package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class GameFightSynchronizeMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5921;

        private var _isInitialized:Boolean = false;
        public var fighters:Vector.<GameFightFighterInformations> = new Vector.<GameFightFighterInformations>();
        private var _fighterstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5921);
        }

        public function initGameFightSynchronizeMessage(fighters:Vector.<GameFightFighterInformations>=null):GameFightSynchronizeMessage
        {
            this.fighters = fighters;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fighters = new Vector.<GameFightFighterInformations>();
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
            this.serializeAs_GameFightSynchronizeMessage(output);
        }

        public function serializeAs_GameFightSynchronizeMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.fighters.length);
            var _i1:uint;
            while (_i1 < this.fighters.length)
            {
                output.writeShort((this.fighters[_i1] as GameFightFighterInformations).getTypeId());
                (this.fighters[_i1] as GameFightFighterInformations).serialize(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightSynchronizeMessage(input);
        }

        public function deserializeAs_GameFightSynchronizeMessage(input:ICustomDataInput):void
        {
            var _id1:uint;
            var _item1:GameFightFighterInformations;
            var _fightersLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _fightersLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(GameFightFighterInformations, _id1);
                _item1.deserialize(input);
                this.fighters.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameFightSynchronizeMessage(tree);
        }

        public function deserializeAsyncAs_GameFightSynchronizeMessage(tree:FuncTree):void
        {
            this._fighterstree = tree.addChild(this._fighterstreeFunc);
        }

        private function _fighterstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._fighterstree.addChild(this._fightersFunc);
                i++;
            };
        }

        private function _fightersFunc(input:ICustomDataInput):void
        {
            var _id:uint = input.readUnsignedShort();
            var _item:GameFightFighterInformations = ProtocolTypeManager.getInstance(GameFightFighterInformations, _id);
            _item.deserialize(input);
            this.fighters.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.fight

