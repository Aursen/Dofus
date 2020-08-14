package Ankama_Connection.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.ConnectionApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import d2hooks.ServersList;
    import d2hooks.SelectedServerRefused;
    import d2hooks.ServerConnectionStarted;
    import d2hooks.AcquaintanceSearchError;
    import d2hooks.AcquaintanceServerList;
    import d2hooks.QueueStatus;
    import d2enums.ComponentHookList;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
    import d2actions.ServerSelection;
    import com.ankamagames.dofus.network.enums.ServerStatusEnum;
    import com.ankamagames.dofus.datacenter.servers.Server;
    import com.ankamagames.dofus.datacenter.servers.ServerGameType;
    import d2actions.AcquaintanceSearch;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import flash.utils.getTimer;
    import d2actions.ResetGame;
    import d2hooks.*;
    import d2actions.*;

    public class ServerListSelection 
    {

        public var output:Object;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="ConnectionApi")]
        public var connecApi:ConnectionApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        private var INPUT_SEARCH_DEFAULT_TEXT:String;
        private var _currentServer:Object;
        private var _serverInfo:Object;
        private var _aServers:Array;
        private var _aMyCommuServers:Array;
        private var _aMyServers:Array;
        private var _serversForDataProvider:Array;
        private var _waitingForServer:int = -1;
        private var _sortName:String = "charactersCount";
        private var _sortParam:uint = (Array.NUMERIC | Array.DESCENDING);
        private var _bReload:Boolean = false;
        private var _flagUri:String;
        private var _illusUri:String;
        private var _popupName:String;
        private var _popupInUse:int = 0;
        private var _lockSearchTimer:Timer;
        private var _clockStart:Number;
        private var _aFriendServers:Array;
        private var _modeAutochoice:Boolean = false;
        private var _gridComponentsList:Dictionary = new Dictionary(true);
        public var gd_listServer:Grid;
        public var inp_search:Input;
        public var btn_friendSearch:ButtonContainer;
        public var btn_closeSearch:ButtonContainer;
        public var btn_ckboxMy:ButtonContainer;
        public var btn_tabCountry:ButtonContainer;
        public var btn_tabName:ButtonContainer;
        public var btn_tabState:ButtonContainer;
        public var btn_tabPopulation:ButtonContainer;
        public var btn_tabCharCount:ButtonContainer;
        public var btn_validate:ButtonContainer;
        public var btn_autochoice:ButtonContainer;


        public function main(param:Object=null):void
        {
            this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
            this.soundApi.switchIntroMusic();
            this.btn_autochoice.soundId = SoundEnum.CANCEL_BUTTON;
            this.btn_validate.soundId = "-1";
            this.sysApi.addHook(ServersList, this.onServersList);
            this.sysApi.addHook(SelectedServerRefused, this.onSelectedServerRefused);
            this.sysApi.addHook(ServerConnectionStarted, this.onServerConnectionStarted);
            this.sysApi.addHook(AcquaintanceSearchError, this.onAcquaintanceSearchError);
            this.sysApi.addHook(AcquaintanceServerList, this.onAcquaintanceServerList);
            this.sysApi.addHook(QueueStatus, this.onQueueStatus);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addComponentHook(this.inp_search, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.inp_search, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.inp_search, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_validate, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_validate, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.gd_listServer, ComponentHookList.ON_SELECT_ITEM);
            this.inp_search.maxChars = 300;
            this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.sersel.findFriend");
            this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
            this._flagUri = this.uiApi.me().getConstant("flag_uri");
            this._illusUri = this.uiApi.me().getConstant("illus_uri");
            this.btn_ckboxMy.selected = this.sysApi.getData("serverListFilterMyServers", DataStoreEnum.BIND_ACCOUNT);
            if ((((param) && (param.servers)) && (param.servers.length > 0)))
            {
                this.onServersList(param.servers);
            }
            else
            {
                this.onServersList(this.connecApi.getServers());
            };
            this.gd_listServer.focus();
        }

        public function unload():void
        {
            this.uiApi.unloadUi(this._popupName);
            this.sysApi.removeEventListener(this.onEnterFrame);
        }

        public function updateServerLine(data:*, componentsRef:*, selected:Boolean):void
        {
            var now:Date;
            var firstWeekendStart:Date;
            var firstWeekendEnd:Date;
            var secondWeekendStart:Date;
            var secondWeekendEnd:Date;
            var coloredCssClass:String;
            if (!this._gridComponentsList[componentsRef.ctr_bgType.name])
            {
                this.uiApi.addComponentHook(componentsRef.ctr_bgType, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.ctr_bgType, ComponentHookList.ON_ROLL_OUT);
            };
            this._gridComponentsList[componentsRef.ctr_bgType.name] = data;
            if (!this._gridComponentsList[componentsRef.lbl_infoType.name])
            {
                this.uiApi.addComponentHook(componentsRef.lbl_infoType, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.lbl_infoType, ComponentHookList.ON_ROLL_OUT);
            };
            this._gridComponentsList[componentsRef.lbl_infoType.name] = data;
            if (!this._gridComponentsList[componentsRef.tx_typeRules.name])
            {
                this.uiApi.addComponentHook(componentsRef.tx_typeRules, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.tx_typeRules, ComponentHookList.ON_ROLL_OUT);
            };
            this._gridComponentsList[componentsRef.tx_typeRules.name] = data;
            if (!this._gridComponentsList[componentsRef.tx_flag.name])
            {
                this.uiApi.addComponentHook(componentsRef.tx_flag, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.tx_flag, ComponentHookList.ON_ROLL_OUT);
            };
            this._gridComponentsList[componentsRef.tx_flag.name] = data;
            if (!this._gridComponentsList[componentsRef.lbl_infoName.name])
            {
                this.uiApi.addComponentHook(componentsRef.lbl_infoName, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.lbl_infoName, ComponentHookList.ON_ROLL_OUT);
            };
            this._gridComponentsList[componentsRef.lbl_infoName.name] = data;
            if (!this._gridComponentsList[componentsRef.lbl_charaCount.name])
            {
                this.uiApi.addComponentHook(componentsRef.lbl_charaCount, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.lbl_charaCount, ComponentHookList.ON_ROLL_OUT);
            };
            this._gridComponentsList[componentsRef.lbl_charaCount.name] = data;
            if (!this._gridComponentsList[componentsRef.tx_waitingIllu.name])
            {
                this.uiApi.addComponentHook(componentsRef.tx_waitingIllu, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(componentsRef.tx_waitingIllu, ComponentHookList.ON_ROLL_OUT);
            };
            this._gridComponentsList[componentsRef.tx_waitingIllu.name] = data;
            if (data)
            {
                if (data.id == 0)
                {
                    if (data.type.id != GameServerTypeEnum.SERVER_TYPE_KOLIZEUM)
                    {
                        componentsRef.tx_bgType.uri = this.uiApi.createUri((((this._illusUri + "tx_serverGameType") + data.type.id) + ".png"));
                        componentsRef.ctr_bgType.bgColor = this.sysApi.getConfigEntry(("colors.gameserver.type" + data.type.id));
                    }
                    else
                    {
                        componentsRef.tx_bgType.uri = this.uiApi.createUri((this._illusUri + "tx_serverGameType0.png"));
                        componentsRef.ctr_bgType.bgColor = this.sysApi.getConfigEntry("colors.gameserver.type0");
                    };
                    componentsRef.lbl_infoType.text = data.type.name;
                    componentsRef.tx_typeRules.x = ((componentsRef.lbl_infoType.x + componentsRef.lbl_infoType.textWidth) + 12);
                    componentsRef.tx_typeRules.y = 14;
                    componentsRef.lbl_seasonal.x = ((componentsRef.tx_typeRules.x + componentsRef.tx_typeRules.width) + 12);
                    componentsRef.lbl_seasonal.y = (componentsRef.lbl_infoType.y + 3);
                    componentsRef.lbl_infoType.visible = true;
                    componentsRef.ctr_bgType.visible = true;
                    componentsRef.tx_typeRules.visible = true;
                    componentsRef.tx_bgType.visible = true;
                    componentsRef.tx_gradientDecoType.visible = true;
                    componentsRef.lbl_monoAccount.text = "";
                    if (data.type.id == GameServerTypeEnum.SERVER_TYPE_TEMPORIS)
                    {
                        componentsRef.lbl_seasonal.text = this.uiApi.getText("ui.server.temporaryServer");
                    }
                    else
                    {
                        componentsRef.lbl_seasonal.text = "";
                    };
                    componentsRef.tx_infoState.uri = null;
                    componentsRef.lbl_infoState.text = "";
                    componentsRef.lbl_infoName.text = "";
                    componentsRef.lbl_charaCount.cssClass = "extrawhitebigcondensedboldcenter";
                    componentsRef.lbl_charaCount.text = (((data.charactersCount + data.monoAccountCharactersCount) + " / ") + (data.charactersSlots + data.monoAccountCharactersSlots));
                    componentsRef.lbl_infoPopulation.text = "";
                    componentsRef.tx_flag.uri = null;
                    componentsRef.tx_waitingIllu.visible = false;
                    componentsRef.btn_server.selected = false;
                }
                else
                {
                    componentsRef.tx_waitingIllu.visible = (this._waitingForServer == data.id);
                    if (!data.server)
                    {
                        componentsRef.tx_flag.uri = null;
                        componentsRef.lbl_monoAccount.text = "";
                        componentsRef.lbl_seasonal.text = "";
                        componentsRef.tx_infoState.uri = null;
                        componentsRef.lbl_infoState.text = "";
                        componentsRef.lbl_infoName.text = "?";
                        componentsRef.lbl_charaCount.text = "?";
                        componentsRef.lbl_infoPopulation.text = "?";
                    }
                    else
                    {
                        componentsRef.lbl_infoName.text = data.name;
                        if (((data.id > 217) && (data.id < 222)))
                        {
                            now = new Date();
                            firstWeekendStart = new Date(Date.UTC(2017, 9, 27, 12));
                            firstWeekendEnd = new Date(Date.UTC(2017, 9, 30, 8));
                            secondWeekendStart = new Date(Date.UTC(2017, 10, 3, 13));
                            secondWeekendEnd = new Date(Date.UTC(2017, 10, 6, 8));
                            if ((((now.getTime() > firstWeekendStart.getTime()) && (now.getTime() < firstWeekendEnd.getTime())) || ((now.getTime() > secondWeekendStart.getTime()) && (now.getTime() < secondWeekendEnd.getTime()))))
                            {
                                componentsRef.lbl_infoName.text = (componentsRef.lbl_infoName.text + ((" (" + this.uiApi.getText("ui.craft.free")) + ")"));
                            };
                        };
                        if (this.sysApi.getPlayerManager().hasRights)
                        {
                            componentsRef.lbl_infoName.text = (componentsRef.lbl_infoName.text + ((" (" + data.id) + ")"));
                        };
                        componentsRef.tx_infoState.uri = this.uiApi.createUri(this.uiApi.me().getConstant(("statusIcon_" + data.status)));
                        componentsRef.lbl_infoState.text = this.uiApi.me().getConstant(("status_" + data.status));
                        if (data.monoAccount)
                        {
                            componentsRef.lbl_monoAccount.text = this.uiApi.getText("ui.server.monoaccount");
                        }
                        else
                        {
                            componentsRef.lbl_monoAccount.text = "";
                        };
                        componentsRef.lbl_seasonal.text = "";
                        componentsRef.lbl_charaCount.cssClass = "center";
                        componentsRef.lbl_charaCount.text = ((data.charactersCount == 0) ? "" : data.charactersCount);
                        if (data.completion >= 0)
                        {
                            coloredCssClass = "p";
                            switch (data.completion)
                            {
                                case 0:
                                    coloredCssClass = "truegreen";
                                    break;
                                case 1:
                                    coloredCssClass = "yellow";
                                    break;
                                case 2:
                                case 4:
                                    coloredCssClass = "orange";
                                    break;
                                case 3:
                                    coloredCssClass = "red";
                                    break;
                            };
                            componentsRef.lbl_infoPopulation.cssClass = coloredCssClass;
                            componentsRef.lbl_infoPopulation.text = data.server.population.name;
                        }
                        else
                        {
                            componentsRef.lbl_infoPopulation.cssClass = "p";
                            componentsRef.lbl_infoPopulation.text = "?";
                        };
                        componentsRef.tx_flag.uri = this.uiApi.createUri((((this._flagUri + "flag_") + data.community.toString()) + ".png"));
                        componentsRef.btn_server.selected = selected;
                    };
                    if (componentsRef.btn_server.disabled)
                    {
                        componentsRef.btn_server.disabled = false;
                    };
                    componentsRef.tx_bgType.visible = false;
                    componentsRef.lbl_infoType.visible = false;
                    componentsRef.tx_typeRules.visible = false;
                    componentsRef.ctr_bgType.visible = false;
                    componentsRef.tx_gradientDecoType.visible = false;
                };
                componentsRef.btn_server.visible = true;
            }
            else
            {
                componentsRef.tx_bgType.visible = false;
                componentsRef.lbl_infoType.text = "";
                componentsRef.tx_typeRules.visible = false;
                componentsRef.tx_gradientDecoType.visible = false;
                componentsRef.tx_infoState.uri = null;
                componentsRef.lbl_infoState.text = "";
                componentsRef.lbl_infoName.text = "";
                componentsRef.lbl_charaCount.text = "";
                componentsRef.lbl_infoPopulation.text = "";
                componentsRef.tx_flag.uri = null;
                componentsRef.ctr_bgType.visible = false;
                componentsRef.btn_server.visible = false;
                componentsRef.tx_waitingIllu.visible = false;
                componentsRef.lbl_monoAccount.text = "";
                componentsRef.lbl_seasonal.text = "";
            };
        }

        private function validateServerChoice():void
        {
            var serverChoiceId:int;
            if (((!(this._aServers)) || (!(this.gd_listServer.selectedItem))))
            {
                return;
            };
            if (this._waitingForServer != -1)
            {
                serverChoiceId = this._waitingForServer;
            }
            else
            {
                serverChoiceId = this.gd_listServer.selectedItem.id;
            };
            if (serverChoiceId == 0)
            {
                return;
            };
            this.soundApi.playSound(SoundTypeEnum.OK_BUTTON);
            this.btn_validate.disabled = true;
            this.btn_autochoice.disabled = true;
            this.gd_listServer.disabled = true;
            this.sysApi.sendAction(new ServerSelection(serverChoiceId));
        }

        private function displayServers():void
        {
            var serverArrayToUse:Array;
            var server:*;
            var j:*;
            if (!this._bReload)
            {
                this._bReload = true;
                for (j in this._aServers)
                {
                    if (((this._aServers[j].status == ServerStatusEnum.ONLINE) || (this._aServers[j].status == ServerStatusEnum.NOJOIN)))
                    {
                        this._serverInfo = this._aServers[j];
                        break;
                    };
                };
            }
            else
            {
                this.gd_listServer.autoSelectMode = 0;
            };
            this._serversForDataProvider = new Array();
            if (this.sysApi.hasRight())
            {
                serverArrayToUse = this._aServers;
            }
            else
            {
                serverArrayToUse = this._aMyCommuServers;
            };
            for each (server in serverArrayToUse)
            {
                if (((Boolean((!(this.btn_ckboxMy.selected)))) || (server.charactersCount > 0)))
                {
                    this._serversForDataProvider.push(server);
                };
            };
            this.createDataprovider();
        }

        private function createDataprovider():void
        {
            var serverData:Server;
            var server:*;
            var data:*;
            var tempArrayForSorting:Array;
            var typeId:*;
            var selectedIndex:int;
            var obj:*;
            var serverId:int;
            var serverTypeData:ServerGameType;
            var servers:Array;
            var totalCharacters:uint;
            var freeCharactersSlotCount:uint;
            var monoAccountTotalCharacters:uint;
            var monoAccountFreeCharactersSlotCount:uint;
            var dataProvider:Array = new Array();
            var serversByTypeId:Array = new Array();
            for each (data in this._serversForDataProvider)
            {
                if (((this._aFriendServers) && (this._aFriendServers.length)))
                {
                    for each (serverId in this._aFriendServers)
                    {
                        if (data.id == serverId)
                        {
                            serverData = this.dataApi.getServer(data.id);
                            if (!serversByTypeId[serverData.gameTypeId])
                            {
                                serversByTypeId[serverData.gameTypeId] = new Array();
                            };
                            serversByTypeId[serverData.gameTypeId].push(data);
                        };
                    };
                }
                else
                {
                    serverData = this.dataApi.getServer(data.id);
                    if (!serversByTypeId[serverData.gameTypeId])
                    {
                        serversByTypeId[serverData.gameTypeId] = new Array();
                    };
                    serversByTypeId[serverData.gameTypeId].push(data);
                };
            };
            for (typeId in serversByTypeId)
            {
                serverTypeData = this.dataApi.getServerGameType(typeId);
                servers = serversByTypeId[typeId];
                totalCharacters = 0;
                freeCharactersSlotCount = 0;
                monoAccountTotalCharacters = 0;
                monoAccountFreeCharactersSlotCount = 0;
                for each (server in serversByTypeId[typeId])
                {
                    if (server.isMonoAccount)
                    {
                        monoAccountFreeCharactersSlotCount = (server.charactersSlots - server.charactersCount);
                        monoAccountTotalCharacters = (monoAccountTotalCharacters + server.charactersCount);
                    }
                    else
                    {
                        freeCharactersSlotCount = (server.charactersSlots - server.charactersCount);
                        totalCharacters = (totalCharacters + server.charactersCount);
                    };
                };
                dataProvider.push({
                    "id":0,
                    "name":"",
                    "completion":0,
                    "community":0,
                    "status":null,
                    "type":serverTypeData,
                    "server":null,
                    "monoAccount":false,
                    "charactersCount":totalCharacters,
                    "charactersSlots":(totalCharacters + freeCharactersSlotCount),
                    "monoAccountCharactersCount":monoAccountTotalCharacters,
                    "monoAccountCharactersSlots":(monoAccountTotalCharacters + monoAccountFreeCharactersSlotCount)
                });
                tempArrayForSorting = new Array();
                for each (server in servers)
                {
                    serverData = this.dataApi.getServer(server.id);
                    tempArrayForSorting.push({
                        "id":server.id,
                        "name":serverData.name,
                        "completion":serverData.populationId,
                        "community":serverData.communityId,
                        "status":server.status,
                        "type":serverTypeData,
                        "server":serverData,
                        "monoAccount":server.isMonoAccount,
                        "charactersCount":server.charactersCount,
                        "charactersSlots":server.charactersSlots,
                        "monoAccountCharactersCount":0,
                        "monoAccountCharactersSlots":0
                    });
                };
                tempArrayForSorting.sortOn(this._sortName, this._sortParam);
                for each (server in tempArrayForSorting)
                {
                    dataProvider.push(server);
                };
            };
            this.gd_listServer.dataProvider = dataProvider;
            selectedIndex = 0;
            for (obj in dataProvider)
            {
                if (this._serverInfo)
                {
                    if (dataProvider[obj].id == this._serverInfo.id)
                    {
                        selectedIndex = obj;
                    };
                }
                else
                {
                    if (dataProvider[obj].id != 0)
                    {
                        selectedIndex = obj;
                        break;
                    };
                };
            };
            this.gd_listServer.selectedIndex = selectedIndex;
        }

        private function autochoice():void
        {
            var serverIndex:*;
            this.btn_ckboxMy.selected = false;
            this.displayServers();
            this._modeAutochoice = true;
            var chosenServer:Object = this.connecApi.getAutoChosenServer(0);
            if (chosenServer)
            {
                for (serverIndex in this._aMyCommuServers)
                {
                    if (this._aMyCommuServers[serverIndex].id == chosenServer.id)
                    {
                        this.gd_listServer.selectedIndex = serverIndex;
                    };
                };
            }
            else
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.popup.noServerAvailiable"), [this.uiApi.getText("ui.common.ok")]);
            };
        }

        private function startSearch():void
        {
            var searchName:String = this.inp_search.text;
            if (searchName == "")
            {
                this.stopSearch();
            }
            else
            {
                if ((((!(searchName.length < 2)) && (searchName.length <= 30)) && (!(this.btn_friendSearch.disabled))))
                {
                    this.sysApi.sendAction(new AcquaintanceSearch(searchName));
                    this.btn_friendSearch.disabled = true;
                    this.inp_search.disabled = true;
                    this._lockSearchTimer = new Timer(3000, 1);
                    this._lockSearchTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
                    this._lockSearchTimer.start();
                };
            };
        }

        private function stopSearch():void
        {
            this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
            this._aFriendServers = new Array();
            this.displayServers();
        }

        private function populationSortFunction(a:Object, b:Object):Number
        {
            var servA:Object = this.dataApi.getServer(a.id);
            var servB:Object = this.dataApi.getServer(b.id);
            if (servA.populationId < servB.populationId)
            {
                return (-1);
            };
            if (servA.populationId == servB.populationId)
            {
                return (0);
            };
            return (1);
        }

        private function displayWaitingInfo():void
        {
            switch (this._serverInfo.status)
            {
                case ServerStatusEnum.STARTING:
                    this._waitingForServer = this._serverInfo.id;
                    this.gd_listServer.updateItems();
                    break;
                case ServerStatusEnum.OFFLINE:
                    if (this.sysApi.getBuildType() < BuildTypeEnum.TESTING)
                    {
                        this._waitingForServer = -1;
                        this.validateServerChoice();
                    }
                    else
                    {
                        this._waitingForServer = this._serverInfo.id;
                        this.gd_listServer.updateItems();
                    };
                    break;
                default:
                    this._waitingForServer = -1;
                    this.validateServerChoice();
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_validate:
                    if (this._serverInfo)
                    {
                        this.displayWaitingInfo();
                    };
                    break;
                case this.btn_autochoice:
                    this.autochoice();
                    break;
                case this.btn_friendSearch:
                    this.startSearch();
                    break;
                case this.btn_closeSearch:
                    if (this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT)
                    {
                        this.stopSearch();
                    };
                    break;
                case this.btn_tabCountry:
                    this._sortName = "community";
                    this._sortParam = Array.NUMERIC;
                    this.createDataprovider();
                    break;
                case this.btn_tabName:
                    this._sortName = "name";
                    this._sortParam = Array.CASEINSENSITIVE;
                    this.createDataprovider();
                    break;
                case this.btn_tabState:
                    this._sortName = "status";
                    this._sortParam = (Array.NUMERIC | Array.DESCENDING);
                    this.createDataprovider();
                    break;
                case this.btn_tabPopulation:
                    this._sortName = "completion";
                    this._sortParam = Array.NUMERIC;
                    this.createDataprovider();
                    break;
                case this.btn_tabCharCount:
                    this._sortName = "charactersCount";
                    this._sortParam = (Array.NUMERIC | Array.DESCENDING);
                    this.createDataprovider();
                    break;
                case this.btn_ckboxMy:
                    this.sysApi.setData("serverListFilterMyServers", this.btn_ckboxMy.selected, DataStoreEnum.BIND_ACCOUNT);
                    this.displayServers();
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    if (this.inp_search.haveFocus)
                    {
                        this.startSearch();
                    }
                    else
                    {
                        this.validateServerChoice();
                    };
                    break;
                case "closeUi":
                    if (this.inp_search.haveFocus)
                    {
                        this.stopSearch();
                    };
                    break;
            };
            return (false);
        }

        public function onRollOver(target:Object):void
        {
            var data:Object;
            var tooltipText:String = "";
            var point:uint = 7;
            var relPoint:uint = 1;
            switch (target)
            {
                case this.btn_ckboxMy:
                    tooltipText = this.uiApi.getText("ui.sersel.showMyServer");
                    break;
                case this.inp_search:
                    tooltipText = this.uiApi.getText("ui.sersel.enterAccountName");
                    break;
                case this.btn_validate:
                    if (this.btn_validate.softDisabled)
                    {
                        tooltipText = this.uiApi.getText("ui.sersel.noSlotOnThisServer");
                    };
                    break;
            };
            if (target.name.indexOf("tx_flag") == 0)
            {
                data = this._gridComponentsList[target.name];
                if (((data) && (data.id > 0)))
                {
                    if (data.server.community)
                    {
                        tooltipText = data.server.community.name;
                    }
                    else
                    {
                        tooltipText = data.community.toString();
                    };
                };
            }
            else
            {
                if (target.name.indexOf("lbl_infoName") == 0)
                {
                    data = this._gridComponentsList[target.name];
                    if (((data) && (data.id > 0)))
                    {
                        if (((data.server.comment) && (data.server.comment.length > 0)))
                        {
                            tooltipText = data.server.comment;
                        };
                        if (data.server.openingDate > 0)
                        {
                            if (tooltipText != "")
                            {
                                tooltipText = (tooltipText + "\n");
                            };
                            tooltipText = (tooltipText + ((this.uiApi.getText("ui.sersel.date") + this.uiApi.getText("ui.common.colon")) + this.timeApi.getDate(data.server.openingDate, true, true)));
                        };
                    };
                }
                else
                {
                    if (target.name.indexOf("tx_typeRules") != -1)
                    {
                        data = this._gridComponentsList[target.name];
                        if (((data) && (data.id == 0)))
                        {
                            tooltipText = data.type.rules;
                        };
                    }
                    else
                    {
                        if (target.name.indexOf("tx_waitingIllu") != -1)
                        {
                            data = this._gridComponentsList[target.name];
                            if (((data) && (data.id == this._waitingForServer)))
                            {
                                tooltipText = this.uiApi.getText("ui.sersel.waitForServerTooltip");
                            };
                        }
                        else
                        {
                            if (target.name.indexOf("lbl_charaCount") != -1)
                            {
                                data = this._gridComponentsList[target.name];
                                if (((data) && (data.id == 0)))
                                {
                                    tooltipText = (((data.charactersCount + " / ") + data.charactersSlots) + "\n");
                                    tooltipText = (tooltipText + ((((this.uiApi.getText("ui.server.monoaccount") + this.uiApi.getText("ui.common.colon")) + data.monoAccountCharactersCount) + " / ") + data.monoAccountCharactersSlots));
                                };
                            };
                        };
                    };
                };
            };
            if (tooltipText != "")
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (((target.selectedItem) && (target.selectedItem.id == 0)))
            {
                return;
            };
            this._serverInfo = target.selectedItem;
            if (this._serverInfo)
            {
                this._currentServer = this.dataApi.getServer(this._serverInfo.id);
                if (selectMethod == SelectMethodEnum.DOUBLE_CLICK)
                {
                    this.displayWaitingInfo();
                };
            };
        }

        private function onServersList(servers:Object):void
        {
            var i:*;
            var currServer:Server;
            var servI:*;
            var currServerC:Object;
            var firstTime:* = (this._aMyServers == null);
            this._aServers = new Array();
            this._aMyCommuServers = new Array();
            this._aMyServers = new Array();
            var playerCommuId:int = this.sysApi.getPlayerManager().communityId;
            for (i in servers)
            {
                currServer = this.dataApi.getServer(servers[i].id);
                if ((((!(this._waitingForServer == -1)) && (servers[i].id == this._waitingForServer)) && (servers[i].status == ServerStatusEnum.ONLINE)))
                {
                    this.validateServerChoice();
                };
                if (currServer)
                {
                    if ((((((currServer.communityId == playerCommuId) || (currServer.communityId == DataEnum.SERVER_COMMUNITY_INTERNATIONAL_ALL)) || (currServer.communityId == DataEnum.SERVER_COMMUNITY_BETA)) || (((!(playerCommuId == DataEnum.SERVER_COMMUNITY_FRENCH_SPEAKING)) && (!(playerCommuId == DataEnum.SERVER_COMMUNITY_SPANISH_SPEAKING))) && (currServer.communityId == DataEnum.SERVER_COMMUNITY_INTERNATIONAL_ALL_EXCEPT_FRENCH))) || (servers[i].charactersCount > 0)))
                    {
                        this._aMyCommuServers.push(servers[i]);
                    };
                    if (servers[i].charactersCount > 0)
                    {
                        this._aMyServers.push(servers[i]);
                    };
                    this._aServers.push(servers[i]);
                }
                else
                {
                    this.sysApi.log(16, (("Server " + servers[i].id) + " cannot be found in data files."));
                };
            };
            if (this._aMyCommuServers.length == 0)
            {
                for each (servI in this._aServers)
                {
                    currServerC = this.dataApi.getServer(servI.id);
                    if (((currServerC) && (currServerC.communityId == DataEnum.SERVER_COMMUNITY_INTERNATIONAL_ALL_EXCEPT_FRENCH)))
                    {
                        this._aMyCommuServers.push(servI);
                    };
                };
            };
            if (((firstTime) && (!(this._aMyServers.length))))
            {
                this.btn_ckboxMy.selected = false;
            };
            this.displayServers();
            this._serverInfo = this.gd_listServer.selectedItem;
            if (this._serverInfo)
            {
                this._currentServer = this.dataApi.getServer(this._serverInfo.id);
            };
        }

        public function onAcquaintanceSearchError(error:String):void
        {
            var text:String;
            switch (error)
            {
                case "no_result":
                    text = this.uiApi.getText(("ui.sersel.searchError." + error), this.inp_search.text);
                    break;
                default:
                    text = this.uiApi.getText(("ui.sersel.searchError." + error));
            };
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), text, [this.uiApi.getText("ui.common.ok")]);
            this.onTimeOut(null);
        }

        public function onAcquaintanceServerList(servers:Object):void
        {
            var serverId:*;
            this._aFriendServers = new Array();
            for each (serverId in servers)
            {
                this._aFriendServers.push(serverId);
            };
            this.displayServers();
            this.onTimeOut(null);
        }

        public function onSelectedServerRefused(serverId:int, error:String, selectableServers:Object):void
        {
            this.btn_validate.disabled = false;
            this.btn_autochoice.disabled = false;
            this.gd_listServer.disabled = false;
            this._clockStart = 0;
            this.sysApi.removeEventListener(this.onEnterFrame);
        }

        public function onQueueStatus(position:uint, total:uint):void
        {
            this._clockStart = 0;
            this.sysApi.removeEventListener(this.onEnterFrame);
        }

        public function onServerConnectionStarted():void
        {
            this._clockStart = getTimer();
            this.sysApi.addEventListener(this.onEnterFrame, "time");
        }

        public function onTimeOut(e:TimerEvent):void
        {
            this.btn_friendSearch.disabled = false;
            this.inp_search.disabled = false;
            this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            this._lockSearchTimer.stop();
            this._lockSearchTimer = null;
        }

        public function onEnterFrame():void
        {
            var clock:Number = getTimer();
            var delay:Number = (clock - this._clockStart);
            if (((delay >= 3000) && (delay < 10000)))
            {
                if (this._popupInUse != 1)
                {
                    this._popupInUse = 1;
                    this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.information"), this.uiApi.getText("ui.popup.currentlyConnecting"), [this.uiApi.getText("ui.common.ok")]);
                };
            }
            else
            {
                if (delay >= 10000)
                {
                    if (((this._popupInUse == 1) && (this.uiApi.getUi(this._popupName))))
                    {
                        this.uiApi.unloadUi(this._popupName);
                    };
                    if (this._popupInUse != 2)
                    {
                        this._popupInUse = 2;
                        this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.popup.accessDenied.timeout"), [this.uiApi.getText("ui.common.wait"), this.uiApi.getText("ui.common.interrupt")], [this.onPopupWait, this.onPopupInterrupt], this.onPopupWait, this.onPopupInterrupt);
                    };
                };
            };
        }

        public function onPopupWait():void
        {
            this.sysApi.removeEventListener(this.onEnterFrame);
        }

        public function onPopupInterrupt():void
        {
            this.sysApi.sendAction(new ResetGame());
        }


    }
} Ankama_Connection.ui

