package com.ankamagames.berilia.managers
{
    import flash.desktop.NativeApplication;
    import flash.events.Event;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.events.NativeWindowDisplayStateEvent;
    import flash.display.NativeWindow;
    import com.ankamagames.berilia.types.graphic.ExternalUi;

    public class ExternalUiManager 
    {

        private static var _instance:ExternalUiManager;

        public function ExternalUiManager()
        {
            NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, this.onWindowFocus, false, 0, true);
            StageShareManager.stage.nativeWindow.addEventListener(Event.ACTIVATE, this.onWindowFocus, false, 0, true);
            StageShareManager.stage.nativeWindow.addEventListener(Event.CLOSING, this.onMainWindowClose, false, 0, true);
            StageShareManager.stage.nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, this.onWindowFocus, false, 0, true);
        }

        public static function getInstance():ExternalUiManager
        {
            if (!_instance)
            {
                _instance = new (ExternalUiManager)();
            };
            return (_instance);
        }


        protected function onMainWindowClose(event:Event):void
        {
            var w:NativeWindow;
            var windows:Array = NativeApplication.nativeApplication.openedWindows;
            for each (w in windows)
            {
                if (!w.closed)
                {
                    w.close();
                };
            };
        }

        public function registerExternalUi(eui:ExternalUi):void
        {
            eui.addEventListener(Event.ACTIVATE, this.onWindowFocus, false, 0, true);
            eui.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, this.onWindowFocus, false, 0, true);
        }

        protected function onWindowFocus(event:Event):void
        {
            var w:NativeWindow;
            var windows:Array = NativeApplication.nativeApplication.openedWindows;
            for each (w in windows)
            {
                if (w != StageShareManager.stage.nativeWindow)
                {
                    w.orderInFrontOf(StageShareManager.stage.nativeWindow);
                };
            };
        }


    }
}

