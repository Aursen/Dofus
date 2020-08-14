package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import com.ankamagames.berilia.components.WebBrowser;

    public class BrowserDomainReadyAction implements Action 
    {

        public var browser:WebBrowser;


        public static function create(browser:WebBrowser):BrowserDomainReadyAction
        {
            var a:BrowserDomainReadyAction = new (BrowserDomainReadyAction)();
            a.browser = browser;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.common.actions

