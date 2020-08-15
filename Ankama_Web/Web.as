package Ankama_Web
{
    import flash.display.Sprite;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import Ankama_Web.ui.WebBase;
    import Ankama_Web.ui.WebShop;
    import Ankama_Web.ui.WebBak;
    import Ankama_Web.ui.WebCodesAndGifts;
    import Ankama_Web.ui.SharePopup;
    import Ankama_Web.ui.ShopPopupAttitude;
    import Ankama_Web.ui.ShopPopupCompanionPack;
    import Ankama_Web.ui.ShopPopupCompanion;
    import Ankama_Web.ui.ShopPopupFinishMove;
    import Ankama_Web.ui.ShopPopupHarness;
    import Ankama_Web.ui.ShopPopupHavenBag;
    import Ankama_Web.ui.ShopPopupItemSet;
    import Ankama_Web.ui.ShopPopupLivingObject;
    import Ankama_Web.ui.ShopPopupPack;
    import Ankama_Web.ui.ShopPopupMysteryBox;
    import Ankama_Web.ui.ShopPopupConfirmBuy;
    import Ankama_Web.ui.ShopPopupOneClickRegister;
    import Ankama_Web.ui.ShopPopupOneClickCode;
    import Ankama_Web.ui.ShopPopupOneClickPayment;
    import Ankama_Web.ui.MysteryBoxPopup;
    import Ankama_Web.ui.CodeResultPopup;
    import d2hooks.OpenWebService;
    import d2hooks.OpenSharePopup;
    import com.ankamagames.berilia.enums.StrataEnum;
    import d2hooks.*;

    public class Web extends Sprite 
    {

        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var include_webBase:WebBase = null;
        private var include_webShop:WebShop = null;
        private var include_webBak:WebBak = null;
        private var include_webCodes:WebCodesAndGifts = null;
        private var include_shareItem:SharePopup = null;
        private var _include_shopPopupAttitude:ShopPopupAttitude = null;
        private var _include_shopPopupCompanion:ShopPopupCompanionPack = null;
        private var _include_shopPopupCompanionPack:ShopPopupCompanion = null;
        private var _include_shopPopupFinishMove:ShopPopupFinishMove = null;
        private var _include_shopPopupHarness:ShopPopupHarness = null;
        private var _include_shopPopupHavenBag:ShopPopupHavenBag = null;
        private var _include_shopPopupItemSet:ShopPopupItemSet = null;
        private var _include_shopPopupLivingObject:ShopPopupLivingObject = null;
        private var _include_shopPopupPack:ShopPopupPack = null;
        private var _include_shopPopupMysteryBox:ShopPopupMysteryBox = null;
        private var _include_shopPopupConfirmBuy:ShopPopupConfirmBuy = null;
        private var _include_shopPopupOneClickRegister:ShopPopupOneClickRegister = null;
        private var _include_shopPopupOneClickCode:ShopPopupOneClickCode = null;
        private var _include_shopPopupOneClickPayment:ShopPopupOneClickPayment = null;
        private var _include_mbPopup:MysteryBoxPopup = null;
        private var _include_cdPopup:CodeResultPopup = null;


        public function main():void
        {
            this.sysApi.addHook(OpenWebService, this.onOpenWebService);
            this.sysApi.addHook(OpenSharePopup, this.onOpenSharePopup);
        }

        private function onOpenWebService(uiName:String, uiParams:*):void
        {
            if (this.uiApi.getUi("webBase"))
            {
                if (((uiName) && (!(WebBase.currentTabUi == uiName))))
                {
                    this.uiApi.getUi("webBase").uiClass.openTab(uiName, uiParams);
                }
                else
                {
                    this.uiApi.unloadUi("webBase");
                };
            }
            else
            {
                this.uiApi.loadUi("webBase", "webBase", [uiName, uiParams]);
            };
        }

        private function onOpenSharePopup(url:String):void
        {
            this.uiApi.loadUi("sharePopup", "sharePopup", {"url":url}, StrataEnum.STRATA_HIGH, null, true);
        }


    }
}

