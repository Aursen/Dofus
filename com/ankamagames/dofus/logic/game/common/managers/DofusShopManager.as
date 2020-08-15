package com.ankamagames.dofus.logic.game.common.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankama.haapi.client.api.ShopApi;
    import com.ankama.haapi.client.api.MoneyApi;
    import flash.utils.Dictionary;
    import org.openapitools.common.ApiUserCredentials;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
    import org.openapitools.event.ApiClientEvent;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.dofus.logic.game.common.types.DofusShopArticle;
    import com.ankamagames.dofus.logic.game.common.types.DofusShopCategory;
    import com.ankamagames.dofus.logic.game.common.types.DofusShopHighlight;
    import com.ankamagames.dofus.types.enums.DofusShopEnum;
    import com.ankama.haapi.client.model.ShopBuyResult;
    import flash.events.IOErrorEvent;
    import flash.events.ErrorEvent;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;

    public class DofusShopManager 
    {

        private static const _log:Logger = Log.getLogger("DofusShopManager");
        private static const HAAPI_BASE_PATH:String = XmlConfig.getInstance().getEntry("config.haapiUrlAnkama");
        private static const NB_CATEGORY_ARTICLES_HEADER_NAME:String = "X-Total";
        private static var _self:DofusShopManager;

        public var shopApi:ShopApi;
        public var moneyApi:MoneyApi;
        private var _tokens:Array;
        private var _key:String;
        private var _articlesTemp:Dictionary = new Dictionary();


        public static function getInstance():DofusShopManager
        {
            if (!_self)
            {
                _self = new (DofusShopManager)();
            };
            return (_self);
        }


        public function init(key:String, forceReleaseGameService:Boolean=false):void
        {
            this._key = key;
            var apiCredentials:ApiUserCredentials = new ApiUserCredentials("", HAAPI_BASE_PATH, this._key);
            this.shopApi = new ShopApi(apiCredentials);
            this.moneyApi = new MoneyApi(apiCredentials);
            this.shopApi.home().onSuccess(this.onHome).onError(this.onHomeError).call();
            this.update();
        }

        private function update():void
        {
            this.moneyApi.ogrins_account(false).onSuccess(this.onLinkedOgrines).onError(this.onLinkedOgrinesError).call();
            this.getOneClickTokens();
        }

        public function getMoney():void
        {
            this.moneyApi.ogrins_amount().onSuccess(this.onMoney).onError(this.onMoneyError).call();
        }

        public function buyArticle(articleId:int, currency:String, amount:Number, quantity:int=1):void
        {
            this.shopApi.simple_buy(articleId, quantity, amount, currency).onSuccess(this.onBuyArticle(articleId)).onError(this.onBuyArticleError(articleId)).call();
        }

        public function getArticlesList(category:int, size:int=20):void
        {
            this._articlesTemp[category] = [];
            this.shopApi.articles_list_by_category(category, 1, size).onSuccess(this.onArticlesList(category, 1)).onError(this.onArticleListError(category, 1)).call();
        }

        public function searchForArticles(criteria:String, size:int=20):void
        {
            this._articlesTemp[-1] = [];
            this.shopApi.articles_list_search(criteria, [], 1, size).onSuccess(this.onSearchArticles(1, criteria)).onError(this.onSearchArticlesError(1, criteria)).call();
        }

        public function updateAfterExpiredArticle(articleId:int):void
        {
            this.shopApi.articles_list_by_ids([articleId]).onSuccess(this.onRefreshArticle([articleId])).onError(this.onRefreshArticleError(articleId)).call();
        }

        public function getOneClickTokens():void
        {
            this.shopApi.one_click_tokens().onSuccess(this.onOneClickTokens).onError(this.onOneClickTokensError).call();
        }

        public function oneClickBuyArticle(data:String, currency:String, token:Number):void
        {
            this.shopApi.one_click_buy(data, currency, token).onSuccess(this.onOneClickBuy(token)).onError(this.onOneclickBuyError(token)).call();
        }

        public function oneClickValidateOrder(orderId:Number, code:String):void
        {
            this.shopApi.one_click_validate_order(orderId, code).onSuccess(this.onOneClickValidateOrder).onError(this.onCodeError).call();
        }

        public function onceClickSendCode(orderId:Number):void
        {
            this.shopApi.one_click_send_code(orderId).onSuccess(this.onOneClickSendCode).onError(this.onOneClickSendCodeError).call();
        }

        private function onOneClickTokens(e:ApiClientEvent):void
        {
            if (e.response.payload)
            {
                this._tokens = (e.response.payload as Array);
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopOneClickTokens, e.response.payload);
            };
        }

        private function onOneClickTokensError(e:ApiClientEvent):void
        {
            _log.error("Can't get haapi One Click token");
        }

        private function onOneClickBuy(pToken:Number):Function
        {
            return (function (e:ApiClientEvent):void
            {
                var token:*;
                if (e.response.payload == null)
                {
                    processCallError(("Error: OneClickBuy requested data corrupted : " + e.response.errorMessage));
                    return;
                };
                var mod:* = UiModuleManager.getInstance().getModule("Ankama_Web");
                var params:* = e.response.payload;
                for each (token in _tokens)
                {
                    if (token.id == pToken)
                    {
                        params.codeMethod = token.security_method;
                        params.codeMethodValue = token.security_method_value;
                        params.article = Berilia.getInstance().getUi("webShop").uiClass.currentArticle;
                    };
                };
                Berilia.getInstance().loadUi(mod, mod.getUi("shopPopupOneClickCode"), "shopPopupOneClickCode", params, true, StrataEnum.STRATA_TOP);
            });
        }

        private function onOneclickBuyError(token:Number):Function
        {
            return (function (e:ApiClientEvent):void
            {
                _log.error(("Can't buy article with One Click [token] " + token));
            });
        }

        private function onOneClickValidateOrder(e:ApiClientEvent):void
        {
            if (e.response.payload == null)
            {
                this.processCallError("Error: OneClickValidateOrder requested data corrupted");
                return;
            };
            if (e.response.payload.reason)
            {
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopOneInvalidCode);
            }
            else
            {
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopBuySuccess, true);
            };
        }

        private function onCodeError(e:ApiClientEvent):void
        {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopOneInvalidCode);
        }

        private function onOneClickSendCode(e:ApiClientEvent):void
        {
            _log.info("OneClick code sent succesfully");
        }

        private function onOneClickSendCodeError(e:ApiClientEvent):void
        {
            _log.error("Could not send OneClick code");
        }

        private function onMoney(e:ApiClientEvent):void
        {
            if (e.response.payload == null)
            {
                this.processCallError("Error: Money requested data corrupted");
                return;
            };
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopMoney, e.response.payload.amount);
        }

        public function onMoneyError(e:ApiClientEvent):void
        {
            _log.error("Can't Retrieve Money ammount from Haapi");
        }

        private function onLinkedOgrines(e:ApiClientEvent):void
        {
            if (e.response.payload == null)
            {
                this.processCallError("Error: LinkedOgrines requested data corrupted");
                return;
            };
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakLinkedOgrines, e.response.payload);
        }

        private function onLinkedOgrinesError(e:ApiClientEvent):void
        {
            _log.error("Could not get linked ogrines ammoun from haapi");
        }

        private function onHome(e:ApiClientEvent):void
        {
            var data:Object;
            var article:DofusShopArticle;
            var payload:* = e.response.payload;
            if (!payload)
            {
                this.processCallError(("Error: Home requested data corrupted : " + e.response.errorMessage));
                return;
            };
            var categories:Array = [];
            var gondolaArticles:Array = [];
            var highlightCarousel:Array = [];
            this.getMoney();
            if (payload.categories)
            {
                for each (data in payload.categories)
                {
                    categories.push(new DofusShopCategory(data));
                };
            };
            if (payload.gondolahead_article)
            {
                for each (data in payload.gondolahead_article)
                {
                    article = new DofusShopArticle(data);
                    if (!article.hasExpired)
                    {
                        gondolaArticles.push(article);
                    };
                };
            };
            if (payload.hightlight_carousel)
            {
                for each (data in payload.hightlight_carousel)
                {
                    highlightCarousel.push(new DofusShopHighlight(data));
                };
            };
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopHome, categories, gondolaArticles, highlightCarousel);
        }

        private function onHomeError(e:ApiClientEvent):void
        {
            _log.error(("Error while retrieving Shop Home from Haapi : " + e.response.errorMessage));
        }

        private function onArticlesList(categoryId:Number, page:Number):Function
        {
            return (function (e:ApiClientEvent):void
            {
                var articleData:*;
                var article:*;
                var maxPage:*;
                var i:*;
                var payload:* = e.response.payload;
                if (payload == null)
                {
                    processCallError(("Error: ArticlesList requested data corrupted : " + e.response.errorMessage));
                    return;
                };
                var articles:* = new Array();
                for each (articleData in payload.articles)
                {
                    article = new DofusShopArticle(articleData);
                    if (!article.hasExpired)
                    {
                        articles.push(article);
                    };
                };
                maxPage = 1;
                if (payload.total_count)
                {
                    maxPage = Math.ceil((int(payload.total_count) / DofusShopEnum.MAX_ARTICLES_PER_PAGE));
                    if (page == 1)
                    {
                        i = 2;
                        while (i <= maxPage)
                        {
                            shopApi.articles_list_by_category(categoryId, i, DofusShopEnum.MAX_ARTICLES_PER_PAGE).onSuccess(onArticlesList(categoryId, i)).onError(onArticleListError(categoryId, i)).call();
                            i++;
                        };
                    };
                };
                _articlesTemp[categoryId].insertAt((page - 1), articles);
                i = 0;
                while (i < maxPage)
                {
                    if (!_articlesTemp[categoryId][i])
                    {
                        return;
                    };
                    i++;
                };
                var resultArray:* = [];
                i = 0;
                while (i < maxPage)
                {
                    resultArray = resultArray.concat(_articlesTemp[categoryId][i]);
                    i++;
                };
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopArticlesList, resultArray, categoryId);
            });
        }

        private function onArticleListError(categoryId:Number, page:Number):Function
        {
            return (function (e:ApiClientEvent):void
            {
                _log.error(((((("Error while retrieving article list from Haapi with [category] " + categoryId) + ", [page] ") + page) + " : ") + e.response.errorMessage));
            });
        }

        private function onSearchArticles(page:int, text:String):Function
        {
            return (function (e:ApiClientEvent):void
            {
                var articleData:*;
                var article:*;
                var maxPage:*;
                var i:*;
                var payload:* = e.response.payload;
                if (payload == null)
                {
                    processCallError(("Error: SearchArticles requested data corrupted : " + e.response.errorMessage));
                    return;
                };
                var articles:* = new Array();
                for each (articleData in payload.articles)
                {
                    article = new DofusShopArticle(articleData);
                    if (!article.hasExpired)
                    {
                        articles.push(article);
                    };
                };
                maxPage = 1;
                if (payload.total_count)
                {
                    maxPage = Math.ceil((int(payload.total_count) / DofusShopEnum.MAX_ARTICLES_PER_PAGE));
                    if (page == 1)
                    {
                        i = 2;
                        while (i <= maxPage)
                        {
                            shopApi.articles_list_search(text, [], i, DofusShopEnum.MAX_ARTICLES_PER_PAGE).onSuccess(onSearchArticles(i, text)).onError(onSearchArticlesError(i, text)).call();
                            i++;
                        };
                    };
                };
                _articlesTemp[-1].insertAt((page - 1), articles);
                i = 0;
                while (i < maxPage)
                {
                    if (!_articlesTemp[-1][i])
                    {
                        return;
                    };
                    i++;
                };
                var resultArray:* = [];
                i = 0;
                while (i < maxPage)
                {
                    resultArray = resultArray.concat(_articlesTemp[-1][i]);
                    i++;
                };
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopArticlesSearchList, resultArray);
            });
        }

        private function onSearchArticlesError(page:int, text:String):Function
        {
            return (function (e:ApiClientEvent):void
            {
                _log.error(((((("Error while searching articles from Haapi with [criteria] " + text) + ", [page] ") + page) + " : ") + e.response.errorMessage));
            });
        }

        private function onBuyArticle(articleId:int):Function
        {
            return (function (e:ApiClientEvent):void
            {
                var payload:* = e.response.payload;
                if (payload == null)
                {
                    processCallError(("Error: BuyArticle requested data corrupted : " + e.response.errorMessage));
                    return;
                };
                if (payload.balance)
                {
                    KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopMoney, payload.balance[0].amount);
                };
                if (payload.order_status == ShopBuyResult.OrderStatusEnum_PROCESSED)
                {
                    shopApi.articles_list_by_ids([articleId]).onSuccess(onRefreshArticle([articleId])).onError(onRefreshArticleError(articleId)).call();
                    KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopBuySuccess, false);
                };
            });
        }

        private function onBuyArticleError(id:int):Function
        {
            return (function (e:ApiClientEvent):void
            {
                _log.error(((("Can't Buy article [id]" + id) + " : ") + e.response.errorMessage));
            });
        }

        private function onRefreshArticle(ids:Array):Function
        {
            return (function (e:ApiClientEvent):void
            {
                if (e.response.payload == null)
                {
                    processCallError(("Error: RefreshArticle requested data corrupted : " + e.response.errorMessage));
                    return;
                };
                if (e.response.payload.articles.length == 0)
                {
                    KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopDeleteArticle, ids);
                };
            });
        }

        private function onRefreshArticleError(id:Number):Function
        {
            return (function (e:ApiClientEvent):void
            {
                _log.error(("Error while refreshing article [id] " + id));
            });
        }

        private function processCallError(error:*):void
        {
            _log.error(error);
            if (((error is ErrorEvent) && (error.type == IOErrorEvent.NETWORK_ERROR)))
            {
                KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError, DofusShopEnum.ERROR_REQUEST_TIMED_OUT);
            }
            else
            {
                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, I18n.getUiText("ui.shop.errorApi"), ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
            };
        }


    }
}

