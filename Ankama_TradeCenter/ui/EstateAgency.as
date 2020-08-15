package Ankama_TradeCenter.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.JobsApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.ComboBox;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.TextureBitmap;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import d2hooks.EstateToSellList;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import d2actions.LeaveDialogRequest;
    import com.ankamagames.berilia.components.Texture;
    import d2actions.HouseToSellListRequest;
    import d2actions.PaddockToSellListRequest;
    import d2actions.HouseToSellFilter;
    import d2actions.PaddockToSellFilter;

    public class EstateAgency 
    {

        public var output:Object;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="JobsApi")]
        public var jobsApi:JobsApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        private var _currentPage:uint;
        private var _maxPage:uint;
        private var _estates:Array;
        private var _estateType:uint = 2;
        private var _housesAreas:Array = new Array();
        private var _paddocksAreas:Array = new Array();
        private var _skills:Array = new Array();
        private var _houseFilters:Array = new Array();
        private var _paddockFilters:Array = new Array();
        private var _aAtLeastNbRoom:Array;
        private var _aAtLeastNbChest:Array;
        private var _aSkillRequested:Array;
        private var _aAtLeastNbMount:Array;
        private var _aAtLeastNbMachine:Array;
        private var _aHousesAreaRequested:Array;
        private var _aPaddocksAreaRequested:Array;
        public var windowCtr:GraphicContainer;
        public var listCtr:Object;
        public var filterCtr:Object;
        public var typeCtr:GraphicContainer;
        public var gd_estates:Object;
        public var cb_estateType:ComboBox;
        public var cb_filterRoomMount:ComboBox;
        public var cb_filterChestMachine:ComboBox;
        public var cb_filterSubarea:ComboBox;
        public var cb_filterSkill:ComboBox;
        public var btn_tabCost:Object;
        public var btn_prevPage:Object;
        public var btn_nextPage:Object;
        public var btn_filter:Object;
        public var btn_close:Object;
        public var lbl_page:Object;
        public var lbl_type:Label;
        public var inp_filterMaxPrice:Object;
        public var bgcb_estateType:TextureBitmap;
        public var bgcb_filterSkill:TextureBitmap;
        private var tx_kamasList:Dictionary = new Dictionary();


        public function main(args:Object):void
        {
            this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_OPEN);
            this.sysApi.addHook(EstateToSellList, this.onEstateToSellList);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortCut);
            this.uiApi.addComponentHook(this.cb_estateType, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.cb_filterRoomMount, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.cb_filterChestMachine, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.cb_filterSubarea, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.cb_filterSkill, ComponentHookList.ON_SELECT_ITEM);
            this._estateType = args.type;
            this.alignTypeCtr();
            this.inp_filterMaxPrice.restrict = "0-9";
            this.inp_filterMaxPrice.numberMax = ProtocolConstantsEnum.MAX_KAMA;
            var labelsEstate:Array = new Array(this.uiApi.getText("ui.common.housesWord"), this.uiApi.getText("ui.common.mountPark"));
            this.cb_estateType.dataProvider = labelsEstate;
            this.cb_estateType.selectedIndex = this._estateType;
            this.initFilters();
            this.onEstateToSellList(args.list, args.index, args.total, this._estateType);
        }

        public function unload():void
        {
            this.uiApi.unloadUi("estateForm");
            this.sysApi.sendAction(new LeaveDialogRequest());
            this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_CLOSE);
        }

        public function updateEstateLine(data:*, components:*, selected:Boolean):void
        {
            var tx_kamas:Texture;
            if (data)
            {
                components.lbl_name.text = (((("{estate," + data.index) + "::") + data.name) + "}");
                components.lbl_loc.text = data.area;
                components.lbl_cost.text = this.utilApi.kamasToString(data.price, "");
                tx_kamas = this.tx_kamasList[components.lbl_cost];
                if (!tx_kamas)
                {
                    tx_kamas = (this.uiApi.createComponent("Texture") as Texture);
                    tx_kamas.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "icon_kama.png"));
                    tx_kamas.finalize();
                    this.tx_kamasList[components.lbl_cost] = tx_kamas;
                };
                tx_kamas.x = ((components.lbl_cost.x + components.lbl_cost.textWidth) + 10);
                tx_kamas.y = (components.lbl_cost.y + 4);
                components.estateCtr.addContent(tx_kamas);
            }
            else
            {
                components.lbl_name.text = "";
                components.lbl_loc.text = "";
                components.lbl_cost.text = "";
                if (this.tx_kamasList[components.lbl_cost])
                {
                    this.tx_kamasList[components.lbl_cost].removeFromParent();
                };
            };
        }

        private function initFilters():void
        {
            var skill:*;
            var skillName:*;
            var area:*;
            var areaName:*;
            var areap:*;
            var areaNamep:*;
            this._aAtLeastNbRoom = new Array(this.uiApi.getText("ui.estate.filter.atLeastNbRoom"), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbRoom", "2"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbRoom", "3"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbRoom", "4"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbRoom", "5"), "m", false));
            this._aAtLeastNbChest = new Array(this.uiApi.getText("ui.estate.filter.atLeastNbChest"), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbChest", "2"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbChest", "3"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbChest", "4"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbChest", "5"), "m", false));
            this._aSkillRequested = new Array(this.uiApi.getText("ui.estate.filter.skillRequested"));
            for each (skill in this.dataApi.getHouseSkills())
            {
                this._skills.push(skill);
            };
            this._skills.sortOn("name");
            for each (skillName in this._skills)
            {
                this._aSkillRequested.push(skillName.name);
            };
            this._aAtLeastNbMount = new Array(this.uiApi.getText("ui.estate.filter.atLeastNbMount"), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMount", "5"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMount", "10"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMount", "15"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMount", "20"), "m", false));
            this._aAtLeastNbMachine = new Array(this.uiApi.getText("ui.estate.filter.atLeastNbMachine"), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMachine", "5"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMachine", "10"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMachine", "15"), "m", false), this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMachine", "20"), "m", false));
            this._aHousesAreaRequested = new Array(this.uiApi.getText("ui.estate.filter.areaRequested"));
            for each (area in this.dataApi.getAllArea(true))
            {
                this._housesAreas.push(area);
            };
            this._housesAreas.sortOn("name");
            for each (areaName in this._housesAreas)
            {
                this._aHousesAreaRequested.push(areaName.name);
            };
            this._aPaddocksAreaRequested = new Array(this.uiApi.getText("ui.estate.filter.areaRequested"));
            for each (areap in this.dataApi.getAllArea(false, true))
            {
                this._paddocksAreas.push(areap);
            };
            this._paddocksAreas.sortOn("name");
            for each (areaNamep in this._paddocksAreas)
            {
                this._aPaddocksAreaRequested.push(areaNamep.name);
            };
            this._houseFilters = [0, 0, 0, 0, 0, 0];
            this._paddockFilters = [0, 0, 0, 0, 0, 0];
            this.updateFilters();
        }

        private function updateFilters():void
        {
            if (this._estateType == 0)
            {
                this.cb_filterSubarea.dataProvider = this._aHousesAreaRequested;
                this.cb_filterRoomMount.dataProvider = this._aAtLeastNbRoom;
                this.cb_filterChestMachine.dataProvider = this._aAtLeastNbChest;
                this.cb_filterSkill.dataProvider = this._aSkillRequested;
                this.cb_filterSkill.visible = (this.bgcb_filterSkill.visible = true);
                this.cb_filterChestMachine.selectedIndex = this._houseFilters[0];
                this.cb_filterRoomMount.selectedIndex = this._houseFilters[1];
                this.cb_filterSkill.selectedIndex = this._houseFilters[2];
                this.cb_filterSubarea.selectedIndex = this._houseFilters[3];
                this.inp_filterMaxPrice.text = ((this._houseFilters[4] == 0) ? "" : this._houseFilters[4]);
            }
            else
            {
                if (this._estateType == 1)
                {
                    this.cb_filterSubarea.dataProvider = this._aPaddocksAreaRequested;
                    this.cb_filterRoomMount.dataProvider = this._aAtLeastNbMount;
                    this.cb_filterChestMachine.dataProvider = this._aAtLeastNbMachine;
                    this.cb_filterSkill.visible = (this.bgcb_filterSkill.visible = false);
                    this.cb_filterChestMachine.selectedIndex = this._paddockFilters[0];
                    this.cb_filterRoomMount.selectedIndex = this._paddockFilters[1];
                    this.cb_filterSubarea.selectedIndex = this._paddockFilters[3];
                    this.inp_filterMaxPrice.text = ((this._paddockFilters[4] == 0) ? "" : this._paddockFilters[4]);
                };
            };
        }

        private function alignTypeCtr():void
        {
            this.lbl_type.fullWidthAndHeight();
            this.bgcb_estateType.x = (this.lbl_type.x + this.lbl_type.width);
            this.typeCtr.x = (((this.windowCtr.width / 2) - ((this.lbl_type.width + this.bgcb_estateType.width) / 2)) - 20);
        }

        public function onEstateToSellList(list:Object, pageIndex:uint, totalPage:uint, _arg_4:uint=0):void
        {
            var estates:Array = new Array();
            var i:int;
            while (i < list.length)
            {
                estates.push({
                    "index":i,
                    "name":list[i].name,
                    "area":list[i].area,
                    "price":list[i].price
                });
                i++;
            };
            this.gd_estates.dataProvider = estates;
            this._currentPage = pageIndex;
            this._maxPage = Math.max(totalPage, 1);
            this.lbl_page.text = ((pageIndex + "/") + this._maxPage);
            if (pageIndex == 1)
            {
                this.btn_prevPage.visible = false;
            }
            else
            {
                this.btn_prevPage.visible = true;
            };
            if (pageIndex == this._maxPage)
            {
                this.btn_nextPage.visible = false;
            }
            else
            {
                this.btn_nextPage.visible = true;
            };
            if (_arg_4 != this._estateType)
            {
                this._estateType = _arg_4;
                this.updateFilters();
            };
        }

        public function onRelease(target:Object):void
        {
            var filter:Array;
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_filter:
                    this.requestData(1);
                    break;
                case this.btn_nextPage:
                    if ((this._currentPage + 1) <= this._maxPage)
                    {
                        if (!this._estateType)
                        {
                            this.sysApi.sendAction(new HouseToSellListRequest(++this._currentPage));
                        }
                        else
                        {
                            this.sysApi.sendAction(new PaddockToSellListRequest(++this._currentPage));
                        };
                    };
                    break;
                case this.btn_prevPage:
                    if ((this._currentPage - 1) >= 0)
                    {
                        if (!this._estateType)
                        {
                            this.sysApi.sendAction(new HouseToSellListRequest(--this._currentPage));
                        }
                        else
                        {
                            this.sysApi.sendAction(new PaddockToSellListRequest(--this._currentPage));
                        };
                    };
                    break;
                case this.btn_tabCost:
                    filter = ((this._estateType) ? this._paddockFilters : this._houseFilters);
                    filter[5] = ((filter[5] == 0) ? 1 : 0);
                    this.requestData(this._currentPage);
                    break;
            };
        }

        private function requestData(page:uint):void
        {
            var area:Object;
            var skillId:int;
            var skill:*;
            var areaId:int = -1;
            if (!this._estateType)
            {
                for each (area in this._housesAreas)
                {
                    if (area.name == this.cb_filterSubarea.value)
                    {
                        areaId = area.id;
                    };
                };
                skillId = 0;
                for each (skill in this._skills)
                {
                    if (skill.name == this.cb_filterSkill.value)
                    {
                        skillId = skill.id;
                    };
                };
                this._houseFilters[0] = (this.cb_filterChestMachine.selectedIndex + 1);
                this._houseFilters[1] = (this.cb_filterRoomMount.selectedIndex + 1);
                this._houseFilters[2] = this.cb_filterSkill.selectedIndex;
                this._houseFilters[3] = this.cb_filterSubarea.selectedIndex;
                this._houseFilters[4] = 0;
                if (this.inp_filterMaxPrice.text != "")
                {
                    this._houseFilters[4] = this.utilApi.stringToKamas(this.inp_filterMaxPrice.text);
                };
                this.sysApi.sendAction(new HouseToSellFilter(areaId, this._houseFilters[1], this._houseFilters[0], skillId, this._houseFilters[4], this._houseFilters[5]));
                this.sysApi.sendAction(new HouseToSellListRequest(page));
            }
            else
            {
                for each (area in this._paddocksAreas)
                {
                    if (area.name == this.cb_filterSubarea.value)
                    {
                        areaId = area.id;
                    };
                };
                this._paddockFilters[0] = this.cb_filterChestMachine.selectedIndex;
                this._paddockFilters[1] = this.cb_filterRoomMount.selectedIndex;
                this._paddockFilters[3] = this.cb_filterSubarea.selectedIndex;
                this._paddockFilters[4] = 0;
                if (this.inp_filterMaxPrice.text != "")
                {
                    this._paddockFilters[4] = this.utilApi.stringToKamas(this.inp_filterMaxPrice.text);
                };
                this.sysApi.sendAction(new PaddockToSellFilter(areaId, (this._paddockFilters[1] * 5), (this._paddockFilters[0] * 5), this._paddockFilters[4], this._paddockFilters[5]));
                this.sysApi.sendAction(new PaddockToSellListRequest(page));
            };
        }

        public function onRollOver(target:Object):void
        {
        }

        public function onRollOut(target:Object):void
        {
        }

        private function onShortCut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                return (true);
            };
            return (false);
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (selectMethod != 7)
            {
                switch (target)
                {
                    case this.cb_estateType:
                        if (!this.cb_estateType.selectedIndex)
                        {
                            this.sysApi.sendAction(new HouseToSellListRequest(1));
                        }
                        else
                        {
                            this.sysApi.sendAction(new PaddockToSellListRequest(1));
                        };
                        break;
                    case this.cb_filterRoomMount:
                        break;
                    case this.cb_filterChestMachine:
                        break;
                    case this.cb_filterSubarea:
                        break;
                    case this.cb_filterSkill:
                        break;
                };
            };
        }


    }
}

