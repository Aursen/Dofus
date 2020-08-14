package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class GameMapMovementMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 951;

        private var _isInitialized:Boolean = false;
        public var keyMovements:Vector.<uint> = new Vector.<uint>();
        public var forcedDirection:int = 0;
        public var actorId:Number = 0;
        private var _keyMovementstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (951);
        }

        public function initGameMapMovementMessage(keyMovements:Vector.<uint>=null, forcedDirection:int=0, actorId:Number=0):GameMapMovementMessage
        {
            this.keyMovements = keyMovements;
            this.forcedDirection = forcedDirection;
            this.actorId = actorId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.keyMovements = new Vector.<uint>();
            this.forcedDirection = 0;
            this.actorId = 0;
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
            this.serializeAs_GameMapMovementMessage(output);
        }

        public function serializeAs_GameMapMovementMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.keyMovements.length);
            var _i1:uint;
            while (_i1 < this.keyMovements.length)
            {
                if (this.keyMovements[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.keyMovements[_i1]) + ") on element 1 (starting at 1) of keyMovements.")));
                };
                output.writeShort(this.keyMovements[_i1]);
                _i1++;
            };
            output.writeShort(this.forcedDirection);
            if (((this.actorId < -9007199254740992) || (this.actorId > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.actorId) + ") on element actorId.")));
            };
            output.writeDouble(this.actorId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameMapMovementMessage(input);
        }

        public function deserializeAs_GameMapMovementMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _keyMovementsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _keyMovementsLen)
            {
                _val1 = input.readShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of keyMovements.")));
                };
                this.keyMovements.push(_val1);
                _i1++;
            };
            this._forcedDirectionFunc(input);
            this._actorIdFunc(input);
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameMapMovementMessage(tree);
        }

        public function deserializeAsyncAs_GameMapMovementMessage(tree:FuncTree):void
        {
            this._keyMovementstree = tree.addChild(this._keyMovementstreeFunc);
            tree.addChild(this._forcedDirectionFunc);
            tree.addChild(this._actorIdFunc);
        }

        private function _keyMovementstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._keyMovementstree.addChild(this._keyMovementsFunc);
                i++;
            };
        }

        private function _keyMovementsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readShort();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of keyMovements.")));
            };
            this.keyMovements.push(_val);
        }

        private function _forcedDirectionFunc(input:ICustomDataInput):void
        {
            this.forcedDirection = input.readShort();
        }

        private function _actorIdFunc(input:ICustomDataInput):void
        {
            this.actorId = input.readDouble();
            if (((this.actorId < -9007199254740992) || (this.actorId > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.actorId) + ") on element of GameMapMovementMessage.actorId.")));
            };
        }


    }
} com.ankamagames.dofus.network.messages.game.context

