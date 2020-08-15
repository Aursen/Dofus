package Ankama_Web.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.berilia.components.EntityDisplayer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
    import com.ankamagames.dofus.types.enums.DofusShopEnum;
    import d2hooks.ClosePopup;
    import d2hooks.DofusShopIndirectBuyClick;
    import com.ankamagames.berilia.enums.StrataEnum;

    public class ShopPopupAttitude 
    {

        private static var ATTITUDE_ACTION_ID:int = 10;

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        public var ed_popupChar:EntityDisplayer;
        public var btn_close:ButtonContainer;
        public var btn_leftArrow:ButtonContainer;
        public var btn_rightArrow:ButtonContainer;
        public var btn_buy:ButtonContainer;
        public var btn_buyOneClick:ButtonContainer;
        public var btn_lbl_btn_buy:Label;
        public var btn_lbl_btn_buyOneClick:Label;
        public var lbl_title:Label;
        public var tx_ogrineButton:Texture;
        private var _direction:int = 3;
        private var _params:Object;


        public function main(params:Object=null):void
        {
            var possibleEffect:EffectInstanceDice;
            var i:int;
            var hasOgrinePrice:Boolean;
            var hasOneClickPrice:Boolean;
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this._params = params;
            this.lbl_title.text = params.article.article.name;
            this.ed_popupChar.look = this.utilApi.getRealTiphonEntityLook(this.playerApi.getPlayedCharacterInfo().id, true);
            if (this.ed_popupChar.look.getBone() == 2)
            {
                this.ed_popupChar.look.setBone(1);
            };
            for each (possibleEffect in params.article.items[0].possibleEffects)
            {
                if (possibleEffect.effectId == ATTITUDE_ACTION_ID)
                {
                    this.ed_popupChar.setAnimationAndDirection(this.dataApi.getEmoteAnimName(possibleEffect.diceNum, this.playerApi.getCurrentEntityLook()), this._direction);
                };
            };
            this.uiApi.addComponentHook(this.ed_popupChar, "onEntityReady");
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
        }

        public function unload():void
        {
            this.sysApi.dispatchHook(ClosePopup);
        }

        public function onEntityReady(entity:*):void
        {
            this.uiApi.removeComponentHook(this.ed_popupChar, "onEntityReady");
            var maxEntityHeight:int;
            var maxEntityWidth:int;
            var i:int;
            while (i < this.ed_popupChar.entity.maxFrame)
            {
                if (this.ed_popupChar.entity.rawAnimation.width > maxEntityWidth)
                {
                    maxEntityWidth = this.ed_popupChar.entity.rawAnimation.width;
                };
                if (this.ed_popupChar.entity.rawAnimation.height > maxEntityHeight)
                {
                    maxEntityHeight = this.ed_popupChar.entity.rawAnimation.height;
                };
                this.ed_popupChar.entity.rawAnimation.nextFrame();
                i++;
            };
            var scale:Number = Math.min(Math.max((this.ed_popupChar.height / maxEntityHeight), (this.ed_popupChar.width / maxEntityWidth), 1.25), 4);
            this.ed_popupChar.entity.scaleX = scale;
            this.ed_popupChar.entity.scaleY = scale;
            this.ed_popupChar.entity.y = 500;
            this.ed_popupChar.visible = true;
        }

        private function turnChara(sens:int):void
        {
            this._direction = (((this._direction + (2 * sens)) + 8) % 8);
            this.ed_popupChar.direction = this._direction;
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

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_leftArrow:
                    this.turnChara(-1);
                    break;
                case this.btn_rightArrow:
                    this.turnChara(1);
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


    }
}

