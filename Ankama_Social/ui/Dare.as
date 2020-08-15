package Ankama_Social.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.dofus.uiApi.UiTutoApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import d2hooks.OpenDareSearch;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import d2actions.DareListRequest;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import d2hooks.*;
    import d2actions.*;

    public class Dare 
    {

        private static var _self:Dare;

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        [Api(name="UiTutoApi")]
        public var hintsApi:UiTutoApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        private var _nCurrentTab:int = -1;
        public var searchFilterStates:Dictionary;
        public var mainCtr:GraphicContainer;
        public var btn_creation:ButtonContainer;
        public var btn_totalList:ButtonContainer;
        public var btn_mineList:ButtonContainer;
        public var btn_successList:ButtonContainer;


        public static function getInstance():Dare
        {
            return (_self);
        }


        public function main(... args):void
        {
            this.sysApi.addHook(OpenDareSearch, this.onOpenDareSearch);
            this.searchFilterStates = new Dictionary(true);
            this.searchFilterStates[DareList.SEARCH_FILTER_ID] = true;
            this.searchFilterStates[DareList.SEARCH_FILTER_CREATOR] = true;
            this.searchFilterStates[DareList.SEARCH_FILTER_MONSTER] = true;
            this.searchFilterStates[DareList.SEARCH_FILTER_CRITERIA] = true;
            this.searchFilterStates[DareList.SEARCH_FILTER_SUBAREA] = true;
            this.searchFilterStates[DareList.SEARCH_FILTER_GUILD] = true;
            this.searchFilterStates[DareList.SEARCH_FILTER_ALLIANCE] = true;
            this.btn_totalList.soundId = SoundEnum.TAB;
            this.btn_creation.soundId = SoundEnum.TAB;
            this.btn_mineList.soundId = SoundEnum.TAB;
            this.btn_successList.soundId = SoundEnum.TAB;
            _self = this;
            this.openSelectedTab(args[0][0], args[0][1]);
        }

        public function unload():void
        {
            this.uiApi.hideTooltip();
            this.uiApi.unloadUi("subDareUi");
            _self = null;
        }

        public function get currentTab():int
        {
            return (this._nCurrentTab);
        }

        public function openSelectedTab(tab:uint, params:Object=null):void
        {
            if (this._nCurrentTab == tab)
            {
                return;
            };
            var tabUiName:String = this.getUiNameByTab(tab);
            if (tabUiName == this.getUiNameByTab(this._nCurrentTab))
            {
                this.sysApi.log(2, ("Rechargement de la liste en mode " + tab));
                this.sysApi.sendAction(new DareListRequest());
            }
            else
            {
                this.uiApi.unloadUi("subDareUi");
                (this.uiApi.loadUiInside(tabUiName, this.mainCtr, "subDareUi", [tab, params]) as UiRootContainer);
                if (tabUiName == "dareList")
                {
                    this.sysApi.sendAction(new DareListRequest());
                };
            };
            this.getButtonByTab(tab).selected = true;
            this._nCurrentTab = tab;
            this.uiApi.getUi("socialBase").uiClass.setSubTab(this._nCurrentTab);
        }

        private function getUiNameByTab(tab:int):String
        {
            if (tab == 0)
            {
                return ("dareList");
            };
            if (tab == 1)
            {
                return ("dareCreation");
            };
            if (tab == 2)
            {
                return ("dareList");
            };
            if (tab == 3)
            {
                return ("dareList");
            };
            return (null);
        }

        private function getButtonByTab(tab:uint):Object
        {
            if (tab == 0)
            {
                return (this.btn_totalList);
            };
            if (tab == 1)
            {
                return (this.btn_creation);
            };
            if (tab == 2)
            {
                return (this.btn_mineList);
            };
            if (tab == 3)
            {
                return (this.btn_successList);
            };
            return (null);
        }

        public function selectWhichTabHintsToDisplay():void
        {
            this.uiApi.me().childUiRoot.uiClass.showTabHints();
        }

        public function onRelease(target:Object):void
        {
            if (target == this.btn_totalList)
            {
                this.openSelectedTab(0);
            }
            else
            {
                if (target == this.btn_creation)
                {
                    this.openSelectedTab(1);
                }
                else
                {
                    if (target == this.btn_mineList)
                    {
                        this.openSelectedTab(2);
                    }
                    else
                    {
                        if (target == this.btn_successList)
                        {
                            this.openSelectedTab(3);
                        };
                    };
                };
            };
        }

        public function onOpenDareSearch(search:String, filter:String=null, forceRefresh:Boolean=true):void
        {
            if (this._nCurrentTab != 1)
            {
                return;
            };
            this.openSelectedTab(0, [search, filter]);
        }


    }
}

