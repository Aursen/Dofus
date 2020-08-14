package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.prism.PrismSubareaEmptyInfo;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class PrismsListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6440;

        private var _isInitialized:Boolean = false;
        public var prisms:Vector.<PrismSubareaEmptyInfo> = new Vector.<PrismSubareaEmptyInfo>();
        private var _prismstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6440);
        }

        public function initPrismsListMessage(prisms:Vector.<PrismSubareaEmptyInfo>=null):PrismsListMessage
        {
            this.prisms = prisms;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.prisms = new Vector.<PrismSubareaEmptyInfo>();
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
            this.serializeAs_PrismsListMessage(output);
        }

        public function serializeAs_PrismsListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.prisms.length);
            var _i1:uint;
            while (_i1 < this.prisms.length)
            {
                output.writeShort((this.prisms[_i1] as PrismSubareaEmptyInfo).getTypeId());
                (this.prisms[_i1] as PrismSubareaEmptyInfo).serialize(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PrismsListMessage(input);
        }

        public function deserializeAs_PrismsListMessage(input:ICustomDataInput):void
        {
            var _id1:uint;
            var _item1:PrismSubareaEmptyInfo;
            var _prismsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _prismsLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(PrismSubareaEmptyInfo, _id1);
                _item1.deserialize(input);
                this.prisms.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_PrismsListMessage(tree);
        }

        public function deserializeAsyncAs_PrismsListMessage(tree:FuncTree):void
        {
            this._prismstree = tree.addChild(this._prismstreeFunc);
        }

        private function _prismstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._prismstree.addChild(this._prismsFunc);
                i++;
            };
        }

        private function _prismsFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:PrismSubareaEmptyInfo = ProtocolTypeManager.getInstance(PrismSubareaEmptyInfo, _id);
            _item.deserialize(input);
            this.prisms.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.prism

