package com.ankamagames.dofus.misc.utils.errormanager
{
    import com.ankamagames.jerakine.handlers.AbstractErrorHandler;
    import damageCalculation.tools.LinkedList;
    import com.ankamagames.jerakine.logger.targets.FixedBufferTarget;
    import flash.utils.Timer;
    import com.ankamagames.jerakine.logger.Log;
    import flash.filesystem.File;
    import com.ankamagames.jerakine.logger.TextLogEvent;
    import com.ankamagames.jerakine.types.events.ErrorReportedEvent;
    import flash.filesystem.FileStream;
    import flash.filesystem.FileMode;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.jerakine.managers.ErrorManager;
    import com.ankamagames.jerakine.utils.system.SystemManager;
    import com.ankamagames.jerakine.enum.OperatingSystem;
    import flash.ui.Keyboard;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.kernel.sound.manager.RegConnectionManager;
    import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
    import flash.events.KeyboardEvent;
    import com.ankamagames.dofus.misc.utils.DebugTarget;
    import flash.events.Event;
    import com.ankamagames.jerakine.utils.system.SystemPopupUI;
    import flash.utils.getTimer;
    import flash.system.System;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import com.ankamagames.dofus.misc.interClient.InterClientManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.jerakine.managers.LangManager;
    import com.ankamagames.dofus.kernel.zaap.ZaapConnectionHelper;
    import com.ankamagames.dofus.kernel.zaap.ZaapApi;
    import com.ankamagames.berilia.managers.ThemeManager;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
    import damageCalculation.tools.LinkedListIterator;
    import com.ankamagames.jerakine.logger.LogEvent;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
    import flash.system.Capabilities;
    import flash.desktop.NativeApplication;
    import com.ankamagames.dofus.misc.BuildTypeParser;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.jerakine.messages.Frame;

    public class DofusErrorHandler extends AbstractErrorHandler 
    {

        public static var maxStackTracelength:uint = 1000;
        public static var debugManuallyActivated:Boolean = false;
        private static const MANUAL_BUG_REPORT_TXT:String = "Manual bug report";
        private static var _lastError:uint;
        private static var _self:DofusErrorHandler;
        private static var _formattedLogBufferReg:LinkedList;

        private var _localSaveReport:Boolean = false;
        private var _distantSaveReport:Boolean = false;
        private var _sendErrorToWebservice:Boolean = false;
        private var _initialLogBuffer:FixedBufferTarget;
        private var _timeoutTimer:Timer;

        public function DofusErrorHandler(autoInit:Boolean=true)
        {
            this.createEmptyLog4As();
            super("Dofus", "", autoInit);
            _self = this;
            this._initialLogBuffer = new FixedBufferTarget(1000);
            this._initialLogBuffer.setCallbackOnBufferFull(this.flushCurrentBuffer);
            Log.addTarget(this._initialLogBuffer);
        }

        public static function get debugFileExists():Boolean
        {
            return ((File.applicationDirectory.resolvePath("debug").exists) || (File.applicationDirectory.resolvePath("debug.txt").exists));
        }

        public static function activateDebugMode():void
        {
            _self.activeManually();
        }

        public static function captureMessage(message:String, tags:Object=null, level:int=40):void
        {
            _self.captureMessage(message, tags, level);
        }

        public static function formatLogBufferReg(data:String):void
        {
            var params:String;
            var logParams:Array;
            var date:Date;
            var textLog:TextLogEvent;
            _self.stopConnectionTimeout();
            _formattedLogBufferReg = new LinkedList();
            var logs:Array = data.split("$");
            for each (params in logs)
            {
                logParams = params.split("|");
                date = new Date();
                date.setTime(logParams[3]);
                textLog = new TextLogEvent(logParams[0], logParams[1], logParams[2]);
                textLog.timestamp = date;
                textLog.time = date.time;
                textLog.stackTrace = logParams[4];
                _formattedLogBufferReg.add(textLog);
            };
            _self.onError(new ErrorReportedEvent(null, MANUAL_BUG_REPORT_TXT));
        }


        private function flushCurrentBuffer():void
        {
            _logBuffer.clearBuffer();
        }

        override protected function createEmptyLog4As():void
        {
            var sosFile:File;
            var fs:FileStream;
            super.createEmptyLog4As();
            sosFile = new File(File.applicationDirectory.resolvePath(Log.CONFIG_FILE).nativePath);
            if (!sosFile.exists)
            {
                try
                {
                    fs = new FileStream();
                    fs.open(sosFile, FileMode.WRITE);
                    fs.writeUTFBytes(<logging>
                                <targets>
                                </targets>
                            </logging>
                    );
                    fs.close();
                }
                catch(e:Error)
                {
                    _log.error(((("Cannot create " + sosFile.nativePath) + " : ") + e.message));
                };
            };
        }

        override protected function init():void
        {
            super.init();
            this.activeManually();
            switch (BuildInfos.BUILD_TYPE)
            {
                case BuildTypeEnum.RELEASE:
                    break;
                case BuildTypeEnum.BETA:
                case BuildTypeEnum.ALPHA:
                    this._localSaveReport = true;
                    break;
                case BuildTypeEnum.TESTING:
                case BuildTypeEnum.INTERNAL:
                    this.activeSOS();
                    this.activeShortcut();
                    ErrorManager.showPopup = true;
                    this._localSaveReport = true;
                    this._distantSaveReport = true;
                    break;
                default:
                    this.activeSOS();
                    this.activeShortcut();
                    this._localSaveReport = true;
                    this._distantSaveReport = true;
            };
            if (BuildInfos.BUILD_TYPE != BuildTypeEnum.DEBUG)
            {
                initSentry(BuildInfos.VERSION, BuildInfos.buildTypeName, (BuildInfos.VERSION.buildType >= BuildTypeEnum.TESTING));
            };
        }

        public function activeManually():void
        {
            if (((debugFileExists) || (debugManuallyActivated)))
            {
                this.activeShortcut();
                this.activeSOS();
                this.updateDebugFile();
                Log.exitIfNoConfigFile = false;
                this._localSaveReport = true;
            };
        }

        override protected function updateDebugFile():void
        {
            if ((((debugFileExists) || (debugManuallyActivated)) || (!(_sentryLevel == SENTRY_DISABLED))))
            {
                createDebugFile();
            }
            else
            {
                removeDebugFile();
            };
        }

        private function onKeyUp(e:KeyboardEvent):void
        {
            if (!debugManuallyActivated)
            {
                return;
            };
            if (SystemManager.getSingleton().os == OperatingSystem.MAC_OS)
            {
                if (e.keyCode == Keyboard.F1)
                {
                    this._timeoutTimer = new Timer(2000, 1);
                    this._timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onSocketTimeOut);
                    this._timeoutTimer.start();
                    RegConnectionManager.getInstance().send(ProtocolEnum.NEED_REG_LOGS);
                };
            }
            else
            {
                if (e.keyCode == Keyboard.F11)
                {
                    this._timeoutTimer = new Timer(2000, 1);
                    this._timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onSocketTimeOut);
                    this._timeoutTimer.start();
                    RegConnectionManager.getInstance().send(ProtocolEnum.NEED_REG_LOGS);
                };
            };
        }

        public function activeSOS():void
        {
            var fs:FileStream;
            var sosFile:File = new File(File.applicationDirectory.resolvePath(Log.CONFIG_FILE).nativePath);
            if (!sosFile.exists)
            {
                fs = new FileStream();
                fs.open(sosFile, FileMode.WRITE);
                fs.writeUTFBytes(<logging>
					<targets>
						<target module="com.ankamagames.jerakine.logger.targets.SOSTarget"/>
					</targets>
				</logging>
                );
                fs.close();
            };
            Log.addTarget(new DebugTarget());
        }

        public function activeShortcut(e:Event=null):void
        {
            Dofus.getInstance().stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        }

        override protected function onError(e:ErrorReportedEvent):void
        {
            var error:Error;
            var report:ErrorReport;
            var stackTrace:String;
            var realStacktrace:String;
            var tmp:Array;
            var line:String;
            var buttons:Array;
            var popup:SystemPopupUI;
            super.onError(e);
            var txt:String = e.text;
            error = e.error;
            if (((error) && (error.getStackTrace())))
            {
                if (txt.length)
                {
                    txt = (txt + "\n\n");
                };
                stackTrace = "";
                realStacktrace = error.getStackTrace();
                tmp = realStacktrace.split("\n");
                for each (line in tmp)
                {
                    if (((line.indexOf("ErrorManager") == -1) || (line.indexOf("addError") == -1)))
                    {
                        stackTrace = (stackTrace + (((stackTrace.length) ? "\n" : "") + line));
                    };
                };
                txt = (txt + stackTrace.substr(0, maxStackTracelength));
                if (stackTrace.length > maxStackTracelength)
                {
                    txt = (txt + " ...");
                };
            };
            var reportInfo:Object = this.getReportInfo(error, e.text);
            report = new ErrorReport(reportInfo);
            _lastError = getTimer();
            if (e.showPopup)
            {
                buttons = [];
                popup = new SystemPopupUI(("exception" + Math.random()));
                popup.width = 1000;
                popup.centerContent = false;
                popup.title = "Information";
                popup.content = txt;
                buttons.push({"label":"Skip"});
                if (error)
                {
                    buttons.push({
                        "label":"Copy to clipboard",
                        "callback":function ():void
                        {
                            System.setClipboard(((e.text + "\n\n") + error.getStackTrace()));
                        }
                    });
                };
                if (this._localSaveReport)
                {
                    buttons.push({
                        "label":"Save report",
                        "callback":function ():void
                        {
                            report.saveReport();
                        }
                    });
                };
                if (this._distantSaveReport)
                {
                    buttons.push({
                        "label":"Send report",
                        "callback":function ():void
                        {
                            report.sendReport();
                        }
                    });
                };
                popup.buttons = buttons;
                popup.show();
            };
        }

        override protected function getUserInfo():Object
        {
            var o:Object = super.getUserInfo();
            if (PlayerManager.getInstance().accountId != 0)
            {
                o.id = PlayerManager.getInstance().accountId;
            };
            if (AuthentificationManager.getInstance().username)
            {
                o.username = AuthentificationManager.getInstance().username;
            };
            return (o);
        }

        override protected function getTags():Object
        {
            var o:Object = super.getTags();
            if (((StageShareManager.stage) && (!(StageShareManager.stage.nativeWindow.closed))))
            {
                o.resolution = ((StageShareManager.stage.nativeWindow.width + "x") + StageShareManager.stage.nativeWindow.height);
            };
            o.multiAccount = (!(InterClientManager.getInstance().isAlone));
            if (PlayerManager.getInstance().server)
            {
                o.serverId = PlayerManager.getInstance().server.id;
                o.serverName = PlayerManager.getInstance().server.name;
            };
            if (PlayedCharacterManager.getInstance().infos)
            {
                o.characterName = PlayedCharacterManager.getInstance().infos.name;
                o.characterId = PlayedCharacterManager.getInstance().id;
                o.bddCharacterId = PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId;
            };
            o.lang = LangManager.getInstance().lang;
            o.isUsingZaap = ZaapConnectionHelper.hasZaapArguments();
            o.isUsingZaapLogin = ZaapApi.canLoginWithZaap();
            o.isConnectedToZaapOrUpdater = ZaapApi.isConnected();
            o.isSubscribed = (PlayerManager.getInstance().subscriptionEndDate > 0);
            o.isAdmin = PlayerManager.getInstance().hasRights;
            if (ThemeManager.getInstance().currentTheme)
            {
                o.theme = ThemeManager.getInstance().currentTheme;
            };
            var currentMap:WorldPointWrapper = PlayedCharacterManager.getInstance().currentMap;
            if (currentMap)
            {
                o.mapId = currentMap.mapId;
                o.mapCoordinates = ((currentMap.x + ",") + currentMap.y);
            };
            o.isFighting = PlayedCharacterManager.getInstance().isFighting;
            o.isSpectator = PlayedCharacterManager.getInstance().isSpectator;
            if (PlayedCharacterManager.getInstance().isFighting)
            {
                o.isPlayerTurn = (this.getFightFrame().battleFrame.currentPlayerId == PlayedCharacterManager.getInstance().id);
            };
            return (o);
        }

        override protected function getExtras():Object
        {
            var flashKeyParts:Array;
            var o:Object = super.getExtras();
            if (PlayerManager.getInstance().nickname)
            {
                o.nickname = PlayerManager.getInstance().nickname;
            };
            var flashKey:String = InterClientManager.getInstance().flashKey;
            if (flashKey)
            {
                flashKeyParts = flashKey.split("#");
                o.flashKey = new Object();
                if (flashKeyParts.length > 1)
                {
                    o.flashKey.id = parseInt(flashKeyParts[1]);
                };
                o.flashKey.base = flashKeyParts[0];
            };
            if (PlayedCharacterManager.getInstance().infos)
            {
                o.look = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook).toString();
            };
            if (PlayedCharacterManager.getInstance().isFighting)
            {
                o.fightId = PlayedCharacterManager.getInstance().fightId;
            };
            return (o);
        }

        public function getReportInfo(error:Error, txt:String):Object
        {
            var date:Date;
            var o:Object;
            var userNameData:Array;
            var currentMap:WorldPointWrapper;
            var obstacles:Array;
            var entities:Array;
            var los:Array;
            var cellId:uint;
            var mp:MapPoint;
            var fightContextFrame:FightContextFrame;
            var entityInfoProvider:AbstractEntitiesFrame;
            var htmlBuffer:String;
            var logs:LinkedList;
            var currentLogs:LinkedList;
            var iterator:LinkedListIterator;
            var log:LogEvent;
            var htmlBufferReg:String;
            var iteratorReg:LinkedListIterator;
            var logReg:LogEvent;
            var screenshot:BitmapData;
            var m:Matrix;
            var fightId:int;
            var fighterBuffer:String;
            var fighters:Vector.<Number>;
            var fighterId:Number;
            var fighterInfos:FighterInformations;
            var level:int;
            var levelText:String;
            var entitiesOnCell:Array;
            var entity:IEntity;
            var entityInfo:GameContextActorInformations;
            var entityInfoDataStr:String;
            var key:String;
            var interactiveElements:Vector.<InteractiveElement>;
            var ie:InteractiveElement;
            var iePos:MapPoint;
            var ieInfoDataStr:String;
            var keyIe:String;
            try
            {
                date = new Date();
                o = new Object();
                o.flashVersion = Capabilities.version;
                o.flashVersion = (o.flashVersion + ((" (AIR " + NativeApplication.nativeApplication.runtimeVersion) + ")"));
                o.os = Capabilities.os;
                o.time = ((((date.hours + ":") + date.minutes) + ":") + date.seconds);
                o.date = ((((date.date + "/") + (date.month + 1)) + "/") + date.fullYear);
                o.buildType = BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE);
                o.appPath = File.applicationDirectory.nativePath;
                o.buildVersion = BuildInfos.VERSION;
                if (_logBuffer)
                {
                    htmlBuffer = "";
                    logs = new LinkedList();
                    if (this._initialLogBuffer.isFull)
                    {
                        logs = this._initialLogBuffer.getBuffer().copy();
                    };
                    currentLogs = _logBuffer.getBuffer().copy();
                    logs.append(currentLogs);
                    iterator = logs.iterator();
                    while (iterator.hasNext())
                    {
                        log = (iterator.next().item as LogEvent);
                        if (((log) && (log.level > 0)))
                        {
                            htmlBuffer = (htmlBuffer + (((((('\t\t\t<li class="l_' + log.level) + '">[') + log.formattedTimestamp) + "] ") + log.message) + "</li>\n"));
                        };
                    };
                    o.logSos = htmlBuffer;
                    if (_formattedLogBufferReg)
                    {
                        htmlBufferReg = "";
                        iteratorReg = _formattedLogBufferReg.iterator();
                        while (iteratorReg.hasNext())
                        {
                            logReg = (iteratorReg.next().item as LogEvent);
                            if (((logReg) && (logReg.level > 0)))
                            {
                                htmlBufferReg = (htmlBufferReg + (((((('\t\t\t<li class="l_' + logReg.level) + '">[') + logReg.formattedTimestamp) + "] ") + logReg.message) + "</li>\n"));
                            };
                        };
                        o.logSosReg = htmlBufferReg;
                    };
                };
                o.errorMsg = txt;
                if (error)
                {
                    o.stacktrace = error.getStackTrace();
                };
                userNameData = File.documentsDirectory.nativePath.split(File.separator);
                o.user = userNameData[2];
                o.multicompte = (!(InterClientManager.getInstance().isAlone));
                if ((getTimer() - _lastError) > 500)
                {
                    screenshot = new BitmapData(640, 0x0200, false);
                    m = new Matrix();
                    m.scale(0.5, 0.5);
                    screenshot.draw(StageShareManager.stage, m, null, null, null, true);
                    o.screenshot = screenshot;
                    o.mouseX = StageShareManager.mouseX;
                    o.mouseY = StageShareManager.mouseY;
                };
                if (!PlayerManager.getInstance().server)
                {
                    return (o);
                };
                if (PlayerManager.getInstance().nickname)
                {
                    o.account = (((PlayerManager.getInstance().nickname + " (id: ") + PlayerManager.getInstance().accountId) + ")");
                };
                o.accountId = PlayerManager.getInstance().accountId;
                o.serverId = PlayerManager.getInstance().server.id;
                o.server = (((PlayerManager.getInstance().server.name + " (id: ") + PlayerManager.getInstance().server.id) + ")");
                if (!PlayedCharacterManager.getInstance().infos)
                {
                    return (o);
                };
                o.character = (((PlayedCharacterManager.getInstance().infos.name + " (id: ") + PlayedCharacterManager.getInstance().id) + ")");
                o.characterId = PlayedCharacterManager.getInstance().id;
                currentMap = PlayedCharacterManager.getInstance().currentMap;
                if (!currentMap)
                {
                    return (o);
                };
                o.mapId = (((((currentMap.mapId + " (") + currentMap.x) + "/") + currentMap.y) + ")");
                o.look = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook).toString();
                o.idMap = currentMap.mapId;
                obstacles = [];
                entities = [];
                los = [];
                fightContextFrame = this.getFightFrame();
                o.wasFighting = (!(fightContextFrame == null));
                o.isSpectator = "";
                if (o.wasFighting)
                {
                    if (PlayedCharacterManager.getInstance().isSpectator)
                    {
                        o.isSpectator = "(spectateur)";
                    };
                    fightId = PlayedCharacterManager.getInstance().fightId;
                    o.fightId = ((("<b>Id Combat : </b>" + fightId) + "-") + currentMap.mapId);
                    fighterBuffer = "";
                    fighters = fightContextFrame.battleFrame.fightersList;
                    for each (fighterId in fighters)
                    {
                        fighterInfos = new FighterInformations(fighterId);
                        level = fightContextFrame.getFighterLevel(fighterId);
                        if (level > ProtocolConstantsEnum.MAX_LEVEL)
                        {
                            levelText = (((ProtocolConstantsEnum.MAX_LEVEL + " (Pr.") + (level - ProtocolConstantsEnum.MAX_LEVEL)) + ")");
                        }
                        else
                        {
                            levelText = ("" + level);
                        };
                        fighterBuffer = (fighterBuffer + (((((((((((((((("<li><b>" + fightContextFrame.getFighterName(fighterId)) + "</b>, id: ") + fighterId) + ", lvl: ") + levelText) + ", team: ") + fighterInfos.team) + ", vie: ") + fighterInfos.lifePoints) + ", pa:") + fighterInfos.actionPoints) + ", pm:") + fighterInfos.movementPoints) + ", cell:") + FightEntitiesFrame.getCurrentInstance().getEntityInfos(fighterId).disposition.cellId) + "</li>"));
                    };
                    o.fighterList = fighterBuffer;
                    o.currentPlayer = fightContextFrame.getFighterName(this.getFightFrame().battleFrame.currentPlayerId);
                };
                if (!o.wasFighting)
                {
                    entityInfoProvider = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
                }
                else
                {
                    entityInfoProvider = fightContextFrame.entitiesFrame;
                };
                cellId = 0;
                while (cellId < AtouinConstants.MAP_CELLS_COUNT)
                {
                    mp = MapPoint.fromCellId(cellId);
                    obstacles.push(((DataMapProvider.getInstance().pointMov(mp.x, mp.y, true)) ? 1 : 0));
                    los.push(((DataMapProvider.getInstance().pointLos(mp.x, mp.y, true)) ? 1 : 0));
                    entitiesOnCell = EntitiesManager.getInstance().getEntitiesOnCell(mp.cellId);
                    if (((entityInfoProvider) && (entitiesOnCell.length)))
                    {
                        for each (entity in entitiesOnCell)
                        {
                            entityInfo = entityInfoProvider.getEntityInfos(entity.id);
                            entityInfoDataStr = (((("{cell:" + cellId) + ",className:'") + getQualifiedClassName(entityInfo).split("::").pop()) + "'");
                            for each (key in entityInfo)
                            {
                                if ((((((entityInfo[key] is int) || (entityInfo[key] is uint)) || (entityInfo[key] is Number)) || (entityInfo[key] is Boolean)) || (entityInfo[key] is String)))
                                {
                                    entityInfoDataStr = (entityInfoDataStr + (((("," + key) + ':"') + entityInfo[key]) + '"'));
                                };
                            };
                            entities.push((entityInfoDataStr + "}"));
                        };
                    };
                    cellId++;
                };
                if (((!(o.wasFighting)) && (entityInfoProvider is RoleplayEntitiesFrame)))
                {
                    interactiveElements = entityInfoProvider.interactiveElements;
                    for each (ie in interactiveElements)
                    {
                        iePos = Atouin.getInstance().getIdentifiedElementPosition(ie.elementId);
                        ieInfoDataStr = (((("{cell:" + iePos.cellId) + ",className:'") + getQualifiedClassName(ie).split("::").pop()) + "'");
                        for each (keyIe in ie)
                        {
                            if ((((((ie[keyIe] is int) || (ie[keyIe] is uint)) || (ie[keyIe] is Number)) || (ie[keyIe] is Boolean)) || (ie[keyIe] is String)))
                            {
                                ieInfoDataStr = (ieInfoDataStr + (((("," + keyIe) + ':"') + ie[keyIe]) + '"'));
                            };
                        };
                        entities.push((ieInfoDataStr + "}"));
                    };
                };
                o.obstacles = obstacles.join(",");
                o.entities = entities.join(",");
                o.los = los.join(",");
            }
            catch(e:Error)
            {
                if (txt != MANUAL_BUG_REPORT_TXT)
                {
                    _log.error(((("Error during the creation of a bug report... " + e.message) + "\nInitial error :") + ((error) ? error.message : txt)));
                }
                else
                {
                    _log.info("Manual bug report has been created");
                };
            };
            return (o);
        }

        private function getFightFrame():FightContextFrame
        {
            var frame:Frame = Kernel.getWorker().getFrame(FightContextFrame);
            return (frame as FightContextFrame);
        }

        public function get localSaveReport():Boolean
        {
            return (this._localSaveReport);
        }

        public function get distantSaveReport():Boolean
        {
            return (this._distantSaveReport);
        }

        public function get sendErrorToWebservice():Boolean
        {
            return (this._sendErrorToWebservice);
        }

        private function stopConnectionTimeout():void
        {
            if (this._timeoutTimer)
            {
                this._timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onSocketTimeOut);
                this._timeoutTimer.stop();
                this._timeoutTimer = null;
            };
        }

        private function onSocketTimeOut(e:Event):void
        {
            _formattedLogBufferReg.clear();
            _log.info("Reg n'as pas envoyé ses logs");
            _self.onError(new ErrorReportedEvent(null, MANUAL_BUG_REPORT_TXT));
        }


    }
}

