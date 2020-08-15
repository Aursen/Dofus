package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.IdentifiedEntityDispositionInformations;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class GameFightPlacementSwapPositionsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6544;

        private var _isInitialized:Boolean = false;
        public var dispositions:Vector.<IdentifiedEntityDispositionInformations> = new Vector.<IdentifiedEntityDispositionInformations>(2, true);
        private var _dispositionstree:FuncTree;
        private var _dispositionsindex:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6544);
        }

        public function initGameFightPlacementSwapPositionsMessage(dispositions:Vector.<IdentifiedEntityDispositionInformations>=null):GameFightPlacementSwapPositionsMessage
        {
            this.dispositions = dispositions;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.dispositions = new Vector.<IdentifiedEntityDispositionInformations>(2, true);
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
            this.serializeAs_GameFightPlacementSwapPositionsMessage(output);
        }

        public function serializeAs_GameFightPlacementSwapPositionsMessage(output:ICustomDataOutput):void
        {
            var _i1:uint;
            while (_i1 < 2)
            {
                this.dispositions[_i1].serializeAs_IdentifiedEntityDispositionInformations(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightPlacementSwapPositionsMessage(input);
        }

        public function deserializeAs_GameFightPlacementSwapPositionsMessage(input:ICustomDataInput):void
        {
            var _i1:uint;
            while (_i1 < 2)
            {
                this.dispositions[_i1] = new IdentifiedEntityDispositionInformations();
                this.dispositions[_i1].deserialize(input);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_GameFightPlacementSwapPositionsMessage(tree);
        }

        public function deserializeAsyncAs_GameFightPlacementSwapPositionsMessage(tree:FuncTree):void
        {
            this._dispositionstree = tree.addChild(this._dispositionstreeFunc);
        }

        private function _dispositionstreeFunc(input:ICustomDataInput):void
        {
            var i:uint;
            while (i < 2)
            {
                this._dispositionstree.addChild(this._dispositionsFunc);
                i++;
            };
        }

        private function _dispositionsFunc(input:ICustomDataInput):void
        {
            this.dispositions[this._dispositionsindex] = new IdentifiedEntityDispositionInformations();
            this.dispositions[this._dispositionsindex].deserializeAsync(this._dispositionstree.children[this._dispositionsindex]);
            this._dispositionsindex++;
        }


    }
}

