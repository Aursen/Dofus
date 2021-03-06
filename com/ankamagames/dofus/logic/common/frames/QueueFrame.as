package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.queues.LoginQueueStatusMessage;
    import com.ankamagames.dofus.network.messages.queues.QueueStatusMessage;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.jerakine.messages.Message;

    public class QueueFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(QueueFrame));


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var lqsMsg:LoginQueueStatusMessage;
            var qsMsg:QueueStatusMessage;
            switch (true)
            {
                case (msg is LoginQueueStatusMessage):
                    lqsMsg = (msg as LoginQueueStatusMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.LoginQueueStatus, lqsMsg.position, lqsMsg.total);
                    return (true);
                case (msg is QueueStatusMessage):
                    qsMsg = (msg as QueueStatusMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.QueueStatus, qsMsg.position, qsMsg.total);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }


    }
}

