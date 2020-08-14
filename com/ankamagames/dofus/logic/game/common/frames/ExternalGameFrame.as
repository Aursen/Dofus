package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Timer;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.OpenWebServiceAction;
    import com.ankamagames.dofus.network.messages.web.haapi.HaapiAuthErrorMessage;
    import com.ankamagames.dofus.network.messages.web.haapi.HaapiShopApiKeyMessage;
    import com.ankamagames.dofus.network.messages.web.haapi.HaapiTokenMessage;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopArticlesListRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopBuyRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopSearchRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopOneClickBuyRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopOneClickValidateOrderRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopOneClickSendCodeRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.HavenBagRoomUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.HavenBagPackListMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.havenbag.HavenBagRoomPreviewInformation;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
    import com.ankamagames.dofus.network.enums.HaapiAuthTypeEnum;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopAuthentificationRequestAction;
    import com.ankamagames.dofus.logic.game.common.managers.DofusShopManager;
    import com.ankamagames.dofus.network.enums.HavenBagRoomActionEnum;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.OpenCodesAndGiftRequestAction;
    import com.ankamagames.dofus.logic.game.common.managers.CodesAndGiftManager;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ConsumeCodeAction;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ConsumeSimpleKardAction;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.UpdateGiftListRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.externalGame.ConsumeMultipleKardAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.network.messages.web.haapi.HaapiShopApiKeyRequestMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.types.enums.DofusShopEnum;

    public class ExternalGameFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalGameFrame));

        private var _tokenRequestCallback:Array = [];
        private var _tokenRequestTimeoutTimer:Timer;
        private var _tokenRequestHasTimedOut:Boolean = false;
        private var _haapiKeyRequestCallback:Array = [];
        private var _haapiKeyRequestTimeoutTimer:Timer;
        private var _haapiKeyRequestHasTimedOut:Boolean = false;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function pulled():Boolean
        {
            this.clearTokenRequestTimer();
            this._tokenRequestCallback.length = 0;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var owsa:OpenWebServiceAction;
            var haem:HaapiAuthErrorMessage;
            var hsakm:HaapiShopApiKeyMessage;
            var htm:HaapiTokenMessage;
            var salra:ShopArticlesListRequestAction;
            var sbra:ShopBuyRequestAction;
            var ssra:ShopSearchRequestAction;
            var socbra:ShopOneClickBuyRequestAction;
            var socvora:ShopOneClickValidateOrderRequestAction;
            var socscra:ShopOneClickSendCodeRequestAction;
            var hbrum:HavenBagRoomUpdateMessage;
            var hbplmsg:HavenBagPackListMessage;
            var validThemes:Vector.<int>;
            var commonThemeIndex:int;
            var commonMod:Object;
            var currentList:Vector.<HavenBagRoomPreviewInformation>;
            var j:int;
            var found:Boolean;
            var i:int;
            switch (true)
            {
                case (msg is OpenWebServiceAction):
                    owsa = (msg as OpenWebServiceAction);
                    KernelEventsManager.getInstance().processCallback(ExternalGameHookList.OpenWebService, owsa.uiName, owsa.uiParams);
                    return (true);
                case (msg is HaapiAuthErrorMessage):
                    if (this._tokenRequestHasTimedOut)
                    {
                        return (true);
                    };
                    haem = (msg as HaapiAuthErrorMessage);
                    if (haem.type == HaapiAuthTypeEnum.HAAPI_TOKEN)
                    {
                        if (this._tokenRequestCallback.length)
                        {
                            this.clearTokenRequestTimer();
                            this.callOnTokenFunctions("");
                        }
                        else
                        {
                            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.HaapiAuthError);
                        };
                    };
                    return (true);
                case (msg is HaapiShopApiKeyMessage):
                    if (this._haapiKeyRequestHasTimedOut)
                    {
                        return (true);
                    };
                    hsakm = (msg as HaapiShopApiKeyMessage);
                    if (this._haapiKeyRequestCallback.length)
                    {
                        this.clearHaapiKeyRequestTimer();
                        this.callOnHaapiKeyFunctions(hsakm.token);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(ExternalGameHookList.HaapiAuthToken, hsakm.token);
                    };
                    return (true);
                case (msg is HaapiTokenMessage):
                    if (this._tokenRequestHasTimedOut)
                    {
                        return (true);
                    };
                    htm = (msg as HaapiTokenMessage);
                    if (this._tokenRequestCallback.length)
                    {
                        this.clearTokenRequestTimer();
                        this.callOnTokenFunctions(htm.token);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(ExternalGameHookList.HaapiAuthToken, htm.token);
                    };
                    return (true);
                case (msg is ShopAuthentificationRequestAction):
                    if (XmlConfig.getInstance().getEntry("config.dev.shopIceToken") == "true")
                    {
                        commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                        commonMod.openInputPopup("ICE Authentication", "To access the Release shop, please enter a valid ICE Token.\nClose this message to access the Local shop.", this.onTokenInput, this.onCancel);
                    }
                    else
                    {
                        this.getHaapiKey(this.openShop);
                    };
                    return (true);
                case (msg is ShopArticlesListRequestAction):
                    salra = (msg as ShopArticlesListRequestAction);
                    DofusShopManager.getInstance().getArticlesList(salra.categoryId);
                    return (true);
                case (msg is ShopBuyRequestAction):
                    sbra = (msg as ShopBuyRequestAction);
                    DofusShopManager.getInstance().buyArticle(sbra.articleId, sbra.currency, sbra.quantity);
                    return (true);
                case (msg is ShopSearchRequestAction):
                    ssra = (msg as ShopSearchRequestAction);
                    DofusShopManager.getInstance().searchForArticles(ssra.text);
                    return (true);
                case (msg is ShopOneClickBuyRequestAction):
                    socbra = (msg as ShopOneClickBuyRequestAction);
                    DofusShopManager.getInstance().oneClickBuyArticle(socbra.data, socbra.currency, socbra.token);
                    return (true);
                case (msg is ShopOneClickValidateOrderRequestAction):
                    socvora = (msg as ShopOneClickValidateOrderRequestAction);
                    DofusShopManager.getInstance().oneClickValidateOrder(socvora.orderId, socvora.code);
                    return (true);
                case (msg is ShopOneClickSendCodeRequestAction):
                    socscra = (msg as ShopOneClickSendCodeRequestAction);
                    DofusShopManager.getInstance().onceClickSendCode(socscra.orderId);
                    return (true);
                case (msg is HavenBagRoomUpdateMessage):
                    hbrum = (msg as HavenBagRoomUpdateMessage);
                    if (((!(hbrum == null)) && (!(hbrum.roomsPreview == null))))
                    {
                        if (hbrum.action == HavenBagRoomActionEnum.HAVEN_BAG_ROOM_DISPATCH)
                        {
                            PlayedCharacterManager.getInstance().currentHavenbagRooms = hbrum.roomsPreview;
                            PlayerManager.getInstance().havenbagAvailableRooms = hbrum.roomsPreview;
                            KernelEventsManager.getInstance().processCallback(HookList.HavenbagAvailableRoomsUpdate, hbrum.roomsPreview);
                        }
                        else
                        {
                            currentList = PlayedCharacterManager.getInstance().currentHavenbagRooms;
                            j = 0;
                            while (j < hbrum.roomsPreview.length)
                            {
                                found = false;
                                i = 0;
                                while (i < currentList.length)
                                {
                                    if (currentList[i].roomId == hbrum.roomsPreview[j].roomId)
                                    {
                                        found = true;
                                        currentList[i].themeId = hbrum.roomsPreview[j].themeId;
                                        break;
                                    };
                                    i++;
                                };
                                if (!found)
                                {
                                    currentList.push(hbrum.roomsPreview[j]);
                                };
                                j++;
                            };
                            PlayedCharacterManager.getInstance().currentHavenbagRooms = currentList;
                            PlayerManager.getInstance().havenbagAvailableRooms = currentList;
                            KernelEventsManager.getInstance().processCallback(HookList.HavenbagAvailableRoomsUpdate, currentList);
                        };
                    };
                    return (true);
                case (msg is HavenBagPackListMessage):
                    hbplmsg = (msg as HavenBagPackListMessage);
                    validThemes = hbplmsg.packIds;
                    commonThemeIndex = validThemes.indexOf(-1);
                    if (commonThemeIndex != -1)
                    {
                        validThemes.splice(commonThemeIndex, 1);
                    };
                    PlayerManager.getInstance().havenbagAvailableThemes = validThemes;
                    KernelEventsManager.getInstance().processCallback(HookList.HavenbagAvailableThemesUpdate, hbplmsg.packIds);
                    return (true);
                case (msg is OpenCodesAndGiftRequestAction):
                    this.getHaapiKey(this.openCodesAndGift);
                    return (true);
                case (msg is ConsumeCodeAction):
                    CodesAndGiftManager.getInstance().consumeCode((msg as ConsumeCodeAction).code);
                    return (true);
                case (msg is ConsumeSimpleKardAction):
                    CodesAndGiftManager.getInstance().consumeKard((msg as ConsumeSimpleKardAction).id);
                    return (true);
                case (msg is UpdateGiftListRequestAction):
                    CodesAndGiftManager.getInstance().updatePurchaseList();
                    return (true);
                case (msg is ConsumeMultipleKardAction):
                    CodesAndGiftManager.getInstance().consumeKardMultiple((msg as ConsumeMultipleKardAction).id);
                    return (true);
            };
            return (false);
        }

        public function getIceToken(callback:Function=null):void
        {
            this._tokenRequestHasTimedOut = false;
            if (callback != null)
            {
                this._tokenRequestCallback.push(callback);
            };
            var hsakrm:HaapiShopApiKeyRequestMessage = new HaapiShopApiKeyRequestMessage();
            ConnectionsHandler.getConnection().send(hsakrm);
            this._tokenRequestTimeoutTimer = new Timer(10000, 1);
            this._tokenRequestTimeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTokenRequestTimeout);
            this._tokenRequestTimeoutTimer.start();
        }

        public function getHaapiKey(callback:Function=null):void
        {
            this._haapiKeyRequestHasTimedOut = false;
            if (callback != null)
            {
                this._haapiKeyRequestCallback.push(callback);
            };
            var hsakrm:HaapiShopApiKeyRequestMessage = new HaapiShopApiKeyRequestMessage();
            ConnectionsHandler.getConnection().send(hsakrm);
            this._haapiKeyRequestTimeoutTimer = new Timer(10000, 1);
            this._haapiKeyRequestTimeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onHaapiKeyRequestTimeout);
            this._haapiKeyRequestTimeoutTimer.start();
        }

        private function openShop(token:String):void
        {
            if (!token)
            {
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError, DofusShopEnum.ERROR_AUTHENTICATION_FAILED);
                return;
            };
            DofusShopManager.getInstance().init(token);
        }

        private function openCodesAndGift(apiKey:String):void
        {
            if (!apiKey)
            {
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError, DofusShopEnum.ERROR_AUTHENTICATION_FAILED);
                return;
            };
            CodesAndGiftManager.getInstance().init(apiKey);
        }

        private function onTokenRequestTimeout(event:TimerEvent):void
        {
            this._tokenRequestHasTimedOut = true;
            this.clearTokenRequestTimer();
            this.callOnTokenFunctions("");
        }

        private function onHaapiKeyRequestTimeout(event:TimerEvent):void
        {
            this._haapiKeyRequestHasTimedOut = true;
            this.clearHaapiKeyRequestTimer();
            this.callOnHaapiKeyFunctions("");
        }

        private function callOnTokenFunctions(token:String):void
        {
            var fct:Function;
            if (this._tokenRequestCallback.length)
            {
                for each (fct in this._tokenRequestCallback)
                {
                    (fct(token));
                };
                this._tokenRequestCallback.length = 0;
            };
        }

        private function callOnHaapiKeyFunctions(token:String):void
        {
            var fct:Function;
            if (this._haapiKeyRequestCallback.length)
            {
                for each (fct in this._haapiKeyRequestCallback)
                {
                    (fct(token));
                };
                this._haapiKeyRequestCallback.length = 0;
            };
        }

        private function clearTokenRequestTimer():void
        {
            if (this._tokenRequestTimeoutTimer)
            {
                this._tokenRequestTimeoutTimer.stop();
                this._tokenRequestTimeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTokenRequestTimeout);
                this._tokenRequestTimeoutTimer = null;
            };
        }

        private function clearHaapiKeyRequestTimer():void
        {
            if (this._haapiKeyRequestTimeoutTimer)
            {
                this._haapiKeyRequestTimeoutTimer.stop();
                this._haapiKeyRequestTimeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onHaapiKeyRequestTimeout);
                this._haapiKeyRequestTimeoutTimer = null;
            };
        }

        private function onTokenInput(value:String):void
        {
            DofusShopManager.getInstance().init(value, true);
        }

        private function onCancel():void
        {
            this.getHaapiKey(this.openShop);
        }


    }
} com.ankamagames.dofus.logic.game.common.frames

