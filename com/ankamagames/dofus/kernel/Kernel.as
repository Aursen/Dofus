package com.ankamagames.dofus.kernel
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.messages.Worker;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import flash.display.Sprite;
    import flash.text.TextField;
    import com.ankamagames.dofus.misc.utils.LoadingScreen;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import com.ankamagames.jerakine.utils.display.FrameIdManager;
    import com.ankamagames.jerakine.utils.misc.ApplicationDomainShareManager;
    import flash.system.ApplicationDomain;
    import com.ankamagames.jerakine.handlers.HumanInputHandler;
    import com.ankamagames.jerakine.handlers.FocusHandler;
    import com.ankamagames.tiphon.engine.BoneIndexManager;
    import com.ankamagames.dofus.misc.utils.AnimationCleaner;
    import com.ankamagames.dofus.misc.stats.StatisticsManager;
    import com.ankamagames.dofus.network.Metadata;
    import com.ankamagames.dofus.kernel.zaap.ZaapConnectionHelper;
    import com.ankamagames.dofus.kernel.zaap.ZaapApi;
    import flash.display.Stage;
    import flash.display.DisplayObject;
    import com.ankamagames.dofus.datacenter.sounds.SoundUi;
    import com.ankamagames.dofus.datacenter.sounds.SoundUiElement;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.jerakine.managers.LangManager;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.misc.interClient.InterClientManager;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.dofus.logic.game.common.types.SubEntityHandler;
    import com.ankamagames.tiphon.engine.Tiphon;
    import com.ankamagames.dofus.types.enums.AnimationEnum;
    import com.ankamagames.tiphon.types.Skin;
    import com.ankamagames.dofus.misc.utils.SkinPartTransformProvider;
    import com.ankamagames.berilia.managers.UiSoundManager;
    import com.ankamagames.dofus.kernel.sound.SoundManager;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.dofus.modules.utils.pathfinding.world.WorldPathFinder;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.dofus.logic.common.managers.FeatureManager;
    import com.ankamagames.dofus.logic.connection.actions.ShowUpdaterLoginInterfaceAction;
    import com.ankamagames.dofus.Constants;
    import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
    import com.ankamagames.dofus.console.moduleLogger.Console;
    import com.ankamagames.dofus.console.moduleLogger.ModuleDebugManager;
    import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.InactivityManager;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
    import com.ankamagames.berilia.types.graphic.TimeoutHTMLLoader;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
    import com.ankamagames.dofus.logic.game.common.frames.CameraControlFrame;
    import com.ankamagames.jerakine.utils.system.SystemPopupUI;
    import com.ankamagames.atouin.types.AtouinOptions;
    import com.ankamagames.atouin.types.Frustum;
    import com.ankamagames.tiphon.events.ScriptedAnimationEvent;
    import com.ankamagames.dofus.types.DofusOptions;
    import com.ankamagames.berilia.types.BeriliaOptions;
    import com.ankamagames.tiphon.types.TiphonOptions;
    import com.ankamagames.tubul.types.TubulOptions;
    import com.ankamagames.jerakine.managers.PerformanceManager;
    import com.ankamagames.dofus.logic.connection.frames.InitializationFrame;
    import com.ankamagames.dofus.logic.common.frames.LoadingModuleFrame;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.dofus.logic.common.frames.LatencyFrame;
    import com.ankamagames.dofus.logic.common.frames.ServerControlFrame;
    import com.ankamagames.dofus.logic.common.frames.AuthorizedFrame;
    import com.ankamagames.dofus.logic.game.common.frames.DebugFrame;
    import com.ankamagames.berilia.frames.UIInteractionFrame;
    import com.ankamagames.berilia.frames.ShortcutsFrame;
    import com.ankamagames.dofus.logic.common.frames.DisconnectionHandlerFrame;
    import com.ankamagames.dofus.logic.common.frames.CleanupCrewFrame;
    import com.ankamagames.dofus.misc.stats.StatisticsFrame;
    import com.ankamagames.berilia.frames.UiStatsFrame;
    import com.ankamagames.berilia.utils.UriCacheFactory;
    import com.ankamagames.jerakine.newCache.impl.DisplayObjectCache;
    import com.ankamagames.jerakine.newCache.impl.Cache;
    import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.sounds.SoundAnimation;
    import com.ankamagames.tiphon.display.TiphonAnimation;
    import com.ankamagames.dofus.datacenter.sounds.SoundBones;
    import com.ankamagames.tiphon.engine.TiphonEventsManager;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;

    public class Kernel 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Kernel));
        private static var _self:Kernel;
        private static var _worker:Worker = new Worker();
        public static var beingInReconection:Boolean;

        public function Kernel()
        {
            if (_self != null)
            {
                throw (new SingletonError("Kernel is a singleton and should not be instanciated directly."));
            };
        }

        public static function getInstance():Kernel
        {
            if (_self == null)
            {
                _self = new (Kernel)();
            };
            return (_self);
        }

        public static function getWorker():Worker
        {
            return (_worker);
        }

        public static function panic(errorId:uint=0, panicArgs:Array=null):void
        {
            var blueScreen:Sprite;
            var errorTitle:TextField;
            var errorMsg:TextField;
            var ls:LoadingScreen;
            _worker.clear();
            ConnectionsHandler.closeConnection();
            if ((Math.random() * 1000) > 999)
            {
                blueScreen = new Sprite();
                blueScreen.graphics.beginFill(0x666666, 0.9);
                blueScreen.graphics.drawRect(-2000, -2000, 5000, 5000);
                blueScreen.graphics.endFill();
                StageShareManager.stage.addChild(blueScreen);
                errorTitle = new TextField();
                errorTitle.selectable = false;
                errorTitle.defaultTextFormat = new TextFormat("Courier New", 12, 0xFFFFFF, true, false, false, null, null, TextFormatAlign.CENTER);
                errorTitle.text = ("FATAL ERROR 0x" + errorId.toString(16).toUpperCase());
                errorTitle.width = StageShareManager.stage.stageWidth;
                errorTitle.y = ((StageShareManager.stage.stageHeight / 2) - (errorTitle.textHeight / 2));
                StageShareManager.stage.addChild(errorTitle);
                errorMsg = new TextField();
                errorMsg.selectable = false;
                errorMsg.defaultTextFormat = new TextFormat("Courier New", 11, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
                errorMsg.text = ("A fatal error has occured.\n" + PanicMessages.getMessage(errorId, panicArgs));
                errorMsg.width = StageShareManager.stage.stageWidth;
                errorMsg.height = (errorMsg.textHeight + 10);
                errorMsg.y = (((StageShareManager.stage.stageHeight / 2) + (errorTitle.textHeight / 2)) + 10);
                StageShareManager.stage.addChild(errorMsg);
            }
            else
            {
                ls = new LoadingScreen();
                ls.tipSelectable = true;
                ls.enableTipsScrollBar = true;
                ls.tip = PanicMessages.getMessage(errorId, panicArgs);
                ls.log(PanicMessages.getMessage(errorId, panicArgs), LoadingScreen.ERROR);
                ls.value = -1;
                ls.showLog(false);
                Dofus.getInstance().addChild(ls);
            };
        }


        public function init(stage:Stage, rootClip:DisplayObject):void
        {
            StageShareManager.stage = stage;
            StageShareManager.rootContainer = Dofus.getInstance().rootContainer;
            FrameIdManager.init();
            ApplicationDomainShareManager.currentApplicationDomain = ApplicationDomain.currentDomain;
            _worker.clear();
            HumanInputHandler.getInstance().handler = _worker;
            FocusHandler.getInstance().handler = HumanInputHandler.getInstance().handler;
            BoneIndexManager.getInstance().setAnimNameModifier(AnimationCleaner.cleanBones1AnimName);
            if (StatisticsManager.getInstance().statsEnabled)
            {
                StatisticsManager.getInstance().init();
            };
            this.addInitialFrames(true);
            _log.info((((((("Using protocole #" + Metadata.PROTOCOL_BUILD) + ", build on ") + Metadata.PROTOCOL_DATE) + " (visibility ") + Metadata.PROTOCOL_VISIBILITY) + ")"));
            if (ZaapConnectionHelper.hasZaapArguments())
            {
                ZaapApi.init();
            };
        }

        public function postInit():void
        {
            var ui:SoundUi;
            var buildType:int;
            var configVersion:String;
            var uiElem:SoundUiElement;
            this.initCaches();
            XmlConfig.getInstance().init(LangManager.getInstance().getCategory("config"));
            if (XmlConfig.getInstance().getEntry("config.buildType"))
            {
                buildType = -1;
                configVersion = XmlConfig.getInstance().getEntry("config.buildType");
                switch (configVersion.replace(/[0-9]/g, "").toLowerCase())
                {
                    case "draft":
                        buildType = BuildTypeEnum.DRAFT;
                        break;
                    case "debug":
                        buildType = BuildTypeEnum.DEBUG;
                        break;
                    case "local":
                    case "internal":
                        buildType = BuildTypeEnum.INTERNAL;
                        break;
                    case "testing":
                        buildType = BuildTypeEnum.TESTING;
                        break;
                    case "alpha":
                        buildType = BuildTypeEnum.ALPHA;
                        break;
                    case "beta":
                        buildType = BuildTypeEnum.BETA;
                        break;
                    case "release":
                        buildType = BuildTypeEnum.RELEASE;
                        break;
                };
                if (((!(buildType == -1)) && (buildType < BuildInfos.BUILD_TYPE)))
                {
                    BuildInfos.VERSION.buildType = buildType;
                };
            };
            this.initOptions();
            InterClientManager.getInstance().update();
            Atouin.getInstance().showWorld(false);
            DataMapProvider.init(AnimatedCharacter);
            TiphonSprite.subEntityHandler = SubEntityHandler.instance;
            Tiphon.getInstance().init(LangManager.getInstance().getEntry("config.gfx.path.skull"), LangManager.getInstance().getEntry("config.gfx.path.skin"), LangManager.getInstance().getEntry("config.gfx.path.animIndex"));
            Tiphon.getInstance().addRasterizeAnimation(AnimationEnum.ANIM_COURSE);
            Tiphon.getInstance().addRasterizeAnimation(AnimationEnum.ANIM_MARCHE);
            Tiphon.getInstance().addRasterizeAnimation(AnimationEnum.ANIM_STATIQUE);
            Skin.skinPartTransformProvider = new SkinPartTransformProvider();
            UiSoundManager.getInstance().playSound = SoundManager.getInstance().manager.playUISound;
            var uiSound:Array = SoundUi.getSoundUis();
            for each (ui in uiSound)
            {
                UiSoundManager.getInstance().registerUi(ui.uiName, ui.openFile, ui.closeFile);
                for each (uiElem in ui.subElements)
                {
                    UiSoundManager.getInstance().registerUiElement(ui.uiName, uiElem.name, uiElem.hook, uiElem.file);
                };
            };
            Berilia.getInstance().autoReloadUiOnChange = (LangManager.getInstance().getEntry("config.dev.autoReloadUi") == "true");
            WorldPathFinder.init();
        }

        public function reset(messagesToDispatchAfter:Array=null, autoRetry:Boolean=false, reloadData:Boolean=false):void
        {
            var msg:Message;
            TooltipManager.hide();
            var featureManager:FeatureManager = FeatureManager.getInstance();
            if (featureManager !== null)
            {
                featureManager.resetEnabledServerFeatures();
                featureManager.resetEnabledServerConnectionFeatures();
            };
            if (ZaapApi.isUsingZaapLogin())
            {
                if (messagesToDispatchAfter == null)
                {
                    messagesToDispatchAfter = new Array();
                };
                messagesToDispatchAfter.push(new ShowUpdaterLoginInterfaceAction());
            };
            if (Constants.EVENT_MODE)
            {
                _log.error("eventmode : quit");
                Dofus.getInstance().reboot();
            };
            if (!autoRetry)
            {
                AuthentificationManager.getInstance().destroy();
            };
            if (Console.isVisible())
            {
                Console.getInstance().close();
            };
            ModuleDebugManager.display(false);
            FightersStateManager.getInstance().endFight();
            CurrentPlayedFighterManager.getInstance().endFight();
            PlayedCharacterManager.getInstance().destroy();
            StatisticsManager.getInstance().destroy();
            HaapiKeyManager.getInstance().destroy();
            SpellWrapper.removeAllSpellWrapper();
            Atouin.getInstance().reset();
            InactivityManager.getInstance().stop();
            DofusEntities.reset();
            _worker.clear();
            ItemWrapper.clearCache();
            SpeakingItemManager.getInstance().destroy();
            TimeoutHTMLLoader.resetCache();
            OptionManager.reset();
            this.initOptions();
            this.addInitialFrames(reloadData);
            Kernel.beingInReconection = false;
            if (((!(messagesToDispatchAfter == null)) && (messagesToDispatchAfter.length > 0)))
            {
                for each (msg in messagesToDispatchAfter)
                {
                    _worker.process(msg);
                };
            };
            SoundManager.getInstance().manager.reset();
            if (ExternalNotificationManager.getInstance().initialized)
            {
                ExternalNotificationManager.getInstance().reset();
            };
            Atouin.getInstance().rootContainer.mouseChildren = true;
            Atouin.getInstance().rootContainer.mouseEnabled = true;
            _worker.removeFrame(_worker.getFrame(CameraControlFrame));
        }

        public function initOptions():void
        {
            var popup:SystemPopupUI;
            OptionManager.reset();
            var ao:AtouinOptions = new AtouinOptions(Dofus.getInstance().getWorldContainer(), Kernel.getWorker());
            ao.setOption("frustum", new Frustum(LangManager.getInstance().getIntEntry("config.atouin.frustum.marginLeft"), LangManager.getInstance().getIntEntry("config.atouin.frustum.marginTop"), LangManager.getInstance().getIntEntry("config.atouin.frustum.marginRight"), LangManager.getInstance().getIntEntry("config.atouin.frustum.marginBottom")));
            ao.setOption("mapsPath", LangManager.getInstance().getEntry("config.atouin.path.maps"));
            ao.setOption("elementsIndexPath", LangManager.getInstance().getEntry("config.atouin.path.elements"));
            ao.setOption("elementsPath", LangManager.getInstance().getEntry("config.gfx.path.cellElement"));
            ao.setOption("jpgSubPath", LangManager.getInstance().getEntry("config.gfx.subpath.world.jpg"));
            ao.setOption("pngSubPath", LangManager.getInstance().getEntry("config.gfx.subpath.world.png"));
            ao.setOption("pngPathOverride", LangManager.getInstance().getEntry("config.gfx.path.world.pngOverride"));
            ao.setOption("swfPath", LangManager.getInstance().getEntry("config.gfx.path.world.swf"));
            ao.setOption("particlesScriptsPath", LangManager.getInstance().getEntry("config.atouin.path.emitters"));
            ao.setOption("mapPictoExtension", LangManager.getInstance().getEntry("config.gfx.subpath.world.extension"));
            ao.setOption("tacticalModeTemplatesPath", LangManager.getInstance().getEntry("config.atouin.path.tacticalModeTemplates"));
            if (ao.getOption("jpgSubPath").charAt(0) == "!")
            {
                ao.setOption("jpgSubPath", "jpg");
            };
            if (ao.getOption("pngSubPath").charAt(0) == "!")
            {
                ao.setOption("pngSubPath", "png");
            };
            if (ao.getOption("mapPictoExtension").charAt(0) == "!")
            {
                ao.setOption("mapPictoExtension", "png");
            };
            if (ao.getOption("pngPathOverride").charAt(0) == "!")
            {
                ao.setOption("pngPathOverride", "");
            };
            Atouin.getInstance().setDisplayOptions(ao);
            StageShareManager.rootContainer.addEventListener(ScriptedAnimationEvent.SCRIPTED_ANIMATION_ADDED, this.onScriptedAnimationAdded);
            var dofusO:DofusOptions = new DofusOptions();
            Dofus.getInstance().setDisplayOptions(dofusO);
            var beriliaO:BeriliaOptions = new BeriliaOptions();
            Berilia.getInstance().setDisplayOptions(beriliaO);
            var tiphonO:TiphonOptions = new TiphonOptions();
            Tiphon.getInstance().setDisplayOptions(tiphonO);
            var tubulO:TubulOptions = new TubulOptions();
            SoundManager.getInstance().setDisplayOptions(tubulO);
            PerformanceManager.init(Dofus.getInstance().options.getOption("optimize"));
            if (Constants.LOG_UPLOAD_MODE)
            {
                popup = new SystemPopupUI("logWarning");
                popup.title = "Attention";
                popup.content = "Vous participez au programme d'analyse des performances de Dofus 2.0 mais le système de log est désactivé dans les options (Options -> Support)";
                popup.show();
            };
        }

        private function addInitialFrames(firstLaunch:Boolean=false):void
        {
            if (firstLaunch)
            {
                _worker.addFrame(new InitializationFrame());
            }
            else
            {
                _worker.addFrame(new LoadingModuleFrame(true));
                UiModuleManager.getInstance().reset();
                UiModuleManager.getInstance().init(Constants.COMMON_GAME_MODULE.concat(Constants.PRE_GAME_MODULE), true);
            };
            if (!_worker.contains(LatencyFrame))
            {
                _worker.addFrame(new LatencyFrame());
            };
            if (!_worker.contains(ServerControlFrame))
            {
                _worker.addFrame(new ServerControlFrame());
            };
            if (!_worker.contains(AuthorizedFrame))
            {
                _worker.addFrame(new AuthorizedFrame());
            };
            if (!_worker.contains(DebugFrame))
            {
                _worker.addFrame(new DebugFrame());
            };
            _worker.addFrame(new UIInteractionFrame());
            _worker.addFrame(new ShortcutsFrame());
            _worker.addFrame(new DisconnectionHandlerFrame());
            if (!_worker.contains(CleanupCrewFrame))
            {
                _worker.addFrame(new CleanupCrewFrame());
            };
            if (!_worker.contains(StatisticsFrame))
            {
                _worker.addFrame(StatisticsManager.getInstance().frame);
            };
            if (!_worker.contains(UiStatsFrame))
            {
                _worker.addFrame(new UiStatsFrame());
            };
        }

        private function initCaches():void
        {
            UriCacheFactory.init(".swf", new DisplayObjectCache(100));
            UriCacheFactory.init(".png", new Cache(200, new LruGarbageCollector()));
        }

        private function onScriptedAnimationAdded(e:ScriptedAnimationEvent):void
        {
            var name:String;
            var vsa:Vector.<SoundAnimation>;
            var sa:SoundAnimation;
            var dataSoundLabel:String;
            var animation:TiphonAnimation = (e.entity.rawAnimation as TiphonAnimation);
            var soundBones:SoundBones = SoundBones.getSoundBonesById(e.entity.look.getBone());
            if (soundBones)
            {
                name = getQualifiedClassName(animation);
                vsa = soundBones.getSoundAnimations(name);
                animation.spriteHandler.tiphonEventManager.removeEvents(TiphonEventsManager.BALISE_SOUND, name);
                for each (sa in vsa)
                {
                    dataSoundLabel = (((TiphonEventsManager.BALISE_DATASOUND + TiphonEventsManager.BALISE_PARAM_BEGIN) + (((!(sa.label == null)) && (!(sa.label == "null"))) ? sa.label : "")) + TiphonEventsManager.BALISE_PARAM_END);
                    animation.spriteHandler.tiphonEventManager.addEvent(dataSoundLabel, sa.startFrame, name);
                };
            };
        }


    }
} com.ankamagames.dofus.kernel

