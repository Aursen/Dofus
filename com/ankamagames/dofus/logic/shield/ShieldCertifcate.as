package com.ankamagames.dofus.logic.shield
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.IDataInput;
    import flash.utils.ByteArray;
    import com.ankamagames.dofus.network.types.secure.TrustCertificate;
    import by.blooddy.crypto.SHA256;
    import com.hurlant.crypto.symmetric.AESKey;
    import com.hurlant.crypto.symmetric.ECBMode;
    import com.ankamagames.jerakine.utils.crypto.Base64;
    import flash.system.Capabilities;
    import flash.filesystem.File;
    import flash.system.ApplicationDomain;
    import by.blooddy.crypto.MD5;

    public class ShieldCertifcate 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ShieldCertifcate));
        public static const HEADER_BEGIN:String = "SV";
        public static const HEADER_V1:String = (HEADER_BEGIN + "1");
        public static const HEADER_V2:String = (HEADER_BEGIN + "2");
        public static const HEADER_V3:String = (HEADER_BEGIN + "3");
        public static const HEADER_V4:String = (HEADER_BEGIN + "4");

        public var version:uint;
        public var id:uint;
        public var content:String;
        public var useBasicNetworkInfo:Boolean;
        public var useAdvancedNetworkInfo:Boolean;
        public var useBasicInfo:Boolean;
        public var useUserInfo:Boolean;
        public var filterVirtualNetwork:Boolean;

        public function ShieldCertifcate(version:uint=4)
        {
            switch (version)
            {
                case 1:
                    this.useAdvancedNetworkInfo = false;
                    this.useBasicNetworkInfo = false;
                    this.useBasicInfo = false;
                    this.useUserInfo = false;
                    this.filterVirtualNetwork = false;
                    break;
                case 2:
                    this.useAdvancedNetworkInfo = true;
                    this.useBasicNetworkInfo = true;
                    this.useBasicInfo = true;
                    this.useUserInfo = true;
                    this.filterVirtualNetwork = false;
                    break;
                case 3:
                case 4:
                    this.useAdvancedNetworkInfo = false;
                    this.useBasicNetworkInfo = true;
                    this.useBasicInfo = true;
                    this.useUserInfo = true;
                    this.filterVirtualNetwork = true;
                    break;
            };
            this.version = version;
        }

        public static function fromRaw(data:IDataInput, output:ShieldCertifcate=null):ShieldCertifcate
        {
            var infoLen:uint;
            var i:uint;
            var result:ShieldCertifcate = ((output) ? output : new (ShieldCertifcate)());
            data["position"] = 0;
            var header:String = data.readUTFBytes(3);
            if (header.substr(0, 2) != HEADER_BEGIN)
            {
                header = HEADER_V1;
            };
            switch (header)
            {
                case HEADER_V1:
                    result.version = 1;
                    data["position"] = 0;
                    result.id = data.readUnsignedInt();
                    result.content = data.readUTF();
                    result.useAdvancedNetworkInfo = false;
                    result.useBasicNetworkInfo = false;
                    result.useBasicInfo = false;
                    result.useUserInfo = false;
                    result.filterVirtualNetwork = false;
                    break;
                case HEADER_V2:
                    result.version = 2;
                    result.id = data.readUnsignedInt();
                    result.useAdvancedNetworkInfo = true;
                    result.useBasicNetworkInfo = true;
                    result.useBasicInfo = true;
                    result.useUserInfo = true;
                    result.filterVirtualNetwork = false;
                    result.content = result.decrypt(data);
                    break;
                case HEADER_V3:
                case HEADER_V4:
                    result.version = ((header == HEADER_V4) ? 4 : 3);
                    result.id = data.readUnsignedInt();
                    infoLen = data.readShort();
                    i = 0;
                    while (i < infoLen)
                    {
                        result[data.readUTF()] = data.readBoolean();
                        i++;
                    };
                    result.content = result.decrypt(data);
                    break;
            };
            return (result);
        }


        public function set secureLevel(level:uint):void
        {
            switch (level)
            {
                case ShieldSecureLevel.LOW:
                    this.useAdvancedNetworkInfo = false;
                    this.useBasicNetworkInfo = false;
                    this.useBasicInfo = false;
                    this.useUserInfo = false;
                    this.filterVirtualNetwork = false;
                    break;
                case ShieldSecureLevel.MEDIUM:
                    this.useAdvancedNetworkInfo = false;
                    this.useBasicNetworkInfo = false;
                    this.useBasicInfo = true;
                    this.useUserInfo = true;
                    this.filterVirtualNetwork = false;
                    break;
                case ShieldSecureLevel.MAX:
                    this.useAdvancedNetworkInfo = true;
                    this.useBasicNetworkInfo = true;
                    this.useBasicInfo = true;
                    this.useUserInfo = true;
                    this.filterVirtualNetwork = true;
                    break;
            };
        }

        public function get hash():String
        {
            return (this.getHash());
        }

        public function get reverseHash():String
        {
            return (this.getHash(true));
        }

        public function serialize():ByteArray
        {
            var info:Array;
            var i:uint;
            var result:ByteArray = new ByteArray();
            switch (this.version)
            {
                case 1:
                    throw (new Error("No more supported"));
                case 2:
                    result.writeUTFBytes(HEADER_V2);
                    result.writeUnsignedInt(this.id);
                    result.writeUTFBytes(this.content);
                    break;
                case 3:
                case 4:
                    result.writeUTFBytes(((this.version == 4) ? HEADER_V4 : HEADER_V3));
                    result.writeUnsignedInt(this.id);
                    info = ["useBasicInfo", "useBasicNetworkInfo", "useAdvancedNetworkInfo", "useUserInfo"];
                    result.writeShort(info.length);
                    i = 0;
                    while (i < info.length)
                    {
                        result.writeUTF(info[i]);
                        result.writeBoolean(this[info[i]]);
                        i++;
                    };
                    result.writeUTFBytes(this.content);
                    break;
            };
            return (result);
        }

        public function toNetwork():TrustCertificate
        {
            var certif:TrustCertificate = new TrustCertificate();
            var hash:String = SHA256.hash((this.getHash() + this.content));
            certif.initTrustCertificate(this.id, hash);
            return (certif);
        }

        private function decrypt(data:IDataInput):String
        {
            var key:ByteArray = new ByteArray();
            key.writeUTFBytes(this.getHash(true));
            var aesKey:AESKey = new AESKey(key);
            var ecb:ECBMode = new ECBMode(aesKey);
            var cryptedData:ByteArray = Base64.decodeToByteArray(data.readUTFBytes(data.bytesAvailable));
            try
            {
                ecb.decrypt(cryptedData);
            }
            catch(e:Error)
            {
                _log.error("Certificat V2 non valide (clef invalide)");
                return (null);
            };
            cryptedData.position = 0;
            return (cryptedData.readUTFBytes(cryptedData.length));
        }

        private function getHash(reverse:Boolean=false):String
        {
            var virtualNetworkRegExpr:RegExp;
            var networkInterface:Object;
            var interfaces:* = undefined;
            var orderInterfaces:Array;
            var netInterface:* = undefined;
            var i:uint;
            var data:Array = [];
            if (this.useBasicInfo)
            {
                data.push(Capabilities.cpuArchitecture);
                if (((Capabilities.os == "Windows 10") && (this.version < 4)))
                {
                    data.push("Windows 8");
                }
                else
                {
                    if (((!(Capabilities.os.indexOf("Mac OS") == -1)) && (this.version > 3)))
                    {
                        data.push(Capabilities.os.split(/\./)[0]);
                    }
                    else
                    {
                        data.push(Capabilities.os);
                    };
                };
                data.push(Capabilities.maxLevelIDC);
                data.push(Capabilities.language);
            };
            if (this.useUserInfo)
            {
                try
                {
                    data.push(File.documentsDirectory.nativePath.split(File.separator)[2]);
                }
                catch(e:Error)
                {
                    _log.error("User non disponible.");
                };
            };
            if (this.useBasicNetworkInfo)
            {
                virtualNetworkRegExpr = new RegExp("(6to4)|(adapter)|(teredo)|(tunneling)|(loopback)", "ig");
                try
                {
                    if (ApplicationDomain.currentDomain.hasDefinition("flash.net::NetworkInfo"))
                    {
                        networkInterface = ApplicationDomain.currentDomain.getDefinition("flash.net::NetworkInfo");
                        interfaces = networkInterface.networkInfo.findInterfaces();
                        orderInterfaces = [];
                        for each (netInterface in interfaces)
                        {
                            orderInterfaces.push(netInterface);
                        };
                        orderInterfaces.sortOn("hardwareAddress");
                        i = 0;
                        while (i < orderInterfaces.length)
                        {
                            if (((this.filterVirtualNetwork) && (!(String(orderInterfaces[i].displayName).search(virtualNetworkRegExpr) == -1))))
                            {
                            }
                            else
                            {
                                data.push(orderInterfaces[i].hardwareAddress);
                                if (this.useAdvancedNetworkInfo)
                                {
                                    data.push(orderInterfaces[i].name);
                                    data.push(orderInterfaces[i].displayName);
                                };
                            };
                            i++;
                        };
                    };
                }
                catch(e:Error)
                {
                    _log.error("Donnée sur la carte réseau non disponible.");
                };
            };
            if (reverse)
            {
                data.reverse();
            };
            return (MD5.hash(data.toString()));
        }

        private function traceInfo(target:*, maxDepth:uint=5, inc:String=""):void
        {
            _log.info("-----------");
            _log.info(("active : " + target.active));
            _log.info(("hardwareAddress : " + target.hardwareAddress));
            _log.info(("name : " + target.hardwareAddress));
            _log.info(("displayName : " + target.displayName));
            _log.info(("parent : " + target.parent));
            if (((target.parent) && (maxDepth)))
            {
                this.traceInfo(target.parent, maxDepth--, (inc + "..."));
            };
        }


    }
}

