package Ankama_Web.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.ConfigApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.berilia.components.WebBrowser;
    import com.ankamagames.dofus.types.enums.WebLocationEnum;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import flash.geom.Point;

    public class WebBak 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="ConfigApi")]
        public var configApi:ConfigApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        private var _domain:int = -1;
        public var wb_ogrineBrowser:WebBrowser;


        public function main(oParam:Object=null):void
        {
            this.uiApi.addComponentHook(this.wb_ogrineBrowser, "onBrowserSessionTimeout");
            this.uiApi.addComponentHook(this.wb_ogrineBrowser, "onBrowserDomChange");
            this._domain = WebLocationEnum.WEB_LOCATION_OGRINE;
            this.sysApi.goToOgrinePortal(this.wb_ogrineBrowser);
        }

        public function showTabHints():void
        {
            this.hintsApi.showSubHints();
        }

        public function destroy():void
        {
            this.uiApi.removeComponentHook(this.wb_ogrineBrowser, "onBrowserSessionTimeout");
            this.uiApi.removeComponentHook(this.wb_ogrineBrowser, "onBrowserDomChange");
        }

        public function goToShopArticle(pArticleId:uint=0, pCategoryId:uint=0, pPage:uint=0):String
        {
            this.sysApi.log(4, (((((("goToShopArticle(" + pArticleId) + ", ") + pCategoryId) + ", ") + pPage) + ")"));
            try
            {
                if (!pCategoryId)
                {
                    this.sysApi.log(4, "goToShopArticle() has no categoryId defined!");
                    return ("categoryId cannot be null!");
                };
                if (!pArticleId)
                {
                    pPage = 1;
                };
                this.uiApi.getUi("webBase").uiClass.openTab("webShop", {
                    "articleId":pArticleId,
                    "categoryId":pCategoryId,
                    "page":pPage
                });
                return ("success");
            }
            catch(error:Error)
            {
                return (error.message);
            };
            return ("unknown error");
        }

        public function openUnlockSecureModeUi():void
        {
            var uiCtr:GraphicContainer;
            try
            {
                this.uiApi.getUi(this.uiApi.me().name).filters = [WebBase.blurFilter];
                this.uiApi.getUi(this.uiApi.me().name).disabled = true;
                uiCtr = WebBase(this.uiApi.getUi("webBase").uiClass).uiCtr;
                this.uiApi.loadUiInside("Ankama_Common::secureMode", uiCtr, "secureMode", {
                    "reboot":false,
                    "callBackOnSecured":this.onSecureModeUnlocked,
                    "callBackOnCancelled":this.onSecureModeCancelled,
                    "offset":new Point(-80, -100),
                    "step":100
                });
            }
            catch(error:Error)
            {
            };
        }

        public function onSecureModeUnlocked(params:*=null):void
        {
            this.uiApi.getUi(this.uiApi.me().name).filters = [];
            this.uiApi.getUi(this.uiApi.me().name).disabled = false;
            this.sysApi.goToOgrinePortal(this.wb_ogrineBrowser);
        }

        public function onSecureModeCancelled(params:*=null):void
        {
            this.uiApi.getUi(this.uiApi.me().name).filters = [];
            this.uiApi.getUi(this.uiApi.me().name).disabled = false;
        }

        public function onBrowserDomChange(target:*):void
        {
            this.wb_ogrineBrowser.javascriptSetVar("window.goToShopArticle", this.goToShopArticle);
            this.wb_ogrineBrowser.javascriptSetVar("window.openUnlockSecureModeUi", this.openUnlockSecureModeUi);
        }

        public function onBrowserSessionTimeout(target:*):void
        {
            this.sysApi.refreshUrl(this.wb_ogrineBrowser, this._domain);
        }


    }
} Ankama_Web.ui

