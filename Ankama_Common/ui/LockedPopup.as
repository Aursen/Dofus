package Ankama_Common.ui
{
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import flash.utils.Timer;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import flash.utils.getTimer;
    import flash.events.TimerEvent;
    import d2hooks.ClosePopup;
    import d2hooks.*;

    public class LockedPopup 
    {

        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        protected var onCancelFunction:Function = null;
        private var _autoCloseTimer:Timer;
        private var _closeAllowed:Boolean = true;
        private var _autoClose:Boolean = false;
        private var _remainedTime:uint;
        private var _clockStart:uint;
        private var _duration:uint;
        public var popCtr:GraphicContainer;
        public var btn_ok:ButtonContainer;
        public var btn_lbl_btn_ok:Label;
        public var lbl_title_popup:Label;
        public var lbl_content:Label;


        public function main(param:Object):void
        {
            var hook:*;
            var duration:uint;
            this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
            this.btn_ok.soundId = SoundEnum.WINDOW_CLOSE;
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            if (param)
            {
                if (param.hideModalContainer)
                {
                    this.popCtr.getUi().showModalContainer = false;
                }
                else
                {
                    this.popCtr.getUi().showModalContainer = true;
                };
                if (!this.sysApi.isFightContext())
                {
                    this.btn_ok.disabled = true;
                    this._closeAllowed = false;
                    this._autoClose = param.autoClose;
                    if (param.closeAtHook)
                    {
                        for each (hook in param.closeParam)
                        {
                            this.sysApi.addHook(hook, this.onCloseHook);
                        };
                    }
                    else
                    {
                        duration = (uint(param.closeParam[0]) * 1000);
                        if (duration > 10000)
                        {
                            duration = 10000;
                        };
                        this._remainedTime = (duration / 1000);
                        this.btn_lbl_btn_ok.text = (((this.uiApi.getText("ui.common.ok") + " (") + this._remainedTime) + ")");
                        this._clockStart = getTimer();
                        this._duration = duration;
                        this.sysApi.addEventListener(this.onEnterFrame, "checkTimer");
                    };
                };
                this.lbl_title_popup.text = param.title;
                if (param.useHyperLink)
                {
                    this.lbl_content.hyperlinkEnabled = true;
                    this.lbl_content.useStyleSheet = true;
                };
                this.lbl_content.text = param.content;
            }
            else
            {
                throw (new Error("Can't load popup without properties."));
            };
            this.popCtr.height = ((Math.floor(this.lbl_content.textfield.textHeight) + this.lbl_content.y) + 92);
        }

        public function unload():void
        {
            if (this._autoCloseTimer)
            {
                this._autoCloseTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
                this._autoCloseTimer.stop();
                this._autoCloseTimer = null;
            };
            this.sysApi.dispatchHook(ClosePopup);
            this.sysApi.removeEventListener(this.onEnterFrame);
        }

        private function allowClose():void
        {
            this._closeAllowed = true;
            this.btn_ok.disabled = false;
            if (this._autoClose)
            {
                this._autoCloseTimer = new Timer(2000, 1);
                this._autoCloseTimer.start();
                this._autoCloseTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            };
        }

        private function closePopup():void
        {
            if (this._closeAllowed)
            {
                if (this._autoCloseTimer)
                {
                    this._autoCloseTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
                    this._autoCloseTimer.stop();
                    this._autoCloseTimer = null;
                };
                if (this.onCancelFunction != null)
                {
                    this.onCancelFunction();
                };
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }

        public function onRelease(target:Object):void
        {
            if (target == this.btn_ok)
            {
                this.closePopup();
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                case "closeUi":
                    this.closePopup();
                    return (true);
            };
            return (false);
        }

        public function onCloseHook(param:Object):void
        {
            this.allowClose();
        }

        public function onEnterFrame():void
        {
            var clock:uint = getTimer();
            var remainedTime:int = int(Math.floor(((this._duration - (clock - this._clockStart)) / 1000)));
            if (this._remainedTime > remainedTime)
            {
                this.btn_lbl_btn_ok.text = (((this.uiApi.getText("ui.common.ok") + " (") + remainedTime) + ")");
                this._remainedTime = remainedTime;
            };
            if (remainedTime <= 0)
            {
                this.sysApi.removeEventListener(this.onEnterFrame);
                this.btn_lbl_btn_ok.text = this.uiApi.getText("ui.common.ok");
                this.allowClose();
            };
        }

        public function onTimeOut(e:TimerEvent):void
        {
            this.closePopup();
        }


    }
} Ankama_Common.ui

