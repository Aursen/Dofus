package Ankama_Web.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.EntityDisplayer;
    import com.ankamagames.berilia.components.TextArea;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import d2hooks.AccessoryPreview;
    import d2actions.AccessoryPreviewRequest;
    import mx.utils.StringUtil;
    import com.ankamagames.dofus.types.enums.DofusShopEnum;
    import d2hooks.ClosePopup;
    import d2hooks.DofusShopIndirectBuyClick;
    import com.ankamagames.berilia.enums.StrataEnum;
    import flash.events.Event;
    import com.ankamagames.berilia.types.LocationEnum;
    import __AS3__.vec.*;

    public class ShopPopupItemSet 
    {

        public const ANIMATION_STATIQUE:String = "AnimStatique";
        public const ANIMATION_WEAPON:String = "AnimArme8";
        public const SKIN_ACTION_ID:int = 1179;
        public const WEAPON_TYPE_ID:int = 2;

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
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var btn_close:ButtonContainer;
        public var ed_popupChar:EntityDisplayer;
        public var lbl_description:TextArea;
        public var btn_leftArrow:ButtonContainer;
        public var btn_rightArrow:ButtonContainer;
        public var gd_setItems:Grid;
        public var btn_playWeaponAnim:ButtonContainer;
        public var btn_lbl_btn_buy:Label;
        public var btn_buy:ButtonContainer;
        public var lbl_title:Label;
        public var btn_buyOneClick:ButtonContainer;
        public var tx_ogrineButton:Texture;
        public var btn_lbl_btn_buyOneClick:Label;
        private var _containsWeapon:Boolean;
        private var _direction:int = 3;
        private var _params:Object;


        public function main(params:Object=null):void
        {
            var item:ItemWrapper;
            var effect:Object;
            var i:int;
            var hasOgrinePrice:Boolean;
            var hasOneClickPrice:Boolean;
            this._params = params;
            this.lbl_title.text = params.article.article.name;
            this.sysApi.addHook(AccessoryPreview, this.onAccessoryPreview);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this._containsWeapon = false;
            for each (item in params.article.items)
            {
                for each (effect in item.possibleEffects)
                {
                    if (((effect.effectId == this.SKIN_ACTION_ID) && (this.dataApi.getItemType(effect.parameter2).superTypeId == this.WEAPON_TYPE_ID)))
                    {
                        this._containsWeapon = true;
                        break;
                    };
                };
                if (this._containsWeapon)
                {
                    break;
                };
            };
            this.gd_setItems.dataProvider = params.article.items;
            this.sysApi.sendAction(new AccessoryPreviewRequest(Vector.<uint>(params.article.article.gids)));
            this.lbl_description.text = params.article.article.description;
            this.lbl_description.text = StringUtil.trim(this.lbl_description.text);
            this.ed_popupChar.look = this.utilApi.getRealTiphonEntityLook(this.playerApi.getPlayedCharacterInfo().id, true);
            if (this.ed_popupChar.look.getBone() == 2)
            {
                this.ed_popupChar.look.setBone(1);
            };
            this.ed_popupChar.setAnimationAndDirection(this.ANIMATION_STATIQUE, this._direction);
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
                        this.btn_buy.x = 95;
                    };
                }
                else
                {
                    this.btn_buy.visible = false;
                    this.tx_ogrineButton.visible = false;
                    if (hasOneClickPrice)
                    {
                        this.btn_buyOneClick.x = 95;
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
            this.ed_popupChar.removeEndAnimationListener(this.onAnimationEnd);
            this.sysApi.dispatchHook(ClosePopup);
        }

        public function onEntityReady(entity:*):void
        {
            this.uiApi.removeComponentHook(this.ed_popupChar, "onEntityReady");
            this.ed_popupChar.visible = true;
            if (this._containsWeapon)
            {
                this.btn_playWeaponAnim.visible = true;
            };
        }

        private function turnChara(sens:int):void
        {
            this._direction = (((this._direction + sens) + 8) % 8);
            if (((this.ed_popupChar.animation == this.ANIMATION_WEAPON) && ((this._direction % 2) == 0)))
            {
                this.turnChara(sens);
            }
            else
            {
                this.ed_popupChar.direction = this._direction;
            };
        }

        private function onAccessoryPreview(look:Object):void
        {
            if (look)
            {
                this.ed_popupChar.look = look;
            };
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
                case this.btn_playWeaponAnim:
                    if ((this.ed_popupChar.direction % 2) == 0)
                    {
                        this.turnChara(1);
                    };
                    this.ed_popupChar.animation = this.ANIMATION_WEAPON;
                    this.ed_popupChar.addEndAnimationListener(this.onAnimationEnd);
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

        private function onAnimationEnd(e:Event):void
        {
            this.ed_popupChar.removeEndAnimationListener(this.onAnimationEnd);
            this.ed_popupChar.animation = this.ANIMATION_STATIQUE;
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (((item) && (item.data is ItemWrapper)))
            {
                this.uiApi.showTooltip(item.data, item.container, false, "standard", LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_BOTTOMRIGHT, 3, null, null, {
                    "showEffects":true,
                    "header":true
                });
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            if (item.data)
            {
                this.modContextMenu.createContextMenu(this.menuApi.create(item.data, "item"));
            };
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

