package Ankama_Tooltips.ui
{
    import flash.utils.Timer;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import flash.geom.Point;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import flash.events.TimerEvent;

    public class TextInfoTooltipUi 
    {

        private var _timerHide:Timer;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        private var _currentCss:String;
        private var _currentCssClass:String = "text";
        public var lbl_content:Object;
        public var backgroundCtr:Object;


        public function main(oParam:Object=null):void
        {
            var lastCss:String = this._currentCss;
            var cssInfo:String = oParam.data.css;
            if (cssInfo == null)
            {
                this._currentCss = (this.uiApi.me().getConstant("css") + "tooltip_default.css");
            }
            else
            {
                this._currentCss = cssInfo;
            };
            if (oParam.data.maxWidth)
            {
                this.lbl_content.multiline = true;
                this.lbl_content.wordWrap = true;
            }
            else
            {
                this.lbl_content.multiline = false;
                this.lbl_content.wordWrap = false;
            };
            if (this._currentCss != lastCss)
            {
                this.lbl_content.css = this.uiApi.createUri(this._currentCss);
            };
            if (this._currentCssClass != oParam.data.cssClass)
            {
                this._currentCssClass = oParam.data.cssClass;
                this.lbl_content.cssClass = this._currentCssClass;
            };
            this.lbl_content.text = oParam.data.content;
            if (oParam.data.bgCornerRadius)
            {
                this.backgroundCtr.bgCornerRadius = oParam.data.bgCornerRadius;
            };
            this.lbl_content.fullWidthAndHeight(oParam.data.maxWidth);
            this.backgroundCtr.width = (this.lbl_content.textfield.width + 14);
            this.backgroundCtr.height = (this.lbl_content.textfield.height + 14);
            var directionalArrowInfo:Object = new Object();
            directionalArrowInfo.showDirectionalArrow = oParam.showDirectionalArrow;
            directionalArrowInfo.anchors = new Point(this.backgroundCtr.x, this.backgroundCtr.y);
            this.tooltipApi.place(oParam.position, directionalArrowInfo, oParam.point, oParam.relativePoint, oParam.offset, oParam.data.checkSuperposition, oParam.data.cellId);
            if (oParam.autoHide)
            {
                this._timerHide = new Timer(ProtocolConstantsEnum.DEFAULT_TOOLTIP_DURATION);
                this._timerHide.addEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerHide.start();
            };
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
}

