package com.ankamagames.dofus.network.messages.game.atlas
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.AtlasPointsInformations;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class AtlasPointInformationsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5956;

        private var _isInitialized:Boolean = false;
        public var type:AtlasPointsInformations = new AtlasPointsInformations();
        private var _typetree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5956);
        }

        public function initAtlasPointInformationsMessage(_arg_1:AtlasPointsInformations=null):AtlasPointInformationsMessage
        {
            this.type = _arg_1;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.type = new AtlasPointsInformations();
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
            this.serializeAs_AtlasPointInformationsMessage(output);
        }

        public function serializeAs_AtlasPointInformationsMessage(output:ICustomDataOutput):void
        {
            this.type.serializeAs_AtlasPointsInformations(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AtlasPointInformationsMessage(input);
        }

        public function deserializeAs_AtlasPointInformationsMessage(input:ICustomDataInput):void
        {
            this.type = new AtlasPointsInformations();
            this.type.deserialize(input);
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_AtlasPointInformationsMessage(tree);
        }

        public function deserializeAsyncAs_AtlasPointInformationsMessage(tree:FuncTree):void
        {
            this._typetree = tree.addChild(this._typetreeFunc);
        }

        private function _typetreeFunc(input:ICustomDataInput):void
        {
            this.type = new AtlasPointsInformations();
            this.type.deserializeAsync(this._typetree);
        }


    }
}

