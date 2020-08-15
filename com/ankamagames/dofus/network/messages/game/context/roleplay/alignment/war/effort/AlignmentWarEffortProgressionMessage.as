package com.ankamagames.dofus.network.messages.game.context.roleplay.alignment.war.effort
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.alignment.war.effort.AlignmentWarEffortInformation;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class AlignmentWarEffortProgressionMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6852;

        private var _isInitialized:Boolean = false;
        public var effortProgressions:Vector.<AlignmentWarEffortInformation> = new Vector.<AlignmentWarEffortInformation>();
        private var _effortProgressionstree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6852);
        }

        public function initAlignmentWarEffortProgressionMessage(effortProgressions:Vector.<AlignmentWarEffortInformation>=null):AlignmentWarEffortProgressionMessage
        {
            this.effortProgressions = effortProgressions;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.effortProgressions = new Vector.<AlignmentWarEffortInformation>();
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
            this.serializeAs_AlignmentWarEffortProgressionMessage(output);
        }

        public function serializeAs_AlignmentWarEffortProgressionMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.effortProgressions.length);
            var _i1:uint;
            while (_i1 < this.effortProgressions.length)
            {
                (this.effortProgressions[_i1] as AlignmentWarEffortInformation).serializeAs_AlignmentWarEffortInformation(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AlignmentWarEffortProgressionMessage(input);
        }

        public function deserializeAs_AlignmentWarEffortProgressionMessage(input:ICustomDataInput):void
        {
            var _item1:AlignmentWarEffortInformation;
            var _effortProgressionsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _effortProgressionsLen)
            {
                _item1 = new AlignmentWarEffortInformation();
                _item1.deserialize(input);
                this.effortProgressions.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_AlignmentWarEffortProgressionMessage(tree);
        }

        public function deserializeAsyncAs_AlignmentWarEffortProgressionMessage(tree:FuncTree):void
        {
            this._effortProgressionstree = tree.addChild(this._effortProgressionstreeFunc);
        }

        private function _effortProgressionstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._effortProgressionstree.addChild(this._effortProgressionsFunc);
                i++;
            };
        }

        private function _effortProgressionsFunc(input:ICustomDataInput):void
        {
            var _item:AlignmentWarEffortInformation = new AlignmentWarEffortInformation();
            _item.deserialize(input);
            this.effortProgressions.push(_item);
        }


    }
}

