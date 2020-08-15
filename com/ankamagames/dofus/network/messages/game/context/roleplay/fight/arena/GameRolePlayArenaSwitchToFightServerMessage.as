package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
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

    public class GameRolePlayArenaSwitchToFightServerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6575;

        private var _isInitialized:Boolean = false;
        public var address:String = "";
        public var ports:Vector.<uint> = new Vector.<uint>();
        public var ticket:Vector.<int> = new Vector.<int>();
        private var _portstree:FuncTree;
        private var _tickettree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6575);
        }

        public function initGameRolePlayArenaSwitchToFightServerMessage(address:String="", ports:Vector.<uint>=null, ticket:Vector.<int>=null):GameRolePlayArenaSwitchToFightServerMessage
        {
            this.address = address;
            this.ports = ports;
            this.ticket = ticket;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.address = "";
            this.ports = new Vector.<uint>();
            this.ticket = new Vector.<int>();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            if (HASH_FUNCTION != null)
            {
                HASH_FUNCTION(data);
            };
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
            this.serializeAs_GameRolePlayArenaSwitchToFightServerMessage(output);
        }

        public function serializeAs_GameRolePlayArenaSwitchToFightServerMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.address);
            output.writeShort(this.ports.length);
            var _i2:uint;
            while (_i2 < this.ports.length)
            {
                if (this.ports[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.ports[_i2]) + ") on element 2 (starting at 1) of ports.")));
                };
                output.writeVarShort(this.ports[_i2]);
                _i2++;
            };
            output.writeVarInt(this.ticket.length);
            var _i3:uint;
            while (_i3 < this.ticket.length)
            {
                output.writeByte(this.ticket[_i3]);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayArenaSwitchToFightServerMessage(input);
        }

        public function deserializeAs_GameRolePlayArenaSwitchToFightServerMessage(input:ICustomDataInput):void
        {
            var _val2:uint;
            var _val3:int;
            this._addressFunc(input);
            var _portsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _portsLen)
            {
                _val2 = input.readVarUhShort();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of ports.")));
                };
                this.ports.push(_val2);
                _i2++;
            };
            var _ticketLen:uint = input.readVarInt();
            var _i3:uint;
            while (_i3 < _ticketLen)
            {
                _val3 = input.readByte();
                this.ticket.push(_val3);
                _i3++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameRolePlayArenaSwitchToFightServerMessage(tree);
        }

        public function deserializeAsyncAs_GameRolePlayArenaSwitchToFightServerMessage(tree:FuncTree):void
        {
            tree.addChild(this._addressFunc);
            this._portstree = tree.addChild(this._portstreeFunc);
            this._tickettree = tree.addChild(this._tickettreeFunc);
        }

        private function _addressFunc(input:ICustomDataInput):void
        {
            this.address = input.readUTF();
        }

        private function _portstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._portstree.addChild(this._portsFunc);
                i++;
            };
        }

        private function _portsFunc(input:ICustomDataInput):void
        {
            var _val:uint = input.readVarUhShort();
            if (_val < 0)
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of ports.")));
            };
            this.ports.push(_val);
        }

        private function _tickettreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readVarInt();
            var i:uint;
            while (i < length)
            {
                this._tickettree.addChild(this._ticketFunc);
                i++;
            };
        }

        private function _ticketFunc(input:ICustomDataInput):void
        {
            var _val:int = input.readByte();
            this.ticket.push(_val);
        }


    }
}

