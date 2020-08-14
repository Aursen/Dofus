package Ankama_Tooltips.ui
{
    import flash.utils.Timer;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.AveragePricesApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import Ankama_Tooltips.Api;
    import com.ankamagames.dofus.datacenter.items.Item;
    import flash.events.TimerEvent;

    public class ItemNameTooltipUi 
    {

        private static var _shortcutColor:String;

        private var _timerHide:Timer;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="AveragePricesApi")]
        public var averagePricesApi:AveragePricesApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        public var backgroundCtr:Object;
        public var lbl_content:Object;
        private var _itemWrapper:Object;
        private var _shortcutKey:String;
        private var _timerShowItemTooltip:Timer;
        private var _param:Object;
        private var _alwaysShowTooltipModuleException:Array = ["giftMenu"];


        public function main(oParam:Object=null):void
        {
            var delay:int;
            if (!_shortcutColor)
            {
                _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                _shortcutColor = _shortcutColor.replace("0x", "#");
            };
            this._param = oParam;
            var displayItemToolTip:Boolean = ((!(this.sysApi.getOption("itemTooltipDelay", "dofus") == -1)) && (((this._param.makerParam.hasOwnProperty("nameOnly")) && (!(this._param.makerParam.nameOnly))) || (((!(this._param.makerParam.hasOwnProperty("nameOnly"))) && (Api.system.getOption("displayTooltips", "dofus"))) || (!(this._alwaysShowTooltipModuleException.indexOf(this._param.tooltip.uiModuleName) == -1)))));
            var text:String = "";
            if (((!(this._param.data == null)) && (this._param.data is Item)))
            {
                this._itemWrapper = this._param.data;
                text = this._itemWrapper.name;
            }
            else
            {
                this._itemWrapper = this._param.data.itemWrapper;
                this._shortcutKey = this._param.data.shortcutKey;
                text = this._itemWrapper.name;
                if (((this._shortcutKey) && (!(this._shortcutKey == ""))))
                {
                    text = (text + ((((" <font color='" + _shortcutColor) + "'>(") + this._shortcutKey) + ")</font>"));
                };
            };
            this.lbl_content.text = text;
            if ((((this.sysApi.isInGame()) && (!(displayItemToolTip))) && (this._itemWrapper.exchangeable)))
            {
                this.lbl_content.appendText(this.averagePricesApi.getItemAveragePriceString(this._itemWrapper));
            };
            this.lbl_content.multiline = true;
            this.lbl_content.wordWrap = false;
            this.lbl_content.fullWidthAndHeight();
            this.backgroundCtr.width = (this.lbl_content.textfield.width + 12);
            this.backgroundCtr.height = (this.lbl_content.textfield.height + 12);
            this.tooltipApi.place(this._param.position, this._param.showDirectionalArrow, this._param.point, this._param.relativePoint, this._param.offset);
            if (displayItemToolTip)
            {
                delay = this.sysApi.getOption("itemTooltipDelay", "dofus");
                this._timerShowItemTooltip = new Timer(delay, 1);
                this._timerShowItemTooltip.addEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerShowItemTooltip.start();
            };
        }

        private function onTimer(e:TimerEvent):void
        {
            if (!this._timerShowItemTooltip)
            {
                return;
            };
            this._timerShowItemTooltip.stop();
            this._timerShowItemTooltip.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this._timerShowItemTooltip = null;
            this.uiApi.showTooltip(this._itemWrapper, (((this._param.makerParam.hasOwnProperty("ref")) && (!(this._param.makerParam.ref == null))) ? this._param.makerParam.ref : this._param.position), false, "standard", this._param.point, this._param.relativePoint, this._param.offset, null, null, this._param.makerParam);
        }

        public function unload():void
        {
            if (this._timerShowItemTooltip)
            {
                this._timerShowItemTooltip.stop();
                this._timerShowItemTooltip.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerShowItemTooltip = null;
            };
        }


    }
} Ankama_Tooltips.ui

