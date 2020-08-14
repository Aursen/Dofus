package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.guild.HavenBagFurnitureInformation;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class HavenBagFurnituresMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6634;

        private var _isInitialized:Boolean = false;
        public var furnituresInfos:Vector.<HavenBagFurnitureInformation> = new Vector.<HavenBagFurnitureInformation>();
        private var _furnituresInfostree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6634);
        }

        public function initHavenBagFurnituresMessage(furnituresInfos:Vector.<HavenBagFurnitureInformation>=null):HavenBagFurnituresMessage
        {
            this.furnituresInfos = furnituresInfos;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.furnituresInfos = new Vector.<HavenBagFurnitureInformation>();
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
            this.serializeAs_HavenBagFurnituresMessage(output);
        }

        public function serializeAs_HavenBagFurnituresMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.furnituresInfos.length);
            var _i1:uint;
            while (_i1 < this.furnituresInfos.length)
            {
                (this.furnituresInfos[_i1] as HavenBagFurnitureInformation).serializeAs_HavenBagFurnitureInformation(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HavenBagFurnituresMessage(input);
        }

        public function deserializeAs_HavenBagFurnituresMessage(input:ICustomDataInput):void
        {
            var _item1:HavenBagFurnitureInformation;
            var _furnituresInfosLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _furnituresInfosLen)
            {
                _item1 = new HavenBagFurnitureInformation();
                _item1.deserialize(input);
                this.furnituresInfos.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_HavenBagFurnituresMessage(tree);
        }

        public function deserializeAsyncAs_HavenBagFurnituresMessage(tree:FuncTree):void
        {
            this._furnituresInfostree = tree.addChild(this._furnituresInfostreeFunc);
        }

        private function _furnituresInfostreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._furnituresInfostree.addChild(this._furnituresInfosFunc);
                i++;
            };
        }

        private function _furnituresInfosFunc(input:ICustomDataInput):void
        {
            var _item:HavenBagFurnitureInformation = new HavenBagFurnitureInformation();
            _item.deserialize(input);
            this.furnituresInfos.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag

