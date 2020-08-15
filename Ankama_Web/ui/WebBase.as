package Ankama_Web.ui
{
    import flash.filters.BlurFilter;
    import Ankama_Web.enum.WebTabEnum;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.ConfigApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.SecurityApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Texture;
    import d2enums.ComponentHookList;
    import d2hooks.CodesAndGiftNotificationValue;
    import d2hooks.GiftsWaitingAllocation;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import flash.geom.Point;
    import d2hooks.DofusShopSwitchTab;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import flash.external.ExternalInterface;

    public class WebBase 
    {

        public static var currentTabUi:String;
        public static var isShopAvailable:Boolean = false;
        public static var isCodesAndGiftsAvailable:Boolean = true;
        public static const blurFilter:BlurFilter = new BlurFilter(10, 10);
        public static const possibleTabs:Array = [WebTabEnum.SHOP_TAB, WebTabEnum.BAK_TAB, WebTabEnum.CODES_AND_GIFTS_TAB];

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="ConfigApi")]
        public var configApi:ConfigApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="SecurityApi")]
        public var securityApi:SecurityApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        public var uiCtr:GraphicContainer;
        public var btn_close:ButtonContainer;
        public var btn_tabShop:ButtonContainer;
        public var btn_tabOgrines:ButtonContainer;
        public var btn_tabCodesAndGifts:ButtonContainer;
        public var btn_help:ButtonContainer;
        public var tx_line:Texture;
        public var tx_horizontalBar1:Texture;
        public var tx_horizontalBar2:Texture;
        public var tx_notifGift:Texture;
        public var ctr_linemask:GraphicContainer;


        public function main(oParams:*=null):void
        {
            var lastTab:String;
            this.uiApi.me().restoreSnapshotAfterLoading = false;
            this.tx_line.mask = this.ctr_linemask;
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addComponentHook(this.btn_tabOgrines, "onRelease");
            this.uiApi.addComponentHook(this.btn_tabCodesAndGifts, "onRelease");
            this.uiApi.addComponentHook(this.btn_tabShop, "onRelease");
            this.uiApi.addComponentHook(this.btn_help, ComponentHookList.ON_RELEASE);
            this.sysApi.addHook(CodesAndGiftNotificationValue, this.onCodesAndGiftNotificationValue);
            this.sysApi.addHook(GiftsWaitingAllocation, this.onCodesAndGiftNotificationValue);
            this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
            this.tx_notifGift.visible = this.sysApi.getData("giftNotification");
            if (this.configApi.isFeatureWithKeywordEnabled("web.shopInClient"))
            {
                isShopAvailable = true;
            };
            currentTabUi = null;
            if (this.sysApi.getCurrentServer().gameTypeId == 5)
            {
                this.btn_tabOgrines.visible = false;
            };
            if (isShopAvailable)
            {
                this.btn_tabShop.visible = true;
            };
            if (isCodesAndGiftsAvailable)
            {
                this.btn_tabCodesAndGifts.visible = true;
            };
            if ((((oParams) && (oParams is Array)) && (oParams[0])))
            {
                this.openTab(oParams[0], oParams[1]);
            }
            else
            {
                lastTab = this.sysApi.getSetData("shopLastOpenedTab", WebTabEnum.SHOP_TAB);
                if (((this.sysApi.getCurrentServer().gameTypeId == 5) && (lastTab == WebTabEnum.BAK_TAB)))
                {
                    lastTab = WebTabEnum.SHOP_TAB;
                };
                if ((((!(isShopAvailable)) && (lastTab == WebTabEnum.SHOP_TAB)) || ((!(isCodesAndGiftsAvailable)) && (lastTab == WebTabEnum.CODES_AND_GIFTS_TAB))))
                {
                    lastTab = WebTabEnum.BAK_TAB;
                };
                if (((isCodesAndGiftsAvailable) && (lastTab == WebTabEnum.VET_RWDS_TAB)))
                {
                    lastTab = WebTabEnum.CODES_AND_GIFTS_TAB;
                };
                if (possibleTabs.indexOf(lastTab) == -1)
                {
                    lastTab = WebTabEnum.SHOP_TAB;
                };
                this.openTab(lastTab);
            };
        }

        public function unload():void
        {
            if (currentTabUi == WebTabEnum.BAK_TAB)
            {
                this.closeWebModalWindow();
            };
            if (currentTabUi)
            {
                this.uiApi.unloadUi(currentTabUi);
            };
            if (this.uiApi.getUi("secureMode"))
            {
                this.uiApi.unloadUi("secureMode");
            };
            currentTabUi = null;
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case ShortcutHookListEnum.CLOSE_UI:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_tabShop:
                    this.openTab(WebTabEnum.SHOP_TAB);
                    break;
                case this.btn_tabOgrines:
                    this.openTab(WebTabEnum.BAK_TAB);
                    break;
                case this.btn_tabCodesAndGifts:
                    this.openTab(WebTabEnum.CODES_AND_GIFTS_TAB);
                    break;
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_help:
                    this.uiApi.me().childUiRoot.uiClass.showTabHints();
                    break;
            };
        }

        public function openTab(uiName:String=null, uiParams:Object=null):void
        {
            this.tx_horizontalBar1.visible = (!(uiName == "webBak"));
            this.tx_horizontalBar2.visible = (!(uiName == "webBak"));
            var shieldUp:* = (this.uiApi.getUi("secureModeIcon") == null);
            if (((!(shieldUp)) && ((uiName == WebTabEnum.BAK_TAB) || (uiName == WebTabEnum.SHOP_TAB))))
            {
                if (!this.uiApi.getUi("secureMode"))
                {
                    if (currentTabUi)
                    {
                        this.uiApi.getUi(currentTabUi).filters = [blurFilter];
                        this.uiApi.getUi(currentTabUi).disabled = true;
                    };
                    this.uiApi.loadUiInside("Ankama_Common::secureMode", this.uiCtr, "secureMode", {
                        "reboot":false,
                        "callBackOnSecured":this.onSecureConfirmed,
                        "callBackOnSecuredParams":[uiName, uiParams],
                        "callBackOnCancelled":this.onSecureRequestCancelled,
                        "offset":new Point(-80, -100),
                        "step":100
                    });
                    this.updateSelectedTab(uiName);
                };
                return;
            };
            if (uiName == currentTabUi)
            {
                return;
            };
            if (this.uiApi.getUi("secureMode"))
            {
                this.uiApi.unloadUi("secureMode");
            };
            if (currentTabUi == WebTabEnum.BAK_TAB)
            {
                this.closeWebModalWindow();
            };
            if (currentTabUi == WebTabEnum.SHOP_TAB)
            {
                this.sysApi.dispatchHook(DofusShopSwitchTab, null);
            };
            if (currentTabUi)
            {
                this.uiApi.unloadUi(currentTabUi);
            };
            currentTabUi = uiName;
            this.sysApi.setData("shopLastOpenedTab", currentTabUi);
            this.updateSelectedTab();
            (this.uiApi.loadUiInside(currentTabUi, this.uiCtr, currentTabUi, uiParams) as UiRootContainer);
        }

        private function onSecureConfirmed(params:Array):void
        {
            this.openTab(params[0], params[1]);
        }

        private function onSecureRequestCancelled():void
        {
            if (currentTabUi)
            {
                this.uiApi.getUi(currentTabUi).filters = null;
                this.uiApi.getUi(currentTabUi).disabled = false;
                this.updateSelectedTab();
            };
        }

        private function updateSelectedTab(uiName:String=""):void
        {
            if (!uiName)
            {
                uiName = currentTabUi;
            };
            switch (uiName)
            {
                case WebTabEnum.SHOP_TAB:
                    this.btn_tabShop.selected = true;
                    break;
                case WebTabEnum.BAK_TAB:
                    this.btn_tabOgrines.selected = true;
                    break;
                case WebTabEnum.CODES_AND_GIFTS_TAB:
                    this.btn_tabCodesAndGifts.selected = true;
                    break;
            };
        }

        private function onCodesAndGiftNotificationValue(show:Boolean):void
        {
            this.tx_notifGift.visible = show;
        }

        private function closeWebModalWindow():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("closeModal");
            };
        }


    }
}

