package Ankama_Grimoire.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.AveragePricesApi;
    import com.ankamagames.dofus.uiApi.PartyApi;
    import com.ankamagames.dofus.uiApi.RoleplayApi;
    import com.ankamagames.dofus.uiApi.MapApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.BreachApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.LuaApi;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import __AS3__.vec.Vector;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
    import d2hooks.OpenBook;
    import d2hooks.KeyUp;
    import d2enums.ComponentHookList;
    import d2hooks.FocusChange;
    import flash.events.TimerEvent;
    import Ankama_Grimoire.Grimoire;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.datacenter.monsters.MonsterGrade;
    import com.ankamagames.dofus.datacenter.monsters.MonsterDrop;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.datacenter.items.Item;
    import com.ankamagames.dofus.datacenter.idols.Idol;
    import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
    import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
    import com.ankamagames.dofus.datacenter.items.criterion.ItemCriterion;
    import com.ankamagames.dofus.datacenter.monsters.MonsterDropCoefficient;
    import com.ankamagames.dofus.datacenter.items.criterion.ServerSeasonTemporisCriterion;
    import flash.geom.Point;
    import com.ankamagames.dofus.datacenter.monsters.MonsterMiniBoss;
    import flash.ui.Keyboard;
    import d2hooks.MouseShiftClick;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import d2hooks.OpenEncyclopedia;
    import Ankama_Grimoire.enum.EnumTab;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import flash.utils.clearTimeout;
    import com.ankamagames.dofus.datacenter.monsters.MonsterRace;
    import __AS3__.vec.*;
    import d2hooks.*;

    public class BestiaryTab 
    {

        private static var CTR_CAT_TYPE_CAT:String = "ctr_cat";
        private static var CTR_CAT_TYPE_SUBCAT:String = "ctr_subCat";
        private static var CTR_MONSTER_BASE:String = "ctr_monster";
        private static var CTR_MONSTER_AREAS:String = "ctr_subareas";
        private static var CTR_MONSTER_DETAILS:String = "ctr_details";
        private static var CTR_MONSTER_DROPS:String = "ctr_drops";
        private static var CAT_TYPE_AREA:int = 0;
        private static var CAT_TYPE_RACE:int = 1;
        private static var NB_DROP_PER_LINE:int = 12;
        private static var AREA_LINE_HEIGHT:int;

        private const MINIMAL_DROP_PERCENTAGE_BEFORE_CALCULATIONS:Number = 0.001;

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="AveragePricesApi")]
        public var averagePricesApi:AveragePricesApi;
        [Api(name="PartyApi")]
        public var partyApi:PartyApi;
        [Api(name="RoleplayApi")]
        public var roleplayApi:RoleplayApi;
        [Api(name="MapApi")]
        public var mapApi:MapApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="BreachApi")]
        public var breachApi:BreachApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="LuaApi")]
        public var luaApi:LuaApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Module(name="Ankama_Cartography")]
        public var modCartography:Object;
        private var _currentCategoryType:int;
        private var _openCatIndex:int;
        private var _currentSelectedCatId:int;
        private var _selectedMonsterId:int;
        private var _selectedAndOpenedMonsterId:int;
        private var _uriRareDrop:String;
        private var _uriOkDrop:String;
        private var _uriSpecialSlot:String;
        private var _uriEmptySlot:String;
        private var _uriStatPicto:String;
        private var _uriMonsterSprite:String;
        private var _lastRaceSelected:Object;
        private var _lastAreaSelected:Object;
        private var _categoriesRace:Array = new Array();
        private var _categoriesArea:Array = new Array();
        private var _monstersListToDisplay:Array = new Array();
        private var _monstersDataById:Dictionary = new Dictionary(true);
        private var _monsterEquipmentDrops:Array;
        private var _dropTemporisItemResult:Object;
        private var _lockSearchTimer:Timer;
        private var _previousSearchCriteria:String;
        private var _searchCriteria:String;
        private var _forceOpenMonster:Boolean;
        private var _currentScrollValue:int;
        private var _mapPopup:String;
        private var _ctrBtnMonsterLocation:Dictionary = new Dictionary(true);
        private var _ctrBtnMonster:Dictionary = new Dictionary(true);
        private var _ctrSlotDrop:Dictionary = new Dictionary(true);
        private var _ctrTxLink:Dictionary = new Dictionary(true);
        private var _lblValueStat:Dictionary = new Dictionary(true);
        private var _progressPopupName:String;
        private var _searchSettimoutId:uint;
        private var _searchTextByCriteriaList:Dictionary = new Dictionary(true);
        private var _searchResultByCriteriaList:Dictionary = new Dictionary(true);
        private var _searchOnName:Boolean;
        private var _searchOnDrop:Boolean;
        private var _currentIdols:Vector.<int> = new Vector.<int>();
        private var _btn_searchFilter_flag:Boolean = false;
        private var _currentTabName:String;
        private var _breachMonsters:Vector.<uint> = new Vector.<uint>();
        private var _selectedMonsterIsScaled:Boolean = false;
        public var gd_categories:Grid;
        public var gd_monsters:Grid;
        public var inp_search:Input;
        public var tx_inputBg_search:TextureBitmap;
        public var btn_resetSearch:ButtonContainer;
        public var btn_searchFilter:ButtonContainer;
        public var btn_races:ButtonContainer;
        public var btn_subareas:ButtonContainer;
        public var btn_displayCriteriaDrop:ButtonContainer;
        public var lbl_noMonster:Label;
        private var _inc_monsterRender:int;
        public var btn_close:ButtonContainer;
        public var btn_help:ButtonContainer;


        public function get currentTabName():String
        {
            return (this._currentTabName);
        }

        public function set currentTabName(value:String):void
        {
            this._currentTabName = value;
        }

        public function main(oParam:Object=null):void
        {
            var customSubCat:Object;
            var mySubArea:Object;
            var area:Object;
            var subcats:Array;
            var branch:*;
            var bossInfo:MonsterInGroupLightInformations;
            var monsterInfo:MonsterInGroupLightInformations;
            var subcat:Object;
            var mId:int;
            this.sysApi.addHook(OpenBook, this.onOpenBestiary);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.uiApi.addComponentHook(this.gd_categories, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_searchFilter, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_displayCriteriaDrop, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_close, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_help, ComponentHookList.ON_RELEASE);
            this.sysApi.addHook(FocusChange, this.onFocusChange);
            this._lockSearchTimer = new Timer(500, 1);
            this._lockSearchTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            AREA_LINE_HEIGHT = int(this.uiApi.me().getConstant("area_line_height"));
            this._uriStatPicto = this.uiApi.me().getConstant("picto_uri");
            this._uriMonsterSprite = this.uiApi.me().getConstant("monsterSprite_uri");
            this._uriSpecialSlot = (this.uiApi.me().getConstant("slot") + "specialSlot.png");
            this._uriEmptySlot = (this.uiApi.me().getConstant("slot") + "emptySlot.png");
            this._uriRareDrop = (this.uiApi.me().getConstant("slot") + "rareSlot.png");
            this._uriOkDrop = (this.uiApi.me().getConstant("slot") + "averageSlot.png");
            this._searchTextByCriteriaList["_searchOnName"] = this.uiApi.getText("ui.common.name");
            this._searchTextByCriteriaList["_searchOnDrop"] = this.uiApi.getText("ui.common.loot");
            this._categoriesArea = Grimoire.getInstance().monsterAreas.concat();
            this._categoriesRace = Grimoire.getInstance().monsterRaces;
            if (this.playerApi.isInBreach())
            {
                subcats = [];
                this._breachMonsters = new Vector.<uint>();
                for each (branch in this.breachApi.getBranches())
                {
                    for each (bossInfo in branch.bosses)
                    {
                        this._breachMonsters.push(bossInfo.genericId);
                    };
                    if (branch.hasOwnProperty("monsters"))
                    {
                        for each (monsterInfo in branch.monsters)
                        {
                            if (this._breachMonsters.indexOf(monsterInfo.genericId) == -1)
                            {
                                this._breachMonsters.push(monsterInfo.genericId);
                            };
                        };
                    };
                };
                customSubCat = {
                    "id":-1,
                    "monsters":this._breachMonsters,
                    "name":(((this.uiApi.getText("ui.breach.title") + " (") + this.uiApi.getText("ui.common.inProgress")) + ")"),
                    "parentId":-1,
                    "realId":-1
                };
                this._lastAreaSelected = customSubCat;
                subcats.push(customSubCat);
                this._categoriesArea.push({
                    "id":-1,
                    "name":this.uiApi.getText("ui.breach.title"),
                    "parentId":0,
                    "realId":-1,
                    "subcats":subcats
                });
            };
            var myCurrentSubarea:SubArea = this.playerApi.currentSubArea();
            var myCurrentAreaId:int = myCurrentSubarea.areaId;
            for each (area in this._categoriesArea)
            {
                if (area.realId == myCurrentAreaId)
                {
                    for each (subcat in area.subcats)
                    {
                        if (subcat.realId == myCurrentSubarea.id)
                        {
                            mySubArea = subcat;
                        };
                    };
                };
            };
            if (!this.playerApi.isInBreach())
            {
                this._lastAreaSelected = mySubArea;
            };
            this._lastRaceSelected = this._categoriesRace[0];
            this.btn_displayCriteriaDrop.selected = Grimoire.getInstance().bestiaryDisplayCriteriaDrop;
            this._searchOnDrop = Grimoire.getInstance().bestiarySearchOnDrop;
            this._searchOnName = Grimoire.getInstance().bestiarySearchOnName;
            var openMonsterId:int;
            if (((oParam) && (oParam.monsterId)))
            {
                openMonsterId = oParam.monsterId;
            };
            if (((oParam) && (oParam.monsterIdsList)))
            {
                if (oParam.monsterSearch)
                {
                    this.inp_search.text = oParam.monsterSearch;
                    this._searchOnDrop = true;
                    this._searchOnName = false;
                };
                for each (mId in oParam.monsterIdsList)
                {
                    if (this._monstersListToDisplay.indexOf(mId) < 0)
                    {
                        this._monstersListToDisplay.push(mId);
                    };
                };
            };
            if (openMonsterId > 0)
            {
                this._selectedMonsterId = openMonsterId;
                this._forceOpenMonster = true;
                this.onOpenBestiary("bestiaryTab", {
                    "forceOpen":true,
                    "monsterId":this._selectedMonsterId
                });
            }
            else
            {
                this.uiApi.setRadioGroupSelectedItem("tabHGroup", this.btn_subareas, this.uiApi.me());
                this.btn_subareas.selected = true;
                this.gd_categories.dataProvider = this._categoriesArea;
                this.currentTabName = this.btn_subareas.name;
                if (((this.playerApi.isInBreach()) && (customSubCat)))
                {
                    this.displayCategories(customSubCat, true);
                }
                else
                {
                    this.displayCategories(mySubArea, true);
                };
            };
        }

        public function unload():void
        {
            if (this._lockSearchTimer)
            {
                this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
                this._lockSearchTimer.stop();
                this._lockSearchTimer = null;
            };
            this.uiApi.unloadUi(this._mapPopup);
        }

        public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint):void
        {
            switch (this.getCatLineType(data, line))
            {
                case CTR_CAT_TYPE_CAT:
                    if (this._openCatIndex == data.id)
                    {
                        componentsRef.tx_catplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("minusUri"));
                    }
                    else
                    {
                        componentsRef.tx_catplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("plusUri"));
                    };
                case CTR_CAT_TYPE_SUBCAT:
                    componentsRef.lbl_catName.text = data.name;
                    componentsRef.btn_cat.selected = selected;
                    break;
            };
        }

        public function getCatLineType(data:*, line:uint):String
        {
            if (!data)
            {
                return ("");
            };
            if (((data) && (data.parentId == 0)))
            {
                return (CTR_CAT_TYPE_CAT);
            };
            return (CTR_CAT_TYPE_SUBCAT);
        }

        public function getCatDataLength(data:*, selected:Boolean):*
        {
            if (selected)
            {
            };
            return (2 + ((selected) ? data.subcats.length : 0));
        }

        public function updateMonsterSubarea(data:*, compRef:*, selected:Boolean):void
        {
            if (data)
            {
                if (!this._ctrBtnMonsterLocation[compRef.btn_loc.name])
                {
                    this.uiApi.addComponentHook(compRef.btn_loc, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.btn_loc, ComponentHookList.ON_ROLL_OUT);
                    this.uiApi.addComponentHook(compRef.btn_loc, ComponentHookList.ON_RELEASE);
                };
                this._ctrBtnMonsterLocation[compRef.btn_loc.name] = data;
                compRef.lbl_subarea.text = ((this.dataApi.getArea(data.areaId).name + " - ") + data.name);
                compRef.btn_loc.visible = true;
            }
            else
            {
                compRef.lbl_subarea.text = "";
                compRef.btn_loc.visible = false;
            };
        }

        public function updateMonsterStatLine(data:*, compRef:*, selected:Boolean):void
        {
            if (data)
            {
                compRef.lbl_text.text = data.text;
                if (data.icon)
                {
                    compRef.tx_caracIcon.uri = data.icon;
                }
                else
                {
                    compRef.tx_caracIcon.uri = null;
                };
                if (data.baseValue[(data.baseValue.length - 1)] != data.scaledValue[(data.scaledValue.length - 1)])
                {
                    compRef.lbl_value.text = ((data.scaledValue.length > 1) ? this.getStringFromValues(data.scaledValue[0], data.scaledValue[1]) : data.scaledValue[0]);
                    compRef.lbl_value.colorText = 16701568;
                    this.uiApi.addComponentHook(compRef.lbl_value, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.lbl_value, ComponentHookList.ON_ROLL_OUT);
                    this._lblValueStat[compRef.lbl_value.name] = data;
                }
                else
                {
                    compRef.lbl_value.text = ((data.baseValue.length > 1) ? this.getStringFromValues(data.baseValue[0], data.baseValue[1]) : data.baseValue[0]);
                    compRef.lbl_value.colorText = 13092805;
                    this.uiApi.removeComponentHook(compRef.lbl_value, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.removeComponentHook(compRef.lbl_value, ComponentHookList.ON_ROLL_OUT);
                    this._lblValueStat[compRef.lbl_value.name] = data;
                };
            }
            else
            {
                compRef.lbl_text.text = "";
                compRef.lbl_value.text = "";
                compRef.tx_caracIcon.uri = null;
            };
        }

        public function updateMonsterResistLine(data:*, compRef:*, selected:Boolean):void
        {
            if (data)
            {
                compRef.lbl_text.text = data.element;
                compRef.lbl_value.text = data.text;
                compRef.tx_picto.uri = this.uiApi.createUri((this._uriStatPicto + data.gfxId));
            }
            else
            {
                compRef.lbl_text.text = "";
                compRef.lbl_value.text = "";
                compRef.tx_picto.uri = null;
            };
        }

        public function updateMonster(data:*, compRef:*, selected:Boolean, line:uint):void
        {
            var monster:Monster;
            var isAggressive:Boolean;
            var gradeMin:MonsterGrade;
            var gradeMax:MonsterGrade;
            var tempSubareas:Array;
            var scaledMonster:Monster;
            var lastGradeId:int;
            var stats:Array;
            var level:int;
            var minN:int;
            var minE:int;
            var minF:int;
            var minW:int;
            var minA:int;
            var maxN:int;
            var maxE:int;
            var maxF:int;
            var maxW:int;
            var maxA:int;
            var resists:Array;
            var dropsSlotContent:Array;
            var pos:int;
            var rareTexture:Object;
            var okTexture:Object;
            var isTemporisSpellsUi:Boolean;
            var temporisCriteriaRegex:RegExp;
            var i:int;
            var m:Monster;
            var subArea:SubArea;
            var subarea:SubArea;
            var areaName:String;
            var subareaName:String;
            var subareaId:int;
            var bonusRange:int;
            var scaledBonusRange:int;
            var grade:Object;
            var drop:MonsterDrop;
            var item:ItemWrapper;
            var slot:Object;
            switch (this.getMonsterLineType(data, line))
            {
                case CTR_MONSTER_BASE:
                    this.uiApi.addComponentHook(compRef.tx_boss, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.tx_boss, ComponentHookList.ON_ROLL_OUT);
                    this.uiApi.addComponentHook(compRef.tx_archMonster, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.tx_archMonster, ComponentHookList.ON_ROLL_OUT);
                    this.uiApi.addComponentHook(compRef.tx_questMonster, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.tx_questMonster, ComponentHookList.ON_ROLL_OUT);
                    if (!this._ctrTxLink[compRef.btn_linkToMonster.name])
                    {
                        this.uiApi.addComponentHook(compRef.btn_linkToMonster, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.btn_linkToMonster, ComponentHookList.ON_ROLL_OUT);
                        this.uiApi.addComponentHook(compRef.btn_linkToMonster, ComponentHookList.ON_RELEASE);
                    };
                    this._ctrTxLink[compRef.btn_linkToMonster.name] = data;
                    if (!this._ctrTxLink[compRef.btn_linkToArch.name])
                    {
                        this.uiApi.addComponentHook(compRef.btn_linkToArch, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.btn_linkToArch, ComponentHookList.ON_ROLL_OUT);
                        this.uiApi.addComponentHook(compRef.btn_linkToArch, ComponentHookList.ON_RELEASE);
                    };
                    this._ctrTxLink[compRef.btn_linkToArch.name] = data;
                    if (!this._ctrTxLink[compRef.tx_incompatibleIdols.name])
                    {
                        this.uiApi.addComponentHook(compRef.tx_incompatibleIdols, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.tx_incompatibleIdols, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._ctrTxLink[compRef.tx_incompatibleIdols.name] = data;
                    monster = this.getMonster(data.monsterId);
                    if (!monster)
                    {
                        this.sysApi.log(16, (("On veut le monstre " + data) + " mais il ne semble pas exister !"));
                        break;
                    };
                    if (!this._ctrBtnMonster[compRef.btn_monster.name])
                    {
                        this.uiApi.addComponentHook(compRef.btn_monster, ComponentHookList.ON_RELEASE);
                    };
                    this._ctrBtnMonster[compRef.btn_monster.name] = {
                        "monster":monster,
                        "scaledMonster":data.breachScale
                    };
                    compRef.btn_monster.handCursor = true;
                    compRef.lbl_name.text = monster.name;
                    if (this.sysApi.getPlayerManager().hasRights)
                    {
                        compRef.lbl_name.text = (compRef.lbl_name.text + ((" (" + monster.id) + ")"));
                    };
                    this._ctrTxLink[compRef.tx_sword.name] = data;
                    compRef.tx_sword.x = ((compRef.lbl_name.textWidth + compRef.lbl_name.x) + 10);
                    compRef.tx_sword.y = 11;
                    compRef.tx_sword.visible = false;
                    isAggressive = false;
                    if (((!(this.playerApi.characteristics().energyPoints == 0)) && ((!(this.playerApi.restrictions())) || (!(this.playerApi.restrictions().cantAttackMonster)))))
                    {
                        m = this.getMonster(data.monsterId);
                        isAggressive = (((m.isAggressive) && (m.canAttack)) && (m["getAggressionLevel"](m.grades.length) >= Math.min(this.playerApi.getPlayedCharacterInfo().level, ProtocolConstantsEnum.MAX_LEVEL)));
                    };
                    if (((isAggressive) && (!(data.breachScale))))
                    {
                        compRef.tx_sword.themeDataId = "tx_sword";
                        if (((this.btn_subareas.selected) && (!(this._searchCriteria))))
                        {
                            subArea = this.dataApi.getSubArea(this.gd_categories.selectedItem.realId);
                            if (((subArea) && (!(this.mapApi.isDungeonSubArea(subArea.id) == -1))))
                            {
                                compRef.tx_sword.visible = false;
                            }
                            else
                            {
                                compRef.tx_sword.visible = true;
                            };
                        }
                        else
                        {
                            compRef.tx_sword.visible = true;
                        };
                    }
                    else
                    {
                        if (data.breachScale)
                        {
                            compRef.tx_sword.themeDataId = "tx_breach";
                            compRef.tx_sword.visible = true;
                        };
                    };
                    if (monster.isBoss)
                    {
                        compRef.tx_boss.visible = true;
                    }
                    else
                    {
                        compRef.tx_boss.visible = false;
                    };
                    if (monster.isMiniBoss)
                    {
                        compRef.tx_archMonster.visible = true;
                    }
                    else
                    {
                        compRef.tx_archMonster.visible = false;
                    };
                    if (monster.isQuestMonster)
                    {
                        compRef.tx_questMonster.visible = true;
                    }
                    else
                    {
                        compRef.tx_questMonster.visible = false;
                    };
                    compRef.btn_linkToMonster.visible = false;
                    compRef.btn_linkToArch.visible = false;
                    if (monster.isMiniBoss)
                    {
                        compRef.btn_linkToMonster.visible = true;
                    }
                    else
                    {
                        if (monster.correspondingMiniBossId > 0)
                        {
                            compRef.btn_linkToArch.visible = true;
                        };
                    };
                    compRef.tx_incompatibleIdols.visible = ((monster.incompatibleIdols.length > 0) || (monster.allIdolsDisabled));
                    if (monster.favoriteSubareaId > 0)
                    {
                        subarea = this.dataApi.getSubArea(monster.favoriteSubareaId);
                        areaName = this.dataApi.getArea(subarea.areaId).name;
                        subareaName = subarea.name;
                        if (subareaName.indexOf(areaName) != -1)
                        {
                            compRef.lbl_bestSubarea.text = subareaName;
                        }
                        else
                        {
                            compRef.lbl_bestSubarea.text = (((subareaName + " (") + areaName) + ")");
                        };
                        compRef.btn_loc.x = ((compRef.lbl_bestSubarea.textWidth + compRef.lbl_bestSubarea.x) + 10);
                        compRef.btn_loc.y = 40;
                        if (!this._ctrBtnMonsterLocation[compRef.btn_loc.name])
                        {
                            this.uiApi.addComponentHook(compRef.btn_loc, ComponentHookList.ON_ROLL_OVER);
                            this.uiApi.addComponentHook(compRef.btn_loc, ComponentHookList.ON_ROLL_OUT);
                            this.uiApi.addComponentHook(compRef.btn_loc, ComponentHookList.ON_RELEASE);
                        };
                        this._ctrBtnMonsterLocation[compRef.btn_loc.name] = monster;
                        compRef.btn_loc.visible = true;
                        if (((!(subarea.hasCustomWorldMap)) && (!(subarea.area.superArea.hasWorldMap))))
                        {
                            compRef.btn_loc.softDisabled = true;
                        }
                        else
                        {
                            compRef.btn_loc.softDisabled = false;
                        };
                    }
                    else
                    {
                        compRef.lbl_bestSubarea.text = this.uiApi.getText("ui.monster.noFavoriteZone");
                        compRef.btn_loc.visible = false;
                    };
                    gradeMin = monster.grades[0];
                    gradeMax = monster.grades[(monster.grades.length - 1)];
                    if (data.breachScale)
                    {
                        compRef.lbl_level.text = ((this.uiApi.getText("ui.common.short.level") + " ") + this.breachApi.getFloor());
                        compRef.lbl_level.colorText = 16701568;
                    }
                    else
                    {
                        compRef.lbl_level.text = ((this.uiApi.getText("ui.common.short.level") + " ") + this.getStringFromValues(gradeMin.level, gradeMax.level));
                        compRef.lbl_level.colorText = 13092805;
                    };
                    compRef.tx_sprite.uri = this.uiApi.createUri(((this._uriMonsterSprite + data.monsterId) + ".png"));
                    this._inc_monsterRender++;
                    break;
                case CTR_MONSTER_AREAS:
                    tempSubareas = new Array();
                    for each (subareaId in data.subareasList)
                    {
                        tempSubareas.push(this.dataApi.getSubArea(subareaId));
                    };
                    if (tempSubareas.length <= 2)
                    {
                        compRef.gd_subareas.height = (AREA_LINE_HEIGHT * 2);
                    }
                    else
                    {
                        compRef.gd_subareas.height = (AREA_LINE_HEIGHT * 5);
                    };
                    compRef.gd_subareas.dataProvider = tempSubareas;
                    break;
                case CTR_MONSTER_DETAILS:
                    this._selectedAndOpenedMonsterId = this._selectedMonsterId;
                    scaledMonster = this.getMonster(this._selectedMonsterId);
                    lastGradeId = (data.grades.length - 1);
                    stats = new Array();
                    level = ((data.grades[(scaledMonster.scaleGradeRef - 1)].hiddenLevel) ? data.grades[(scaledMonster.scaleGradeRef - 1)].hiddenLevel : data.grades[(scaledMonster.scaleGradeRef - 1)].level);
                    stats.push({
                        "text":(this.uiApi.getText("ui.common.lifePoints") + this.uiApi.getText("ui.common.colon")),
                        "baseValue":((data.scaledMonster) ? [(data.grades[(scaledMonster.scaleGradeRef - 1)].lifePoints + data.grades[(scaledMonster.scaleGradeRef - 1)].vitality)] : [(data.grades[0].lifePoints + data.grades[0].vitality), (data.grades[lastGradeId].lifePoints + data.grades[lastGradeId].vitality)]),
                        "scaledValue":(((data.scaledMonster) && (level < this.breachApi.getFloor())) ? ([Math.max((this.luaApi.getMonsterLifeScale(this.breachApi.getFloor(), scaledMonster, 0) + this.luaApi.getMonsterLifeScale(this.breachApi.getFloor(), scaledMonster, 11)), (data.grades[(scaledMonster.scaleGradeRef - 1)].lifePoints + data.grades[(scaledMonster.scaleGradeRef - 1)].vitality))]) : ([(data.grades[0].lifePoints + data.grades[0].vitality), (data.grades[lastGradeId].lifePoints + data.grades[lastGradeId].vitality)])),
                        "icon":this.uiApi.createUri(this.uiApi.me().getConstant("hpIconUri")),
                        "statIds":[0, 11]
                    });
                    stats.push({
                        "text":(this.uiApi.getText("ui.stats.actionPoints") + this.uiApi.getText("ui.common.colon")),
                        "baseValue":[data.grades[0].actionPoints, data.grades[lastGradeId].actionPoints],
                        "scaledValue":[data.grades[0].actionPoints, data.grades[lastGradeId].actionPoints],
                        "icon":this.uiApi.createUri(this.uiApi.me().getConstant("apIconUri")),
                        "statIds":[1]
                    });
                    stats.push({
                        "text":(this.uiApi.getText("ui.stats.movementPoints") + this.uiApi.getText("ui.common.colon")),
                        "baseValue":[data.grades[0].movementPoints, data.grades[lastGradeId].movementPoints],
                        "scaledValue":(((data.scaledMonster) && (level < this.breachApi.getFloor())) ? [this.luaApi.getMonsterMovementPointsScale(scaledMonster, this.breachApi.getFloor(), 23)] : ([data.grades[0].movementPoints, data.grades[lastGradeId].movementPoints])),
                        "icon":this.uiApi.createUri(this.uiApi.me().getConstant("mpIconUri")),
                        "statIds":[23]
                    });
                    if (data.scaledMonster)
                    {
                        bonusRange = scaledMonster.grades[(scaledMonster.scaleGradeRef - 1)].bonusRange;
                        scaledBonusRange = ((data.grades[(scaledMonster.scaleGradeRef - 1)].level < this.breachApi.getFloor()) ? this.luaApi.getMonsterBonusRangeScale(scaledMonster, this.breachApi.getFloor(), 19) : bonusRange);
                        if (((!(bonusRange == 0)) && (!(scaledBonusRange == 0))))
                        {
                            stats.push({
                                "text":(this.uiApi.getText("ui.stats.range") + this.uiApi.getText("ui.common.colon")),
                                "baseValue":[bonusRange],
                                "scaledValue":[scaledBonusRange],
                                "icon":null,
                                "statIds":[19]
                            });
                        };
                    };
                    compRef.gd_stats.dataProvider = stats;
                    minN = -1;
                    minE = -1;
                    minF = -1;
                    minW = -1;
                    minA = -1;
                    maxN = -1;
                    maxE = -1;
                    maxF = -1;
                    maxW = -1;
                    maxA = -1;
                    resists = new Array();
                    if (data.scaledMonster)
                    {
                        minN = (maxN = data.grades[(scaledMonster.scaleGradeRef - 1)].neutralResistance);
                        minE = (maxE = data.grades[(scaledMonster.scaleGradeRef - 1)].earthResistance);
                        minF = (maxF = data.grades[(scaledMonster.scaleGradeRef - 1)].fireResistance);
                        minW = (maxW = data.grades[(scaledMonster.scaleGradeRef - 1)].waterResistance);
                        minA = (maxA = data.grades[(scaledMonster.scaleGradeRef - 1)].airResistance);
                    }
                    else
                    {
                        for each (grade in data.grades)
                        {
                            if (((minN == -1) || (grade.neutralResistance < minN)))
                            {
                                minN = grade.neutralResistance;
                            };
                            if (((maxN == -1) || (grade.neutralResistance > maxN)))
                            {
                                maxN = grade.neutralResistance;
                            };
                            if (((minE == -1) || (grade.earthResistance < minE)))
                            {
                                minE = grade.earthResistance;
                            };
                            if (((maxE == -1) || (grade.earthResistance > maxE)))
                            {
                                maxE = grade.earthResistance;
                            };
                            if (((minF == -1) || (grade.fireResistance < minF)))
                            {
                                minF = grade.fireResistance;
                            };
                            if (((maxF == -1) || (grade.fireResistance > maxF)))
                            {
                                maxF = grade.fireResistance;
                            };
                            if (((minW == -1) || (grade.waterResistance < minW)))
                            {
                                minW = grade.waterResistance;
                            };
                            if (((maxW == -1) || (grade.waterResistance > maxW)))
                            {
                                maxW = grade.waterResistance;
                            };
                            if (((minA == -1) || (grade.airResistance < minA)))
                            {
                                minA = grade.airResistance;
                            };
                            if (((maxA == -1) || (grade.airResistance > maxA)))
                            {
                                maxA = grade.airResistance;
                            };
                        };
                    };
                    resists.push({
                        "text":this.getStringFromValues(minN, maxN),
                        "gfxId":"neutral",
                        "element":this.uiApi.getText("ui.stats.neutralReductionPercent")
                    });
                    resists.push({
                        "text":this.getStringFromValues(minE, maxE),
                        "gfxId":"strength",
                        "element":this.uiApi.getText("ui.stats.earthReductionPercent")
                    });
                    resists.push({
                        "text":this.getStringFromValues(minF, maxF),
                        "gfxId":"intelligence",
                        "element":this.uiApi.getText("ui.stats.fireReductionPercent")
                    });
                    resists.push({
                        "text":this.getStringFromValues(minW, maxW),
                        "gfxId":"chance",
                        "element":this.uiApi.getText("ui.stats.waterReductionPercent")
                    });
                    resists.push({
                        "text":this.getStringFromValues(minA, maxA),
                        "gfxId":"agility",
                        "element":this.uiApi.getText("ui.stats.airReductionPercent")
                    });
                    compRef.gd_resists.dataProvider = resists;
                    if (data.hasDrops)
                    {
                        compRef.lbl_drops.text = this.uiApi.getText("ui.common.loot");
                    }
                    else
                    {
                        compRef.lbl_drops.text = "";
                    };
                    if (this.sysApi.getCurrentServer().gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS)
                    {
                        this.getMonsterEquipmentDrops(this._selectedAndOpenedMonsterId);
                        compRef.btn_openEquipmentTab.visible = false;
                    }
                    else
                    {
                        compRef.btn_openEquipmentTab.visible = false;
                    };
                    if (!this._ctrSlotDrop[compRef.btn_openEquipmentTab.name])
                    {
                        this.uiApi.addComponentHook(compRef.btn_openEquipmentTab, ComponentHookList.ON_RELEASE);
                        this.uiApi.addComponentHook(compRef.btn_openEquipmentTab, ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.btn_openEquipmentTab, ComponentHookList.ON_ROLL_OUT);
                    };
                    this._ctrSlotDrop[compRef.btn_openEquipmentTab.name] = this._selectedAndOpenedMonsterId;
                    break;
                case CTR_MONSTER_DROPS:
                    dropsSlotContent = new Array();
                    pos = 0;
                    for each (drop in data.dropsList)
                    {
                        item = this.dataApi.getItemWrapper(drop.objectId, pos, 0, 1);
                        pos++;
                        dropsSlotContent.push(item);
                    };
                    rareTexture = this.uiApi.createUri(this._uriRareDrop);
                    okTexture = this.uiApi.createUri(this._uriOkDrop);
                    if (((this.sysApi.getCurrentServer().gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS) && ((this._monsterEquipmentDrops) && (this._monsterEquipmentDrops.length > 0))))
                    {
                        compRef.gd_drops.x = 55;
                        compRef.gd_drops.width = 695;
                    }
                    else
                    {
                        compRef.gd_drops.x = 10;
                        compRef.gd_drops.width = 740;
                    };
                    compRef.gd_drops.dataProvider = dropsSlotContent;
                    isTemporisSpellsUi = this.dataApi.isTemporisSpellsUi();
                    temporisCriteriaRegex = new RegExp("^((SC=[0-9]+?(&ST=[0-9]+?)?)|(ST=[0-9]+?(&SC=[0-9]+?)?))$");
                    i = 0;
                    for each (slot in compRef.gd_drops.slots)
                    {
                        if (!data.dropsList[i])
                        {
                            slot.visible = false;
                        }
                        else
                        {
                            slot.visible = true;
                            if ((((data.dropsList[i]) && (data.dropsList[i].hasCriteria)) && ((!(isTemporisSpellsUi)) || (!(temporisCriteriaRegex.test(data.dropsList[i].criteria))))))
                            {
                                slot.forcedBackGroundIconUri = this.uiApi.createUri(this._uriSpecialSlot);
                            }
                            else
                            {
                                if (data.dropsList[i])
                                {
                                    slot.forcedBackGroundIconUri = this.uiApi.createUri(this._uriEmptySlot);
                                };
                            };
                            if (((data.dropsList[i]) && (data.dropsList[i].percentDropForGrade1 < 2)))
                            {
                                slot.customTexture = rareTexture;
                            }
                            else
                            {
                                if (((data.dropsList[i]) && (data.dropsList[i].percentDropForGrade1 < 10)))
                                {
                                    slot.customTexture = okTexture;
                                }
                                else
                                {
                                    slot.customTexture = null;
                                };
                            };
                        };
                        i++;
                    };
                    if (!this._ctrSlotDrop[compRef.gd_drops.name])
                    {
                        this.uiApi.addComponentHook(compRef.gd_drops, ComponentHookList.ON_ITEM_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.gd_drops, ComponentHookList.ON_ITEM_ROLL_OUT);
                        this.uiApi.addComponentHook(compRef.gd_drops, ComponentHookList.ON_ITEM_RIGHT_CLICK);
                    };
                    this._ctrSlotDrop[compRef.gd_drops.name] = data;
                    break;
            };
        }

        public function getMonsterLineType(data:*, line:uint):String
        {
            if (!data)
            {
                return ("");
            };
            if (data.hasOwnProperty("dropsList"))
            {
                return (CTR_MONSTER_DROPS);
            };
            if (data.hasOwnProperty("grades"))
            {
                return (CTR_MONSTER_DETAILS);
            };
            if (data.hasOwnProperty("subareasList"))
            {
                return (CTR_MONSTER_AREAS);
            };
            return (CTR_MONSTER_BASE);
        }

        public function getMonsterDataLength(data:*, selected:Boolean):*
        {
            return (1);
        }

        private function getMonster(id:int):Monster
        {
            if (!this._monstersDataById[id])
            {
                this._monstersDataById[id] = this.dataApi.getMonsterFromId(id);
            };
            return (this._monstersDataById[id]);
        }

        private function pushEmptyLine(array:Array, count:int):void
        {
            var i:int;
            while (i < count)
            {
                array.push(null);
                i++;
            };
        }

        private function updateMonsterGrid(category:Object):void
        {
            var tempMonstersSorted:Object;
            var id:uint;
            var ts:uint;
            var result:Object;
            var critSplit:Array;
            var nameResult:Object;
            var dropResult:Object;
            var data:*;
            var currentCriteria:String;
            var wannabeCriteria:String;
            var crit:String;
            var index:int;
            var indexToScroll:int;
            var monsters:Array = [];
            this._selectedAndOpenedMonsterId = 0;
            var vectoruint:Vector.<uint> = new Vector.<uint>();
            if (((!(this._monstersListToDisplay)) || (this._monstersListToDisplay.length == 0)))
            {
                if (!this._searchCriteria)
                {
                    if (((category.parentId > 0) || (this.playerApi.isInBreach())))
                    {
                        for each (id in category.monsters)
                        {
                            if (id)
                            {
                                vectoruint.push(id);
                            };
                        };
                        tempMonstersSorted = this.dataApi.querySort(Monster, vectoruint, ["isBoss", "isMiniBoss", "name"], [false, true, true]);
                        for each (id in tempMonstersSorted)
                        {
                            index = monsters.length;
                            monsters.push({
                                "monsterId":id,
                                "breachScale":(category.parentId < 0)
                            });
                            this.pushEmptyLine(monsters, (this.uiApi.me().getConstant("monsterInfoLineCount") - 1));
                            if (((id == this._selectedMonsterId) && (this._selectedMonsterIsScaled == (category.parentId < 0))))
                            {
                                monsters = monsters.concat(this.addDetails(id, category, this._selectedMonsterIsScaled));
                                indexToScroll = index;
                            };
                        };
                    };
                }
                else
                {
                    if (this._previousSearchCriteria != ((((((this._searchCriteria + "#") + this.btn_displayCriteriaDrop.selected) + "#") + this._searchOnName) + "") + this._searchOnDrop))
                    {
                        ts = getTimer();
                        critSplit = ((this._previousSearchCriteria) ? this._previousSearchCriteria.split("#") : []);
                        if (((!(this._searchCriteria == critSplit[0])) || (!(this.btn_displayCriteriaDrop.selected.toString() == critSplit[1]))))
                        {
                            nameResult = this.dataApi.queryString(Monster, "name", this._searchCriteria);
                            if (this.btn_displayCriteriaDrop.selected)
                            {
                                dropResult = this.dataApi.queryEquals(Monster, "drops.objectId", this.dataApi.queryString(Item, "name", this._searchCriteria));
                            }
                            else
                            {
                                dropResult = this.dataApi.queryIntersection(this.dataApi.queryEquals(Monster, "drops.objectId", this.dataApi.queryString(Item, "name", this._searchCriteria)), this.dataApi.queryEquals(Monster, "drops.hasCriteria", false));
                            };
                            this._searchResultByCriteriaList["_searchOnName"] = nameResult;
                            this._searchResultByCriteriaList["_searchOnDrop"] = dropResult;
                            if (((nameResult) || (dropResult)))
                            {
                                this.sysApi.log(2, (((("Result : " + (((nameResult) ? nameResult.length : 0) + ((dropResult) ? dropResult.length : 0))) + " in ") + (getTimer() - ts)) + " ms"));
                            };
                        };
                        if (((this._searchOnName) && (this._searchOnDrop)))
                        {
                            result = this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"], this._searchResultByCriteriaList["_searchOnDrop"]);
                        }
                        else
                        {
                            if (this._searchOnName)
                            {
                                result = this._searchResultByCriteriaList["_searchOnName"];
                            }
                            else
                            {
                                if (this._searchOnDrop)
                                {
                                    result = this._searchResultByCriteriaList["_searchOnDrop"];
                                }
                                else
                                {
                                    this.gd_monsters.dataProvider = [];
                                    this.lbl_noMonster.visible = true;
                                    this.lbl_noMonster.text = this.uiApi.getText("ui.search.needCriterion");
                                    this._previousSearchCriteria = ((((((this._searchCriteria + "#") + this.btn_displayCriteriaDrop.selected) + "#") + this._searchOnName) + "") + this._searchOnDrop);
                                    return;
                                };
                            };
                        };
                        for each (id in result)
                        {
                            vectoruint.push(id);
                        };
                        tempMonstersSorted = this.dataApi.querySort(Monster, vectoruint, ["isBoss", "isMiniBoss", "name"], [false, true, true]);
                        for each (id in tempMonstersSorted)
                        {
                            index = monsters.length;
                            monsters.push({
                                "monsterId":id,
                                "breachScale":false
                            });
                            this.pushEmptyLine(monsters, (this.uiApi.me().getConstant("monsterInfoLineCount") - 1));
                            if (((id == this._selectedMonsterId) && (!(this._selectedMonsterIsScaled))))
                            {
                                indexToScroll = monsters.length;
                                monsters = monsters.concat(this.addDetails(id, category, this._selectedMonsterIsScaled));
                            };
                            if (this._breachMonsters.indexOf(id) != -1)
                            {
                                monsters.push({
                                    "monsterId":id,
                                    "breachScale":true
                                });
                                this.pushEmptyLine(monsters, (this.uiApi.me().getConstant("monsterInfoLineCount") - 1));
                                if (((id == this._selectedMonsterId) && (this._selectedMonsterIsScaled)))
                                {
                                    indexToScroll = monsters.length;
                                    monsters = monsters.concat(this.addDetails(id, category, this._selectedMonsterIsScaled));
                                };
                            };
                        };
                    }
                    else
                    {
                        for each (data in this.gd_monsters.dataProvider)
                        {
                            if ((((data) && (data.monsterId)) && (data.monsterId is int)))
                            {
                                index = monsters.length;
                                monsters.push(data);
                                this.pushEmptyLine(monsters, (this.uiApi.me().getConstant("monsterInfoLineCount") - 1));
                                if (((data.monsterId == this._selectedMonsterId) && ((!(this.gd_monsters.selectedItem)) || (this.gd_monsters.selectedItem.breachScale == data.breachScale))))
                                {
                                    indexToScroll = monsters.length;
                                    monsters = monsters.concat(this.addDetails(int(data.monsterId), category, this._selectedMonsterIsScaled));
                                };
                            };
                        };
                    };
                };
            }
            else
            {
                for each (id in this._monstersListToDisplay)
                {
                    vectoruint.push(id);
                };
                tempMonstersSorted = this.dataApi.querySort(Monster, vectoruint, ["isBoss", "isMiniBoss", "name"], [false, true, true]);
                for each (id in tempMonstersSorted)
                {
                    monsters.push({
                        "monsterId":id,
                        "breachScale":(category.parentId < 0)
                    });
                    this.pushEmptyLine(monsters, (this.uiApi.me().getConstant("monsterInfoLineCount") - 1));
                    if (((id == this._selectedMonsterId) && ((!(this.gd_monsters.selectedItem)) || (this.gd_monsters.selectedItem.breachScale == this._selectedMonsterIsScaled))))
                    {
                        indexToScroll = index;
                        monsters = monsters.concat(this.addDetails(id, category, this._selectedMonsterIsScaled));
                    };
                    index++;
                    index++;
                };
            };
            if (monsters.length)
            {
                this.gd_monsters.dataProvider = monsters;
                this.lbl_noMonster.visible = false;
            }
            else
            {
                this.gd_monsters.dataProvider = [];
                this.lbl_noMonster.visible = true;
                this.lbl_noMonster.text = this.uiApi.getText("ui.search.noResult");
                if (this._searchCriteria)
                {
                    currentCriteria = "";
                    wannabeCriteria = "";
                    for (crit in this._searchTextByCriteriaList)
                    {
                        if (this[crit])
                        {
                            currentCriteria = (currentCriteria + (this._searchTextByCriteriaList[crit] + ", "));
                        }
                        else
                        {
                            if (this._searchResultByCriteriaList[crit].length > 0)
                            {
                                wannabeCriteria = (wannabeCriteria + (this._searchTextByCriteriaList[crit] + ", "));
                            };
                        };
                    };
                    if (currentCriteria.length > 0)
                    {
                        currentCriteria = currentCriteria.slice(0, -2);
                    };
                    if (wannabeCriteria.length > 0)
                    {
                        wannabeCriteria = wannabeCriteria.slice(0, -2);
                    };
                    if (wannabeCriteria.length == 0)
                    {
                        this.lbl_noMonster.text = this.uiApi.getText("ui.search.noResultFor", this._searchCriteria);
                    }
                    else
                    {
                        this.lbl_noMonster.text = this.uiApi.getText("ui.search.noResultsBut", currentCriteria, wannabeCriteria);
                    };
                };
            };
            if (this._forceOpenMonster)
            {
                this._forceOpenMonster = false;
                this.gd_monsters.moveTo(indexToScroll, true);
            };
            if (this._currentScrollValue != 0)
            {
                this.gd_monsters.verticalScrollValue = this._currentScrollValue;
            };
            this._previousSearchCriteria = ((((((this._searchCriteria + "#") + this.btn_displayCriteriaDrop.selected) + "#") + this._searchOnName) + "") + this._searchOnDrop);
        }

        private function addDetails(monsterId:int, category:Object, scaledMonster:Boolean=false):Array
        {
            var drop:MonsterDrop;
            var nbDropsLine:int;
            var dropsList:Array;
            var endIndex:int;
            var i:int;
            var result:Array = [];
            var monster:Monster = this.getMonster(monsterId);
            var details:Object = {
                "grades":monster.grades,
                "spells":monster.spells,
                "subareas":monster.subareas,
                "hasDrops":true,
                "scaledMonster":scaledMonster
            };
            var drops:Array = [];
            if (!scaledMonster)
            {
                this._dropTemporisItemResult = null;
                for each (drop in monster.drops)
                {
                    if (((this.btn_displayCriteriaDrop.selected) || (!(drop.hasCriteria))))
                    {
                        drops.push(drop);
                    };
                };
                if (this.dataApi.isTemporisSpellsUi())
                {
                    for each (drop in monster.temporisDrops)
                    {
                        if (((this.btn_displayCriteriaDrop.selected) || (!(drop.hasCriteria))))
                        {
                            drops.push(drop);
                        };
                    };
                };
            };
            if (!drops.length)
            {
                details.hasDrops = false;
            };
            result.push(details);
            this.pushEmptyLine(result, (this.uiApi.me().getConstant("monsterDetailLineCount") - 1));
            if (drops.length)
            {
                nbDropsLine = int(Math.ceil((drops.length / NB_DROP_PER_LINE)));
                i = 0;
                while (i < nbDropsLine)
                {
                    endIndex = ((i + 1) * NB_DROP_PER_LINE);
                    if (endIndex >= drops.length)
                    {
                        dropsList = drops.slice((i * NB_DROP_PER_LINE));
                    }
                    else
                    {
                        dropsList = drops.slice((i * NB_DROP_PER_LINE), endIndex);
                    };
                    result.push({"dropsList":dropsList});
                    this.pushEmptyLine(result, (this.uiApi.me().getConstant("monsterSlotLineCount") - 1));
                    i++;
                };
            };
            return (result);
        }

        private function displayCategories(selectedCategory:Object=null, forceOpen:Boolean=false):void
        {
            var cat2:Object;
            var categories:Array;
            var cat:Object;
            var subcat:Object;
            var myIndex:int;
            if (!selectedCategory)
            {
                selectedCategory = this.gd_categories.selectedItem;
            };
            if ((((selectedCategory.parentId > 0) && (this._openCatIndex == selectedCategory.parentId)) || (this._openCatIndex == selectedCategory.id)))
            {
                this._currentSelectedCatId = selectedCategory.id;
                for each (cat2 in this.gd_categories.dataProvider)
                {
                    if (cat2.id == this._currentSelectedCatId)
                    {
                        break;
                    };
                    myIndex++;
                };
                if (this.gd_categories.selectedIndex != myIndex)
                {
                    this.gd_categories.silent = true;
                    this.gd_categories.selectedIndex = myIndex;
                    this.gd_categories.silent = false;
                };
                this.updateMonsterGrid(selectedCategory);
                if (this._openCatIndex != selectedCategory.id)
                {
                    return;
                };
            }
            else
            {
                if (((this.playerApi.isInBreach()) && (selectedCategory.parentId == -1)))
                {
                    this._currentSelectedCatId = selectedCategory.id;
                    for each (cat2 in this.gd_categories.dataProvider)
                    {
                        if (cat2.id == this._currentSelectedCatId)
                        {
                            break;
                        };
                        myIndex++;
                    };
                    if (this.gd_categories.selectedIndex != myIndex)
                    {
                        this.gd_categories.silent = true;
                        this.gd_categories.selectedIndex = myIndex;
                        this.gd_categories.silent = false;
                    };
                    this.updateMonsterGrid(selectedCategory);
                };
            };
            var bigCatId:int = selectedCategory.id;
            if (selectedCategory.parentId > 0)
            {
                bigCatId = selectedCategory.parentId;
            };
            var index:int = -1;
            var tempCats:Array = [];
            var categoryOpened:int = -1;
            if (this._currentCategoryType == CAT_TYPE_AREA)
            {
                categories = this._categoriesArea;
            }
            else
            {
                categories = this._categoriesRace;
            };
            for each (cat in categories)
            {
                tempCats.push(cat);
                index++;
                if (bigCatId == cat.id)
                {
                    myIndex = index;
                    if (((!(this._currentSelectedCatId == cat.id)) || (this._openCatIndex == 0)))
                    {
                        categoryOpened = cat.id;
                        for each (subcat in cat.subcats)
                        {
                            tempCats.push(subcat);
                            index++;
                            if (subcat.id == selectedCategory.id)
                            {
                                myIndex = index;
                            };
                        };
                    };
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
            this._currentSelectedCatId = selectedCategory.id;
            this.gd_categories.dataProvider = tempCats;
            if (this.gd_categories.selectedIndex != myIndex)
            {
                this.gd_categories.silent = true;
                this.gd_categories.selectedIndex = myIndex;
                this.gd_categories.silent = false;
            };
            this.updateMonsterGrid(this.gd_categories.selectedItem);
        }

        private function changeSearchOnName():void
        {
            this._searchOnName = (!(this._searchOnName));
            Grimoire.getInstance().bestiarySearchOnName = this._searchOnName;
            if (((!(this._searchOnName)) && (!(this._searchOnDrop))))
            {
                this.inp_search.visible = false;
                this.tx_inputBg_search.disabled = true;
            }
            else
            {
                this.inp_search.visible = true;
                this.tx_inputBg_search.disabled = false;
            };
            if (((this._searchCriteria) && (!(this._searchCriteria == ""))))
            {
                this.updateMonsterGrid(this.gd_categories.selectedItem);
            };
        }

        private function changeSearchOnDrop():void
        {
            this._searchOnDrop = (!(this._searchOnDrop));
            Grimoire.getInstance().bestiarySearchOnDrop = this._searchOnDrop;
            if (((!(this._searchOnName)) && (!(this._searchOnDrop))))
            {
                this.inp_search.visible = false;
                this.tx_inputBg_search.disabled = true;
            }
            else
            {
                this.inp_search.visible = true;
                this.tx_inputBg_search.disabled = false;
            };
            if (((this._searchCriteria) && (!(this._searchCriteria == ""))))
            {
                this.updateMonsterGrid(this.gd_categories.selectedItem);
            };
        }

        private function getIdolCoeff(pIdol:Idol):Number
        {
            var i:int;
            var j:int;
            var coeff:Number = 1;
            var synergiesIds:Object = pIdol.synergyIdolsIds;
            var synergiesCoeffs:Object = pIdol.synergyIdolsCoeff;
            var numSynergies:uint = synergiesIds.length;
            var numActiveIdols:uint = this._currentIdols.length;
            i = 0;
            while (i < numActiveIdols)
            {
                j = 0;
                while (j < numSynergies)
                {
                    if (synergiesIds[j] == this._currentIdols[i])
                    {
                        coeff = (coeff * synergiesCoeffs[j]);
                    };
                    j++;
                };
                i++;
            };
            return (coeff);
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (target == this.gd_categories)
            {
                if (selectMethod != GridItemSelectMethodEnum.AUTO)
                {
                    this._searchCriteria = null;
                    this.inp_search.text = "";
                    this._currentScrollValue = 0;
                    this._monstersListToDisplay = new Array();
                    if (this._currentCategoryType == CAT_TYPE_AREA)
                    {
                        this._lastAreaSelected = target.selectedItem;
                    }
                    else
                    {
                        this._lastRaceSelected = target.selectedItem;
                    };
                    this.displayCategories(target.selectedItem);
                };
            };
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (((item.data) && (!(target.name.indexOf("gd_drops") == -1))))
            {
                data = item.data;
                if (((data == null) || (!(data is ItemWrapper))))
                {
                    return;
                };
                contextMenu = this.menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var text:String;
            var pos:Object;
            var data:Object;
            var monster:Monster;
            var dropResult:Object;
            var itemData:Object;
            var settings:Object;
            var itemTooltipSettings:ItemTooltipSettings;
            var setting:String;
            var objVariables:*;
            if (((item.data) && (!(target.name.indexOf("gd_drops") == -1))))
            {
                pos = {
                    "point":LocationEnum.POINT_BOTTOM,
                    "relativePoint":LocationEnum.POINT_TOP
                };
                data = this._ctrSlotDrop[target.name].dropsList[item.data.position];
                if ((item.data is ItemWrapper))
                {
                    monster = this.getMonster(data.monsterId);
                    dropResult = this.computeDropPercentage(monster, 1, monster.grades.length, data);
                    itemData = new Object();
                    itemData.itemWrapper = item.data;
                    itemData.dropResult = dropResult;
                    settings = new Object();
                    itemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings);
                    if (itemTooltipSettings == null)
                    {
                        itemTooltipSettings = this.tooltipApi.createItemSettings();
                        this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, DataStoreEnum.BIND_ACCOUNT);
                    };
                    objVariables = this.sysApi.getObjectVariables(itemTooltipSettings);
                    for each (setting in objVariables)
                    {
                        settings[setting] = itemTooltipSettings[setting];
                    };
                    settings["showEffects"] = true;
                    settings.showDropPercentage = true;
                    this.uiApi.showTooltip(itemData, target, false, "standard", pos.point, pos.relativePoint, 3, "item", null, settings);
                };
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
            };
        }

        private function computeDropPercentage(monster:Monster, minGrade:uint, maxGrade:uint, data:*):Object
        {
            var idol:Idol;
            var i:int;
            var dropPercentageWithMonsterAndAlmanaxBonuses:Number;
            var dropPercentageWithoutIdolsBonus:Number;
            var monsterLevelForGivenGrade:uint;
            var ratioMonsterLevelToPlayersGroupLevel:Number;
            var idolsDropBonus:Number;
            var partyMembers:Object;
            var member:PartyMemberWrapper;
            if (minGrade < 1)
            {
                minGrade = 1;
            };
            if (minGrade > 5)
            {
                minGrade = 5;
            };
            if (maxGrade < 1)
            {
                maxGrade = 1;
            };
            if (maxGrade > 5)
            {
                maxGrade = 5;
            };
            var isInParty:* = (this.partyApi.getPartyMembers().length > 0);
            var idolsList:Object = ((isInParty) ? this.playerApi.getPartyIdols() : this.playerApi.getSoloIdols());
            var numIdols:uint = idolsList.length;
            var idolsLootBonusPercent:Number = 0;
            this._currentIdols = new Vector.<int>();
            i = 0;
            while (i < numIdols)
            {
                idol = this.dataApi.getIdol(idolsList[i]);
                if (monster.incompatibleIdols.indexOf(idol.id) == -1)
                {
                    this._currentIdols.push(idol.id);
                };
                i++;
            };
            numIdols = this._currentIdols.length;
            i = 0;
            while (i < numIdols)
            {
                idol = this.dataApi.getIdol(this._currentIdols[i]);
                idolsLootBonusPercent = (idolsLootBonusPercent + (Math.round((idol.dropBonus * this.getIdolCoeff(idol))) / 100));
                i++;
            };
            var myProspection:int = (((this.playerApi.characteristics().prospecting.alignGiftBonus + this.playerApi.characteristics().prospecting.base) + this.playerApi.characteristics().prospecting.contextModif) + this.playerApi.characteristics().prospecting.objectsAndMountBonus);
            if (myProspection < 100)
            {
                myProspection = 100;
            };
            var monsterAndAlmanaxDropBoostMultiplier:Number = (this.roleplayApi.getMonsterDropBoostMultiplier(monster.id) * this.roleplayApi.getAlmanaxMonsterDropChanceBonusMultiplier(monster.id));
            var highestLevelFromThePlayersGroup:uint;
            if (!isInParty)
            {
                highestLevelFromThePlayersGroup = this.playerApi.getPlayedCharacterInfo().level;
            }
            else
            {
                partyMembers = this.partyApi.getPartyMembers();
                for each (member in partyMembers)
                {
                    if (member.level > highestLevelFromThePlayersGroup)
                    {
                        highestLevelFromThePlayersGroup = member.level;
                    };
                };
            };
            if (highestLevelFromThePlayersGroup > ProtocolConstantsEnum.MAX_LEVEL)
            {
                highestLevelFromThePlayersGroup = ProtocolConstantsEnum.MAX_LEVEL;
            };
            var bonusFromGroupsHighestLevel:Number = (((highestLevelFromThePlayersGroup * 0.5) + 100) / 100);
            var idolsAndGroupLevelDropBonus:Number = (bonusFromGroupsHighestLevel * idolsLootBonusPercent);
            var basicDropPercentageMinGrade:Number = 0;
            if (((data[("percentDropForGrade" + minGrade)] > 0) && (data[("percentDropForGrade" + minGrade)] < this.MINIMAL_DROP_PERCENTAGE_BEFORE_CALCULATIONS)))
            {
                basicDropPercentageMinGrade = this.getRound(this.MINIMAL_DROP_PERCENTAGE_BEFORE_CALCULATIONS);
            }
            else
            {
                basicDropPercentageMinGrade = this.addSpecificCoeff(data, minGrade);
            };
            dropPercentageWithMonsterAndAlmanaxBonuses = (basicDropPercentageMinGrade * monsterAndAlmanaxDropBoostMultiplier);
            dropPercentageWithoutIdolsBonus = this.getRound(((dropPercentageWithMonsterAndAlmanaxBonuses * myProspection) / 100));
            monsterLevelForGivenGrade = ((monster.grades[(minGrade - 1)].hiddenLevel > 0) ? monster.grades[(minGrade - 1)].hiddenLevel : monster.grades[(minGrade - 1)].level);
            ratioMonsterLevelToPlayersGroupLevel = Math.pow((monsterLevelForGivenGrade / highestLevelFromThePlayersGroup), 2);
            idolsDropBonus = this.getRound(((dropPercentageWithMonsterAndAlmanaxBonuses * ratioMonsterLevelToPlayersGroupLevel) * idolsAndGroupLevelDropBonus));
            var finalDropPercentageForMinGrade:Number = this.getRound((dropPercentageWithoutIdolsBonus + idolsDropBonus));
            var basicDropPercentageMaxGrade:Number = 0;
            if (((data[("percentDropForGrade" + maxGrade)] > 0) && (data[("percentDropForGrade" + maxGrade)] < this.MINIMAL_DROP_PERCENTAGE_BEFORE_CALCULATIONS)))
            {
                basicDropPercentageMaxGrade = this.getRound(this.MINIMAL_DROP_PERCENTAGE_BEFORE_CALCULATIONS);
            }
            else
            {
                basicDropPercentageMaxGrade = this.addSpecificCoeff(data, maxGrade);
            };
            dropPercentageWithMonsterAndAlmanaxBonuses = (basicDropPercentageMaxGrade * monsterAndAlmanaxDropBoostMultiplier);
            dropPercentageWithoutIdolsBonus = this.getRound(((dropPercentageWithMonsterAndAlmanaxBonuses * myProspection) / 100));
            monsterLevelForGivenGrade = ((monster.grades[(maxGrade - 1)].hiddenLevel > 0) ? monster.grades[(maxGrade - 1)].hiddenLevel : monster.grades[(maxGrade - 1)].level);
            ratioMonsterLevelToPlayersGroupLevel = Math.pow((monsterLevelForGivenGrade / highestLevelFromThePlayersGroup), 2);
            idolsDropBonus = this.getRound(((dropPercentageWithMonsterAndAlmanaxBonuses * ratioMonsterLevelToPlayersGroupLevel) * idolsAndGroupLevelDropBonus));
            var finalDropPercentageForMaxGrade:Number = this.getRound((dropPercentageWithoutIdolsBonus + idolsDropBonus));
            if (finalDropPercentageForMinGrade > 100)
            {
                finalDropPercentageForMinGrade = 100;
            };
            if (finalDropPercentageForMaxGrade > 100)
            {
                finalDropPercentageForMaxGrade = 100;
            };
            return ({
                "dropMinGrade":finalDropPercentageForMinGrade,
                "dropMaxGrade":finalDropPercentageForMaxGrade,
                "baseDropMinGrade":basicDropPercentageMinGrade,
                "baseDropMaxGrade":basicDropPercentageMaxGrade
            });
        }

        private function addSpecificCoeff(data:*, grade:uint):Number
        {
            var criteria:ItemCriterion;
            var dropPercentForGrade:String = ("percentDropForGrade" + grade);
            if (data[dropPercentForGrade] >= 100)
            {
                return (this.getRound(data[dropPercentForGrade]));
            };
            var specificCoeff:MonsterDropCoefficient = data.getSpecificDropCoeffByGrade(1);
            if (!specificCoeff)
            {
                return (this.getRound(data["percentDropForGrade1"]));
            };
            specificCoeff = data.getSpecificDropCoeffByGrade(grade);
            if (specificCoeff)
            {
                if (specificCoeff.conditions)
                {
                    for each (criteria in specificCoeff.conditions.inlineCriteria)
                    {
                        if ((criteria is ServerSeasonTemporisCriterion))
                        {
                            if (criteria.isRespected)
                            {
                                return (this.getRound((data[dropPercentForGrade] * specificCoeff.dropCoefficient)));
                            };
                        };
                    };
                };
            };
            return (this.getRound(data[dropPercentForGrade]));
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRelease(target:Object):void
        {
            var contextMenu:Array;
            var pos:Point;
            var data:Object;
            var monster:Monster;
            var text:String;
            var monsterSubAreas:Vector.<uint>;
            var subArea:SubArea;
            var subAreaId:uint;
            var monsterMiniboss:MonsterMiniBoss;
            var monster2:Monster;
            var dropData:Object;
            var minLevel:int;
            var maxLevel:int;
            var index:uint;
            var foundItemWrapper:ItemWrapper;
            switch (target)
            {
                case this.btn_resetSearch:
                    this._searchCriteria = null;
                    this.inp_search.text = "";
                    this.updateMonsterGrid(this.gd_categories.selectedItem);
                    break;
                case this.btn_races:
                    if (this._currentCategoryType != CAT_TYPE_RACE)
                    {
                        this._currentCategoryType = CAT_TYPE_RACE;
                        this.currentTabName = target.name;
                        this.displayCategories(this._lastRaceSelected);
                        this.hintsApi.uiTutoTabLaunch();
                    };
                    break;
                case this.btn_subareas:
                    if (this._currentCategoryType != CAT_TYPE_AREA)
                    {
                        this._currentCategoryType = CAT_TYPE_AREA;
                        this.currentTabName = target.name;
                        this.displayCategories(this._lastAreaSelected);
                        this.hintsApi.uiTutoTabLaunch();
                    };
                    break;
                case this.btn_searchFilter:
                    if (((this.btn_searchFilter.selected) && (!(this._btn_searchFilter_flag))))
                    {
                        contextMenu = [];
                        contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.search.criteria")));
                        contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnName"], this.changeSearchOnName, null, false, null, this._searchOnName, false));
                        contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnDrop"], this.changeSearchOnDrop, null, false, null, this._searchOnDrop, false));
                        pos = (this.btn_searchFilter as Object).localToGlobal(new Point((this.btn_searchFilter.x + this.btn_searchFilter.width), (this.btn_searchFilter.y + this.btn_searchFilter.height)));
                        this.modContextMenu.createContextMenu(contextMenu, pos, this.onContextMenuClose);
                    }
                    else
                    {
                        this.btn_searchFilter.selected = false;
                    };
                    break;
                case this.btn_displayCriteriaDrop:
                    Grimoire.getInstance().bestiaryDisplayCriteriaDrop = this.btn_displayCriteriaDrop.selected;
                    this.updateMonsterGrid(this.gd_categories.selectedItem);
                    break;
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_help:
                    this.hintsApi.showSubHints(this.currentTabName);
                    break;
                default:
                    if (target.name.indexOf("btn_monster") != -1)
                    {
                        if (this.uiApi.keyIsDown(Keyboard.SHIFT))
                        {
                            this.sysApi.dispatchHook(MouseShiftClick, {"data":this._ctrBtnMonster[target.name].monster});
                            break;
                        };
                        data = this._ctrBtnMonster[target.name];
                        if (((!(this._selectedMonsterId == data.monster.id)) || (!(this._selectedMonsterIsScaled == data.scaledMonster))))
                        {
                            this.gd_monsters.selectedItem = data;
                            this._selectedMonsterId = data.monster.id;
                            this._selectedMonsterIsScaled = data.scaledMonster;
                        }
                        else
                        {
                            this._selectedMonsterId = 0;
                            this._selectedMonsterIsScaled = false;
                        };
                        this.updateMonsterGrid(this.gd_categories.selectedItem);
                    }
                    else
                    {
                        if (target.name.indexOf("btn_loc") != -1)
                        {
                            monster = this._ctrBtnMonsterLocation[target.name];
                            text = this.uiApi.processText(this.uiApi.getText("ui.monster.presentInAreas", monster.subareas.length), "m", (monster.subareas.length == 1), (monster.subareas.length == 0));
                            monsterSubAreas = new Vector.<uint>(0);
                            for each (subAreaId in monster.subareas)
                            {
                                subArea = this.dataApi.getSubArea(subAreaId);
                                if (((subArea.hasCustomWorldMap) || (subArea.area.superArea.hasWorldMap)))
                                {
                                    monsterSubAreas.push(subAreaId);
                                };
                            };
                            this._mapPopup = this.modCartography.openCartographyPopup(monster.name, monster.favoriteSubareaId, monsterSubAreas, text);
                        }
                        else
                        {
                            if (target.name.indexOf("btn_linkToMonster") != -1)
                            {
                                monsterMiniboss = this.dataApi.getMonsterMiniBossFromId(this._ctrTxLink[target.name].monsterId);
                                this.onOpenBestiary("bestiaryTab", {
                                    "forceOpen":true,
                                    "monsterId":monsterMiniboss.monsterReplacingId
                                });
                            }
                            else
                            {
                                if (target.name.indexOf("btn_linkToArch") != -1)
                                {
                                    monster2 = this.getMonster(this._ctrTxLink[target.name].monsterId);
                                    this.onOpenBestiary("bestiaryTab", {
                                        "forceOpen":true,
                                        "monsterId":monster2.correspondingMiniBossId
                                    });
                                }
                                else
                                {
                                    if (target.name.indexOf("btn_openEquipmentTab") != -1)
                                    {
                                        if (this._monsterEquipmentDrops.length <= 0)
                                        {
                                            return;
                                        };
                                        dropData = {};
                                        minLevel = 0;
                                        maxLevel = 200;
                                        index = 0;
                                        foundItemWrapper = null;
                                        while (index < this._monsterEquipmentDrops.length)
                                        {
                                            if (this._monsterEquipmentDrops[index].type.categoryId === ItemCategoryEnum.EQUIPMENT_CATEGORY)
                                            {
                                                foundItemWrapper = this._monsterEquipmentDrops[index];
                                                break;
                                            };
                                            index++;
                                        };
                                        if (foundItemWrapper)
                                        {
                                            minLevel = foundItemWrapper.level;
                                            foundItemWrapper = null;
                                        };
                                        index = (this._monsterEquipmentDrops.length - 1);
                                        while (index >= 0)
                                        {
                                            if (this._monsterEquipmentDrops[index].type.categoryId === ItemCategoryEnum.EQUIPMENT_CATEGORY)
                                            {
                                                foundItemWrapper = this._monsterEquipmentDrops[index];
                                                break;
                                            };
                                            index--;
                                        };
                                        if (foundItemWrapper)
                                        {
                                            maxLevel = foundItemWrapper.level;
                                        };
                                        dropData.forceOpenEquipmentTab = true;
                                        dropData.specificSearchData = {
                                            "monsterId":this._selectedAndOpenedMonsterId,
                                            "filterComponent":true,
                                            "filterCraftable":true,
                                            "levelRange":new Point(minLevel, maxLevel)
                                        };
                                        this.sysApi.dispatchHook(OpenEncyclopedia, EnumTab.ENCYCLOPEDIA_EQUIPMENT_TAB, dropData);
                                    };
                                };
                            };
                        };
                    };
            };
        }

        private function filterEquipmentDrops(element:ItemWrapper, index:int, arr:Array):Boolean
        {
            return ((element.isEquipment) && (!(element.typeId == DataEnum.ITEM_TYPE_TROPHY)));
        }

        public function onFocusChange(pTarget:Object):void
        {
            this._btn_searchFilter_flag = false;
        }

        public function onContextMenuClose():void
        {
            this.btn_searchFilter.selected = false;
            this._btn_searchFilter_flag = true;
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            var monster:Monster;
            var incompatibleIdols:String;
            var id:uint;
            var idol:Idol;
            var m:Monster;
            var textId:String;
            var subAreas:Array;
            var subArea:SubArea;
            var s:int;
            var currentMonster:Monster;
            var filteredEquipmentDrop:Array;
            var data:Object;
            var scaledMonster:Monster;
            var baseValue:int;
            var characId:int;
            var scaledValue:int;
            var textValue:String;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            if (target.name.indexOf("tx_boss") != -1)
            {
                text = this.uiApi.getText("ui.item.boss");
            }
            else
            {
                if (target.name.indexOf("tx_archMonster") != -1)
                {
                    text = this.uiApi.getText("ui.item.miniboss");
                }
                else
                {
                    if (target.name.indexOf("tx_questMonster") != -1)
                    {
                        text = this.uiApi.getText("ui.monster.questMonster");
                    }
                    else
                    {
                        if (target.name.indexOf("btn_linkToArch") != -1)
                        {
                            text = this.uiApi.getText("ui.monster.goToArchMonster");
                        }
                        else
                        {
                            if (target.name.indexOf("btn_linkToMonster") != -1)
                            {
                                text = this.uiApi.getText("ui.monster.goToMonster");
                            }
                            else
                            {
                                if (target.name.indexOf("btn_searchFilter") != -1)
                                {
                                    text = this.uiApi.getText("ui.search.criteria");
                                }
                                else
                                {
                                    if (target.name.indexOf("btn_loc") != -1)
                                    {
                                        if ((target as ButtonContainer).softDisabled)
                                        {
                                            return;
                                        };
                                        text = this.uiApi.getText("ui.monster.showAreas");
                                    }
                                    else
                                    {
                                        if (target.name.indexOf("tx_incompatibleIdols") != -1)
                                        {
                                            monster = this.getMonster(this._ctrTxLink[target.name].monsterId);
                                            if (monster.allIdolsDisabled)
                                            {
                                                text = this.uiApi.getText("ui.idol.allIdolsDisabled");
                                            }
                                            else
                                            {
                                                incompatibleIdols = "";
                                                for each (id in monster.incompatibleIdols)
                                                {
                                                    idol = this.dataApi.getIdol(id);
                                                    if (idol)
                                                    {
                                                        incompatibleIdols = (incompatibleIdols + ("\n" + idol.item.name));
                                                    };
                                                };
                                                text = this.uiApi.getText("ui.idol.incompatibleIdols", incompatibleIdols);
                                            };
                                        }
                                        else
                                        {
                                            if (target.name.indexOf("tx_sword") != -1)
                                            {
                                                if (((this.breachApi.isInBreach()) && (this._currentSelectedCatId == -1)))
                                                {
                                                    text = this.uiApi.getText("ui.breach.bestiaryInfo");
                                                }
                                                else
                                                {
                                                    m = this.getMonster(this._ctrTxLink[target.name].monsterId);
                                                    textId = "ui.monster.aggroTooltip";
                                                    subAreas = this.dataApi.getAllSubAreas();
                                                    for each (subArea in subAreas)
                                                    {
                                                        if (((!(subArea.monsters.indexOf(m.id) == -1)) && (!(this.mapApi.isDungeonSubArea(subArea.id) == -1))))
                                                        {
                                                            textId = "ui.monster.aggroTooltipDungeon";
                                                            break;
                                                        };
                                                    };
                                                    s = int((m.aggressiveAttackDelay / 1000));
                                                    text = this.uiApi.processText(this.uiApi.getText(textId, s), "n", (s <= 1), (s == 0));
                                                };
                                            }
                                            else
                                            {
                                                if (target.name.indexOf("btn_openEquipmentTab") != -1)
                                                {
                                                    if (this._monsterEquipmentDrops.length <= 0)
                                                    {
                                                        return;
                                                    };
                                                    currentMonster = this.dataApi.getMonsterFromId(this._ctrSlotDrop[target.name]);
                                                    if (((currentMonster.temporisDrops) && (currentMonster.temporisDrops.length > 0)))
                                                    {
                                                        this._dropTemporisItemResult = this.computeDropPercentage(currentMonster, 0, currentMonster.grades.length, currentMonster.temporisDrops[0]);
                                                    };
                                                    filteredEquipmentDrop = this._monsterEquipmentDrops.filter(this.filterEquipmentDrops);
                                                    text = (("<b>" + this.uiApi.getText("ui.encyclopedia.seeEquipmentInRange", filteredEquipmentDrop[0].level, filteredEquipmentDrop[(filteredEquipmentDrop.length - 1)].level)) + "</b>");
                                                    if (this._dropTemporisItemResult)
                                                    {
                                                        text = (text + ("\n\n" + this.uiApi.getText("ui.monster.obtaining.withBonuses", this.getStringFromValues(this._dropTemporisItemResult.dropMinGrade, this._dropTemporisItemResult.dropMaxGrade))));
                                                        text = (text + ("\n" + this.uiApi.getText("ui.monster.obtaining.base", this.getStringFromValues(this._dropTemporisItemResult.baseDropMinGrade, this._dropTemporisItemResult.baseDropMinGrade))));
                                                    };
                                                }
                                                else
                                                {
                                                    if (target.name.indexOf("lbl_value") != -1)
                                                    {
                                                        data = this._lblValueStat[target.name];
                                                        scaledMonster = this.getMonster(this._selectedMonsterId);
                                                        baseValue = 0;
                                                        for each (characId in data.statIds)
                                                        {
                                                            baseValue = (baseValue + this.luaApi.getGradeStatValueById(scaledMonster, characId));
                                                        };
                                                        scaledValue = data.scaledValue[(data.scaledValue.length - 1)];
                                                        textValue = (baseValue.toString() + (((scaledValue - baseValue) >= 0) ? (" + " + (scaledValue - baseValue)) : (" - " + (scaledValue - baseValue).toString().substr(1))));
                                                        text = this.uiApi.getText("ui.breach.scaleInfo", textValue, scaledMonster.grades[(scaledMonster.scaleGradeRef - 1)].level, this.breachApi.getFloor());
                                                    };
                                                };
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
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onKeyUp(target:Object, keyCode:uint):void
        {
            if (this.inp_search.haveFocus)
            {
                this._lockSearchTimer.reset();
                this._lockSearchTimer.start();
            };
        }

        public function onTimeOut(e:TimerEvent):void
        {
            if (this.inp_search.text.length > 2)
            {
                this._searchCriteria = this.inp_search.text.toLowerCase();
                this._currentScrollValue = 0;
                this._monstersListToDisplay = [];
                this.updateMonsterGrid(this.gd_categories.selectedItem);
            }
            else
            {
                if (this._searchCriteria)
                {
                    this._searchCriteria = null;
                };
                if (this.inp_search.text.length == 0)
                {
                    this.updateMonsterGrid(this.gd_categories.selectedItem);
                };
            };
        }

        private function onCancelSearch():void
        {
            clearTimeout(this._searchSettimoutId);
            if (this._progressPopupName)
            {
                this.uiApi.unloadUi(this._progressPopupName);
                this._progressPopupName = null;
            };
        }

        private function onOpenBestiary(tab:String=null, param:Object=null):void
        {
            var monster:Monster;
            var monsterRace:MonsterRace;
            var raceDPObject:Object;
            var superRace:Object;
            var race:Object;
            var mId:int;
            if ((((tab == "bestiaryTab") && (param)) && (param.forceOpen)))
            {
                this.uiApi.hideTooltip();
                this._monstersListToDisplay = new Array();
                if (param.monsterId)
                {
                    this._selectedMonsterId = param.monsterId;
                    this._forceOpenMonster = true;
                    this._searchCriteria = null;
                    this.inp_search.text = "";
                    monster = this.getMonster(this._selectedMonsterId);
                    this.btn_races.selected = true;
                    this._currentCategoryType = CAT_TYPE_RACE;
                    monsterRace = monster.type;
                    for each (superRace in this._categoriesRace)
                    {
                        if (superRace.realId == monsterRace.superRaceId)
                        {
                            for each (race in superRace.subcats)
                            {
                                if (race.realId == monsterRace.id)
                                {
                                    raceDPObject = race;
                                };
                            };
                        };
                    };
                    this._lastRaceSelected = raceDPObject;
                    this.displayCategories(raceDPObject, true);
                };
                if (param.monsterIdsList)
                {
                    if (param.monsterSearch)
                    {
                        this.inp_search.text = param.monsterSearch;
                        this._searchOnDrop = true;
                        this._searchOnName = false;
                    };
                    for each (mId in param.monsterIdsList)
                    {
                        this._monstersListToDisplay.push(mId);
                    };
                    this.updateMonsterGrid(this.gd_categories.selectedItem);
                };
            };
        }

        private function getStringFromValues(valueA:Number, valueB:Number):String
        {
            if (valueA == valueB)
            {
                return ("" + valueA);
            };
            return ((((("" + valueA) + " ") + this.uiApi.getText("ui.chat.to")) + " ") + valueB);
        }

        private function getRound(value:Number):Number
        {
            var a:Number = (Math.round((value * 1000)) / 1000);
            return (a);
        }

        private function getMonsterEquipmentDrops(monsterId:uint):void
        {
            var drop:MonsterDrop;
            var item:ItemWrapper;
            var currentMonster:Monster = this.dataApi.getMonsterFromId(monsterId);
            this._monsterEquipmentDrops = [];
            for each (drop in currentMonster.temporisDrops)
            {
                item = this.dataApi.getItemWrapper(drop.objectId, 0, 0, 1);
                if (((!(item === null)) && (item.type.categoryId === ItemCategoryEnum.EQUIPMENT_CATEGORY)))
                {
                    this._monsterEquipmentDrops.push(item);
                };
            };
            this._monsterEquipmentDrops.sortOn("level", Array.NUMERIC);
        }


    }
}

