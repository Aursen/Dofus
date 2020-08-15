package Ankama_Web.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.ComboBox;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofus.types.enums.DofusShopEnum;
    import d2hooks.ClosePopup;
    import d2hooks.DofusShopValidPaymentChoice;
    import d2hooks.DofusShopCurrentArticle;
    import d2actions.ShopOneClickBuyRequest;
    import flash.geom.Point;
    import Ankama_Web.enum.ShopArticleTypeEnum;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;

    public class ShopPopupOneClickPayment 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        public var btn_close_ctr_popupWindow:ButtonContainer;
        public var btn_buy:ButtonContainer;
        public var btn_manage:ButtonContainer;
        public var btn_cgv:ButtonContainer;
        public var tx_picture:Texture;
        public var tx_externalCgvLink:Texture;
        public var tx_slot:Texture;
        public var lbl_name:Label;
        public var lbl_price:Label;
        public var lbl_expiration:Label;
        public var lbl_title_ctr_popupWindow:Label;
        public var lbl_managePayment:Label;
        public var lbl_cgv:Label;
        public var lbl_rights:Label;
        public var combo_creditCards:ComboBox;
        private var _item:*;
        private var _params:Object;


        public function main(params:Object=null):void
        {
            var price:Object;
            var token:Object;
            this.uiApi.addComponentHook(this.tx_slot, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_slot, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_buy, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_manage, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_cgv, ComponentHookList.ON_RELEASE);
            this._params = params;
            this.lbl_rights.height = Math.min(this.lbl_rights.height, this.lbl_rights.textHeight);
            this.lbl_managePayment.fullWidth(0, 10);
            this.lbl_cgv.fullWidth();
            this.tx_externalCgvLink.x = ((this.lbl_cgv.x + this.lbl_cgv.width) + 3);
            this.lbl_name.text = (((params.article.quantity > 1) ? (params.article.quantity + "x ") : "") + (((params.article.items[0]) && (params.article.items.length == 1)) ? params.article.items[0].name : params.article.article.name));
            for each (price in params.article.article.prices)
            {
                if (price.paymentmode == DofusShopEnum.PAYMENT_MODE_ONECLICK)
                {
                    if (((this.lbl_price.text == "") || (!(price.country == "WD"))))
                    {
                        this.lbl_price.text = ((price.price + " ") + price.currency);
                    };
                };
            };
            if (((params.article.article.imageNormal) && (params.article.article.imageNormal.length > 0)))
            {
                this.tx_picture.uri = this.uiApi.createUri(params.article.article.imageNormal);
            }
            else
            {
                if (((params.article.article.imageSmall) && (params.article.article.imageSmall.length > 0)))
                {
                    this.tx_picture.uri = this.uiApi.createUri(params.article.article.imageSmall);
                }
                else
                {
                    if (params.article.article.imageSwf)
                    {
                        this.tx_picture.uri = params.article.article.imageSwf;
                    };
                };
            };
            var tokens:Array = [];
            for each (token in this._params.tokens)
            {
                tokens.push(token.pan);
            };
            this.combo_creditCards.dataProvider = tokens;
            this.combo_creditCards.selectedIndex = 0;
            this._params = params;
            this._item = ((params.article.items[0]) ? params.article.items[0] : params.article.article);
            this.lbl_title_ctr_popupWindow.forceUppercase = true;
        }

        public function unload():void
        {
            this.sysApi.dispatchHook(ClosePopup);
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var token:Object;
            for each (token in this._params.tokens)
            {
                if (token.pan == this.combo_creditCards.selectedItem)
                {
                    this.lbl_expiration.text = this.uiApi.getText("ui.shop.oneClickExpiration", ((token.expiry_month + "/") + token.expiry_year));
                };
            };
        }

        public function onRelease(target:Object):void
        {
            var token:Object;
            var jsonObject:Object;
            var price:*;
            var currency:String;
            switch (target)
            {
                case this.btn_buy:
                    for each (token in this._params.tokens)
                    {
                        if (token.pan == this.combo_creditCards.selectedItem)
                        {
                            jsonObject = {
                                "quantity":1,
                                "id":this._params.article.article.id
                            };
                            for each (price in this._params.article.article.prices)
                            {
                                if (price.paymentmode == DofusShopEnum.PAYMENT_MODE_ONECLICK)
                                {
                                    jsonObject.amount = price.price;
                                    currency = price.currency;
                                };
                            };
                            this.sysApi.dispatchHook(DofusShopValidPaymentChoice, this._params.article.article, false);
                            this.sysApi.dispatchHook(DofusShopCurrentArticle, this._params.article);
                            this.sysApi.sendAction(new ShopOneClickBuyRequest(JSON.stringify([jsonObject]), currency, token.id));
                        };
                    };
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_close_ctr_popupWindow:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_manage:
                    this.sysApi.goToUrl(this.sysApi.getConfigEntry("config.shopManagePaymentUrl"));
                    break;
                case this.btn_cgv:
                    this.sysApi.goToUrl(this.sysApi.getConfigEntry("config.shopCgvUrl"));
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var globalPosition:*;
            var probaObject:Object;
            var txt:String;
            switch (target)
            {
                case this.tx_slot:
                    globalPosition = target["localToGlobal"](new Point(0, 0));
                    if (this._params.article.type == ShopArticleTypeEnum.MYSTERY_BOX)
                    {
                        probaObject = {
                            "name":this._params.article.article.name,
                            "icon":this._params.article.imageUri,
                            "probas":this.createProbaObject(this._params.article.items[0].kards)
                        };
                        this.uiApi.showTooltip(probaObject, target, false, "standard", LocationEnum.POINT_TOPRIGHT, LocationEnum.POINT_TOPLEFT, 20, "mysteryBox", null, {
                            "showProba":true,
                            "sortInBlocks":true,
                            "description":this._params.article.article.description
                        });
                    }
                    else
                    {
                        if ((this._item is ItemWrapper))
                        {
                            this.uiApi.showTooltip(this._item, target, false, "standard", LocationEnum.POINT_TOPRIGHT, LocationEnum.POINT_TOPLEFT, 20, "item", null, {"showEffects":true});
                        }
                        else
                        {
                            txt = "";
                            if (this._item.name)
                            {
                                txt = (txt + (("<b>" + this._item.name) + "</b>\n"));
                            };
                            if (this._item.description)
                            {
                                txt = (txt + this._item.description);
                            };
                            if (txt)
                            {
                                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt), target, false, "standard", LocationEnum.POINT_TOPRIGHT, LocationEnum.POINT_TOPLEFT, 20, null, null, null, "TextInfo");
                            };
                        };
                    };
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

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onShortcut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                return (true);
            };
            return (false);
        }


    }
}

