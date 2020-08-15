package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.dofus.misc.stats.IHookStats;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.logic.game.common.types.DofusShopObject;
    import com.ankamagames.dofus.misc.stats.StatisticsManager;
    import com.ankamagames.berilia.utils.BeriliaHookList;
    import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
    import com.ankamagames.berilia.types.data.Hook;
    import __AS3__.vec.*;

    public class ShopNavigationStats implements IUiStats, IHookStats 
    {

        private static const EVENT_ID:uint = 700;

        private var _actionsStack:Vector.<StatsAction>;
        private var action_count:int;

        public function ShopNavigationStats(args:Array)
        {
            this.action_count = 0;
            this._actionsStack = new Vector.<StatsAction>(0);
            this.CreateNewStatShop(ShopTypeStat.OPEN_UI, 0);
        }

        private function CreateNewStatShop(action_type:int, action_id:int=0, virtualCurrency:*=null, navigationType:*=null):void
        {
            var _statsAction:StatsAction = new StatsAction(EVENT_ID);
            _statsAction.user = StatsAction.getUserId();
            _statsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
            _statsAction.setParam("account_id", PlayerManager.getInstance().accountId);
            _statsAction.setParam("server_id", PlayerManager.getInstance().server.id);
            _statsAction.setParam("character_id", PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
            _statsAction.setParam("map_id", PlayedCharacterManager.getInstance().currentMap.mapId);
            _statsAction.setParam("character_level", PlayedCharacterManager.getInstance().infos.level);
            _statsAction.setParam("action_type", action_type);
            _statsAction.setParam("action_count", this.action_count);
            _statsAction.setParam("action_id", action_id);
            _statsAction.setParam("virtual_currency", virtualCurrency);
            _statsAction.setParam("navigation_type", navigationType);
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
            var selectedArticle:DofusShopObject;
            var indirectBoughtArticle:DofusShopObject;
            var directBoughtArticle:DofusShopObject;
            var paymentChoiceArticle:DofusShopObject;
            var validCodeArticle:DofusShopObject;
            var validBuyArticle:DofusShopObject;
            var webRedirectArticle:DofusShopObject;
            if (((pArgs == null) || (pArgs.length == 0)))
            {
                return;
            };
            switch (pHook.name)
            {
                case BeriliaHookList.UiUnloaded.name:
                    if (pArgs[0] == "webShop")
                    {
                        this.CreateNewStatShop(ShopTypeStat.CLOSE_UI, 0);
                        StatisticsManager.getInstance().sendActions(this._actionsStack);
                    };
                    break;
                case ExternalGameHookList.DofusShopCurrentSelectedArticle.name:
                    selectedArticle = (pArgs[0] as DofusShopObject);
                    this.action_count++;
                    this.CreateNewStatShop(ShopTypeStat.ARTICLE_CLICK, selectedArticle.id, null, pArgs[2]);
                    break;
                case ExternalGameHookList.DofusShopIndirectBuyClick.name:
                    indirectBoughtArticle = (pArgs[0] as DofusShopObject);
                    this.action_count++;
                    this.CreateNewStatShop(ShopTypeStat.ARTICLE_BUY_CLICK, indirectBoughtArticle.id, pArgs[1]);
                    break;
                case ExternalGameHookList.DofusShopDirectBuyClick.name:
                    directBoughtArticle = (pArgs[0] as DofusShopObject);
                    this.action_count++;
                    this.CreateNewStatShop(ShopTypeStat.BUY_CLICK, directBoughtArticle.id, pArgs[1], pArgs[2]);
                    break;
                case ExternalGameHookList.DofusShopValidPaymentChoice.name:
                    paymentChoiceArticle = (pArgs[0] as DofusShopObject);
                    this.action_count++;
                    this.CreateNewStatShop(ShopTypeStat.ONECLICK_PAYMENT, paymentChoiceArticle.id);
                    break;
                case ExternalGameHookList.DofusShopValidCode.name:
                    validCodeArticle = (pArgs[0] as DofusShopObject);
                    this.action_count++;
                    this.CreateNewStatShop(ShopTypeStat.ONECLICK_CODE, validCodeArticle.id);
                    break;
                case ExternalGameHookList.DofusShopValidBuy.name:
                    validBuyArticle = (pArgs[0] as DofusShopObject);
                    this.action_count++;
                    this.CreateNewStatShop(ShopTypeStat.VALID_BUY, validBuyArticle.id, pArgs[1]);
                    break;
                case ExternalGameHookList.DofusShopSwitchTab.name:
                    this.action_count++;
                    this.CreateNewStatShop(ShopTypeStat.SWITCH_TAB);
                    break;
                case ExternalGameHookList.DofusShopWebRedirect.name:
                    webRedirectArticle = (pArgs[0] as DofusShopObject);
                    this.action_count++;
                    this.CreateNewStatShop(ShopTypeStat.WEBSITE_REDIRECTION, webRedirectArticle.id);
                    break;
            };
        }


    }
}

