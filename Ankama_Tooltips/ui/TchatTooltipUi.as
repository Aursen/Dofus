package Ankama_Tooltips.ui
{
    import flash.utils.Timer;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import Ankama_Tooltips.Api;
    import flash.events.TimerEvent;

    public class TchatTooltipUi 
    {

        private var _timerHide:Timer;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        public var mainCtr:Object;
        public var chatCtr:Object;
        public var lblMsg:Object;
        public var txMsg:Object;


        public function main(oParam:Object=null):void
        {
            if (!this.sysApi.worldIsVisible())
            {
                this.uiApi.hideTooltip(this.uiApi.me().name);
                return;
            };
            this.mainCtr.dynamicPosition = true;
            this.txMsg.dynamicPosition = true;
            var msg:String = Api.chat.getStaticHyperlink(oParam.data.text);
            msg = Api.chat.unEscapeChatString(msg);
            this.lblMsg.text = msg;
            this.lblMsg.mouseChildren = false;
            if (this.chatCtr.width > 200)
            {
                this.lblMsg.width = 200;
                this.lblMsg.multiline = true;
                this.lblMsg.wordWrap = true;
                this.lblMsg.fullWidthAndHeight();
            };
            this.txMsg.width = (this.chatCtr.width + 15);
            this.txMsg.height = (this.chatCtr.height + 15);
            var point:Object = this.tooltipApi.placeArrow(oParam.position);
            if (point.bottomFlip)
            {
                this.txMsg.hFlip();
                this.lblMsg.y = (this.lblMsg.y + 9);
            };
            if (point.leftFlip)
            {
                this.txMsg.vFlip();
            };
            if (oParam.autoHide)
            {
                this._timerHide = new Timer((4000 + (msg.length * 30)));
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

