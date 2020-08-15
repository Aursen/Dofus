package com.ankamagames.dofus.network.messages.game.character.debt
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

    public class DebtsDeleteMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6866;

        private var _isInitialized:Boolean = false;
        public var reason:uint = 0;
        public var debts:Vector.<Number> = new Vector.<Number>();
        private var _debtstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6866);
        }

        public function initDebtsDeleteMessage(reason:uint=0, debts:Vector.<Number>=null):DebtsDeleteMessage
        {
            this.reason = reason;
            this.debts = debts;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.reason = 0;
            this.debts = new Vector.<Number>();
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
            this.serializeAs_DebtsDeleteMessage(output);
        }

        public function serializeAs_DebtsDeleteMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.reason);
            output.writeShort(this.debts.length);
            var _i2:uint;
            while (_i2 < this.debts.length)
            {
                if (((this.debts[_i2] < 0) || (this.debts[_i2] > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + this.debts[_i2]) + ") on element 2 (starting at 1) of debts.")));
                };
                output.writeDouble(this.debts[_i2]);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_DebtsDeleteMessage(input);
        }

        public function deserializeAs_DebtsDeleteMessage(input:ICustomDataInput):void
        {
            var _val2:Number;
            this._reasonFunc(input);
            var _debtsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _debtsLen)
            {
                _val2 = input.readDouble();
                if (((_val2 < 0) || (_val2 > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of debts.")));
                };
                this.debts.push(_val2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_DebtsDeleteMessage(tree);
        }

        public function deserializeAsyncAs_DebtsDeleteMessage(tree:FuncTree):void
        {
            tree.addChild(this._reasonFunc);
            this._debtstree = tree.addChild(this._debtstreeFunc);
        }

        private function _reasonFunc(input:ICustomDataInput):void
        {
            this.reason = input.readByte();
            if (this.reason < 0)
            {
                throw (new Error((("Forbidden value (" + this.reason) + ") on element of DebtsDeleteMessage.reason.")));
            };
        }

        private function _debtstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._debtstree.addChild(this._debtsFunc);
                i++;
            };
        }

        private function _debtsFunc(input:ICustomDataInput):void
        {
            var _val:Number = input.readDouble();
            if (((_val < 0) || (_val > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of debts.")));
            };
            this.debts.push(_val);
        }


    }
}

