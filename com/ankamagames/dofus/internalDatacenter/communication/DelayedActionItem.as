package com.ankamagames.dofus.internalDatacenter.communication
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;

    public class DelayedActionItem implements IDataCenter 
    {

        public var playerId:Number;
        public var type:uint;
        public var dataId:int;
        public var endTime:Number;

        public function DelayedActionItem(pPlayerId:Number, _arg_2:uint, dataId:int, endTime:Number)
        {
            this.playerId = pPlayerId;
            this.type = _arg_2;
            this.dataId = dataId;
            this.endTime = endTime;
        }

    }
} com.ankamagames.dofus.internalDatacenter.communication

