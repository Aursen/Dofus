package com.ankamagames.dofus.network.messages.common.basic
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.common.basic.StatisticData;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class BasicStatWithDataMessage extends BasicStatMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6573;

        private var _isInitialized:Boolean = false;
        public var datas:Vector.<StatisticData> = new Vector.<StatisticData>();
        private var _datastree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return ((super.isInitialized) && (this._isInitialized));
        }

        override public function getMessageId():uint
        {
            return (6573);
        }

        public function initBasicStatWithDataMessage(timeSpent:Number=0, statId:uint=0, datas:Vector.<StatisticData>=null):BasicStatWithDataMessage
        {
            super.initBasicStatMessage(timeSpent, statId);
            this.datas = datas;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.datas = new Vector.<StatisticData>();
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
            this.serializeAs_BasicStatWithDataMessage(output);
        }

        public function serializeAs_BasicStatWithDataMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_BasicStatMessage(output);
            output.writeShort(this.datas.length);
            var _i1:uint;
            while (_i1 < this.datas.length)
            {
                output.writeShort((this.datas[_i1] as StatisticData).getTypeId());
                (this.datas[_i1] as StatisticData).serialize(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BasicStatWithDataMessage(input);
        }

        public function deserializeAs_BasicStatWithDataMessage(input:ICustomDataInput):void
        {
            var _id1:uint;
            var _item1:StatisticData;
            super.deserialize(input);
            var _datasLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _datasLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(StatisticData, _id1);
                _item1.deserialize(input);
                this.datas.push(_item1);
                _i1++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_BasicStatWithDataMessage(tree);
        }

        public function deserializeAsyncAs_BasicStatWithDataMessage(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._datastree = tree.addChild(this._datastreeFunc);
        }

        private function _datastreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._datastree.addChild(this._datasFunc);
                i++;
            };
        }

        private function _datasFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:StatisticData = ProtocolTypeManager.getInstance(StatisticData, _id);
            _item.deserialize(input);
            this.datas.push(_item);
        }


    }
}

