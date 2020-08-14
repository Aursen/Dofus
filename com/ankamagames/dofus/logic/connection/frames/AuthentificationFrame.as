package com.ankamagames.dofus.logic.connection.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.dofus.kernel.zaap.IZaapMessageHandler;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
    import flash.system.LoaderContext;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.dofus.kernel.zaap.ZaapApi;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
    import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.zaap.messages.impl.ZaapNeedUpdateMessage;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.kernel.zaap.messages.IZaapInputMessage;
    import com.ankamagames.dofus.logic.common.frames.DisconnectionHandlerFrame;
    import com.ankamagames.dofus.logic.game.common.managers.AlmanaxManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.ProtectPishingFrame;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.common.actions.BrowserDomainReadyAction;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
    import com.ankamagames.jerakine.network.messages.ServerConnectionFailedMessage;
    import com.ankamagames.dofus.network.messages.connection.HelloConnectMessage;
    import com.ankamagames.dofus.network.messages.connection.IdentificationMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.messages.connection.IdentificationSuccessMessage;
    import com.ankamagames.dofus.network.messages.connection.IdentificationFailedForBadVersionMessage;
    import com.ankamagames.dofus.network.messages.connection.IdentificationFailedBannedMessage;
    import com.ankamagames.dofus.network.messages.connection.IdentificationFailedMessage;
    import com.ankamagames.dofus.network.messages.connection.register.NicknameRefusedMessage;
    import com.ankamagames.dofus.logic.connection.actions.NicknameChoiceRequestAction;
    import com.ankamagames.dofus.network.messages.connection.register.NicknameChoiceRequestMessage;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTicketAction;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.utils.crypto.Signature;
    import com.ankamagames.dofus.network.messages.security.ClientKeyMessage;
    import com.ankamagames.dofus.logic.connection.managers.ZaapConnectionManager;
    import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTokenAction;
    import com.ankamagames.dofus.network.enums.IdentificationFailureReasonEnum;
    import by.blooddy.crypto.MD5;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.jerakine.utils.crypto.Base64;
    import com.ankamagames.jerakine.resources.adapters.impl.SignedFileAdapter;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.dofus.Constants;
    import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.jerakine.network.ServerConnection;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.kernel.net.DisconnectionReasonEnum;
    import com.ankamagames.dofus.network.messages.connection.IdentificationAccountForceMessage;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.misc.interClient.InterClientManager;
    import com.ankamagames.jerakine.types.DataStoreType;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.dofus.network.messages.connection.IdentificationSuccessWithLoginTokenMessage;
    import com.ankamagames.dofus.logic.common.frames.AuthorizedFrame;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.dofus.logic.connection.managers.StoreUserDataManager;
    import com.ankamagames.dofus.logic.common.frames.ChangeCharacterFrame;
    import com.ankamagames.dofus.misc.stats.StatisticsManager;
    import com.ankamagames.dofus.logic.game.common.managers.SubhintManager;
    import com.ankamagames.dofus.logic.game.common.managers.SubhintEditorManager;
    import com.ankamagames.dofus.network.messages.connection.register.NicknameRegistrationMessage;
    import com.ankamagames.dofus.network.messages.connection.register.NicknameAcceptedMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.jerakine.utils.system.CommandLineArguments;
    import com.ankamagames.jerakine.json.JSONDecoder;
    import com.ankamagames.dofus.internalDatacenter.connection.SubscriberGift;
    import com.ankamagames.jerakine.resources.ResourceType;
    import __AS3__.vec.*;

    public class AuthentificationFrame implements Frame, IZaapMessageHandler 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthentificationFrame));
        private static const HIDDEN_PORT:uint = 443;
        private static var _lastTicket:String;

        private var _loader:IResourceLoader;
        private var _contextLoader:LoaderContext;
        private var _dispatchModuleHook:Boolean;
        private var _connexionSequence:Array;
        private var commonMod:Object = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
        private var _lastLoginHash:String;
        private var _currentLogIsForced:Boolean = false;
        private var _zaapApi:ZaapApi;

        public function AuthentificationFrame(dispatchModuleHook:Boolean=true)
        {
            this._dispatchModuleHook = dispatchModuleHook;
            this._contextLoader = new LoaderContext();
            this._contextLoader.checkPolicyFile = true;
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadError);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoad);
            this._zaapApi = new ZaapApi(this);
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function handleConnectionOpened():void
        {
        }

        public function handleConnectionClosed():void
        {
        }

        public function handleMessage(msg:IZaapInputMessage):void
        {
            var znum:ZaapNeedUpdateMessage;
            if ((msg is ZaapNeedUpdateMessage))
            {
                znum = (msg as ZaapNeedUpdateMessage);
                _log.info(("Zaap need update " + znum.needUpdate));
                if (znum.needUpdate)
                {
                    this.commonMod.openPopup(I18n.getUiText("ui.popup.launcher.getLastVersion.title"), I18n.getUiText("ui.popup.launcher.getLastVersion.msg"), [I18n.getUiText("ui.common.ok")], [], null, null, null, false, true);
                };
            };
        }

        public function pushed():Boolean
        {
            var dhf:DisconnectionHandlerFrame;
            var f:Frame;
            var className:String;
            var split:Array;
            this.processInvokeArgs();
            AlmanaxManager.getInstance();
            if (this._dispatchModuleHook)
            {
                if (Kernel.getWorker().contains(ProtectPishingFrame))
                {
                    _log.error("Oh oh ! ProtectPishingFrame is still here, it shoudln't be. Who else is in here ?");
                    for each (f in Kernel.getWorker().framesList)
                    {
                        className = getQualifiedClassName(f);
                        split = className.split("::");
                        _log.error((" - " + split[(split.length - 1)]));
                    };
                    Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(ProtectPishingFrame));
                };
                dhf = (Kernel.getWorker().getFrame(DisconnectionHandlerFrame) as DisconnectionHandlerFrame);
                KernelEventsManager.getInstance().processCallback(HookList.AuthentificationStart, dhf.mustShowLoginInterface);
            };
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var bdra:BrowserDomainReadyAction;
            var lva:LoginValidationAction;
            var connexionPorts:Array;
            var ports:String;
            var connectionHostsEntry:String;
            var connexionHosts:Array;
            var tmpHosts:Array;
            var defaultPort:uint;
            var firstConnexionSequence:Array;
            var host:String;
            var connInfo:Object;
            var scfMsg:ServerConnectionFailedMessage;
            var hcmsg:HelloConnectMessage;
            var iMsg:IdentificationMessage;
            var dhf:DisconnectionHandlerFrame;
            var time:int;
            var elapsedTimesSinceConnectionFail:Vector.<uint>;
            var failureTimes:Array;
            var ismsg:IdentificationSuccessMessage;
            var updateInformationDisplayed:String;
            var currentVersion:String;
            var iffbvmsg:IdentificationFailedForBadVersionMessage;
            var ifbmsg:IdentificationFailedBannedMessage;
            var ifmsg:IdentificationFailedMessage;
            var nrfmsg:NicknameRefusedMessage;
            var ncra:NicknameChoiceRequestAction;
            var ncrmsg:NicknameChoiceRequestMessage;
            var token:String;
            var fakeLvwta:LoginValidationWithTicketAction;
            var porc:String;
            var connectionHostsSignatureEntry:String;
            var output:ByteArray;
            var signedData:ByteArray;
            var signature:Signature;
            var validHosts:Boolean;
            var tmpHost:String;
            var randomHost:Object;
            var port:uint;
            var rawParam:String;
            var params:Array;
            var tmp:Array;
            var param:String;
            var tmp2:Array;
            var retryConnInfo:Object;
            var i:int;
            var elapsedSeconds:Number;
            var flashKeyMsg:ClientKeyMessage;
            var lengthModsTou:String;
            var newLengthModsTou:String;
            var files:Array;
            switch (true)
            {
                case (msg is LoginValidationWithTokenAction):
                    ZaapConnectionManager.getInstance().requestApiToken();
                    return (true);
                case (msg is BrowserDomainReadyAction):
                    bdra = BrowserDomainReadyAction(msg);
                    if (bdra.browser.content)
                    {
                        try
                        {
                            token = bdra.browser.content.getElementById("token").innerHTML;
                        }
                        catch(error:Error)
                        {
                            _log.fatal((((("Could not find authentication token on " + bdra.browser.location) + " (") + error.message) + ")"));
                        };
                        if (token)
                        {
                            fakeLvwta = LoginValidationWithTicketAction.create("", token, false);
                            this.process(fakeLvwta);
                        }
                        else
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailed, IdentificationFailureReasonEnum.SERVICE_UNAVAILABLE);
                        };
                        bdra.browser.clearLocation();
                    };
                    return (true);
                case (msg is LoginValidationAction):
                    lva = LoginValidationAction(msg);
                    if (this._lastLoginHash != MD5.hash(lva.username))
                    {
                        UiModuleManager.getInstance().isDevMode = XmlConfig.getInstance().getEntry("config.dev.mode");
                    };
                    this._lastLoginHash = MD5.hash(lva.username);
                    connexionPorts = new Array();
                    ports = XmlConfig.getInstance().getEntry("config.connection.port");
                    for each (porc in ports.split(","))
                    {
                        connexionPorts.push(int(porc));
                    };
                    connectionHostsEntry = XmlConfig.getInstance().getEntry("config.connection.host");
                    if (BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
                    {
                        connectionHostsSignatureEntry = XmlConfig.getInstance().getEntry("config.connection.host.signature");
                        output = new ByteArray();
                        try
                        {
                            signedData = Base64.decodeToByteArray(connectionHostsSignatureEntry);
                        }
                        catch(error:Error)
                        {
                            _log.warn("Host signature has not been properly encoded in Base64.");
                            commonMod.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.popup.connectionFailed.unauthenticatedHost"), [I18n.getUiText("ui.common.ok")]);
                            KernelEventsManager.getInstance().processCallback(HookList.SelectedServerFailed);
                            return (false);
                        };
                        signedData.position = signedData.length;
                        signedData.writeUTFBytes(connectionHostsEntry);
                        signedData.position = 0;
                        signature = new Signature(SignedFileAdapter.defaultSignatureKey);
                        validHosts = signature.verify(signedData, output);
                        if (!validHosts)
                        {
                            _log.warn("Host signature could not be verified, connection refused.");
                            this.commonMod.openPopup(I18n.getUiText("ui.common.error"), I18n.getUiText("ui.popup.connectionFailed.unauthenticatedHost"), [I18n.getUiText("ui.common.ok")]);
                            KernelEventsManager.getInstance().processCallback(HookList.SelectedServerFailed);
                            return (false);
                        };
                    };
                    connexionHosts = connectionHostsEntry.split(",");
                    tmpHosts = [];
                    for each (tmpHost in connexionHosts)
                    {
                        tmpHosts.push({
                            "host":tmpHost,
                            "random":Math.random()
                        });
                    };
                    tmpHosts.sortOn("random", Array.NUMERIC);
                    connexionHosts = [];
                    for each (randomHost in tmpHosts)
                    {
                        connexionHosts.push(randomHost.host);
                    };
                    defaultPort = uint(StoreDataManager.getInstance().getData(Constants.DATASTORE_COMPUTER_OPTIONS, "defaultConnectionPort"));
                    this._connexionSequence = [];
                    firstConnexionSequence = [];
                    for each (host in connexionHosts)
                    {
                        for each (port in connexionPorts)
                        {
                            if (defaultPort == port)
                            {
                                firstConnexionSequence.push({
                                    "host":host,
                                    "port":port
                                });
                            }
                            else
                            {
                                this._connexionSequence.push({
                                    "host":host,
                                    "port":port
                                });
                            };
                        };
                    };
                    if (connexionPorts.indexOf(HIDDEN_PORT) == -1)
                    {
                        for each (host in connexionHosts)
                        {
                            this._connexionSequence.push({
                                "host":host,
                                "port":HIDDEN_PORT
                            });
                        };
                    };
                    this._connexionSequence = firstConnexionSequence.concat(this._connexionSequence);
                    if (Constants.EVENT_MODE)
                    {
                        rawParam = Constants.EVENT_MODE_PARAM;
                        if (((rawParam) && (!(rawParam.charAt(0) == "!"))))
                        {
                            rawParam = Base64.decode(rawParam);
                            params = [];
                            tmp = rawParam.split(",");
                            for each (param in tmp)
                            {
                                tmp2 = param.split(":");
                                params[tmp2[0]] = tmp2[1];
                            };
                            if (params["login"])
                            {
                                lva.username = params["login"];
                            };
                            if (params["password"])
                            {
                                lva.password = params["password"];
                            };
                        };
                    };
                    AuthentificationManager.getInstance().setValidationAction(lva);
                    connInfo = this._connexionSequence.shift();
                    ConnectionsHandler.connectToLoginServer(connInfo.host, connInfo.port);
                    return (true);
                case (msg is ServerConnectionFailedMessage):
                    scfMsg = ServerConnectionFailedMessage(msg);
                    if (scfMsg.failedConnection == ConnectionsHandler.getConnection().getSubConnection(scfMsg))
                    {
                        (ConnectionsHandler.getConnection().mainConnection as ServerConnection).stopConnectionTimeout();
                        if (this._connexionSequence)
                        {
                            retryConnInfo = this._connexionSequence.shift();
                            if (retryConnInfo)
                            {
                                ConnectionsHandler.connectToLoginServer(retryConnInfo.host, retryConnInfo.port);
                            }
                            else
                            {
                                PlayerManager.getInstance().destroy();
                                KernelEventsManager.getInstance().processCallback(HookList.ServerConnectionFailed, DisconnectionReasonEnum.UNEXPECTED);
                            };
                        };
                    };
                    return (true);
                case (msg is HelloConnectMessage):
                    hcmsg = HelloConnectMessage(msg);
                    AuthentificationManager.getInstance().setPublicKey(hcmsg.key);
                    AuthentificationManager.getInstance().setSalt(hcmsg.salt);
                    AuthentificationManager.getInstance().initAESKey();
                    iMsg = AuthentificationManager.getInstance().getIdentificationMessage();
                    this._currentLogIsForced = (iMsg is IdentificationAccountForceMessage);
                    _log.info(((((((("Current version : " + iMsg.version.major) + ".") + iMsg.version.minor) + ".") + iMsg.version.code) + ".") + iMsg.version.build));
                    dhf = (Kernel.getWorker().getFrame(DisconnectionHandlerFrame) as DisconnectionHandlerFrame);
                    time = int(Math.round((getTimer() / 1000)));
                    elapsedTimesSinceConnectionFail = new Vector.<uint>();
                    failureTimes = StoreDataManager.getInstance().getData(Constants.DATASTORE_MODULE_DEBUG, "connection_fail_times");
                    if (failureTimes)
                    {
                        i = 0;
                        while (i < failureTimes.length)
                        {
                            elapsedSeconds = (time - failureTimes[i]);
                            if (elapsedSeconds <= 3600)
                            {
                                elapsedTimesSinceConnectionFail[i] = elapsedSeconds;
                            };
                            i = (i + 1);
                        };
                        dhf.resetConnectionAttempts();
                    };
                    iMsg.failedAttempts = elapsedTimesSinceConnectionFail;
                    ConnectionsHandler.getConnection().send(iMsg);
                    KernelEventsManager.getInstance().processCallback(HookList.ConnectionTimerStart);
                    TimeManager.getInstance().reset();
                    if (InterClientManager.getInstance().flashKey)
                    {
                        flashKeyMsg = new ClientKeyMessage();
                        flashKeyMsg.initClientKeyMessage(InterClientManager.getInstance().flashKey);
                        ConnectionsHandler.getConnection().send(flashKeyMsg);
                    };
                    return (true);
                case (msg is IdentificationSuccessMessage):
                    ismsg = IdentificationSuccessMessage(msg);
                    updateInformationDisplayed = StoreDataManager.getInstance().getData(new DataStoreType("ComputerModule_Ankama_Connection", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER), "updateInformationDisplayed");
                    currentVersion = ((BuildInfos.VERSION.major.toString() + "-") + BuildInfos.VERSION.minor.toString());
                    if (updateInformationDisplayed != currentVersion)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.OpenUpdateInformation);
                    };
                    if ((ismsg is IdentificationSuccessWithLoginTokenMessage))
                    {
                        AuthentificationManager.getInstance().nextToken = IdentificationSuccessWithLoginTokenMessage(ismsg).loginToken;
                    };
                    if (ismsg.login)
                    {
                        AuthentificationManager.getInstance().username = ismsg.login;
                    };
                    PlayerManager.getInstance().accountId = ismsg.accountId;
                    PlayerManager.getInstance().communityId = ismsg.communityId;
                    PlayerManager.getInstance().hasRights = ismsg.hasRights;
                    PlayerManager.getInstance().hasConsoleRight = ismsg.hasConsoleRight;
                    PlayerManager.getInstance().nickname = ismsg.nickname;
                    PlayerManager.getInstance().subscriptionEndDate = ismsg.subscriptionEndDate;
                    PlayerManager.getInstance().subscriptionDurationElapsed = ismsg.subscriptionElapsedDuration;
                    PlayerManager.getInstance().secretQuestion = ismsg.secretQuestion;
                    PlayerManager.getInstance().accountCreation = ismsg.accountCreation;
                    PlayerManager.getInstance().wasAlreadyConnected = ismsg.wasAlreadyConnected;
                    DataStoreType.ACCOUNT_ID = ismsg.accountId.toString();
                    StoreDataManager.getInstance().setData(Constants.DATASTORE_COMPUTER_OPTIONS, "lastNickname", ismsg.nickname);
                    try
                    {
                        _log.info((((((("Timestamp subscription end date : " + PlayerManager.getInstance().subscriptionEndDate) + " ( ") + TimeManager.getInstance().formatDateIRL(PlayerManager.getInstance().subscriptionEndDate, true)) + " ") + TimeManager.getInstance().formatClock(PlayerManager.getInstance().subscriptionEndDate, false, true)) + " )"));
                    }
                    catch(e:Error)
                    {
                    };
                    if (ismsg.wasAlreadyConnected)
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.AlreadyConnected);
                    };
                    AuthorizedFrame(Kernel.getWorker().getFrame(AuthorizedFrame)).hasRights = ismsg.hasRights;
                    if (PlayerManager.getInstance().hasRights)
                    {
                        lengthModsTou = OptionManager.getOptionManager("dofus").getOption("legalAgreementModsTou");
                        newLengthModsTou = ((XmlConfig.getInstance().getEntry("config.lang.current") + "#") + I18n.getUiText("ui.legal.modstou").length);
                        files = new Array();
                        if (lengthModsTou != newLengthModsTou)
                        {
                            files.push("modstou");
                        };
                        if (files.length > 0)
                        {
                            PlayerManager.getInstance().allowAutoConnectCharacter = false;
                            KernelEventsManager.getInstance().processCallback(HookList.AgreementsRequired, files);
                        };
                    };
                    if (StoreUserDataManager.getInstance().statsEnabled)
                    {
                        StoreUserDataManager.getInstance().gatherUserData();
                    };
                    Kernel.getWorker().removeFrame(this);
                    Kernel.getWorker().addFrame(new ChangeCharacterFrame());
                    Kernel.getWorker().addFrame(new ServerSelectionFrame());
                    KernelEventsManager.getInstance().processCallback(HookList.IdentificationSuccess, ((ismsg.login) ? ismsg.login : ""), this._currentLogIsForced);
                    KernelEventsManager.getInstance().processCallback(HookList.SubscriptionEndDateUpdate);
                    if (StatisticsManager.getInstance().statsEnabled)
                    {
                        StatisticsManager.getInstance().setAccountId(PlayerManager.getInstance().accountId);
                    };
                    SubhintManager.getInstance().init();
                    if (BuildInfos.BUILD_TYPE >= BuildTypeEnum.INTERNAL)
                    {
                        SubhintEditorManager.getInstance().init();
                    };
                    this._zaapApi.getNeedZaapUpdate();
                    return (true);
                case (msg is IdentificationFailedForBadVersionMessage):
                    iffbvmsg = IdentificationFailedForBadVersionMessage(msg);
                    PlayerManager.getInstance().destroy();
                    ConnectionsHandler.closeConnection();
                    KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailedForBadVersion, iffbvmsg.reason, iffbvmsg.requiredVersion);
                    if (!this._dispatchModuleHook)
                    {
                        this._dispatchModuleHook = true;
                        this.pushed();
                    };
                    return (true);
                case (msg is IdentificationFailedBannedMessage):
                    ifbmsg = IdentificationFailedBannedMessage(msg);
                    PlayerManager.getInstance().destroy();
                    ConnectionsHandler.closeConnection();
                    KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailedWithDuration, ifbmsg.reason, ifbmsg.banEndDate);
                    if (!this._dispatchModuleHook)
                    {
                        this._dispatchModuleHook = true;
                        this.pushed();
                    };
                    return (true);
                case (msg is IdentificationFailedMessage):
                    ifmsg = IdentificationFailedMessage(msg);
                    PlayerManager.getInstance().destroy();
                    ConnectionsHandler.closeConnection();
                    KernelEventsManager.getInstance().processCallback(HookList.IdentificationFailed, ifmsg.reason);
                    if (!this._dispatchModuleHook)
                    {
                        this._dispatchModuleHook = true;
                        this.pushed();
                    };
                    return (true);
                case (msg is NicknameRegistrationMessage):
                    KernelEventsManager.getInstance().processCallback(HookList.NicknameRegistration);
                    return (true);
                case (msg is NicknameRefusedMessage):
                    nrfmsg = NicknameRefusedMessage(msg);
                    KernelEventsManager.getInstance().processCallback(HookList.NicknameRefused, nrfmsg.reason);
                    return (true);
                case (msg is NicknameAcceptedMessage):
                    KernelEventsManager.getInstance().processCallback(HookList.NicknameAccepted);
                    return (true);
                case (msg is NicknameChoiceRequestAction):
                    ncra = NicknameChoiceRequestAction(msg);
                    ncrmsg = new NicknameChoiceRequestMessage();
                    ncrmsg.initNicknameChoiceRequestMessage(ncra.nickname);
                    ConnectionsHandler.getConnection().send(ncrmsg);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            Berilia.getInstance().unloadUi("Login");
            this._loader.removeEventListener(ResourceErrorEvent.ERROR, this.onLoadError);
            this._loader.removeEventListener(ResourceLoadedEvent.LOADED, this.onLoad);
            return (true);
        }

        private function processInvokeArgs():void
        {
            var value:String;
            var username:String;
            var lvwta:LoginValidationWithTicketAction;
            if (((CommandLineArguments.getInstance().hasArgument("ticket")) && (CommandLineArguments.getInstance().hasArgument("username"))))
            {
                value = CommandLineArguments.getInstance().getArgument("ticket");
                username = CommandLineArguments.getInstance().getArgument("username");
                if (_lastTicket == value)
                {
                    return;
                };
                _log.info("Use ticket from launch param's");
                _lastTicket = value;
                lvwta = LoginValidationWithTicketAction.create(username, value, true);
                this.process(lvwta);
            };
        }

        private function onLoad(e:ResourceLoadedEvent):void
        {
            var jsonArray:* = undefined;
            var gift:* = undefined;
            var jdsonD:JSONDecoder;
            var subGift:SubscriberGift;
            var subGiftList:Array = new Array();
            if (e.resourceType == ResourceType.RESOURCE_JSON)
            {
                jsonArray = e.resource;
            }
            else
            {
                try
                {
                    jdsonD = new JSONDecoder(e.resource, true);
                    jsonArray = jdsonD.getValue();
                }
                catch(error:Error)
                {
                    _log.error((((("Cannot read Json " + e.uri) + "(") + error.message) + ")"));
                    return;
                };
            };
            var i:int;
            for each (gift in jsonArray)
            {
                i = (i + 1);
                subGift = new SubscriberGift(gift.article_name, gift.article_price, gift.article_pricecrossed, gift.article_visual, gift["new"], gift.promo, gift.redirect, gift.title, gift.url);
                subGiftList.push(subGift);
            };
            KernelEventsManager.getInstance().processCallback(HookList.SubscribersList, subGiftList);
        }

        private function onLoadError(e:ResourceErrorEvent):void
        {
            _log.error((((("Cannot load xml " + e.uri) + "(") + e.errorMsg) + ")"));
        }


    }
} com.ankamagames.dofus.logic.connection.frames

