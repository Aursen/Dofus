package com.ankamagames.berilia.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.types.DataStoreType;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.jerakine.handlers.messages.HumanInputMessage;
    import com.ankamagames.berilia.components.messages.SelectItemMessage;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
    import com.ankamagames.berilia.components.ComboBoxGrid;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import com.ankamagames.berilia.Berilia;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.messages.Message;
    import flash.display.DisplayObjectContainer;
    import flash.display.DisplayObject;

    public class UiStatsFrame implements Frame 
    {

        private static var _statsData:Object = new Object();
        private static var _dataStoreType:DataStoreType = new DataStoreType("Berilia_ui_stats2", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT);
        private static const _components:Array = ["login_btn_members", "login_btn_lowa", "login_gd_shop", "login_btn_options", "login_grid_cb_connectiontype", "characterselection_btn_changeserver", "characterheader_btn_subscribe", "characterselection_btn_create", "charactercreation_btn_breedinfo", "charactercreation_btn_previous", "serverlistselection_btn_friendsearch", "serverlistselection_btn_ckboxmy", "bannermap_btn_showentitiestooltips", "bannermap_btn_highlightinteractiveelements", "bannermap_btn_viewfights", "bannermap_btn_showfightpositions"];

        private var _accountServersKey:String;


        public static function get hasStats():Boolean
        {
            var statId:*;
            for (statId in _statsData)
            {
                return (true);
            };
            return (false);
        }

        public static function getStatsData():Object
        {
            return (_statsData);
        }

        public static function setStat(id:String, value:*):void
        {
            _statsData[id] = value;
        }

        public static function clearStats():void
        {
            _statsData = new Object();
        }

        public static function setDateStat(id:String):void
        {
            _statsData[id] = formatDate(new Date());
        }

        public static function formatDate(d:Date):String
        {
            return ((((((((((d.fullYearUTC + "-") + StringUtils.fill((d.monthUTC + 1).toString(), 2, "0")) + "-") + StringUtils.fill(d.dateUTC.toString(), 2, "0")) + "T") + StringUtils.fill(d.hoursUTC.toString(), 2, "0")) + ":") + StringUtils.fill(d.minutesUTC.toString(), 2, "0")) + ":") + StringUtils.fill(d.secondsUTC.toString(), 2, "0"));
        }

        public static function addStat(id:String):void
        {
            if (!_statsData.hasOwnProperty(id))
            {
                _statsData[id] = 1;
            }
            else
            {
                _statsData[id]++;
            };
        }


        public function pushed():Boolean
        {
            return (true);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        public function get priority():int
        {
            return (Priority.LOG);
        }

        public function process(msg:Message):Boolean
        {
            var gc:GraphicContainer;
            var id:String;
            var ui:UiRootContainer;
            var himsg:HumanInputMessage;
            var simsg:SelectItemMessage;
            var numServers:uint;
            var savedNumServers:*;
            var cbDataKey:String;
            var savedValue:*;
            var currentValue:uint;
            var server:*;
            switch (true)
            {
                case (msg is HumanInputMessage):
                    himsg = (msg as HumanInputMessage);
                    gc = this.getGraphicContainer(himsg.target);
                    if (((gc) && (msg is MouseClickMessage)))
                    {
                        ui = gc.getUi();
                        if (ui)
                        {
                            id = ((ui.name + "_") + gc.name).toLowerCase();
                            if (_components.indexOf(id) != -1)
                            {
                                addStat((("ui_" + id) + "_clicked"));
                            };
                        };
                    };
                    break;
                case (msg is SelectItemMessage):
                    simsg = (msg as SelectItemMessage);
                    gc = this.getGraphicContainer(simsg.target);
                    if (gc)
                    {
                        ui = gc.getUi();
                        if (ui)
                        {
                            id = ((ui.name + "_") + gc.name).toLowerCase();
                            if (_components.indexOf(id) != -1)
                            {
                                if ((gc is ComboBoxGrid))
                                {
                                    cbDataKey = (("ui_" + id) + "_value");
                                    savedValue = StoreDataManager.getInstance().getData(_dataStoreType, cbDataKey);
                                    currentValue = (gc as ComboBoxGrid).selectedIndex;
                                    if (savedValue != currentValue)
                                    {
                                        StoreDataManager.getInstance().setData(_dataStoreType, cbDataKey, currentValue);
                                        _statsData[cbDataKey] = currentValue;
                                    };
                                }
                                else
                                {
                                    if (simsg.selectMethod == SelectMethodEnum.CLICK)
                                    {
                                        addStat((("ui_" + id) + "_selected"));
                                    };
                                };
                            };
                        };
                    };
                    break;
                case (!(getQualifiedClassName(msg).indexOf("ChangeServerAction") == -1)):
                    if (Berilia.getInstance().getUi("characterCreation"))
                    {
                        addStat("charactercreation_changeserver");
                    };
                    break;
                case (!(getQualifiedClassName(msg).indexOf("IdentificationSuccessMessage") == -1)):
                    this._accountServersKey = (msg["accountId"] + "_numservers");
                    break;
                case (!(getQualifiedClassName(msg).indexOf("ServersListMessage") == -1)):
                    for each (server in msg["servers"])
                    {
                        if (server.charactersCount > 0)
                        {
                            numServers++;
                        };
                    };
                    savedNumServers = StoreDataManager.getInstance().getData(_dataStoreType, this._accountServersKey);
                    if (((!(savedNumServers)) || (!(numServers == parseInt(savedNumServers)))))
                    {
                        StoreDataManager.getInstance().setData(_dataStoreType, this._accountServersKey, numServers);
                        _statsData[this._accountServersKey] = numServers;
                    };
                    break;
            };
            return (false);
        }

        private function getGraphicContainer(target:DisplayObject):GraphicContainer
        {
            var p:DisplayObjectContainer;
            if ((target is GraphicContainer))
            {
                return (target as GraphicContainer);
            };
            if (target)
            {
                p = target.parent;
                while (p)
                {
                    if ((p is GraphicContainer))
                    {
                        return (p as GraphicContainer);
                    };
                    p = p.parent;
                };
            };
            return (null);
        }


    }
}

