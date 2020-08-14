package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.BreachHookList;

    public class HyperlinkBreachManager 
    {


        public static function leaveBreach():void
        {
            KernelEventsManager.getInstance().processCallback(BreachHookList.BreachExit);
        }

        public static function invitGroup():void
        {
            KernelEventsManager.getInstance().processCallback(BreachHookList.BreachInvitGroupMembers);
        }


    }
} com.ankamagames.dofus.logic.common.managers

