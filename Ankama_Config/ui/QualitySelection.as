package Ankama_Config.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.ConfigApi;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.TextArea;
    import d2enums.ComponentHookList;
    import d2hooks.SetDofusQuality;
    import flash.ui.MouseCursor;
    import com.ankamagames.berilia.enums.StatesEnum;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import d2hooks.*;

    public class QualitySelection 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="ConfigApi")]
        public var configApi:ConfigApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _qualityTextures:Array = new Array();
        private var _selectedQuality:uint = 2;
        private var _selectedTypo:uint = 1;
        private var _creaturesLimitByQuality:Array = [10, 20, 100];
        public var mainCtr:Object;
        public var grid_quality:Grid;
        public var btn_quality:ButtonContainer;
        public var btn_typo:ButtonContainer;
        public var btn_small:ButtonContainer;
        public var btn_big:ButtonContainer;
        public var lbl_title:Label;
        public var ctr_quality:GraphicContainer;
        public var ctr_typo:GraphicContainer;
        public var lbl_big_example:TextArea;
        public var lbl_small_example:TextArea;


        public function main(params:Object):void
        {
            this.uiApi.addComponentHook(this.btn_big, ComponentHookList.ON_DOUBLE_CLICK);
            this.uiApi.addComponentHook(this.btn_small, ComponentHookList.ON_DOUBLE_CLICK);
            this.uiApi.addComponentHook(this.lbl_big_example, ComponentHookList.ON_DOUBLE_CLICK);
            this.uiApi.addComponentHook(this.lbl_small_example, ComponentHookList.ON_DOUBLE_CLICK);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            var qualities:Array = [{
                "id":0,
                "title":"low",
                "x":130,
                "y":60
            }, {
                "id":1,
                "title":"medium",
                "x":150,
                "y":45
            }, {
                "id":2,
                "title":"high",
                "x":175,
                "y":80
            }];
            this.grid_quality.dataProvider = qualities;
            this.grid_quality.selectedIndex = this._selectedQuality;
            this._qualityTextures[this._selectedQuality].btn_quality.selected = true;
        }

        public function unload():void
        {
            this._qualityTextures = null;
        }

        public function updateQualitySlot(data:*, componentsRef:*, selected:Boolean):void
        {
            if (data)
            {
                componentsRef.lbl_title.text = this.uiApi.getText((("ui.option.quality." + data.title) + "Quality")).toLocaleUpperCase();
                componentsRef.lbl_processor.text = this.uiApi.getText((("ui.option.quality." + data.title) + ".processor"));
                componentsRef.lbl_ram.text = this.uiApi.getText((("ui.option.quality." + data.title) + ".ram"));
                componentsRef.tx_decoQuality.uri = this.uiApi.createUri(this.uiApi.me().getConstant(("bg_quality" + data.id)));
                this._qualityTextures[data.id] = componentsRef;
            };
        }

        private function selectQuality():void
        {
            this.sysApi.dispatchHook(SetDofusQuality, this._selectedQuality);
            this.configApi.setConfigProperty("tiphon", "creaturesMode", this._creaturesLimitByQuality[this._selectedQuality]);
            if (!this.ctr_typo.visible)
            {
                this.configApi.setConfigProperty("dofus", "askForQualitySelection", false);
                this.ctr_quality.visible = false;
                this.lbl_title.text = this.uiApi.getText("ui.option.typo.select");
                this.lbl_big_example.text = this.uiApi.getText("ui.option.typo.exampleBig", 17);
                this.lbl_small_example.text = this.uiApi.getText("ui.option.typo.example", 15);
                this.btn_big.selected = true;
                this.ctr_typo.visible = true;
            }
            else
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }

        private function selectTextSize():void
        {
            this.sysApi.changeActiveFontType(((this._selectedTypo == 0) ? "smallScreen" : ""));
            this.configApi.setConfigProperty("dofus", "smallScreenFont", (this._selectedTypo == 0));
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        public function onRollOver(target:Object):void
        {
            this.sysApi.setMouseCursor(MouseCursor.BUTTON);
            if (target == this.lbl_small_example)
            {
                this.btn_small.state = StatesEnum.STATE_OVER;
            }
            else
            {
                if (target == this.lbl_big_example)
                {
                    this.btn_big.state = StatesEnum.STATE_OVER;
                };
            };
        }

        public function onRollOut(target:Object):void
        {
            this.sysApi.setMouseCursor(MouseCursor.AUTO);
            if (((!(this.btn_small.selected)) && (target == this.lbl_small_example)))
            {
                this.btn_small.state = StatesEnum.STATE_NORMAL;
            }
            else
            {
                if (((!(this.btn_big.selected)) && (target == this.lbl_big_example)))
                {
                    this.btn_big.state = StatesEnum.STATE_NORMAL;
                };
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_quality:
                    this.selectQuality();
                    break;
                case this.btn_typo:
                    this.selectTextSize();
                    break;
                case this.btn_small:
                case this.lbl_small_example:
                    this._selectedTypo = 0;
                    this.btn_small.selected = true;
                    break;
                case this.btn_big:
                case this.lbl_big_example:
                    this._selectedTypo = 1;
                    this.btn_big.selected = true;
                    break;
            };
        }

        public function onDoubleClick(target:Object):void
        {
            switch (target)
            {
                case this.btn_small:
                case this.lbl_small_example:
                    this._selectedTypo = 0;
                    this.btn_small.selected = true;
                    this.selectTextSize();
                    break;
                case this.btn_big:
                case this.lbl_big_example:
                    this._selectedTypo = 1;
                    this.btn_big.selected = true;
                    this.selectTextSize();
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (((target == this.grid_quality) && (!(selectMethod == SelectMethodEnum.AUTO))))
            {
                this._selectedQuality = this.grid_quality.selectedItem.id;
                if (selectMethod == SelectMethodEnum.DOUBLE_CLICK)
                {
                    this.selectQuality();
                };
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    if (!this.ctr_typo.visible)
                    {
                        this._selectedQuality = this.grid_quality.selectedItem.id;
                        this.selectQuality();
                    }
                    else
                    {
                        this.selectTextSize();
                    };
                    return (true);
            };
            return (false);
        }


    }
} Ankama_Config.ui

