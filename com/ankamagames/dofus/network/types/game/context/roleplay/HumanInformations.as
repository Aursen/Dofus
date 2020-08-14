package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.character.restriction.ActorRestrictionsInformations;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class HumanInformations implements INetworkType 
    {

        public static const protocolId:uint = 157;

        public var restrictions:ActorRestrictionsInformations = new ActorRestrictionsInformations();
        public var sex:Boolean = false;
        public var options:Vector.<HumanOption> = new Vector.<HumanOption>();
        private var _restrictionstree:FuncTree;
        private var _optionstree:FuncTree;


        public function getTypeId():uint
        {
            return (157);
        }

        public function initHumanInformations(restrictions:ActorRestrictionsInformations=null, sex:Boolean=false, options:Vector.<HumanOption>=null):HumanInformations
        {
            this.restrictions = restrictions;
            this.sex = sex;
            this.options = options;
            return (this);
        }

        public function reset():void
        {
            this.restrictions = new ActorRestrictionsInformations();
            this.options = new Vector.<HumanOption>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_HumanInformations(output);
        }

        public function serializeAs_HumanInformations(output:ICustomDataOutput):void
        {
            this.restrictions.serializeAs_ActorRestrictionsInformations(output);
            output.writeBoolean(this.sex);
            output.writeShort(this.options.length);
            var _i3:uint;
            while (_i3 < this.options.length)
            {
                output.writeShort((this.options[_i3] as HumanOption).getTypeId());
                (this.options[_i3] as HumanOption).serialize(output);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HumanInformations(input);
        }

        public function deserializeAs_HumanInformations(input:ICustomDataInput):void
        {
            var _id3:uint;
            var _item3:HumanOption;
            this.restrictions = new ActorRestrictionsInformations();
            this.restrictions.deserialize(input);
            this._sexFunc(input);
            var _optionsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _optionsLen)
            {
                _id3 = input.readUnsignedShort();
                _item3 = ProtocolTypeManager.getInstance(HumanOption, _id3);
                _item3.deserialize(input);
                this.options.push(_item3);
                _i3++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_HumanInformations(tree);
        }

        public function deserializeAsyncAs_HumanInformations(tree:FuncTree):void
        {
            this._restrictionstree = tree.addChild(this._restrictionstreeFunc);
            tree.addChild(this._sexFunc);
            this._optionstree = tree.addChild(this._optionstreeFunc);
        }

        private function _restrictionstreeFunc(input:ICustomDataInput):void
        {
            this.restrictions = new ActorRestrictionsInformations();
            this.restrictions.deserializeAsync(this._restrictionstree);
        }

        private function _sexFunc(input:ICustomDataInput):void
        {
            this.sex = input.readBoolean();
        }

        private function _optionstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._optionstree.addChild(this._optionsFunc);
                i++;
            };
        }

        private function _optionsFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:HumanOption = ProtocolTypeManager.getInstance(HumanOption, _id);
            _item.deserialize(input);
            this.options.push(_item);
        }


    }
} com.ankamagames.dofus.network.types.game.context.roleplay

