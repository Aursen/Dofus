package com.ankamagames.dofus.network.messages.game.context.roleplay.breach
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class BreachStateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6799;

        private var _isInitialized:Boolean = false;
        public var owner:CharacterMinimalInformations = new CharacterMinimalInformations();
        public var bonuses:Vector.<ObjectEffectInteger> = new Vector.<ObjectEffectInteger>();
        public var bugdet:uint = 0;
        public var saved:Boolean = false;
        private var _ownertree:FuncTree;
        private var _bonusestree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6799);
        }

        public function initBreachStateMessage(owner:CharacterMinimalInformations=null, bonuses:Vector.<ObjectEffectInteger>=null, bugdet:uint=0, saved:Boolean=false):BreachStateMessage
        {
            this.owner = owner;
            this.bonuses = bonuses;
            this.bugdet = bugdet;
            this.saved = saved;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.owner = new CharacterMinimalInformations();
            this.bugdet = 0;
            this.saved = false;
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
            this.serializeAs_BreachStateMessage(output);
        }

        public function serializeAs_BreachStateMessage(output:ICustomDataOutput):void
        {
            this.owner.serializeAs_CharacterMinimalInformations(output);
            output.writeShort(this.bonuses.length);
            var _i2:uint;
            while (_i2 < this.bonuses.length)
            {
                (this.bonuses[_i2] as ObjectEffectInteger).serializeAs_ObjectEffectInteger(output);
                _i2++;
            };
            if (this.bugdet < 0)
            {
                throw (new Error((("Forbidden value (" + this.bugdet) + ") on element bugdet.")));
            };
            output.writeVarInt(this.bugdet);
            output.writeBoolean(this.saved);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BreachStateMessage(input);
        }

        public function deserializeAs_BreachStateMessage(input:ICustomDataInput):void
        {
            var _item2:ObjectEffectInteger;
            this.owner = new CharacterMinimalInformations();
            this.owner.deserialize(input);
            var _bonusesLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _bonusesLen)
            {
                _item2 = new ObjectEffectInteger();
                _item2.deserialize(input);
                this.bonuses.push(_item2);
                _i2++;
            };
            this._bugdetFunc(input);
            this._savedFunc(input);
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_BreachStateMessage(tree);
        }

        public function deserializeAsyncAs_BreachStateMessage(tree:FuncTree):void
        {
            this._ownertree = tree.addChild(this._ownertreeFunc);
            this._bonusestree = tree.addChild(this._bonusestreeFunc);
            tree.addChild(this._bugdetFunc);
            tree.addChild(this._savedFunc);
        }

        private function _ownertreeFunc(input:ICustomDataInput):void
        {
            this.owner = new CharacterMinimalInformations();
            this.owner.deserializeAsync(this._ownertree);
        }

        private function _bonusestreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._bonusestree.addChild(this._bonusesFunc);
                i++;
            };
        }

        private function _bonusesFunc(input:ICustomDataInput):void
        {
            var _item:ObjectEffectInteger = new ObjectEffectInteger();
            _item.deserialize(input);
            this.bonuses.push(_item);
        }

        private function _bugdetFunc(input:ICustomDataInput):void
        {
            this.bugdet = input.readVarUhInt();
            if (this.bugdet < 0)
            {
                throw (new Error((("Forbidden value (" + this.bugdet) + ") on element of BreachStateMessage.bugdet.")));
            };
        }

        private function _savedFunc(input:ICustomDataInput):void
        {
            this.saved = input.readBoolean();
        }


    }
}

