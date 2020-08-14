package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class MapObstacleUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6051;

        private var _isInitialized:Boolean = false;
        public var obstacles:Vector.<MapObstacle> = new Vector.<MapObstacle>();
        private var _obstaclestree:FuncTree;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6051);
        }

        public function initMapObstacleUpdateMessage(obstacles:Vector.<MapObstacle>=null):MapObstacleUpdateMessage
        {
            this.obstacles = obstacles;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.obstacles = new Vector.<MapObstacle>();
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
            this.serializeAs_MapObstacleUpdateMessage(output);
        }

        public function serializeAs_MapObstacleUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.obstacles.length);
            var _i1:uint;
            while (_i1 < this.obstacles.length)
            {
                (this.obstacles[_i1] as MapObstacle).serializeAs_MapObstacle(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MapObstacleUpdateMessage(input);
        }

        public function deserializeAs_MapObstacleUpdateMessage(input:ICustomDataInput):void
        {
            var _item1:MapObstacle;
            var _obstaclesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _obstaclesLen)
            {
                _item1 = new MapObstacle();
                _item1.deserialize(input);
                this.obstacles.push(_item1);
                _i1++;
            };
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_MapObstacleUpdateMessage(tree);
        }

        public function deserializeAsyncAs_MapObstacleUpdateMessage(tree:FuncTree):void
        {
            this._obstaclestree = tree.addChild(this._obstaclestreeFunc);
        }

        private function _obstaclestreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._obstaclestree.addChild(this._obstaclesFunc);
                i++;
            };
        }

        private function _obstaclesFunc(input:ICustomDataInput):void
        {
            var _item:MapObstacle = new MapObstacle();
            _item.deserialize(input);
            this.obstacles.push(_item);
        }


    }
} com.ankamagames.dofus.network.messages.game.context.roleplay

