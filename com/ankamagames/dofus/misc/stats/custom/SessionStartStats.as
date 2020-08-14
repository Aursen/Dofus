package com.ankamagames.dofus.misc.stats.custom
{
    import com.ankamagames.dofus.misc.stats.IHookStats;
    import com.ankamagames.dofus.misc.stats.IStatsClass;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.misc.interClient.InterClientManager;
    import com.ankamagames.berilia.types.data.Hook;
    import com.ankamagames.jerakine.messages.Message;

    public class SessionStartStats implements IHookStats, IStatsClass 
    {

        public function SessionStartStats()
        {
            var action:StatsAction = new StatsAction(672);
            action.user = StatsAction.getUserId();
            action.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
            action.setParam("account_id", PlayerManager.getInstance().accountId);
            action.setParam("client_open", InterClientManager.getInstance().numClients);
            action.send();
        }

        public function onHook(pHook:Hook, pArgs:Array):void
        {
        }

        public function process(pMessage:Message, pArgs:Array=null):void
        {
        }

        public function remove():void
        {
        }


    }
} com.ankamagames.dofus.misc.stats.custom

