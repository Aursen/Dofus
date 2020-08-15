package Ankama_CharacterSheet.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
    import com.ankamagames.dofus.internalDatacenter.people.SpouseWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
    import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.components.ProgressBar;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import d2hooks.StatsUpgradeResult;
    import d2hooks.CharacterStatsList;
    import d2hooks.FightEvent;
    import d2hooks.HouseInformations;
    import d2hooks.UiLoaded;
    import d2hooks.UiUnloaded;
    import d2hooks.SpellsToHighlightUpdate;
    import d2hooks.ContextChanged;
    import d2hooks.StrataUpdate;
    import d2hooks.LevelUpStatsTutorial;
    import d2hooks.CloseLevelUpUiTutorial;
    import d2hooks.GameFightStart;
    import d2hooks.GameFightEnd;
    import d2enums.ComponentHookList;
    import Ankama_CharacterSheet.CharacterSheet;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
    import com.ankamagames.dofus.datacenter.characteristics.CharacteristicCategory;
    import com.ankamagames.dofus.datacenter.characteristics.Characteristic;
    import com.ankamagames.dofusModuleLibrary.enum.AlignementSideEnum;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
    import d2actions.OpenBook;
    import d2hooks.OpenCharacterBuilds;
    import d2actions.OpenSocial;
    import d2actions.OpenHouses;
    import d2hooks.OpenSocial;
    import com.ankamagames.dofus.network.enums.BoostableCharacteristicEnum;
    import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
    import d2actions.ResetCharacterStatsRequest;
    import d2hooks.*;

    public class CharacterSheetUi 
    {

        private static const CTR_CAT_TYPE_CAT:String = "ctr_cat";
        private static const CTR_CAT_TYPE_ITEM:String = "ctr_caracAdvancedItem";
        private static const GAUGE_MAX_WIDTH:uint = 220;
        private static const STAT_REGULAR_TAB:int = 0;
        private static const STAT_ADVANCED_TAB:int = 1;

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _dataMatrix:Array;
        private var _statListWithLife:Array;
        private var _caracList:Array;
        private var _pdvLine:Object;
        private var _componentList:Dictionary = new Dictionary(true);
        private var _characterInfos:*;
        private var _characterCharacteristics:CharacterCharacteristicsInformations;
        private var _someStatsMayBeScrolled:Boolean = false;
        private var _xpInfoText:String;
        private var _xpColor:Number;
        private var _isUnloading:Boolean;
        private var _storageMod:uint;
        private var _nCurrentTab:uint = 0;
        private var _characteristicsCategoriesData:Object;
        private var _currentScrollValue:int;
        private var _caracListToDisplay:Array;
        private var _lastCategorySelected:Object;
        private var _openCatIndex:int;
        private var _currentSelectedCatId:int;
        private var _openedCategories:Array;
        private var _favCategoriesId:Array;
        private var _spouse:SpouseWrapper;
        private var _guild:GuildWrapper;
        private var _alliance:AllianceWrapper;
        private var _lastChildIndex:uint;
        private var _currentTabName:String;
        private var _tooltipStrata:int = 4;
        private var _resetPopupName:String;
        public var charSheetWindow:GraphicContainer;
        public var ctr_regular:GraphicContainer;
        public var ctr_advanced:GraphicContainer;
        public var ctr_charTitleButton:GraphicContainer;
        public var ctr_rewardPointButton:GraphicContainer;
        public var ctr_healhPointsSmallBlock:GraphicContainer;
        public var ctr_actionPointsSmallBlock:GraphicContainer;
        public var ctr_movementPointsSmallBlock:GraphicContainer;
        public var ctr_pointsToDivide:GraphicContainer;
        public var ctr_openGuildTab:GraphicContainer;
        public var ctr_openAllianceTab:GraphicContainer;
        public var lbl_name:Label;
        public var lbl_charTitle:Label;
        public var lbl_lvl:Label;
        public var lbl_xp:Label;
        public var lbl_energy:Label;
        public var lbl_statPoints:Label;
        public var lbl_advancedName:Label;
        public var lbl_advancedLvl:Label;
        public var lbl_advancedBaseColumn:Label;
        public var lbl_advancedBonusColumn:Label;
        public var lbl_rewardPoints:Label;
        public var lbl_healthPointsValue:Label;
        public var lbl_actionPointsValue:Label;
        public var lbl_movementPointsValue:Label;
        public var tx_basicCharPortrait:Texture;
        public var tx_advancedCharPortrait:Texture;
        public var bgTexturebtn_pvp:Texture;
        public var tx_guildEmblemBack:Texture;
        public var tx_guildEmblemFront:Texture;
        public var tx_allianceEmblemBack:Texture;
        public var tx_allianceEmblemFront:Texture;
        public var tx_warningSpell:Texture;
        public var pb_xp:ProgressBar;
        public var pb_energy:ProgressBar;
        public var gd_carac:Grid;
        public var gd_caracAdvanced:Grid;
        public var btn_close:ButtonContainer;
        public var btn_help:ButtonContainer;
        public var btn_advanced:ButtonContainer;
        public var btn_regular:ButtonContainer;
        public var btn_title:ButtonContainer;
        public var btn_spellBook:ButtonContainer;
        public var btn_build:ButtonContainer;
        public var btn_house:ButtonContainer;
        public var btn_spouse:ButtonContainer;
        public var btn_pvp:ButtonContainer;
        public var btn_reset:ButtonContainer;


        public function get currentTabName():String
        {
            return (this._currentTabName);
        }

        public function set currentTabName(value:String):void
        {
            this._currentTabName = value;
        }

        public function main(params:Object):void
        {
            if (this.uiApi.me().strata == StrataEnum.STRATA_MAX)
            {
                this._tooltipStrata = StrataEnum.STRATA_SUPERMAX;
            };
            this._isUnloading = false;
            this.soundApi.playSound(SoundTypeEnum.CHARACTER_SHEET_OPEN);
            this.ctr_advanced.visible = false;
            this.sysApi.addHook(StatsUpgradeResult, this.onStatsUpgradeResult);
            this.sysApi.addHook(CharacterStatsList, this.onCharacterStatsList);
            this.sysApi.addHook(FightEvent, this.onFightEvent);
            this.sysApi.addHook(HouseInformations, this.onHouseInformations);
            this.sysApi.addHook(UiLoaded, this.onUiLoaded);
            this.sysApi.addHook(UiUnloaded, this.onUiUnloaded);
            this.sysApi.addHook(SpellsToHighlightUpdate, this.onSpellsToHighlightUpdate);
            this.sysApi.addHook(ContextChanged, this.onContextChanged);
            this.sysApi.addHook(StrataUpdate, this.onStrataUpdate);
            this.sysApi.addHook(LevelUpStatsTutorial, this.onLevelUpStatsTutorial);
            this.sysApi.addHook(CloseLevelUpUiTutorial, this.onCloseLevelUpUiTutorial);
            this.sysApi.addHook(GameFightStart, this.onGameFightStart);
            this.sysApi.addHook(GameFightEnd, this.onGameFightEnd);
            this.uiApi.addShortcutHook("closeUi", this.onShortCut);
            this.uiApi.addComponentHook(this.btn_advanced, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_advanced, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_advanced, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_title, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_title, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_spouse, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_spouse, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_house, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_house, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_pvp, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_pvp, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_close, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ctr_charTitleButton, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ctr_charTitleButton, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_charTitleButton, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_rewardPointButton, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ctr_rewardPointButton, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_rewardPointButton, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_reset, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_reset, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.pb_xp, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.pb_xp, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.pb_energy, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.pb_energy, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.lbl_lvl, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_lvl, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.lbl_xp, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_xp, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.lbl_energy, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_energy, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_pointsToDivide, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_pointsToDivide, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.gd_caracAdvanced, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.gd_caracAdvanced, ComponentHookList.ON_ITEM_RIGHT_CLICK);
            this.uiApi.addComponentHook(this.ctr_healhPointsSmallBlock, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_healhPointsSmallBlock, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_actionPointsSmallBlock, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_actionPointsSmallBlock, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_movementPointsSmallBlock, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_movementPointsSmallBlock, ComponentHookList.ON_ROLL_OUT);
            this.tx_guildEmblemBack.dispatchMessages = true;
            this.tx_guildEmblemFront.dispatchMessages = true;
            this.tx_allianceEmblemBack.dispatchMessages = true;
            this.tx_allianceEmblemFront.dispatchMessages = true;
            this.uiApi.addComponentHook(this.tx_guildEmblemBack, ComponentHookList.ON_TEXTURE_READY);
            this.uiApi.addComponentHook(this.tx_guildEmblemFront, ComponentHookList.ON_TEXTURE_READY);
            this.uiApi.addComponentHook(this.tx_allianceEmblemBack, ComponentHookList.ON_TEXTURE_READY);
            this.uiApi.addComponentHook(this.tx_allianceEmblemFront, ComponentHookList.ON_TEXTURE_READY);
            this.uiApi.addComponentHook(this.ctr_openGuildTab, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ctr_openGuildTab, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_openGuildTab, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_openAllianceTab, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ctr_openAllianceTab, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_openAllianceTab, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_warningSpell, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_warningSpell, ComponentHookList.ON_ROLL_OUT);
            this._characterInfos = this.playerApi.getPlayedCharacterInfo();
            this._characterCharacteristics = this.playerApi.characteristics();
            this._characteristicsCategoriesData = this.dataApi.getCharacteristicCategories();
            this._dataMatrix = [];
            this._statListWithLife = [];
            this._caracList = [];
            this._spouse = this.socialApi.getSpouse();
            this._guild = this.socialApi.getGuild();
            this._alliance = this.socialApi.getAlliance();
            if (this._guild)
            {
                this.tx_guildEmblemBack.uri = this._guild.backEmblem.fullSizeIconUri;
                this.tx_guildEmblemFront.uri = this._guild.upEmblem.fullSizeIconUri;
            };
            if (this._alliance)
            {
                this.tx_allianceEmblemBack.uri = this._alliance.backEmblem.fullSizeIconUri;
                this.tx_allianceEmblemFront.uri = this._alliance.upEmblem.fullSizeIconUri;
            };
            this.onSpellsToHighlightUpdate(CharacterSheet.getInstance().newSpellIdsToHighlight);
            this.uiApi.setRadioGroupSelectedItem("tabHGroup", this.btn_regular, this.uiApi.me());
            this.btn_regular.selected = true;
            this.currentTabName = this.btn_regular.name;
            this._openedCategories = this.sysApi.getData("openedCharsheetCat");
            if (!this._openedCategories)
            {
                this._openedCategories = [];
            };
            this._favCategoriesId = [];
            this._favCategoriesId = this.sysApi.getData("favCharsheetCat");
            if (!this._favCategoriesId)
            {
                this._favCategoriesId = [];
            };
            var charSexString:String = ((this._characterInfos.sex) ? "1" : "0");
            var charPortraitUri:* = ((((this.uiApi.me().getConstant("illus_uri") + this._characterInfos.breed) + "_") + charSexString) + ".png");
            this.tx_basicCharPortrait.uri = (this.tx_advancedCharPortrait.uri = this.uiApi.createUri(charPortraitUri));
            this.statsUpdate();
            this.dataInit();
            this.characterUpdate();
            this.btn_close.state = 0;
            this.btn_close.reset();
            if (((this.playerApi.isInFight()) && (!(this.playerApi.isInPreFight()))))
            {
                this.btn_reset.disabled = true;
            };
        }

        public function unload():void
        {
            if (!this._isUnloading)
            {
                this._isUnloading = true;
                this.uiApi.hideTooltip();
                this.soundApi.playSound(SoundTypeEnum.CHARACTER_SHEET_CLOSE);
                this.uiApi.unloadUi("statBoost");
            };
            if (this.uiApi.getUi(this._resetPopupName))
            {
                this.uiApi.unloadUi(this._resetPopupName);
            };
        }

        public function updateStatLine(data:*, componentsRef:*, selected:Boolean):void
        {
            var initiative:int;
            var total:int;
            if (data)
            {
                if (!this._componentList[componentsRef.lbl_nameStat.name])
                {
                    this.uiApi.addComponentHook(componentsRef.lbl_nameStat, ComponentHookList.ON_ROLL_OUT);
                    this.uiApi.addComponentHook(componentsRef.lbl_nameStat, ComponentHookList.ON_ROLL_OVER);
                };
                this._componentList[componentsRef.lbl_nameStat.name] = data;
                if (data.gfxId != "null")
                {
                    componentsRef.tx_pictoStat.visible = true;
                    componentsRef.tx_pictoStat.uri = this.uiApi.createUri((this.uiApi.me().getConstant("picto_uri") + data.gfxId));
                }
                else
                {
                    componentsRef.tx_pictoStat.uri = null;
                };
                componentsRef.lbl_nameStat.text = data.text;
                if (data.id == "lifePoints")
                {
                    componentsRef.lbl_valueStat.text = ((this._characterCharacteristics.lifePoints + " / ") + this._characterCharacteristics.maxLifePoints);
                }
                else
                {
                    if (data.id == "initiative")
                    {
                        initiative = ((data.base + data.boost) + data.stuff);
                        componentsRef.lbl_valueStat.text = ((int(((initiative * this._characterCharacteristics.lifePoints) / this._characterCharacteristics.maxLifePoints)) + " / ") + initiative);
                    }
                    else
                    {
                        if (((data.id == "actionPoints") || (data.id == "movementPoints")))
                        {
                            componentsRef.lbl_valueStat.text = this._characterCharacteristics[(data.id + "Current")];
                        }
                        else
                        {
                            total = ((((data.base + data.additionnal) + data.boost) + data.stuff) + data.gift);
                            if (total != 0)
                            {
                                componentsRef.lbl_valueStat.text = total;
                            }
                            else
                            {
                                componentsRef.lbl_valueStat.text = "-";
                            };
                        };
                    };
                };
            }
            else
            {
                componentsRef.lbl_nameStat.text = "";
                componentsRef.lbl_valueStat.text = "";
                componentsRef.tx_pictoStat.visible = false;
            };
        }

        public function updateCaracLine(data:*, componentsRef:*, selected:Boolean):void
        {
            var total:int;
            var statPointName:String;
            var statpoints:Array;
            var truc:*;
            var isRoleplayOrPrefight:Boolean;
            var i:int;
            if (data)
            {
                if (!this._componentList[componentsRef.btn_plus.name])
                {
                    this.uiApi.addComponentHook(componentsRef.btn_plus, ComponentHookList.ON_RELEASE);
                    this.uiApi.addComponentHook(componentsRef.btn_plus, ComponentHookList.ON_ROLL_OUT);
                    this.uiApi.addComponentHook(componentsRef.btn_plus, ComponentHookList.ON_ROLL_OVER);
                };
                this._componentList[componentsRef.btn_plus.name] = data;
                if (!this._componentList[componentsRef.lbl_nameCarac.name])
                {
                    this.uiApi.addComponentHook(componentsRef.lbl_nameCarac, ComponentHookList.ON_ROLL_OUT);
                    this.uiApi.addComponentHook(componentsRef.lbl_nameCarac, ComponentHookList.ON_ROLL_OVER);
                };
                this._componentList[componentsRef.lbl_nameCarac.name] = data;
                if (!this._componentList[componentsRef.lbl_valueCarac.name])
                {
                    this.uiApi.addComponentHook(componentsRef.lbl_valueCarac, ComponentHookList.ON_ROLL_OUT);
                    this.uiApi.addComponentHook(componentsRef.lbl_valueCarac, ComponentHookList.ON_ROLL_OVER);
                };
                this._componentList[componentsRef.lbl_valueCarac.name] = data;
                if (data.gfxId != "null")
                {
                    componentsRef.tx_pictoCarac.visible = true;
                    componentsRef.tx_pictoCarac.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("characteristics") + data.gfxId) + ".png"));
                }
                else
                {
                    componentsRef.tx_pictoCarac.uri = null;
                };
                componentsRef.tx_gridSeparator.visible = true;
                componentsRef.lbl_nameCarac.text = data.text;
                total = ((((data.base + data.additionnal) + data.boost) + data.stuff) + data.gift);
                if (total != 0)
                {
                    componentsRef.lbl_valueCarac.text = total;
                }
                else
                {
                    componentsRef.lbl_valueCarac.text = "-";
                };
                statPointName = (data.id.substr(0, 1).toLocaleUpperCase() + data.id.substr(1));
                statpoints = [];
                for each (truc in this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed)[("statsPointsFor" + statPointName)])
                {
                    statpoints.push(truc);
                };
                componentsRef.btn_plus.visible = false;
                isRoleplayOrPrefight = ((!(this.playerApi.isInFight())) || (this.playerApi.isInPreFight()));
                i = 0;
                while (i < statpoints.length)
                {
                    if (((((statpoints[(i + 1)]) && (statpoints[(i + 1)][0] > data.base)) && (statpoints[i][0] <= data.base)) || (!(statpoints[(i + 1)]))))
                    {
                        if (((this._characterCharacteristics.statsPoints >= statpoints[i][1]) && (isRoleplayOrPrefight)))
                        {
                            componentsRef.btn_plus.visible = true;
                        };
                    };
                    if (((data.additionnal < ProtocolConstantsEnum.MAX_ADDITIONNAL_PER_CARAC) && ((((statpoints[(i + 1)]) && (statpoints[(i + 1)][0] > data.additionnal)) && (statpoints[i][0] <= data.additionnal)) || (!(statpoints[(i + 1)])))))
                    {
                        if (((this._characterCharacteristics.additionnalPoints >= statpoints[i][1]) && (isRoleplayOrPrefight)))
                        {
                            componentsRef.btn_plus.visible = true;
                        };
                    };
                    i++;
                };
            }
            else
            {
                componentsRef.lbl_valueCarac.text = "";
                componentsRef.lbl_nameCarac.text = "";
                componentsRef.btn_plus.visible = false;
                componentsRef.tx_pictoCarac.visible = false;
                componentsRef.tx_gridSeparator.visible = false;
            };
        }

        public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint):void
        {
            var currentBase:Number;
            var bonusUsed:int;
            var base:int;
            var bonus:int;
            var total:int;
            switch (this.getCatLineType(data, line))
            {
                case CTR_CAT_TYPE_CAT:
                    componentsRef.lbl_catName.text = data.name;
                    componentsRef.btn_cat.selected = selected;
                    if (this._openedCategories.indexOf(data.id) != -1)
                    {
                        componentsRef.tx_catplusminus.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture_uri") + "icon_minus_grey.png"));
                    }
                    else
                    {
                        componentsRef.tx_catplusminus.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture_uri") + "icon_plus_grey.png"));
                    };
                    break;
                case CTR_CAT_TYPE_ITEM:
                    if (!this._componentList[componentsRef.lbl_name.name])
                    {
                        this.uiApi.addComponentHook(componentsRef.lbl_name, ComponentHookList.ON_ROLL_OUT);
                        this.uiApi.addComponentHook(componentsRef.lbl_name, ComponentHookList.ON_ROLL_OVER);
                    };
                    this._componentList[componentsRef.lbl_name.name] = data;
                    if (!this._componentList[componentsRef.lbl_value.name])
                    {
                        this.uiApi.addComponentHook(componentsRef.lbl_value, ComponentHookList.ON_ROLL_OUT);
                        this.uiApi.addComponentHook(componentsRef.lbl_value, ComponentHookList.ON_ROLL_OVER);
                    };
                    this._componentList[componentsRef.lbl_value.name] = data;
                    componentsRef.lbl_name.cssClass = "p";
                    if (data.gfxId != "null")
                    {
                        componentsRef.tx_picto.visible = true;
                        componentsRef.tx_picto.uri = this.uiApi.createUri((this.uiApi.me().getConstant("picto_uri") + data.gfxId));
                    }
                    else
                    {
                        componentsRef.tx_picto.uri = null;
                    };
                    if (((data.cat == -1) && (data.numId == -1)))
                    {
                        componentsRef.lbl_favExplanation.visible = true;
                        componentsRef.lbl_name.visible = false;
                        componentsRef.lbl_value.visible = false;
                        componentsRef.tx_picto.visible = false;
                    }
                    else
                    {
                        componentsRef.lbl_favExplanation.visible = false;
                        componentsRef.lbl_name.visible = true;
                        componentsRef.lbl_value.visible = true;
                        componentsRef.tx_picto.visible = true;
                    };
                    componentsRef.lbl_name.text = data.text;
                    if (((data.id == "actionPoints") || (data.id == "movementPoints")))
                    {
                        currentBase = (this._characterCharacteristics[(data.id + "Current")] - (data.boost + data.stuff));
                        if (currentBase < 0)
                        {
                            bonusUsed = Math.abs(currentBase);
                            currentBase = 0;
                        };
                    };
                    base = ((isNaN(currentBase)) ? (data.base + data.additionnal) : currentBase);
                    bonus = (((data.boost + data.stuff) + data.gift) - bonusUsed);
                    if (String(data.id).indexOf("%") != -1)
                    {
                        total = Math.min(50, (((data.base + data.boost) + data.stuff) + data.gift));
                    }
                    else
                    {
                        total = (base + bonus);
                    };
                    if (total != 0)
                    {
                        componentsRef.lbl_value.text = total;
                    }
                    else
                    {
                        componentsRef.lbl_value.text = "-";
                    };
                    break;
            };
        }

        public function getCatLineType(data:*, line:uint):String
        {
            if (!data)
            {
                return ("");
            };
            if (data.isCat)
            {
                return (CTR_CAT_TYPE_CAT);
            };
            return (CTR_CAT_TYPE_ITEM);
        }

        public function getCatDataLength(data:*, selected:Boolean):*
        {
            if (selected)
            {
            };
            return (10);
        }

        public function restoreChildIndex():void
        {
            this.uiApi.me().childIndex = this._lastChildIndex;
        }

        private function getParsedStat(stat:Object, forAdvancedTooltip:Boolean=false):String
        {
            var parsedStat:String;
            if (forAdvancedTooltip)
            {
                parsedStat = ((((((this.uiApi.getText("ui.common.base") + this.uiApi.getText("ui.common.colon")) + (stat.base + stat.additionnal)) + "\n") + this.uiApi.getText("ui.common.bonus")) + this.uiApi.getText("ui.common.colon")) + ((stat.boost + stat.stuff) + stat.gift));
            }
            else
            {
                parsedStat = (((((((((((((((((this.uiApi.getText("ui.common.base") + " (") + this.uiApi.getText("ui.charaSheet.natural")) + " + ") + this.uiApi.getText("ui.charaSheet.additionnal")) + ")") + this.uiApi.getText("ui.common.colon")) + stat.base) + "+") + stat.additionnal) + "\n") + this.uiApi.getText("ui.common.equipement")) + this.uiApi.getText("ui.common.colon")) + stat.stuff) + "\n") + this.uiApi.getText("ui.charaSheet.temporaryBonus")) + this.uiApi.getText("ui.common.colon")) + stat.boost);
                if (((this.sysApi.getCurrentServer().gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS) && (this.dataApi.getCurrentSeason().seasonNumber == 3)))
                {
                    parsedStat = (parsedStat + ((("\n" + this.uiApi.getText("ui.temporis.alignmentGift")) + this.uiApi.getText("ui.common.colon")) + stat.gift));
                };
            };
            return (parsedStat);
        }

        private function dataInit():void
        {
            var cat:CharacteristicCategory;
            var pdvCharac:Characteristic;
            var cId:int;
            var charac:Characteristic;
            for each (cat in this._characteristicsCategoriesData)
            {
                this._dataMatrix.push({
                    "name":cat.name,
                    "id":cat.id,
                    "isCat":true
                });
                for each (cId in cat.characteristicIds)
                {
                    charac = this.dataApi.getCharacteristic(cId);
                    if (charac)
                    {
                        this._dataMatrix.push(new CharacteristiqueGridItem(cId, charac.keyword, charac.name, charac.asset, charac.id, charac.upgradable, charac.categoryId));
                    };
                };
            };
            pdvCharac = this.dataApi.getCharacteristic(0);
            this._pdvLine = {
                "id":pdvCharac.keyword,
                "text":pdvCharac.name,
                "gfxId":pdvCharac.asset,
                "numId":pdvCharac.id,
                "base":0,
                "additionnal":0,
                "stuff":0,
                "boost":0
            };
        }

        private function creareFavItemsArray():Array
        {
            var item:*;
            var cloneItem:CharacteristiqueGridItem;
            var favItems:Array = [];
            favItems.push({
                "name":this.uiApi.getText("ui.charaSheet.favorite"),
                "id":-1,
                "isCat":true
            });
            if (this._favCategoriesId.length <= 0)
            {
                cloneItem = new CharacteristiqueGridItem(-1, "", "", null, -1, false, -1);
                favItems.push(cloneItem);
                return (favItems);
            };
            for each (item in this._dataMatrix)
            {
                if (((!(item.isCat)) && (!(this._favCategoriesId.indexOf(item.numId) == -1))))
                {
                    cloneItem = item.clone();
                    cloneItem.cat = -1;
                    favItems.push(cloneItem);
                };
            };
            return (favItems);
        }

        private function characterUpdate():void
        {
            var xpPercent:Number;
            var percentBonus:Number;
            this._characterCharacteristics = this.playerApi.characteristics();
            this.lbl_advancedName.text = (this.lbl_name.text = this._characterInfos.name);
            if (this._characterInfos.level > ProtocolConstantsEnum.MAX_LEVEL)
            {
                this.lbl_advancedLvl.text = (this.lbl_lvl.text = ((this.uiApi.getText("ui.common.prestige") + " ") + (this._characterInfos.level - ProtocolConstantsEnum.MAX_LEVEL)));
                this._xpColor = this.sysApi.getConfigEntry("colors.progressbar.gold");
            }
            else
            {
                this.lbl_advancedLvl.text = (this.lbl_lvl.text = ((this.uiApi.getText("ui.common.level") + " ") + this._characterInfos.level));
                this._xpColor = this.sysApi.getConfigEntry("colors.progressbar.xp");
            };
            if (this.playerApi.getTitle())
            {
                this.lbl_charTitle.text = this.playerApi.getTitle().name;
            }
            else
            {
                this.lbl_charTitle.text = this.uiApi.getText("ui.common.noTitle");
            };
            this.pb_xp.barColor = this._xpColor;
            var experienceDelta:Number = (this._characterCharacteristics.experienceNextLevelFloor - this._characterCharacteristics.experienceLevelFloor);
            var requiredXp:Number = (this._characterCharacteristics.experienceNextLevelFloor - this._characterCharacteristics.experience);
            if (experienceDelta > 0)
            {
                xpPercent = ((this._characterCharacteristics.experience - this._characterCharacteristics.experienceLevelFloor) / experienceDelta);
                this.pb_xp.value = xpPercent;
            }
            else
            {
                this.pb_xp.value = 0;
            };
            this._xpInfoText = this.utilApi.formateIntToString(this._characterCharacteristics.experience);
            this._xpInfoText = (this._xpInfoText + (" / " + this.utilApi.formateIntToString(this._characterCharacteristics.experienceNextLevelFloor)));
            if (experienceDelta > 0)
            {
                this._xpInfoText = (this._xpInfoText + (((("\n" + this.uiApi.getText("ui.common.nextLevel")) + this.uiApi.getText("ui.common.colon")) + Math.floor((xpPercent * 100))) + " %"));
            };
            this._xpInfoText = (this._xpInfoText + ((("\n" + this.uiApi.getText("ui.common.required")) + this.uiApi.getText("ui.common.colon")) + this.utilApi.formateIntToString(requiredXp)));
            var bonusLimitXp:Number = this._characterCharacteristics.experienceBonusLimit;
            if (((bonusLimitXp) && (bonusLimitXp > this._characterCharacteristics.experience)))
            {
                if (bonusLimitXp > this._characterCharacteristics.experienceNextLevelFloor)
                {
                    this.pb_xp.innerValue = 1;
                }
                else
                {
                    percentBonus = ((bonusLimitXp - this._characterCharacteristics.experienceLevelFloor) / (this._characterCharacteristics.experienceNextLevelFloor - this._characterCharacteristics.experienceLevelFloor));
                    this.pb_xp.innerValue = percentBonus;
                };
                this.pb_xp.innerBarColor = this._xpColor;
                this.pb_xp.innerBarAlpha = 0.3;
                this._xpInfoText = (this._xpInfoText + (("\n<i>" + this.uiApi.getText("ui.help.xpBonus", 2)) + "</i>"));
            };
            var energyPercent:Number = (this._characterCharacteristics.energyPoints / this._characterCharacteristics.maxEnergyPoints);
            if (energyPercent <= 0)
            {
                this.pb_energy.visible = false;
            }
            else
            {
                this.pb_energy.visible = true;
                this.pb_energy.value = energyPercent;
            };
            this.btn_spouse.visible = this.socialApi.hasSpouse();
            var houses:Object = this.playerApi.getPlayerHouses();
            this.btn_house.visible = ((houses) && (houses.length >= 1));
            switch (this.playerApi.getAlignmentSide())
            {
                case AlignementSideEnum.ALIGNMENT_ANGEL:
                    this.bgTexturebtn_pvp.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture_uri") + "tx_alignement_bonta.png"));
                    this.btn_pvp.visible = true;
                    break;
                case AlignementSideEnum.ALIGNMENT_EVIL:
                    this.bgTexturebtn_pvp.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture_uri") + "tx_alignement_brakmar.png"));
                    this.btn_pvp.visible = true;
                    break;
                default:
                    this.btn_pvp.visible = false;
            };
            this.lbl_rewardPoints.text = ((this.utilApi.kamasToString(this.playerApi.getAchievementPoints(), "") + " ") + this.uiApi.getText("ui.common.points"));
            this.statsUpdate();
        }

        private function statsUpdate():void
        {
            var data:Object;
            var points:int;
            var carac:Object;
            var allStatsAreNull:Boolean = true;
            this._characterCharacteristics = this.playerApi.characteristics();
            this._someStatsMayBeScrolled = false;
            this._statListWithLife.push(this._pdvLine);
            for each (data in this._dataMatrix)
            {
                if (((!(data)) || (data.isCat)))
                {
                }
                else
                {
                    carac = this._characterCharacteristics[data.id];
                    if ((carac is CharacterBaseCharacteristic))
                    {
                        data.base = carac.base;
                        data.additionnal = carac.additionnal;
                        data.stuff = carac.objectsAndMountBonus;
                        data.boost = carac.contextModif;
                        data.gift = carac.alignGiftBonus;
                    }
                    else
                    {
                        if ((carac is int))
                        {
                            data.base = carac;
                        };
                    };
                    if ((((data.cat == DataEnum.CHARACTERISTIC_TYPE_PRIMARY) || (data.id == "tackleBlock")) || (data.id == "tackleEvade")))
                    {
                        if (data.upgradable)
                        {
                            this._caracList.push(data);
                            if (data.base > 0)
                            {
                                allStatsAreNull = false;
                            };
                        }
                        else
                        {
                            this._statListWithLife.push(data);
                        };
                        if (((data.upgradable) && (data.additionnal < ProtocolConstantsEnum.MAX_ADDITIONNAL_PER_CARAC)))
                        {
                            this._someStatsMayBeScrolled = true;
                        };
                    };
                };
            };
            this.lbl_healthPointsValue.text = this.utilApi.kamasToString(this._characterCharacteristics.maxLifePoints, "");
            this.lbl_actionPointsValue.text = this.utilApi.kamasToString((((this._characterCharacteristics.actionPoints.base + this._characterCharacteristics.actionPoints.additionnal) + this._characterCharacteristics.actionPoints.contextModif) + this._characterCharacteristics.actionPoints.objectsAndMountBonus), "");
            this.lbl_movementPointsValue.text = this.utilApi.kamasToString((((this._characterCharacteristics.movementPoints.base + this._characterCharacteristics.movementPoints.additionnal) + this._characterCharacteristics.movementPoints.contextModif) + this._characterCharacteristics.movementPoints.objectsAndMountBonus), "");
            points = ((this._someStatsMayBeScrolled) ? (this._characterCharacteristics.statsPoints + this._characterCharacteristics.additionnalPoints) : this._characterCharacteristics.statsPoints);
            this.lbl_statPoints.text = this.utilApi.kamasToString(points, "");
            this.btn_reset.softDisabled = allStatsAreNull;
            this.gridsUpdate();
        }

        private function gridsUpdate():void
        {
            if (this.ctr_regular.visible)
            {
                this.gd_carac.dataProvider = this._caracList;
            }
            else
            {
                this.displayCategories();
            };
        }

        private function displayCategories(selectedCategory:Object=null, forceOpen:Boolean=false):void
        {
            var myIndex:int;
            var entry:Object;
            var selecCatId:int;
            if (selectedCategory)
            {
                selecCatId = selectedCategory.id;
                if (this._openedCategories.indexOf(selecCatId) != -1)
                {
                    this._openedCategories.splice(this._openedCategories.indexOf(selecCatId), 1);
                }
                else
                {
                    this._openedCategories.push(selecCatId);
                };
            };
            var index:int = -1;
            var tempCats:Array = [];
            var categoryOpened:int = -1;
            var favItems:Array = this.creareFavItemsArray();
            var fullArray:Array = favItems.concat(this._dataMatrix);
            for each (entry in fullArray)
            {
                if (entry.isCat)
                {
                    tempCats.push(entry);
                    index++;
                    if (entry.id == selecCatId)
                    {
                        myIndex = index;
                    };
                };
                if (((!(entry.isCat)) && (!(this._openedCategories.indexOf(entry.cat) == -1))))
                {
                    tempCats.push(entry);
                    index++;
                };
            };
            if (categoryOpened >= 0)
            {
                this._openCatIndex = categoryOpened;
            }
            else
            {
                this._openCatIndex = 0;
            };
            this._currentSelectedCatId = selecCatId;
            var scrollValue:int = this.gd_caracAdvanced.verticalScrollValue;
            this.gd_caracAdvanced.dataProvider = tempCats;
            if (this.gd_caracAdvanced.selectedIndex != myIndex)
            {
                this.gd_caracAdvanced.silent = true;
                this.gd_caracAdvanced.selectedIndex = myIndex;
                this.gd_caracAdvanced.silent = false;
            };
            this.gd_caracAdvanced.verticalScrollValue = scrollValue;
            this.gd_caracAdvanced.focus();
            this.sysApi.setData("openedCharsheetCat", this._openedCategories);
        }

        private function updateFavCatArray(numId:int, delEntry:Boolean):void
        {
            if (!delEntry)
            {
                this._favCategoriesId.push(numId);
            }
            else
            {
                this._favCategoriesId.splice(this._favCategoriesId.indexOf(numId), 1);
            };
            this.sysApi.setData("favCharsheetCat", this._favCategoriesId);
            this.displayCategories();
        }

        private function displaySelectedTab(tab:uint):void
        {
            switch (tab)
            {
                case STAT_REGULAR_TAB:
                    this.ctr_regular.visible = true;
                    this.ctr_advanced.visible = false;
                    break;
                case STAT_ADVANCED_TAB:
                    this.ctr_regular.visible = false;
                    this.ctr_advanced.visible = true;
                    break;
            };
            this.gridsUpdate();
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (target == this.gd_caracAdvanced)
            {
                if (((!(selectMethod == GridItemSelectMethodEnum.AUTO)) && (target.selectedItem.isCat)))
                {
                    this._currentScrollValue = 0;
                    this._caracListToDisplay = [];
                    this._lastCategorySelected = target.selectedItem;
                    this.displayCategories(target.selectedItem);
                }
                else
                {
                    if (!target.selectedItem.isCat)
                    {
                        this.gd_caracAdvanced.focus();
                    };
                };
            };
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            var menu:Array;
            if (!item.data.isCat)
            {
                menu = [];
                if (this._favCategoriesId.indexOf(item.data.numId) == -1)
                {
                    menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.zaap.addFavoritTooltip"), this.updateFavCatArray, [item.data.numId, false]));
                }
                else
                {
                    menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.zaap.deleteFavoritTooltip"), this.updateFavCatArray, [item.data.numId, true]));
                };
                this.modContextMenu.createContextMenu(menu);
            };
        }

        public function onRelease(target:Object):void
        {
            var side:int;
            var param:Object;
            var text:String;
            var isRoleplayOrPrefight:Boolean;
            if ((((this.uiApi.getUi("levelUp")) && (!(target == this.btn_reset))) && (target.name.indexOf("btn_plus") == -1)))
            {
                this.uiApi.unloadUi("levelUp");
            };
            switch (target)
            {
                case this.btn_close:
                    if (this.uiApi.getUi("statBoost"))
                    {
                        this.uiApi.unloadUi("statBoost");
                    };
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_pvp:
                    side = this.playerApi.getAlignmentSide();
                    if (((side == AlignementSideEnum.ALIGNMENT_ANGEL) || (side == AlignementSideEnum.ALIGNMENT_EVIL)))
                    {
                        this.sysApi.sendAction(new OpenBook("alignmentTab"));
                    };
                    break;
                case this.btn_regular:
                    if (this._nCurrentTab != STAT_REGULAR_TAB)
                    {
                        this._nCurrentTab = STAT_REGULAR_TAB;
                        this.displaySelectedTab(this._nCurrentTab);
                        this.currentTabName = target.name;
                        this.hintsApi.uiTutoTabLaunch();
                    };
                    break;
                case this.btn_advanced:
                    if (this._nCurrentTab != STAT_ADVANCED_TAB)
                    {
                        this._nCurrentTab = STAT_ADVANCED_TAB;
                        this.displaySelectedTab(this._nCurrentTab);
                        this.currentTabName = target.name;
                        this.hintsApi.uiTutoTabLaunch();
                    };
                    break;
                case this.btn_spellBook:
                    param = {};
                    param.strata = this.uiApi.getUi(this.uiApi.me().name).strata;
                    if (this.dataApi.isTemporisSpellsUi())
                    {
                        this.sysApi.sendAction(new OpenBook("temporisSpellsUi", param));
                    }
                    else
                    {
                        param[0] = "spellList";
                        param[1] = {"variantsListTab":true};
                        this.sysApi.sendAction(new OpenBook("spellBase", param));
                    };
                    break;
                case this.btn_build:
                    this.uiApi.unloadUi("statBoost");
                    this.sysApi.dispatchHook(OpenCharacterBuilds, -1);
                    break;
                case this.ctr_charTitleButton:
                    this.sysApi.sendAction(new OpenBook("titleTab"));
                    break;
                case this.ctr_rewardPointButton:
                    this.sysApi.sendAction(new OpenBook("achievementTab"));
                    break;
                case this.btn_spouse:
                    if (this.socialApi.hasSpouse())
                    {
                        this.sysApi.sendAction(new d2actions.OpenSocial(3));
                    };
                    break;
                case this.btn_house:
                    this.sysApi.sendAction(new OpenHouses());
                    break;
                case this.btn_reset:
                    text = this.uiApi.getText("ui.charaSheet.resetStatsConfirm");
                    this._resetPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), text, [this.uiApi.getText("ui.common.ok"), this.uiApi.getText("ui.common.cancel")], [this.onPopupSendRestat, this.onPopupClose], this.onPopupSendRestat, this.onPopupClose, null, false, false, true, null, this.uiApi.me().strata);
                    break;
                case this.ctr_openGuildTab:
                    if (this.socialApi.hasGuild())
                    {
                        this.sysApi.sendAction(new d2actions.OpenSocial(1));
                    }
                    else
                    {
                        this.sysApi.dispatchHook(d2hooks.OpenSocial, 4, 0);
                    };
                    break;
                case this.ctr_openAllianceTab:
                    if (this.socialApi.hasAlliance())
                    {
                        this.sysApi.sendAction(new d2actions.OpenSocial(2));
                    }
                    else
                    {
                        this.sysApi.dispatchHook(d2hooks.OpenSocial, 4, 1);
                    };
                    break;
                case this.btn_help:
                    this.hintsApi.showSubHints(this.currentTabName);
                    break;
                default:
                    if (target.name.indexOf("btn_plus") != -1)
                    {
                        isRoleplayOrPrefight = ((!(this.playerApi.isInFight())) || (this.playerApi.isInPreFight()));
                        if (!isRoleplayOrPrefight)
                        {
                            return;
                        };
                        if (!this.uiApi.getUi("statBoost"))
                        {
                            this.uiApi.loadUi("statBoost", "statBoost", [this._componentList[target.name].id, this._componentList[target.name].numId, this._someStatsMayBeScrolled], this.uiApi.me().strata);
                            this.uiApi.me().setOnTopBeforeMe.push(this.uiApi.getUi("statBoost"));
                        }
                        else
                        {
                            if (((this._componentList[target.name]) && (!(this.uiApi.getUi("statBoost").uiClass.statId == this._componentList[target.name].numId))))
                            {
                                this.uiApi.getUi("statBoost").uiClass.displayUI(this._componentList[target.name].id, this._componentList[target.name].numId, this._someStatsMayBeScrolled);
                            };
                        };
                    };
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
            this.uiApi.hideTooltip("statboostTooltip");
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            var data:*;
            var params:*;
            var favText:String;
            var description:String;
            var isRoleplayOrPrefight:Boolean;
            switch (target)
            {
                case this.lbl_lvl:
                    text = this.uiApi.getText("ui.help.level", ProtocolConstantsEnum.MAX_LEVEL);
                    break;
                case this.pb_xp:
                    text = ((this._xpInfoText + "\n") + this.uiApi.getText("ui.banner.xpBonus", (this.playerApi.getExperienceBonusPercent() + 100)));
                    break;
                case this.pb_energy:
                    text = ((this.utilApi.formateIntToString(this._characterCharacteristics.energyPoints) + " / ") + this.utilApi.formateIntToString(this._characterCharacteristics.maxEnergyPoints));
                    break;
                case this.lbl_energy:
                    text = this.uiApi.getText("ui.help.energy");
                    break;
                case this.lbl_xp:
                    text = this.uiApi.getText("ui.help.xp");
                    break;
                case this.ctr_pointsToDivide:
                    text = this.uiApi.getText("ui.help.boostPoints");
                    if (((this._someStatsMayBeScrolled) && (this._characterCharacteristics.additionnalPoints > 0)))
                    {
                        text = (text + (((((((((("\n\n" + this.uiApi.getText("ui.common.base")) + " (") + this.uiApi.getText("ui.charaSheet.natural")) + " + ") + this.uiApi.getText("ui.charaSheet.additionnal")) + ")") + this.uiApi.getText("ui.common.colon")) + this._characterCharacteristics.statsPoints) + "+") + this._characterCharacteristics.additionnalPoints));
                    };
                    break;
                case this.btn_title:
                    text = this.uiApi.getText("ui.common.titles");
                    break;
                case this.btn_spouse:
                    text = this.uiApi.processText(this.uiApi.getText("ui.common.spouse"), ((this._spouse.sex > 0) ? "f" : "m"), true);
                    break;
                case this.btn_house:
                    text = this.uiApi.getText("ui.common.housesWord");
                    break;
                case this.btn_reset:
                    text = this.uiApi.getText("ui.charaSheet.resetStats");
                    break;
                case this.btn_pvp:
                    text = this.uiApi.getText("ui.common.alignment");
                    break;
                case this.lbl_advancedBaseColumn:
                    text = this.uiApi.getText("ui.charaSheet.advancedBaseInfo");
                    break;
                case this.lbl_advancedBonusColumn:
                    text = this.uiApi.getText("ui.charaSheet.advancedBonusInfo");
                    break;
                case this.ctr_charTitleButton:
                    if (this.playerApi.getTitle())
                    {
                        text = this.uiApi.getText("ui.charaSheet.changeTitle");
                    }
                    else
                    {
                        text = this.uiApi.getText("ui.charaSheet.noTitle");
                    };
                    break;
                case this.ctr_rewardPointButton:
                    text = this.uiApi.getText("ui.achievement.achievement");
                    break;
                case this.ctr_healhPointsSmallBlock:
                    text = this.uiApi.getText("ui.help.lifePoints");
                    break;
                case this.ctr_actionPointsSmallBlock:
                    text = this.uiApi.getText("ui.help.actionPoints");
                    break;
                case this.ctr_movementPointsSmallBlock:
                    text = this.uiApi.getText("ui.help.movementPoints");
                    break;
                case this.ctr_openGuildTab:
                    text = ((this.socialApi.hasGuild()) ? this._guild.guildName : this.uiApi.getText("ui.common.guild"));
                    break;
                case this.ctr_openAllianceTab:
                    text = ((this.socialApi.hasAlliance()) ? this._alliance.allianceName : this.uiApi.getText("ui.common.alliance"));
                    break;
                case this.tx_warningSpell:
                    text = this.uiApi.getText("ui.spell.spellsUnlocked");
                    break;
                default:
                    if (target.name.indexOf("lbl_name") != -1)
                    {
                        favText = "";
                        data = this._componentList[target.name];
                        if (this._favCategoriesId.indexOf(data.numId) == -1)
                        {
                            favText = this.uiApi.getText("ui.charaSheet.rightClickToAdd");
                        }
                        else
                        {
                            favText = this.uiApi.getText("ui.charaSheet.rightClickToRemove");
                        };
                        if (this.ctr_advanced.visible)
                        {
                            text = null;
                            description = this.uiApi.getText(("ui.help." + this._componentList[target.name].id));
                            if (description.indexOf("[UNKNOWN_TEXT_NAME") != -1)
                            {
                                text = favText;
                            }
                            else
                            {
                                params = {
                                    "content":this.uiApi.getText(("ui.help." + this._componentList[target.name].id)),
                                    "additionalInfo":favText,
                                    "maxWidth":400,
                                    "addInfoCssClass":"italiclightgrey"
                                };
                                this.uiApi.showTooltip(params, target, false, "standard", 5, 3, 3, "textInfoWithHorizontalSeparator", null, null, null, false, this._tooltipStrata);
                            };
                        }
                        else
                        {
                            text = this.uiApi.getText(("ui.help." + this._componentList[target.name].id));
                        };
                    }
                    else
                    {
                        if (target.name.indexOf("lbl_value") != -1)
                        {
                            if (this.ctr_advanced.visible)
                            {
                                text = null;
                                params = {
                                    "content":this.getParsedStat(this._componentList[target.name], true),
                                    "additionalInfo":((this.uiApi.getText("ui.common.total") + this.uiApi.getText("ui.common.colon")) + target.text),
                                    "maxWidth":100
                                };
                                this.uiApi.showTooltip(params, target, false, "standard", 6, 2, 3, "textInfoWithHorizontalSeparator", null, null, null, false, this._tooltipStrata);
                            }
                            else
                            {
                                text = this.getParsedStat(this._componentList[target.name]);
                            };
                        }
                        else
                        {
                            if (target.name.indexOf("lbl_base") != -1)
                            {
                                data = this._componentList[target.name];
                                if (((((((data) && (!(data.isCat))) && (data.hasOwnProperty("upgradable"))) && (data.upgradable)) && (data.hasOwnProperty("base"))) && ((data.base > 0) || (data.additionnal > 0))))
                                {
                                    text = ((("" + data.base) + " + ") + data.additionnal);
                                };
                            }
                            else
                            {
                                if (target.name.indexOf("lbl_bonus") != -1)
                                {
                                    data = this._componentList[target.name];
                                    if (((((data) && (!(data.isCat))) && (data.hasOwnProperty("boost"))) && (data.boost > 0)))
                                    {
                                        text = ((("" + data.stuff) + " + ") + data.boost);
                                    };
                                }
                                else
                                {
                                    if (target.name.indexOf("btn_plus") != -1)
                                    {
                                        isRoleplayOrPrefight = ((!(this.playerApi.isInFight())) || (this.playerApi.isInPreFight()));
                                        if (!isRoleplayOrPrefight)
                                        {
                                            text = this.uiApi.getText("ui.charaSheet.caracBoostNoFight");
                                        }
                                        else
                                        {
                                            if (target.softDisabled)
                                            {
                                                text = this.uiApi.getText("ui.charaSheet.notEnoughtPoints");
                                            }
                                            else
                                            {
                                                switch (this._componentList[target.name].numId)
                                                {
                                                    case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_VITALITY:
                                                        text = this.uiApi.getText("ui.stats.modifyVitalityPoints");
                                                        break;
                                                    case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_WISDOM:
                                                        text = this.uiApi.getText("ui.stats.modifyWisdomPoints");
                                                        break;
                                                    case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_STRENGTH:
                                                        text = this.uiApi.getText("ui.stats.modifyStrengthPoints");
                                                        break;
                                                    case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_INTELLIGENCE:
                                                        text = this.uiApi.getText("ui.stats.modifyIntelligencePoints");
                                                        break;
                                                    case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_CHANCE:
                                                        text = this.uiApi.getText("ui.stats.modifyChancePoints");
                                                        break;
                                                    case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_AGILITY:
                                                        text = this.uiApi.getText("ui.stats.modifyAgilityPoints");
                                                        break;
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", 7, 1, 3, null, null, null, "textWithSeparator", false, this._tooltipStrata);
            };
        }

        public function onStatsUpgradeResult(nbCharacBoost:uint):void
        {
            if (nbCharacBoost > 0)
            {
                this.statsUpdate();
            };
        }

        public function onInventoryContent(equipment:Object):void
        {
            this.characterUpdate();
        }

        public function onCharacterStatsList(oneLifePointRegenOnly:Boolean=false):void
        {
            this.characterUpdate();
        }

        public function onFightEvent(eventName:String, params:Object, targetList:Object=null):void
        {
            var num:int = targetList.length;
            var i:int;
            while (i < num)
            {
                if (targetList[i] == this.playerApi.id())
                {
                    switch (eventName)
                    {
                        case FightEventEnum.FIGHTER_LIFE_GAIN:
                        case FightEventEnum.FIGHTER_LIFE_LOSS:
                        case FightEventEnum.FIGHTER_TEMPORARY_BOOSTED:
                        case FightEventEnum.FIGHTER_AP_USED:
                        case FightEventEnum.FIGHTER_AP_LOST:
                        case FightEventEnum.FIGHTER_AP_GAINED:
                        case FightEventEnum.FIGHTER_MP_USED:
                        case FightEventEnum.FIGHTER_MP_LOST:
                        case FightEventEnum.FIGHTER_MP_GAINED:
                            this.characterUpdate();
                    };
                };
                i++;
            };
        }

        private function onHouseInformations(houses:Object):void
        {
            this.btn_house.visible = (!((!(houses)) || (houses.length == 0)));
        }

        private function onSpellsToHighlightUpdate(newSpellIdsToHighlight:Array):void
        {
            this.tx_warningSpell.visible = (newSpellIdsToHighlight.length > 0);
        }

        private function onContextChanged(context:String, previousContext:String="", contextChanged:Boolean=false):void
        {
            this.gridsUpdate();
        }

        private function onStrataUpdate(uiName:String, strata:int):void
        {
            if (this.uiApi.me().name == uiName)
            {
                this._tooltipStrata = strata;
            };
        }

        private function onShortCut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                this.uiApi.unloadUi(((this.uiApi.getUi("statBoost")) ? "statBoost" : this.uiApi.me().name));
                return (true);
            };
            return (false);
        }

        public function onUiLoaded(pUiName:String):void
        {
            if (pUiName == "statBoost")
            {
                this._lastChildIndex = this.uiApi.me().childIndex;
                this.uiApi.me().setOnTop();
            };
        }

        public function onUiUnloaded(pUiName:String):void
        {
            if (pUiName == "statBoost")
            {
                this.uiApi.me().setOnTopBeforeMe = [];
            };
        }

        public function onTextureReady(target:Object):void
        {
            switch (target)
            {
                case this.tx_guildEmblemBack:
                    this.utilApi.changeColor(this.tx_guildEmblemBack.getChildByName("back"), this._guild.backEmblem.color, 1);
                    break;
                case this.tx_guildEmblemFront:
                    if (this.dataApi.getEmblemSymbol(this._guild.upEmblem.idEmblem).colorizable)
                    {
                        this.utilApi.changeColor(this.tx_guildEmblemFront.getChildByName("up"), this._guild.upEmblem.color, 0);
                    }
                    else
                    {
                        this.utilApi.changeColor(this.tx_guildEmblemFront.getChildByName("up"), this._guild.upEmblem.color, 0, true);
                    };
                    break;
                case this.tx_allianceEmblemBack:
                    this.utilApi.changeColor(this.tx_allianceEmblemBack.getChildByName("back"), this._alliance.backEmblem.color, 1);
                    break;
                case this.tx_allianceEmblemFront:
                    if (this.dataApi.getEmblemSymbol(this._alliance.upEmblem.idEmblem).colorizable)
                    {
                        this.utilApi.changeColor(this.tx_allianceEmblemFront.getChildByName("up"), this._alliance.upEmblem.color, 0);
                    }
                    else
                    {
                        this.utilApi.changeColor(this.tx_allianceEmblemFront.getChildByName("up"), this._alliance.upEmblem.color, 0, true);
                    };
                    break;
            };
        }

        public function onPopupClose():void
        {
        }

        public function onPopupSendRestat():void
        {
            this.sysApi.sendAction(new ResetCharacterStatsRequest());
        }

        private function onLevelUpStatsTutorial():void
        {
            this.btn_spellBook.disabled = true;
            this.btn_build.disabled = true;
        }

        private function onCloseLevelUpUiTutorial():void
        {
            this.btn_spellBook.disabled = false;
            this.btn_build.disabled = false;
        }

        private function onGameFightStart():void
        {
            this.btn_reset.disabled = true;
        }

        private function onGameFightEnd(params:Object):void
        {
            this.btn_reset.disabled = false;
        }


    }
}

class CharacteristiqueGridItem 
{

    public var cId:int = 0;
    public var id:String;
    public var text:String;
    public var gfxId:String;
    public var numId:int;
    public var upgradable:Boolean;
    public var cat:int;
    public var base:uint = 0;
    public var additionnal:uint = 0;
    public var stuff:int = 0;
    public var boost:int = 0;
    public var gift:int = 0;
    public var isCat:Boolean = false;

    public function CharacteristiqueGridItem(gCid:int, gId:String, gText:String, gGfxId:String, gNumId:int, gUpgradable:Boolean, gCat:int)
    {
        this.cId = gCid;
        this.id = gId;
        this.text = gText;
        this.gfxId = gGfxId;
        this.numId = gNumId;
        this.upgradable = gUpgradable;
        this.cat = gCat;
    }

    public function clone():CharacteristiqueGridItem
    {
        var _local_1:CharacteristiqueGridItem = new CharacteristiqueGridItem(this.cId, this.id, this.text, this.gfxId, this.numId, this.upgradable, this.cat);
        _local_1.base = this.base;
        _local_1.additionnal = this.additionnal;
        _local_1.stuff = this.stuff;
        _local_1.boost = this.boost;
        _local_1.gift = this.gift;
        _local_1.isCat = this.isCat;
        return (_local_1);
    }


}


