package Ankama_Grimoire.ui
{
    import com.ankamagames.dofus.uiApi.BindsApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import d2hooks.NewAreNewTemporisRewardsAvailable;
    import d2enums.ComponentHookList;
    import Ankama_Grimoire.enum.EnumTab;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;

    public class QuestBase 
    {

        private static var _shortcutColor:String;
        private static const STORAGE_NEW_TEMPORIS_4_REWARD:String = "storageNewTemporis4Reward";

        [Api(name="BindsApi")]
        public var bindsApi:BindsApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        private var _currentTabUi:String = "";
        public var uiCtr:GraphicContainer;
        public var btn_close:ButtonContainer;
        public var btn_tabTemporis:ButtonContainer;
        public var btn_tabSuccess:ButtonContainer;
        public var btn_tabQuests:ButtonContainer;
        public var btn_tabAlmanax:ButtonContainer;
        public var lbl_btn_tabTemporis:Label;
        public var lbl_btn_tabSuccess:Label;
        public var lbl_btn_tabQuests:Label;
        public var lbl_btn_tabAlmanax:Label;
        public var btn_help:ButtonContainer;
        public var tx_temporisBar:Texture;
        public var tx_tabTemporisWarning:Texture;


        public function main(params:Object):void
        {
            var shortcut:String;
            var rawAreNewTemporisRewardsAvailable:*;
            var deltaX:Number;
            this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
            this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_OPEN);
            var isTemporisTab:Boolean = this.dataApi.isTemporisSpellsUi();
            this.btn_tabTemporis.visible = isTemporisTab;
            if (isTemporisTab)
            {
                this.btn_tabTemporis.soundId = SoundEnum.TAB;
                this.uiApi.addComponentHook(this.btn_tabTemporis, "onRelease");
                this.uiApi.addComponentHook(this.btn_tabTemporis, "onRollOver");
                this.uiApi.addComponentHook(this.btn_tabTemporis, "onRollOut");
                this.lbl_btn_tabTemporis.text = this.uiApi.getText("ui.temporis.temporisTabName");
                this.lbl_btn_tabTemporis.text = this.uiApi.getText("ui.temporis.temporisTabName");
                shortcut = this.bindsApi.getShortcutBindStr("openTemporisQuestTab");
                if (shortcut != "")
                {
                    this.lbl_btn_tabTemporis.text = (this.lbl_btn_tabTemporis.text + ((((" <font color='" + _shortcutColor) + "'>(") + shortcut) + ")</font>"));
                };
                rawAreNewTemporisRewardsAvailable = this.sysApi.getData(STORAGE_NEW_TEMPORIS_4_REWARD);
                if ((rawAreNewTemporisRewardsAvailable is Boolean))
                {
                    this.tx_tabTemporisWarning.visible = (rawAreNewTemporisRewardsAvailable as Boolean);
                }
                else
                {
                    this.tx_tabTemporisWarning.visible = false;
                };
                this.sysApi.addHook(NewAreNewTemporisRewardsAvailable, this.onNewAreTemporis4RewardsAvailable);
            }
            else
            {
                deltaX = (this.btn_tabTemporis.width / 2);
                this.btn_tabSuccess.x = (this.btn_tabSuccess.x - deltaX);
                this.btn_tabQuests.x = (this.btn_tabQuests.x - deltaX);
                this.btn_tabAlmanax.x = (this.btn_tabAlmanax.x - deltaX);
            };
            this.btn_tabSuccess.soundId = SoundEnum.TAB;
            this.btn_tabQuests.soundId = SoundEnum.TAB;
            this.btn_tabAlmanax.soundId = SoundEnum.TAB;
            this.uiApi.addComponentHook(this.btn_tabSuccess, "onRelease");
            this.uiApi.addComponentHook(this.btn_tabSuccess, "onRollOver");
            this.uiApi.addComponentHook(this.btn_tabSuccess, "onRollOut");
            this.uiApi.addComponentHook(this.btn_tabQuests, "onRelease");
            this.uiApi.addComponentHook(this.btn_tabQuests, "onRollOver");
            this.uiApi.addComponentHook(this.btn_tabQuests, "onRollOut");
            this.uiApi.addComponentHook(this.btn_tabAlmanax, "onRelease");
            this.uiApi.addComponentHook(this.btn_tabAlmanax, "onRollOver");
            this.uiApi.addComponentHook(this.btn_tabAlmanax, "onRollOut");
            this.uiApi.addComponentHook(this.btn_help, ComponentHookList.ON_RELEASE);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addShortcutHook("openAchievement", this.onShortcut);
            this.uiApi.addShortcutHook("openBookQuest", this.onShortcut);
            this.uiApi.addShortcutHook("openAlmanax", this.onShortcut);
            this.uiApi.addShortcutHook("openTemporisQuestTab", this.onShortcut);
            if (!_shortcutColor)
            {
                _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                _shortcutColor = _shortcutColor.replace("0x", "#");
            };
            this.lbl_btn_tabSuccess.text = this.uiApi.getText("ui.achievement.achievement");
            shortcut = this.bindsApi.getShortcutBindStr("openAchievement");
            if (shortcut != "")
            {
                this.lbl_btn_tabSuccess.text = (this.lbl_btn_tabSuccess.text + ((((" <font color='" + _shortcutColor) + "'>(") + shortcut) + ")</font>"));
            };
            this.lbl_btn_tabQuests.text = this.uiApi.getText("ui.common.quests");
            shortcut = this.bindsApi.getShortcutBindStr("openBookQuest");
            if (shortcut != "")
            {
                this.lbl_btn_tabQuests.text = (this.lbl_btn_tabQuests.text + ((((" <font color='" + _shortcutColor) + "'>(") + shortcut) + ")</font>"));
            };
            this.lbl_btn_tabAlmanax.text = this.uiApi.getText("ui.almanax.almanax");
            shortcut = this.bindsApi.getShortcutBindStr("openAlmanax");
            if (shortcut != "")
            {
                this.lbl_btn_tabAlmanax.text = (this.lbl_btn_tabAlmanax.text + ((((" <font color='" + _shortcutColor) + "'>(") + shortcut) + ")</font>"));
            };
            if (params != null)
            {
                this.openTab(params[0], params[1], params[1], this.uiApi.me().restoreSnapshotAfterLoading);
            }
            else
            {
                this.openTab();
            };
        }

        public function unload():void
        {
            if (this.soundApi)
            {
                this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
            };
            this.closeTab(this._currentTabUi);
        }

        public function getTab():String
        {
            return (this._currentTabUi);
        }

        public function openTab(tab:String="", subTab:int=0, params:Object=null, restoreSnapshot:Boolean=true):void
        {
            var lastTab:String;
            if ((((this._currentTabUi == tab) && (params)) && (params.hasOwnProperty("tabButtonClicked"))))
            {
                return;
            };
            if ((((!(tab == "")) && ((!(params)) || (!(params.hasOwnProperty("forceOpen"))))) && ((this._currentTabUi == tab) || (this.getButtonByTab(tab).disabled))))
            {
                this.closeQuestBase();
                return;
            };
            if (this._currentTabUi != "")
            {
                this.uiApi.unloadUi("subQuestUi");
            };
            if (tab == "")
            {
                lastTab = this.sysApi.getData("lastQuestsTab");
                if (((lastTab) && (!(this.getButtonByTab(lastTab).disabled))))
                {
                    this._currentTabUi = lastTab;
                }
                else
                {
                    this._currentTabUi = EnumTab.ACHIEVEMENT_TAB;
                };
            }
            else
            {
                this._currentTabUi = tab;
            };
            this.sysApi.setData("lastQuestsTab", this._currentTabUi);
            this.uiCtr.getUi().restoreSnapshotAfterLoading = restoreSnapshot;
            (this.uiApi.loadUiInside(this._currentTabUi, this.uiCtr, "subQuestUi", params) as UiRootContainer);
            this.uiApi.setRadioGroupSelectedItem("tabHGroup", this.getButtonByTab(this._currentTabUi), this.uiApi.me());
            this.getButtonByTab(this._currentTabUi).selected = true;
            this.tx_temporisBar.visible = (tab === EnumTab.TEMPORIS_QUEST_TAB);
        }

        private function getButtonByTab(tab:String):ButtonContainer
        {
            var returnButton:ButtonContainer;
            switch (tab)
            {
                case EnumTab.TEMPORIS_QUEST_TAB:
                    returnButton = this.btn_tabTemporis;
                    break;
                case EnumTab.ACHIEVEMENT_TAB:
                    returnButton = this.btn_tabSuccess;
                    break;
                case EnumTab.QUEST_TAB:
                    returnButton = this.btn_tabQuests;
                    break;
                case EnumTab.CALENDAR_TAB:
                    returnButton = this.btn_tabAlmanax;
                    break;
            };
            return (returnButton);
        }

        private function closeTab(tab:String):void
        {
            this.uiApi.unloadUi("subQuestUi");
        }

        private function closeQuestBase():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.closeQuestBase();
                    break;
                case this.btn_tabTemporis:
                    this.openTab(EnumTab.TEMPORIS_QUEST_TAB, 0, {"tabButtonClicked":true});
                    break;
                case this.btn_tabSuccess:
                    this.openTab(EnumTab.ACHIEVEMENT_TAB, 0, {"tabButtonClicked":true});
                    break;
                case this.btn_tabQuests:
                    this.openTab(EnumTab.QUEST_TAB, 0, {"tabButtonClicked":true});
                    break;
                case this.btn_tabAlmanax:
                    this.openTab(EnumTab.CALENDAR_TAB, 0, {"tabButtonClicked":true});
                    break;
                case this.btn_help:
                    this.uiApi.me().childUiRoot.uiClass.showTabHints();
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "openAchievement":
                    if (this._currentTabUi == EnumTab.ACHIEVEMENT_TAB)
                    {
                        this.uiApi.unloadUi(this.uiApi.me().name);
                    }
                    else
                    {
                        this.openTab(EnumTab.ACHIEVEMENT_TAB);
                    };
                    return (true);
                case "openBookQuest":
                    if (this._currentTabUi == EnumTab.QUEST_TAB)
                    {
                        this.uiApi.unloadUi(this.uiApi.me().name);
                    }
                    else
                    {
                        this.openTab(EnumTab.QUEST_TAB);
                    };
                    return (true);
                case "openAlmanax":
                    if (this._currentTabUi == EnumTab.CALENDAR_TAB)
                    {
                        this.uiApi.unloadUi(this.uiApi.me().name);
                    }
                    else
                    {
                        this.openTab(EnumTab.CALENDAR_TAB);
                    };
                    return (true);
                case "openTemporisQuestTab":
                    if (this._currentTabUi == EnumTab.TEMPORIS_QUEST_TAB)
                    {
                        this.uiApi.unloadUi(this.uiApi.me().name);
                    }
                    else
                    {
                        this.openTab(EnumTab.TEMPORIS_QUEST_TAB);
                    };
                    return (true);
                case "closeUi":
                    this.closeQuestBase();
                    return (true);
            };
            return (false);
        }

        public function onRollOver(target:Object):void
        {
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        private function onNewAreTemporis4RewardsAvailable(areTemporis4RewardsAvailable:Boolean):void
        {
            this.sysApi.setData(STORAGE_NEW_TEMPORIS_4_REWARD, areTemporis4RewardsAvailable);
            this.tx_tabTemporisWarning.visible = areTemporis4RewardsAvailable;
        }


    }
} Ankama_Grimoire.ui

