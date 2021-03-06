package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.DataStoreType;
    import com.ankama.haapi.client.api.CharacterApi;
    import com.ankamagames.jerakine.logger.LogLogger;
    import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.messages.Worker;
    import com.ankamagames.dofus.logic.connection.frames.AuthentificationFrame;
    import com.ankamagames.dofus.logic.connection.frames.InitializationFrame;
    import com.ankamagames.dofus.logic.game.approach.frames.GameServerApproachFrame;
    import com.ankamagames.dofus.logic.connection.frames.ServerSelectionFrame;
    import com.ankamagames.berilia.types.data.Hook;
    import com.ankamagames.berilia.utils.errors.BeriliaError;
    import com.ankamagames.berilia.types.listener.GenericListener;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.berilia.utils.errors.ApiError;
    import com.ankamagames.jerakine.utils.misc.CallWithParameters;
    import com.ankamagames.dofus.misc.utils.DofusApiAction;
    import com.ankamagames.jerakine.handlers.messages.Action;
    import com.ankamagames.jerakine.logger.ModuleLogger;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.dofus.misc.interClient.InterClientManager;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.dofus.Constants;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.jerakine.interfaces.IModuleUtil;
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import com.ankamagames.jerakine.utils.system.SystemManager;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.dofus.logic.common.frames.MiscFrame;
    import com.ankamagames.dofus.types.data.ServerCommand;
    import com.ankamagames.jerakine.console.ConsolesManager;
    import flash.events.Event;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.jerakine.types.Version;
    import com.ankamagames.dofus.datacenter.servers.Server;
    import com.ankamagames.atouin.managers.DataGroundMapManager;
    import com.ankamagames.dofus.logic.game.common.frames.CameraControlFrame;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.berilia.components.ComponentInternalAccessor;
    import com.ankamagames.berilia.components.WebBrowser;
    import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
    import flash.net.URLRequestMethod;
    import com.ankamagames.dofus.misc.utils.GameID;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.jerakine.utils.crypto.AdvancedMd5;
    import flash.utils.ByteArray;
    import flash.net.URLVariables;
    import com.ankamagames.dofus.internalDatacenter.dare.DareCriteriaWrapper;
    import com.ankamagames.dofus.misc.utils.CharacterIdConverter;
    import com.ankamagames.dofus.network.enums.DareCriteriaTypeEnum;
    import com.ankamagames.dofus.internalDatacenter.dare.DareWrapper;
    import flash.geom.Point;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.logic.game.roleplay.frames.EntitiesTooltipsFrame;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkDisplayArrowManager;
    import flash.display.MovieClip;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import flash.filesystem.File;
    import com.ankamagames.dofus.kernel.zaap.ZaapApi;
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;
    import com.ankamagames.dofus.logic.common.managers.AccountManager;
    import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
    import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.DynamicSecureObject;
    import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;
    import com.ankamagames.jerakine.utils.system.CommandLineArguments;
    import flash.filesystem.FileStream;
    import flash.filesystem.FileMode;
    import com.ankamagames.dofus.themes.utils.ThemeInstallerFrame;
    import com.ankamagames.jerakine.handlers.HumanInputHandler;
    import org.openapitools.common.ApiUserCredentials;
    import org.openapitools.event.ApiClientEvent;
    import com.ankamagames.jerakine.managers.LangManager;
    import com.ankamagames.jerakine.managers.FontManager;
    import com.ankamagames.berilia.managers.ThemeManager;
    import com.ankamagames.dofus.misc.stats.StatisticsManager;
    import com.ankamagames.jerakine.types.Callback;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
    import com.ankamagames.dofus.logic.shield.SecureModeManager;
    import com.ankamagames.dofus.network.types.secure.TrustCertificate;
    import com.ankamagames.dofus.misc.utils.frames.LuaScriptRecorderFrame;
    import com.ankamagames.jerakine.utils.misc.StringUtils;

    [InstanciedApi]
    public class SystemApi implements IApi 
    {

        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        private static var _wordInteractionEnable:Boolean = true;

        private var _module:UiModule;
        private var _currentUi:UiRootContainer;
        protected var _log:Logger = Log.getLogger(getQualifiedClassName(SystemApi));
        private var _characterDataStore:DataStoreType;
        private var _accountDataStore:DataStoreType;
        private var _computerDataStore:DataStoreType;
        private var _dofusCharacterApi:CharacterApi;
        private var _hooks:Dictionary = new Dictionary();
        private var _listener:Dictionary = new Dictionary();
        private var _listenerCount:uint;
        private var _running:Boolean;

        public function SystemApi()
        {
            MEMORY_LOG[this] = 1;
        }

        public static function get wordInteractionEnable():Boolean
        {
            return (_wordInteractionEnable);
        }


        public function enableLogs(enabled:Boolean):void
        {
            LogLogger.activeLog(enabled);
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        [ApiData(name="currentUi")]
        public function set currentUi(value:UiRootContainer):void
        {
            this._currentUi = value;
        }

        public function destroy():void
        {
            var hookName:*;
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            this._listener = null;
            this._module = null;
            this._currentUi = null;
            this._characterDataStore = null;
            this._accountDataStore = null;
            this._computerDataStore = null;
            for (hookName in this._hooks)
            {
                this.removeHook(hookName);
            };
            this._hooks = new Dictionary();
        }

        public function isInGame():Boolean
        {
            var worker:Worker = Kernel.getWorker();
            var authentificationFramePresent:Boolean = worker.contains(AuthentificationFrame);
            var initializationFramePresent:Boolean = worker.contains(InitializationFrame);
            var gameServerApproachFramePresent:Boolean = worker.contains(GameServerApproachFrame);
            var serverSelectionFramePresent:Boolean = worker.contains(ServerSelectionFrame);
            return (!((((authentificationFramePresent) || (initializationFramePresent)) || (gameServerApproachFramePresent)) || (serverSelectionFramePresent)));
        }

        public function addHook(hookClass:Class, callback:Function):void
        {
            var hookName:String;
            var classInfo:Array = getQualifiedClassName(hookClass).split("::");
            hookName = classInfo[(classInfo.length - 1)];
            var targetedHook:Hook = Hook.getHookByName(hookName);
            if (!targetedHook)
            {
                throw (new BeriliaError((("Hook [" + hookName) + "] does not exists.")));
            };
            var listener:GenericListener = new GenericListener(hookName, ((this._currentUi) ? this._currentUi.name : ("__module_" + this._module.id)), callback, 0, ((this._currentUi) ? GenericListener.LISTENER_TYPE_UI : GenericListener.LISTENER_TYPE_MODULE));
            this._hooks[hookClass] = listener;
            KernelEventsManager.getInstance().registerEvent(listener);
        }

        public function removeHook(hookClass:Class):void
        {
            if (hookClass)
            {
                KernelEventsManager.getInstance().removeEventListener(this._hooks[hookClass]);
                delete this._hooks[hookClass];
            };
        }

        public function createHook(name:String):void
        {
            new Hook(name);
        }

        [NoBoxing]
        public function dispatchHook(hookClass:Class, ... params):void
        {
            var hookName:String;
            var classInfo:Array = getQualifiedClassName(hookClass).split("::");
            hookName = classInfo[(classInfo.length - 1)];
            var targetedHook:Hook = Hook.getHookByName(hookName);
            if (!targetedHook)
            {
                throw (new ApiError((("Hook [" + hookName) + "] does not exist")));
            };
            CallWithParameters.call(KernelEventsManager.getInstance().processCallback, new Array(targetedHook).concat(params));
        }

        public function sendAction(action:Object):uint
        {
            var apiAction:DofusApiAction;
            var classInfo:Array;
            if (action.hasOwnProperty("parameters"))
            {
                classInfo = getQualifiedClassName(action).split("::");
                apiAction = DofusApiAction.getApiActionByName(classInfo[(classInfo.length - 1)]);
            }
            else
            {
                throw (new ApiError((("Action [" + action) + "] don't implement IAction")));
            };
            if (!apiAction)
            {
                throw (new ApiError((("Action [" + action) + "] does not exist")));
            };
            var actionToSend:Action = CallWithParameters.callR(apiAction.actionClass["create"], action.parameters);
            ModuleLogger.log(actionToSend);
            Kernel.getWorker().process(actionToSend);
            return (1);
        }

        public function log(level:uint, text:*):void
        {
            var ui:String = ((this._currentUi) ? ((this._currentUi.uiModule.name + "/") + this._currentUi.uiClass) : "?");
            this._log.log(level, ((("[" + ui) + "] ") + text));
            if (BuildInfos.BUILD_TYPE >= BuildTypeEnum.TESTING)
            {
                ModuleLogger.log(((("[" + ui) + "] ") + text), level);
            };
        }

        public function getClientId():uint
        {
            return (InterClientManager.getInstance().clientId);
        }

        public function getNumberOfClients():uint
        {
            return (InterClientManager.getInstance().numClients);
        }

        public function getConfigEntry(sKey:String):*
        {
            return (XmlConfig.getInstance().getEntry(sKey));
        }

        public function isEventMode():Boolean
        {
            return (Constants.EVENT_MODE);
        }

        public function isCharacterCreationAllowed():Boolean
        {
            return (Constants.CHARACTER_CREATION_ALLOWED);
        }

        public function getConfigKey(key:String):*
        {
            return (XmlConfig.getInstance().getEntry(("config." + key)));
        }

        public function goToUrl(url:String):void
        {
            if (!url)
            {
                this._log.warn("Failed to navigate to URL, no valid URL was provided.");
                return;
            };
            if (url.indexOf("[!] ") == 0)
            {
                url = url.substr(4);
            };
            navigateToURL(new URLRequest(url));
        }

        public function getPlayerManager():PlayerManager
        {
            return (PlayerManager.getInstance());
        }

        public function getTimeManager():TimeManager
        {
            return (TimeManager.getInstance());
        }

        public function getBuffManager():BuffManager
        {
            return (BuffManager.getInstance());
        }

        public function getPort():uint
        {
            var dst:DataStoreType = new DataStoreType("Dofus_ComputerOptions", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT);
            return (StoreDataManager.getInstance().getData(dst, "defaultConnectionPort"));
        }

        public function setPort(port:uint):Boolean
        {
            var dst:DataStoreType = new DataStoreType("Dofus_ComputerOptions", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT);
            return (StoreDataManager.getInstance().setData(dst, "defaultConnectionPort", port));
        }

        public function setData(name:String, value:*, dataStore:int=2):Boolean
        {
            var dst:DataStoreType;
            if (dataStore == DataStoreEnum.BIND_ACCOUNT)
            {
                if (!this._accountDataStore)
                {
                    this.initAccountDataStore();
                };
                dst = this._accountDataStore;
            }
            else
            {
                if (dataStore == DataStoreEnum.BIND_COMPUTER)
                {
                    if (!this._computerDataStore)
                    {
                        this.initComputerDataStore();
                    };
                    dst = this._computerDataStore;
                }
                else
                {
                    if (!this._characterDataStore)
                    {
                        this.initCharacterDataStore();
                    };
                    dst = this._characterDataStore;
                };
            };
            return (StoreDataManager.getInstance().setData(dst, name, value));
        }

        [NoBoxing]
        public function getData(name:String, dataStore:int=2):*
        {
            var dst:DataStoreType;
            if (dataStore == DataStoreEnum.BIND_ACCOUNT)
            {
                if (!this._accountDataStore)
                {
                    this.initAccountDataStore();
                };
                dst = this._accountDataStore;
            }
            else
            {
                if (dataStore == DataStoreEnum.BIND_COMPUTER)
                {
                    if (!this._computerDataStore)
                    {
                        this.initComputerDataStore();
                    };
                    dst = this._computerDataStore;
                }
                else
                {
                    if (!this._characterDataStore)
                    {
                        this.initCharacterDataStore();
                    };
                    dst = this._characterDataStore;
                };
            };
            var value:* = StoreDataManager.getInstance().getData(dst, name);
            switch (true)
            {
                case (value is IModuleUtil):
                case (value is IDataCenter):
                    return (value);
            };
            return (value);
        }

        public function getSetData(name:String, value:*, dataStore:int=2):*
        {
            var dst:DataStoreType;
            if (dataStore == DataStoreEnum.BIND_ACCOUNT)
            {
                if (!this._accountDataStore)
                {
                    this.initAccountDataStore();
                };
                dst = this._accountDataStore;
            }
            else
            {
                if (dataStore == DataStoreEnum.BIND_COMPUTER)
                {
                    if (!this._computerDataStore)
                    {
                        this.initComputerDataStore();
                    };
                    dst = this._computerDataStore;
                }
                else
                {
                    if (!this._characterDataStore)
                    {
                        this.initCharacterDataStore();
                    };
                    dst = this._characterDataStore;
                };
            };
            return (StoreDataManager.getInstance().getSetData(dst, name, value));
        }

        public function setQualityIsEnable():Boolean
        {
            return (StageShareManager.setQualityIsEnable);
        }

        public function getOs():String
        {
            return (SystemManager.getSingleton().os);
        }

        public function getOsVersion():String
        {
            return (SystemManager.getSingleton().version);
        }

        public function getCpu():String
        {
            return (SystemManager.getSingleton().cpu);
        }

        public function getOption(name:String, moduleName:String):*
        {
            if (((moduleName == "dofus") && (name == "displayTooltips")))
            {
                return (true);
            };
            return (OptionManager.getOptionManager(moduleName).getOption(name));
        }

        public function showWorld(b:Boolean):void
        {
            Atouin.getInstance().showWorld(b);
        }

        public function worldIsVisible():Boolean
        {
            return (Atouin.getInstance().worldIsVisible);
        }

        public function getServerStatus():uint
        {
            var miscframe:MiscFrame = (Kernel.getWorker().getFrame(MiscFrame) as MiscFrame);
            return (miscframe.getServerStatus());
        }

        public function getConsoleAutoCompletion(cmd:String, server:Boolean):String
        {
            if (server)
            {
                return (ServerCommand.autoComplete(cmd));
            };
            return (ConsolesManager.getConsole("debug").autoComplete(cmd));
        }

        public function getAutoCompletePossibilities(cmd:String, server:Boolean=false):Array
        {
            if (server)
            {
                return (ServerCommand.getAutoCompletePossibilities(cmd).sort());
            };
            return (ConsolesManager.getConsole("debug").getAutoCompletePossibilities(cmd).sort());
        }

        public function getAutoCompletePossibilitiesOnParam(cmd:String, server:Boolean=false, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return (ConsolesManager.getConsole("debug").getAutoCompletePossibilitiesOnParam(cmd, paramIndex, currentParams).sort());
        }

        public function getCmdHelp(cmd:String, server:Boolean=false):String
        {
            if (server)
            {
                return (ServerCommand.getHelp(cmd));
            };
            return (ConsolesManager.getConsole("debug").getCmdHelp(cmd));
        }

        public function hasAdminCommand(cmd:String):Boolean
        {
            return (ServerCommand.hasCommand(cmd));
        }

        private function onEnterFrame(e:Event):void
        {
            var fct:Function;
            for each (fct in this._listener)
            {
                if (fct != null)
                {
                    (fct());
                };
            };
        }

        [NoBoxing]
        public function addEventListener(listener:Function, name:String, frameRate:uint=25):void
        {
            this._listenerCount++;
            this._listener[name] = listener;
            if (!this._running)
            {
                EnterFrameDispatcher.addEventListener(this.onEnterFrame, ((this._module.id + ".enterframe") + Math.random()), frameRate);
                this._running = true;
            };
        }

        [NoBoxing]
        public function removeEventListener(listener:Function):void
        {
            var name:String;
            var toDelete:Array = [];
            for (name in this._listener)
            {
                if (listener == this._listener[name])
                {
                    this._listenerCount--;
                    toDelete.push(name);
                };
            };
            for each (name in toDelete)
            {
                delete this._listener[name];
            };
            if (!this._listenerCount)
            {
                this._running = false;
                EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            };
        }

        public function disableWorldInteraction(pTotal:Boolean=true):void
        {
            _wordInteractionEnable = false;
            TooltipManager.hideAll();
            Kernel.getWorker().process(ChangeWorldInteractionAction.create(false, pTotal));
        }

        public function enableWorldInteraction():void
        {
            _wordInteractionEnable = true;
            Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
        }

        public function hasWorldInteraction():Boolean
        {
            var contextFrame:RoleplayContextFrame = (Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame);
            if (!contextFrame)
            {
                return (false);
            };
            return (contextFrame.hasWorldInteraction);
        }

        public function hasRight():Boolean
        {
            return (PlayerManager.getInstance().hasRights);
        }

        public function hasConsoleRight():Boolean
        {
            return (PlayerManager.getInstance().hasConsoleRight);
        }

        public function isFightContext():Boolean
        {
            return ((Kernel.getWorker().contains(FightContextFrame)) || (Kernel.getWorker().isBeingAdded(FightContextFrame)));
        }

        public function getEntityLookFromString(s:String):TiphonEntityLook
        {
            return (TiphonEntityLook.fromString(s));
        }

        public function getCurrentVersion():Version
        {
            return (BuildInfos.VERSION);
        }

        public function getBuildType():uint
        {
            return (BuildInfos.BUILD_TYPE);
        }

        public function getCurrentLanguage():String
        {
            return (XmlConfig.getInstance().getEntry("config.lang.current"));
        }

        public function clearCache(pSelective:Boolean=false):void
        {
            Dofus.getInstance().clearCache(pSelective, true);
        }

        public function reset():void
        {
            Dofus.getInstance().reboot();
        }

        public function getCurrentServer():Server
        {
            return (PlayerManager.getInstance().server);
        }

        public function getGroundCacheSize():Number
        {
            return (DataGroundMapManager.getCurrentDiskUsed());
        }

        public function clearGroundCache():void
        {
            DataGroundMapManager.clearGroundCache();
        }

        public function zoom(value:Number):void
        {
            var cameraFrame:CameraControlFrame = (Kernel.getWorker().getFrame(CameraControlFrame) as CameraControlFrame);
            if (cameraFrame.dragging)
            {
                return;
            };
            this.luaZoom(value);
            Atouin.getInstance().zoom(value);
        }

        public function getCurrentZoom():Number
        {
            return (Atouin.getInstance().currentZoom);
        }

        public function goToThirdPartyLogin(target:WebBrowser):void
        {
            var ur:URLRequest;
            if (BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG)
            {
                ur = new URLRequest("http://127.0.0.1/login.php");
            }
            else
            {
                ur = new URLRequest(I18n.getUiText("ui.link.thirdparty.login"));
            };
            (ComponentInternalAccessor.access(target, "load")(ur));
        }

        public function goToOgrinePortal(target:WebBrowser):void
        {
            HaapiKeyManager.getInstance().callWithApiKey(function (apiKey:String):void
            {
                var ur:URLRequest;
                if (((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA)))
                {
                    ur = new URLRequest(I18n.getUiText("ui.link.ogrinePortal"));
                }
                else
                {
                    if (((BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.INTERNAL)))
                    {
                        ur = new URLRequest(I18n.getUiText("ui.link.ogrinePortalTest"));
                    }
                    else
                    {
                        ur = new URLRequest(I18n.getUiText("ui.link.ogrinePortalLocal"));
                    };
                };
                ur.data = getAnkamaPortalUrlParams(apiKey);
                ur.method = URLRequestMethod.POST;
                (ComponentInternalAccessor.access(target, "load")(ur));
            });
        }

        public function goToWebAuthentification(target:WebBrowser, serviceName:String):String
        {
            var ur:URLRequest;
            if (((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA)))
            {
                ur = new URLRequest(I18n.getUiText("ui.link.ankamaOauth", [serviceName]));
            }
            else
            {
                if (((BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.INTERNAL)))
                {
                    ur = new URLRequest(I18n.getUiText("ui.link.ankamaOauthTest", [serviceName]));
                }
                else
                {
                    ur = new URLRequest(I18n.getUiText("ui.link.ankamaOauthLocal", [serviceName]));
                };
            };
            (ComponentInternalAccessor.access(target, "load")(ur));
            return (ur.url);
        }

        public function goToAnkaBoxPortal(target:WebBrowser):void
        {
            HaapiKeyManager.getInstance().callWithApiKey(function (apiKey:String):void
            {
                var ur:URLRequest;
                if (((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA)))
                {
                    ur = new URLRequest(I18n.getUiText("ui.link.ankaboxPortal"));
                }
                else
                {
                    ur = new URLRequest(I18n.getUiText("ui.link.ankaboxPortalLocal"));
                };
                ur.data = getAnkamaPortalUrlParams(apiKey);
                ur.data.idbar = 0;
                ur.data.game = GameID.current;
                ur.method = URLRequestMethod.POST;
                if (target)
                {
                    (ComponentInternalAccessor.access(target, "load")(ur));
                }
                else
                {
                    navigateToURL(ur);
                };
            });
        }

        public function goToAnkaBoxLastMessage(target:WebBrowser):void
        {
            HaapiKeyManager.getInstance().callWithApiKey(function (apiKey:String):void
            {
                var ur:URLRequest;
                if (((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA)))
                {
                    ur = new URLRequest(I18n.getUiText("ui.link.ankaboxLastMessage"));
                }
                else
                {
                    ur = new URLRequest(I18n.getUiText("ui.link.ankaboxLastMessageLocal"));
                };
                ur.data = getAnkamaPortalUrlParams(apiKey);
                ur.data.idbar = 0;
                ur.data.game = GameID.current;
                ur.method = URLRequestMethod.POST;
                if (target)
                {
                    (ComponentInternalAccessor.access(target, "load")(ur));
                }
                else
                {
                    navigateToURL(ur);
                };
            });
        }

        public function goToAnkaBoxSend(target:WebBrowser, userId:Number):void
        {
            HaapiKeyManager.getInstance().callWithApiKey(function (apiKey:String):void
            {
                var ur:URLRequest;
                if (((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA)))
                {
                    ur = new URLRequest(I18n.getUiText("ui.link.ankaboxSend"));
                }
                else
                {
                    ur = new URLRequest(I18n.getUiText("ui.link.ankaboxSendLocal"));
                };
                ur.data = getAnkamaPortalUrlParams(apiKey);
                ur.data.i = String(userId);
                ur.data.idbar = 0;
                ur.data.game = GameID.current;
                ur.method = URLRequestMethod.POST;
                if (target)
                {
                    (ComponentInternalAccessor.access(target, "load")(ur));
                }
                else
                {
                    navigateToURL(ur);
                };
            });
        }

        public function goToSupportFAQ(faqURL:String):void
        {
            var ur:URLRequest = new URLRequest(faqURL);
            navigateToURL(ur);
        }

        public function goToCheckLink(url:String, sender:Number, senderName:String):void
        {
            var checkLink:String;
            if ((((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA)) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.TESTING)))
            {
                checkLink = I18n.getUiText("ui.link.checklink");
            }
            else
            {
                checkLink = (("http://go.ankama.lan/" + this.getCurrentLanguage()) + "/check");
            };
            if (((url.indexOf("http://") == -1) && (url.indexOf("https://") == -1)))
            {
                url = ("http://" + url);
            };
            var click_id:uint = PlayerManager.getInstance().accountId;
            var click_name:String = PlayedCharacterManager.getInstance().infos.name;
            var sender_id:Number = sender;
            var sender_name:String = senderName;
            var game:int = GameID.current;
            var server:int = PlayerManager.getInstance().server.id;
            this._log.debug(((((((((("goToCheckLink : " + url) + " ") + click_id) + " ") + sender_id) + " ") + game) + " ") + server));
            var chaine:String = ((((((((url + click_id) + "") + sender_id) + "") + click_name) + senderName) + game.toString()) + server.toString());
            var keyMd5:String = AdvancedMd5.hex_hmac_md5(">:fIZ?vfU0sDM_9j", chaine);
            var jsonTab:* = (((((((((((((((('{"url":"' + url) + '","click_account":') + click_id) + ',"from_account":') + sender_id) + ',"click_name":"') + click_name) + '","from_name":"') + sender_name) + '","game":') + game) + ',"server":') + server) + ',"hmac":"') + keyMd5) + '"}');
            var bytearray:ByteArray = new ByteArray();
            bytearray.writeUTFBytes(jsonTab);
            bytearray.position = 0;
            var buffer:String = "";
            bytearray.position = 0;
            while (bytearray.bytesAvailable)
            {
                buffer = (buffer + bytearray.readUnsignedByte().toString(16));
            };
            buffer = buffer.toUpperCase();
            checkLink = (checkLink + ("?s=" + buffer));
            var ur:URLRequest = new URLRequest(checkLink);
            var params:URLVariables = new URLVariables();
            params.s = buffer;
            ur.method = URLRequestMethod.POST;
            navigateToURL(ur);
        }

        public function goToDare(data:DareWrapper):void
        {
            var url:String;
            var c:DareCriteriaWrapper;
            var keyMd5:String;
            var bytearray:ByteArray;
            var buffer:String;
            var param:int;
            if ((((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA)) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.TESTING)))
            {
                url = (I18n.getUiText("ui.link.darelink") + data.dareId);
            }
            else
            {
                url = ((("http://www.dofus.tst/" + this.getCurrentLanguage()) + "/mmorpg/communaute/defis/") + data.dareId);
            };
            if (url.indexOf("www") == 0)
            {
                url = ("http://" + url);
            };
            var serverId:int = PlayerManager.getInstance().server.id;
            this._log.debug(((("goToDare : " + url) + " ") + serverId));
            var keyString:String = (((((((((((((((((url + data.dareId) + "") + serverId) + "") + CharacterIdConverter.extractServerCharacterIdFromInterserverCharacterId(data.creatorId)) + "") + data.subscriptionFee) + "") + data.jackpot) + "") + data.maxCountWinners) + "") + data.endDate) + "") + data.startDate) + "") + data.isPrivate);
            var jsonTab:String = ((((((((((((((((((('{"url":"' + url) + '","id":') + data.dareId) + ',"srv":') + serverId) + ',"oid":') + CharacterIdConverter.extractServerCharacterIdFromInterserverCharacterId(data.creatorId)) + ',"sf":') + data.subscriptionFee) + ',"jp":') + data.jackpot) + ',"mwc":') + data.maxCountWinners) + ',"d":') + data.endDate) + ',"sd":') + data.startDate) + ',"p":') + data.isPrivate);
            if (data.allianceId > 0)
            {
                jsonTab = (jsonTab + (',"aid":' + data.allianceId));
                keyString = (keyString + (data.allianceId + ""));
            }
            else
            {
                if (data.guildId > 0)
                {
                    jsonTab = (jsonTab + (',"gid":' + data.guildId));
                    keyString = (keyString + (data.guildId + ""));
                };
            };
            for each (c in data.criteria)
            {
                if (c.type == DareCriteriaTypeEnum.MONSTER_ID)
                {
                    jsonTab = (jsonTab + (',"cm":' + c.params[0]));
                    keyString = (keyString + (c.params[0] + ""));
                }
                else
                {
                    if (c.type == DareCriteriaTypeEnum.CHALLENGE_ID)
                    {
                        jsonTab = (jsonTab + (',"cc":' + c.params[0]));
                        keyString = (keyString + (c.params[0] + ""));
                    }
                    else
                    {
                        if (c.type == DareCriteriaTypeEnum.IDOLS_SCORE)
                        {
                            jsonTab = (jsonTab + (',"cis":' + c.params[0]));
                            keyString = (keyString + (c.params[0] + ""));
                        }
                        else
                        {
                            if (c.type == DareCriteriaTypeEnum.MAX_CHAR_LVL)
                            {
                                jsonTab = (jsonTab + (',"ccl":' + c.params[0]));
                                keyString = (keyString + (c.params[0] + ""));
                            }
                            else
                            {
                                if (c.type == DareCriteriaTypeEnum.MAX_FIGHT_TURNS)
                                {
                                    jsonTab = (jsonTab + (',"ct":' + c.params[0]));
                                    keyString = (keyString + (c.params[0] + ""));
                                }
                                else
                                {
                                    if (c.type == DareCriteriaTypeEnum.MAX_COUNT_CHAR)
                                    {
                                        jsonTab = (jsonTab + (',"ccx":' + c.params[0]));
                                        keyString = (keyString + (c.params[0] + ""));
                                    }
                                    else
                                    {
                                        if (c.type == DareCriteriaTypeEnum.MIN_COUNT_CHAR)
                                        {
                                            jsonTab = (jsonTab + (',"ccn":' + c.params[0]));
                                            keyString = (keyString + (c.params[0] + ""));
                                        }
                                        else
                                        {
                                            if (c.type == DareCriteriaTypeEnum.MIN_COUNT_MONSTERS)
                                            {
                                                jsonTab = (jsonTab + (',"cmc":' + c.params[0]));
                                                keyString = (keyString + (c.params[0] + ""));
                                            }
                                            else
                                            {
                                                if (c.type == DareCriteriaTypeEnum.IDOLS)
                                                {
                                                    jsonTab = (jsonTab + ',"ci":');
                                                }
                                                else
                                                {
                                                    if (c.type == DareCriteriaTypeEnum.FORBIDDEN_BREEDS)
                                                    {
                                                        jsonTab = (jsonTab + ',"cbf":');
                                                    }
                                                    else
                                                    {
                                                        if (c.type == DareCriteriaTypeEnum.MANDATORY_BREEDS)
                                                        {
                                                            jsonTab = (jsonTab + ',"cbr":');
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
                if ((((c.type == DareCriteriaTypeEnum.IDOLS) || (c.type == DareCriteriaTypeEnum.FORBIDDEN_BREEDS)) || (c.type == DareCriteriaTypeEnum.MANDATORY_BREEDS)))
                {
                    jsonTab = (jsonTab + "[");
                    for each (param in c.params)
                    {
                        if (param > 0)
                        {
                            jsonTab = (jsonTab + (param + ","));
                            keyString = (keyString + (param + ""));
                        };
                    };
                    jsonTab = jsonTab.slice(0, (jsonTab.length - 1));
                    jsonTab = (jsonTab + "]");
                };
            };
            this._log.debug(("keyString : " + keyString));
            keyMd5 = AdvancedMd5.hex_hmac_md5(">:fIZ?vfU0sDM_9j", keyString);
            jsonTab = (jsonTab + ((',"hmac":"' + keyMd5) + '"}'));
            this._log.debug(("json : " + jsonTab));
            bytearray = new ByteArray();
            bytearray.writeUTFBytes(jsonTab);
            bytearray.position = 0;
            buffer = "";
            bytearray.position = 0;
            while (bytearray.bytesAvailable)
            {
                buffer = (buffer + bytearray.readUnsignedByte().toString(16));
            };
            buffer = buffer.toUpperCase();
            url = (url + ("?s=" + buffer));
            var ur:URLRequest = new URLRequest(url);
            var params:URLVariables = new URLVariables();
            params.s = buffer;
            ur.method = URLRequestMethod.POST;
            navigateToURL(ur);
        }

        public function refreshUrl(target:WebBrowser, domain:uint=0):void
        {
            HaapiKeyManager.getInstance().callWithApiKey(function (apiKey:String):void
            {
                var params:URLVariables;
                var ur:URLRequest = new URLRequest(target.location);
                if (domain == 0)
                {
                    ur.data = getAnkamaPortalUrlParams(apiKey);
                    ur.method = URLRequestMethod.POST;
                }
                else
                {
                    if (domain == 1)
                    {
                        params = new URLVariables();
                        params.tags = ((((BuildInfos.VERSION.major + ".") + BuildInfos.VERSION.minor) + ".") + BuildInfos.VERSION.code);
                        params.theme = OptionManager.getOptionManager("dofus").getOption("currentUiSkin");
                        ur.data = params;
                        ur.method = URLRequestMethod.GET;
                    };
                };
                (ComponentInternalAccessor.access(target, "load")(ur));
            });
        }

        public function mouseZoom(zoomIn:Boolean=true):void
        {
            var arrowPos:Point;
            var newPos:Point;
            var cameraFrame:CameraControlFrame = (Kernel.getWorker().getFrame(CameraControlFrame) as CameraControlFrame);
            if (cameraFrame.dragging)
            {
                return;
            };
            var zoomLevel:Number = (Atouin.getInstance().currentZoom + ((zoomIn) ? 1 : -1));
            this.luaZoom(zoomLevel);
            Atouin.getInstance().zoom(zoomLevel, Atouin.getInstance().worldContainer.mouseX, Atouin.getInstance().worldContainer.mouseY);
            var rpEntitesFrame:RoleplayEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
            if (rpEntitesFrame)
            {
                rpEntitesFrame.updateAllIcons();
            };
            var entitiesTooltipsFrame:EntitiesTooltipsFrame = (Kernel.getWorker().getFrame(EntitiesTooltipsFrame) as EntitiesTooltipsFrame);
            if (entitiesTooltipsFrame)
            {
                entitiesTooltipsFrame.update(true);
            };
            if (((zoomLevel <= AtouinConstants.MAX_ZOOM) && (zoomLevel >= 1)))
            {
                TooltipManager.hideAll();
            };
            var fightPreparationFrame:FightPreparationFrame = (Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame);
            if (fightPreparationFrame)
            {
                fightPreparationFrame.updateSwapPositionRequestsIcons();
            };
            var arrow:MovieClip = HyperlinkDisplayArrowManager.getArrowClip();
            if (((arrow) && (!(HyperlinkDisplayArrowManager.getArrowStrata() == 5))))
            {
                arrowPos = new Point(HyperlinkDisplayArrowManager.getArrowStartX(), HyperlinkDisplayArrowManager.getArrowStartY());
                newPos = Atouin.getInstance().rootContainer.localToGlobal(arrowPos);
                arrow.x = newPos.x;
                arrow.y = newPos.y;
            };
        }

        public function resetZoom():void
        {
            Atouin.getInstance().zoom(1);
            var rpEntitesFrame:RoleplayEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
            if (rpEntitesFrame)
            {
                rpEntitesFrame.updateAllIcons();
            };
            var fightPreparationFrame:FightPreparationFrame = (Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame);
            if (fightPreparationFrame)
            {
                fightPreparationFrame.updateSwapPositionRequestsIcons();
            };
        }

        public function getMaxZoom():uint
        {
            return (AtouinConstants.MAX_ZOOM);
        }

        public function isDevMode():Boolean
        {
            return (UiModuleManager.getInstance().isDevMode);
        }

        public function getDirectoryContent(path:String="."):Array
        {
            var len:uint;
            var result:Array;
            var folderContent:Array;
            var file:File;
            do 
            {
                len = path.length;
                path = path.replace("..", ".");
            } while (path.length != len);
            path = path.replace(":", "");
            var folder:File = new File(unescape(this._module.rootPath.replace("file://", ""))).resolvePath(path);
            if (folder.isDirectory)
            {
                result = [];
                folderContent = folder.getDirectoryListing();
                for each (file in folderContent)
                {
                    result.push({
                        "name":file.name,
                        "type":((file.isDirectory) ? "folder" : "file")
                    });
                };
                return (result);
            };
            return ([]);
        }

        public function isUsingZaapLogin():Boolean
        {
            return (ZaapApi.isUsingZaapLogin());
        }

        public function setMouseCursor(cursor:String):void
        {
            switch (cursor)
            {
                case MouseCursor.ARROW:
                case MouseCursor.AUTO:
                case MouseCursor.BUTTON:
                case MouseCursor.HAND:
                case MouseCursor.IBEAM:
                    if (Mouse.supportsCursor)
                    {
                        Mouse.cursor = cursor;
                    };
                    break;
            };
        }

        public function getAccountId(playerName:String):int
        {
            try
            {
                return (AccountManager.getInstance().getAccountId(playerName));
            }
            catch(error:Error)
            {
            };
            return (0);
        }

        public function getIsAnkaBoxEnabled():Boolean
        {
            var chat:ChatFrame = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame);
            if (chat)
            {
                return (chat.ankaboxEnabled);
            };
            return (false);
        }

        public function getAdminStatus():int
        {
            return (PlayerManager.getInstance().adminStatus);
        }

        public function getObjectVariables(o:Object, onlyVar:Boolean=false, useCache:Boolean=false):Vector.<String>
        {
            return (DescribeTypeCache.getVariables(o, onlyVar, useCache));
        }

        public function getNewDynamicSecureObject():DynamicSecureObject
        {
            return (new DynamicSecureObject());
        }

        public function getNickname():String
        {
            return (PlayerManager.getInstance().nickname);
        }

        public function copyToClipboard(val:String):void
        {
            Clipboard.generalClipboard.clear();
            Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, val);
        }

        public function getLaunchArgs():String
        {
            return (CommandLineArguments.getInstance().toString());
        }

        public function getPartnerInfo():String
        {
            var fs:FileStream;
            var content:String;
            var f:File = File.applicationDirectory.resolvePath("partner");
            if (f.exists)
            {
                fs = new FileStream();
                fs.open(f, FileMode.READ);
                content = fs.readUTFBytes(fs.bytesAvailable);
                fs.close();
                return (content);
            };
            return ("");
        }

        public function toggleThemeInstaller():void
        {
            var tif:ThemeInstallerFrame = (Kernel.getWorker().getFrame(ThemeInstallerFrame) as ThemeInstallerFrame);
            if (tif)
            {
                Kernel.getWorker().removeFrame(tif);
            }
            else
            {
                Kernel.getWorker().addFrame(new ThemeInstallerFrame());
            };
        }

        public function isKeyDown(keyCode:uint):Boolean
        {
            return (HumanInputHandler.getInstance().getKeyboardPoll().isDown(keyCode));
        }

        public function getGiftList():Array
        {
            var gsapf:GameServerApproachFrame = (Kernel.getWorker().getFrame(GameServerApproachFrame) as GameServerApproachFrame);
            return (gsapf.giftList);
        }

        public function getCharaListMinusDeadPeople():Array
        {
            var gsapf:GameServerApproachFrame = (Kernel.getWorker().getFrame(GameServerApproachFrame) as GameServerApproachFrame);
            return (gsapf.charaListMinusDeadPeople);
        }

        public function removeFocus():void
        {
            StageShareManager.stage.focus = null;
        }

        public function getUrltoShareContent(content:Object, callback:Function, shareType:String=null):void
        {
            if (((((!(content)) || (!(content.hasOwnProperty("title")))) || (!(content.hasOwnProperty("description")))) || (!(content.hasOwnProperty("image")))))
            {
                throw (new ArgumentError("Content argument is null or missing required properties."));
            };
            if (!shareType)
            {
                shareType = CharacterApi.addScreenshot_TypeEnum_DEFAULT;
            };
            HaapiKeyManager.getInstance().callWithApiKey(function (apiKey:String):void
            {
                var apiCredentials:ApiUserCredentials;
                var completeFct:Function = function (e:ApiClientEvent):void
                {
                    onShareUrlReady(e, callback);
                };
                var errorFct:Function = function (e:ApiClientEvent):void
                {
                    onShareUrlError(e, callback);
                };
                if (!_dofusCharacterApi)
                {
                    apiCredentials = new ApiUserCredentials("", XmlConfig.getInstance().getEntry("config.haapiUrlAnkama"), apiKey);
                    _dofusCharacterApi = new CharacterApi(apiCredentials);
                };
                _dofusCharacterApi.add_screenshot(content.image, content.title, LangManager.getInstance().getEntry("config.lang.current"), CharacterIdConverter.extractServerCharacterIdFromInterserverCharacterId(PlayedCharacterManager.getInstance().id), PlayerManager.getInstance().server.id, PlayedCharacterManager.getInstance().currentMap.mapId, content.description, shareType).onSuccess(completeFct).onError(errorFct).call();
            });
        }

        public function changeActiveFontType(newName:String):void
        {
            FontManager.getInstance().activeType = newName;
        }

        public function getActiveFontType():String
        {
            return (FontManager.getInstance().activeType);
        }

        public function useCustomUISkin():Boolean
        {
            return (!(OptionManager.getOptionManager("dofus").getOption("currentUiSkin") == ThemeManager.OFFICIAL_THEME_NAME));
        }

        public function resetCustomUISkin():void
        {
            OptionManager.getOptionManager("dofus").setOption("currentUiSkin", ThemeManager.OFFICIAL_THEME_NAME);
            Dofus.getInstance().clearCache(true, true);
        }

        public function startStats(pStatsName:String, ... args):void
        {
            if (StatisticsManager.getInstance().statsEnabled)
            {
                StatisticsManager.getInstance().startStats.apply(StatisticsManager.getInstance(), [pStatsName].concat(args));
            };
        }

        public function removeStats(pStatsName:String):void
        {
            if (StatisticsManager.getInstance().statsEnabled)
            {
                StatisticsManager.getInstance().removeStats(pStatsName);
            };
        }

        public function createCallback(fMethod:Function, ... args):Callback
        {
            return (new Callback(fMethod, args));
        }

        private function onShareUrlReady(e:ApiClientEvent, callback:Function):void
        {
            var payload:Object = e.response.payload;
            if ((((payload) && (payload.hasOwnProperty("status"))) && (payload.status)))
            {
                (callback(payload.url));
            }
            else
            {
                this.onShareUrlError(e, callback);
            };
        }

        private function onShareUrlError(e:ApiClientEvent, callback:Function):void
        {
            this._log.error(("Failed to retrieve share url!\n" + e.response.errorMessage));
            var errorMessage:String = I18n.getUiText("ui.social.share.popup.error");
            var channelId:uint = ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO;
            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, errorMessage, channelId, TimeManager.getInstance().getTimestamp());
            (callback(null));
        }

        private function getAnkamaPortalUrlParams(apiKey:String):URLVariables
        {
            var params:URLVariables = new URLVariables();
            params.username = AuthentificationManager.getInstance().username;
            params.passkey = apiKey;
            params.server = ((PlayerManager.getInstance().server) ? PlayerManager.getInstance().server.id : 0);
            params.serverName = ((PlayerManager.getInstance().server) ? PlayerManager.getInstance().server.name : "");
            params.language = XmlConfig.getInstance().getEntry("config.lang.current");
            params.character = ((PlayedCharacterManager.getInstance()) ? PlayedCharacterManager.getInstance().id : 0);
            params.theme = OptionManager.getOptionManager("dofus").getOption("currentUiSkin");
            var certificate:TrustCertificate = SecureModeManager.getInstance().certificate;
            if (certificate)
            {
                params.certificateid = certificate.id;
                params.certificatehash = certificate.hash;
            };
            return (params);
        }

        private function initAccountDataStore():void
        {
            this._accountDataStore = new DataStoreType(("AccountModule_" + this._module.id), true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT);
        }

        private function initCharacterDataStore():void
        {
            this._characterDataStore = new DataStoreType(("Module_" + this._module.id), true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_CHARACTER);
        }

        private function initComputerDataStore():void
        {
            this._computerDataStore = new DataStoreType(("ComputerModule_" + this._module.id), true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
        }

        private function luaZoom(value:Number):void
        {
            var lsrf:LuaScriptRecorderFrame = (Kernel.getWorker().getFrame(LuaScriptRecorderFrame) as LuaScriptRecorderFrame);
            if (lsrf)
            {
                lsrf.cameraZoom(value);
            };
        }

        public function trimString(string:String):String
        {
            return (StringUtils.trim(string));
        }


    }
}

