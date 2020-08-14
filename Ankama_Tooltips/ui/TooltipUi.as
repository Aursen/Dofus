package Ankama_Tooltips.ui
{
    import flash.utils.Timer;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.components.Label;
    import d2hooks.FontActiveTypeChanged;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import flash.events.TimerEvent;
    import d2hooks.*;

    public class TooltipUi 
    {

        private var _timerHide:Timer;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        public var lbl_content:Label;


        public function main(oParam:Object=null):void
        {
            if (((oParam.tooltip) && (oParam.tooltip.chunkType == "htmlChunks")))
            {
                this.sysApi.addHook(FontActiveTypeChanged, this.onFontActiveTypeChanged);
                this.onFontActiveTypeChanged();
                this.lbl_content.multiline = true;
                this.lbl_content.text = oParam.tooltip.htmlText;
            };
            if (oParam.zoom > 1)
            {
                this.uiApi.me().scale = oParam.zoom;
            };
            this.tooltipApi.place(oParam.position, oParam.showDirectionalArrow, oParam.point, oParam.relativePoint, oParam.offset, false, -1, null, oParam.alwaysDisplayed);
            if (oParam.autoHide)
            {
                this._timerHide = new Timer(ProtocolConstantsEnum.DEFAULT_TOOLTIP_DURATION);
                this._timerHide.addEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerHide.start();
            };
        }

        private function onFontActiveTypeChanged():void
        {
            var tooltipCssName:String = "tooltip_item";
            var activeFontType:String = this.sysApi.getActiveFontType();
            if (((activeFontType) && (!(activeFontType == "default"))))
            {
                tooltipCssName = (tooltipCssName + ("-" + activeFontType));
            };
            this.uiApi.setLabelStyleSheet(this.lbl_content, (((this.sysApi.getConfigEntry("config.ui.skin") + "css/") + tooltipCssName) + ".css"));
        }

        private function onTimer(e:TimerEvent):void
        {
            this._timerHide.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this.uiApi.hideTooltip(this.uiApi.me().name);
        }

        public function unload():void
        {
            if (this._timerHide)
            {
                this._timerHide.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerHide.stop();
                this._timerHide = null;
            };
        }


    }
} Ankama_Tooltips.ui

