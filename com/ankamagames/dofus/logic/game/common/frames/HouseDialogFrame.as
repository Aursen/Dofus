package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.common.actions.LockableUseCodeAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableUseCodeMessage;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.network.enums.DialogTypeEnum;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;

    public class HouseDialogFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HouseDialogFrame));


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
            var luca:LockableUseCodeAction;
            var lucmsg:LockableUseCodeMessage;
            var ldm:LeaveDialogMessage;
            switch (true)
            {
                case (msg is LockableUseCodeAction):
                    luca = (msg as LockableUseCodeAction);
                    lucmsg = new LockableUseCodeMessage();
                    lucmsg.initLockableUseCodeMessage(luca.code);
                    ConnectionsHandler.getConnection().send(lucmsg);
                    return (true);
                case (msg is LeaveDialogMessage):
                    ldm = (msg as LeaveDialogMessage);
                    if (((ldm.dialogType == DialogTypeEnum.DIALOG_PURCHASABLE) || (ldm.dialogType == DialogTypeEnum.DIALOG_LOCKABLE)))
                    {
                        Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                        Kernel.getWorker().removeFrame(this);
                    };
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
            return (true);
        }


    }
}

