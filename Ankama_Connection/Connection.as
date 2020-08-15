package Ankama_Connection
{
    import flash.display.Sprite;
    import Ankama_Connection.ui.Login;
    import Ankama_Connection.ui.LoginThirdParty;
    import Ankama_Connection.ui.ServerListSelection;
    import Ankama_Connection.ui.CharacterCreation;
    import Ankama_Connection.ui.CharacterHeader;
    import Ankama_Connection.ui.ConnectionBackground;
    import Ankama_Connection.ui.CharacterSelection;
    import Ankama_Connection.ui.PseudoChoice;
    import Ankama_Connection.ui.PreGameMainMenu;
    import Ankama_Connection.ui.GiftMenu;
    import Ankama_Connection.ui.SecretPopup;
    import Ankama_Connection.ui.UserAgreement;
    import Ankama_Connection.ui.UpdateInformation;
    import Ankama_Connection.ui.UpdateInformationFullTemplate;
    import Ankama_Connection.ui.UpdateInformationThreeTemplate;
    import Ankama_Connection.ui.items.GiftCharacterSelectionItem;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.ConnectionApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import flash.utils.Timer;
    import d2hooks.AuthentificationStart;
    import d2hooks.ServerSelectionStart;
    import d2hooks.CharacterSelectionStart;
    import d2hooks.CharacterCreationStart;
    import d2hooks.ServersList;
    import d2hooks.SelectedServerRefused;
    import d2hooks.GameStart;
    import d2hooks.GiftList;
    import d2hooks.CharactersListUpdated;
    import d2hooks.CharacterImpossibleSelection;
    import d2hooks.TutorielAvailable;
    import d2hooks.BreedsAvailable;
    import d2hooks.OpenMainMenu;
    import d2hooks.ConnectionTimerStart;
    import d2hooks.ServerConnectionFailed;
    import d2hooks.UnexpectedSocketClosure;
    import d2hooks.AlreadyConnected;
    import d2hooks.ZaapConnectionFailed;
    import d2hooks.MigratedServerList;
    import d2hooks.OpenUpdateInformation;
    import d2hooks.LoginQueueStatus;
    import d2hooks.QueueStatus;
    import d2hooks.NicknameRegistration;
    import d2hooks.IdentificationSuccess;
    import d2hooks.IdentificationFailed;
    import d2hooks.IdentificationFailedWithDuration;
    import d2hooks.IdentificationFailedForBadVersion;
    import d2hooks.AuthenticationTicketAccepted;
    import d2hooks.AuthenticationTicketRefused;
    import d2hooks.InformationPopup;
    import d2hooks.AgreementsRequired;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.jerakine.types.Version;
    import d2actions.LoginValidationWithToken;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import d2actions.ChangeServer;
    import d2actions.ChangeCharacter;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import d2actions.CharacterSelection;
    import com.ankamagames.dofus.network.types.connection.GameServerInformations;
    import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
    import d2actions.ServerSelection;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.network.enums.IdentificationFailureReasonEnum;
    import d2actions.ResetGame;
    import d2hooks.*;

    public class Connection extends Sprite 
    {

        public static var loginUiName:String = "login";
        private static var _self:Connection;
        public static var TUTORIAL_SELECTION:Boolean = false;
        public static var TUTORIAL_SELECTION_IS_AVAILABLE:Boolean = false;
        public static var BREEDS_AVAILABLE:int;
        public static var BREEDS_VISIBLE:int;
        public static var waitingForCreation:Boolean = false;
        public static var waitingForCharactersList:Boolean = false;
        public static var waitingForServersList:String = "";
        public static var loginMustBeSaved:int;

        protected var login:Login;
        protected var loginThirdParty:LoginThirdParty;
        protected var serverListSelection:ServerListSelection;
        protected var characterCreation:CharacterCreation;
        protected var characterHeader:CharacterHeader;
        protected var connectionBackground:ConnectionBackground;
        protected var characterSelection:Ankama_Connection.ui.CharacterSelection;
        protected var pseudoChoice:PseudoChoice;
        protected var preGameMainMenu:PreGameMainMenu;
        protected var giftMenu:GiftMenu;
        protected var secretPopup:SecretPopup;
        protected var userAgreement:UserAgreement;
        protected var updateInformation:UpdateInformation;
        protected var updateInformationFullTemplate:UpdateInformationFullTemplate;
        protected var updateInformationThreeTemplate:UpdateInformationThreeTemplate;
        protected var giftCharaSelectItem:GiftCharacterSelectionItem;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="ConnectionApi")]
        public var connecApi:ConnectionApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        public var previousUi:String;
        public var currentUi:String;
        public var _charaList:Object;
        public var _serversList:Object;
        public var _sPopup:String;
        public var unlocked:Boolean = false;
        private var _timeoutTimer:Timer;
        private var _timeoutPopupName:String;


        public static function getInstance():Connection
        {
            return (_self);
        }


        public function main():void
        {
            this.previousUi = "";
            this.currentUi = null;
            this.sysApi.addHook(AuthentificationStart, this.onAuthentificationStart);
            this.sysApi.addHook(ServerSelectionStart, this.onServerSelectionStart);
            this.sysApi.addHook(CharacterSelectionStart, this.onCharacterSelectionStart);
            this.sysApi.addHook(CharacterCreationStart, this.onCharacterCreationStart);
            this.sysApi.addHook(ServersList, this.onServersList);
            this.sysApi.addHook(SelectedServerRefused, this.onSelectedServerRefused);
            this.sysApi.addHook(GameStart, this.onGameStart);
            this.sysApi.addHook(GiftList, this.onGiftList);
            this.sysApi.addHook(CharactersListUpdated, this.onCharactersListUpdated);
            this.sysApi.addHook(CharacterImpossibleSelection, this.onCharacterImpossibleSelection);
            this.sysApi.addHook(TutorielAvailable, this.onTutorielAvailable);
            this.sysApi.addHook(BreedsAvailable, this.onBreedsAvailable);
            this.sysApi.addHook(OpenMainMenu, this.onOpenMainMenu);
            this.sysApi.addHook(ConnectionTimerStart, this.onConnectionTimerStart);
            this.sysApi.addHook(ServerConnectionFailed, this.onServerConnectionFailed);
            this.sysApi.addHook(UnexpectedSocketClosure, this.onUnexpectedSocketClosure);
            this.sysApi.addHook(AlreadyConnected, this.onAlreadyConnected);
            this.sysApi.addHook(ZaapConnectionFailed, this.onZaapConnectionFailed);
            this.sysApi.addHook(MigratedServerList, this.onMigratedServerList);
            this.sysApi.addHook(OpenUpdateInformation, this.onOpenUpdateInformation);
            this.sysApi.addHook(LoginQueueStatus, this.removeTimer);
            this.sysApi.addHook(QueueStatus, this.removeTimer);
            this.sysApi.addHook(NicknameRegistration, this.removeTimer);
            this.sysApi.addHook(IdentificationSuccess, this.onIdentificationSuccess);
            this.sysApi.addHook(IdentificationFailed, this.onIdentificationFailed);
            this.sysApi.addHook(IdentificationFailedWithDuration, this.onIdentificationFailed);
            this.sysApi.addHook(IdentificationFailedForBadVersion, this.onIdentificationFailedForBadVersion);
            this.sysApi.addHook(AuthenticationTicketAccepted, this.onConnectionStart);
            this.sysApi.addHook(AuthenticationTicketRefused, this.removeTimer);
            this.sysApi.addHook(InformationPopup, this.onInformationPopup);
            if (this.sysApi.getConfigEntry("config.community.current") != "ja")
            {
                this.sysApi.addHook(AgreementsRequired, this.onAgreementsRequired);
            };
            this.uiApi.addShortcutHook("closeUi", this.onOpenMainMenu);
            if (this.sysApi.getConfigEntry("config.loginMode") == "web")
            {
                loginUiName = "loginThirdParty";
            };
            loginMustBeSaved = this.sysApi.getData("saveLogin");
            _self = this;
        }

        public function unload():void
        {
            this.removeTimer();
            _self = null;
            this._charaList = null;
            this._serversList = null;
        }

        public function get charactersCount():int
        {
            if (this._charaList)
            {
                return (this._charaList.length);
            };
            return (0);
        }

        public function connexionEnd():void
        {
            this.onGameStart();
        }

        public function characterCreationStart(charactersList:Object=null):void
        {
            waitingForCreation = true;
            this.onCharacterCreationStart([null, null, null, charactersList]);
        }

        public function displayHeader(withAccountInfo:Boolean=true):void
        {
            var connectionBackground:Object = this.uiApi.getUi("connectionBackground");
            if (!connectionBackground)
            {
                this.uiApi.loadUi("connectionBackground", "connectionBackground", null, StrataEnum.STRATA_LOW);
            };
            var header:Object = this.uiApi.getUi("characterHeader");
            if (!header)
            {
                this.uiApi.loadUi("characterHeader", "characterHeader", withAccountInfo, StrataEnum.STRATA_HIGH);
            }
            else
            {
                if (withAccountInfo)
                {
                    if (header.uiClass)
                    {
                        header.uiClass.showHeader(true);
                    };
                };
            };
        }

        private function onAgreementsRequired(files:Object):void
        {
            if (!this.uiApi.getUi("userAgreement"))
            {
                this.uiApi.loadUi("userAgreement", "userAgreement", files, 3);
            };
        }

        private function onAuthentificationStart(mustDisplayLogin:Boolean=false):void
        {
            var skinName:String;
            var version:Version;
            var lastCustomUISkinWarning:uint;
            this.displayHeader(false);
            if (((this.sysApi.isUsingZaapLogin()) && (!(mustDisplayLogin))))
            {
                this.sysApi.sendAction(new LoginValidationWithToken());
            };
            this.uiApi.loadUi(loginUiName, null, [this._sPopup, (!(mustDisplayLogin))], 1, null, true);
            this.sysApi.setData("forceServerListDisplay", false, DataStoreEnum.BIND_ACCOUNT);
            this.sysApi.setData("forceCharacterCreationDisplay", false, DataStoreEnum.BIND_ACCOUNT);
            if (this.sysApi.useCustomUISkin())
            {
                skinName = this.sysApi.getOption("currentUiSkin", "dofus");
                version = this.sysApi.getCurrentVersion();
                lastCustomUISkinWarning = this.sysApi.getData(("lastCustomUISkinWarningWithVersion_" + skinName));
                if (((lastCustomUISkinWarning) && (lastCustomUISkinWarning == version.minor)))
                {
                    return;
                };
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.popup.customTheme.warningContent"), [this.uiApi.getText("ui.popup.customTheme.restaureDefault"), this.uiApi.getText("ui.popup.doNotShowAgain")], [this.onRestoreUiSkin, this.onDoNotShowUISkinPopupAnymore], this.onRestoreUiSkin, null, null, false, false, false);
            };
        }

        public function openPreviousUi():void
        {
            switch (this.previousUi)
            {
                case "characterCreation":
                case loginUiName:
                    this.onPreviousUiStart();
                    break;
                case "serverListSelection":
                    this.sysApi.sendAction(new ChangeServer());
                    break;
                case "characterSelection":
                default:
                    if (((this._charaList) && (this._charaList.length > 0)))
                    {
                        waitingForCharactersList = true;
                        this.onCharacterSelectionStart(this._charaList);
                    }
                    else
                    {
                        if (this.sysApi.getCurrentServer())
                        {
                            this.sysApi.sendAction(new ChangeCharacter(this.sysApi.getCurrentServer().id));
                        }
                        else
                        {
                            this.sysApi.sendAction(new ChangeServer());
                        };
                    };
            };
        }

        private function unlockLogin():void
        {
            var login:Object = this.uiApi.getUi("login");
            this.unlocked = true;
            if (((login) && (login.uiClass)))
            {
                login.uiClass.unlockUi();
            };
        }

        private function onConnectionStart():void
        {
            if (this.uiApi.getUi(loginUiName))
            {
                this.previousUi = loginUiName;
                this.uiApi.unloadUi(loginUiName);
                this.uiApi.unloadUi(UIEnum.WEB_PORTAL);
            };
        }

        private function onCharacterSelectionStart(characterList:Object):void
        {
            if (((!(this.uiApi.getUi("characterCreation"))) || (waitingForCharactersList)))
            {
                if (TUTORIAL_SELECTION)
                {
                    if (TUTORIAL_SELECTION_IS_AVAILABLE)
                    {
                        TUTORIAL_SELECTION = false;
                        this.sysApi.sendAction(new d2actions.CharacterSelection(characterList[0].id, true));
                    }
                    else
                    {
                        this.sysApi.sendAction(new d2actions.CharacterSelection(characterList[0].id, false));
                    };
                }
                else
                {
                    this._charaList = characterList;
                    if (!this.uiApi.getUi("characterSelection"))
                    {
                        this.uiApi.loadUi("characterSelection", "characterSelection", this._charaList);
                    };
                    this.previousUi = this.currentUi;
                    this.currentUi = "characterSelection";
                    if (this.previousUi)
                    {
                        this.uiApi.unloadUi(this.previousUi);
                    };
                    this.displayHeader();
                };
                waitingForCharactersList = false;
            };
        }

        private function onCharacterCreationStart(params:Object=null):void
        {
            if ((((waitingForCreation) || ((((params) && (params[0])) && (params[0][0] == "create")) && (params[1] == true))) || (((params) && (params[0])) && (!(params[0][0] == "create")))))
            {
                if (!this.uiApi.getUi("characterCreation"))
                {
                    this.sysApi.setData("forceCharacterCreationDisplay", false, DataStoreEnum.BIND_ACCOUNT);
                    this.uiApi.loadUi("characterCreation", "characterCreation", params);
                    this.previousUi = this.currentUi;
                    this.currentUi = "characterCreation";
                    if (this.previousUi)
                    {
                        this.uiApi.unloadUi(this.previousUi);
                    };
                };
                waitingForCreation = false;
                this.displayHeader();
            };
        }

        private function onServerSelectionStart(params:Object=null):void
        {
            waitingForCreation = params[1];
            this.uiApi.loadUi("serverListSelection");
            this.previousUi = this.currentUi;
            this.currentUi = "serverListSelection";
            if (this.previousUi)
            {
                this.uiApi.unloadUi(this.previousUi);
            };
            this.displayHeader();
        }

        private function onServersList(serverList:Object):void
        {
            var serversWithCharacters:Array;
            var server:Object;
            var isServerListDisplayForced:Boolean;
            var chosenServer:GameServerInformations;
            this._serversList = serverList;
            if (!this.uiApi.getUi("serverListSelection"))
            {
                serversWithCharacters = new Array();
                for each (server in this.connecApi.getUsedServers())
                {
                    serversWithCharacters.push(server);
                };
                isServerListDisplayForced = this.sysApi.getData("forceServerListDisplay", DataStoreEnum.BIND_ACCOUNT);
                if ((((serversWithCharacters.length == 0) || (waitingForCreation)) && (!(isServerListDisplayForced))))
                {
                    waitingForCreation = true;
                    chosenServer = this.connecApi.getAutoChosenServer(GameServerTypeEnum.SERVER_TYPE_CLASSICAL);
                    if (chosenServer)
                    {
                        this.sysApi.log(2, ("Connexion au serveur " + chosenServer.id));
                        this.sysApi.sendAction(new ServerSelection(chosenServer.id));
                        return;
                    };
                };
                this.uiApi.loadUi("serverListSelection");
                this.previousUi = this.currentUi;
                this.currentUi = "serverListSelection";
                this.sysApi.setData("forceServerListDisplay", false, DataStoreEnum.BIND_ACCOUNT);
                if (this.previousUi)
                {
                    this.uiApi.unloadUi(this.previousUi);
                };
                this.displayHeader();
            };
        }

        private function onPreviousUiStart():void
        {
            this.uiApi.loadUi(this.previousUi);
            var currUi:String = this.previousUi;
            this.previousUi = this.currentUi;
            this.currentUi = currUi;
            if (this.previousUi)
            {
                this.uiApi.unloadUi(this.previousUi);
            };
            this.displayHeader();
        }

        private function onGameStart():void
        {
            this.uiApi.unloadUi(this.currentUi);
            this.uiApi.unloadUi("characterSelection");
            this.uiApi.unloadUi("characterHeader");
            this._charaList = null;
        }

        private function onOpenMainMenu(s:String=""):Boolean
        {
            if (!this.uiApi.getUi("preGameMainMenu"))
            {
                this.uiApi.loadUi("preGameMainMenu", null, [], 3);
            }
            else
            {
                this.uiApi.unloadUi("preGameMainMenu");
            };
            return (true);
        }

        private function onGiftList(giftList:Object, characterList:Object):void
        {
            if (!this.uiApi.getUi("giftMenu"))
            {
                this.uiApi.loadUi("giftMenu", "giftMenu", {
                    "gift":giftList,
                    "chara":characterList
                }, 2);
            };
            this.previousUi = this.currentUi;
            this.currentUi = "giftMenu";
            if (this.previousUi)
            {
                this.uiApi.unloadUi(this.previousUi);
            };
        }

        private function onTutorielAvailable(tutorielAvailable:Boolean):void
        {
            TUTORIAL_SELECTION_IS_AVAILABLE = tutorielAvailable;
        }

        private function onBreedsAvailable(breedsAvailable:int, breedsVisible:int):void
        {
            BREEDS_AVAILABLE = breedsAvailable;
            BREEDS_VISIBLE = breedsVisible;
        }

        public function onCharactersListUpdated(charactersList:Object):void
        {
            var cha:*;
            this._charaList = new Array();
            for each (cha in charactersList)
            {
                this._charaList.push(cha);
            };
        }

        public function onConnectionTimerStart():void
        {
            if (this._timeoutTimer)
            {
                this._timeoutTimer.removeEventListener(TimerEvent.TIMER, this.onTimeOut);
                this._timeoutTimer.reset();
                this._timeoutTimer = null;
            };
            this._timeoutTimer = new Timer(10000, 1);
            this._timeoutTimer.start();
            this._timeoutTimer.addEventListener(TimerEvent.TIMER, this.onTimeOut);
        }

        public function onCharacterImpossibleSelection(pCharacterId:Number):void
        {
        }

        public function onSelectedServerRefused(serverId:int, error:String, selectableServers:Object):void
        {
            var text:String;
            var servList:String;
            var server:*;
            this.removeTimer();
            switch (error)
            {
                case "AccountRestricted":
                    text = this.uiApi.getText("ui.server.cantChoose.serverForbidden");
                    break;
                case "CommunityRestricted":
                    text = this.uiApi.getText("ui.server.cantChoose.communityRestricted");
                    break;
                case "LocationRestricted":
                    text = this.uiApi.getText("ui.server.cantChoose.locationRestricted");
                    break;
                case "SubscribersOnly":
                    text = this.uiApi.getText("ui.server.cantChoose.communityNonSubscriberRestricted");
                    break;
                case "RegularPlayersOnly":
                    text = this.uiApi.getText("ui.server.cantChoose.regularPlayerRestricted");
                    break;
                case "MonoaccountCannotVerify":
                    text = this.uiApi.getText("ui.server.cantChoose.monoaccountNotVerified");
                    break;
                case "MonoaccountOnly":
                    text = this.uiApi.getText("ui.server.cantChoose.monoaccountNotMono");
                    break;
                case "ServerFull":
                    if (this.sysApi.getCurrentLanguage() == "fr")
                    {
                        text = "Ce serveur est complet. Nombre maximum de joueurs atteint. Vous pouvez tenter de vous connecter sur un autre serveur.";
                    }
                    else
                    {
                        text = "This server is full. The maximum number of players has been reached. You can try logging on to another server.";
                    };
                    break;
                case "StatusOffline":
                    this.sysApi.log(2, "StatusOffline");
                    text = this.uiApi.getText("ui.server.cantChoose.serverDown");
                    break;
                case "StatusStarting":
                    this.sysApi.log(2, "StatusStarting");
                    text = this.uiApi.getText("ui.server.cantChoose.serverDown");
                    break;
                case "StatusNojoin":
                    this.sysApi.log(2, "StatusNojoin");
                    text = this.uiApi.getText("ui.server.cantChoose.serverForbidden");
                    break;
                case "StatusSaving":
                    this.sysApi.log(2, "StatusSaving");
                    text = this.uiApi.getText("ui.server.cantChoose.serverSaving");
                    break;
                case "StatusStoping":
                    this.sysApi.log(2, "StatusStoping");
                    text = this.uiApi.getText("ui.server.cantChoose.serverDown");
                    break;
                case "StatusFull":
                    text = (this.uiApi.getText("ui.server.cantChoose.serverFull") + "\n\n");
                    servList = "";
                    for each (server in selectableServers)
                    {
                        servList = (servList + (this.dataApi.getServer(server).name + ", "));
                    };
                    if (servList != "")
                    {
                        servList = servList.substr(0, (servList.length - 2));
                    }
                    else
                    {
                        servList = this.uiApi.getText("ui.common.none").toLocaleLowerCase();
                    };
                    text = (text + this.uiApi.getText("ui.server.serversAccessibles", servList));
                    break;
                case "NoReason":
                case "StatusUnknown":
                    text = this.uiApi.getText("ui.popup.connectionRefused");
                    break;
            };
            if (text)
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), text, [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
            };
        }

        public function onIdentificationFailed(reason:uint, endDate:Number=0):void
        {
            var msgStr:String;
            this.removeTimer();
            if (reason > 0)
            {
                switch (reason)
                {
                    case IdentificationFailureReasonEnum.BANNED:
                        if (endDate == 0)
                        {
                            this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.banned"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        }
                        else
                        {
                            this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.bannedWithDuration", ((this.timeApi.getDate(endDate, true) + " ") + this.timeApi.getClock(endDate, false, true))), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        };
                        break;
                    case IdentificationFailureReasonEnum.IN_MAINTENANCE:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.inMaintenance"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.KICKED:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.kicked"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.UNKNOWN_AUTH_ERROR:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.unknown"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.WRONG_CREDENTIALS:
                        msgStr = this.uiApi.getText("ui.popup.accessDenied.wrongCredentials");
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), msgStr, [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.BAD_IPRANGE:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.badIpRange"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.TOO_MANY_ON_IP:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.toomanyonip"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.TIME_OUT:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.timeout"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.CREDENTIALS_RESET:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.credentialsReset"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.EMAIL_UNVALIDATED:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.unvalidatedEmail"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.SERVICE_UNAVAILABLE:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.serviceUnavailable"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.OTP_TIMEOUT:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.otpTimeout"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.SPARE:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), "", [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                    case IdentificationFailureReasonEnum.LOCKED:
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.locked"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, false, true);
                        break;
                };
            };
            this.unlockLogin();
        }

        public function onIdentificationSuccess(login:String, isForced:Boolean):void
        {
            var oldLogins:Array;
            var logins:Array;
            var oldLogIndex:*;
            var oldLog:String;
            var logins2:Array;
            var oldLog2:String;
            this.removeTimer();
            if (((login) && (login.length > 0)))
            {
                if (((!(login.indexOf("[") == -1)) && (!(login.indexOf("]") == -1))))
                {
                    return;
                };
                oldLogins = this.sysApi.getData("LastLogins");
                if (loginMustBeSaved > -1)
                {
                    logins = new Array();
                    for (oldLogIndex in oldLogins)
                    {
                        if (((oldLogins[oldLogIndex]) && (oldLogins[oldLogIndex].toLowerCase() == login.toLowerCase())))
                        {
                            oldLogins.splice(oldLogIndex, 1);
                            break;
                        };
                    };
                    if (!isForced)
                    {
                        logins.push(login);
                    };
                    for each (oldLog in oldLogins)
                    {
                        if (((logins.length < 10) && (logins.indexOf(oldLog) == -1)))
                        {
                            logins.push(oldLog);
                        };
                    };
                    this.sysApi.setData("LastLogins", logins);
                }
                else
                {
                    if (((oldLogins) && (oldLogins.length > 0)))
                    {
                        logins2 = new Array();
                        for each (oldLog2 in oldLogins)
                        {
                            if (((oldLog2) && (!(oldLog2.toLowerCase() == login.toLowerCase()))))
                            {
                                logins2.push(oldLog2);
                            };
                        };
                        this.sysApi.setData("LastLogins", logins2);
                    };
                };
            };
        }

        public function onIdentificationFailedForBadVersion(reason:uint, requiredVersion:Object):void
        {
            this.removeTimer();
            if (reason == IdentificationFailureReasonEnum.BAD_VERSION)
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.accessDenied.badVersion", this.sysApi.getCurrentVersion(), ((((((requiredVersion.major + ".") + requiredVersion.minor) + ".") + requiredVersion.code) + ".") + requiredVersion.build)), [this.uiApi.getText("ui.common.ok")]);
            };
            this.unlockLogin();
        }

        public function onServerConnectionFailed(reason:uint=0):void
        {
            this.removeTimer();
            if (reason == 4)
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"), this.uiApi.getText("ui.popup.silentServer"), [this.uiApi.getText("ui.common.ok")]);
            }
            else
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.popup.connectionFailed.text"), [this.uiApi.getText("ui.common.ok")]);
            };
            this.unlockLogin();
        }

        public function onUnexpectedSocketClosure():void
        {
            this.removeTimer();
            this._sPopup = "unexpectedSocketClosure";
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.unexpectedSocketClosure"), this.uiApi.getText("ui.popup.unexpectedSocketClosure.text"), [this.uiApi.getText("ui.common.ok")]);
            this.unlockLogin();
        }

        public function onAlreadyConnected():void
        {
            this.removeTimer();
            this.modCommon.openIllustratedWithLinkPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.connection.wasAlreadyConnected"), this.uiApi.getText("ui.connection.secureMyAccount.link"), "tx_illu_secure.jpg", null, this.uiApi.getText("ui.connection.secureMyAccount"));
            this.unlockLogin();
        }

        public function onInformationPopup(msg:String):void
        {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), msg, [this.uiApi.getText("ui.common.ok")]);
        }

        public function onTimeOut(e:TimerEvent):void
        {
            this.removeTimer();
            this._timeoutPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.popup.accessDenied.timeout"), [this.uiApi.getText("ui.common.wait"), this.uiApi.getText("ui.common.interrupt")], [this.onPopupWait, this.onPopupInterrupt], this.onPopupWait, this.onPopupInterrupt);
        }

        public function onPopupWait():void
        {
        }

        public function onRestoreUiSkin():void
        {
            this.sysApi.resetCustomUISkin();
        }

        public function onDoNotShowUISkinPopupAnymore():void
        {
            var skinName:String = this.sysApi.getOption("currentUiSkin", "dofus");
            var version:Version = this.sysApi.getCurrentVersion();
            this.sysApi.setData(("lastCustomUISkinWarningWithVersion_" + skinName), version.minor);
        }

        public function onPopupInterrupt():void
        {
            this.sysApi.sendAction(new ResetGame());
        }

        public function removeTimer(... args):void
        {
            if (this._timeoutTimer)
            {
                this._timeoutTimer.removeEventListener(TimerEvent.TIMER, this.onTimeOut);
                this._timeoutTimer.reset();
                this._timeoutTimer = null;
            };
        }

        private function onZaapConnectionFailed():void
        {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.connection.updaterConnectionFailed"), [this.uiApi.getText("ui.common.ok")]);
        }

        private function onMigratedServerList(migratedServerIds:Object):void
        {
            var serverFusionWarning:Boolean = this.sysApi.getData("serverFusionWarning");
            if (!serverFusionWarning)
            {
                this.modCommon.openIllustratedWithLinkPopup(this.uiApi.getText("ui.popup.serverfusion.title"), this.uiApi.getText("ui.popup.serverfusion.desc"), this.uiApi.getText("ui.popup.serverfusion.link"), "tx_illu_serverFusion.jpg", null);
                this.sysApi.setData("serverFusionWarning", true);
            };
        }

        private function onOpenUpdateInformation():void
        {
            if (!this.uiApi.getUi("updateInformation"))
            {
                this.uiApi.loadUi("updateInformation", null, null, 3);
            };
        }


    }
}

