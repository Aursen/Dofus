package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
    import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
    import com.ankamagames.dofus.network.types.game.idol.Idol;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightEffectTriggerCount;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class GameFightSpectateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6069;

        private var _isInitialized:Boolean = false;
        public var effects:Vector.<FightDispellableEffectExtendedInformations> = new Vector.<FightDispellableEffectExtendedInformations>();
        public var marks:Vector.<GameActionMark> = new Vector.<GameActionMark>();
        public var gameTurn:uint = 0;
        public var fightStart:uint = 0;
        public var idols:Vector.<Idol> = new Vector.<Idol>();
        public var fxTriggerCounts:Vector.<GameFightEffectTriggerCount> = new Vector.<GameFightEffectTriggerCount>();
        private var _effectstree:FuncTree;
        private var _markstree:FuncTree;
        private var _idolstree:FuncTree;
        private var _fxTriggerCountstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6069);
        }

        public function initGameFightSpectateMessage(effects:Vector.<FightDispellableEffectExtendedInformations>=null, marks:Vector.<GameActionMark>=null, gameTurn:uint=0, fightStart:uint=0, idols:Vector.<Idol>=null, fxTriggerCounts:Vector.<GameFightEffectTriggerCount>=null):GameFightSpectateMessage
        {
            this.effects = effects;
            this.marks = marks;
            this.gameTurn = gameTurn;
            this.fightStart = fightStart;
            this.idols = idols;
            this.fxTriggerCounts = fxTriggerCounts;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.effects = new Vector.<FightDispellableEffectExtendedInformations>();
            this.marks = new Vector.<GameActionMark>();
            this.gameTurn = 0;
            this.fightStart = 0;
            this.idols = new Vector.<Idol>();
            this.fxTriggerCounts = new Vector.<GameFightEffectTriggerCount>();
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
            this.serializeAs_GameFightSpectateMessage(output);
        }

        public function serializeAs_GameFightSpectateMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.effects.length);
            var _i1:uint;
            while (_i1 < this.effects.length)
            {
                (this.effects[_i1] as FightDispellableEffectExtendedInformations).serializeAs_FightDispellableEffectExtendedInformations(output);
                _i1++;
            };
            output.writeShort(this.marks.length);
            var _i2:uint;
            while (_i2 < this.marks.length)
            {
                (this.marks[_i2] as GameActionMark).serializeAs_GameActionMark(output);
                _i2++;
            };
            if (this.gameTurn < 0)
            {
                throw (new Error((("Forbidden value (" + this.gameTurn) + ") on element gameTurn.")));
            };
            output.writeVarShort(this.gameTurn);
            if (this.fightStart < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightStart) + ") on element fightStart.")));
            };
            output.writeInt(this.fightStart);
            output.writeShort(this.idols.length);
            var _i5:uint;
            while (_i5 < this.idols.length)
            {
                (this.idols[_i5] as Idol).serializeAs_Idol(output);
                _i5++;
            };
            output.writeShort(this.fxTriggerCounts.length);
            var _i6:uint;
            while (_i6 < this.fxTriggerCounts.length)
            {
                (this.fxTriggerCounts[_i6] as GameFightEffectTriggerCount).serializeAs_GameFightEffectTriggerCount(output);
                _i6++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightSpectateMessage(input);
        }

        public function deserializeAs_GameFightSpectateMessage(input:ICustomDataInput):void
        {
            var _item1:FightDispellableEffectExtendedInformations;
            var _item2:GameActionMark;
            var _item5:Idol;
            var _item6:GameFightEffectTriggerCount;
            var _effectsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _effectsLen)
            {
                _item1 = new FightDispellableEffectExtendedInformations();
                _item1.deserialize(input);
                this.effects.push(_item1);
                _i1++;
            };
            var _marksLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _marksLen)
            {
                _item2 = new GameActionMark();
                _item2.deserialize(input);
                this.marks.push(_item2);
                _i2++;
            };
            this._gameTurnFunc(input);
            this._fightStartFunc(input);
            var _idolsLen:uint = input.readUnsignedShort();
            var _i5:uint;
            while (_i5 < _idolsLen)
            {
                _item5 = new Idol();
                _item5.deserialize(input);
                this.idols.push(_item5);
                _i5++;
            };
            var _fxTriggerCountsLen:uint = input.readUnsignedShort();
            var _i6:uint;
            while (_i6 < _fxTriggerCountsLen)
            {
                _item6 = new GameFightEffectTriggerCount();
                _item6.deserialize(input);
                this.fxTriggerCounts.push(_item6);
                _i6++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameFightSpectateMessage(tree);
        }

        public function deserializeAsyncAs_GameFightSpectateMessage(tree:FuncTree):void
        {
            this._effectstree = tree.addChild(this._effectstreeFunc);
            this._markstree = tree.addChild(this._markstreeFunc);
            tree.addChild(this._gameTurnFunc);
            tree.addChild(this._fightStartFunc);
            this._idolstree = tree.addChild(this._idolstreeFunc);
            this._fxTriggerCountstree = tree.addChild(this._fxTriggerCountstreeFunc);
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
            var _item:FightDispellableEffectExtendedInformations = new FightDispellableEffectExtendedInformations();
            _item.deserialize(input);
            this.effects.push(_item);
        }

        private function _markstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._markstree.addChild(this._marksFunc);
                i++;
            };
        }

        private function _marksFunc(input:ICustomDataInput):void
        {
            var _item:GameActionMark = new GameActionMark();
            _item.deserialize(input);
            this.marks.push(_item);
        }

        private function _gameTurnFunc(input:ICustomDataInput):void
        {
            this.gameTurn = input.readVarUhShort();
            if (this.gameTurn < 0)
            {
                throw (new Error((("Forbidden value (" + this.gameTurn) + ") on element of GameFightSpectateMessage.gameTurn.")));
            };
        }

        private function _fightStartFunc(input:ICustomDataInput):void
        {
            this.fightStart = input.readInt();
            if (this.fightStart < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightStart) + ") on element of GameFightSpectateMessage.fightStart.")));
            };
        }

        private function _idolstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._idolstree.addChild(this._idolsFunc);
                i++;
            };
        }

        private function _idolsFunc(input:ICustomDataInput):void
        {
            var _item:Idol = new Idol();
            _item.deserialize(input);
            this.idols.push(_item);
        }

        private function _fxTriggerCountstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._fxTriggerCountstree.addChild(this._fxTriggerCountsFunc);
                i++;
            };
        }

        private function _fxTriggerCountsFunc(input:ICustomDataInput):void
        {
            var _item:GameFightEffectTriggerCount = new GameFightEffectTriggerCount();
            _item.deserialize(input);
            this.fxTriggerCounts.push(_item);
        }


    }
}

