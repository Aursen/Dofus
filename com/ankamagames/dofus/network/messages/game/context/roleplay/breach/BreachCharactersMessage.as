package com.ankamagames.dofus.network.messages.game.context.roleplay.breach
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

    public class BreachCharactersMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6811;

        private var _isInitialized:Boolean = false;
        public var characters:Vector.<Number> = new Vector.<Number>();
        private var _characterstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6811);
        }

        public function initBreachCharactersMessage(characters:Vector.<Number>=null):BreachCharactersMessage
        {
            this.characters = characters;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.characters = new Vector.<Number>();
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
            this.serializeAs_BreachCharactersMessage(output);
        }

        public function serializeAs_BreachCharactersMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.characters.length);
            var _i1:uint;
            while (_i1 < this.characters.length)
            {
                if (((this.characters[_i1] < 0) || (this.characters[_i1] > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + this.characters[_i1]) + ") on element 1 (starting at 1) of characters.")));
                };
                output.writeVarLong(this.characters[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BreachCharactersMessage(input);
        }

        public function deserializeAs_BreachCharactersMessage(input:ICustomDataInput):void
        {
            var _val1:Number;
            var _charactersLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _charactersLen)
            {
                _val1 = input.readVarUhLong();
                if (((_val1 < 0) || (_val1 > 9007199254740992)))
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of characters.")));
                };
                this.characters.push(_val1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_BreachCharactersMessage(tree);
        }

        public function deserializeAsyncAs_BreachCharactersMessage(tree:FuncTree):void
        {
            this._characterstree = tree.addChild(this._characterstreeFunc);
        }

        private function _characterstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._characterstree.addChild(this._charactersFunc);
                i++;
            };
        }

        private function _charactersFunc(input:ICustomDataInput):void
        {
            var _val:Number = input.readVarUhLong();
            if (((_val < 0) || (_val > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + _val) + ") on elements of characters.")));
            };
            this.characters.push(_val);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.roleplay.breach

