package Ankama_Social.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.ComboBox;
    import com.ankamagames.berilia.components.ColorPicker;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.dofus.datacenter.guild.EmblemSymbolCategory;
    import d2hooks.UiLoaded;
    import d2hooks.LeaveDialog;
    import d2hooks.KeyUp;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofus.datacenter.communication.NamingRule;
    import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
    import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
    import d2actions.LeaveDialog;
    import d2actions.AllianceCreationValid;
    import d2actions.AllianceModificationNameAndTagValid;
    import d2actions.AllianceModificationEmblemValid;
    import d2actions.AllianceModificationValid;
    import com.ankamagames.dofus.network.enums.SocialGroupCreationResultEnum;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import d2hooks.*;
    import d2actions.*;

    public class AllianceCreator 
    {

        public static const CREATION:uint = 0;
        public static const NAME_MODIFICATION:uint = 1;
        public static const EMBLEM_MODIFICATION:uint = 2;
        public static const MODIFICATION:uint = 3;
        public static const EMBLEM_TAB_ICON:uint = 0;
        public static const EMBLEM_TAB_BACKGROUND:uint = 1;

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        private var _mode:uint = 0;
        private var _nCurrentTab:int = -1;
        private var _emblemList:Object;
        private var _background:Object;
        private var _backgroundIdx:uint;
        private var _backgroundColor:uint;
        private var _icon:EmblemWrapper;
        private var _iconIdx:uint;
        private var _iconColor:uint;
        private var _stickEmblem:Boolean = false;
        private var _iconCategories:Array = new Array();
        private var _currentIconCat:Object;
        private var _emblemsHash:String;
        public var tx_emblem:Texture;
        public var tx_icon:Texture;
        public var bgcbb_emblemCategory:TextureBitmap;
        public var tx_nameRules:ButtonContainer;
        public var tx_tagRules:ButtonContainer;
        public var inp_alliancename:Input;
        public var inp_alliancetag:Input;
        public var gd_emblemBack:Grid;
        public var gd_emblemFront:Grid;
        public var cbb_emblemCategory:ComboBox;
        public var cp_colorPk:ColorPicker;
        public var btn_create:ButtonContainer;
        public var btn_background:ButtonContainer;
        public var btn_icon:ButtonContainer;
        public var btn_close:ButtonContainer;
        public var allianceNameCtr:GraphicContainer;
        public var emblemCreatorCtr:GraphicContainer;
        public var ctr_hexaColor:GraphicContainer;
        public var inp_hexaValue:Input;
        public var btn_hexaOk:ButtonContainer;


        public function get mode():uint
        {
            return (this._mode);
        }

        public function set mode(v:uint):void
        {
            this._mode = v;
            this.refreshUIMode();
        }

        public function main(... args):void
        {
            var emblemCat:EmblemSymbolCategory;
            this.sysApi.addHook(UiLoaded, this.onUiLoaded);
            this.sysApi.addHook(d2hooks.LeaveDialog, this.onLeaveDialog);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.uiApi.addComponentHook(this.tx_emblem, "onTextureReady");
            this.uiApi.addComponentHook(this.gd_emblemBack, "onSelectItem");
            this.uiApi.addComponentHook(this.gd_emblemFront, "onSelectItem");
            this.uiApi.addComponentHook(this.cbb_emblemCategory, "onSelectItem");
            this.uiApi.addComponentHook(this.cp_colorPk, "onColorChange");
            this.uiApi.addComponentHook(this.cp_colorPk, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_create, "onRelease");
            this.uiApi.addComponentHook(this.btn_background, "onRelease");
            this.uiApi.addComponentHook(this.btn_icon, "onRelease");
            this.uiApi.addComponentHook(this.btn_close, "onRelease");
            this.uiApi.addComponentHook(this.tx_nameRules, "onRollOver");
            this.uiApi.addComponentHook(this.tx_nameRules, "onRollOut");
            this.uiApi.addComponentHook(this.tx_tagRules, "onRollOver");
            this.uiApi.addComponentHook(this.tx_tagRules, "onRollOut");
            this.uiApi.addComponentHook(this.inp_alliancename, "onChange");
            this.uiApi.addComponentHook(this.inp_alliancetag, "onChange");
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.ctr_hexaColor.visible = false;
            if (args[0][0])
            {
                if (args[0][1])
                {
                    this._mode = MODIFICATION;
                }
                else
                {
                    this._mode = NAME_MODIFICATION;
                };
            }
            else
            {
                if (args[0][1])
                {
                    this._mode = EMBLEM_MODIFICATION;
                }
                else
                {
                    this._mode = CREATION;
                };
            };
            this.gd_emblemBack.visible = true;
            this.gd_emblemBack.disabled = false;
            this.gd_emblemFront.visible = false;
            this.tx_emblem.dispatchMessages = true;
            this._emblemList = this.dataApi.getEmblems();
            var namingRuleAllianceName:NamingRule = this.sysApi.getCurrentServer().community.namingRuleAllianceName;
            var namingRuleAllianceTag:NamingRule = this.sysApi.getCurrentServer().community.namingRuleAllianceTag;
            this.inp_alliancename.maxChars = namingRuleAllianceName.maxLength;
            this.inp_alliancetag.maxChars = namingRuleAllianceTag.maxLength;
            var esc:Object = this.dataApi.getAllEmblemSymbolCategories();
            var allowedCategories:int = this.socialApi.getAllowedGuildEmblemSymbolCategories();
            for each (emblemCat in esc)
            {
                if ((allowedCategories & Math.pow(2, (emblemCat.id - 1))))
                {
                    this._iconCategories.push({
                        "label":emblemCat.name,
                        "value":emblemCat.id
                    });
                };
            };
            this.cbb_emblemCategory.dataProvider = this._iconCategories;
            this._currentIconCat = this._iconCategories[0];
        }

        public function unload():void
        {
        }

        public function selectBackground(item:Object, updateGrid:Boolean):void
        {
            if (item != null)
            {
                if (((updateGrid) && (this._nCurrentTab == EMBLEM_TAB_BACKGROUND)))
                {
                    this.gd_emblemBack.selectedItem = item;
                };
                this._background = item;
                this.tx_emblem.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("picto_uri") + "backalliance/") + item.iconUri.fileName.split(".")[0]) + ".swf"));
            };
        }

        public function selectIcon(item:EmblemWrapper, updateGrid:Boolean):void
        {
            var icon:EmblemSymbol;
            if (item != null)
            {
                if (((updateGrid) && (this._nCurrentTab == EMBLEM_TAB_ICON)))
                {
                    this.gd_emblemFront.selectedItem = item;
                };
                this._icon = item;
                this.tx_icon.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("picto_uri") + "up/") + item.iconUri.fileName.split(".")[0]) + ".swf"));
                icon = this.dataApi.getEmblemSymbol(this._icon.idEmblem);
                if (icon.colorizable)
                {
                    this.utilApi.changeColor(this.tx_icon, this._iconColor, 0);
                }
                else
                {
                    this.utilApi.changeColor(this.tx_icon, this._iconColor, 0, true);
                };
            };
        }

        public function getCurrentTab():int
        {
            return (this._nCurrentTab);
        }

        public function onKeyUp(target:Object, keyCode:uint):void
        {
            if (keyCode == 9)
            {
                if (this.inp_alliancename.haveFocus)
                {
                    this.inp_alliancetag.focus();
                    this.inp_alliancetag.setSelection(0, this.inp_alliancetag.text.length);
                }
                else
                {
                    if (this.inp_alliancetag.haveFocus)
                    {
                        this.inp_alliancename.focus();
                        this.inp_alliancename.setSelection(0, this.inp_alliancename.text.length);
                    };
                };
            };
        }

        private function refreshUIMode():void
        {
            this.updateLogoFromPlayerAlliance();
            this.openSelectedTab(EMBLEM_TAB_BACKGROUND);
            switch (this._mode)
            {
                case CREATION:
                    this.allianceNameCtr.disabled = false;
                    this.emblemCreatorCtr.disabled = false;
                    this.btn_background.selected = true;
                    this.randomEmblem();
                    break;
                case NAME_MODIFICATION:
                    this.gd_emblemBack.selectedIndex = (this._background.idEmblem - 1);
                    this.allianceNameCtr.disabled = false;
                    this.emblemCreatorCtr.disabled = true;
                    this.btn_create.disabled = true;
                    break;
                case EMBLEM_MODIFICATION:
                    this.gd_emblemBack.selectedIndex = (this._background.idEmblem - 1);
                    this.allianceNameCtr.disabled = true;
                    this.emblemCreatorCtr.disabled = false;
                    this.btn_background.selected = true;
                    this.btn_create.disabled = true;
                    break;
                case MODIFICATION:
                    this.gd_emblemBack.selectedIndex = (this._background.idEmblem - 1);
                    this.allianceNameCtr.disabled = false;
                    this.emblemCreatorCtr.disabled = false;
                    this.btn_background.selected = true;
                    this.btn_create.disabled = true;
                    break;
            };
            this.uiApi.me().render();
        }

        private function updateLogoFromPlayerAlliance():void
        {
            var alliance:AllianceWrapper;
            if (this.socialApi.hasAlliance())
            {
                alliance = this.socialApi.getAlliance();
                if (!alliance)
                {
                    return;
                };
                if (!this.socialApi.isAllianceNameInvalid())
                {
                    this.inp_alliancename.text = alliance.allianceName;
                };
                if (!this.socialApi.isAllianceTagInvalid())
                {
                    this.inp_alliancetag.text = alliance.allianceTag;
                };
                this._background = alliance.backEmblem;
                this.tx_emblem.uri = this._background.fullSizeIconUri;
                this._backgroundColor = this._background.color;
                this._icon = alliance.upEmblem;
                this.tx_icon.uri = this._icon.fullSizeIconUri;
                this._iconColor = this._icon.color;
                this.setIconColor(this._iconColor);
            };
        }

        private function randomEmblem():void
        {
            var rnd:int;
            rnd = Math.floor((Math.random() * this._emblemList[EMBLEM_TAB_BACKGROUND].length));
            this.selectBackground(this._emblemList[EMBLEM_TAB_BACKGROUND][rnd], false);
            this.setBackgroundColor((Math.random() * 0xFFFFFF));
            rnd = Math.floor((Math.random() * this._emblemList[EMBLEM_TAB_ICON].length));
            this.selectIcon(this._emblemList[EMBLEM_TAB_ICON][rnd], false);
            this.setIconColor((Math.random() * 0xFFFFFF));
        }

        private function openSelectedTab(tab:int):void
        {
            var cat:Object;
            if (this._nCurrentTab == tab)
            {
                return;
            };
            this._nCurrentTab = tab;
            this._stickEmblem = true;
            switch (tab)
            {
                case EMBLEM_TAB_ICON:
                    if (this.gd_emblemFront.dataProvider.length == 0)
                    {
                        if (this._icon)
                        {
                            for each (cat in this._iconCategories)
                            {
                                if (this._icon.category == cat.value)
                                {
                                    this._currentIconCat = cat;
                                    this.cbb_emblemCategory.selectedItem = this._currentIconCat;
                                };
                            };
                        };
                        this.updateIconGrid();
                        this.gd_emblemFront.selectedItem = this._icon;
                    };
                    this.gd_emblemBack.visible = false;
                    this.gd_emblemFront.visible = true;
                    this.cbb_emblemCategory.visible = (this.bgcbb_emblemCategory.visible = true);
                    this.cp_colorPk.color = this._iconColor;
                    break;
                case EMBLEM_TAB_BACKGROUND:
                    if (this.gd_emblemBack.dataProvider.length == 0)
                    {
                        this.gd_emblemBack.dataProvider = this._emblemList[EMBLEM_TAB_BACKGROUND];
                        this.gd_emblemBack.selectedItem = this._background;
                    };
                    this.gd_emblemBack.visible = true;
                    this.gd_emblemFront.visible = false;
                    this.cbb_emblemCategory.visible = (this.bgcbb_emblemCategory.visible = false);
                    this.cp_colorPk.color = this._backgroundColor;
                    break;
            };
            this._stickEmblem = false;
        }

        private function setBackgroundColor(color:Number):void
        {
            this._backgroundColor = color;
            if ((((((this.tx_emblem) && (this.tx_emblem.uri)) && (this.tx_emblem.child)) && (this.tx_emblem.child.hasOwnProperty("back"))) && (Object(this.tx_emblem.child).back)))
            {
                this.utilApi.changeColor(this.tx_emblem.getChildByName("back"), this._backgroundColor, 1);
            };
        }

        private function setIconColor(color:Number):void
        {
            var icon:EmblemSymbol = this.dataApi.getEmblemSymbol(this._icon.idEmblem);
            this._iconColor = color;
            if (icon.colorizable)
            {
                this.utilApi.changeColor(this.tx_icon, this._iconColor, 0);
            }
            else
            {
                this.utilApi.changeColor(this.tx_icon, this._iconColor, 0, true);
            };
        }

        private function unloadAllianceCreation():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        private function updateIconGrid():void
        {
            var initialIconIndex:int;
            var emblem:EmblemWrapper;
            var DP:Array = new Array();
            var hash:String = "";
            for each (emblem in this._emblemList[EMBLEM_TAB_ICON])
            {
                if (((emblem.category == this._currentIconCat.value) || (this._currentIconCat.value == uint.MAX_VALUE)))
                {
                    DP.push(emblem);
                    hash = (hash + (emblem.idEmblem + "-"));
                    if (emblem.idEmblem == this._icon.idEmblem)
                    {
                        initialIconIndex = (DP.length - 1);
                    };
                };
            };
            if (this._emblemsHash != hash)
            {
                this.gd_emblemFront.dataProvider = DP;
                this.gd_emblemFront.selectedIndex = initialIconIndex;
                this._emblemsHash = hash;
            };
        }

        private function checkModifications():void
        {
            var alliance:AllianceWrapper;
            if (this.socialApi.hasAlliance())
            {
                alliance = this.socialApi.getAlliance();
                if (((((((this.inp_alliancename.text == alliance.allianceName) && (this.inp_alliancetag.text == alliance.allianceTag)) && (this._background.idEmblem == alliance.backEmblem.idEmblem)) && (this._backgroundColor == alliance.backEmblem.color)) && (this._icon.idEmblem == alliance.upEmblem.idEmblem)) && (this._iconColor == alliance.upEmblem.color)))
                {
                    this.btn_create.disabled = true;
                }
                else
                {
                    this.btn_create.disabled = false;
                };
            };
        }

        public function onRelease(target:Object):void
        {
            var color:uint;
            var namingRuleAllianceName:NamingRule;
            var namingRuleAllianceTag:NamingRule;
            var position:int;
            switch (target)
            {
                case this.btn_close:
                    this.sysApi.sendAction(new d2actions.LeaveDialog());
                    this.unloadAllianceCreation();
                    break;
                case this.btn_background:
                    this.openSelectedTab(EMBLEM_TAB_BACKGROUND);
                    break;
                case this.btn_icon:
                    this.openSelectedTab(EMBLEM_TAB_ICON);
                    this.setBackgroundColor(this._backgroundColor);
                    break;
                case this.btn_hexaOk:
                    color = int(Number(("0x" + this.inp_hexaValue.text)));
                    this.onColorChange(new Object(), color);
                    this.cp_colorPk.color = color;
                    break;
                case this.cp_colorPk:
                    if (this.uiApi.keyIsDown(16))
                    {
                        this.inp_hexaValue.text = this.cp_colorPk.color.toString(16);
                        this.ctr_hexaColor.visible = true;
                        this.inp_hexaValue.focus();
                        position = this.inp_hexaValue.text.length;
                        this.inp_hexaValue.setSelection(position, position);
                    };
                    break;
                case this.btn_create:
                    namingRuleAllianceName = this.sysApi.getCurrentServer().community.namingRuleAllianceName;
                    namingRuleAllianceTag = this.sysApi.getCurrentServer().community.namingRuleAllianceTag;
                    if (((!(this._mode == EMBLEM_MODIFICATION)) && ((this.inp_alliancename.text.length < namingRuleAllianceName.minLength) || (this.inp_alliancename.text.length > namingRuleAllianceName.maxLength))))
                    {
                        this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.alliance.invalidLengthName", namingRuleAllianceName.minLength, namingRuleAllianceName.maxLength), [this.uiApi.getText("ui.common.ok")]);
                    }
                    else
                    {
                        if (((!(this._mode == EMBLEM_MODIFICATION)) && ((this.inp_alliancetag.text.length < namingRuleAllianceTag.minLength) || (this.inp_alliancetag.text.length > namingRuleAllianceTag.maxLength))))
                        {
                            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.alliance.invalidLengthTag", namingRuleAllianceTag.minLength, namingRuleAllianceTag.maxLength), [this.uiApi.getText("ui.common.ok")]);
                        }
                        else
                        {
                            if (this._mode == CREATION)
                            {
                                this.sysApi.sendAction(new AllianceCreationValid(this.inp_alliancename.text, this.inp_alliancetag.text, this._icon.idEmblem, this._iconColor, this._background.idEmblem, this._backgroundColor));
                            }
                            else
                            {
                                if (this._mode == NAME_MODIFICATION)
                                {
                                    this.sysApi.sendAction(new AllianceModificationNameAndTagValid(this.inp_alliancename.text, this.inp_alliancetag.text));
                                }
                                else
                                {
                                    if (this._mode == EMBLEM_MODIFICATION)
                                    {
                                        this.sysApi.sendAction(new AllianceModificationEmblemValid(this._icon.idEmblem, this._iconColor, this._background.idEmblem, this._backgroundColor));
                                    }
                                    else
                                    {
                                        if (this._mode == MODIFICATION)
                                        {
                                            this.sysApi.sendAction(new AllianceModificationValid(this.inp_alliancename.text, this.inp_alliancetag.text, this._icon.idEmblem, this._iconColor, this._background.idEmblem, this._backgroundColor));
                                        };
                                    };
                                };
                            };
                        };
                    };
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            if (target == this.tx_nameRules)
            {
                text = this.uiApi.getText("ui.social.nameRules");
            }
            else
            {
                if (target == this.tx_tagRules)
                {
                    text = this.uiApi.getText("ui.alliance.tagRules");
                };
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", 0, 0, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onChange(target:Object):void
        {
            if (((target == this.inp_alliancename) || (target == this.inp_alliancetag)))
            {
                this.checkModifications();
            };
        }

        public function onColorChange(target:Object, fixedColor:int=-1):void
        {
            var color:Number;
            if (!this.ctr_hexaColor.visible)
            {
                color = this.cp_colorPk.color;
            }
            else
            {
                color = fixedColor;
                this.ctr_hexaColor.visible = false;
            };
            switch (this._nCurrentTab)
            {
                case 0:
                    if (!this._stickEmblem)
                    {
                        this.setIconColor(color);
                    };
                    break;
                case 1:
                    if (!this._stickEmblem)
                    {
                        this.setBackgroundColor(color);
                    };
                    break;
            };
            this.checkModifications();
        }

        public function onAllianceCreationResult(result:uint):void
        {
            switch (result)
            {
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_OK:
                    this.unloadAllianceCreation();
                    break;
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_ALREADY_EXISTS:
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.alliance.AlreadyUseName"), [this.uiApi.getText("ui.common.ok")]);
                    break;
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_INVALID:
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.alliance.invalidName"), [this.uiApi.getText("ui.common.ok")]);
                    break;
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_TAG_ALREADY_EXISTS:
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.alliance.AlreadyUseName"), [this.uiApi.getText("ui.common.ok")]);
                    break;
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_TAG_INVALID:
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.alliance.invalidName"), [this.uiApi.getText("ui.common.ok")]);
                    break;
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_EMBLEM_ALREADY_EXISTS:
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.alliance.AlreadyUseEmblem"), [this.uiApi.getText("ui.common.ok")]);
                    break;
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_CANCEL:
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_LEAVE:
                    break;
                case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_REQUIREMENT_UNMET:
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.alliance.requirementUnmet"), [this.uiApi.getText("ui.common.ok")]);
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            switch (target)
            {
                case this.gd_emblemBack:
                    if ((((isNewSelection) && (!(this._stickEmblem))) && (!(selectMethod == SelectMethodEnum.AUTO))))
                    {
                        this.selectBackground(target.selectedItem, false);
                        this.checkModifications();
                    };
                    break;
                case this.gd_emblemFront:
                    if ((((!(this._stickEmblem)) && (!(selectMethod == SelectMethodEnum.AUTO))) && ((isNewSelection) || (this.gd_emblemFront.dataProvider.length == 1))))
                    {
                        this.selectIcon((target.selectedItem as EmblemWrapper), false);
                        this.checkModifications();
                    };
                    break;
                case this.cbb_emblemCategory:
                    if (isNewSelection)
                    {
                        this._currentIconCat = this._iconCategories[this.cbb_emblemCategory.selectedIndex];
                        switch (selectMethod)
                        {
                            case 0:
                            case 3:
                            case 4:
                            case 8:
                                this._stickEmblem = true;
                                this.updateIconGrid();
                                this._stickEmblem = false;
                                break;
                        };
                        break;
                    };
            };
        }

        public function onTextureReady(target:Object):void
        {
            switch (target)
            {
                case this.tx_emblem:
                    this.utilApi.changeColor(target.getChildByName("back"), this._backgroundColor, 1);
                    break;
            };
        }

        public function onUiLoaded(name:String):void
        {
            if (name == "allianceCreator")
            {
                this.refreshUIMode();
            };
        }

        public function onLeaveDialog():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        public function onShortcut(s:String):Boolean
        {
            var color:uint;
            switch (s)
            {
                case "validUi":
                    if (this.ctr_hexaColor.visible)
                    {
                        color = int(Number(("0x" + this.inp_hexaValue.text)));
                        this.onColorChange(new Object(), color);
                        this.cp_colorPk.color = color;
                    };
                    return (true);
                case "closeUi":
                    if (this.ctr_hexaColor.visible)
                    {
                        this.ctr_hexaColor.visible = false;
                    }
                    else
                    {
                        this.sysApi.sendAction(new d2actions.LeaveDialog());
                        this.uiApi.unloadUi(this.uiApi.me().name);
                    };
                    return (true);
            };
            return (false);
        }


    }
} Ankama_Social.ui

