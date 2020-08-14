package Ankama_Web.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ScrollContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Grid;
    import mx.utils.StringUtil;
    import com.ankamagames.dofus.types.enums.DofusShopEnum;
    import d2hooks.ClosePopup;
    import flash.geom.Point;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.berilia.types.LocationEnum;
    import d2hooks.DofusShopIndirectBuyClick;
    import com.ankamagames.berilia.enums.StrataEnum;

    public class ShopPopupPack 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        public var ctr_popupMain:GraphicContainer;
        public var blk_description:GraphicContainer;
        public var ctr_description:GraphicContainer;
        public var scroll_description:ScrollContainer;
        public var blk_grid:GraphicContainer;
        public var btn_close:ButtonContainer;
        public var tx_picture:Texture;
        public var tx_promo:Texture;
        public var lbl_description:Label;
        public var lbl_promo:Label;
        public var gd_setItems:Grid;
        public var btn_lbl_btn_buy:Label;
        public var btn_buy:ButtonContainer;
        public var lbl_title:Label;
        public var btn_buyOneClick:ButtonContainer;
        public var tx_ogrineButton:Texture;
        public var btn_lbl_btn_buyOneClick:Label;
        private var _params:Object;


        public function main(params:Object=null):void
        {
            var diff:int;
            var prom:Object;
            var i:int;
            var hasOgrinePrice:Boolean;
            var hasOneClickPrice:Boolean;
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this._params = params;
            if (params.article.items.length > 7)
            {
                diff = (params.article.items.length - 7);
                this.ctr_popupMain.width = (this.ctr_popupMain.width + (44 * diff));
                this.blk_description.width = (this.blk_description.width + (44 * diff));
                this.scroll_description.width = (this.scroll_description.width + (44 * diff));
                this.lbl_description.width = (this.lbl_description.width + (44 * diff));
                this.lbl_promo.width = this.lbl_description.width;
                this.blk_grid.width = (this.blk_grid.width + (44 * diff));
                this.gd_setItems.width = (this.gd_setItems.width + (44 * diff));
            };
            this.lbl_description.textfield.height = this.lbl_description.height;
            this.lbl_title.text = params.article.article.name;
            this.tx_picture.uri = this.uiApi.createUri(params.article.article.imageNormal);
            var j:int;
            while (j < params.article.article.promo.length)
            {
                if (params.article.article.promo[j].image)
                {
                    this.tx_promo.uri = this.uiApi.createUri(params.article.article.promo[j].image);
                    break;
                };
                j++;
            };
            this.lbl_promo.text = "";
            if (params.article.article.promo.length > 0)
            {
                this.lbl_promo.text = (this.lbl_promo.text + this.uiApi.getText("ui.shop.promotion"));
                for each (prom in params.article.article.promo)
                {
                    this.lbl_promo.text = (this.lbl_promo.text + prom.description);
                };
            }
            else
            {
                this.lbl_description.y = (this.lbl_description.y - 40);
            };
            this.lbl_promo.fullSize(this.lbl_promo.width);
            this.lbl_description.text = params.article.article.description;
            this.lbl_description.text = StringUtil.trim(this.lbl_description.text);
            this.lbl_description.fullSize(this.lbl_description.width);
            this.ctr_description.height = ((this.lbl_description.height + this.lbl_promo.height) + 7);
            this.scroll_description.addContent(this.ctr_description);
            this.gd_setItems.dataProvider = params.article.items;
            if (params.article.article.prices)
            {
                hasOgrinePrice = false;
                hasOneClickPrice = false;
                i = 0;
                while (i < params.article.article.prices.length)
                {
                    if (params.article.article.prices[i].currency == DofusShopEnum.CURRENCY_OGRINES)
                    {
                        hasOgrinePrice = true;
                        this.btn_lbl_btn_buy.text = ((params.article.article.prices[i].originalPrice) ? (params.article.article.prices[i].originalPrice + " ") : ("" + params.article.article.prices[i].price));
                    }
                    else
                    {
                        if (params.article.article.prices[i].paymentmode == DofusShopEnum.PAYMENT_MODE_ONECLICK)
                        {
                            hasOneClickPrice = true;
                            if (((this.btn_lbl_btn_buyOneClick.text == "") || (!(params.article.article.prices[i].country == "WD"))))
                            {
                                this.btn_lbl_btn_buyOneClick.text = ((params.article.article.prices[i].price + " ") + params.article.article.prices[i].currency);
                            };
                        };
                    };
                    i++;
                };
                if (hasOgrinePrice)
                {
                    if (!hasOneClickPrice)
                    {
                        this.btn_buyOneClick.visible = false;
                        this.btn_buy.x = 94;
                    };
                }
                else
                {
                    this.btn_buy.visible = false;
                    this.tx_ogrineButton.visible = false;
                    if (hasOneClickPrice)
                    {
                        this.btn_buyOneClick.x = 94;
                    }
                    else
                    {
                        this.btn_buyOneClick.visible = false;
                    };
                };
            };
        }

        public function unload():void
        {
            this.sysApi.dispatchHook(ClosePopup);
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var txt:String;
            var globalPosition:* = target["localToGlobal"](new Point(0, 0));
            if (((item) && (item.data is ItemWrapper)))
            {
                this.uiApi.showTooltip(item.data, target, false, "standard", ((globalPosition.x > 200) ? LocationEnum.POINT_TOPRIGHT : LocationEnum.POINT_TOPLEFT), ((globalPosition.x > 200) ? LocationEnum.POINT_TOPLEFT : LocationEnum.POINT_TOPRIGHT), 20, null, null, {
                    "showEffects":true,
                    "header":true
                });
            }
            else
            {
                txt = "";
                if (item.data)
                {
                    txt = (txt + (("<b>" + item.data.name) + "</b>\n"));
                    txt = (txt + item.data.description);
                };
                if (txt)
                {
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt), target, false, "standard", ((globalPosition.x > 200) ? LocationEnum.POINT_TOPRIGHT : LocationEnum.POINT_TOPLEFT), ((globalPosition.x > 200) ? LocationEnum.POINT_TOPLEFT : LocationEnum.POINT_TOPRIGHT), 20, null, null, null, "TextInfo");
                };
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_buy:
                    this.sysApi.dispatchHook(DofusShopIndirectBuyClick, this._params.article.article, true);
                    this.uiApi.loadUi("shopPopupConfirmBuy", "shopPopupConfirmBuy", this._params, StrataEnum.STRATA_TOP, null, true);
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_buyOneClick:
                    this.sysApi.dispatchHook(DofusShopIndirectBuyClick, this._params.article.article, false);
                    if (this._params.tokens.length == 0)
                    {
                        this.uiApi.loadUi("shopPopupOneClickRegister", "shopPopupOneClickRegister", this._params, StrataEnum.STRATA_TOP, null, true);
                    }
                    else
                    {
                        this.uiApi.loadUi("shopPopupOneClickPayment", "shopPopupOneClickPayment", this._params, StrataEnum.STRATA_TOP, null, true);
                    };
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        private function onShortcut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                return (true);
            };
            return (false);
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            if (item.data)
            {
                this.modContextMenu.createContextMenu(this.menuApi.create(item.data, "item"));
            };
        }


    }
} Ankama_Web.ui

