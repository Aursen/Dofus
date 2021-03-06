package Ankama_Config.ui
{
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.ConfigApi;
    import Ankama_Config.types.ConfigProperty;
    import d2hooks.ConfigPropertyChange;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import d2hooks.*;

    public class ConfigUi 
    {

        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="ConfigApi")]
        public var configApi:ConfigApi;
        protected var _properties:Array;


        public function init(configProperties:Array):void
        {
            var configProperty:ConfigProperty;
            this._properties = configProperties;
            for each (configProperty in this._properties)
            {
                if (!configProperty.associatedProperty)
                {
                    this.uiApi.me().getElement(configProperty.associatedComponent).disabled = true;
                }
                else
                {
                    this.updateDisplay(configProperty, this.configApi.getConfigProperty(configProperty.associatedConfigModule, configProperty.associatedProperty), true);
                };
            };
            this.sysApi.addHook(ConfigPropertyChange, this.onConfigPropertyChange);
        }

        public function reset():void
        {
            var configProperty:ConfigProperty;
            for each (configProperty in this._properties)
            {
                this.configApi.resetConfigProperty(configProperty.associatedConfigModule, configProperty.associatedProperty);
            };
        }

        public function setProperty(associatedConfigModule:String, associatedProperty:String, value:*):void
        {
            var configProperty:ConfigProperty;
            for each (configProperty in this._properties)
            {
                if (((associatedProperty == configProperty.associatedProperty) && (associatedConfigModule == configProperty.associatedConfigModule)))
                {
                    this.configApi.setConfigProperty(configProperty.associatedConfigModule, configProperty.associatedProperty, value);
                    this.updateDisplay(configProperty, value);
                    break;
                };
            };
        }

        public function showDefaultBtn(show:Boolean):void
        {
            var mainContainer:Object = this.uiApi.getUi("optionContainer");
            if (mainContainer)
            {
                mainContainer.uiClass.btn_default.visible = show;
            };
        }

        private function updateDisplay(configProperty:ConfigProperty, value:*, addHook:Boolean=false):void
        {
            var cpt:Object = this.uiApi.me().getElement(configProperty.associatedComponent);
            switch (true)
            {
                case (value is Boolean):
                    cpt.selected = value;
                    if (addHook)
                    {
                        this.uiApi.addComponentHook((cpt as GraphicContainer), "onRelease");
                    };
                    break;
            };
        }

        public function onRelease(target:Object):void
        {
            var configProperty:ConfigProperty;
            for each (configProperty in this._properties)
            {
                if (target.name == configProperty.associatedComponent)
                {
                    this.configApi.setConfigProperty(configProperty.associatedConfigModule, configProperty.associatedProperty, target.selected);
                    this.updateDisplay(configProperty, target.selected);
                    break;
                };
            };
        }

        private function onConfigPropertyChange(target:String, name:String, value:*, oldValue:*):void
        {
            var configProperty:ConfigProperty;
            for each (configProperty in this._properties)
            {
                if (((target == configProperty.associatedConfigModule) && (name == configProperty.associatedProperty)))
                {
                    this.updateDisplay(configProperty, value);
                    break;
                };
            };
        }


    }
}

