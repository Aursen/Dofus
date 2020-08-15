package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobDescription;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class JobDescriptionMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5655;

        private var _isInitialized:Boolean = false;
        public var jobsDescription:Vector.<JobDescription> = new Vector.<JobDescription>();
        private var _jobsDescriptiontree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5655);
        }

        public function initJobDescriptionMessage(jobsDescription:Vector.<JobDescription>=null):JobDescriptionMessage
        {
            this.jobsDescription = jobsDescription;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.jobsDescription = new Vector.<JobDescription>();
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
            this.serializeAs_JobDescriptionMessage(output);
        }

        public function serializeAs_JobDescriptionMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.jobsDescription.length);
            var _i1:uint;
            while (_i1 < this.jobsDescription.length)
            {
                (this.jobsDescription[_i1] as JobDescription).serializeAs_JobDescription(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobDescriptionMessage(input);
        }

        public function deserializeAs_JobDescriptionMessage(input:ICustomDataInput):void
        {
            var _item1:JobDescription;
            var _jobsDescriptionLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _jobsDescriptionLen)
            {
                _item1 = new JobDescription();
                _item1.deserialize(input);
                this.jobsDescription.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_JobDescriptionMessage(tree);
        }

        public function deserializeAsyncAs_JobDescriptionMessage(tree:FuncTree):void
        {
            this._jobsDescriptiontree = tree.addChild(this._jobsDescriptiontreeFunc);
        }

        private function _jobsDescriptiontreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._jobsDescriptiontree.addChild(this._jobsDescriptionFunc);
                i++;
            };
        }

        private function _jobsDescriptionFunc(input:ICustomDataInput):void
        {
            var _item:JobDescription = new JobDescription();
            _item.deserialize(input);
            this.jobsDescription.push(_item);
        }


    }
}

