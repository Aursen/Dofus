package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightResumeSlaveInfo;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
    import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
    import com.ankamagames.dofus.network.types.game.idol.Idol;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightEffectTriggerCount;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class GameFightResumeWithSlavesMessage extends GameFightResumeMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6215;

        private var _isInitialized:Boolean = false;
        public var slavesInfo:Vector.<GameFightResumeSlaveInfo> = new Vector.<GameFightResumeSlaveInfo>();
        private var _slavesInfotree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return ((super.isInitialized) && (this._isInitialized));
        }

        override public function getMessageId():uint
        {
            return (6215);
        }

        public function initGameFightResumeWithSlavesMessage(effects:Vector.<FightDispellableEffectExtendedInformations>=null, marks:Vector.<GameActionMark>=null, gameTurn:uint=0, fightStart:uint=0, idols:Vector.<Idol>=null, fxTriggerCounts:Vector.<GameFightEffectTriggerCount>=null, spellCooldowns:Vector.<GameFightSpellCooldown>=null, summonCount:uint=0, bombCount:uint=0, slavesInfo:Vector.<GameFightResumeSlaveInfo>=null):GameFightResumeWithSlavesMessage
        {
            super.initGameFightResumeMessage(effects, marks, gameTurn, fightStart, idols, fxTriggerCounts, spellCooldowns, summonCount, bombCount);
            this.slavesInfo = slavesInfo;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.slavesInfo = new Vector.<GameFightResumeSlaveInfo>();
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
            this.serializeAs_GameFightResumeWithSlavesMessage(output);
        }

        public function serializeAs_GameFightResumeWithSlavesMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_GameFightResumeMessage(output);
            output.writeShort(this.slavesInfo.length);
            var _i1:uint;
            while (_i1 < this.slavesInfo.length)
            {
                (this.slavesInfo[_i1] as GameFightResumeSlaveInfo).serializeAs_GameFightResumeSlaveInfo(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightResumeWithSlavesMessage(input);
        }

        public function deserializeAs_GameFightResumeWithSlavesMessage(input:ICustomDataInput):void
        {
            var _item1:GameFightResumeSlaveInfo;
            super.deserialize(input);
            var _slavesInfoLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _slavesInfoLen)
            {
                _item1 = new GameFightResumeSlaveInfo();
                _item1.deserialize(input);
                this.slavesInfo.push(_item1);
                _i1++;
            };
        }

        override public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameFightResumeWithSlavesMessage(tree);
        }

        public function deserializeAsyncAs_GameFightResumeWithSlavesMessage(tree:FuncTree):void
        {
            super.deserializeAsync(tree);
            this._slavesInfotree = tree.addChild(this._slavesInfotreeFunc);
        }

        private function _slavesInfotreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._slavesInfotree.addChild(this._slavesInfoFunc);
                i++;
            };
        }

        private function _slavesInfoFunc(input:ICustomDataInput):void
        {
            var _item:GameFightResumeSlaveInfo = new GameFightResumeSlaveInfo();
            _item.deserialize(input);
            this.slavesInfo.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.fight

