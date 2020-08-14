package Ankama_Web.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import flash.utils.Dictionary;
    import Ankama_Web.enum.MysteryBoxRarityEnum;
    import flash.geom.ColorTransform;
    import com.ankamagames.dofus.types.enums.DofusShopEnum;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import d2hooks.ClosePopup;
    import d2hooks.DofusShopIndirectBuyClick;
    import com.ankamagames.berilia.enums.StrataEnum;
    import flash.geom.Point;
    import com.ankamagames.berilia.types.LocationEnum;

    public class ShopPopupMysteryBox 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        public var btn_close:ButtonContainer;
        public var gd_content:Grid;
        public var lbl_content:Label;
        public var lbl_description:Label;
        public var lbl_totalJackpot:Label;
        public var lbl_totalEpic:Label;
        public var lbl_totalRare:Label;
        public var lbl_totalUncommon:Label;
        public var lbl_totalCommon:Label;
        public var btn_lbl_btn_buy:Label;
        public var btn_lbl_btn_buyOneClick:Label;
        public var lbl_title:Label;
        public var btn_buy:ButtonContainer;
        public var btn_buyOneClick:ButtonContainer;
        public var tx_ogrineButton:Texture;
        private var _data:Dictionary = new Dictionary();
        private var _totalProba:Dictionary = new Dictionary();
        private var _dataOrder:Array = [MysteryBoxRarityEnum.COMMON, MysteryBoxRarityEnum.UNCOMMON, MysteryBoxRarityEnum.RARE, MysteryBoxRarityEnum.EPIC, MysteryBoxRarityEnum.LEGENDARY];
        private var _params:Object;
        private var _nbJackpot:int = 0;
        private var _bgColor1:ColorTransform;


        public function main(params:Object=null):void
        {
            var kard:Object;
            var provider:Array;
            var rarity:String;
            var i:int;
            var hasOgrinePrice:Boolean;
            var hasOneClickPrice:Boolean;
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.lbl_title.text = params.article.article.name;
            this._params = params;
            this._bgColor1 = new ColorTransform();
            var bgColor:* = this.sysApi.getConfigEntry("colors.grid.line");
            this._bgColor1.color = (parseInt(bgColor, 16) & 0xFFFFFF);
            this._bgColor1.alphaMultiplier = (((parseInt(bgColor, 16) & 0xFF000000) >> 24) / 0xFF);
            if (params.article.article.description)
            {
                this.lbl_description.text = params.article.article.description;
            };
            for each (kard in this._params.article.items[0].kards)
            {
                if (!this._data[kard.rarity])
                {
                    this._data[kard.rarity] = [];
                    this._totalProba[kard.rarity] = 0;
                };
                this._data[kard.rarity].push(kard);
                if (kard.rarity == MysteryBoxRarityEnum.LEGENDARY)
                {
                    this._data[kard.rarity].push(false);
                };
                this._totalProba[kard.rarity] = (this._totalProba[kard.rarity] + kard.probability);
            };
            provider = [];
            for each (rarity in this._dataOrder)
            {
                if (((this._data[rarity]) && (this._data[rarity].length > 0)))
                {
                    provider = provider.concat(this._data[rarity]);
                    switch (rarity)
                    {
                        case MysteryBoxRarityEnum.COMMON:
                            this.lbl_totalCommon.text = (((this.uiApi.getText("ui.codesAndGift.mb.rarityCommon") + " (") + (Math.round((10 * this._totalProba[MysteryBoxRarityEnum.COMMON])) / 10)) + " %)");
                            this.lbl_totalCommon.colorText = MysteryBoxRarityEnum.COMMON_COLOR;
                            break;
                        case MysteryBoxRarityEnum.UNCOMMON:
                            this.lbl_totalUncommon.text = (((this.uiApi.getText("ui.codesAndGift.mb.rarityUncommon") + " (") + (Math.round((10 * this._totalProba[MysteryBoxRarityEnum.UNCOMMON])) / 10)) + " %),");
                            this.lbl_totalUncommon.colorText = MysteryBoxRarityEnum.UNCOMMON_COLOR;
                            break;
                        case MysteryBoxRarityEnum.RARE:
                            this.lbl_totalRare.text = (((this.uiApi.getText("ui.codesAndGift.mb.rarityRare") + " (") + (Math.round((10 * this._totalProba[MysteryBoxRarityEnum.RARE])) / 10)) + " %),");
                            this.lbl_totalRare.colorText = MysteryBoxRarityEnum.RARE_COLOR;
                            break;
                        case MysteryBoxRarityEnum.EPIC:
                            this.lbl_totalEpic.text = (((this.uiApi.getText("ui.codesAndGift.mb.rarityEpic") + " (") + (Math.round((10 * this._totalProba[MysteryBoxRarityEnum.EPIC])) / 10)) + " %),");
                            this.lbl_totalEpic.colorText = MysteryBoxRarityEnum.EPIC_COLOR;
                            break;
                        case MysteryBoxRarityEnum.LEGENDARY:
                            this.lbl_totalJackpot.text = (((this.uiApi.getText("ui.codesAndGift.mb.rarityLegendary") + " (") + (Math.round((10 * this._totalProba[MysteryBoxRarityEnum.LEGENDARY])) / 10)) + " %),");
                            this.lbl_totalJackpot.colorText = MysteryBoxRarityEnum.LEGENDARY_COLOR;
                            break;
                    };
                };
            };
            this.lbl_content.fullWidth();
            this.lbl_totalCommon.fullWidth();
            this.lbl_totalUncommon.fullWidth();
            this.lbl_totalRare.fullWidth();
            this.lbl_totalEpic.fullWidth();
            this.lbl_totalJackpot.fullWidth();
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
                        this.btn_buy.x = 0;
                    };
                }
                else
                {
                    this.btn_buy.visible = false;
                    this.tx_ogrineButton.visible = false;
                    if (hasOneClickPrice)
                    {
                        this.btn_buyOneClick.x = 0;
                    }
                    else
                    {
                        this.btn_buyOneClick.visible = false;
                    };
                };
            };
            this.gd_content.dataProvider = provider;
        }

        public function updateBlock(data:*, componentsRef:*, selected:Boolean, line:uint):void
        {
            if (data)
            {
                switch (data.rarity)
                {
                    case MysteryBoxRarityEnum.COMMON:
                        componentsRef.lbl_rarityName.text = this.uiApi.getText("ui.codesAndGift.mb.rarityCommon");
                        componentsRef.lbl_rarityName.colorText = MysteryBoxRarityEnum.COMMON_COLOR;
                        break;
                    case MysteryBoxRarityEnum.UNCOMMON:
                        componentsRef.lbl_rarityName.text = this.uiApi.getText("ui.codesAndGift.mb.rarityUncommon");
                        componentsRef.lbl_rarityName.colorText = MysteryBoxRarityEnum.UNCOMMON_COLOR;
                        break;
                    case MysteryBoxRarityEnum.RARE:
                        componentsRef.lbl_rarityName.text = this.uiApi.getText("ui.codesAndGift.mb.rarityRare");
                        componentsRef.lbl_rarityName.colorText = MysteryBoxRarityEnum.RARE_COLOR;
                        break;
                    case MysteryBoxRarityEnum.EPIC:
                        componentsRef.lbl_rarityName.text = this.uiApi.getText("ui.codesAndGift.mb.rarityEpic");
                        componentsRef.lbl_rarityName.colorText = MysteryBoxRarityEnum.EPIC_COLOR;
                        break;
                    case MysteryBoxRarityEnum.LEGENDARY:
                        componentsRef.lbl_rarityName.text = this.uiApi.getText("ui.codesAndGift.mb.rarityLegendary");
                        componentsRef.lbl_rarityName.colorText = MysteryBoxRarityEnum.LEGENDARY_COLOR;
                        break;
                };
                componentsRef.lbl_kardDescription.text = data.kard.description;
                componentsRef.lbl_kardName.text = data.kard.name;
                componentsRef.lbl_kardProba.text = (data.probability + " %");
                componentsRef.tx_kardImage.uri = data.kard.iconUri;
            };
            if (componentsRef.ctr_emptyLine)
            {
                this._nbJackpot++;
            };
            var index:int = (line + this._nbJackpot);
            var ctr:GraphicContainer = componentsRef[this.getBlockType(data, line)];
            ctr.graphics.clear();
            if ((index % 2) == 0)
            {
                ctr.graphics.beginFill(this._bgColor1.color, this._bgColor1.alphaMultiplier);
                ctr.graphics.drawRect(0, 0, this.gd_content.slotWidth, this.gd_content.slotHeight);
                ctr.graphics.endFill();
            };
        }

        public function getBlockType(data:*, line:uint):String
        {
            if (!data)
            {
                return ("ctr_emptyLine");
            };
            if (data.rarity == MysteryBoxRarityEnum.LEGENDARY)
            {
                return ("ctr_legendaryRarity");
            };
            return ("ctr_basicRarity");
        }

        public function updateContentLine(data:*, componentsRef:*, selected:Boolean):void
        {
        }

        public function unload():void
        {
            this.sysApi.dispatchHook(ClosePopup);
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

        public function onRollOver(target:Object):void
        {
            var globalPosition:*;
            if (target.name.indexOf("kardImage") != -1)
            {
                globalPosition = target["localToGlobal"](new Point(0, 0));
                this.uiApi.showTooltip({
                    "uri":target.uri,
                    "width":250,
                    "height":250
                }, target, false, "zoomTooltip", ((globalPosition.x > 200) ? LocationEnum.POINT_TOPRIGHT : LocationEnum.POINT_TOPLEFT), ((globalPosition.x > 200) ? LocationEnum.POINT_TOPLEFT : LocationEnum.POINT_TOPRIGHT), 20, "slotTexture", null, null);
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip("zoomTooltip");
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


    }
} Ankama_Web.ui

