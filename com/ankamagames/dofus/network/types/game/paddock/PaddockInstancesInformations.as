package com.ankamagames.dofus.network.types.game.paddock
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class PaddockInstancesInformations extends PaddockInformations implements INetworkType 
    {

        public static const protocolId:uint = 509;

        public var paddocks:Vector.<PaddockBuyableInformations> = new Vector.<PaddockBuyableInformations>();
        private var _paddockstree:FuncTree;


        override public function getTypeId():uint
        {
            return (509);
        }

        public function initPaddockInstancesInformations(maxOutdoorMount:uint=0, maxItems:uint=0, paddocks:Vector.<PaddockBuyableInformations>=null):PaddockInstancesInformations
        {
            super.initPaddockInformations(maxOutdoorMount, maxItems);
            this.paddocks = paddocks;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.paddocks = new Vector.<PaddockBuyableInformations>();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PaddockInstancesInformations(output);
        }

        public function serializeAs_PaddockInstancesInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_PaddockInformations(output);
            output.writeShort(this.paddocks.length);
            var _i1:uint;
            while (_i1 < this.paddocks.length)
            {
                output.writeShort((this.paddocks[_i1] as PaddockBuyableInformations).getTypeId());
                (this.paddocks[_i1] as PaddockBuyableInformations).serialize(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PaddockInstancesInformations(input);
        }

        public function deserializeAs_PaddockInstancesInformations(input:ICustomDataInput):void
        {
            var _id1:uint;
            var _item1:PaddockBuyableInformations;
            super.deserialize(input);
            var _paddocksLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _paddocksLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(PaddockBuyableInformations, _id1);
                _item1.deserialize(input);
                this.paddocks.push(_item1);
                _i1++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_PaddockInstancesInformations(tree);
        }

        public function deserializeAsyncAs_PaddockInstancesInformations(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._paddockstree = tree.addChild(this._paddockstreeFunc);
        }

        private function _paddockstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._paddockstree.addChild(this._paddocksFunc);
                i++;
            };
        }

        private function _paddocksFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:PaddockBuyableInformations = ProtocolTypeManager.getInstance(PaddockBuyableInformations, _id);
            _item.deserialize(input);
            this.paddocks.push(_item);
        }


    }
} com.ankamagames.dofus.network.types.game.paddock

