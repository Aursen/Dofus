package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.idol.Idol;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class GameFightStartMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 712;

        private var _isInitialized:Boolean = false;
        public var idols:Vector.<Idol> = new Vector.<Idol>();
        private var _idolstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (712);
        }

        public function initGameFightStartMessage(idols:Vector.<Idol>=null):GameFightStartMessage
        {
            this.idols = idols;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.idols = new Vector.<Idol>();
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
            this.serializeAs_GameFightStartMessage(output);
        }

        public function serializeAs_GameFightStartMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.idols.length);
            var _i1:uint;
            while (_i1 < this.idols.length)
            {
                (this.idols[_i1] as Idol).serializeAs_Idol(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightStartMessage(input);
        }

        public function deserializeAs_GameFightStartMessage(input:ICustomDataInput):void
        {
            var _item1:Idol;
            var _idolsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _idolsLen)
            {
                _item1 = new Idol();
                _item1.deserialize(input);
                this.idols.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameFightStartMessage(tree);
        }

        public function deserializeAsyncAs_GameFightStartMessage(tree:FuncTree):void
        {
            this._idolstree = tree.addChild(this._idolstreeFunc);
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


    }
} com.ankamagames.dofus.network.messages.game.context.fight

