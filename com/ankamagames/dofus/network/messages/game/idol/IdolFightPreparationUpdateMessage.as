package com.ankamagames.dofus.network.messages.game.idol
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
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class IdolFightPreparationUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6586;

        private var _isInitialized:Boolean = false;
        public var idolSource:uint = 0;
        public var idols:Vector.<Idol> = new Vector.<Idol>();
        private var _idolstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6586);
        }

        public function initIdolFightPreparationUpdateMessage(idolSource:uint=0, idols:Vector.<Idol>=null):IdolFightPreparationUpdateMessage
        {
            this.idolSource = idolSource;
            this.idols = idols;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.idolSource = 0;
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
            this.serializeAs_IdolFightPreparationUpdateMessage(output);
        }

        public function serializeAs_IdolFightPreparationUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.idolSource);
            output.writeShort(this.idols.length);
            var _i2:uint;
            while (_i2 < this.idols.length)
            {
                output.writeShort((this.idols[_i2] as Idol).getTypeId());
                (this.idols[_i2] as Idol).serialize(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IdolFightPreparationUpdateMessage(input);
        }

        public function deserializeAs_IdolFightPreparationUpdateMessage(input:ICustomDataInput):void
        {
            var _id2:uint;
            var _item2:Idol;
            this._idolSourceFunc(input);
            var _idolsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _idolsLen)
            {
                _id2 = input.readUnsignedShort();
                _item2 = ProtocolTypeManager.getInstance(Idol, _id2);
                _item2.deserialize(input);
                this.idols.push(_item2);
                _i2++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_IdolFightPreparationUpdateMessage(tree);
        }

        public function deserializeAsyncAs_IdolFightPreparationUpdateMessage(tree:FuncTree):void
        {
            tree.addChild(this._idolSourceFunc);
            this._idolstree = tree.addChild(this._idolstreeFunc);
        }

        private function _idolSourceFunc(input:ICustomDataInput):void
        {
            this.idolSource = input.readByte();
            if (this.idolSource < 0)
            {
                throw (new Error((("Forbidden value (" + this.idolSource) + ") on element of IdolFightPreparationUpdateMessage.idolSource.")));
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
            var _id:uint = input.readUnsignedShort();
            var _item:Idol = ProtocolTypeManager.getInstance(Idol, _id);
            _item.deserialize(input);
            this.idols.push(_item);
        }


    }
}

