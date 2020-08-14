package Ankama_Config.ui
{
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import d2enums.ComponentHookList;

    public class ConfigSupport extends ConfigUi 
    {

        public var btnGotoSupport:ButtonContainer;
        public var btnBugReport:ButtonContainer;
        public var btn_allowDebug:ButtonContainer;
        public var lbl_infoDebug:Label;
        public var isInDebugMode:Boolean;


        public function main(arg:*):void
        {
            uiApi.addComponentHook(this.btnGotoSupport, ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.btnBugReport, ComponentHookList.ON_RELEASE);
            showDefaultBtn(false);
            var os:String = sysApi.getOs();
            var bugReportKey:String = ((os == "Mac OS") ? "F1" : "F11");
            this.isInDebugMode = configApi.getDebugMode();
            this.lbl_infoDebug.text = uiApi.getText("ui.option.debugMode.info", bugReportKey);
            uiApi.addComponentHook(this.btn_allowDebug, ComponentHookList.ON_RELEASE);
            this.btn_allowDebug.selected = this.isInDebugMode;
            if (configApi.debugFileExists())
            {
                this.btn_allowDebug.softDisabled = true;
                uiApi.addComponentHook(this.btn_allowDebug, ComponentHookList.ON_ROLL_OVER);
                uiApi.addComponentHook(this.btn_allowDebug, ComponentHookList.ON_ROLL_OUT);
            };
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btnGotoSupport:
                    sysApi.goToUrl(uiApi.getText("ui.link.support"));
                    break;
                case this.btnBugReport:
                    sysApi.goToUrl(uiApi.getText("ui.link.betaReport"));
                    break;
                case this.btn_allowDebug:
                    this.isInDebugMode = this.btn_allowDebug.selected;
                    configApi.setDebugMode(this.isInDebugMode);
                    sysApi.enableLogs(this.isInDebugMode);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.option.debugMode.hasFile")), target, false, "standard", 5, 3, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            uiApi.hideTooltip();
        }


    }
} Ankama_Config.ui

