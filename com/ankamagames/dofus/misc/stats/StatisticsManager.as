package com.ankamagames.dofus.misc.stats
{
    import flash.events.EventDispatcher;
    import com.ankamagames.jerakine.interfaces.IDestroyable;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.ankama.haapi.client.api.GameApi;
    import com.ankama.haapi.client.api.AccountApi;
    import flash.globalization.DateTimeFormatter;
    import com.ankamagames.jerakine.types.DataStoreType;
    import org.openapitools.common.ApiUserCredentials;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
    import com.ankamagames.dofus.misc.utils.events.GameSessionReadyEvent;
    import com.ankamagames.dofus.misc.stats.custom.SessionStartStats;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.dofus.misc.stats.ui.BuildVersionStats;
    import flash.filesystem.File;
    import com.ankamagames.dofus.misc.utils.events.AccountSessionReadyEvent;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.dofus.misc.stats.ui.NicknameRegistrationStats;
    import com.ankamagames.dofus.misc.stats.ui.ServerListSelectionStats;
    import com.ankamagames.dofus.misc.stats.ui.CharacterCreationStats;
    import com.ankamagames.dofus.misc.stats.ui.CinematicStats;
    import com.ankamagames.dofus.misc.stats.ui.TutorialStats;
    import com.ankamagames.dofus.misc.stats.custom.AdvancedTutorialStats;
    import com.ankamagames.dofus.misc.stats.ui.PayZoneUiStats;
    import com.ankamagames.dofus.misc.stats.custom.PayZoneStats;
    import com.ankamagames.dofus.misc.stats.ui.UpdateInformationStats;
    import com.ankamagames.dofus.misc.stats.ui.ConfigShortcutStats;
    import com.ankamagames.dofus.misc.stats.custom.ShortcutsStats;
    import com.ankamagames.dofus.misc.stats.ui.AuctionBetaStats;
    import com.ankamagames.dofus.misc.stats.ui.KolizeumStats;
    import com.ankamagames.dofus.misc.stats.ui.ShopNavigationStats;
    import com.ankamagames.dofus.misc.stats.ui.UserActivitiesStats;
    import com.ankamagames.dofus.misc.stats.ui.OpenBoxStats;
    import com.ankamagames.dofus.misc.stats.ui.GetArticlesStats;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.types.event.UiRenderEvent;
    import com.ankamagames.berilia.types.event.UiUnloadEvent;
    import com.ankamagames.jerakine.logger.ModuleLogger;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.misc.stats.custom.SessionEndStats;
    import com.ankamagames.dofus.misc.stats.events.StatisticsEvent;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.misc.stats.components.IComponentStats;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.types.data.Hook;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import org.openapitools.event.ApiClientEvent;
    import com.ankamagames.jerakine.utils.system.SystemManager;
    import com.ankamagames.jerakine.utils.misc.DeviceUtils;
    import com.ankamagames.dofus.misc.utils.GameID;
    import com.ankamagames.dofus.misc.utils.errormanager.DofusErrorHandler;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.IOErrorEvent;
    import com.ankamagames.dofus.misc.stats.ui.IUiStats;
    import __AS3__.vec.*;

    public class StatisticsManager extends EventDispatcher implements IDestroyable 
    {

        private static const NORMAL_ERROR:String = "No information received from the server ...";
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(StatisticsManager));
        private static var _self:StatisticsManager;

        private var _statsAssoc:Dictionary;
        private var _stats:Dictionary;
        private var _frame:StatisticsFrame;
        private var _componentsStats:Dictionary;
        private var _firstTimeUserExperience:Dictionary;
        private var _removedStats:Vector.<String>;
        private var _pendingActions:Vector.<StatsAction>;
        private var _actionsSent:Vector.<StatsAction>;
        private var _statsEnabled:Boolean;
        private var _gameApi:GameApi;
        private var _accountApi:AccountApi;
        private var _dateTimeFormatter:DateTimeFormatter;
        private var _dataStoreType:DataStoreType;
        private var _exiting:Boolean;
        private var _stepByStep:Number;
        private var _sentryReport:Boolean;
        private var _sentryReported:Boolean;
        private var _apiCredentials:ApiUserCredentials;

        public function StatisticsManager()
        {
            this._statsAssoc = new Dictionary(true);
            this._stats = new Dictionary(true);
            this._frame = new StatisticsFrame(this._stats);
            this._componentsStats = new Dictionary(true);
            this._firstTimeUserExperience = new Dictionary(true);
            this._removedStats = new Vector.<String>(0);
            this._actionsSent = new Vector.<StatsAction>(0);
            this.initDataStoreType();
            this._dateTimeFormatter = new DateTimeFormatter("fr-FR");
            this._dateTimeFormatter.setDateTimePattern("yyyy-MM-dd'T'HH:mm:ss+00:00");
            this._apiCredentials = new ApiUserCredentials("", XmlConfig.getInstance().getEntry("config.haapiUrlAnkama"), null);
            this._gameApi = new GameApi(this._apiCredentials);
        }

        public static function getInstance():StatisticsManager
        {
            if (!_self)
            {
                _self = new (StatisticsManager)();
            };
            return (_self);
        }


        private function get sending():Boolean
        {
            return (this._actionsSent.length > 0);
        }

        private function onGameSessionReady(event:GameSessionReadyEvent):void
        {
            HaapiKeyManager.getInstance().removeEventListener(GameSessionReadyEvent.READY, this.onGameSessionReady);
            this.setGameSessionId(HaapiKeyManager.getInstance().getGameSessionId());
            new SessionStartStats();
            if ((((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.DRAFT)) && (this.zipFileExists())))
            {
                BuildVersionStats.createAndSendStat();
            };
            this.sendPendingEvents();
        }

        public function zipFileExists():Boolean
        {
            _log.debug(("searching zipVersion file in directory : " + File.applicationDirectory.nativePath));
            var zaapFile:File = File.applicationDirectory.resolvePath(((File.applicationDirectory.nativePath + File.separator) + "zipVersion"));
            return (zaapFile.exists);
        }

        private function onAccountSessionReady(event:AccountSessionReadyEvent):void
        {
            HaapiKeyManager.getInstance().removeEventListener(AccountSessionReadyEvent.READY, this.onAccountSessionReady);
            HaapiKeyManager.getInstance().callWithApiKey(function (apiKey:String):void
            {
                _apiCredentials.apiToken = apiKey;
                _accountApi = new AccountApi(_apiCredentials);
                sendDeviceInfos();
            });
        }

        public function get statsEnabled():Boolean
        {
            return (this._statsEnabled);
        }

        public function set statsEnabled(pValue:Boolean):void
        {
            this._statsEnabled = pValue;
        }

        public function startFirstTimeUserExperience(pUserId:String):void
        {
            var uiName:String;
            for (uiName in this._statsAssoc)
            {
                if (this._statsAssoc[uiName].ftue)
                {
                    this.setFirstTimeUserExperience(uiName, true);
                };
            };
            StoreDataManager.getInstance().setData(this._dataStoreType, ("firstTimeUserExperience-" + pUserId), this._firstTimeUserExperience);
        }

        public function setFirstTimeUserExperience(pUiName:String, pValue:Boolean):void
        {
            this._firstTimeUserExperience[pUiName] = pValue;
        }

        public function init():void
        {
            var savedStats:*;
            var savedStatsAction:String;
            var action:StatsAction;
            if (!this._pendingActions)
            {
                this._pendingActions = new Vector.<StatsAction>(0);
                savedStats = StoreDataManager.getInstance().getData(this._dataStoreType, "statsActions");
                StoreDataManager.getInstance().setData(this._dataStoreType, "statsActions", null);
                if (savedStats)
                {
                    for each (savedStatsAction in savedStats)
                    {
                        action = StatsAction.fromString(savedStatsAction);
                        if (action)
                        {
                            this._pendingActions.push(action);
                        };
                    };
                };
            };
            this.sendPendingEvents();
            this.registerStats("pseudoChoice", NicknameRegistrationStats);
            this.registerStats("serverListSelection", ServerListSelectionStats, true);
            this.registerStats("characterCreation", CharacterCreationStats, true);
            this.registerStats("cinematic", CinematicStats, true);
            this.registerStats("tutorial", TutorialStats, true);
            this.registerStats("advancedTutorial", AdvancedTutorialStats, true);
            this.registerStats("payZone", PayZoneUiStats);
            this.registerStats("payZoneArrival", PayZoneStats);
            this.registerStats("updateInformation", UpdateInformationStats);
            this.registerStats("configShortcuts", ConfigShortcutStats);
            this.registerStats("shortcuts", ShortcutsStats);
            this.registerStats("auctionBeta", AuctionBetaStats);
            this.registerStats("pvpArena", KolizeumStats);
            this.registerStats("shopNavigation", ShopNavigationStats);
            this.registerStats("userActivity", UserActivitiesStats);
            this.registerStats("openBox", OpenBoxStats);
            this.registerStats("getArticles", GetArticlesStats);
            Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderComplete, this.onUiLoaded);
            Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_STARTED, this.onUiUnloadStart);
            ModuleLogger.active = true;
            ModuleLogger.addCallback(this.log);
            HaapiKeyManager.getInstance().addEventListener(GameSessionReadyEvent.READY, this.onGameSessionReady);
            HaapiKeyManager.getInstance().addEventListener(AccountSessionReadyEvent.READY, this.onAccountSessionReady);
        }

        public function destroy():void
        {
            StatsAction.reset();
            ModuleLogger.active = false;
            ModuleLogger.removeCallback(this.log);
            Kernel.getWorker().removeFrame(this._frame);
            this._statsAssoc = new Dictionary(true);
            this._stats = new Dictionary(true);
            this._frame = new StatisticsFrame(this._stats);
            this._componentsStats = new Dictionary(true);
            this._firstTimeUserExperience = new Dictionary(true);
            this._removedStats = new Vector.<String>(0);
            Berilia.getInstance().removeEventListener(UiRenderEvent.UIRenderComplete, this.onUiLoaded);
            Berilia.getInstance().removeEventListener(UiUnloadEvent.UNLOAD_UI_STARTED, this.onUiUnloadStart);
            HaapiKeyManager.getInstance().removeEventListener(GameSessionReadyEvent.READY, this.onGameSessionReady);
            HaapiKeyManager.getInstance().removeEventListener(AccountSessionReadyEvent.READY, this.onAccountSessionReady);
            if (!this._exiting)
            {
                new SessionEndStats();
                this.init();
            };
        }

        public function get frame():StatisticsFrame
        {
            return (this._frame);
        }

        public function saveActionTimestamp(pActionId:uint, pTimestamp:Number):void
        {
            StoreDataManager.getInstance().setData(this._dataStoreType, this.getActionDataId(pActionId), pTimestamp);
        }

        public function getActionTimestamp(pActionId:uint):Number
        {
            var data:* = StoreDataManager.getInstance().getData(this._dataStoreType, this.getActionDataId(pActionId));
            return (((data is Number) && (!(isNaN(data)))) ? (data as Number) : NaN);
        }

        public function deleteTimeStamp(pActionId:uint):void
        {
            this.saveActionTimestamp(pActionId, NaN);
        }

        public function sendAction(action:StatsAction):void
        {
            if (this._pendingActions.indexOf(action) != -1)
            {
                return;
            };
            this._pendingActions.push(action);
            this.sendPendingEvents();
        }

        public function sendActions(actions:Vector.<StatsAction>):void
        {
            var action:StatsAction;
            for each (action in actions)
            {
                if (this._pendingActions.indexOf(action) != -1)
                {
                }
                else
                {
                    this._pendingActions.push(action);
                };
            };
            this.sendPendingEvents();
        }

        public function setAccountId(pAccountId:uint):void
        {
            var action:StatsAction;
            for each (action in this._pendingActions)
            {
                if (((action.hasParam("account_id")) && (action.user == StatsAction.getUserId())))
                {
                    action.setParam("account_id", pAccountId);
                };
            };
        }

        public function setGameSessionId(gameSessionId:Number):void
        {
            var action:StatsAction;
            for each (action in this._pendingActions)
            {
                if (((action.user == StatsAction.getUserId()) && (!(action.gameSessionId))))
                {
                    action.gameSessionId = gameSessionId;
                };
            };
        }

        public function sendActionsAndExit():Boolean
        {
            this._exiting = true;
            new SessionEndStats();
            if (this.sendPendingEvents())
            {
                return (true);
            };
            this.quit();
            return (false);
        }

        public function hasActionsToSend():Boolean
        {
            if (this.sending)
            {
                return (true);
            };
            return (this.getEventsToSend().length > 0);
        }

        public function formatDate(pDate:Date):String
        {
            return (this._dateTimeFormatter.formatUTC(pDate));
        }

        public function quit():void
        {
            dispatchEvent(new StatisticsEvent(StatisticsEvent.ALL_DATA_SENT));
            this.destroy();
        }

        public function getData(pKey:String):*
        {
            return (StoreDataManager.getInstance().getData(this._dataStoreType, pKey));
        }

        public function setData(pKey:String, pValue:*):void
        {
            StoreDataManager.getInstance().setData(this._dataStoreType, pKey, pValue);
        }

        public function removeStats(pStatsName:String):void
        {
            this._removedStats.push(pStatsName);
            if ((this._stats[pStatsName] is IStatsClass))
            {
                (this._stats[pStatsName] as IStatsClass).remove();
                delete this._stats[pStatsName];
                this._removedStats.splice(this._removedStats.indexOf(pStatsName), 1);
            };
        }

        public function startStats(pStatsName:String, ... args):void
        {
            var removedIndex:int;
            var customStatsInfo:Object = this._statsAssoc[pStatsName];
            if (((customStatsInfo) && ((!(customStatsInfo.ftue)) || (this._firstTimeUserExperience[pStatsName]))))
            {
                this._stats[pStatsName] = new customStatsInfo.statClass(args);
                removedIndex = this._removedStats.indexOf(pStatsName);
                if (removedIndex != -1)
                {
                    delete this._stats[pStatsName];
                    this._removedStats.splice(removedIndex, 1);
                };
            };
        }

        private function getActionDataId(pActionId:uint):String
        {
            var id:String;
            var characterName:String = ((PlayedCharacterManager.getInstance().infos) ? PlayedCharacterManager.getInstance().infos.name : null);
            var accountName:String = PlayerManager.getInstance().nickname;
            if (characterName)
            {
                id = characterName;
            }
            else
            {
                if (accountName)
                {
                    id = accountName;
                };
            };
            var actionId:String = pActionId.toString();
            var dataId:String = ((id) ? ((id + "#") + actionId) : actionId);
            return (dataId);
        }

        private function log(... args):void
        {
            var stats:IStatsClass;
            var componentStats:IComponentStats;
            if ((args[0] is Message))
            {
                for each (stats in this._stats)
                {
                    stats.process((args[0] as Message), args);
                };
                for each (componentStats in this._componentsStats)
                {
                    if (args[1] == componentStats.component)
                    {
                        componentStats.process((args[0] as Message), args);
                    };
                };
            }
            else
            {
                if ((args[0] is Hook))
                {
                    for each (stats in this._stats)
                    {
                        if ((stats is IHookStats))
                        {
                            (stats as IHookStats).onHook((args[0] as Hook), args[1]);
                        };
                    };
                    for each (componentStats in this._componentsStats)
                    {
                        if ((componentStats is IHookStats))
                        {
                            (componentStats as IHookStats).onHook((args[0] as Hook), args[1]);
                        };
                    };
                };
            };
        }

        private function registerStats(pUiName:String, pUiStatsClass:Class, pFtue:Boolean=false):void
        {
            this._statsAssoc[pUiName] = {
                "statClass":pUiStatsClass,
                "ftue":pFtue
            };
        }

        private function initDataStoreType():void
        {
            var storeKey:String = "statistics";
            if (((!(this._dataStoreType)) || (!(this._dataStoreType.category == storeKey))))
            {
                this._dataStoreType = new DataStoreType(storeKey, true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
            };
        }

        private function onAccountApiCallResult(e:ApiClientEvent):void
        {
            _log.info("Device info sent successfully");
        }

        private function onAccountApiCallError(e:ApiClientEvent):void
        {
            if (((e.response.payload == null) || (e.response.payload.message == NORMAL_ERROR)))
            {
                return;
            };
            _log.warn(("Account Api Error : " + e.response.payload.message));
        }

        private function sendDeviceInfos():void
        {
            _log.info("Calling method SendDeviceInfos");
            this._accountApi.send_device_infos(0, AccountApi.sendDeviceInfos_ConnectionTypeEnum_ANKAMA, AccountApi.sendDeviceInfos_ClientTypeEnum_STANDALONE, SystemManager.getSingleton().os.replace(/ /gi, "").toUpperCase(), AccountApi.sendDeviceInfos_DeviceEnum_PC, null, DeviceUtils.deviceUniqueIdentifier, HaapiKeyManager.getInstance().getAccountSessionId()).onSuccess(this.onAccountApiCallResult).onError(this.onAccountApiCallError).call();
        }

        private function getEventsToSend():Vector.<StatsAction>
        {
            var action:StatsAction;
            var result:Vector.<StatsAction> = new Vector.<StatsAction>(0);
            var gameSessionId:Number = 0;
            var currentGameSessionId:Number = HaapiKeyManager.getInstance().getGameSessionId();
            for each (action in this._pendingActions)
            {
                if ((((!(this._exiting)) && (!(currentGameSessionId == 0))) ? ((action.gameSessionId == currentGameSessionId) && (!(action.sendOnExit))) : action.gameSessionId))
                {
                    if (gameSessionId == 0)
                    {
                        gameSessionId = action.gameSessionId;
                    }
                    else
                    {
                        if (gameSessionId != action.gameSessionId)
                        {
                            break;
                        };
                    };
                    result.push(action);
                    if (this._stepByStep == gameSessionId)
                    {
                        break;
                    };
                };
            };
            return (result);
        }

        private function sendPendingEvents():Boolean
        {
            var action:StatsAction;
            _log.info(((("Status :  Sending = " + this._actionsSent.length) + " / Total not sent = ") + this._pendingActions.length));
            if (this.sending)
            {
                return (true);
            };
            this._actionsSent = this.getEventsToSend();
            if (this._actionsSent.length)
            {
                if (this._actionsSent.length == 1)
                {
                    action = this._actionsSent[0];
                    _log.info("Calling method SendEvent");
                    this._gameApi.send_event(GameID.current, action.gameSessionId, action.id, action.paramsString, action.date).onSuccess(this.onApiCallResult).onError(this.onApiCallError).call();
                }
                else
                {
                    _log.info((("Calling method SendEvents containing " + this._actionsSent.length) + " events"));
                    this._gameApi.send_events(GameID.current, this._actionsSent[0].gameSessionId, this.sentEventsToString).onSuccess(this.onApiCallResult).onError(this.onApiCallError).call();
                };
                return (true);
            };
            return (false);
        }

        private function get sentEventsToString():String
        {
            var eventString:String = "[";
            var i:uint;
            while (i < this._actionsSent.length)
            {
                eventString = (eventString + this._actionsSent[i].toString());
                if (i < (this._actionsSent.length - 1))
                {
                    eventString = (eventString + ",");
                };
                i++;
            };
            eventString = (eventString + "]");
            return (eventString);
        }

        private function onApiCallResult(e:ApiClientEvent):void
        {
            _log.info("kpi events successfully submitted");
            while (this._actionsSent.length)
            {
                this._pendingActions.splice(this._pendingActions.indexOf(this._actionsSent.pop()), 1);
            };
            if (((this._stepByStep) && (this._pendingActions.length == 0)))
            {
                this._stepByStep = 0;
            };
            if (((!(this.sendPendingEvents())) && (this._exiting)))
            {
                this.quit();
            };
        }

        private function warnAndReportSentry(msg:String):void
        {
            this._sentryReported = true;
            _log.warn(msg);
            DofusErrorHandler.captureMessage("Failed to submit KPIs");
            if (this._exiting)
            {
                this.quit();
            };
        }

        private function testHaapi():void
        {
            if (this._sentryReport)
            {
                return;
            };
            this._sentryReport = true;
            var testLoader:URLLoader = new URLLoader();
            testLoader.addEventListener(Event.COMPLETE, function (e:Event):void
            {
                warnAndReportSentry("[Haapi test] Complete.");
            }, false, 0, true);
            testLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, function (e:HTTPStatusEvent):void
            {
                _log.warn(("[Haapi test] HTTP Status Code : " + e.status));
            }, false, 0, true);
            testLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function (e:SecurityErrorEvent):void
            {
                warnAndReportSentry(("[Haapi test] Security Error : " + e.toString()));
            }, false, 0, true);
            testLoader.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void
            {
                warnAndReportSentry(("[Haapi test] IOError : " + e.toString()));
            }, false, 0, true);
        }

        private function onApiCallError(e:ApiClientEvent):void
        {
            var firstAction:StatsAction;
            if (((e.response.payload == null) || (e.response.payload.message == NORMAL_ERROR)))
            {
                return;
            };
            _log.warn(((((("Failed to submit KPIs : '" + e.response.errorMessage) + "' with gameSessionId ") + this._actionsSent[0].gameSessionId) + " and event(s) : ") + this.sentEventsToString));
            if (this._exiting)
            {
                while (this._actionsSent.length)
                {
                    this._actionsSent.pop();
                };
                this.storeData();
                if (this._sentryReported)
                {
                    this.quit();
                }
                else
                {
                    this.testHaapi();
                };
            }
            else
            {
                this.testHaapi();
                firstAction = this._actionsSent.pop();
                if (this._actionsSent.length)
                {
                    this._stepByStep = firstAction.gameSessionId;
                }
                else
                {
                    this._pendingActions.splice(this._pendingActions.indexOf(firstAction), 1);
                };
                while (this._actionsSent.length)
                {
                    this._actionsSent.pop();
                };
                this.sendPendingEvents();
            };
        }

        public function storeData():void
        {
            var action:StatsAction;
            var savedStatsAction:String;
            var savedAction:StatsAction;
            var stats:Array = [];
            for each (action in this._pendingActions)
            {
                stats.push(action.toString(true));
            };
            while (this._pendingActions.length)
            {
                this._pendingActions.pop();
            };
            var savedStats:* = StoreDataManager.getInstance().getData(this._dataStoreType, "statsActions");
            StoreDataManager.getInstance().setData(this._dataStoreType, "statsActions", null);
            if (savedStats)
            {
                for each (savedStatsAction in savedStats)
                {
                    savedAction = StatsAction.fromString(savedStatsAction);
                    if (savedAction)
                    {
                        stats.push(savedAction);
                    };
                };
            };
            StoreDataManager.getInstance().setData(this._dataStoreType, "statsActions", stats);
        }

        private function onUiLoaded(pEvent:UiRenderEvent):void
        {
            var removedIndex:int;
            var uiStatsInfo:Object = this._statsAssoc[pEvent.uiTarget.name];
            if (((uiStatsInfo) && ((!(uiStatsInfo.ftue)) || (this._firstTimeUserExperience[pEvent.uiTarget.name]))))
            {
                this._stats[pEvent.uiTarget.name] = new uiStatsInfo.statClass(pEvent.uiTarget);
                removedIndex = this._removedStats.indexOf(pEvent.uiTarget.name);
                if (removedIndex != -1)
                {
                    delete this._stats[pEvent.uiTarget.name];
                    this._removedStats.splice(removedIndex, 1);
                };
            };
        }

        private function onUiUnloadStart(pEvent:UiUnloadEvent):void
        {
            var uistats:IUiStats = this._stats[pEvent.name];
            if (uistats)
            {
                uistats.remove();
            };
            delete this._stats[pEvent.name];
        }


    }
} com.ankamagames.dofus.misc.stats

