package com.ankamagames.dofus.logic.common.managers.temporis
{
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.actions.OpenTemporisSpellsUiAction;
    import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;

    public class HyperlinkTemporisManager 
    {

        private static const ACHIEVEMENT_ID_TO_OPEN:uint = 2316;


        public static function openTemporisSpellsUi():void
        {
            Kernel.getWorker().process(OpenTemporisSpellsUiAction.create());
        }

        public static function openTemporisSuccesses():void
        {
            Kernel.getWorker().process(OpenBookAction.create("achievementTab", {"achievementId":ACHIEVEMENT_ID_TO_OPEN}));
        }

        public static function openTemporisQuestTab():void
        {
            Kernel.getWorker().process(OpenBookAction.create("temporisQuestTab"));
        }

        public static function locatePorisAssistant():void
        {
            KernelEventsManager.getInstance().processCallback(HookList.LocatePorisAssistant);
        }


    }
}

