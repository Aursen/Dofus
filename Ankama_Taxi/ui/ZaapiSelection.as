package Ankama_Taxi.ui
{
    import com.ankamagames.berilia.types.graphic.ButtonContainer;

    public class ZaapiSelection extends ZaapSelection 
    {


        override public function main(params:Array):void
        {
            lbl_btn_tab1.text = uiApi.getText("ui.map.craftHouse");
            lbl_btn_tab2.text = uiApi.getText("ui.map.bidHouse");
            lbl_btn_tab3.text = uiApi.getText("ui.common.misc");
            lbl_title.text = uiApi.getText("ui.zaap.zaapi");
            lbl_noDestination.visible = false;
            super.main(params);
            btn_showUnknowZaap.visible = false;
            tx_currentRespawn.visible = false;
            btn_save.visible = false;
            if (btn_tab1.selected)
            {
                currentTabName = "workshop";
            }
            else
            {
                if (btn_tab2.selected)
                {
                    currentTabName = "shop";
                }
                else
                {
                    currentTabName = "others";
                };
            };
        }

        override protected function changeZaapTab(target:ButtonContainer):void
        {
            var tabList:Array;
            super.changeZaapTab(btn_tab1);
            btn_save.visible = false;
            switch (target)
            {
                case btn_tab1:
                    currentTabName = "workshop";
                    tabList = _tab1List;
                    break;
                case btn_tab2:
                    currentTabName = "shop";
                    tabList = _tab2List;
                    break;
                case btn_tab3:
                    currentTabName = "others";
                    tabList = _tab3List;
                    break;
            };
            gd_zaap.dataProvider = sortZaap(tabList, _currentSortCriteria);
            _currentdataProvider = tabList;
        }

        override public function onZaapList(zaapList:Object):void
        {
            var i:String;
            _tab1List = [];
            _tab2List = [];
            _tab3List = [];
            _fullZaapList = [];
            for (i in zaapList)
            {
                _fullZaapList.push(zaapList[i]);
                if (zaapList[i].mapId == playerApi.currentMap().mapId)
                {
                    _currentZaapName = zaapList[i].name;
                    lbl_title.text = ((uiApi.getText("ui.zaap.zaapi") + " ") + zaapList[i].subArea.name);
                }
                else
                {
                    if (zaapList[i].category == 3)
                    {
                        _tab1List.push(zaapList[i]);
                    }
                    else
                    {
                        if (zaapList[i].category == 2)
                        {
                            _tab2List.push(zaapList[i]);
                        }
                        else
                        {
                            _tab3List.push(zaapList[i]);
                        };
                    };
                };
            };
            if (((_favoriteZaap) && (!(_favoriteZaap.indexOf(_currentZaapName) == -1))))
            {
                tx_fav.uri = _uriYellowStar;
            }
            else
            {
                tx_fav.uri = _uriEmptyStar;
            };
            if (_tab1List.length == 0)
            {
                btn_tab1.disabled = true;
            }
            else
            {
                _tab1List = sortZaap(_tab1List, "name");
            };
            if (_tab2List.length == 0)
            {
                btn_tab2.disabled = true;
            }
            else
            {
                btn_tab2.disabled = false;
                _tab2List = sortZaap(_tab2List, "name");
            };
            if (_tab3List.length == 0)
            {
                btn_tab3.disabled = true;
            }
            else
            {
                btn_tab3.disabled = false;
                _tab3List = sortZaap(_tab3List, "name");
            };
            if (!btn_tab1.disabled)
            {
                uiApi.setRadioGroupSelectedItem("tabHGroup", btn_tab1, uiApi.me());
                btn_tab1.selected = true;
                gd_zaap.dataProvider = _tab1List;
                _currentdataProvider = _tab1List;
                currentTabName = "workshop";
            }
            else
            {
                if (!btn_tab2.disabled)
                {
                    uiApi.setRadioGroupSelectedItem("tabHGroup", btn_tab2, uiApi.me());
                    btn_tab2.selected = true;
                    gd_zaap.dataProvider = _tab2List;
                    _currentdataProvider = _tab2List;
                    currentTabName = "shop";
                }
                else
                {
                    if (!btn_tab3.disabled)
                    {
                        uiApi.setRadioGroupSelectedItem("tabHGroup", btn_tab3, uiApi.me());
                        btn_tab3.selected = true;
                        gd_zaap.dataProvider = _tab3List;
                        _currentdataProvider = _tab3List;
                        currentTabName = "others";
                    };
                };
            };
        }


    }
} Ankama_Taxi.ui

