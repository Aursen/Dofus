package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.AnomalySubareaInformation;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class AnomalySubareaInformationResponseMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6836;

        private var _isInitialized:Boolean = false;
        public var subareas:Vector.<AnomalySubareaInformation> = new Vector.<AnomalySubareaInformation>();
        private var _subareastree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6836);
        }

        public function initAnomalySubareaInformationResponseMessage(subareas:Vector.<AnomalySubareaInformation>=null):AnomalySubareaInformationResponseMessage
        {
            this.subareas = subareas;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.subareas = new Vector.<AnomalySubareaInformation>();
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
            this.serializeAs_AnomalySubareaInformationResponseMessage(output);
        }

        public function serializeAs_AnomalySubareaInformationResponseMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.subareas.length);
            var _i1:uint;
            while (_i1 < this.subareas.length)
            {
                (this.subareas[_i1] as AnomalySubareaInformation).serializeAs_AnomalySubareaInformation(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AnomalySubareaInformationResponseMessage(input);
        }

        public function deserializeAs_AnomalySubareaInformationResponseMessage(input:ICustomDataInput):void
        {
            var _item1:AnomalySubareaInformation;
            var _subareasLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _subareasLen)
            {
                _item1 = new AnomalySubareaInformation();
                _item1.deserialize(input);
                this.subareas.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_AnomalySubareaInformationResponseMessage(tree);
        }

        public function deserializeAsyncAs_AnomalySubareaInformationResponseMessage(tree:FuncTree):void
        {
            this._subareastree = tree.addChild(this._subareastreeFunc);
        }

        private function _subareastreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._subareastree.addChild(this._subareasFunc);
                i++;
            };
        }

        private function _subareasFunc(input:ICustomDataInput):void
        {
            var _item:AnomalySubareaInformation = new AnomalySubareaInformation();
            _item.deserialize(input);
            this.subareas.push(_item);
        }


    }
}

