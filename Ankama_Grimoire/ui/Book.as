package Ankama_Grimoire.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.BindsApi;
    import com.ankamagames.dofus.uiApi.ConfigApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import d2hooks.GameFightJoin;
    import d2hooks.GameFightStart;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import Ankama_Grimoire.enum.EnumTab;
    import Ankama_Grimoire.Grimoire;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import d2hooks.OpenGrimoireQuestTab;
    import d2hooks.OpenGrimoireJobTab;
    import d2hooks.OpenGrimoireCalendarTab;
    import d2actions.OpenIdols;
    import com.ankamagames.berilia.types.LocationEnum;
    import d2hooks.*;
    import d2actions.*;

    public class Book 
    {

        private static var _shortcutColor:String;
        private static var _disabledColor:String;
        private static var _self:Book;

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="BindsApi")]
        public var bindsApi:BindsApi;
        [Api(name="ConfigApi")]
        public var configApi:ConfigApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        public var uiCtr:GraphicContainer;
        public var btn_close:ButtonContainer;
        public var btn_ongletQuetes:ButtonContainer;
        public var btn_ongletMetiers:ButtonContainer;
        public var btn_ongletCalendar:ButtonContainer;
        public var btn_ongletAchievement:ButtonContainer;
        public var btn_ongletTitle:ButtonContainer;
        public var btn_ongletBestiary:ButtonContainer;
        public var btn_ongletCompanion:ButtonContainer;
        public var btn_ongletIdols:ButtonContainer;
        private var _currentTabUi:String;
        private var _spellList:Object;


        public static function getInstance():Book
        {
            return (_self);
        }


        public function main(oParam:Object=null):void
        {
            this.sysApi.addHook(GameFightJoin, this.onGameFightJoin);
            this.sysApi.addHook(GameFightStart, this.onGameFightStart);
            this.uiApi.addComponentHook(this.btn_ongletQuetes, "onRelease");
            this.uiApi.addComponentHook(this.btn_ongletQuetes, "onRollOver");
            this.uiApi.addComponentHook(this.btn_ongletQuetes, "onRollOut");
            this.uiApi.addComponentHook(this.btn_ongletMetiers, "onRelease");
            this.uiApi.addComponentHook(this.btn_ongletMetiers, "onRollOver");
            this.uiApi.addComponentHook(this.btn_ongletMetiers, "onRollOut");
            this.uiApi.addComponentHook(this.btn_ongletCalendar, "onRelease");
            this.uiApi.addComponentHook(this.btn_ongletCalendar, "onRollOver");
            this.uiApi.addComponentHook(this.btn_ongletCalendar, "onRollOut");
            this.uiApi.addComponentHook(this.btn_ongletAchievement, "onRelease");
            this.uiApi.addComponentHook(this.btn_ongletAchievement, "onRollOver");
            this.uiApi.addComponentHook(this.btn_ongletAchievement, "onRollOut");
            this.uiApi.addComponentHook(this.btn_ongletTitle, "onRelease");
            this.uiApi.addComponentHook(this.btn_ongletTitle, "onRollOver");
            this.uiApi.addComponentHook(this.btn_ongletTitle, "onRollOut");
            this.uiApi.addComponentHook(this.btn_ongletBestiary, "onRelease");
            this.uiApi.addComponentHook(this.btn_ongletBestiary, "onRollOver");
            this.uiApi.addComponentHook(this.btn_ongletBestiary, "onRollOut");
            this.uiApi.addComponentHook(this.btn_ongletCompanion, "onRelease");
            this.uiApi.addComponentHook(this.btn_ongletCompanion, "onRollOver");
            this.uiApi.addComponentHook(this.btn_ongletCompanion, "onRollOut");
            this.uiApi.addComponentHook(this.btn_ongletIdols, "onRelease");
            this.uiApi.addComponentHook(this.btn_ongletIdols, "onRollOver");
            this.uiApi.addComponentHook(this.btn_ongletIdols, "onRollOut");
            this.uiApi.addComponentHook(this.btn_close, "onRelease");
            this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
            this._currentTabUi = null;
            this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_OPEN);
            this.btn_ongletQuetes.soundId = SoundEnum.TAB;
            this.btn_ongletMetiers.soundId = SoundEnum.TAB;
            this.btn_ongletCalendar.soundId = SoundEnum.TAB;
            this.btn_ongletAchievement.soundId = SoundEnum.TAB;
            this.btn_ongletTitle.soundId = SoundEnum.TAB;
            this.btn_ongletBestiary.soundId = SoundEnum.TAB;
            this.btn_ongletCompanion.soundId = SoundEnum.TAB;
            this.btn_ongletIdols.soundId = SoundEnum.TAB;
            _self = this;
            this.uiApi.addShortcutHook("closeUi", this.onShortCut);
            this.uiApi.addShortcutHook("openBookQuest", this.onShortCut);
            this.uiApi.addShortcutHook("openBookJob", this.onShortCut);
            if (oParam != null)
            {
                this.openTab(oParam[0], oParam[1]);
            }
            else
            {
                this.openTab();
            };
        }

        private function onShortCut(s:String):Boolean
        {
            switch (s)
            {
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
                case "openBookJob":
                    if (this._currentTabUi == EnumTab.JOB_TAB)
                    {
                        this.uiApi.unloadUi(this.uiApi.me().name);
                    }
                    else
                    {
                        this.openTab(EnumTab.JOB_TAB);
                    };
                    return (true);
                case "closeUi":
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }

        public function unload():void
        {
            this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_CLOSE);
            this.sysApi.enableWorldInteraction();
            Grimoire.getInstance().tabOpened = "";
            this.closeTab();
        }

        public function get spellList():Object
        {
            return (this._spellList);
        }

        public function openTab(tab:String=null, param:Object=null):void
        {
            var tabName:String;
            var tabToShow:String;
            var lastTab:String;
            var disabledTab:Array = new Array();
            disabledTab[EnumTab.CALENDAR_TAB] = Grimoire.getInstance().isCalendarDisabled();
            disabledTab[EnumTab.TITLE_TAB] = this.playerApi.isInFight();
            var tutorial:Object = this.uiApi.getUi(UIEnum.TUTORIAL_UI);
            if (((tutorial) && (!(tutorial.uiClass.tutorialDisabled))))
            {
                disabledTab[EnumTab.JOB_TAB] = true;
                disabledTab[EnumTab.CALENDAR_TAB] = true;
                disabledTab[EnumTab.ACHIEVEMENT_TAB] = true;
                disabledTab[EnumTab.TITLE_TAB] = true;
                disabledTab[EnumTab.BESTIARY_TAB] = true;
                disabledTab[EnumTab.COMPANION_TAB] = true;
                disabledTab[EnumTab.IDOLS_TAB] = true;
            };
            for (tabName in disabledTab)
            {
                this.getButtonByTabName(tabName).softDisabled = disabledTab[tabName];
            };
            if (((tab == null) || (disabledTab[tab])))
            {
                lastTab = this.sysApi.getData("lastGrimoireTab");
                if (((lastTab) && (!(disabledTab[lastTab]))))
                {
                    tabToShow = lastTab;
                }
                else
                {
                    tabToShow = EnumTab.SPELL_TAB;
                };
            }
            else
            {
                tabToShow = tab;
            };
            if (tabToShow == this._currentTabUi)
            {
                return;
            };
            if (this._currentTabUi)
            {
                this.uiApi.unloadUi(this._currentTabUi);
            };
            this._currentTabUi = tabToShow;
            this.sysApi.setData("lastGrimoireTab", this._currentTabUi);
            Grimoire.getInstance().tabOpened = this._currentTabUi;
            this.uiApi.loadUiInside(tabToShow, this.uiCtr, tabToShow, param);
            this.uiApi.setRadioGroupSelectedItem("tabGroup", this.getButtonByTabName(this._currentTabUi), this.uiApi.me());
            this.getButtonByTabName(this._currentTabUi).selected = true;
        }

        private function closeTab(tab:String=null):void
        {
            var tabToClose:String;
            if (tab == null)
            {
                if (this._currentTabUi)
                {
                    tabToClose = this._currentTabUi;
                }
                else
                {
                    tabToClose = tab;
                };
            };
            if (tabToClose)
            {
                this.uiApi.unloadUi(tabToClose);
            };
        }

        private function getButtonByTabName(tabName:String):ButtonContainer
        {
            var returnButton:ButtonContainer;
            switch (tabName)
            {
                case EnumTab.QUEST_TAB:
                    returnButton = this.btn_ongletQuetes;
                    break;
                case EnumTab.JOB_TAB:
                    returnButton = this.btn_ongletMetiers;
                    break;
                case EnumTab.CALENDAR_TAB:
                    returnButton = this.btn_ongletCalendar;
                    break;
                case EnumTab.ACHIEVEMENT_TAB:
                    returnButton = this.btn_ongletAchievement;
                    break;
                case EnumTab.TITLE_TAB:
                    returnButton = this.btn_ongletTitle;
                    break;
                case EnumTab.BESTIARY_TAB:
                    returnButton = this.btn_ongletBestiary;
                    break;
                case EnumTab.COMPANION_TAB:
                    returnButton = this.btn_ongletCompanion;
                    break;
                case EnumTab.IDOLS_TAB:
                    returnButton = this.btn_ongletIdols;
                    break;
            };
            return (returnButton);
        }

        private function onSpellsList(spellList:Object):void
        {
            this._spellList = spellList;
        }

        public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int, alliesPreparation:Boolean):void
        {
            if (this._currentTabUi == EnumTab.TITLE_TAB)
            {
                this.openTab(EnumTab.SPELL_TAB);
            };
        }

        public function onGameFightStart():void
        {
            if (this._currentTabUi == EnumTab.TITLE_TAB)
            {
                this.openTab(EnumTab.SPELL_TAB);
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.sysApi.enableWorldInteraction();
                    this.uiApi.unloadUi(UIEnum.GRIMOIRE);
                    return;
                case this.btn_ongletQuetes:
                    this.openTab(EnumTab.QUEST_TAB);
                    this.sysApi.dispatchHook(OpenGrimoireQuestTab);
                    break;
                case this.btn_ongletMetiers:
                    this.openTab(EnumTab.JOB_TAB);
                    this.sysApi.dispatchHook(OpenGrimoireJobTab);
                    break;
                case this.btn_ongletCalendar:
                    this.openTab(EnumTab.CALENDAR_TAB);
                    this.sysApi.dispatchHook(OpenGrimoireCalendarTab);
                    break;
                case this.btn_ongletAchievement:
                    this.openTab(EnumTab.ACHIEVEMENT_TAB);
                    break;
                case this.btn_ongletTitle:
                    this.openTab(EnumTab.TITLE_TAB);
                    break;
                case this.btn_ongletBestiary:
                    this.openTab(EnumTab.BESTIARY_TAB);
                    break;
                case this.btn_ongletCompanion:
                    this.openTab(EnumTab.COMPANION_TAB);
                    break;
                case this.btn_ongletIdols:
                    this.sysApi.sendAction(new OpenIdols());
                    break;
            };
            if (Grimoire.getInstance().tabOpened != "")
            {
                this.sysApi.disableWorldInteraction();
            }
            else
            {
                this.sysApi.enableWorldInteraction();
            };
        }

        public function onRollOver(target:Object):void
        {
            var title:String;
            var data:Object;
            var point:uint = LocationEnum.POINT_LEFT;
            var relPoint:uint = LocationEnum.POINT_RIGHT;
            var shortcutKey:String;
            var description:String = "";
            var tooltipTxt:String = "";
            switch (target)
            {
                case this.btn_ongletQuetes:
                    title = this.uiApi.getText("ui.common.quests");
                    shortcutKey = this.bindsApi.getShortcutBindStr("openBookQuest");
                    break;
                case this.btn_ongletMetiers:
                    title = this.uiApi.getText("ui.common.myJobs");
                    shortcutKey = this.bindsApi.getShortcutBindStr("openBookJob");
                    break;
                case this.btn_ongletCalendar:
                    title = this.uiApi.getText("ui.almanax.almanax");
                    shortcutKey = this.bindsApi.getShortcutBindStr("openAlmanax");
                    break;
                case this.btn_ongletAchievement:
                    title = this.uiApi.getText("ui.achievement.achievement");
                    shortcutKey = this.bindsApi.getShortcutBindStr("openAchievement");
                    break;
                case this.btn_ongletTitle:
                    title = this.uiApi.getText("ui.common.titles");
                    shortcutKey = this.bindsApi.getShortcutBindStr("openTitle");
                    description = this.uiApi.getText("ui.banner.lockBtn.inRP");
                    break;
                case this.btn_ongletBestiary:
                    title = this.uiApi.getText("ui.common.bestiary");
                    shortcutKey = this.bindsApi.getShortcutBindStr("openBestiary");
                    break;
                case this.btn_ongletCompanion:
                    title = this.uiApi.getText("ui.companion.companions");
                    break;
                case this.btn_ongletIdols:
                    title = this.uiApi.getText("ui.idol.idols");
                    break;
            };
            if (shortcutKey)
            {
                if (!_shortcutColor)
                {
                    _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                    _shortcutColor = _shortcutColor.replace("0x", "#");
                };
                tooltipTxt = (((((title + " <font color='") + _shortcutColor) + "'>(") + shortcutKey) + ")</font>");
            }
            else
            {
                tooltipTxt = title;
            };
            if (target.softDisabled)
            {
                if (!_disabledColor)
                {
                    _disabledColor = (this.sysApi.getConfigEntry("colors.tooltip.text.disabled") as String).replace("0x", "#");
                };
                tooltipTxt = tooltipTxt.replace(title, (((("<font color='" + _disabledColor) + "'>") + title) + "</font>"));
                if (description)
                {
                    tooltipTxt = (tooltipTxt + ("\n" + description));
                };
            };
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipTxt), target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }


    }
}

