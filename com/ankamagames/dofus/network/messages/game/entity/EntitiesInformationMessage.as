package com.ankamagames.dofus.network.messages.game.entity
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.entity.EntityInformation;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class EntitiesInformationMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6775;

        private var _isInitialized:Boolean = false;
        public var entities:Vector.<EntityInformation> = new Vector.<EntityInformation>();
        private var _entitiestree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6775);
        }

        public function initEntitiesInformationMessage(entities:Vector.<EntityInformation>=null):EntitiesInformationMessage
        {
            this.entities = entities;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.entities = new Vector.<EntityInformation>();
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
            this.serializeAs_EntitiesInformationMessage(output);
        }

        public function serializeAs_EntitiesInformationMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.entities.length);
            var _i1:uint;
            while (_i1 < this.entities.length)
            {
                (this.entities[_i1] as EntityInformation).serializeAs_EntityInformation(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_EntitiesInformationMessage(input);
        }

        public function deserializeAs_EntitiesInformationMessage(input:ICustomDataInput):void
        {
            var _item1:EntityInformation;
            var _entitiesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _entitiesLen)
            {
                _item1 = new EntityInformation();
                _item1.deserialize(input);
                this.entities.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_EntitiesInformationMessage(tree);
        }

        public function deserializeAsyncAs_EntitiesInformationMessage(tree:FuncTree):void
        {
            this._entitiestree = tree.addChild(this._entitiestreeFunc);
        }

        private function _entitiestreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._entitiestree.addChild(this._entitiesFunc);
                i++;
            };
        }

        private function _entitiesFunc(input:ICustomDataInput):void
        {
            var _item:EntityInformation = new EntityInformation();
            _item.deserialize(input);
            this.entities.push(_item);
        }


    }
}

