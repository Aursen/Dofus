package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.ActorOrientation;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class GameMapChangeOrientationsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6155;

        private var _isInitialized:Boolean = false;
        public var orientations:Vector.<ActorOrientation> = new Vector.<ActorOrientation>();
        private var _orientationstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6155);
        }

        public function initGameMapChangeOrientationsMessage(orientations:Vector.<ActorOrientation>=null):GameMapChangeOrientationsMessage
        {
            this.orientations = orientations;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.orientations = new Vector.<ActorOrientation>();
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
            this.serializeAs_GameMapChangeOrientationsMessage(output);
        }

        public function serializeAs_GameMapChangeOrientationsMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.orientations.length);
            var _i1:uint;
            while (_i1 < this.orientations.length)
            {
                (this.orientations[_i1] as ActorOrientation).serializeAs_ActorOrientation(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameMapChangeOrientationsMessage(input);
        }

        public function deserializeAs_GameMapChangeOrientationsMessage(input:ICustomDataInput):void
        {
            var _item1:ActorOrientation;
            var _orientationsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _orientationsLen)
            {
                _item1 = new ActorOrientation();
                _item1.deserialize(input);
                this.orientations.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameMapChangeOrientationsMessage(tree);
        }

        public function deserializeAsyncAs_GameMapChangeOrientationsMessage(tree:FuncTree):void
        {
            this._orientationstree = tree.addChild(this._orientationstreeFunc);
        }

        private function _orientationstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._orientationstree.addChild(this._orientationsFunc);
                i++;
            };
        }

        private function _orientationsFunc(input:ICustomDataInput):void
        {
            var _item:ActorOrientation = new ActorOrientation();
            _item.deserialize(input);
            this.orientations.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.context

