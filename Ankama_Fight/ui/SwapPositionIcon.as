package Ankama_Fight.ui
{
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.components.Texture;
    import d2enums.ComponentHookList;
    import d2hooks.ShowSwapPositionRequestMenu;
    import d2actions.TimelineEntityOver;
    import d2actions.TimelineEntityOut;

    public class SwapPositionIcon 
    {

        private var _requestId:uint;
        private var _isRequester:Boolean;
        private var _entityId:Number;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var tx_icon:Texture;


        public function main(pData:Object):void
        {
            this._requestId = pData.requestId;
            this._isRequester = pData.isRequester;
            this._entityId = pData.entityId;
            this.tx_icon.uri = this.uiApi.createUri((this.uiApi.me().getConstant("icons_uri") + ((this._isRequester) ? "swapRequested" : "swapRequest")));
            this.tx_icon.handCursor = true;
            this.uiApi.addComponentHook(this.tx_icon, ComponentHookList.ON_RELEASE);
            if (pData.rollEvents)
            {
                this.uiApi.addComponentHook(this.tx_icon, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(this.tx_icon, ComponentHookList.ON_ROLL_OUT);
            };
        }

        public function unload():void
        {
            if (this.uiApi.getUi("swapPositionMenu"))
            {
                this.modContextMenu.closeAllMenu();
            };
        }

        public function onRelease(pTarget:Object):void
        {
            if (pTarget == this.tx_icon)
            {
                this.sysApi.dispatchHook(ShowSwapPositionRequestMenu, this._requestId, this._isRequester);
            };
        }

        public function onRollOver(pTarget:Object):void
        {
            if (pTarget == this.tx_icon)
            {
                this.sysApi.sendAction(new TimelineEntityOver(this._entityId, true, false));
            };
        }

        public function onRollOut(pTarget:Object):void
        {
            if (pTarget == this.tx_icon)
            {
                this.sysApi.sendAction(new TimelineEntityOut(this._entityId));
            };
        }


    }
}

