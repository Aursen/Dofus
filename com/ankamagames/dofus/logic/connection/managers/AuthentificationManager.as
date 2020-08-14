package com.ankamagames.dofus.logic.connection.managers
{
    import com.ankamagames.jerakine.interfaces.IDestroyable;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
    import com.ankamagames.dofus.network.types.secure.TrustCertificate;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.hurlant.crypto.Crypto;
    import com.hurlant.crypto.symmetric.NullPad;
    import com.hurlant.crypto.symmetric.ICipher;
    import com.hurlant.crypto.rsa.RSAKey;
    import com.hurlant.util.der.PEM;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.jerakine.utils.crypto.Base64;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.shield.SecureModeManager;
    import com.ankamagames.dofus.logic.game.common.frames.ProtectPishingFrame;
    import by.blooddy.crypto.MD5;
    import com.ankamagames.dofus.network.messages.connection.IdentificationMessage;
    import com.ankamagames.dofus.network.messages.connection.IdentificationAccountForceMessage;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTicketAction;
    import com.ankamagames.jerakine.data.XmlConfig;
    import flash.filesystem.File;
    import com.ankamagames.jerakine.utils.crypto.RSA;
    import __AS3__.vec.*;

    public class AuthentificationManager implements IDestroyable 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthentificationManager));
        private static var _self:AuthentificationManager;
        private static const AES_KEY_LENGTH:uint = 32;
        private static const PUBLIC_KEY_V2:Class = AuthentificationManager_PUBLIC_KEY_V2;

        private var _publicKey:String;
        private var _salt:String;
        private var _lva:LoginValidationAction;
        private var _certificate:TrustCertificate;
        private var _AESKey:ByteArray;
        private var _verifyKey:Class = AuthentificationManager__verifyKey;
        private var _gameServerTicket:String;
        public var username:String;
        public var nextToken:String;
        public var tokenMode:Boolean = false;

        public function AuthentificationManager()
        {
            if (_self != null)
            {
                throw (new SingletonError("AuthentificationManager is a singleton and should not be instanciated directly."));
            };
        }

        public static function getInstance():AuthentificationManager
        {
            if (_self == null)
            {
                _self = new (AuthentificationManager)();
            };
            return (_self);
        }


        public function get gameServerTicket():String
        {
            return (this._gameServerTicket);
        }

        public function set gameServerTicket(value:String):void
        {
            this._gameServerTicket = value;
        }

        public function get salt():String
        {
            return (this._salt);
        }

        public function initAESKey():void
        {
            this._AESKey = this.generateRandomAESKey();
        }

        public function decodeWithAES(byteArrayOrVector:*):ByteArray
        {
            var i:int;
            var aesCipher:ICipher = Crypto.getCipher("simple-aes256-cbc", this._AESKey, new NullPad());
            this._AESKey.position = 0;
            var result:ByteArray = new ByteArray();
            result.writeBytes(this._AESKey, 0, 16);
            if (((byteArrayOrVector is Vector.<int>) || (byteArrayOrVector is Vector.<uint>)))
            {
                i = 0;
                while (i < byteArrayOrVector.length)
                {
                    result.writeByte(byteArrayOrVector[i]);
                    i++;
                };
            }
            else
            {
                if ((byteArrayOrVector is ByteArray))
                {
                    result.writeBytes((byteArrayOrVector as ByteArray));
                }
                else
                {
                    throw (new ArgumentError("Argument must be a bytearray or a vector of int/uint"));
                };
            };
            aesCipher.decrypt(result);
            return (result);
        }

        public function setSalt(salt:String):void
        {
            this._salt = salt;
            if (this._salt.length < 32)
            {
                _log.warn("Authentification salt size is lower than 32 ");
                while (this._salt.length < 32)
                {
                    this._salt = (this._salt + " ");
                };
            };
        }

        public function setPublicKey(publicKey:Vector.<int>):void
        {
            var commonMod:Object;
            var baSignedKey:ByteArray = new ByteArray();
            var i:int;
            while (i < publicKey.length)
            {
                baSignedKey.writeByte(publicKey[i]);
                i = (i + 1);
            };
            baSignedKey.position = 0;
            var key:ByteArray = new ByteArray();
            var readKey:RSAKey = PEM.readRSAPublicKey((new this._verifyKey() as ByteArray).readUTFBytes((new this._verifyKey() as ByteArray).length));
            try
            {
                readKey.verify(baSignedKey, key, baSignedKey.length);
            }
            catch(e:Error)
            {
                commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                commonMod.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.server.authentificationImpossible"), [I18n.getUiText("ui.common.ok")]);
                return;
            };
            this._publicKey = (("-----BEGIN PUBLIC KEY-----\n" + Base64.encodeByteArray(key)) + "-----END PUBLIC KEY-----");
        }

        public function setValidationAction(lva:LoginValidationAction):void
        {
            this.username = lva["username"];
            this._lva = lva;
            this._certificate = SecureModeManager.getInstance().retreiveCertificate();
            ProtectPishingFrame.setPasswordHash(MD5.hash(lva.password.toUpperCase()), lva.password.length);
        }

        public function get loginValidationAction():LoginValidationAction
        {
            return (this._lva);
        }

        public function get canAutoConnectWithToken():Boolean
        {
            return (!(this.nextToken == null));
        }

        public function getIdentificationMessage():IdentificationMessage
        {
            var imsg:IdentificationMessage;
            var token:String;
            var login:Array;
            var iafmsg:IdentificationAccountForceMessage;
            var buildType:uint = BuildInfos.BUILD_TYPE;
            if (this._lva.username.indexOf("|") == -1)
            {
                imsg = new IdentificationMessage();
                if (((this._lva is LoginValidationWithTicketAction) || (this.nextToken)))
                {
                    token = ((this.nextToken) ? this.nextToken : LoginValidationWithTicketAction(this._lva).ticket);
                    this.nextToken = null;
                    imsg.initIdentificationMessage(imsg.version, XmlConfig.getInstance().getEntry("config.lang.current"), this.cipherRsa("   ", token, this._certificate), this._lva.serverId, this._lva.autoSelectServer, (!(this._certificate == null)), true);
                }
                else
                {
                    imsg.initIdentificationMessage(imsg.version, XmlConfig.getInstance().getEntry("config.lang.current"), this.cipherRsa(this._lva.username, this._lva.password, this._certificate), this._lva.serverId, this._lva.autoSelectServer, (!(this._certificate == null)), false);
                };
                imsg.version.initVersion(BuildInfos.VERSION.major, BuildInfos.VERSION.minor, BuildInfos.VERSION.code, BuildInfos.VERSION.build, buildType);
                return (imsg);
            };
            login = this._lva.username.split("|");
            iafmsg = new IdentificationAccountForceMessage();
            iafmsg.initIdentificationAccountForceMessage(iafmsg.version, XmlConfig.getInstance().getEntry("config.lang.current"), this.cipherRsa(login[0], this._lva.password, this._certificate), this._lva.serverId, this._lva.autoSelectServer, (!(this._certificate == null)), false, 0, null, login[1]);
            iafmsg.version.initVersion(BuildInfos.VERSION.major, BuildInfos.VERSION.minor, BuildInfos.VERSION.code, BuildInfos.VERSION.build, buildType);
            return (iafmsg);
        }

        public function destroy():void
        {
            _self = null;
        }

        private function cipherMd5String(pwd:String):String
        {
            return (MD5.hash((pwd + this._salt)));
        }

        private function cipherRsa(login:String, pwd:String, certificate:TrustCertificate):Vector.<int>
        {
            var baOut:ByteArray;
            var debugOutput:ByteArray;
            var n:int;
            var baIn:ByteArray = new ByteArray();
            baIn.writeUTFBytes(this._salt);
            baIn.writeBytes(this._AESKey);
            if (certificate)
            {
                baIn.writeUnsignedInt(certificate.id);
                baIn.writeUTFBytes(certificate.hash);
            };
            baIn.writeByte(login.length);
            baIn.writeUTFBytes(login);
            baIn.writeUTFBytes(pwd);
            try
            {
                if (((File.applicationDirectory.resolvePath("debug-login.txt")) || (File.applicationDirectory.resolvePath("debuglogin.txt"))))
                {
                    _log.debug("login with certificate");
                    debugOutput = new ByteArray();
                    baIn.position = 0;
                    debugOutput.position = 0;
                    debugOutput = RSA.publicEncrypt((new PUBLIC_KEY_V2() as ByteArray).readUTFBytes((new PUBLIC_KEY_V2() as ByteArray).length), baIn);
                };
            }
            catch(e:Error)
            {
                _log.error(("Erreur lors du log des informations de login " + e.getStackTrace()));
            };
            baOut = RSA.publicEncrypt(this._publicKey, baIn);
            var ret:Vector.<int> = new Vector.<int>();
            baOut.position = 0;
            var i:int;
            while (baOut.bytesAvailable != 0)
            {
                n = baOut.readByte();
                ret[i] = n;
                i = (i + 1);
            };
            return (ret);
        }

        private function generateRandomAESKey():ByteArray
        {
            var ba:ByteArray = new ByteArray();
            var i:int;
            while (i < AES_KEY_LENGTH)
            {
                ba[i] = Math.floor((Math.random() * 0x0100));
                i++;
            };
            return (ba);
        }


    }
} com.ankamagames.dofus.logic.connection.managers

