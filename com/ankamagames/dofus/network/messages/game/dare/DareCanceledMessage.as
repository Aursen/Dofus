package com.ankamagames.dofus.network.messages.game.dare
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.jerakine.network.utils.FuncTree;

    public class DareCanceledMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6679;

        private var _isInitialized:Boolean = false;
        public var dareId:Number = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6679);
        }

        public function initDareCanceledMessage(dareId:Number=0):DareCanceledMessage
        {
            this.dareId = dareId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.dareId = 0;
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

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_DareCanceledMessage(output);
        }

        public function serializeAs_DareCanceledMessage(output:ICustomDataOutput):void
        {
            if (((this.dareId < 0) || (this.dareId > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.dareId) + ") on element dareId.")));
            };
            output.writeDouble(this.dareId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_DareCanceledMessage(input);
        }

        public function deserializeAs_DareCanceledMessage(input:ICustomDataInput):void
        {
            this._dareIdFunc(input);
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_DareCanceledMessage(tree);
        }

        public function deserializeAsyncAs_DareCanceledMessage(tree:FuncTree):void
        {
            tree.addChild(this._dareIdFunc);
        }

        private function _dareIdFunc(input:ICustomDataInput):void
        {
            this.dareId = input.readDouble();
            if (((this.dareId < 0) || (this.dareId > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.dareId) + ") on element of DareCanceledMessage.dareId.")));
            };
        }


    }
}

