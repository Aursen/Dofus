package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.version.Version;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.jerakine.network.utils.FuncTree;

    public class IdentificationAccountForceMessage extends IdentificationMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6119;

        private var _isInitialized:Boolean = false;
        public var forcedAccountLogin:String = "";


        override public function get isInitialized():Boolean
        {
            return ((super.isInitialized) && (this._isInitialized));
        }

        override public function getMessageId():uint
        {
            return (6119);
        }

        public function initIdentificationAccountForceMessage(version:Version=null, lang:String="", credentials:Vector.<int>=null, serverId:int=0, autoconnect:Boolean=false, useCertificate:Boolean=false, useLoginToken:Boolean=false, sessionOptionalSalt:Number=0, failedAttempts:Vector.<uint>=null, forcedAccountLogin:String=""):IdentificationAccountForceMessage
        {
            super.initIdentificationMessage(version, lang, credentials, serverId, autoconnect, useCertificate, useLoginToken, sessionOptionalSalt, failedAttempts);
            this.forcedAccountLogin = forcedAccountLogin;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.forcedAccountLogin = "";
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function unpackAsync(input:ICustomDataInput, length:uint):FuncTree
        {
            var tree:FuncTree = new FuncTree();
            tree.setRoot(input);
            this.deserializeAsync(tree);
            return (tree);
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_IdentificationAccountForceMessage(output);
        }

        public function serializeAs_IdentificationAccountForceMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_IdentificationMessage(output);
            output.writeUTF(this.forcedAccountLogin);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IdentificationAccountForceMessage(input);
        }

        public function deserializeAs_IdentificationAccountForceMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this._forcedAccountLoginFunc(input);
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_IdentificationAccountForceMessage(tree);
        }

        public function deserializeAsyncAs_IdentificationAccountForceMessage(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            tree.addChild(this._forcedAccountLoginFunc);
        }

        private function _forcedAccountLoginFunc(input:ICustomDataInput):void
        {
            this.forcedAccountLogin = input.readUTF();
        }


    }
} com.ankamagames.dofus.network.messages.connection

