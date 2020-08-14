package Ankama_Fight.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.AveragePricesApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.CaptureApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.components.TextureBitmap;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.datacenter.idols.Idol;
    import Ankama_Fight.Fight;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofus.network.enums.FightTypeEnum;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import d2hooks.FightResultClosed;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
    import flash.geom.ColorTransform;
    import com.ankamagames.dofus.network.enums.FightOutcomeEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.dofus.types.enums.ScreenshotTypeEnum;
    import d2hooks.TextInformation;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import d2actions.OpenIdols;
    import d2actions.OpenBook;
    import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
    import d2hooks.ShowObjectLinked;
    import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
    import com.ankamagames.berilia.types.LocationEnum;
    import d2hooks.*;

    public class FightResult 
    {

        private static const RESULT_COMPLETE:uint = 1;
        private static const RESULT_FAILED:uint = 2;
        private static const MAXIMAL_SIZE:uint = 18;

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="AveragePricesApi")]
        public var averagePricesApi:AveragePricesApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="CaptureApi")]
        public var captureApi:CaptureApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var ctr_drop:GraphicContainer;
        public var mainCtr:GraphicContainer;
        public var ctr_fightResult:GraphicContainer;
        public var ctr_gridResult:GraphicContainer;
        public var fightResultWindow:GraphicContainer;
        public var btn_close_fightResultWindow:ButtonContainer;
        public var btn_close2:ButtonContainer;
        public var btn_closeDrop:ButtonContainer;
        public var btn_idols:ButtonContainer;
        public var btn_minimize:ButtonContainer;
        public var ctr_rewardRate:GraphicContainer;
        public var tx_rewardRate:GraphicContainer;
        public var lbl_rewardRate:Label;
        public var lbl_result:Label;
        public var lbl_time:Label;
        public var lbl_honour:Label;
        public var lbl_drop:Label;
        public var lbl_score:Label;
        public var lbl_objects:Label;
        public var lbl_kamas:Label;
        public var gd_fighters:Grid;
        public var gd_drop:Grid;
        public var gd_idols:Grid;
        public var tx_challenge1:Texture;
        public var tx_challenge2:Texture;
        public var tx_challenge_result1:Texture;
        public var tx_challenge_result2:Texture;
        public var tx_gdFighterBg:Texture;
        public var tx_gridHeader:Texture;
        public var tx_result:TextureBitmap;
        public var tx_honor_separator:TextureBitmap;
        public var tx_minimizeBg:TextureBitmap;
        public var tx_kamaItemSeparator:TextureBitmap;
        public var tx_breachItemSeparator:TextureBitmap;
        public var btn_share:ButtonContainer;
        private var CTR_TYPE_TITLE:String = "ctr_title";
        private var CTR_TYPE_FIGHTER:String = "ctr_fighter";
        private var _challenges:Array;
        private var _rewardRate:int;
        private var _isPvpFight:Boolean;
        private var _winnersName:String;
        private var _losersName:String;
        private var _widthName:int;
        private var _widthXp:int;
        private var _widthXpWithHonour:int;
        private var _pictoUris:Array = [];
        private var _objectsLists:Dictionary = new Dictionary(true);
        private var _hookGridObjects:Dictionary = new Dictionary(true);
        private var _headsUri:String;
        private var _bgLevelUri:Object;
        private var _bgPrestigeUri:Object;
        private var _helpColor:String;
        private var _idols:Object;
        private var _totalScore:uint;
        private var _totalExp:uint;
        private var _totalLoot:uint;
        private var _objectsGridCoord:Array = [];
        private var _breachMode:Boolean = false;
        private var _budget:int;


        public function main(params:Object):void
        {
            var i:int;
            var idol:Idol;
            var coeff:Number;
            if (this.uiApi.getUi("levelUp"))
            {
                this.uiApi.me().visible = false;
            };
            if (params)
            {
                Fight.resultsRecap = params;
            }
            else
            {
                params = Fight.resultsRecap;
            };
            this.uiApi.addComponentHook(this.tx_challenge1, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_challenge1, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_challenge2, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_challenge2, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_close_fightResultWindow, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.tx_challenge_result1, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_challenge_result1, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_challenge_result2, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_challenge_result2, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ctr_rewardRate, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_rewardRate, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.gd_drop, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.gd_drop, ComponentHookList.ON_ITEM_RIGHT_CLICK);
            this.uiApi.addComponentHook(this.gd_drop, ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addComponentHook(this.gd_drop, ComponentHookList.ON_ITEM_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_share, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_share, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_idols, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_idols, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_idols, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_minimize, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_minimize, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            if (params.isSpectator)
            {
                this.tx_minimizeBg.visible = false;
                this.btn_minimize.visible = false;
                this.tx_result.visible = false;
                this.lbl_result.visible = false;
            };
            if (params.budget != null)
            {
                this._breachMode = true;
                this.tx_kamaItemSeparator.visible = false;
                this.tx_breachItemSeparator.visible = true;
                this.lbl_objects.x = this.uiApi.me().getConstant("lbl_objects_x_in_breach");
                this._objectsGridCoord[0] = this.uiApi.me().getConstant("gd_objects_x_in_breach");
                this.lbl_kamas.width = 220;
                this.lbl_kamas.text = this.uiApi.getText("ui.fightend.teamDreamPoints");
            }
            else
            {
                this.lbl_objects.x = this.uiApi.me().getConstant("lbl_objects_x_standart");
                this._objectsGridCoord[0] = this.uiApi.me().getConstant("gd_objects_x_standart");
            };
            this._objectsGridCoord[1] = this.uiApi.me().getConstant("gd_objects_y");
            this.lbl_objects.y = this.uiApi.me().getConstant("lbl_objects_y");
            this.ctr_drop.visible = false;
            if (this._breachMode)
            {
                this._budget = params.budget;
            };
            var duration:int = params.duration;
            this._rewardRate = params.rewardRate;
            var results:Object = params.results;
            this._challenges = params.challenges;
            this._winnersName = params.winnersName;
            this._losersName = params.losersName;
            this._headsUri = this.uiApi.me().getConstant("heads");
            this._pictoUris.push(this.uiApi.me().getConstant("winner_uri"));
            this._pictoUris.push(this.uiApi.me().getConstant("loser_uri"));
            this._pictoUris.push(this.uiApi.me().getConstant("pony_uri"));
            this._bgLevelUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgLevel_uri"));
            this._bgPrestigeUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgPrestige_uri"));
            this._widthName = int(this.uiApi.me().getConstant("name_width"));
            this._widthXp = this.uiApi.me().getConstant("lbl_xp_full_width");
            this._widthXpWithHonour = this.uiApi.me().getConstant("lbl_xp_limited_width");
            this._helpColor = this.sysApi.getConfigEntry("colors.text.help").toString().replace("0x", "#");
            var turns:* = ((" (" + this.uiApi.getText("ui.fight.turnCount", params.turns)) + ")");
            if (params.turns > 1)
            {
                turns = this.uiApi.processText(turns, "m", false);
            }
            else
            {
                turns = this.uiApi.processText(turns, "m", true);
            };
            this.lbl_time.text = (this.timeApi.getShortDuration(duration, true) + turns);
            if (((params.fightType == FightTypeEnum.FIGHT_TYPE_AGRESSION) || (params.fightType == FightTypeEnum.FIGHT_TYPE_PvMA)))
            {
                this._isPvpFight = true;
            };
            this.lbl_honour.visible = this._isPvpFight;
            this.tx_honor_separator.visible = this._isPvpFight;
            this.displayBonuses();
            this.displayChallenges();
            this.displayResults(results, params.playSound);
            params.playSound = false;
            this._idols = params.idols;
            var idols:Array = [];
            var numIdols:uint = this._idols.length;
            i = 0;
            while (i < numIdols)
            {
                idol = this.dataApi.getIdol(this._idols[i]);
                coeff = this.getIdolCoeff(idol);
                this._totalScore = (this._totalScore + Math.floor((idol.score * coeff)));
                this._totalExp = (this._totalExp + Math.floor((idol.experienceBonus * coeff)));
                this._totalLoot = (this._totalLoot + Math.floor((idol.dropBonus * coeff)));
                idols.push(this.dataApi.getItemWrapper(idol.itemId));
                i++;
            };
            this.gd_idols.dataProvider = idols;
            this.lbl_score.text = this._totalScore.toString();
            var level:uint = this.playerApi.getPlayedCharacterInfo().level;
            if (level > ProtocolConstantsEnum.MAX_LEVEL)
            {
                level = ProtocolConstantsEnum.MAX_LEVEL;
            };
            var wisdom:int = ((((this.playerApi.characteristics().wisdom.base + this.playerApi.characteristics().wisdom.additionnal) + this.playerApi.characteristics().wisdom.objectsAndMountBonus) + this.playerApi.characteristics().wisdom.alignGiftBonus) + this.playerApi.characteristics().wisdom.contextModif);
            var pp:int = ((((this.playerApi.characteristics().prospecting.base + this.playerApi.characteristics().prospecting.additionnal) + this.playerApi.characteristics().prospecting.objectsAndMountBonus) + this.playerApi.characteristics().prospecting.alignGiftBonus) + this.playerApi.characteristics().prospecting.contextModif);
            this._totalExp = ((((2.5 * level) + 100) * this._totalExp) / (wisdom + 100));
            this._totalLoot = ((((0.5 * level) + 100) * this._totalLoot) / (pp + 100));
            if (this.sysApi.getPlayerManager().subscriptionEndDate == 0)
            {
                this.btn_share.softDisabled = true;
            }
            else
            {
                if (this.uiApi.getUi("sharePopup"))
                {
                    this.uiApi.unloadUi("sharePopup");
                };
            };
        }

        public function unload():void
        {
            if (this.uiApi.getUi("sharePopup"))
            {
                this.uiApi.unloadUi("sharePopup");
            };
            this.uiApi.hideTooltip();
            this.sysApi.dispatchHook(FightResultClosed);
        }

        private function getPlayerExperienceBonusPercent():uint
        {
            return (Math.floor((this.playerApi.getExperienceBonusPercent() / 100)) + 1);
        }

        public function updateLine(data:*, compRef:*, selected:Boolean, line:uint):void
        {
            var name:String;
            var server:Object;
            var visibleObjectsCount:int;
            var monster:Monster;
            var percentXp:int;
            var xpMultiplicator:int;
            var heroicEpicXpMultiplicator:int;
            var objects:Array;
            var o:Object;
            var objectsList:String;
            var i:int;
            switch (this.getLineType(data, line))
            {
                case this.CTR_TYPE_TITLE:
                    compRef.tx_titleIcon.uri = this.uiApi.createUri(this._pictoUris[data.icon]);
                    compRef.lbl_titleName.text = data.name;
                    compRef.lbl_breachBudget.text = data.budget;
                    if (this._breachMode)
                    {
                        compRef.lbl_breachBudget.visible = true;
                        if (data.budget != "")
                        {
                            compRef.tx_breachBudget.visible = true;
                        };
                    };
                    break;
                case this.CTR_TYPE_FIGHTER:
                    if (!this._hookGridObjects[compRef.gd_objects.name])
                    {
                        this.uiApi.addComponentHook(compRef.gd_objects, ComponentHookList.ON_ITEM_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.gd_objects, ComponentHookList.ON_ITEM_ROLL_OUT);
                        this.uiApi.addComponentHook(compRef.gd_objects, ComponentHookList.ON_SELECT_ITEM);
                        this.uiApi.addComponentHook(compRef.gd_objects, ComponentHookList.ON_ITEM_RIGHT_CLICK);
                    };
                    this._hookGridObjects[compRef.gd_objects.name] = data;
                    if (!this._hookGridObjects[compRef.btn_seeMore.name])
                    {
                        this.uiApi.addComponentHook(compRef.btn_seeMore, ComponentHookList.ON_RELEASE);
                        this.uiApi.addComponentHook(compRef.btn_seeMore, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.btn_seeMore, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._hookGridObjects[compRef.btn_seeMore.name] = data;
                    if (!this._hookGridObjects[compRef.pb_xpGauge.name])
                    {
                        this.uiApi.addComponentHook(compRef.pb_xpGauge, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.pb_xpGauge, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._hookGridObjects[compRef.pb_xpGauge.name] = data;
                    if (!this._hookGridObjects[compRef.tx_xpBonusPicto.name])
                    {
                        this.uiApi.addComponentHook(compRef.tx_xpBonusPicto, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.tx_xpBonusPicto, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._hookGridObjects[compRef.tx_xpBonusPicto.name] = data;
                    if (!this._hookGridObjects[compRef.lbl_xpPerso.name])
                    {
                        this.uiApi.addComponentHook(compRef.lbl_xpPerso, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.lbl_xpPerso, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._hookGridObjects[compRef.lbl_xpPerso.name] = data;
                    if (!this._hookGridObjects[compRef.lbl_honour.name])
                    {
                        this.uiApi.addComponentHook(compRef.lbl_honour, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.lbl_honour, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._hookGridObjects[compRef.lbl_honour.name] = data;
                    if (!this._hookGridObjects[compRef.tx_arrow.name])
                    {
                        this.uiApi.addComponentHook(compRef.tx_arrow, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.tx_arrow, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._hookGridObjects[compRef.tx_arrow.name] = data;
                    compRef.gd_objects.x = this._objectsGridCoord[0];
                    compRef.gd_objects.y = this._objectsGridCoord[1];
                    if (this._breachMode)
                    {
                        compRef.lbl_kamas.visible = false;
                    };
                    compRef.tx_deathPicto.visible = (!(data.alive));
                    if (((data.id == this.playerApi.id()) || (data.fightInitiator)))
                    {
                        compRef.lbl_name.width = ((this._widthName - compRef.tx_arrow.width) - 3);
                        compRef.tx_arrow.visible = true;
                        if (data.fightInitiator)
                        {
                            compRef.tx_arrow.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "tx_pictoattaquant.png"));
                        }
                        else
                        {
                            compRef.tx_arrow.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "icon_man.png"));
                        };
                    }
                    else
                    {
                        compRef.tx_arrow.visible = false;
                    };
                    name = data.name;
                    if (data.type == 0)
                    {
                        name = (((((("{player," + data.name) + ",") + data.id) + "::") + data.name) + "}");
                    }
                    else
                    {
                        if (data.type == 1)
                        {
                            monster = this.dataApi.getMonsterFromId(data.id);
                            if (monster)
                            {
                                name = (((("{bestiary," + data.id) + "::") + data.name) + "}");
                            };
                        };
                    };
                    compRef.lbl_name.text = name;
                    if (((data.type == 0) && (data.level > ProtocolConstantsEnum.MAX_LEVEL)))
                    {
                        compRef.lbl_level.text = ("" + (data.level - ProtocolConstantsEnum.MAX_LEVEL));
                        compRef.tx_level.uri = this._bgPrestigeUri;
                        this.uiApi.addComponentHook(compRef.tx_level, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.tx_level, ComponentHookList.ON_ROLL_OUT);
                        compRef.lbl_level.cssClass = "darkboldcenter";
                    }
                    else
                    {
                        compRef.lbl_level.text = data.level;
                        compRef.tx_level.uri = this._bgLevelUri;
                        compRef.lbl_level.cssClass = "boldcenter";
                    };
                    if (data.breed > 0)
                    {
                        compRef.tx_head.uri = this.uiApi.createUri((((((this._headsUri + "") + data.breed) + "") + int(data.gender)) + ".png"));
                        compRef.tx_head.visible = true;
                        compRef.tx_fighterHeadSlot.visible = true;
                    }
                    else
                    {
                        compRef.tx_head.visible = false;
                        compRef.tx_fighterHeadSlot.visible = false;
                    };
                    if (data.showExperience)
                    {
                        if (data.level > ProtocolConstantsEnum.MAX_LEVEL)
                        {
                            compRef.pb_xpGauge.barColor = this.sysApi.getConfigEntry("colors.progressbar.gold");
                        }
                        else
                        {
                            compRef.pb_xpGauge.barColor = this.sysApi.getConfigEntry("colors.progressbar.xp");
                        };
                        compRef.pb_xpGauge.visible = true;
                        percentXp = int((((data.experience - data.experienceLevelFloor) * 100) / (data.experienceNextLevelFloor - data.experienceLevelFloor)));
                        compRef.pb_xpGauge.value = (percentXp / 100);
                    }
                    else
                    {
                        compRef.pb_xpGauge.visible = false;
                    };
                    if (this._isPvpFight)
                    {
                        compRef.lbl_xpPerso.width = this._widthXpWithHonour;
                    }
                    else
                    {
                        compRef.lbl_xpPerso.width = this._widthXp;
                    };
                    compRef.lbl_xpPerso.finalize();
                    if (data.honorDelta == -1)
                    {
                        compRef.lbl_honour.visible = false;
                    }
                    else
                    {
                        compRef.lbl_honour.visible = true;
                        compRef.lbl_honour.text = data.honorDelta;
                    };
                    server = this.sysApi.getCurrentServer();
                    if (((data.honorDelta == -1) && (data.rerollXpMultiplicator > 1)))
                    {
                        xpMultiplicator = (data.rerollXpMultiplicator - 1);
                        if (xpMultiplicator > 3)
                        {
                            xpMultiplicator = 4;
                        };
                        compRef.tx_xpBonusPicto.visible = true;
                        compRef.tx_xpBonusPicto.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("texture") + "XPBonus") + xpMultiplicator.toString()) + ".png"));
                    }
                    else
                    {
                        if (((data.type == 0) && ((server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_HARDCORE) || (server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_EPIC))))
                        {
                            heroicEpicXpMultiplicator = this.getPlayerExperienceBonusPercent();
                            if (((heroicEpicXpMultiplicator > 1) && (heroicEpicXpMultiplicator < 7)))
                            {
                                compRef.tx_xpBonusPicto.visible = true;
                                compRef.tx_xpBonusPicto.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("texture") + "XPBonus") + (heroicEpicXpMultiplicator - 1).toString()) + ".png"));
                            }
                            else
                            {
                                compRef.tx_xpBonusPicto.visible = false;
                            };
                        }
                        else
                        {
                            compRef.tx_xpBonusPicto.visible = false;
                        };
                    };
                    if (data.showExperienceFightDelta)
                    {
                        compRef.lbl_xpPerso.text = this.utilApi.kamasToString(data.experienceFightDelta, "");
                    }
                    else
                    {
                        compRef.lbl_xpPerso.text = "";
                    };
                    if (data.rewards.kamas > 0)
                    {
                        compRef.lbl_kamas.text = this.utilApi.kamasToString(data.rewards.kamas, "");
                    }
                    else
                    {
                        if (data.type != 0)
                        {
                            compRef.lbl_kamas.text = "";
                        }
                        else
                        {
                            compRef.lbl_kamas.text = "0";
                        };
                    };
                    if (data.rewards.objects.length > 0)
                    {
                        objects = [];
                        for each (o in data.rewards.objects)
                        {
                            objects.push(o);
                        };
                        compRef.gd_objects.dataProvider = objects;
                    }
                    else
                    {
                        compRef.gd_objects.dataProvider = [];
                    };
                    visibleObjectsCount = compRef.gd_objects.slotByRow;
                    if (data.rewards.objects.length > visibleObjectsCount)
                    {
                        compRef.btn_seeMore.visible = true;
                        objectsList = "";
                        i = visibleObjectsCount;
                        while (i < data.rewards.objects.length)
                        {
                            objectsList = (objectsList + (((data.rewards.objects[i].quantity + " x ") + data.rewards.objects[i].name) + " \n"));
                            i++;
                        };
                        this._objectsLists[data.id] = objectsList;
                    }
                    else
                    {
                        compRef.btn_seeMore.visible = false;
                    };
                    break;
            };
        }

        public function getLineType(data:*, line:uint):String
        {
            if (!data)
            {
                return ("");
            };
            if (((data) && (data.hasOwnProperty("level"))))
            {
                return (this.CTR_TYPE_FIGHTER);
            };
            return (this.CTR_TYPE_TITLE);
        }

        public function getDataLength(data:*, selected:Boolean):*
        {
            if (selected)
            {
            };
            return (2 + ((selected) ? data.subcats.length : 0));
        }

        public function displayBonuses():void
        {
            var colorTransform:ColorTransform = new ColorTransform();
            this.lbl_rewardRate.text = (this._rewardRate.toString() + "%");
            if (this._rewardRate < 100)
            {
                this.ctr_rewardRate.visible = true;
                colorTransform.color = this.uiApi.me().getConstant("malus_color");
                this.tx_rewardRate.colorTransform = colorTransform;
            }
            else
            {
                this.ctr_rewardRate.visible = true;
                colorTransform.color = this.uiApi.me().getConstant("bonus_color");
                this.tx_rewardRate.colorTransform = colorTransform;
                this.lbl_rewardRate.text = ("+" + this.lbl_rewardRate.text);
            };
        }

        public function displayChallenge(ctr_challenge:Object, challenge:Object):void
        {
            ctr_challenge.tx_challenge.visible = true;
            ctr_challenge.tx_challenge.uri = challenge.iconUri;
            switch (challenge.result)
            {
                case RESULT_COMPLETE:
                    ctr_challenge.tx_challenge_result.visible = true;
                    ctr_challenge.tx_challenge_result.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "hud/filter_iconChallenge_check.png"));
                    break;
                case RESULT_FAILED:
                    ctr_challenge.tx_challenge_result.visible = true;
                    ctr_challenge.tx_challenge_result.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "hud/filter_iconChallenge_cross.png"));
                    break;
            };
        }

        public function displayChallenges():void
        {
            var ctr_challenges:Array = [{
                "tx_challenge":this.tx_challenge1,
                "tx_challenge_result":this.tx_challenge_result1
            }, {
                "tx_challenge":this.tx_challenge2,
                "tx_challenge_result":this.tx_challenge_result2
            }];
            var i:int;
            while (i < ctr_challenges.length)
            {
                ctr_challenges[i].tx_challenge.visible = false;
                ctr_challenges[i].tx_challenge_result.visible = false;
                i++;
            };
            var maxChallenge:uint = ((this._challenges.length <= 2) ? this._challenges.length : 2);
            i = 0;
            while (i < maxChallenge)
            {
                this.displayChallenge(ctr_challenges[i], this._challenges[i]);
                i++;
            };
        }

        public function displayResults(results:Object, playSound:Boolean):void
        {
            var i:*;
            var winnerBudget:String;
            var LoserBudget:String;
            var w:Object;
            var losersStr:String;
            var l:Object;
            var playerTeamLost:Boolean;
            var budgetString:String;
            var p:Object;
            var gridHeight:int;
            var interfaceHeight:int;
            var dataprovider:Array = [];
            var winners:Array = [];
            var losers:Array = [];
            var pony:Array = [];
            for (i in results)
            {
                results[i].rewards.objects.sort(this.compareItemsAveragePrices);
                if (results[i].outcome == FightOutcomeEnum.RESULT_VICTORY)
                {
                    winners.push(results[i]);
                    if (results[i].id == this.playerApi.id())
                    {
                        this.lbl_result.text = this.uiApi.getText("ui.fightend.victory");
                        this.tx_result.uri = this.uiApi.createUri((this.uiApi.me().getConstant("illus_uri") + "tx_flag_victory.png"));
                        if (playSound)
                        {
                            this.soundApi.playSound(SoundTypeEnum.FIGHT_WIN);
                        };
                    };
                }
                else
                {
                    if (results[i].outcome == FightOutcomeEnum.RESULT_LOST)
                    {
                        losers.push(results[i]);
                        if (results[i].id == this.playerApi.id())
                        {
                            this.lbl_result.text = this.uiApi.getText("ui.fightend.loss");
                            this.tx_result.uri = this.uiApi.createUri((this.uiApi.me().getConstant("illus_uri") + "tx_flag_defeat.png"));
                            if (playSound)
                            {
                                this.soundApi.playSound(SoundTypeEnum.FIGHT_LOSE);
                            };
                        };
                    }
                    else
                    {
                        if (results[i].outcome == FightOutcomeEnum.RESULT_TAX)
                        {
                            pony.push(results[i]);
                        };
                    };
                };
            };
            winnerBudget = "";
            LoserBudget = "";
            if (this._breachMode)
            {
                playerTeamLost = false;
                if (this._budget < 0)
                {
                    playerTeamLost = true;
                    this._budget = Math.abs(this._budget);
                };
                budgetString = this.utilApi.kamasToString(this._budget, "");
                if (!playerTeamLost)
                {
                    winnerBudget = budgetString;
                }
                else
                {
                    LoserBudget = ("-" + budgetString);
                };
            };
            var winnersStr:String = ((this._winnersName != "") ? this._winnersName : this.uiApi.getText("ui.fightend.winners"));
            dataprovider.push({
                "name":winnersStr,
                "icon":0,
                "budget":winnerBudget
            });
            for each (w in winners)
            {
                dataprovider.push(w);
            };
            losersStr = ((this._losersName != "") ? this._losersName : this.uiApi.getText("ui.fightend.losers"));
            dataprovider.push({
                "name":losersStr,
                "icon":1,
                "budget":LoserBudget
            });
            for each (l in losers)
            {
                dataprovider.push(l);
            };
            if (pony.length > 0)
            {
                dataprovider.push({
                    "name":this.uiApi.getText("ui.common.taxCollector"),
                    "icon":2
                });
                for each (p in pony)
                {
                    dataprovider.push(p);
                };
            };
            if (dataprovider.length < MAXIMAL_SIZE)
            {
                gridHeight = (dataprovider.length * this.gd_fighters.slotHeight);
                interfaceHeight = ((this.ctr_fightResult.height + 164) + gridHeight);
                this.fightResultWindow.height = interfaceHeight;
                this.mainCtr.height = interfaceHeight;
                this.ctr_gridResult.height = ((gridHeight + this.tx_gridHeader.height) + 24);
                this.gd_fighters.height = gridHeight;
                this.tx_gdFighterBg.height = gridHeight;
                this.uiApi.me().render();
            };
            this.gd_fighters.dataProvider = dataprovider;
        }

        private function compareItemsAveragePrices(pItemA:Object, pItemB:Object):int
        {
            var itemAPrice:Number = (this.averagePricesApi.getItemAveragePrice(pItemA.objectGID) * pItemA.quantity);
            var itemBPrice:Number = (this.averagePricesApi.getItemAveragePrice(pItemB.objectGID) * pItemB.quantity);
            return ((itemAPrice < itemBPrice) ? 1 : ((itemAPrice > itemBPrice) ? -1 : 0));
        }

        private function getIdolCoeff(pIdol:Idol):Number
        {
            var i:int;
            var j:int;
            var coeff:Number = 1;
            var synergiesIds:Object = pIdol.synergyIdolsIds;
            var synergiesCoeffs:Object = pIdol.synergyIdolsCoeff;
            var numSynergies:uint = synergiesIds.length;
            var numActiveIdols:uint = this._idols.length;
            i = 0;
            while (i < numActiveIdols)
            {
                j = 0;
                while (j < numSynergies)
                {
                    if (synergiesIds[j] == this._idols[i])
                    {
                        coeff = (coeff * synergiesCoeffs[j]);
                    };
                    j++;
                };
                i++;
            };
            return (coeff);
        }

        private function onUrlReceived(url:String=null):void
        {
            if (this.btn_share)
            {
                this.btn_share.disabled = false;
                this.btn_share.visible = true;
                if (url)
                {
                    this.uiApi.loadUi("Ankama_Web::sharePopup", "sharePopup", {"url":url}, StrataEnum.STRATA_HIGH, null, true);
                };
            };
        }

        public function onRelease(target:Object):void
        {
            var sharePopup:*;
            var screenshotAsBase64:String;
            var data:Object;
            switch (target)
            {
                case this.btn_close_fightResultWindow:
                case this.btn_close2:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_minimize:
                    this.sysApi.setData("useFightResultSimple", true, DataStoreEnum.BIND_ACCOUNT);
                    this.uiApi.loadUi("fightResultSimple", "fightResultSimple");
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_closeDrop:
                    this.ctr_drop.visible = false;
                    break;
                case this.btn_share:
                    sharePopup = this.uiApi.getUi("sharePopup");
                    if (!sharePopup)
                    {
                        this.uiApi.hideTooltip();
                        screenshotAsBase64 = this.captureApi.getScreenAsJpgCompressedBase64();
                        if (screenshotAsBase64)
                        {
                            this.sysApi.getUrltoShareContent({
                                "title":this.uiApi.getText("ui.social.share.staticPage.defaultTitle", this.playerApi.getPlayedCharacterInfo().name),
                                "description":this.uiApi.getText("ui.social.share.staticPage.defaultDescription"),
                                "image":screenshotAsBase64
                            }, this.onUrlReceived, ScreenshotTypeEnum.ENDFIGHT);
                            this.btn_share.disabled = true;
                            this.btn_share.visible = false;
                        }
                        else
                        {
                            this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.social.share.popup.error"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, this.timeApi.getTimestamp());
                            this.sysApi.log(16, "Failed to get screenshot of the game view as base64!");
                        };
                    }
                    else
                    {
                        sharePopup.uiClass.toggleVisibility();
                    };
                    break;
                case this.btn_idols:
                    if (!this.uiApi.getUi("idolsTab"))
                    {
                        this.sysApi.sendAction(new OpenIdols());
                    }
                    else
                    {
                        this.sysApi.sendAction(new OpenBook("idolsTab"));
                    };
                    break;
                default:
                    if (target.name.indexOf("btn_seeMore") != -1)
                    {
                        data = this._hookGridObjects[target.name];
                        if (((this.ctr_drop.visible) && (this.lbl_drop.text == data.name)))
                        {
                            this.ctr_drop.visible = false;
                        }
                        else
                        {
                            this.ctr_drop.visible = true;
                            this.gd_drop.dataProvider = data.rewards.objects;
                            this.lbl_drop.text = data.name;
                        };
                    };
            };
        }

        public function onRollOver(target:Object):void
        {
            var data:Object;
            var percentXp:int;
            var bonusXp:int;
            var text:String = "";
            var pos:Object = {
                "point":7,
                "relativePoint":7,
                "offset":0
            };
            var server:Object = this.sysApi.getCurrentServer();
            switch (target)
            {
                case this.tx_challenge_result1:
                    this.uiApi.showTooltip(this._challenges[0], target, false, "standard", 2, 8, 0, null, null, null);
                    break;
                case this.tx_challenge_result2:
                    this.uiApi.showTooltip(this._challenges[1], target, false, "standard", 2, 8, 0, null, null, null);
                    break;
                case this.btn_minimize:
                    text = this.uiApi.getText("ui.common.minimize");
                    break;
                case this.ctr_rewardRate:
                    if (this._rewardRate < 0)
                    {
                        text = this.uiApi.getText("ui.fightend.malus");
                    }
                    else
                    {
                        text = this.uiApi.getText("ui.fightend.bonus");
                    };
                    break;
                case this.lbl_score:
                    text = (((this.gd_idols.dataProvider) && (this.gd_idols.dataProvider.length > 0)) ? this.uiApi.getText("ui.idol.fightScore", this._totalScore, (this._totalLoot + "%"), (this._totalExp + "%")) : this.uiApi.getText("ui.idol.noIdols"));
                    break;
                case this.btn_share:
                    if (!this.btn_share.softDisabled)
                    {
                        text = this.uiApi.getText("ui.common.socialNetworkShare");
                    }
                    else
                    {
                        text = this.uiApi.getText("ui.payzone.limit");
                    };
                    break;
                default:
                    if (target.name.indexOf("btn_seeMore") != -1)
                    {
                        text = this._objectsLists[this._hookGridObjects[target.name].id];
                        text = (text + (((("<br/><font color='" + this._helpColor) + "'><i>") + this.uiApi.getText("ui.tooltip.loot.more")) + "</i></font>"));
                    }
                    else
                    {
                        if (target.name.indexOf("lbl_honour") != -1)
                        {
                            data = this._hookGridObjects[target.name];
                            if (data)
                            {
                                text = (((((((this.uiApi.getText("ui.pvp.rank") + this.uiApi.getText("ui.common.colon")) + data.grade) + "\n") + this.uiApi.getText("ui.pvp.honourPoints")) + this.uiApi.getText("ui.common.colon")) + ((data.honorDelta > 0) ? "+" : "")) + data.honorDelta);
                            };
                        }
                        else
                        {
                            if (target.name.indexOf("lbl_xpPerso") != -1)
                            {
                                data = this._hookGridObjects[target.name];
                                if (data)
                                {
                                    if (data.showExperienceFightDelta)
                                    {
                                        text = ((this.uiApi.getText("ui.fightend.xp") + this.uiApi.getText("ui.common.colon")) + this.utilApi.kamasToString(data.experienceFightDelta, ""));
                                        if (data.isIncarnationExperience)
                                        {
                                            text = (text + ((" (" + this.uiApi.getText("ui.common.incarnation")) + ")"));
                                        };
                                    };
                                    if (data.showExperienceForGuild)
                                    {
                                        text = (text + ((("\n" + this.uiApi.getText("ui.common.guild")) + this.uiApi.getText("ui.common.colon")) + this.utilApi.kamasToString(data.experienceForGuild, "")));
                                    };
                                    if (data.showExperienceForRide)
                                    {
                                        text = (text + ((("\n" + this.uiApi.getText("ui.common.ride")) + this.uiApi.getText("ui.common.colon")) + this.utilApi.kamasToString(data.experienceForRide, "")));
                                    };
                                };
                            }
                            else
                            {
                                if (target.name.indexOf("pb_xpGauge") != -1)
                                {
                                    data = this._hookGridObjects[target.name];
                                    if (data)
                                    {
                                        percentXp = int(Math.floor((((data.experience - data.experienceLevelFloor) * 100) / (data.experienceNextLevelFloor - data.experienceLevelFloor))));
                                        text = (((((("" + percentXp) + "% (") + this.utilApi.kamasToString((data.experience - data.experienceLevelFloor), "")) + " / ") + this.utilApi.kamasToString((data.experienceNextLevelFloor - data.experienceLevelFloor), "")) + ")");
                                    };
                                }
                                else
                                {
                                    if (target.name.indexOf("tx_xpBonusPicto") != -1)
                                    {
                                        data = this._hookGridObjects[target.name];
                                        if (data)
                                        {
                                            bonusXp = 0;
                                            if (((server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_HARDCORE) || (server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_EPIC)))
                                            {
                                                bonusXp = this.getPlayerExperienceBonusPercent();
                                                if (bonusXp == 6)
                                                {
                                                    text = (text + this.uiApi.getText("ui.information.xpHardcoreEpicDeathBonus"));
                                                }
                                                else
                                                {
                                                    text = (text + this.uiApi.getText("ui.information.xpHardcoreEpicBonus"));
                                                };
                                            }
                                            else
                                            {
                                                bonusXp = data.rerollXpMultiplicator;
                                                if (bonusXp > 1)
                                                {
                                                    text = ((((this.uiApi.getText("ui.common.experiencePoint") + " x ") + bonusXp) + "\n\n") + this.uiApi.getText("ui.information.xpFamilyBonus"));
                                                };
                                            };
                                        };
                                    }
                                    else
                                    {
                                        if (target.name.indexOf("tx_arrow") != -1)
                                        {
                                            data = this._hookGridObjects[target.name];
                                            if (data)
                                            {
                                                if (data.fightInitiator)
                                                {
                                                    text = this.uiApi.getText("ui.fightend.fightInitiator");
                                                };
                                            };
                                        }
                                        else
                                        {
                                            if (target.name.indexOf("tx_level") != -1)
                                            {
                                                text = this.uiApi.getText("ui.tooltip.OmegaLevel");
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
            };
            if (text != "")
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, pos.offset, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var item:Object;
            if (((!(target.name.indexOf("gd_objects") == -1)) || (target == this.gd_drop)))
            {
                if (((!(this.sysApi.getOption("displayTooltips", "dofus"))) && ((selectMethod == GridItemSelectMethodEnum.CLICK) || (selectMethod == GridItemSelectMethodEnum.MANUAL))))
                {
                    item = target.selectedItem;
                    this.sysApi.dispatchHook(ShowObjectLinked, item);
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var idol:Idol;
            var itemTooltipSettings:ItemTooltipSettings;
            var tooltipData:*;
            if (item.data)
            {
                if (item.data.typeId == 178)
                {
                    idol = this.dataApi.getIdolByItemId(item.data.objectGID);
                    this.uiApi.showTooltip(idol.spellPair, item.container, false, "standard", LocationEnum.POINT_BOTTOM, LocationEnum.POINT_BOTTOM, 0, null, null, {
                        "smallSpell":true,
                        "header":false,
                        "footer":false,
                        "effects":false,
                        "currentCC_EC":false,
                        "baseCC_EC":false,
                        "spellTab":false
                    });
                }
                else
                {
                    itemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings);
                    if (!itemTooltipSettings)
                    {
                        itemTooltipSettings = this.tooltipApi.createItemSettings();
                        this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, DataStoreEnum.BIND_ACCOUNT);
                    };
                    tooltipData = item.data;
                    if ((((((!(itemTooltipSettings.header)) && (!(itemTooltipSettings.conditions))) && (!(itemTooltipSettings.effects))) && (!(itemTooltipSettings.description))) && (!(itemTooltipSettings.averagePrice))))
                    {
                        tooltipData = item.data.name;
                    };
                    this.uiApi.showTooltip(item.data, item.container, false, "standard", 7, 7, 0, "itemName", null, {
                        "header":itemTooltipSettings.header,
                        "conditions":itemTooltipSettings.conditions,
                        "description":itemTooltipSettings.description,
                        "averagePrice":itemTooltipSettings.averagePrice,
                        "showEffects":itemTooltipSettings.effects
                    }, "ItemInfo");
                };
            };
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            if (item.data == null)
            {
                return;
            };
            var data:Object = item.data;
            var contextMenu:Object = this.menuApi.create(data);
            var itemTooltipSettings:ItemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings);
            if (!itemTooltipSettings)
            {
                itemTooltipSettings = this.tooltipApi.createItemSettings();
                this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, DataStoreEnum.BIND_ACCOUNT);
            };
            this.modContextMenu.createContextMenu(contextMenu);
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemDetails(item:Object, target:Object):void
        {
            this.uiApi.showTooltip(item, target, false, "Hyperlink", 0, 2, 3, null, null, null, null, true);
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                case "closeUi":
                    if (this.ctr_drop.visible)
                    {
                        this.ctr_drop.visible = false;
                    }
                    else
                    {
                        this.uiApi.unloadUi(this.uiApi.me().name);
                    };
                    return (true);
            };
            return (false);
        }


    }
} Ankama_Fight.ui

