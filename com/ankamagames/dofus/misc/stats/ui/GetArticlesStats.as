package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.dofus.misc.stats.IHookStats;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.misc.stats.StatisticsManager;
    import com.ankamagames.berilia.utils.BeriliaHookList;
    import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
    import com.ankamagames.berilia.types.data.Hook;
    import __AS3__.vec.*;

    public class GetArticlesStats implements IUiStats, IHookStats 
    {

        private static const EVENT_ID:uint = 709;

        private var _actionsStack:Vector.<StatsAction>;

        public function GetArticlesStats(args:Array)
        {
            this._actionsStack = new Vector.<StatsAction>();
        }

        private function CreateNewGetArticlesStats(item_id:int):void
        {
            var _statsAction:StatsAction = new StatsAction(EVENT_ID);
            _statsAction.user = StatsAction.getUserId();
            _statsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
            _statsAction.setParam("account_id", PlayerManager.getInstance().accountId);
            _statsAction.setParam("server_id", PlayerManager.getInstance().server.id);
            _statsAction.setParam("character_id", PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
            _statsAction.setParam("character_level", PlayedCharacterManager.getInstance().infos.level);
            _statsAction.setParam("item_id", item_id);
            _statsAction.setParam("get_all", false);
            this._actionsStack.push(_statsAction);
        }

        private function CreateNewGetAllArticles():void
        {
            var _statsAction:StatsAction = new StatsAction(EVENT_ID);
            _statsAction.user = StatsAction.getUserId();
            _statsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
            _statsAction.setParam("account_id", PlayerManager.getInstance().accountId);
            _statsAction.setParam("server_id", PlayerManager.getInstance().server.id);
            _statsAction.setParam("character_id", PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
            _statsAction.setParam("character_level", PlayedCharacterManager.getInstance().infos.level);
            _statsAction.setParam("item_id", -1);
            _statsAction.setParam("get_all", true);
            this._actionsStack.push(_statsAction);
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
            switch (pHook.name)
            {
                case BeriliaHookList.UiUnloaded.name:
                    if (pArgs[0] == "webCodesAndGifts")
                    {
                        StatisticsManager.getInstance().sendActions(this._actionsStack);
                    };
                    break;
                case ExternalGameHookList.CodesAndGiftGetArticlesStats.name:
                    if (pArgs[0] == null)
                    {
                        this.CreateNewGetAllArticles();
                    }
                    else
                    {
                        this.CreateNewGetArticlesStats(pArgs[0]);
                    };
                    break;
            };
        }


    }
}

