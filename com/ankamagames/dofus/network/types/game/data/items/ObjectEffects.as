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

    public class ObjectEffects implements INetworkType 
    {

        public static const protocolId:uint = 358;

        public var effects:Vector.<ObjectEffect> = new Vector.<ObjectEffect>();
        private var _effectstree:FuncTree;


        public function getTypeId():uint
        {
            return (358);
        }

        public function initObjectEffects(effects:Vector.<ObjectEffect>=null):ObjectEffects
        {
            this.effects = effects;
            return (this);
        }

        public function reset():void
        {
            this.effects = new Vector.<ObjectEffect>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ObjectEffects(output);
        }

        public function serializeAs_ObjectEffects(output:ICustomDataOutput):void
        {
            output.writeShort(this.effects.length);
            var _i1:uint;
            while (_i1 < this.effects.length)
            {
                output.writeShort((this.effects[_i1] as ObjectEffect).getTypeId());
                (this.effects[_i1] as ObjectEffect).serialize(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectEffects(input);
        }

        public function deserializeAs_ObjectEffects(input:ICustomDataInput):void
        {
            var _id1:uint;
            var _item1:ObjectEffect;
            var _effectsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _effectsLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(ObjectEffect, _id1);
                _item1.deserialize(input);
                this.effects.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ObjectEffects(tree);
        }

        public function deserializeAsyncAs_ObjectEffects(tree:FuncTree):void
        {
            this._effectstree = tree.addChild(this._effectstreeFunc);
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

