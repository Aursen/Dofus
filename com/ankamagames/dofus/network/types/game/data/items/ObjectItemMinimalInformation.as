package com.ankamagames.dofus.network.types.game.data.items
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class ObjectItemMinimalInformation extends Item implements INetworkType 
    {

        public static const protocolId:uint = 124;

        public var objectGID:uint = 0;
        public var effects:Vector.<ObjectEffect> = new Vector.<ObjectEffect>();
        private var _effectstree:FuncTree;


        override public function getTypeId():uint
        {
            return (124);
        }

        public function initObjectItemMinimalInformation(objectGID:uint=0, effects:Vector.<ObjectEffect>=null):ObjectItemMinimalInformation
        {
            this.objectGID = objectGID;
            this.effects = effects;
            return (this);
        }

        override public function reset():void
        {
            this.objectGID = 0;
            this.effects = new Vector.<ObjectEffect>();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ObjectItemMinimalInformation(output);
        }

        public function serializeAs_ObjectItemMinimalInformation(output:ICustomDataOutput):void
        {
            super.serializeAs_Item(output);
            if (this.objectGID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGID) + ") on element objectGID.")));
            };
            output.writeVarShort(this.objectGID);
            output.writeShort(this.effects.length);
            var _i2:uint;
            while (_i2 < this.effects.length)
            {
                output.writeShort((this.effects[_i2] as ObjectEffect).getTypeId());
                (this.effects[_i2] as ObjectEffect).serialize(output);
                _i2++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectItemMinimalInformation(input);
        }

        public function deserializeAs_ObjectItemMinimalInformation(input:ICustomDataInput):void
        {
            var _id2:uint;
            var _item2:ObjectEffect;
            super.deserialize(input);
            this._objectGIDFunc(input);
            var _effectsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _effectsLen)
            {
                _id2 = input.readUnsignedShort();
                _item2 = ProtocolTypeManager.getInstance(ObjectEffect, _id2);
                _item2.deserialize(input);
                this.effects.push(_item2);
                _i2++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ObjectItemMinimalInformation(tree);
        }

        public function deserializeAsyncAs_ObjectItemMinimalInformation(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            tree.addChild(this._objectGIDFunc);
            this._effectstree = tree.addChild(this._effectstreeFunc);
        }

        private function _objectGIDFunc(input:ICustomDataInput):void
        {
            this.objectGID = input.readVarUhShort();
            if (this.objectGID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGID) + ") on element of ObjectItemMinimalInformation.objectGID.")));
            };
        }

        private function _effectstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._effectstree.addChild(this._effectsFunc);
                i++;
            };
        }

        private function _effectsFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:ObjectEffect = ProtocolTypeManager.getInstance(ObjectEffect, _id);
            _item.deserialize(input);
            this.effects.push(_item);
        }


    }
} com.ankamagames.dofus.network.types.game.data.items

