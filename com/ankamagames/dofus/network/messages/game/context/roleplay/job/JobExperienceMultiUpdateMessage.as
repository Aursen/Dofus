package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class JobExperienceMultiUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5809;

        private var _isInitialized:Boolean = false;
        public var experiencesUpdate:Vector.<JobExperience> = new Vector.<JobExperience>();
        private var _experiencesUpdatetree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5809);
        }

        public function initJobExperienceMultiUpdateMessage(experiencesUpdate:Vector.<JobExperience>=null):JobExperienceMultiUpdateMessage
        {
            this.experiencesUpdate = experiencesUpdate;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.experiencesUpdate = new Vector.<JobExperience>();
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
            this.serializeAs_JobExperienceMultiUpdateMessage(output);
        }

        public function serializeAs_JobExperienceMultiUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.experiencesUpdate.length);
            var _i1:uint;
            while (_i1 < this.experiencesUpdate.length)
            {
                (this.experiencesUpdate[_i1] as JobExperience).serializeAs_JobExperience(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobExperienceMultiUpdateMessage(input);
        }

        public function deserializeAs_JobExperienceMultiUpdateMessage(input:ICustomDataInput):void
        {
            var _item1:JobExperience;
            var _experiencesUpdateLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _experiencesUpdateLen)
            {
                _item1 = new JobExperience();
                _item1.deserialize(input);
                this.experiencesUpdate.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_JobExperienceMultiUpdateMessage(tree);
        }

        public function deserializeAsyncAs_JobExperienceMultiUpdateMessage(tree:FuncTree):void
        {
            this._experiencesUpdatetree = tree.addChild(this._experiencesUpdatetreeFunc);
        }

        private function _experiencesUpdatetreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._experiencesUpdatetree.addChild(this._experiencesUpdateFunc);
                i++;
            };
        }

        private function _experiencesUpdateFunc(input:ICustomDataInput):void
        {
            var _item:JobExperience = new JobExperience();
            _item.deserialize(input);
            this.experiencesUpdate.push(_item);
        }


    }
}

