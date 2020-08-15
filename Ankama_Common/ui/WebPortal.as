package Ankama_Common.ui
{
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.WebBrowser;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofus.types.enums.WebLocationEnum;
    import d2hooks.NumericWhoIs;
    import d2hooks.*;

    public class WebPortal 
    {

        private static var _lastDomain:int = -1;

        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        public var btnClose:ButtonContainer;
        public var btn_help:ButtonContainer;
        public var browser:WebBrowser;
        public var mainCtr:GraphicContainer;
        private var _domain:int = -1;
        private var _args:Object;


        public function main(arg:*):void
        {
            var accountId:uint;
            this.uiApi.addComponentHook(this.btnClose, "onRelease");
            this.uiApi.addComponentHook(this.browser, "onBrowserSessionTimeout");
            this.uiApi.addComponentHook(this.browser, "onBrowserDomReady");
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortcut);
            this.uiApi.addComponentHook(this.btn_help, ComponentHookList.ON_RELEASE);
            this._domain = arg[0];
            _lastDomain = this._domain;
            this._args = arg[2];
            if ((((((this._domain == WebLocationEnum.WEB_LOCATION_ANKABOX_SEND_MESSAGE) && (this._args)) && (this._args.length > 1)) && (this._args[0] == 0)) && (this._args[1])))
            {
                accountId = this.sysApi.getAccountId(this._args[1]);
                if (!accountId)
                {
                    this._args = [0, this._args[1]];
                    this.sysApi.addHook(NumericWhoIs, this.onAccountInfo);
                };
            };
            this.refreshPortal();
        }

        public function goTo(domain:int, showBigClose:Boolean, args:Array):void
        {
            this._domain = domain;
            _lastDomain = this._domain;
            this._args = args;
            this.refreshPortal();
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btnClose:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_help:
                    this.hintsApi.showSubHints();
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
            if (s == "validUi")
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
            return (true);
        }

        public function onBrowserSessionTimeout(target:*):void
        {
            this.sysApi.refreshUrl(this.browser, this._domain);
        }

        public function onBrowserDomReady(target:*):void
        {
        }

        public function onAccountInfo(playerId:Number, accountId:uint):void
        {
            this._args[0] = accountId;
            this.refreshPortal();
        }

        private function refreshPortal():void
        {
            var webBrowser:WebBrowser = this.browser;
            if (this._domain == WebLocationEnum.WEB_LOCATION_OGRINE)
            {
                this.sysApi.goToOgrinePortal(webBrowser);
            }
            else
            {
                if (this._domain == WebLocationEnum.WEB_LOCATION_ANKABOX)
                {
                    this.sysApi.goToAnkaBoxPortal(webBrowser);
                }
                else
                {
                    if (this._domain == WebLocationEnum.WEB_LOCATION_ANKABOX_LAST_UNREAD)
                    {
                        this.sysApi.goToAnkaBoxLastMessage(webBrowser);
                    }
                    else
                    {
                        if (this._domain == WebLocationEnum.WEB_LOCATION_ANKABOX_SEND_MESSAGE)
                        {
                            if (this._args)
                            {
                                if (this._args[0])
                                {
                                    this.sysApi.goToAnkaBoxSend(webBrowser, uint(this._args[0]));
                                }
                                else
                                {
                                    this.sysApi.goToAnkaBoxPortal(webBrowser);
                                };
                            };
                        };
                    };
                };
            };
            if (!webBrowser)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }


    }
}

