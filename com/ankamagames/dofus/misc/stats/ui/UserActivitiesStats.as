package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.dofus.misc.stats.IHookStats;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.misc.lists.ChatServiceHookList;
    import com.ankamagames.berilia.types.data.Hook;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.misc.stats.StatisticsManager;

    public class UserActivitiesStats implements IUiStats, IHookStats 
    {

        private static const EVENT_ID:uint = 707;

        public function UserActivitiesStats(args:Array)
        {
        }

        public function process(pMessage:Message, pArgs:Array=null):void
        {
        }

        public function remove():void
        {
        }

        public function onHook(pHook:Hook, pArgs:Array):void
        {
            if (((pArgs == null) || (pArgs.length == 0)))
            {
                return;
            };
            if (pHook.name == ChatServiceHookList.ChatServiceUserUpdateHisActivity.name)
            {
                this.CreateAndSendNewStat(pArgs[0]);
            };
        }

        private function CreateAndSendNewStat(activity_type:uint):void
        {
            var _statsAction:StatsAction = new StatsAction(EVENT_ID);
            _statsAction.user = StatsAction.getUserId();
            _statsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
            _statsAction.setParam("account_id", PlayerManager.getInstance().accountId);
            _statsAction.setParam("server_id", PlayerManager.getInstance().server.id);
            _statsAction.setParam("character_id", PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
            _statsAction.setParam("character_level", PlayedCharacterManager.getInstance().infos.level);
            _statsAction.setParam("activity_type", activity_type);
            StatisticsManager.getInstance().sendAction(_statsAction);
        }


    }
} com.ankamagames.dofus.misc.stats.ui

