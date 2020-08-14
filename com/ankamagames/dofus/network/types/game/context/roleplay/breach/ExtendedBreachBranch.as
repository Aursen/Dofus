package com.ankamagames.dofus.network.types.game.context.roleplay.breach
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class ExtendedBreachBranch extends BreachBranch implements INetworkType 
    {

        public static const protocolId:uint = 560;

        public var rewards:Vector.<BreachReward> = new Vector.<BreachReward>();
        public var modifier:int = 0;
        public var prize:uint = 0;
        private var _rewardstree:FuncTree;


        override public function getTypeId():uint
        {
            return (560);
        }

        public function initExtendedBreachBranch(room:uint=0, element:uint=0, bosses:Vector.<MonsterInGroupLightInformations>=null, map:Number=0, score:int=0, relativeScore:int=0, monsters:Vector.<MonsterInGroupLightInformations>=null, rewards:Vector.<BreachReward>=null, modifier:int=0, prize:uint=0):ExtendedBreachBranch
        {
            super.initBreachBranch(room, element, bosses, map, score, relativeScore, monsters);
            this.rewards = rewards;
            this.modifier = modifier;
            this.prize = prize;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.rewards = new Vector.<BreachReward>();
            this.modifier = 0;
            this.prize = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ExtendedBreachBranch(output);
        }

        public function serializeAs_ExtendedBreachBranch(output:ICustomDataOutput):void
        {
            super.serializeAs_BreachBranch(output);
            output.writeShort(this.rewards.length);
            var _i1:uint;
            while (_i1 < this.rewards.length)
            {
                (this.rewards[_i1] as BreachReward).serializeAs_BreachReward(output);
                _i1++;
            };
            output.writeVarInt(this.modifier);
            if (this.prize < 0)
            {
                throw (new Error((("Forbidden value (" + this.prize) + ") on element prize.")));
            };
            output.writeVarInt(this.prize);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExtendedBreachBranch(input);
        }

        public function deserializeAs_ExtendedBreachBranch(input:ICustomDataInput):void
        {
            var _item1:BreachReward;
            super.deserialize(input);
            var _rewardsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _rewardsLen)
            {
                _item1 = new BreachReward();
                _item1.deserialize(input);
                this.rewards.push(_item1);
                _i1++;
            };
            this._modifierFunc(input);
            this._prizeFunc(input);
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_ExtendedBreachBranch(tree);
        }

        public function deserializeAsyncAs_ExtendedBreachBranch(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._rewardstree = tree.addChild(this._rewardstreeFunc);
            tree.addChild(this._modifierFunc);
            tree.addChild(this._prizeFunc);
        }

        private function _rewardstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._rewardstree.addChild(this._rewardsFunc);
                i++;
            };
        }

        private function _rewardsFunc(input:ICustomDataInput):void
        {
            var _item:BreachReward = new BreachReward();
            _item.deserialize(input);
            this.rewards.push(_item);
        }

        private function _modifierFunc(input:ICustomDataInput):void
        {
            this.modifier = input.readVarInt();
        }

        private function _prizeFunc(input:ICustomDataInput):void
        {
            this.prize = input.readVarUhInt();
            if (this.prize < 0)
            {
                throw (new Error((("Forbidden value (" + this.prize) + ") on element of ExtendedBreachBranch.prize.")));
            };
        }


    }
} com.ankamagames.dofus.network.types.game.context.roleplay.breach

