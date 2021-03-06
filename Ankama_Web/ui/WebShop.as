package Ankama_Web.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import __AS3__.vec.Vector;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.Input;
    import d2hooks.DofusShopHome;
    import d2hooks.DofusShopMoney;
    import d2hooks.DofusShopArticlesList;
    import d2hooks.DofusShopArticlesSearchList;
    import d2hooks.DofusBakLinkedOgrines;
    import d2hooks.DofusShopError;
    import d2hooks.KeyUp;
    import d2hooks.DofusShopDeleteArticle;
    import d2hooks.DofusShopOneClickTokens;
    import d2hooks.MouseClick;
    import d2hooks.DofusShopBuySuccess;
    import d2hooks.DofusShopCurrentArticle;
    import d2hooks.DofusShopOpenCategory;
    import d2enums.ComponentHookList;
    import flash.geom.ColorTransform;
    import flash.events.TimerEvent;
    import d2actions.ShopAuthentificationRequest;
    import flash.events.Event;
    import Ankama_Web.enum.ShopArticleTypeEnum;
    import com.ankamagames.dofus.logic.game.common.types.DofusShopHighlight;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.dofus.logic.game.common.types.DofusShopArticle;
    import com.ankamagames.dofus.types.enums.DofusShopEnum;
    import com.ankamagames.dofus.logic.game.common.types.DofusShopArticleReference;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
    import com.ankama.dofus.enums.ActionIds;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import d2actions.ShopArticlesListRequest;
    import flash.geom.Point;
    import com.ankamagames.berilia.types.LocationEnum;
    import d2hooks.DofusShopCurrentSelectedArticle;
    import flash.utils.ByteArray;
    import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
    import d2hooks.DofusShopDirectBuyClick;
    import d2actions.ShopSearchRequest;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.dofus.logic.game.common.types.DofusShopCategory;
    import __AS3__.vec.*;
    import d2hooks.*;
    import d2actions.*;

    public class WebShop 
    {

        private static const CTR_CAT_TYPE_CAT:String = "ctr_cat";
        private static const CTR_CAT_TYPE_SUBCAT:String = "ctr_subCat";
        private static const CTR_CAT_TYPE_SUBSUBCAT:String = "ctr_subSubCat";
        private static const VIRTUALSUBSCRIPTION_TYPE:String = "VIRTUALSUBSCRIPTION";
        private static const GAMEACTION_TYPE:String = "GAMEACTION";
        private static const HAVENBAG_TYPE:String = "DofusHavenBagTheme";
        private static const HAVENBAG_ROOM_TYPE:String = "DofusHavenBagRoom";
        private static const KARD_TYPE:String = "KARD";
        private static const KEY_GREATER_THAN:int = 226;
        private static const MAX_FANION_POOL_SIZE:int = 40;

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        private var _compHookData:Dictionary = new Dictionary(true);
        private var _moneyOgr:int;
        private var _searchCriteria:String;
        private var _goToArticleParams:Object;
        private var _goToCategoryId:uint;
        private var INPUT_SEARCH_DEFAULT_TEXT:String;
        private var _textureCache:Dictionary = new Dictionary();
        private var _promoTextureCache:Dictionary = new Dictionary();
        private var _allArticlesDatas:Array = new Array();
        private var _searchDatas:Array = new Array();
        private var _tooltipTarget:Object = null;
        private var _shopArticle:ShopArticle = null;
        private var _searchTimer:Timer = new Timer(500, 1);
        private var _linkedOgrinesAmount:int = 0;
        private var _expiringOgrines:Array;
        private var _loadedCategories:Array = [];
        private var _lastNameExtension:String = "";
        private var _oneClickTokens:Array = [];
        private var _promoPool:Vector.<Texture> = new Vector.<Texture>();
        private var _newPool:Vector.<Texture> = new Vector.<Texture>();
        private var _promoPoolIndex:int = 0;
        private var _newPoolIndex:int = 0;
        private var _tooltipCount:int = 0;
        private var _currentArticle:Object;
        private var _tooltipTimer:Timer;
        private var _navigationType:uint = 3;
        public var ctr_ogrinesAmount:GraphicContainer;
        public var btn_buyOgrins:ButtonContainer;
        public var iconTexturebtn_buyOgrins:TextureBitmap;
        public var lbl_currentOgrines:Label;
        public var gd_categories:Grid;
        public var ctr_search:GraphicContainer;
        public var inp_search:Input;
        public var btn_resetSearch:ButtonContainer;
        public var ctr_linkedOgrines:GraphicContainer;
        public var btn_gotToSubscriptions:ButtonContainer;
        public var lbl_subscribed:Label;
        public var lbl_subscriptionLink:Label;
        public var lbl_linkedOgrinesAmount:Label;
        public var lbl_linked:Label;
        public var tx_subscriptionExpire:Texture;
        public var tx_ogrinesExpire:Texture;
        public var gd_categoriesArticles:Grid;


        public function main(oParam:Object=null):void
        {
            this.sysApi.addHook(DofusShopHome, this.onDofusShopHome);
            this.sysApi.addHook(DofusShopMoney, this.onDofusShopMoney);
            this.sysApi.addHook(DofusShopArticlesList, this.onDofusShopArticlesList);
            this.sysApi.addHook(DofusShopArticlesSearchList, this.onDofusShopArticlesSearchList);
            this.sysApi.addHook(DofusBakLinkedOgrines, this.onDofusShopLinkedOgrines);
            this.sysApi.addHook(DofusShopError, this.onDofusShopError);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.sysApi.addHook(DofusShopDeleteArticle, this.onDeleteArticle);
            this.sysApi.addHook(DofusShopOneClickTokens, this.onDofusShopOneClickTokens);
            this.sysApi.addHook(MouseClick, this.onGenericMouseClick);
            this.sysApi.addHook(DofusShopBuySuccess, this.onDofusShopBuySuccess);
            this.sysApi.addHook(DofusShopCurrentArticle, this.onDofusShopCurrentArticle);
            this.sysApi.addHook(DofusShopOpenCategory, this.goToCategory);
            this.uiApi.addComponentHook(this.gd_categories, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.btn_buyOgrins, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_buyOgrins, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_buyOgrins, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.inp_search, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_resetSearch, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_resetSearch, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_gotToSubscriptions, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ctr_ogrinesAmount, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_ogrinesAmount, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_ogrinesExpire, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_ogrinesExpire, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_subscriptionExpire, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_subscriptionExpire, ComponentHookList.ON_ROLL_OUT);
            this._tooltipTimer = new Timer(500, 1);
            this.btn_buyOgrins.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -112, -15, 253);
            this.iconTexturebtn_buyOgrins.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 112, 15, -253);
            this.gd_categoriesArticles.verticalScrollSpeed = 1;
            this._searchTimer.addEventListener(TimerEvent.TIMER, this.onSearchTimer);
            this._textureCache[-1] = new Dictionary();
            this._promoTextureCache[-1] = new Dictionary();
            if (oParam)
            {
                if (oParam.hasOwnProperty("articleId"))
                {
                    this._goToArticleParams = {
                        "categoryId":oParam.categoryId,
                        "articleId":oParam.articleId
                    };
                }
                else
                {
                    if (oParam.hasOwnProperty("categoryId"))
                    {
                        this._goToCategoryId = oParam.categoryId;
                    };
                };
            };
            this.sysApi.sendAction(new ShopAuthentificationRequest());
            this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.search.shop");
            this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
            this.btn_resetSearch.visible = false;
            this.displaySubscriptionMessage();
            this.resizeLabels();
        }

        public function unload():void
        {
            this._tooltipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.displayItemTooltip);
            this._tooltipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.displayGenericTooltip);
            this._tooltipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.displayMysteryBoxTooltip);
            this._searchTimer.removeEventListener(TimerEvent.TIMER, this.onSearchTimer);
            if (this.gd_categoriesArticles.scrollBarV)
            {
                this.gd_categoriesArticles.scrollBarV.removeEventListener(Event.CHANGE, this.onScroll);
            };
            this.uiApi.unloadUi("shopPopup");
        }

        public function showTabHints():void
        {
            this.hintsApi.showSubHints();
        }

        public function updateLine(data:*, componentsRef:*, selected:Boolean, line:uint):void
        {
            var sa:ShopArticle;
            switch (this.getLineType(data, line))
            {
                case "ctr_categoryArticles":
                    this._lastNameExtension = componentsRef.gd_categoryArticles.name.slice(19);
                    for each (sa in data)
                    {
                        sa.nameExtension = this._lastNameExtension;
                    };
                    componentsRef.gd_categoryArticles.dataProvider = data;
                    break;
                case "ctr_subCategorySlot":
                case "ctr_subSubategorySlot":
                case "ctr_categorySlot":
                    componentsRef.lbl_categoryName.text = data.name;
                    break;
            };
        }

        public function getLineType(data:*, line:uint):String
        {
            if (data)
            {
                if (data.level >= 0)
                {
                    switch (data.level)
                    {
                        case 0:
                            return ("ctr_categorySlot");
                        case 1:
                            return ("ctr_subCategorySlot");
                        case 2:
                            return ("ctr_subSubCategorySlot");
                        default:
                            return ("ctr_emptyLine");
                    };
                };
                return ("ctr_categoryArticles");
            };
            return ("ctr_emptyLine");
        }

        public function getLineLength(data:*, line:uint):*
        {
            return (1);
        }

        public function updateSlot(data:*, componentsRef:*, selected:Boolean, line:uint):void
        {
            var slot:GraphicContainer;
            var labelName:Label;
            var nameBg:TextureBitmap;
            var labelPrice:Label;
            var labelOldPrice:Label;
            var labelCat:Label;
            var labelOneClick:Label;
            var labelOldOneClick:Label;
            var btn:ButtonContainer;
            var btnBuy:ButtonContainer;
            var btnBuyOneClick:ButtonContainer;
            var btnCat:ButtonContainer;
            var texture:Texture;
            var promoTexture:Texture;
            var buyBg:TextureBitmap;
            var oneClickBg:TextureBitmap;
            var hasOgrinePrice:Boolean;
            var hasOneClickPrice:Boolean;
            var i:int;
            if (((data) && (data.article)))
            {
                if (componentsRef.ctr_articleSlot)
                {
                    slot = componentsRef.ctr_articleSlot;
                    labelName = componentsRef.lbl_articleSlotName;
                    btn = componentsRef.btn_article;
                    btnBuy = componentsRef.btn_buy;
                    btnBuyOneClick = componentsRef.btn_buyOneClick;
                    labelPrice = componentsRef.lbl_ogrinesPrice;
                    labelOldPrice = componentsRef.lbl_ogrinesOldPrice;
                    nameBg = componentsRef.tx_articleSlotNameBg;
                    buyBg = componentsRef.tx_articleSlotBuyBg;
                    oneClickBg = componentsRef.tx_articleSlotOneClickBg;
                    labelOneClick = componentsRef.lbl_oneClickBuy;
                    labelOldOneClick = componentsRef.lbl_oneClickOldBuy;
                    btnCat = componentsRef.btn_articleCategory;
                    labelCat = componentsRef.lbl_articleCategoryName;
                    componentsRef.tx_articleOneClickImageOver.visible = false;
                    componentsRef.tx_articlePriceImageOver.visible = false;
                    componentsRef.tx_articleSlotImageOver.visible = false;
                }
                else
                {
                    slot = componentsRef.ctr_largeArticleSlot;
                    labelName = componentsRef.lbl_largeArticleSlotName;
                    btn = componentsRef.btn_largeArticle;
                    labelPrice = componentsRef.lbl_ogrinesPriceLargeArticle;
                    labelOldPrice = componentsRef.lbl_ogrinesOldPriceLargeArticle;
                    btnBuy = componentsRef.btn_buyLarge;
                    btnBuyOneClick = componentsRef.btn_buyOneClickLarge;
                    nameBg = componentsRef.tx_largeArticleSlotNameBg;
                    buyBg = componentsRef.tx_largeArticleSlotBuyBg;
                    oneClickBg = componentsRef.tx_largeArticleSlotOneClickBg;
                    labelOneClick = componentsRef.lbl_largeOneClickBuy;
                    labelOldOneClick = componentsRef.lbl_largeOneClickOldBuy;
                    btnCat = componentsRef.btn_largeArticleCategory;
                    labelCat = componentsRef.lbl_largeArticleCategoryName;
                    componentsRef.tx_largeArticleOneClickImageOver.visible = false;
                    componentsRef.tx_largeArticlePriceImageOver.visible = false;
                    componentsRef.tx_largeArticleSlotImageOver.visible = false;
                };
                labelOneClick.text = "";
                slot.visible = true;
                btnCat.visible = (((data.cat <= 0) && (!(data.type == ShopArticleTypeEnum.CATEGORY))) && (data.article.category));
                if (((!(data.article is DofusShopHighlight)) && (data.article.category)))
                {
                    labelCat.text = this.getCatName(data.article.category);
                };
                if (data.article.name)
                {
                    labelName.text = (data.name + (((!(data.article is DofusShopHighlight)) && (data.article.subtitle)) ? (" - " + data.article.subtitle) : ""));
                    labelName.y = ((nameBg.y + ((nameBg.height - Math.min(labelName.height, labelName.textHeight)) / 2)) - 4);
                };
                if (btn.getStrata(StrataEnum.STRATA_MEDIUM).numChildren > 2)
                {
                    btn.getStrata(StrataEnum.STRATA_MEDIUM).removeChildAt(2);
                };
                texture = this._textureCache[data.cat][data.article.id];
                btn.getStrata(StrataEnum.STRATA_MEDIUM).addChildAt(texture, 2);
                if (this._promoTextureCache[data.cat])
                {
                    promoTexture = this._promoTextureCache[data.cat][data.article.id];
                };
                if (btn.getStrata(StrataEnum.STRATA_MEDIUM).numChildren > 3)
                {
                    btn.getStrata(StrataEnum.STRATA_MEDIUM).removeChildAt(3);
                };
                if (promoTexture)
                {
                    btn.getStrata(StrataEnum.STRATA_MEDIUM).addChildAt(promoTexture, 3);
                };
                btnBuy.visible = false;
                btnBuyOneClick.visible = false;
                buyBg.visible = false;
                oneClickBg.visible = false;
                slot.height = 195;
                if (btn.getStrata(StrataEnum.STRATA_HIGH).numChildren > 1)
                {
                    this.freeFanion((btn.getStrata(StrataEnum.STRATA_HIGH).removeChildAt(1) as Texture));
                }
                else
                {
                    this.addFanionNew();
                };
                if (((data.article is DofusShopArticle) && (data.article.isNew)))
                {
                    btn.getStrata(StrataEnum.STRATA_HIGH).addChildAt(this._newPool[this._newPoolIndex], 1);
                    this._newPoolIndex = ((this._newPoolIndex == (this._newPool.length - 1)) ? 0 : (this._newPoolIndex + 1));
                };
                hasOgrinePrice = false;
                hasOneClickPrice = false;
                if (data.article.hasOwnProperty("prices"))
                {
                    i = 0;
                    while (i < data.article.prices.length)
                    {
                        if (data.article.prices[i].currency == DofusShopEnum.CURRENCY_OGRINES)
                        {
                            hasOgrinePrice = true;
                            labelPrice.text = ((data.article.prices[i].originalPrice) ? (data.article.prices[i].originalPrice + " ") : ("" + data.article.prices[i].price));
                            labelPrice.fullWidthAndHeight();
                            labelPrice.removeTooltipExtension();
                            labelPrice.textfield.width = labelPrice.width;
                            labelPrice.x = (118 - labelPrice.width);
                            if (((data.article.prices[i].original_price) && (data.article.prices[i].original_price > data.article.prices[i].price)))
                            {
                                if (btn.getStrata(StrataEnum.STRATA_HIGH).numChildren > 1)
                                {
                                    this.freeFanion((btn.getStrata(StrataEnum.STRATA_HIGH).removeChildAt(1) as Texture));
                                }
                                else
                                {
                                    this.addFanionPromo();
                                };
                                if (data.article.isNew)
                                {
                                    this.addFanionPromo();
                                };
                                btn.getStrata(StrataEnum.STRATA_HIGH).addChildAt(this._promoPool[this._promoPoolIndex], 1);
                                this._promoPoolIndex = ((this._promoPoolIndex == (this._promoPool.length - 1)) ? 0 : (this._promoPoolIndex + 1));
                                labelOldPrice.text = data.article.prices[i].original_price;
                                labelOldPrice.fullWidthAndHeight();
                                labelOldPrice.removeTooltipExtension();
                                labelOldPrice.textfield.width = labelOldPrice.width;
                                labelOldPrice.x = ((labelPrice.x - labelOldPrice.textWidth) - 13);
                                labelOldPrice.graphics.clear();
                                labelOldPrice.graphics.beginFill(this.sysApi.getConfigEntry("colors.shop.oldPrice"));
                                labelOldPrice.graphics.drawRect(0, ((labelOldPrice.height / 2) - 3), (labelOldPrice.textWidth + 5), 1);
                                labelOldPrice.graphics.endFill();
                            }
                            else
                            {
                                labelOldPrice.text = "";
                                labelOldPrice.graphics.clear();
                            };
                        }
                        else
                        {
                            if (data.article.prices[i].paymentmode == DofusShopEnum.PAYMENT_MODE_ONECLICK)
                            {
                                hasOneClickPrice = true;
                                if (((labelOneClick.text == "") || (!(data.article.prices[i].country == "WD"))))
                                {
                                    labelOneClick.text = ((data.article.prices[i].price + " ") + data.article.prices[i].currency);
                                    labelOneClick.fullWidthAndHeight();
                                    labelOneClick.removeTooltipExtension();
                                    labelOneClick.textfield.width = labelOneClick.width;
                                    labelOneClick.x = (140 - labelOneClick.width);
                                    if (((data.article.prices[i].original_price) && (data.article.prices[i].original_price > data.article.prices[i].price)))
                                    {
                                        if (btn.getStrata(StrataEnum.STRATA_HIGH).numChildren > 1)
                                        {
                                            this.freeFanion((btn.getStrata(StrataEnum.STRATA_HIGH).removeChildAt(1) as Texture));
                                        }
                                        else
                                        {
                                            this.addFanionPromo();
                                        };
                                        if (data.article.isNew)
                                        {
                                            this.addFanionPromo();
                                        };
                                        btn.getStrata(StrataEnum.STRATA_HIGH).addChildAt(this._promoPool[this._promoPoolIndex], 1);
                                        this._promoPoolIndex = ((this._promoPoolIndex == (this._promoPool.length - 1)) ? 0 : (this._promoPoolIndex + 1));
                                        labelOldOneClick.text = data.article.prices[i].original_price;
                                        labelOldOneClick.fullWidthAndHeight();
                                        labelOldOneClick.removeTooltipExtension();
                                        labelOldOneClick.textfield.width = labelOldOneClick.width;
                                        labelOldOneClick.x = ((labelOneClick.x - labelOldOneClick.textWidth) - 13);
                                        labelOldOneClick.graphics.clear();
                                        labelOldOneClick.graphics.beginFill(this.sysApi.getConfigEntry("colors.shop.oldPrice"));
                                        labelOldOneClick.graphics.drawRect(0, ((labelOldOneClick.height / 2) - 3), (labelOldOneClick.textWidth + 2), 1);
                                        labelOldOneClick.graphics.endFill();
                                    }
                                    else
                                    {
                                        labelOldOneClick.text = "";
                                        labelOldOneClick.graphics.clear();
                                    };
                                };
                            };
                        };
                        i++;
                    };
                };
                if (componentsRef.ctr_largeArticleSlot)
                {
                    if (hasOneClickPrice)
                    {
                        btnBuyOneClick.visible = true;
                        oneClickBg.visible = true;
                        slot.height = 245;
                        if (hasOgrinePrice)
                        {
                            btnBuy.visible = true;
                            buyBg.visible = true;
                        }
                        else
                        {
                            oneClickBg.x = buyBg.x;
                            oneClickBg.y = buyBg.y;
                            oneClickBg.width = 333;
                            btnBuyOneClick.x = btnBuy.x;
                            btnBuyOneClick.y = btnBuy.y;
                            btnBuyOneClick.width = 320;
                            componentsRef.tx_largeArticleOneClickImageOver.width = 320;
                            labelOneClick.fullWidthAndHeight();
                            labelOneClick.removeTooltipExtension();
                            labelOneClick.textfield.width = labelOneClick.width;
                            labelOneClick.x = ((oneClickBg.x + (oneClickBg.width / 2)) - (labelOneClick.width / 2));
                            if (labelOldOneClick.text)
                            {
                                labelOldOneClick.x = ((labelOneClick.x - labelOldOneClick.textWidth) - 13);
                                labelOldOneClick.graphics.clear();
                                labelOldOneClick.graphics.beginFill((labelOldOneClick.textFormat.color as uint));
                                labelOldOneClick.graphics.drawRect(0, ((labelOldOneClick.height / 2) - 3), labelOldOneClick.width, 1);
                                labelOldOneClick.graphics.endFill();
                            };
                        };
                        btnCat.y = 245;
                    }
                    else
                    {
                        if (hasOgrinePrice)
                        {
                            slot.height = 245;
                            btnBuy.visible = true;
                            buyBg.visible = true;
                            btnBuy.width = 320;
                            componentsRef.tx_largeArticlePriceImageOver.width = 320;
                            buyBg.width = 333;
                            labelPrice.fullWidthAndHeight();
                            labelPrice.removeTooltipExtension();
                            labelPrice.textfield.width = labelPrice.width;
                            labelPrice.x = (((buyBg.x + (buyBg.width / 2)) - (labelPrice.width / 2)) - 15);
                            componentsRef.tx_ogrinesPriceIconLargeArticle.x = ((labelPrice.x + labelPrice.width) + 5);
                            if (labelOldPrice.text)
                            {
                                labelOldPrice.x = ((labelPrice.x - labelOldPrice.textWidth) - 13);
                                labelOldPrice.graphics.clear();
                                labelOldPrice.graphics.beginFill((labelOldPrice.textFormat.color as uint));
                                labelOldPrice.graphics.drawRect(0, ((labelOldPrice.height / 2) - 3), labelOldPrice.width, 1);
                                labelOldPrice.graphics.endFill();
                            };
                            btnCat.y = ((btnBuy.y + btnBuy.height) + 1);
                            btnCat.y = 245;
                        }
                        else
                        {
                            slot.height = 220;
                            btnCat.y = 220;
                        };
                    };
                }
                else
                {
                    if (hasOneClickPrice)
                    {
                        btnBuyOneClick.visible = true;
                        oneClickBg.visible = true;
                        if (hasOgrinePrice)
                        {
                            slot.height = 245;
                            btnBuy.visible = true;
                            buyBg.visible = true;
                            componentsRef.ctr_oneClickBuy.y = 220;
                            btnCat.y = 245;
                        }
                        else
                        {
                            slot.height = 220;
                            componentsRef.ctr_oneClickBuy.y = 193;
                            btnCat.y = 220;
                        };
                    }
                    else
                    {
                        btnBuyOneClick.visible = false;
                        oneClickBg.visible = false;
                        if (hasOgrinePrice)
                        {
                            slot.height = 220;
                            btnBuy.visible = true;
                            buyBg.visible = true;
                            btnCat.y = 220;
                        }
                        else
                        {
                            slot.height = 195;
                            btnCat.y = 195;
                        };
                    };
                };
                btn.name = (("btn_article_" + data.article.id) + data.cat);
                if (!this._compHookData[btn.name])
                {
                    this._compHookData[btn.name] = data;
                };
                this.uiApi.addComponentHook(btn, ComponentHookList.ON_RELEASE);
                this.uiApi.addComponentHook(btn, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(btn, ComponentHookList.ON_ROLL_OUT);
                btnBuy.name = (("btn_buy_" + data.article.id) + data.cat);
                if (!this._compHookData[btnBuy.name])
                {
                    this._compHookData[btnBuy.name] = data;
                };
                btnBuyOneClick.name = (("btn_buyOneClick_" + data.article.id) + data.cat);
                if (!this._compHookData[btnBuyOneClick.name])
                {
                    this._compHookData[btnBuyOneClick.name] = data;
                };
                this.uiApi.addComponentHook(btnBuy, ComponentHookList.ON_RELEASE);
                this.uiApi.addComponentHook(btnBuy, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(btnBuy, ComponentHookList.ON_ROLL_OUT);
                this.uiApi.addComponentHook(btnBuyOneClick, ComponentHookList.ON_RELEASE);
                this.uiApi.addComponentHook(btnBuyOneClick, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(btnBuyOneClick, ComponentHookList.ON_ROLL_OUT);
                if (((!(data.article is DofusShopHighlight)) && (data.article.category)))
                {
                    btnCat.name = (("btn_cat_" + data.article.id) + data.cat);
                    if (!this._compHookData[btnCat.name])
                    {
                        this._compHookData[btnCat.name] = data.article.category;
                    };
                    this.uiApi.addComponentHook(btnCat, ComponentHookList.ON_RELEASE);
                    this.uiApi.addComponentHook(btnCat, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(btnCat, ComponentHookList.ON_ROLL_OUT);
                };
            }
            else
            {
                if (componentsRef)
                {
                    if (componentsRef.ctr_articleSlot)
                    {
                        componentsRef.ctr_articleSlot.visible = false;
                    };
                    if (componentsRef.ctr_largeArticleSlot)
                    {
                        componentsRef.ctr_largeArticleSlot.visible = false;
                    };
                };
            };
        }

        public function getSlotType(data:*, line:uint):String
        {
            if (((data) && (data.article)))
            {
                if (data.isLarge)
                {
                    return ("ctr_largeArticleSlot" + data.nameExtension);
                };
                return ("ctr_articleSlot" + data.nameExtension);
            };
            return ("ctr_emptySlot" + this._lastNameExtension);
        }

        public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint):void
        {
            switch (this.getCatLineType(data, line))
            {
                case CTR_CAT_TYPE_CAT:
                case CTR_CAT_TYPE_SUBCAT:
                case CTR_CAT_TYPE_SUBSUBCAT:
                    componentsRef.lbl_catName.text = data.name;
                    componentsRef.btn_cat.selected = selected;
                    if (((data.img) && (data.img.length > 0)))
                    {
                        componentsRef.tx_catImage.uri = this.uiApi.createUri(data.img);
                    }
                    else
                    {
                        componentsRef.tx_catImage.uri = this.uiApi.createUri(this.uiApi.me().getConstant("news_uri"));
                    };
                    break;
            };
        }

        public function getCatLineType(data:*, line:uint):String
        {
            if (!data)
            {
                return ("");
            };
            if (((data) && (data.level == 0)))
            {
                return (CTR_CAT_TYPE_CAT);
            };
            if (((data) && (data.level == 1)))
            {
                return (CTR_CAT_TYPE_SUBCAT);
            };
            if (((data) && (data.level == 2)))
            {
                return (CTR_CAT_TYPE_SUBSUBCAT);
            };
            return (CTR_CAT_TYPE_SUBCAT);
        }

        public function getCatDataLength(data:*, selected:Boolean):*
        {
            return (2 + ((selected) ? data.subcats.length : 0));
        }

        private function freeFanion(tx:Texture):void
        {
            var pool:Vector.<Texture> = ((this._promoPool.indexOf(tx) >= 0) ? this._promoPool : this._newPool);
            var poolIndex:int = pool.indexOf(tx);
            if (((pool == this._promoPool) && (poolIndex < this._promoPoolIndex)))
            {
                this._promoPoolIndex--;
            }
            else
            {
                if (((pool == this._newPool) && (poolIndex < this._newPoolIndex)))
                {
                    this._newPoolIndex--;
                };
            };
            pool.insertAt(((pool == this._promoPool) ? this._promoPoolIndex : this._newPoolIndex), pool.removeAt(poolIndex));
        }

        private function addFanionPromo():void
        {
            var promoTexture:Texture;
            if (this._promoPool.length < MAX_FANION_POOL_SIZE)
            {
                promoTexture = new Texture();
                promoTexture.finalized = true;
                promoTexture.uri = this.uiApi.createUri(this.uiApi.me().getConstant("fanions_uri_promo"));
                promoTexture.width = 150;
                promoTexture.height = 150;
                promoTexture.x = 0;
                promoTexture.y = 0;
                this._promoPool.push(promoTexture);
            };
        }

        private function addFanionNew():void
        {
            var newTexture:Texture;
            if (this._newPool.length < MAX_FANION_POOL_SIZE)
            {
                newTexture = new Texture();
                newTexture.finalized = true;
                newTexture.uri = this.uiApi.createUri(this.uiApi.me().getConstant(("fanions_uri_" + this.sysApi.getConfigEntry("config.lang.current"))));
                newTexture.width = 150;
                newTexture.height = 150;
                newTexture.x = 0;
                newTexture.y = 0;
                this._newPool.push(newTexture);
            };
        }

        private function getCatName(cat:int):String
        {
            var tempCat:Object;
            for each (tempCat in this.gd_categories.dataProvider)
            {
                if (tempCat.id == cat)
                {
                    return (tempCat.name);
                };
            };
            return ("");
        }

        private function getShopArticle(dsa:*):ShopArticle
        {
            var sa:ShopArticle;
            var i:int;
            var ref:DofusShopArticleReference;
            var prom:Object;
            var gift:Object;
            var action:Object;
            var newItem:ItemWrapper;
            var newEffects:Vector.<EffectInstance>;
            var ei:EffectInstanceDice;
            var effectInstance:EffectInstance;
            var effect:EffectInstance;
            var item:*;
            var isCompanion:Boolean;
            sa = new ShopArticle(((dsa is DofusShopArticle) ? dsa : null));
            if (!dsa)
            {
                return (sa);
            };
            sa.name = dsa.name;
            if ((dsa is DofusShopHighlight))
            {
                sa.isLarge = true;
                sa.imageUri = dsa.image[(dsa.image.length - 1)].url;
                if (dsa.type == DofusShopEnum.HIGHLIGHT_TYPE_CATEGORY)
                {
                    sa.article = dsa;
                    sa.type = ShopArticleTypeEnum.CATEGORY;
                    return (sa);
                };
                dsa.external.subtitle = dsa.description;
                sa.article = dsa.external;
            }
            else
            {
                if (((dsa.imageNormal) && (dsa.imageNormal.length > 0)))
                {
                    sa.imageUri = dsa.imageNormal;
                }
                else
                {
                    if (((dsa.imageSmall) && (dsa.imageSmall.length > 0)))
                    {
                        sa.imageUri = dsa.imageSmall;
                    }
                    else
                    {
                        if (dsa.imageSwf)
                        {
                            sa.imageUri = dsa.imageSwf.uri;
                        };
                    };
                };
            };
            if (sa.article.promo.length > 0)
            {
                for each (prom in sa.article.promo)
                {
                    for each (gift in prom.gifts)
                    {
                        sa.article.gids = sa.article.gids.concat(this.getShopArticle(this.dataApi.createDofusShopArticle(gift)).article.gids);
                    };
                };
            };
            i = 0;
            while (i < sa.article.gids.length)
            {
                if (sa.article.gids.indexOf(sa.article.gids[i]) == i)
                {
                    sa.items.push(this.dataApi.getItemWrapper(sa.article.gids[i], 0, 0, 1));
                };
                i++;
            };
            for each (ref in sa.article.references)
            {
                if (((((ref.type.toUpperCase() == VIRTUALSUBSCRIPTION_TYPE) || (ref.type == HAVENBAG_TYPE)) || (ref.type == HAVENBAG_ROOM_TYPE)) || (ref.type == KARD_TYPE)))
                {
                    sa.items.insertAt(sa.article.promo.length, ref);
                }
                else
                {
                    if (ref.type.toUpperCase() == GAMEACTION_TYPE)
                    {
                        for each (action in ref.actions)
                        {
                            newItem = this.dataApi.getItemWrapper(action.item_id, 0, 0, action.quantity, null);
                            sa.article.gids.push(newItem.objectGID);
                            if (action.bond)
                            {
                                newEffects = new Vector.<EffectInstance>();
                                ei = new EffectInstanceDice();
                                ei["effectId"] = 983;
                                this.dataApi.setEffectInstanceParameters(ei, 2, ((action.bond > 0) ? action.bond : null));
                                for each (effectInstance in newItem.possibleEffects)
                                {
                                    if (effectInstance.effectId != 983)
                                    {
                                        newEffects.push(effectInstance);
                                    };
                                };
                                newEffects.push(ei);
                                newItem["possibleEffects"] = newEffects;
                            };
                            sa.items.insertAt(sa.article.promo.length, newItem);
                        };
                    };
                };
            };
            if (((sa.items[0]) && (sa.items.length == 1)))
            {
                sa.quantity = ((sa.article.references.length > 0) ? sa.article.references[0].quantity : sa.items[0].quantity);
                if (!(sa.items[0] is ItemWrapper))
                {
                    if (sa.items[0].type == VIRTUALSUBSCRIPTION_TYPE)
                    {
                        sa.type = ShopArticleTypeEnum.SUBSCRIPTION;
                    }
                    else
                    {
                        if (sa.items[0].type == HAVENBAG_TYPE)
                        {
                            sa.type = ShopArticleTypeEnum.HAVENBAG;
                        }
                        else
                        {
                            if (sa.items[0].type == KARD_TYPE)
                            {
                                sa.type = ShopArticleTypeEnum.MYSTERY_BOX;
                            };
                        };
                    };
                    return (sa);
                };
                for each (effect in sa.items[0].possibleEffects)
                {
                    switch (effect.effectId)
                    {
                        case ActionIds.ACTION_CHARACTER_LEARN_EMOTICON:
                            sa.type = ShopArticleTypeEnum.EMOTE;
                            break;
                        case ActionIds.ACTION_SET_COMPANION:
                            sa.type = ShopArticleTypeEnum.COMPANION;
                            break;
                        case ActionIds.ACTION_CHARACTER_LEARN_FINISH_MOVE:
                            sa.type = ShopArticleTypeEnum.FINISHMOVE;
                            break;
                    };
                };
                if (sa.type == ShopArticleTypeEnum.UNKNOWN)
                {
                    if (((sa.items[0].isHarness) || (sa.items[0].typeId == DataEnum.ITEM_TYPE_CEREMONIAL_ITEMS)))
                    {
                        sa.type = ShopArticleTypeEnum.HARNESS;
                    }
                    else
                    {
                        if (this.dataApi.getItem(sa.items[0].id).type.id == DataEnum.ITEM_TYPE_LIVING_OBJECT)
                        {
                            sa.type = ShopArticleTypeEnum.LIVINGOBJECT;
                        }
                        else
                        {
                            if (sa.items[0].type.id == DataEnum.ITEM_TYPE_HAVENBAG)
                            {
                                sa.type = ShopArticleTypeEnum.HAVENBAG;
                            }
                            else
                            {
                                if (this.dataApi.getItem(sa.items[0].id).type.superTypeId == DataEnum.ITEM_SUPERTYPE_CONSUMABLE)
                                {
                                    sa.type = ShopArticleTypeEnum.CONSUMABLE;
                                };
                            };
                        };
                    };
                };
            }
            else
            {
                if (sa.items.length > 0)
                {
                    sa.type = ShopArticleTypeEnum.COMPANION_PACK;
                    for each (item in sa.items)
                    {
                        if (((!(item is ItemWrapper)) && ((item.type == VIRTUALSUBSCRIPTION_TYPE) || (item.type == KARD_TYPE))))
                        {
                            sa.type = ShopArticleTypeEnum.PACK;
                            break;
                        };
                        isCompanion = false;
                        for each (effect in sa.items[0].possibleEffects)
                        {
                            if (effect.effectId == ActionIds.ACTION_SET_COMPANION)
                            {
                                isCompanion = true;
                                break;
                            };
                        };
                        if (!isCompanion)
                        {
                            sa.type = ShopArticleTypeEnum.ITEMSET;
                        };
                        if (((!(item.isEquipment)) || (item.isHarness)))
                        {
                            sa.type = ShopArticleTypeEnum.PACK;
                            break;
                        };
                    };
                };
            };
            return (sa);
        }

        private function resizeLabels():void
        {
            this.lbl_subscribed.fullWidthAndHeight(0, 7);
            this.lbl_linkedOgrinesAmount.fullWidthAndHeight();
            this.lbl_linked.fullWidthAndHeight();
            this.lbl_subscriptionLink.fullWidthAndHeight();
        }

        private function displaySubscriptionMessage():void
        {
            var playerManager:* = this.sysApi.getPlayerManager();
            if (playerManager.subscriptionEndDate > 0)
            {
                this.lbl_subscribed.text = this.uiApi.getText("ui.bak.subscribed", this.timeApi.getDate(playerManager.subscriptionEndDate));
                if (playerManager.subscriptionEndDate > 172800000)
                {
                    this.tx_subscriptionExpire.width = 0;
                    this.lbl_subscriptionLink.visible = false;
                }
                else
                {
                    this.tx_subscriptionExpire.width = 25;
                    this.lbl_subscriptionLink.visible = true;
                };
            }
            else
            {
                this.lbl_subscribed.text = this.uiApi.getText("ui.bak.notSubscribed");
                this.tx_subscriptionExpire.width = 0;
                this.lbl_subscriptionLink.visible = true;
            };
        }

        private function loadCloseCategories(cat:Object):void
        {
            var index:int;
            var tempCat:Object;
            var i:int;
            for each (tempCat in this.gd_categories.dataProvider)
            {
                if (tempCat.id == cat.id)
                {
                    index = this.gd_categories.dataProvider.indexOf(tempCat);
                    break;
                };
            };
            i = (index - 3);
            while (i <= (index + 3))
            {
                if (((((i >= 1) && (i < this.gd_categories.dataProvider.length)) && (this.gd_categories.dataProvider[i].subcats.length == 0)) && (this._loadedCategories.indexOf(this.gd_categories.dataProvider[i].id) == -1)))
                {
                    this.sysApi.sendAction(new ShopArticlesListRequest(this.gd_categories.dataProvider[i].id));
                    this._loadedCategories.push(this.gd_categories.dataProvider[i].id);
                };
                i++;
            };
        }

        private function displayCategory(selectedCategory:Object=null):void
        {
            var line:*;
            this.resetSearch();
            this.loadCloseCategories(selectedCategory);
            for (line in this.gd_categoriesArticles.dataProvider)
            {
                if (((this.gd_categoriesArticles.dataProvider[line].hasOwnProperty("id")) && (this.gd_categoriesArticles.dataProvider[line].id == selectedCategory.id)))
                {
                    this.gd_categoriesArticles.moveTo(line, true);
                    break;
                };
            };
        }

        private function displayArticleTooltip(target:Object):void
        {
            this._tooltipTimer.delay = ((this._tooltipCount > 0) ? 50 : 500);
            var shopArticle:ShopArticle = this._compHookData[target.name];
            this._tooltipTarget = target;
            this._shopArticle = shopArticle;
            if (((shopArticle) && ((shopArticle.items.length == 0) || ((shopArticle.items.length >= (this._tooltipCount + 1)) && (shopArticle.items[this._tooltipCount])))))
            {
                if (shopArticle.type == ShopArticleTypeEnum.MYSTERY_BOX)
                {
                    this._tooltipTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.displayMysteryBoxTooltip);
                }
                else
                {
                    if ((shopArticle.items[this._tooltipCount] is ItemWrapper))
                    {
                        if (this.sysApi.getOption("itemTooltipDelay", "dofus") > 0)
                        {
                            this._tooltipTimer.delay = 50;
                        };
                        this._tooltipTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.displayItemTooltip);
                    }
                    else
                    {
                        this._tooltipTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.displayGenericTooltip);
                    };
                };
                this._tooltipTimer.start();
            };
        }

        private function displayMysteryBoxTooltip(e:TimerEvent):void
        {
            this._tooltipTimer.reset();
            this._tooltipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.displayMysteryBoxTooltip);
            var globalPosition:* = this._tooltipTarget["localToGlobal"](new Point(0, 0));
            var probaObject:Object = {
                "name":this._shopArticle.article.name,
                "icon":this._shopArticle.imageUri,
                "probas":this.createProbaObject(this._shopArticle.items[0].kards)
            };
            this.uiApi.showTooltip(probaObject, this._tooltipTarget, false, "standard", ((globalPosition.x > 200) ? LocationEnum.POINT_TOPRIGHT : LocationEnum.POINT_TOPLEFT), ((globalPosition.x > 200) ? LocationEnum.POINT_TOPLEFT : LocationEnum.POINT_TOPRIGHT), 20, "mysteryBox", null, {
                "showProba":true,
                "sortInBlocks":true,
                "description":this._shopArticle.article.description
            });
        }

        private function displayItemTooltip(e:TimerEvent):void
        {
            this._tooltipTimer.reset();
            this._tooltipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.displayItemTooltip);
            var globalPosition:* = this._tooltipTarget["localToGlobal"](new Point(0, 0));
            this.uiApi.showTooltip(this._shopArticle.items[this._tooltipCount], this._tooltipTarget, false, "standard", ((globalPosition.x > 200) ? LocationEnum.POINT_TOPRIGHT : LocationEnum.POINT_TOPLEFT), ((globalPosition.x > 200) ? LocationEnum.POINT_TOPLEFT : LocationEnum.POINT_TOPRIGHT), 20, "item", null, {
                "showEffects":true,
                "rightText":((this._shopArticle.items.length > 1) ? this.uiApi.getText("ui.tooltip.swapItem") : "")
            });
        }

        private function displayGenericTooltip(e:TimerEvent):void
        {
            this._tooltipTimer.reset();
            this._tooltipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.displayGenericTooltip);
            var globalPosition:* = this._tooltipTarget["localToGlobal"](new Point(0, 0));
            var txt:String = "";
            if (this._shopArticle.items[this._tooltipCount])
            {
                txt = (txt + (("<b>" + this._shopArticle.items[this._tooltipCount].name) + "</b>\n"));
                txt = (txt + this._shopArticle.items[this._tooltipCount].description);
                if (this._shopArticle.items.length > 1)
                {
                    txt = (txt + ("\n" + this.uiApi.getText("ui.tooltip.swapItem")));
                };
            };
            if (!txt)
            {
                txt = (txt + (("<b>" + this._shopArticle.article.name) + "</b>\n"));
                if (this._shopArticle.article.description)
                {
                    txt = (txt + this._shopArticle.article.description);
                };
            };
            if (txt)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt), this._tooltipTarget, false, "standard", ((globalPosition.x > 200) ? LocationEnum.POINT_TOPRIGHT : LocationEnum.POINT_TOPLEFT), ((globalPosition.x > 200) ? LocationEnum.POINT_TOPLEFT : LocationEnum.POINT_TOPRIGHT), 20, null, null, null, "TextInfo");
            };
        }

        private function createProbaObject(data:Array):Array
        {
            var kard:Object;
            var internalFunc:Function;
            var res:Array = [];
            for each (kard in data)
            {
                res.push({
                    "name":kard.kard.name,
                    "proba":kard.probability,
                    "rarity":kard.rarity,
                    "showProba":true
                });
            };
            internalFunc = function (kard1:Object, kard2:Object):int
            {
                if (kard1.proba > kard2.proba)
                {
                    return (1);
                };
                if (kard1.proba < kard2.proba)
                {
                    return (-1);
                };
                return (0);
            };
            res.sort(internalFunc);
            return (res);
        }

        private function displayArticle(shopArticle:ShopArticle):void
        {
            var price:Object;
            if (!(shopArticle.article is DofusShopHighlight))
            {
                this.sysApi.dispatchHook(DofusShopCurrentSelectedArticle, shopArticle.article, true, this._navigationType);
            };
            var params:Object = new Object();
            params.article = shopArticle;
            params.tokens = this._oneClickTokens;
            params.moneyOgr = this._moneyOgr;
            switch (shopArticle.type)
            {
                case ShopArticleTypeEnum.COMPANION:
                    this.uiApi.loadUi("shopPopupCompanion", "shopPopup", params, StrataEnum.STRATA_TOP, null, true);
                    return;
                case ShopArticleTypeEnum.EMOTE:
                    this.uiApi.loadUi("shopPopupAttitude", "shopPopup", params, StrataEnum.STRATA_TOP, null, true);
                    return;
                case ShopArticleTypeEnum.FINISHMOVE:
                    this.uiApi.loadUi("shopPopupFinishMove", "shopPopup", params, StrataEnum.STRATA_TOP, null, true);
                    return;
                case ShopArticleTypeEnum.HARNESS:
                    this.uiApi.loadUi("shopPopupHarness", "shopPopup", params, StrataEnum.STRATA_TOP, null, true);
                    return;
                case ShopArticleTypeEnum.ITEMSET:
                    this.uiApi.loadUi("shopPopupItemSet", "shopPopup", params, StrataEnum.STRATA_TOP, null, true);
                    return;
                case ShopArticleTypeEnum.LIVINGOBJECT:
                    this.uiApi.loadUi("shopPopupLivingObject", "shopPopup", params, StrataEnum.STRATA_TOP, null, true);
                    return;
                case ShopArticleTypeEnum.HAVENBAG:
                    this.uiApi.loadUi("shopPopupHavenBag", "shopPopup", params, StrataEnum.STRATA_TOP, null, true);
                    return;
                case ShopArticleTypeEnum.PACK:
                    this.uiApi.loadUi("shopPopupPack", "shopPopup", params, StrataEnum.STRATA_TOP, null, true);
                    return;
                case ShopArticleTypeEnum.MYSTERY_BOX:
                    this.uiApi.loadUi("shopPopupMysteryBox", "shopPopup", params, StrataEnum.STRATA_TOP, null, true);
                    break;
                case ShopArticleTypeEnum.SUBSCRIPTION:
                case ShopArticleTypeEnum.UNKNOWN:
                case ShopArticleTypeEnum.CONSUMABLE:
                    if (shopArticle.article.prices.length == 0)
                    {
                        return;
                    };
                    for each (price in shopArticle.article.prices)
                    {
                        if (price.currency == DofusShopEnum.CURRENCY_OGRINES)
                        {
                            this.uiApi.loadUi("shopPopupConfirmBuy", "shopPopupConfirmBuy", params, StrataEnum.STRATA_TOP, null, true);
                            return;
                        };
                    };
                    if (this._oneClickTokens.length == 0)
                    {
                        this.uiApi.loadUi("shopPopupOneClickRegister", "shopPopupOneClickRegister", params, StrataEnum.STRATA_TOP, null, true);
                    }
                    else
                    {
                        this.uiApi.loadUi("shopPopupOneClickPayment", "shopPopupOneClickPayment", params, StrataEnum.STRATA_TOP, null, true);
                    };
                    return;
                case ShopArticleTypeEnum.COMPANION_PACK:
                    this.uiApi.loadUi("shopPopupCompanionPack", "shopPopup", params, StrataEnum.STRATA_TOP, null, true);
                    return;
                case ShopArticleTypeEnum.CATEGORY:
                    this.goToCategory(shopArticle.article.external.id);
                    break;
            };
        }

        private function goToCategory(catId:int):void
        {
            var cat:*;
            for each (cat in this.gd_categories.dataProvider)
            {
                if (cat.id == catId)
                {
                    this.gd_categories.selectedItem = cat;
                    return;
                };
            };
            if (catId == DofusShopEnum.OGRINES_CATEGORY_ID)
            {
                this.sysApi.goToUrl(this.uiApi.getText("ui.link.buyOgrine"));
            };
        }

        private function resetSearch():void
        {
            if (this.gd_categoriesArticles.dataProvider != this._allArticlesDatas)
            {
                this.gd_categoriesArticles.dataProvider = this._allArticlesDatas;
            };
            this._searchCriteria = null;
            this._searchTimer.reset();
            this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
            this.btn_resetSearch.visible = false;
        }

        private function copyObject(o:*):*
        {
            var tempObject:ByteArray = new ByteArray();
            tempObject.writeObject(o);
            tempObject.position = 0;
            return (tempObject.readObject());
        }

        public function onScroll(e:Event):void
        {
            var cat:*;
            this._tooltipTimer.reset();
            if (this.gd_categoriesArticles.dataProvider == this._searchDatas)
            {
                return;
            };
            this._tooltipTarget = null;
            var tempIndex:int = this.gd_categoriesArticles.scrollBarV.value;
            while (this.getLineType(this.gd_categoriesArticles.dataProvider[tempIndex], 0).indexOf("Slot") < 0)
            {
                tempIndex--;
            };
            var tempId:int = this.gd_categoriesArticles.dataProvider[tempIndex].id;
            for each (cat in this.gd_categories.dataProvider)
            {
                if (((cat.id == tempId) && (!(this.gd_categories.selectedItem.id == cat.id))))
                {
                    this._navigationType = DofusShopEnum.NAVIGATION_SCROLL;
                    this.gd_categories.setSelectedIndex(this.gd_categories.dataProvider.indexOf(cat), GridItemSelectMethodEnum.AUTO);
                    this.loadCloseCategories(this.gd_categories.dataProvider[this.gd_categories.selectedIndex]);
                };
            };
        }

        public function onGenericMouseClick(target:Object):void
        {
            var targetTemp:Object = target;
            while (((targetTemp) && (!(targetTemp.hasOwnProperty("getUi")))))
            {
                targetTemp = targetTemp.parent;
            };
            if (((targetTemp) && (targetTemp.getUi().name == "webShop")))
            {
                this.uiApi.unloadUi("shopPopup");
            };
        }

        public function onRelease(target:Object):void
        {
            var oldNavigationType:uint;
            var cat:Object;
            var params:Object;
            var catTemp:*;
            this._tooltipTimer.reset();
            this._tooltipTarget = null;
            switch (target)
            {
                case this.btn_gotToSubscriptions:
                    this.goToCategory(DofusShopEnum.SUBSCRIPTION_CATEGORY_ID);
                    break;
                case this.btn_resetSearch:
                    this.resetSearch();
                    break;
                case this.btn_buyOgrins:
                    for each (cat in this.gd_categories.dataProvider)
                    {
                        if (cat.id == DofusShopEnum.OGRINES_CATEGORY_ID)
                        {
                            this.goToCategory(DofusShopEnum.OGRINES_CATEGORY_ID);
                            return;
                        };
                    };
                    this.sysApi.goToUrl(this.sysApi.getConfigEntry("config.shopOgrinesUrl"));
                    break;
                default:
                    oldNavigationType = this._navigationType;
                    if (((this.gd_categoriesArticles.dataProvider[1]) && (!(this.gd_categoriesArticles.dataProvider[1].indexOf(this._compHookData[target.name]) == -1))))
                    {
                        this._navigationType = DofusShopEnum.NAVIGATION_GONDOLAHEAD;
                    };
                    if (target.name.indexOf("btn_article") != -1)
                    {
                        this.displayArticle(this._compHookData[target.name]);
                    }
                    else
                    {
                        if (target.name.indexOf("btn_buy") != -1)
                        {
                            params = new Object();
                            params.article = this._compHookData[target.name];
                            params.moneyOgr = this._moneyOgr;
                            if (target.name.indexOf("btn_buyOneClick") == -1)
                            {
                                this.sysApi.dispatchHook(DofusShopDirectBuyClick, params.article.article, false, this._navigationType);
                                this.uiApi.loadUi("shopPopupConfirmBuy", "shopPopupConfirmBuy", params, StrataEnum.STRATA_TOP, null, true);
                            }
                            else
                            {
                                this.sysApi.dispatchHook(DofusShopDirectBuyClick, params.article.article, true, this._navigationType);
                                if (this._oneClickTokens.length == 0)
                                {
                                    this.uiApi.loadUi("shopPopupOneClickRegister", "shopPopupOneClickRegister", params, StrataEnum.STRATA_TOP, null, true);
                                }
                                else
                                {
                                    params.tokens = this._oneClickTokens;
                                    this.uiApi.loadUi("shopPopupOneClickPayment", "shopPopupOneClickPayment", params, StrataEnum.STRATA_TOP, null, true);
                                };
                            };
                        }
                        else
                        {
                            if (target.name.indexOf("btn_cat") != -1)
                            {
                                this._navigationType = DofusShopEnum.NAVIGATION_CATEGORY_GONDOLAHEAD;
                                for each (catTemp in this.gd_categories.dataProvider)
                                {
                                    if (catTemp.id == this._compHookData[target.name])
                                    {
                                        this.gd_categories.setSelectedIndex(this.gd_categories.dataProvider.indexOf(catTemp), GridItemSelectMethodEnum.AUTO);
                                        this.displayCategory(catTemp);
                                        return;
                                    };
                                };
                            };
                        };
                    };
                    this._navigationType = oldNavigationType;
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            var msDiff:int;
            var ogrines:Object;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            var offset:int = 3;
            switch (target)
            {
                case this.ctr_ogrinesAmount:
                    text = this.uiApi.getText("ui.bak.ogrinesTotalAmount");
                    break;
                case this.tx_ogrinesExpire:
                    if (this._expiringOgrines.length == 0)
                    {
                        text = ((this.uiApi.getText("ui.bak.linkedOgrines") + "<br/><br/>") + this.uiApi.getText("ui.bak.linkedOgrinesNotExpiring"));
                    }
                    else
                    {
                        text = (((this.uiApi.getText("ui.bak.linkedOgrines") + "<br/><br/>") + this.uiApi.getText("ui.bak.linkedOgrinesExpiring")) + "<br/>");
                        for each (ogrines in this._expiringOgrines)
                        {
                            msDiff = (Date.parse((ogrines.date_expiration.replace(/-/g, "/") + " GMT+0200")) - new Date().valueOf());
                        };
                        text = (text + ((((((((("<br/>" + ogrines.amount_left.toString()) + " ") + this.uiApi.getText("ui.bak.ogrinesExpireValue")) + " ") + ((Math.ceil((msDiff / 86400000)) <= 1) ? "" : ((Math.ceil((msDiff / 86400000)) - 1) + this.uiApi.getText("ui.time.short.day")))) + " ") + ((Math.ceil(((msDiff % 86400000) / 3600000)) <= 1) ? "" : ((Math.ceil(((msDiff % 86400000) / 3600000)) - 1) + this.uiApi.getText("ui.time.short.hour")))) + " ") + ((Math.ceil(((msDiff % 3600000) / 60000)) <= 1) ? "" : ((Math.ceil(((msDiff % 3600000) / 60000)) - 1) + this.uiApi.getText("ui.time.short.minute")))));
                    };
                    break;
                case this.tx_subscriptionExpire:
                    text = this.uiApi.getText("ui.bak.subscriptionExpire");
                    break;
                case this.btn_buyOgrins:
                    text = this.uiApi.getText("ui.shop.buyOgrines");
                    break;
                case this.btn_resetSearch:
                    text = this.uiApi.getText("ui.search.clear");
                    break;
                case this.lbl_currentOgrines:
                    pos = {
                        "point":LocationEnum.POINT_BOTTOMRIGHT,
                        "relativePoint":LocationEnum.POINT_TOPRIGHT
                    };
                    offset = 0;
                    text = this.uiApi.getText("ui.shop.ownedOgrines");
                    break;
                default:
                    if (target.name.indexOf("btn_article") != -1)
                    {
                        if (this._compHookData[target.name])
                        {
                            this._tooltipCount = 0;
                            this.displayArticleTooltip(target);
                        };
                    }
                    else
                    {
                        if (target.name.indexOf("btn_buy") != -1)
                        {
                            text = this.uiApi.getText("ui.common.buy");
                        };
                    };
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, offset, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
            this._tooltipTimer.reset();
            this._tooltipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.displayItemTooltip);
            this._tooltipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.displayGenericTooltip);
            this._tooltipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.displayMysteryBoxTooltip);
            if (this._tooltipTarget)
            {
                this._tooltipTarget = null;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (selectMethod != GridItemSelectMethodEnum.AUTO)
            {
                if (target == this.gd_categories)
                {
                    this._navigationType = DofusShopEnum.NAVIGATION_CATEGORY_GRID;
                    this.displayCategory(target.selectedItem);
                };
            };
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            if (item.data)
            {
                this.modContextMenu.createContextMenu(this.menuApi.create(item.data.items[0], "item"));
            };
        }

        private function onSearchTimer(r:TimerEvent=null):void
        {
            this.sysApi.sendAction(new ShopSearchRequest(this._searchCriteria));
            this._searchTimer.reset();
        }

        private function onKeyUp(target:Object, keyCode:uint):void
        {
            if (((this.inp_search.haveFocus) && (!(this.inp_search.text == this.INPUT_SEARCH_DEFAULT_TEXT))))
            {
                if (this.inp_search.text.length)
                {
                    this._searchCriteria = this.inp_search.text;
                    this._searchTimer.start();
                    this.btn_resetSearch.visible = true;
                }
                else
                {
                    if (this._searchCriteria)
                    {
                        this.resetSearch();
                    };
                };
            }
            else
            {
                if (((keyCode == KEY_GREATER_THAN) && (this._tooltipTarget)))
                {
                    if (this._tooltipCount == (this._compHookData[this._tooltipTarget.name].items.length - 1))
                    {
                        this._tooltipCount = 0;
                    }
                    else
                    {
                        this._tooltipCount++;
                    };
                    this.displayArticleTooltip(this._tooltipTarget);
                };
            };
        }

        private function findCategoryById(catId:int, grid:Grid):Object
        {
            var line:Object;
            for each (line in grid.dataProvider)
            {
                if (((line.hasOwnProperty("id")) && (line.id == catId)))
                {
                    return (line);
                };
            };
            return (null);
        }

        private function onDofusShopLinkedOgrines(ogrinesList:Object):void
        {
            var ogrines:Object;
            this._linkedOgrinesAmount = 0;
            this._expiringOgrines = [];
            for each (ogrines in ogrinesList)
            {
                if (ogrines.forbidden_usages != "")
                {
                    this._linkedOgrinesAmount = (this._linkedOgrinesAmount + parseInt(ogrines.amount_left, 10));
                    if (((ogrines.date_expiration) && ((new Date(Date.parse((ogrines.date_expiration.replace(/-/g, "/") + " GMT+0200"))).valueOf() - new Date().valueOf()) < 0x240C8400)))
                    {
                        this._expiringOgrines.push(ogrines);
                    };
                };
            };
            if (this._linkedOgrinesAmount != 0)
            {
                this.lbl_linkedOgrinesAmount.text = this.uiApi.getText("ui.bak.linkedOgrinesAmount", this._linkedOgrinesAmount);
                this.lbl_linkedOgrinesAmount.removeTooltipExtension();
                this.lbl_linkedOgrinesAmount.fullWidthAndHeight();
                this.ctr_linkedOgrines.width = (this.lbl_linkedOgrinesAmount.width + 85);
                this.tx_ogrinesExpire.uri = ((this._expiringOgrines.length == 0) ? this.uiApi.createUri(this.uiApi.me().getConstant("interrogation_uri")) : this.uiApi.createUri(this.uiApi.me().getConstant("exclamation_uri")));
                this.lbl_linkedOgrinesAmount.x = 2;
                if (this.gd_categories.dataProvider.length != 0)
                {
                    this.ctr_linkedOgrines.visible = true;
                };
            };
        }

        private function onDofusShopOneClickTokens(tokens:Array):void
        {
            this._oneClickTokens = tokens;
        }

        private function onDofusShopBuySuccess(oneClick:Boolean):void
        {
            var params:Object = new Object();
            params.article = this._currentArticle;
            params.congratulations = true;
            params.oneClick = oneClick;
            this.uiApi.loadUi("shopPopupConfirmBuy", "shopPopupConfirmBuy", params, StrataEnum.STRATA_TOP, null, true);
            this._currentArticle = null;
        }

        private function onDofusShopCurrentArticle(article:Object):void
        {
            this._currentArticle = article;
        }

        public function get currentArticle():Object
        {
            return (this._currentArticle);
        }

        private function onDofusShopArticlesList(articles:Object, cat:int):void
        {
            var i:int;
            var dsa:*;
            var sa:ShopArticle;
            var articleUri:Uri;
            var newTexture:Texture;
            var j:int;
            var newPromoTexture:Texture;
            var tempCat:Object;
            var articlesToDisplay:Array = new Array();
            var articlesCount:int;
            var catIndex:int = this.gd_categoriesArticles.dataProvider.indexOf(this.findCategoryById(cat, this.gd_categoriesArticles));
            for each (dsa in articles)
            {
                sa = this.getShopArticle(dsa);
                sa.cat = cat;
                articleUri = this.uiApi.createUri(sa.imageUri);
                if (!this._textureCache[cat])
                {
                    this._textureCache[cat] = new Dictionary();
                };
                if (!this._textureCache[cat][sa.article.id])
                {
                    newTexture = new Texture();
                    newTexture.finalized = true;
                    newTexture.uri = articleUri;
                    newTexture.width = ((sa.isLarge) ? 317 : 140);
                    newTexture.height = ((sa.isLarge) ? 176 : 140);
                    newTexture.x = ((sa.isLarge) ? 2 : 5);
                    newTexture.y = ((sa.isLarge) ? 1 : 5);
                    this._textureCache[cat][sa.article.id] = newTexture;
                };
                if ((((!(sa.article is DofusShopHighlight)) && (sa.article.promo)) && (!(sa.isLarge))))
                {
                    j = 0;
                    while (j < sa.article.promo.length)
                    {
                        if (sa.article.promo[j].image)
                        {
                            if (!this._promoTextureCache[cat])
                            {
                                this._promoTextureCache[cat] = new Dictionary();
                            };
                            if (!this._promoTextureCache[cat][sa.article.id])
                            {
                                newPromoTexture = new Texture();
                                newPromoTexture.finalized = true;
                                newPromoTexture.uri = this.uiApi.createUri(sa.article.promo[j].image);
                                newPromoTexture.width = 147;
                                newPromoTexture.height = 147;
                                newPromoTexture.x = 1;
                                newPromoTexture.y = 1;
                                this._promoTextureCache[cat][sa.article.id] = newPromoTexture;
                            };
                            break;
                        };
                        j++;
                    };
                };
                articlesToDisplay.push(sa);
                if (sa.isLarge)
                {
                    articlesToDisplay.push(this.getShopArticle(null));
                    articlesCount++;
                };
                articlesCount++;
                if (articlesToDisplay.length == 5)
                {
                    this._allArticlesDatas.insertAt(((catIndex + ((6 * articlesCount) / 5)) - 5), articlesToDisplay);
                    articlesToDisplay = [];
                    this.addEmptyLinesAt(5, ((catIndex + ((6 * articlesCount) / 5)) - 4));
                }
                else
                {
                    if (articlesToDisplay.length > 5)
                    {
                        this._allArticlesDatas.insertAt(((catIndex + ((6 * (articlesCount - 1)) / 5)) - 5), articlesToDisplay.slice(0, 4));
                        articlesToDisplay.splice(0, 4);
                        this.addEmptyLinesAt(5, ((catIndex + ((6 * (articlesCount - 1)) / 5)) - 4));
                    };
                };
            };
            if ((articlesCount % 5) != 0)
            {
                this._allArticlesDatas.insertAt(((catIndex + (6 * Math.ceil((articlesCount / 5)))) - 5), articlesToDisplay);
                this.addEmptyLinesAt(5, ((catIndex + (6 * Math.ceil((articlesCount / 5)))) - 4));
            };
            this.addEmptyLinesAt(1, ((catIndex + (6 * Math.ceil((articlesCount / 5)))) + 1));
            if (this.getLineType(this.gd_categoriesArticles.dataProvider[(this.gd_categoriesArticles.dataProvider.length - 1)], 0).indexOf("Slot") != -1)
            {
                i = 0;
                while (i < 15)
                {
                    this._allArticlesDatas.push(false);
                    i++;
                };
            };
            if (cat == this.gd_categories.dataProvider[(this.gd_categories.dataProvider.length - 1)].id)
            {
                i = 0;
                while (i < 15)
                {
                    this._allArticlesDatas.pop();
                    i++;
                };
            };
            if (this.gd_categoriesArticles.dataProvider == this._allArticlesDatas)
            {
                this.gd_categoriesArticles.dataProvider = this._allArticlesDatas;
                if (this.gd_categoriesArticles.scrollBarV != null)
                {
                    this.gd_categoriesArticles.scrollBarV.addEventListener(Event.CHANGE, this.onScroll);
                };
                for each (tempCat in this.gd_categories.dataProvider)
                {
                    if (tempCat.id == cat)
                    {
                        if (this.gd_categories.dataProvider.indexOf(tempCat) < this.gd_categories.selectedIndex)
                        {
                            this.gd_categoriesArticles.verticalScrollValue = (this.gd_categoriesArticles.verticalScrollValue + ((6 * Math.ceil((articles.length / 5))) + 1));
                            break;
                        };
                    };
                };
            };
        }

        private function addEmptyLinesAt(nb:int, index:int, target:Array=null):void
        {
            var i:int;
            while (i < nb)
            {
                ((target) ? target : this._allArticlesDatas).insertAt(index, false);
                i++;
            };
        }

        private function onDeleteArticle(id:int):void
        {
            var isInSearch:* = (this.gd_categoriesArticles.dataProvider == this._searchDatas);
            this._allArticlesDatas = this.deleteArticleFromData(id, this._allArticlesDatas);
            this._searchDatas = this.deleteArticleFromData(id, this._searchDatas);
            this.gd_categoriesArticles.dataProvider = ((isInSearch) ? this._searchDatas : this._allArticlesDatas);
        }

        private function deleteArticleFromData(id:int, data:Array):Array
        {
            var line:*;
            var article:*;
            var tmpLine:Array;
            var nextLine:*;
            for each (line in data)
            {
                if ((line is Array))
                {
                    for each (article in line)
                    {
                        if ((((article) && (article.article)) && (article.article.id == id)))
                        {
                            line.removeAt(line.indexOf(article));
                            if (line.length == 0)
                            {
                                data = data.slice(0, data.indexOf(line)).concat(data.slice((data.indexOf(line) + 6)));
                            };
                            if (data.length > (data.indexOf(line) + 6))
                            {
                                tmpLine = line;
                                nextLine = data[(data.indexOf(tmpLine) + 6)];
                                while ((nextLine is Array))
                                {
                                    tmpLine.push(nextLine.shift());
                                    if (nextLine.length == 0)
                                    {
                                        data = data.slice(0, data.indexOf(nextLine)).concat(data.slice((data.indexOf(nextLine) + 6)));
                                    };
                                    tmpLine = nextLine;
                                    if (data.length > (data.indexOf(tmpLine) + 6))
                                    {
                                        break;
                                    };
                                    nextLine = data[(data.indexOf(tmpLine) + 6)];
                                };
                            };
                        };
                    };
                };
            };
            return (data);
        }

        private function onDofusShopArticlesSearchList(articles:Object):void
        {
            var i:int;
            var dsa:DofusShopArticle;
            var sa:ShopArticle;
            var articleUri:Uri;
            var newTexture:Texture;
            var articlesToDisplay:Array = new Array();
            var articlesCount:int;
            this._searchDatas = [];
            for each (dsa in articles)
            {
                sa = this.getShopArticle(dsa);
                articleUri = null;
                articleUri = this.uiApi.createUri(sa.imageUri);
                if (!this._textureCache[-1][sa.article.id])
                {
                    newTexture = new Texture();
                    newTexture.finalized = true;
                    newTexture.uri = articleUri;
                    newTexture.width = ((sa.isLarge) ? 318 : 140);
                    newTexture.height = ((sa.isLarge) ? 176 : 140);
                    newTexture.x = ((sa.isLarge) ? 2 : 5);
                    newTexture.y = ((sa.isLarge) ? 1 : 5);
                    this._textureCache[-1][sa.article.id] = newTexture;
                };
                articlesToDisplay.push(sa);
                if (sa.isLarge)
                {
                    articlesToDisplay.push(this.getShopArticle(null));
                    articlesCount++;
                };
                articlesCount++;
                if (articlesToDisplay.length == 5)
                {
                    this._searchDatas.insertAt((((7 * articlesCount) / 5) - 6), articlesToDisplay);
                    articlesToDisplay = [];
                    this.addEmptyLinesAt(6, (((7 * articlesCount) / 5) - 5), this._searchDatas);
                }
                else
                {
                    if (articlesToDisplay.length > 5)
                    {
                        this._searchDatas.insertAt((((7 * (articlesCount - 1)) / 5) - 6), articlesToDisplay.slice(0, 4));
                        articlesToDisplay.splice(0, 4);
                        this.addEmptyLinesAt(6, (((7 * (articlesCount - 1)) / 5) - 5), this._searchDatas);
                    };
                };
            };
            if ((articlesCount % 5) != 0)
            {
                this._searchDatas.insertAt(((7 * Math.ceil((articlesCount / 5))) - 6), articlesToDisplay);
                this.addEmptyLinesAt(6, ((7 * Math.ceil((articlesCount / 5))) - 5), this._searchDatas);
            };
            this.gd_categoriesArticles.dataProvider = this._searchDatas;
        }

        private function onDofusShopError(errorId:String):void
        {
            var text:String;
            switch (errorId)
            {
                case DofusShopEnum.ERROR_AUTHENTICATION_FAILED:
                    text = this.uiApi.getText("ui.shop.errorAuthentication");
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), text, [this.uiApi.getText("ui.common.ok")]);
                    this.uiApi.unloadUi("webBase");
                    return;
            };
        }

        private function onDofusShopMoney(ogrins:int):void
        {
            this._moneyOgr = ogrins;
            this.lbl_currentOgrines.text = this.utilApi.kamasToString(this._moneyOgr, "");
        }

        private function onDofusShopHome(categories:Object, gondolaArticles:Array, carousel:Array):void
        {
            var c:DofusShopCategory;
            var cat:Object;
            var gondolaCat:Object;
            var c2:DofusShopCategory;
            var c3:DofusShopCategory;
            var subcat:Object;
            var subsubcat:Object;
            var targetCategory:int;
            this.sysApi.startStats("shopNavigation");
            var categoriesArray:Array = [];
            var childrens:Dictionary = new Dictionary();
            var subchildrens:Dictionary = new Dictionary();
            for each (c in categories)
            {
                childrens[c.id] = new Array();
                for each (c2 in c.children)
                {
                    subchildrens[c2.id] = new Array();
                    for each (c3 in c2.children)
                    {
                        subchildrens[c2.id].push({
                            "id":c3.id,
                            "name":c3.name,
                            "desc":c3.description,
                            "img":c3.image,
                            "parentIds":[c2.id, c.id],
                            "subcats":new Array()
                        });
                    };
                    childrens[c.id].push({
                        "id":c2.id,
                        "name":c2.name,
                        "desc":c2.description,
                        "img":c2.image,
                        "parentIds":[c.id],
                        "level":1,
                        "subcats":subchildrens[c2.id]
                    });
                };
                categoriesArray.push({
                    "id":c.id,
                    "name":c.name,
                    "desc":c.description,
                    "img":c.image,
                    "parentIds":new Array(),
                    "level":0,
                    "subcats":childrens[c.id]
                });
            };
            for each (cat in categoriesArray)
            {
                this._allArticlesDatas.push(cat);
                for each (subcat in cat.subcats)
                {
                    this._allArticlesDatas.push(subcat);
                    for each (subsubcat in subcat.subcats)
                    {
                        this._allArticlesDatas.push(subsubcat);
                    };
                };
            };
            gondolaCat = new Object();
            gondolaCat.id = 0;
            gondolaCat.name = this.uiApi.getText("ui.shop.gondolaCatName");
            gondolaCat.children = [];
            gondolaCat.level = 0;
            gondolaCat.subcats = [];
            this._allArticlesDatas.insertAt(0, gondolaCat);
            this.gd_categories.dataProvider = this.copyObject(this._allArticlesDatas);
            this.gd_categories.selectedIndex = 0;
            this.gd_categoriesArticles.dataProvider = this._allArticlesDatas;
            if (carousel[0])
            {
                gondolaArticles.insertAt(2, carousel[0]);
                this.onDofusShopArticlesList(gondolaArticles.slice(0, 4), 0);
            }
            else
            {
                this.onDofusShopArticlesList(gondolaArticles.slice(0, 5), 0);
            };
            if (((this._goToArticleParams) || (this._goToCategoryId)))
            {
                targetCategory = ((this._goToArticleParams) ? this._goToArticleParams.categoryId : this._goToCategoryId);
                this.gd_categories.selectedItem = this.findCategoryById(targetCategory, this.gd_categories);
                this._goToCategoryId = 0;
            };
            if (((!(this.ctr_linkedOgrines.visible)) && (!(this._linkedOgrinesAmount == 0))))
            {
                this.ctr_linkedOgrines.visible = true;
            };
        }


    }
}

import Ankama_Web.enum.ShopArticleTypeEnum;
import com.ankamagames.dofus.logic.game.common.types.DofusShopArticle;

class ShopArticle 
{

    public var article:*;
    public var type:int;
    public var items:Array;
    public var quantity:int;
    public var isLarge:Boolean;
    public var nameExtension:String;
    public var cat:int;
    public var imageUri:String;
    public var name:String;

    public function ShopArticle(dsa:DofusShopArticle)
    {
        this.article = dsa;
        this.type = ShopArticleTypeEnum.UNKNOWN;
        this.items = [];
        this.quantity = 1;
        this.isLarge = false;
        this.nameExtension = "";
        this.cat = -1;
        this.imageUri = "";
        this.name = "";
    }

}


