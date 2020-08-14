package com.ankamagames.dofus.logic.game.fight.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.filters.GlowFilter;
    import flash.filters.ColorMatrixFilter;
    import com.ankamagames.jerakine.utils.memory.WeakReference;
    import flash.utils.Timer;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeam;
    import com.ankamagames.dofus.network.types.game.idol.Idol;
    import com.ankamagames.dofus.logic.game.fight.frames.Preview.DamagePreview;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.berilia.Berilia;
    import flash.events.TimerEvent;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.dofus.logic.game.roleplay.frames.EntitiesTooltipsFrame;
    import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
    import com.ankamagames.berilia.types.event.UiUnloadEvent;
    import com.ankamagames.berilia.types.tooltip.event.TooltipEvent;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightTaxCollectorInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.dofus.datacenter.monsters.Companion;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
    import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMutantInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.dofus.network.enums.FightTypeEnum;
    import com.ankamagames.dofus.internalDatacenter.fight.ChallengeWrapper;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightStartingMessage;
    import flash.display.Sprite;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import flash.utils.ByteArray;
    import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
    import com.ankamagames.dofus.network.messages.game.context.GameContextReadyMessage;
    import com.ankamagames.atouin.messages.MapsLoadingCompleteMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightResumeMessage;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightResumeSlaveInfo;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
    import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
    import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightUpdateTeamMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSpectateMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSpectatorJoinMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCarryCharacterMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightStartMessage;
    import com.ankamagames.atouin.messages.CellOverMessage;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
    import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
    import com.ankamagames.atouin.messages.CellOutMessage;
    import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
    import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightLeaveMessage;
    import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOverAction;
    import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOutAction;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
    import com.ankamagames.dofus.logic.game.fight.actions.ChallengeTargetsListRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeTargetsListRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeTargetsListMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeInfoMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeTargetUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.challenge.ChallengeResultMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.arena.ArenaFighterLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapObstacleUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightNoSpellCastMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachEnterMessage;
    import com.ankamagames.dofus.logic.game.common.actions.ToggleShowUIAction;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightResumeWithSlavesMessage;
    import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.types.entities.Glyph;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.logic.game.common.messages.FightEndingMessage;
    import com.ankamagames.dofus.internalDatacenter.fight.FightResultEntryWrapper;
    import com.ankamagames.dofus.network.types.game.context.fight.FightResultListEntry;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeamWithOutcome;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.dofus.logic.game.common.frames.BreachFrame;
    import com.ankamagames.atouin.messages.MapLoadedMessage;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
    import com.ankamagames.dofus.logic.game.common.managers.SubhintManager;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.kernel.sound.SoundManager;
    import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapInstanceMessage;
    import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.hurlant.util.Hex;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.logic.game.fight.actions.ToggleEntityIconsAction;
    import com.ankamagames.dofus.misc.lists.FightHookList;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
    import com.ankamagames.dofus.network.enums.TeamEnum;
    import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
    import com.ankamagames.dofus.logic.game.roleplay.managers.MountAutoTripManager;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.jerakine.entities.interfaces.IInteractive;
    import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import tools.enumeration.GameActionMarkTypeEnum;
    import com.ankamagames.dofus.logic.game.fight.managers.LinkedCellsManager;
    import com.ankamagames.dofus.logic.game.common.frames.PointCellFrame;
    import com.ankamagames.dofus.logic.game.fight.actions.TogglePointCellAction;
    import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.berilia.managers.SecureCenter;
    import com.ankamagames.dofus.network.types.game.context.fight.FightResultPlayerListEntry;
    import com.ankamagames.dofus.network.types.game.context.fight.FightResultTaxCollectorListEntry;
    import com.ankamagames.dofus.network.types.game.context.fight.FightResultFighterListEntry;
    import com.ankamagames.dofus.network.enums.FightOutcomeEnum;
    import com.ankamagames.dofus.misc.lists.TriggerHookList;
    import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
    import com.ankamagames.dofus.network.messages.game.context.fight.breach.BreachGameFightEndMessage;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkShowCellManager;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.dofus.network.enums.MapObstacleStateEnum;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.logic.game.fight.actions.ShowTacticModeAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.BreachExitResponseMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.sequencer.SerialSequencer;
    import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.atouin.managers.SelectionManager;
    import com.ankamagames.atouin.types.Selection;
    import com.ankamagames.dofus.logic.game.fight.managers.SpellDamagesManager;
    import flash.utils.getTimer;
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.jerakine.interfaces.IRectangle;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.berilia.enums.StrataEnum;
    import com.ankamagames.atouin.renderers.ZoneDARenderer;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.dofus.logic.game.fight.miscs.FightReachableCellsMaker;
    import com.ankamagames.jerakine.types.zones.Custom;
    import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
    import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
    import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
    import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
    import flash.display.DisplayObject;
    import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.renderers.*;

    public class FightContextFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightContextFrame));
        public static var preFightIsActive:Boolean = true;
        public static var fighterEntityTooltipId:Number;
        public static var currentCell:int = -1;

        private const INVISIBLE_POSITION_SELECTION:String = "invisible_position";
        protected const REACHABLE_CELL_COLOR:int = 0x6600;
        protected const UNREACHABLE_CELL_COLOR:int = 0x660000;

        private var _entitiesFrame:FightEntitiesFrame;
        private var _preparationFrame:FightPreparationFrame;
        private var _battleFrame:FightBattleFrame;
        private var _overEffectOk:GlowFilter;
        private var _overEffectKo:GlowFilter;
        private var _linkedEffect:ColorMatrixFilter;
        private var _linkedMainEffect:ColorMatrixFilter;
        private var _lastEffectEntity:WeakReference;
        private var _timerFighterInfo:Timer;
        private var _timerMovementRange:Timer;
        private var _currentFighterInfo:GameFightFighterInformations;
        private var _currentMapRenderId:int = -1;
        private var _timelineOverEntity:Boolean;
        private var _timelineOverEntityId:Number;
        private var _showPermanentTooltips:Boolean;
        private var _hiddenEntites:Array = [];
        public var _challengesList:Array;
        private var _fightType:uint;
        private var _fightAttackerId:Number;
        private var _spellTargetsTooltips:Dictionary = new Dictionary();
        private var _tooltipLastUpdate:Dictionary = new Dictionary();
        private var _namedPartyTeams:Vector.<NamedPartyTeam>;
        private var _fightersPositionsHistory:Dictionary = new Dictionary();
        private var _fightersRoundStartPosition:Dictionary = new Dictionary();
        private var _fightIdols:Vector.<Idol>;
        private var _mustShowTreasureHuntMask:Boolean = false;
        private var _roleplayGridDisplayed:Boolean;
        public var isFightLeader:Boolean;
        public var onlyTheOtherTeamCanPlace:Boolean = false;

        public function FightContextFrame()
        {
            DamagePreview.init();
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get entitiesFrame():FightEntitiesFrame
        {
            return (this._entitiesFrame);
        }

        public function get battleFrame():FightBattleFrame
        {
            return (this._battleFrame);
        }

        public function get preparationFrame():FightPreparationFrame
        {
            return (this._preparationFrame);
        }

        public function get challengesList():Array
        {
            return (this._challengesList);
        }

        public function get fightType():uint
        {
            return (this._fightType);
        }

        public function set fightType(t:uint):void
        {
            this._fightType = t;
            var partyFrame:PartyManagementFrame = (Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame);
            partyFrame.lastFightType = t;
        }

        public function get timelineOverEntity():Boolean
        {
            return (this._timelineOverEntity);
        }

        public function get timelineOverEntityId():Number
        {
            return (this._timelineOverEntityId);
        }

        public function get showPermanentTooltips():Boolean
        {
            return (this._showPermanentTooltips);
        }

        public function get hiddenEntites():Array
        {
            return (this._hiddenEntites);
        }

        public function get fightersPositionsHistory():Dictionary
        {
            return (this._fightersPositionsHistory);
        }

        public function pushed():Boolean
        {
            if (!Kernel.beingInReconection)
            {
                this._roleplayGridDisplayed = Atouin.getInstance().options.getOption("alwaysShowGrid");
                if (((Berilia.getInstance().getUi("banner").uiClass.tacticModeActivated) && (OptionManager.getOptionManager("dofus").getOption("useNewTacticalMode"))))
                {
                    Atouin.getInstance().displayGrid(false, true);
                }
                else
                {
                    Atouin.getInstance().displayGrid(true, true);
                };
            };
            currentCell = -1;
            this._overEffectOk = new GlowFilter(0xFFFFFF, 1, 4, 4, 3, 1);
            this._overEffectKo = new GlowFilter(0xD70000, 1, 4, 4, 3, 1);
            var matrix:Array = [0.5, 0, 0, 0, 100, 0, 0.5, 0, 0, 100, 0, 0, 0.5, 0, 100, 0, 0, 0, 1, 0];
            this._linkedEffect = new ColorMatrixFilter(matrix);
            var matrix2:Array = [0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 1, 0];
            this._linkedMainEffect = new ColorMatrixFilter(matrix2);
            this._entitiesFrame = new FightEntitiesFrame();
            this._preparationFrame = new FightPreparationFrame(this);
            this._battleFrame = new FightBattleFrame();
            this._challengesList = [];
            this._timerFighterInfo = new Timer(100, 1);
            this._timerFighterInfo.addEventListener(TimerEvent.TIMER, this.showFighterInfo, false, 0, true);
            this._timerMovementRange = new Timer(200, 1);
            this._timerMovementRange.addEventListener(TimerEvent.TIMER, this.showMovementRange, false, 0, true);
            if (MapDisplayManager.getInstance().getDataMapContainer())
            {
                MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(false);
            };
            if (Kernel.getWorker().contains(EntitiesTooltipsFrame))
            {
                Kernel.getWorker().removeFrame((Kernel.getWorker().getFrame(EntitiesTooltipsFrame) as EntitiesTooltipsFrame));
            };
            this._showPermanentTooltips = OptionManager.getOptionManager("dofus").getOption("showPermanentTargetsTooltips");
            OptionManager.getOptionManager("dofus").addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE, this.onUiUnloaded);
            Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_STARTED, this.onUiUnloadStarted);
            Berilia.getInstance().addEventListener(TooltipEvent.TOOLTIPS_ORDERED, this.onTooltipsOrdered);
            try
            {
                Berilia.getInstance().uiSavedModificationPresetName = "fight";
            }
            catch(error:Error)
            {
                _log.error(((("Failed to set uiSavedModificationPresetName to 'fight'!\n" + error.message) + "\n") + error.getStackTrace()));
            };
            return (true);
        }

        private function onUiUnloaded(pEvent:UiUnloadEvent):void
        {
            var entityId:Number;
            if (((this._showPermanentTooltips) && (this.battleFrame)))
            {
                for each (entityId in this.battleFrame.targetedEntities)
                {
                    this.displayEntityTooltip(entityId);
                };
            };
        }

        public function getFighterName(fighterId:Number):String
        {
            var fighterInfos:GameFightFighterInformations;
            var compInfos:GameFightEntityInformation;
            var name:String;
            var genericName:String;
            var taxInfos:GameFightTaxCollectorInformations;
            var masterName:String;
            fighterInfos = this.getFighterInfos(fighterId);
            if (!fighterInfos)
            {
                return ("Unknown Fighter");
            };
            switch (true)
            {
                case (fighterInfos is GameFightFighterNamedInformations):
                    return ((fighterInfos as GameFightFighterNamedInformations).name);
                case (fighterInfos is GameFightMonsterInformations):
                    return (Monster.getMonsterById((fighterInfos as GameFightMonsterInformations).creatureGenericId).name);
                case (fighterInfos is GameFightEntityInformation):
                    compInfos = (fighterInfos as GameFightEntityInformation);
                    genericName = Companion.getCompanionById(compInfos.entityModelId).name;
                    if (compInfos.masterId != PlayedCharacterManager.getInstance().id)
                    {
                        masterName = this.getFighterName(compInfos.masterId);
                        name = I18n.getUiText("ui.common.belonging", [genericName, masterName]);
                    }
                    else
                    {
                        name = genericName;
                    };
                    return (name);
                case (fighterInfos is GameFightTaxCollectorInformations):
                    taxInfos = (fighterInfos as GameFightTaxCollectorInformations);
                    return ((TaxCollectorFirstname.getTaxCollectorFirstnameById(taxInfos.firstNameId).firstname + " ") + TaxCollectorName.getTaxCollectorNameById(taxInfos.lastNameId).name);
            };
            return ("Unknown Fighter Type");
        }

        public function getFighterLevel(fighterId:Number):uint
        {
            var entity:String;
            var creatureLevel:uint;
            var minLevel:uint;
            var fighterInfos:GameFightFighterInformations = this.getFighterInfos(fighterId);
            if (!fighterInfos)
            {
                return (0);
            };
            switch (true)
            {
                case (fighterInfos is GameFightMutantInformations):
                    return ((fighterInfos as GameFightMutantInformations).powerLevel);
                case (fighterInfos is GameFightCharacterInformations):
                    return ((fighterInfos as GameFightCharacterInformations).level);
                case (fighterInfos is GameFightEntityInformation):
                    return ((fighterInfos as GameFightEntityInformation).level);
                case (fighterInfos is GameFightMonsterInformations):
                    if (this.fightType == FightTypeEnum.FIGHT_TYPE_BREACH)
                    {
                        minLevel = uint.MAX_VALUE;
                        for (entity in this._entitiesFrame.entities)
                        {
                            if (!(this._entitiesFrame.entities[entity] is GameFightMonsterInformations))
                            {
                            }
                            else
                            {
                                creatureLevel = this._entitiesFrame.entities[entity].creatureLevel;
                                if ((((fighterInfos as GameFightMonsterInformations).creatureGenericId == this._entitiesFrame.entities[entity].creatureGenericId) && ((this._entitiesFrame.entities[entity] as GameFightMonsterInformations).stats.summoned)))
                                {
                                    return (creatureLevel);
                                };
                                if ((this._entitiesFrame.entities[entity] as GameFightMonsterInformations).stats.summoned)
                                {
                                }
                                else
                                {
                                    if (minLevel > creatureLevel)
                                    {
                                        minLevel = creatureLevel;
                                    };
                                };
                            };
                        };
                        return (minLevel);
                    };
                    if (fighterInfos.stats.summoned)
                    {
                        return (this.getFighterLevel(fighterInfos.stats.summoner));
                    };
                    return ((fighterInfos as GameFightMonsterInformations).creatureLevel);
                case (fighterInfos is GameFightTaxCollectorInformations):
                    return ((fighterInfos as GameFightTaxCollectorInformations).level);
            };
            return (0);
        }

        public function getChallengeById(challengeId:uint):ChallengeWrapper
        {
            var challenge:ChallengeWrapper;
            for each (challenge in this._challengesList)
            {
                if (challenge.id == challengeId)
                {
                    return (challenge);
                };
            };
            return (null);
        }

        public function process(msg:Message):Boolean
        {
            var fscf:FightSpellCastFrame;
            var gfsmsg:GameFightStartingMessage;
            var TreasurHuntMask:Sprite;
            var mcmsg:CurrentMapMessage;
            var wp:WorldPointWrapper;
            var decryptionKey:ByteArray;
            var questFrame:QuestFrame;
            var gcrmsg:GameContextReadyMessage;
            var mlcm:MapsLoadingCompleteMessage;
            var dofusOptionsManager:OptionManager;
            var gfrmsg:GameFightResumeMessage;
            var playerId:Number;
            var cooldownInfos:Vector.<GameFightResumeSlaveInfo>;
            var playerCoolDownInfo:GameFightResumeSlaveInfo;
            var playedFighterManager:CurrentPlayedFighterManager;
            var i:int;
            var num:int;
            var infos:GameFightResumeSlaveInfo;
            var spellCastManager:SpellCastInFightManager;
            var castingSpellPool:Array;
            var targetPool:Array;
            var durationPool:Array;
            var castingSpell:CastingSpell;
            var numEffects:uint;
            var buff:FightDispellableEffectExtendedInformations;
            var gfutmsg:GameFightUpdateTeamMessage;
            var gfspmsg:GameFightSpectateMessage;
            var fightStartTime:Number;
            var attackersName:String;
            var defendersName:String;
            var castingSpellPools:Array;
            var targetPools:Array;
            var durationPools:Array;
            var castingSpells:CastingSpell;
            var gfsjmsg:GameFightSpectatorJoinMessage;
            var timeBeforeStart2:int;
            var attackersName2:String;
            var defendersName2:String;
            var gfjmsg:GameFightJoinMessage;
            var timeBeforeStart:int;
            var gafccmsg:GameActionFightCarryCharacterMessage;
            var gfsm:GameFightStartMessage;
            var conmsg:CellOverMessage;
            var cellEntity:AnimatedCharacter;
            var mcm:MarkedCellsManager;
            var portalOnThisCell:MarkInstance;
            var coutMsg:CellOutMessage;
            var cellEntity2:AnimatedCharacter;
            var mcmOut:MarkedCellsManager;
            var portalOnThisCellOut:MarkInstance;
            var emovmsg:EntityMouseOverMessage;
            var emomsg:EntityMouseOutMessage;
            var gflmsg:GameFightLeaveMessage;
            var teoa:TimelineEntityOverAction;
            var tleoutaction:TimelineEntityOutAction;
            var entityId:Number;
            var entities:Vector.<Number>;
            var gfemsg:GameFightEndMessage;
            var ctlra:ChallengeTargetsListRequestAction;
            var ctlrmsg:ChallengeTargetsListRequestMessage;
            var ctlmsg:ChallengeTargetsListMessage;
            var cimsg:ChallengeInfoMessage;
            var challenge:ChallengeWrapper;
            var ctumsg:ChallengeTargetUpdateMessage;
            var crmsg:ChallengeResultMessage;
            var aflmsg:ArenaFighterLeaveMessage;
            var moumsg:MapObstacleUpdateMessage;
            var gafnscmsg:GameActionFightNoSpellCastMessage;
            var canceledApAmout:uint;
            var bemsg:BreachEnterMessage;
            var tsuia:ToggleShowUIAction;
            var decryptionKeyString:String;
            var gfrwsmsg:GameFightResumeWithSlavesMessage;
            var buffTmp:BasicBuff;
            var namedTeam:NamedPartyTeam;
            var buffS:FightDispellableEffectExtendedInformations;
            var buffTmpS:BasicBuff;
            var namedTeam2:NamedPartyTeam;
            var entity:IEntity;
            var mi:MarkInstance;
            var glyph:Glyph;
            var mpWithPortals:Vector.<MapPoint>;
            var links:Vector.<uint>;
            var entity2:IEntity;
            var miOut:MarkInstance;
            var glyphOut:Glyph;
            var fightEnding:FightEndingMessage;
            var results:Vector.<FightResultEntryWrapper>;
            var resultIndex:uint;
            var hardcoreLoots:FightResultEntryWrapper;
            var winners:Vector.<FightResultEntryWrapper>;
            var temp:Array;
            var resultEntryTemp:FightResultListEntry;
            var isSpectator:Boolean;
            var winnersName:String;
            var losersName:String;
            var namedTeamWO:NamedPartyTeamWithOutcome;
            var resultsRecap:Object;
            var idols:Vector.<uint>;
            var frew:FightResultEntryWrapper;
            var id:Number;
            var resultEntry:FightResultListEntry;
            var currentWinner:uint;
            var loot:ItemWrapper;
            var kamas:Number;
            var kamasPerWinner:Number;
            var winner:FightResultEntryWrapper;
            var numIdols:uint;
            var j:int;
            var cell:Number;
            var mo:MapObstacle;
            var sl:SpellLevel;
            var breachFrame:BreachFrame;
            switch (true)
            {
                case (msg is MapLoadedMessage):
                    MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(false);
                    return (true);
                case (msg is GameFightStartingMessage):
                    gfsmsg = (msg as GameFightStartingMessage);
                    TreasurHuntMask = Atouin.getInstance().getWorldMask("treasureHinting", false);
                    if (((TreasurHuntMask) && (TreasurHuntMask.visible)))
                    {
                        Atouin.getInstance().toggleWorldMask("treasureHinting", false);
                        this._mustShowTreasureHuntMask = true;
                    }
                    else
                    {
                        this._mustShowTreasureHuntMask = false;
                    };
                    TooltipManager.hideAll();
                    TooltipPlacer.isInFight = true;
                    SubhintManager.getInstance().closeSubhint();
                    Atouin.getInstance().cancelZoom();
                    KernelEventsManager.getInstance().processCallback(HookList.StartZoom, false);
                    MapDisplayManager.getInstance().activeIdentifiedElements(false);
                    FightEventsHelper.reset();
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightStarting, gfsmsg.fightType);
                    this.fightType = gfsmsg.fightType;
                    this._fightAttackerId = gfsmsg.attackerId;
                    PlayedCharacterManager.getInstance().fightId = gfsmsg.fightId;
                    if (PlayerManager.getInstance().kisServerPort > 0)
                    {
                        _log.log(2, (((((("KIS fight started : " + gfsmsg.fightId) + "-") + PlayedCharacterManager.getInstance().currentMap.mapId) + " (port : ") + PlayerManager.getInstance().kisServerPort) + ")"));
                    }
                    else
                    {
                        _log.log(2, (((((("Game fight started : " + gfsmsg.fightId) + "-") + PlayedCharacterManager.getInstance().currentMap.mapId) + " (port : ") + PlayerManager.getInstance().gameServerPort) + ")"));
                    };
                    CurrentPlayedFighterManager.getInstance().currentFighterId = PlayedCharacterManager.getInstance().id;
                    CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn = 0;
                    SoundManager.getInstance().manager.playFightMusic(gfsmsg.containsBoss);
                    SoundManager.getInstance().manager.playUISound(UISoundEnum.INTRO_FIGHT);
                    return (true);
                case (msg is CurrentMapMessage):
                    mcmsg = (msg as CurrentMapMessage);
                    ConnectionsHandler.pause();
                    Kernel.getWorker().pause();
                    if ((mcmsg is CurrentMapInstanceMessage))
                    {
                        MapDisplayManager.getInstance().mapInstanceId = (mcmsg as CurrentMapInstanceMessage).instantiatedMapId;
                    }
                    else
                    {
                        MapDisplayManager.getInstance().mapInstanceId = 0;
                    };
                    if (TacticModeManager.getInstance().tacticModeActivated)
                    {
                        TacticModeManager.getInstance().hide();
                    };
                    wp = new WorldPointWrapper(mcmsg.mapId);
                    KernelEventsManager.getInstance().processCallback(HookList.StartZoom, false);
                    Atouin.getInstance().initPreDisplay(wp);
                    Atouin.getInstance().clearEntities();
                    if (((mcmsg.mapKey) && (mcmsg.mapKey.length)))
                    {
                        decryptionKeyString = XmlConfig.getInstance().getEntry("config.maps.encryptionKey");
                        if (!decryptionKeyString)
                        {
                            decryptionKeyString = mcmsg.mapKey;
                        };
                        decryptionKey = Hex.toArray(Hex.fromString(decryptionKeyString));
                    };
                    this._currentMapRenderId = Atouin.getInstance().display(wp, decryptionKey);
                    _log.info(("Ask map render for fight #" + this._currentMapRenderId));
                    PlayedCharacterManager.getInstance().currentMap = wp;
                    PlayedCharacterManager.getInstance().currentSubArea = SubArea.getSubAreaByMapId(mcmsg.mapId);
                    questFrame = (Kernel.getWorker().getFrame(QuestFrame) as QuestFrame);
                    if (((questFrame) && (questFrame.followedQuestsCallback)))
                    {
                        questFrame.followedQuestsCallback.exec();
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.CurrentMap, mcmsg.mapId);
                    return (false);
                case (msg is MapsLoadingCompleteMessage):
                    _log.info(("MapsLoadingCompleteMessage #" + MapsLoadingCompleteMessage(msg).renderRequestId));
                    if (this._currentMapRenderId != MapsLoadingCompleteMessage(msg).renderRequestId)
                    {
                        return (false);
                    };
                    Atouin.getInstance().showWorld(true);
                    Atouin.getInstance().cellOverEnabled = true;
                    gcrmsg = new GameContextReadyMessage();
                    gcrmsg.initGameContextReadyMessage(MapDisplayManager.getInstance().currentMapPoint.mapId);
                    ConnectionsHandler.getConnection().send(gcrmsg);
                    mlcm = (msg as MapsLoadingCompleteMessage);
                    SoundManager.getInstance().manager.setSubArea(mlcm.mapData);
                    Kernel.getWorker().resume();
                    ConnectionsHandler.resume();
                    return (true);
                case (msg is ToggleEntityIconsAction):
                    dofusOptionsManager = OptionManager.getOptionManager("dofus");
                    if (dofusOptionsManager === null)
                    {
                        return (false);
                    };
                    dofusOptionsManager.setOption("toggleEntityIcons", (msg as ToggleEntityIconsAction).isVisible);
                    return (true);
                case (msg is GameFightResumeMessage):
                    gfrmsg = (msg as GameFightResumeMessage);
                    playerId = PlayedCharacterManager.getInstance().id;
                    this.tacticModeHandler();
                    CurrentPlayedFighterManager.getInstance().setCurrentSummonedCreature(gfrmsg.summonCount, playerId);
                    CurrentPlayedFighterManager.getInstance().setCurrentSummonedBomb(gfrmsg.bombCount, playerId);
                    this._battleFrame.turnsCount = (gfrmsg.gameTurn - 1);
                    KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated, (gfrmsg.gameTurn - 1));
                    this._fightIdols = gfrmsg.idols;
                    KernelEventsManager.getInstance().processCallback(FightHookList.FightIdolList, gfrmsg.idols);
                    if ((msg is GameFightResumeWithSlavesMessage))
                    {
                        gfrwsmsg = (msg as GameFightResumeWithSlavesMessage);
                        cooldownInfos = gfrwsmsg.slavesInfo;
                    }
                    else
                    {
                        cooldownInfos = new Vector.<GameFightResumeSlaveInfo>();
                    };
                    playerCoolDownInfo = new GameFightResumeSlaveInfo();
                    playerCoolDownInfo.spellCooldowns = gfrmsg.spellCooldowns;
                    playerCoolDownInfo.slaveId = PlayedCharacterManager.getInstance().id;
                    cooldownInfos.unshift(playerCoolDownInfo);
                    playedFighterManager = CurrentPlayedFighterManager.getInstance();
                    num = cooldownInfos.length;
                    i = 0;
                    while (i < num)
                    {
                        infos = cooldownInfos[i];
                        spellCastManager = playedFighterManager.getSpellCastManagerById(infos.slaveId);
                        spellCastManager.currentTurn = (gfrmsg.gameTurn - 1);
                        spellCastManager.updateCooldowns(cooldownInfos[i].spellCooldowns);
                        if (infos.slaveId != playerId)
                        {
                            CurrentPlayedFighterManager.getInstance().setCurrentSummonedCreature(infos.summonCount, infos.slaveId);
                            CurrentPlayedFighterManager.getInstance().setCurrentSummonedBomb(infos.bombCount, infos.slaveId);
                        };
                        i++;
                    };
                    castingSpellPool = [];
                    numEffects = gfrmsg.effects.length;
                    i = 0;
                    while (i < numEffects)
                    {
                        buff = gfrmsg.effects[i];
                        if (!castingSpellPool[buff.effect.targetId])
                        {
                            castingSpellPool[buff.effect.targetId] = [];
                        };
                        targetPool = castingSpellPool[buff.effect.targetId];
                        if (!targetPool[buff.effect.turnDuration])
                        {
                            targetPool[buff.effect.turnDuration] = [];
                        };
                        durationPool = targetPool[buff.effect.turnDuration];
                        castingSpell = durationPool[buff.effect.spellId];
                        if (!castingSpell)
                        {
                            castingSpell = new CastingSpell();
                            castingSpell.casterId = buff.sourceId;
                            castingSpell.spell = Spell.getSpellById(buff.effect.spellId);
                            durationPool[buff.effect.spellId] = castingSpell;
                        };
                        buffTmp = BuffManager.makeBuffFromEffect(buff.effect, castingSpell, buff.actionId);
                        BuffManager.getInstance().addBuff(buffTmp);
                        i++;
                    };
                    this.addMarks(gfrmsg.marks);
                    Kernel.beingInReconection = false;
                    return (true);
                case (msg is GameFightUpdateTeamMessage):
                    gfutmsg = (msg as GameFightUpdateTeamMessage);
                    PlayedCharacterManager.getInstance().teamId = gfutmsg.team.teamId;
                    return (true);
                case (msg is GameFightSpectateMessage):
                    gfspmsg = (msg as GameFightSpectateMessage);
                    this.tacticModeHandler();
                    this._battleFrame.turnsCount = (gfspmsg.gameTurn - 1);
                    KernelEventsManager.getInstance().processCallback(FightHookList.TurnCountUpdated, (gfspmsg.gameTurn - 1));
                    this._fightIdols = gfspmsg.idols;
                    KernelEventsManager.getInstance().processCallback(FightHookList.FightIdolList, gfspmsg.idols);
                    fightStartTime = gfspmsg.fightStart;
                    attackersName = "";
                    defendersName = "";
                    for each (namedTeam in this._namedPartyTeams)
                    {
                        if (((namedTeam.partyName) && (!(namedTeam.partyName == ""))))
                        {
                            if (namedTeam.teamId == TeamEnum.TEAM_CHALLENGER)
                            {
                                attackersName = namedTeam.partyName;
                            }
                            else
                            {
                                if (namedTeam.teamId == TeamEnum.TEAM_DEFENDER)
                                {
                                    defendersName = namedTeam.partyName;
                                };
                            };
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(FightHookList.SpectateUpdate, fightStartTime, attackersName, defendersName);
                    castingSpellPools = [];
                    for each (buffS in gfspmsg.effects)
                    {
                        if (!castingSpellPools[buffS.effect.targetId])
                        {
                            castingSpellPools[buffS.effect.targetId] = [];
                        };
                        targetPools = castingSpellPools[buffS.effect.targetId];
                        if (!targetPools[buffS.effect.turnDuration])
                        {
                            targetPools[buffS.effect.turnDuration] = [];
                        };
                        durationPools = targetPools[buffS.effect.turnDuration];
                        castingSpells = durationPools[buffS.effect.spellId];
                        if (!castingSpells)
                        {
                            castingSpells = new CastingSpell();
                            castingSpells.casterId = buffS.sourceId;
                            castingSpells.spell = Spell.getSpellById(buffS.effect.spellId);
                            durationPools[buffS.effect.spellId] = castingSpells;
                        };
                        buffTmpS = BuffManager.makeBuffFromEffect(buffS.effect, castingSpells, buffS.actionId);
                        BuffManager.getInstance().addBuff(buffTmpS, (!(buffTmpS is StatBuff)));
                    };
                    this.addMarks(gfspmsg.marks);
                    FightEventsHelper.sendAllFightEvent();
                    return (true);
                case (msg is GameFightSpectatorJoinMessage):
                    gfsjmsg = (msg as GameFightSpectatorJoinMessage);
                    preFightIsActive = (!(gfsjmsg.isFightStarted));
                    this.fightType = gfsjmsg.fightType;
                    Kernel.getWorker().addFrame(this._entitiesFrame);
                    if (preFightIsActive)
                    {
                        Kernel.getWorker().addFrame(this._preparationFrame);
                    }
                    else
                    {
                        Kernel.getWorker().removeFrame(this._preparationFrame);
                        Kernel.getWorker().addFrame(this._battleFrame);
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightStart);
                    };
                    PlayedCharacterManager.getInstance().isSpectator = true;
                    PlayedCharacterManager.getInstance().isFighting = true;
                    timeBeforeStart2 = (gfsjmsg.timeMaxBeforeFightStart * 100);
                    if (((timeBeforeStart2 == 0) && (preFightIsActive)))
                    {
                        timeBeforeStart2 = -1;
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightJoin, gfsjmsg.canBeCancelled, gfsjmsg.canSayReady, true, timeBeforeStart2, gfsjmsg.fightType, gfsjmsg.isTeamPhase);
                    this._namedPartyTeams = gfsjmsg.namedPartyTeams;
                    attackersName2 = "";
                    defendersName2 = "";
                    for each (namedTeam2 in gfsjmsg.namedPartyTeams)
                    {
                        if (((namedTeam2.partyName) && (!(namedTeam2.partyName == ""))))
                        {
                            if (namedTeam2.teamId == TeamEnum.TEAM_CHALLENGER)
                            {
                                attackersName2 = namedTeam2.partyName;
                            }
                            else
                            {
                                if (namedTeam2.teamId == TeamEnum.TEAM_DEFENDER)
                                {
                                    defendersName2 = namedTeam2.partyName;
                                };
                            };
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(FightHookList.SpectateUpdate, 0, attackersName2, defendersName2);
                    return (true);
                case ((msg is INetworkMessage) && (INetworkMessage(msg).getMessageId() == GameFightJoinMessage.protocolId)):
                    gfjmsg = (msg as GameFightJoinMessage);
                    MountAutoTripManager.getInstance().stopCurrentTrip();
                    preFightIsActive = (!(gfjmsg.isFightStarted));
                    this.fightType = gfjmsg.fightType;
                    if (!Kernel.getWorker().contains(FightEntitiesFrame))
                    {
                        Kernel.getWorker().addFrame(this._entitiesFrame);
                    };
                    if (preFightIsActive)
                    {
                        if (!Kernel.getWorker().contains(FightPreparationFrame))
                        {
                            Kernel.getWorker().addFrame(this._preparationFrame);
                        };
                        this.onlyTheOtherTeamCanPlace = (!(gfjmsg.isTeamPhase));
                    }
                    else
                    {
                        Kernel.getWorker().removeFrame(this._preparationFrame);
                        Kernel.getWorker().addFrame(this._battleFrame);
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightStart);
                        this.onlyTheOtherTeamCanPlace = false;
                    };
                    PlayedCharacterManager.getInstance().isSpectator = false;
                    PlayedCharacterManager.getInstance().isFighting = true;
                    timeBeforeStart = (gfjmsg.timeMaxBeforeFightStart * 100);
                    if (((timeBeforeStart == 0) && (preFightIsActive)))
                    {
                        timeBeforeStart = -1;
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightJoin, gfjmsg.canBeCancelled, gfjmsg.canSayReady, false, timeBeforeStart, gfjmsg.fightType, gfjmsg.isTeamPhase);
                    return (true);
                case (msg is GameActionFightCarryCharacterMessage):
                    gafccmsg = (msg as GameActionFightCarryCharacterMessage);
                    if (((this._lastEffectEntity) && (this._lastEffectEntity.object.id == gafccmsg.targetId)))
                    {
                        this.process(new EntityMouseOutMessage((this._lastEffectEntity.object as IInteractive)));
                    };
                    return (false);
                case (msg is GameFightStartMessage):
                    gfsm = (msg as GameFightStartMessage);
                    preFightIsActive = false;
                    Kernel.getWorker().removeFrame(this._preparationFrame);
                    this._entitiesFrame.removeSwords();
                    CurrentPlayedFighterManager.getInstance().getSpellCastManager().resetInitialCooldown();
                    Kernel.getWorker().addFrame(this._battleFrame);
                    KernelEventsManager.getInstance().processCallback(HookList.GameFightStart);
                    this._fightIdols = gfsm.idols;
                    KernelEventsManager.getInstance().processCallback(FightHookList.FightIdolList, gfsm.idols);
                    return (true);
                case (msg is GameContextDestroyMessage):
                    TooltipManager.hide();
                    Kernel.getWorker().removeFrame(this);
                    return (true);
                case (msg is CellOverMessage):
                    conmsg = (msg as CellOverMessage);
                    fscf = (Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame);
                    for each (entity in EntitiesManager.getInstance().getEntitiesOnCell(conmsg.cellId))
                    {
                        if (((entity is AnimatedCharacter) && (!((entity as AnimatedCharacter).isMoving))))
                        {
                            if (((!(fscf == null)) && (fscf.isTeleportationPreviewEntity(entity.id))))
                            {
                            }
                            else
                            {
                                cellEntity = (entity as AnimatedCharacter);
                                break;
                            };
                        };
                    };
                    currentCell = conmsg.cellId;
                    if (cellEntity)
                    {
                        this.overEntity(cellEntity.id);
                    };
                    mcm = MarkedCellsManager.getInstance();
                    portalOnThisCell = mcm.getMarkAtCellId(conmsg.cellId, GameActionMarkTypeEnum.PORTAL);
                    if (portalOnThisCell)
                    {
                        for each (mi in mcm.getMarks(portalOnThisCell.markType, portalOnThisCell.teamId, false))
                        {
                            glyph = mcm.getGlyph(mi.markId);
                            if (((glyph) && (glyph.lbl_number)))
                            {
                                glyph.lbl_number.visible = true;
                            };
                        };
                        if (((portalOnThisCell.active) && (mcm.getActivePortalsCount(portalOnThisCell.teamId) >= 2)))
                        {
                            mpWithPortals = mcm.getMarksMapPoint(GameActionMarkTypeEnum.PORTAL, portalOnThisCell.teamId);
                            links = LinkedCellsManager.getInstance().getLinks(MapPoint.fromCellId(conmsg.cellId), mpWithPortals);
                            if (links)
                            {
                                LinkedCellsManager.getInstance().drawPortalLinks(links);
                            };
                        };
                    };
                    return (true);
                case (msg is CellOutMessage):
                    coutMsg = (msg as CellOutMessage);
                    for each (entity2 in EntitiesManager.getInstance().getEntitiesOnCell(coutMsg.cellId))
                    {
                        if ((entity2 is AnimatedCharacter))
                        {
                            cellEntity2 = (entity2 as AnimatedCharacter);
                            break;
                        };
                    };
                    currentCell = -1;
                    if (cellEntity2)
                    {
                        TooltipManager.hide();
                        TooltipManager.hide("fighter");
                        this.outEntity(cellEntity2.id);
                    };
                    mcmOut = MarkedCellsManager.getInstance();
                    portalOnThisCellOut = mcmOut.getMarkAtCellId(coutMsg.cellId, GameActionMarkTypeEnum.PORTAL);
                    if (portalOnThisCellOut)
                    {
                        for each (miOut in mcmOut.getMarks(portalOnThisCellOut.markType, portalOnThisCellOut.teamId, false))
                        {
                            glyphOut = mcmOut.getGlyph(miOut.markId);
                            if (((glyphOut) && (glyphOut.lbl_number)))
                            {
                                glyphOut.lbl_number.visible = false;
                            };
                        };
                    };
                    LinkedCellsManager.getInstance().clearLinks();
                    return (true);
                case (msg is EntityMouseOverMessage):
                    emovmsg = (msg as EntityMouseOverMessage);
                    currentCell = emovmsg.entity.position.cellId;
                    this.overEntity(emovmsg.entity.id);
                    return (true);
                case (msg is EntityMouseOutMessage):
                    emomsg = (msg as EntityMouseOutMessage);
                    currentCell = -1;
                    this.outEntity(emomsg.entity.id);
                    return (true);
                case (msg is GameFightLeaveMessage):
                    gflmsg = (msg as GameFightLeaveMessage);
                    if (gflmsg.charId == PlayedCharacterManager.getInstance().id)
                    {
                        PlayedCharacterManager.getInstance().fightId = -1;
                    };
                    if (TooltipManager.isVisible(("tooltipOverEntity_" + gflmsg.charId)))
                    {
                        currentCell = -1;
                        this.outEntity(gflmsg.charId);
                    };
                    return (false);
                case (msg is TimelineEntityOverAction):
                    teoa = (msg as TimelineEntityOverAction);
                    this._timelineOverEntity = true;
                    this._timelineOverEntityId = teoa.targetId;
                    fscf = (Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame);
                    if (!fscf)
                    {
                        this.removeSpellTargetsTooltips();
                    };
                    this.overEntity(teoa.targetId, teoa.showRange, teoa.highlightTimelineFighter, teoa.timelineTarget);
                    return (true);
                case (msg is TimelineEntityOutAction):
                    tleoutaction = (msg as TimelineEntityOutAction);
                    entities = this._entitiesFrame.getEntitiesIdsList();
                    for each (entityId in entities)
                    {
                        if ((((!(this._showPermanentTooltips)) || ((this._showPermanentTooltips) && (this._battleFrame.targetedEntities.indexOf(entityId) == -1))) && (!(entityId == tleoutaction.targetId))))
                        {
                            TooltipManager.hide(("tooltipOverEntity_" + entityId));
                        };
                    };
                    this._timelineOverEntity = false;
                    this.outEntity(tleoutaction.targetId);
                    this.removeSpellTargetsTooltips();
                    return (true);
                case (msg is TogglePointCellAction):
                    if (Kernel.getWorker().contains(PointCellFrame))
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.ShowCell);
                        Kernel.getWorker().removeFrame(PointCellFrame.getInstance());
                    }
                    else
                    {
                        Kernel.getWorker().addFrame(PointCellFrame.getInstance());
                    };
                    return (true);
                case (msg is GameFightEndMessage):
                    gfemsg = (msg as GameFightEndMessage);
                    if (TacticModeManager.getInstance().tacticModeActivated)
                    {
                        TacticModeManager.getInstance().hide(true);
                    };
                    if (this._entitiesFrame.isInCreaturesFightMode())
                    {
                        this._entitiesFrame.showCreaturesInFight(false);
                    };
                    if (this._mustShowTreasureHuntMask)
                    {
                        Atouin.getInstance().toggleWorldMask("treasureHinting", true);
                        this._mustShowTreasureHuntMask = false;
                    };
                    TooltipManager.hide();
                    TooltipManager.hide("fighter");
                    TooltipPlacer.isInFight = false;
                    this.hideMovementRange();
                    CurrentPlayedFighterManager.getInstance().resetPlayerSpellList();
                    MapDisplayManager.getInstance().activeIdentifiedElements(true);
                    FightEventsHelper.sendAllFightEvent(true);
                    if (!PlayedCharacterManager.getInstance().isSpectator)
                    {
                        FightEventsHelper.sendFightEvent(FightEventEnum.FIGHT_END, [], 0, -1, true);
                    };
                    SoundManager.getInstance().manager.stopFightMusic();
                    PlayedCharacterManager.getInstance().isFighting = false;
                    PlayedCharacterManager.getInstance().fightId = -1;
                    SpellWrapper.removeAllSpellWrapperBut(PlayedCharacterManager.getInstance().id, SecureCenter.ACCESS_KEY);
                    SpellWrapper.resetAllCoolDown(PlayedCharacterManager.getInstance().id, SecureCenter.ACCESS_KEY);
                    if (gfemsg.results == null)
                    {
                        KernelEventsManager.getInstance().processCallback(FightHookList.SpectatorWantLeave);
                    }
                    else
                    {
                        fightEnding = new FightEndingMessage();
                        fightEnding.initFightEndingMessage();
                        Kernel.getWorker().process(fightEnding);
                        results = new Vector.<FightResultEntryWrapper>();
                        resultIndex = 0;
                        winners = new Vector.<FightResultEntryWrapper>();
                        temp = [];
                        for each (resultEntryTemp in gfemsg.results)
                        {
                            temp.push(resultEntryTemp);
                        };
                        isSpectator = true;
                        i = 0;
                        while (i < temp.length)
                        {
                            resultEntry = temp[i];
                            switch (true)
                            {
                                case (resultEntry is FightResultPlayerListEntry):
                                    id = (resultEntry as FightResultPlayerListEntry).id;
                                    frew = new FightResultEntryWrapper(resultEntry, (this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations), isSpectator);
                                    frew.alive = FightResultPlayerListEntry(resultEntry).alive;
                                    break;
                                case (resultEntry is FightResultTaxCollectorListEntry):
                                    id = (resultEntry as FightResultTaxCollectorListEntry).id;
                                    frew = new FightResultEntryWrapper(resultEntry, (this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations), isSpectator);
                                    frew.alive = FightResultTaxCollectorListEntry(resultEntry).alive;
                                    break;
                                case (resultEntry is FightResultFighterListEntry):
                                    id = (resultEntry as FightResultFighterListEntry).id;
                                    frew = new FightResultEntryWrapper(resultEntry, (this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations), isSpectator);
                                    frew.alive = FightResultFighterListEntry(resultEntry).alive;
                                    break;
                                case (resultEntry is FightResultListEntry):
                                    frew = new FightResultEntryWrapper(resultEntry, null, isSpectator);
                                    break;
                            };
                            frew.fightInitiator = (this._fightAttackerId == id);
                            frew.wave = resultEntry.wave;
                            if ((((((i + 1) < temp.length) && (temp[(i + 1)])) && (temp[(i + 1)].outcome == resultEntry.outcome)) && (!(temp[(i + 1)].wave == resultEntry.wave))))
                            {
                                frew.isLastOfHisWave = true;
                            };
                            if (resultEntry.outcome == FightOutcomeEnum.RESULT_DEFENDER_GROUP)
                            {
                                hardcoreLoots = frew;
                            }
                            else
                            {
                                if (resultEntry.outcome == FightOutcomeEnum.RESULT_VICTORY)
                                {
                                    winners.push(frew);
                                };
                                var _local_115:* = resultIndex++;
                                results[_local_115] = frew;
                            };
                            if (frew.id == PlayedCharacterManager.getInstance().id)
                            {
                                isSpectator = false;
                                switch (resultEntry.outcome)
                                {
                                    case FightOutcomeEnum.RESULT_VICTORY:
                                        KernelEventsManager.getInstance().processCallback(TriggerHookList.FightResultVictory);
                                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_FIGHT_WON);
                                        break;
                                    case FightOutcomeEnum.RESULT_LOST:
                                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_FIGHT_LOST);
                                        break;
                                };
                                if (frew.rewards.objects.length >= SpeakingItemManager.GREAT_DROP_LIMIT)
                                {
                                    SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_GREAT_DROP);
                                };
                            };
                            i++;
                        };
                        if (hardcoreLoots)
                        {
                            currentWinner = 0;
                            for each (loot in hardcoreLoots.rewards.objects)
                            {
                                winners[currentWinner].rewards.objects.push(loot);
                                currentWinner++;
                                currentWinner = (currentWinner % winners.length);
                            };
                            kamas = hardcoreLoots.rewards.kamas;
                            kamasPerWinner = Math.floor((kamas / winners.length));
                            if ((kamas % winners.length) != 0)
                            {
                                kamasPerWinner++;
                            };
                            for each (winner in winners)
                            {
                                if (kamas < kamasPerWinner)
                                {
                                    winner.rewards.kamas = kamas;
                                }
                                else
                                {
                                    winner.rewards.kamas = kamasPerWinner;
                                };
                                kamas = (kamas - winner.rewards.kamas);
                            };
                        };
                        winnersName = "";
                        losersName = "";
                        for each (namedTeamWO in gfemsg.namedPartyTeamsOutcomes)
                        {
                            if (((namedTeamWO.team.partyName) && (!(namedTeamWO.team.partyName == ""))))
                            {
                                if (namedTeamWO.outcome == FightOutcomeEnum.RESULT_VICTORY)
                                {
                                    winnersName = namedTeamWO.team.partyName;
                                }
                                else
                                {
                                    if (namedTeamWO.outcome == FightOutcomeEnum.RESULT_LOST)
                                    {
                                        losersName = namedTeamWO.team.partyName;
                                    };
                                };
                            };
                        };
                        resultsRecap = new Object();
                        resultsRecap.results = results;
                        resultsRecap.rewardRate = gfemsg.rewardRate;
                        resultsRecap.sizeMalus = gfemsg.lootShareLimitMalus;
                        resultsRecap.duration = gfemsg.duration;
                        resultsRecap.challenges = this.challengesList;
                        resultsRecap.turns = this._battleFrame.turnsCount;
                        resultsRecap.fightType = this._fightType;
                        resultsRecap.winnersName = winnersName;
                        resultsRecap.losersName = losersName;
                        resultsRecap.playSound = true;
                        resultsRecap.isSpectator = isSpectator;
                        if ((msg is BreachGameFightEndMessage))
                        {
                            resultsRecap.budget = (gfemsg as BreachGameFightEndMessage).budget;
                        };
                        idols = new Vector.<uint>();
                        if (this._fightIdols)
                        {
                            numIdols = this._fightIdols.length;
                            j = 0;
                            while (j < numIdols)
                            {
                                idols.push(this._fightIdols[j].id);
                                j++;
                            };
                        };
                        resultsRecap.idols = idols;
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightEnd, resultsRecap);
                    };
                    Kernel.getWorker().removeFrame(this);
                    return (true);
                case (msg is ChallengeTargetsListRequestAction):
                    ctlra = (msg as ChallengeTargetsListRequestAction);
                    ctlrmsg = new ChallengeTargetsListRequestMessage();
                    ctlrmsg.initChallengeTargetsListRequestMessage(ctlra.challengeId);
                    ConnectionsHandler.getConnection().send(ctlrmsg);
                    return (true);
                case (msg is ChallengeTargetsListMessage):
                    ctlmsg = (msg as ChallengeTargetsListMessage);
                    for each (cell in ctlmsg.targetCells)
                    {
                        if (cell != -1)
                        {
                            HyperlinkShowCellManager.showCell(cell);
                        };
                    };
                    return (true);
                case (msg is ChallengeInfoMessage):
                    cimsg = (msg as ChallengeInfoMessage);
                    challenge = this.getChallengeById(cimsg.challengeId);
                    if (!challenge)
                    {
                        challenge = new ChallengeWrapper();
                        this.challengesList.push(challenge);
                    };
                    challenge.id = cimsg.challengeId;
                    challenge.targetId = cimsg.targetId;
                    challenge.xpBonus = cimsg.xpBonus;
                    challenge.dropBonus = cimsg.dropBonus;
                    challenge.result = 0;
                    KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeInfoUpdate, this.challengesList);
                    return (true);
                case (msg is ChallengeTargetUpdateMessage):
                    ctumsg = (msg as ChallengeTargetUpdateMessage);
                    challenge = this.getChallengeById(ctumsg.challengeId);
                    if (challenge == null)
                    {
                        _log.warn((("Got a challenge result with no corresponding challenge (challenge id " + ctumsg.challengeId) + "), skipping."));
                        return (false);
                    };
                    challenge.targetId = ctumsg.targetId;
                    KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeInfoUpdate, this.challengesList);
                    return (true);
                case (msg is ChallengeResultMessage):
                    crmsg = (msg as ChallengeResultMessage);
                    challenge = this.getChallengeById(crmsg.challengeId);
                    if (!challenge)
                    {
                        _log.warn((("Got a challenge result with no corresponding challenge (challenge id " + crmsg.challengeId) + "), skipping."));
                        return (false);
                    };
                    challenge.result = ((crmsg.success) ? 1 : 2);
                    KernelEventsManager.getInstance().processCallback(FightHookList.ChallengeInfoUpdate, this.challengesList);
                    return (true);
                case (msg is ArenaFighterLeaveMessage):
                    aflmsg = (msg as ArenaFighterLeaveMessage);
                    KernelEventsManager.getInstance().processCallback(FightHookList.ArenaFighterLeave, aflmsg.leaver);
                    return (true);
                case (msg is MapObstacleUpdateMessage):
                    moumsg = (msg as MapObstacleUpdateMessage);
                    for each (mo in moumsg.obstacles)
                    {
                        InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId, (mo.state == MapObstacleStateEnum.OBSTACLE_OPENED));
                    };
                    return (true);
                case (msg is GameActionFightNoSpellCastMessage):
                    gafnscmsg = (msg as GameActionFightNoSpellCastMessage);
                    if (((!(gafnscmsg.spellLevelId == 0)) || (!(PlayedCharacterManager.getInstance().currentWeapon))))
                    {
                        if (gafnscmsg.spellLevelId == 0)
                        {
                            sl = Spell.getSpellById(0).getSpellLevel(1);
                        }
                        else
                        {
                            sl = SpellLevel.getLevelById(gafnscmsg.spellLevelId);
                        };
                        canceledApAmout = sl.apCost;
                    }
                    else
                    {
                        canceledApAmout = PlayedCharacterManager.getInstance().currentWeapon.apCost;
                    };
                    CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent = (CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations().actionPointsCurrent + canceledApAmout);
                    return (true);
                case (msg is ShowTacticModeAction):
                    if (PlayedCharacterApi.getInstance().isInPreFight())
                    {
                        return (false);
                    };
                    if (((PlayedCharacterApi.getInstance().isInFight()) || (PlayedCharacterManager.getInstance().isSpectator)))
                    {
                        if ((msg as ShowTacticModeAction).force)
                        {
                            if (!TacticModeManager.getInstance().tacticModeActivated)
                            {
                                TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap);
                            };
                        }
                        else
                        {
                            this.tacticModeHandler(true);
                        };
                    };
                    return (true);
                case (msg is BreachEnterMessage):
                    bemsg = (msg as BreachEnterMessage);
                    PlayedCharacterManager.getInstance().isInBreach = true;
                    if (!Kernel.getWorker().getFrame(BreachFrame))
                    {
                        breachFrame = new BreachFrame();
                        breachFrame.ownerId = bemsg.owner;
                        Kernel.getWorker().addFrame(breachFrame);
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.BreachTeleport, true);
                    return (true);
                case (msg is BreachExitResponseMessage):
                    KernelEventsManager.getInstance().processCallback(HookList.BreachTeleport, false);
                    if (PlayedCharacterManager.getInstance().isInBreach)
                    {
                        if (Berilia.getInstance().getUi("breachTracking"))
                        {
                            Berilia.getInstance().unloadUi("breachTracking");
                        };
                        PlayedCharacterManager.getInstance().isInBreach = false;
                        if (Kernel.getWorker().getFrame(BreachFrame))
                        {
                            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(BreachFrame));
                        };
                    };
                    return (true);
                case (msg is ToggleShowUIAction):
                    tsuia = (msg as ToggleShowUIAction);
                    tsuia.toggleUIs();
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            if (TacticModeManager.getInstance().tacticModeActivated)
            {
                TacticModeManager.getInstance().hide(true);
            };
            if (this._entitiesFrame)
            {
                Kernel.getWorker().removeFrame(this._entitiesFrame);
            };
            if (this._preparationFrame)
            {
                Kernel.getWorker().removeFrame(this._preparationFrame);
            };
            if (this._battleFrame)
            {
                Kernel.getWorker().removeFrame(this._battleFrame);
            };
            SerialSequencer.clearByType(FightSequenceFrame.FIGHT_SEQUENCERS_CATEGORY);
            this._preparationFrame = null;
            this._battleFrame = null;
            this._lastEffectEntity = null;
            this.removeSpellTargetsTooltips();
            TooltipManager.hideAll();
            this._timerFighterInfo.reset();
            this._timerFighterInfo.removeEventListener(TimerEvent.TIMER, this.showFighterInfo);
            this._timerFighterInfo = null;
            this._timerMovementRange.reset();
            this._timerMovementRange.removeEventListener(TimerEvent.TIMER, this.showMovementRange);
            this._timerMovementRange = null;
            this._currentFighterInfo = null;
            if (MapDisplayManager.getInstance().getDataMapContainer())
            {
                MapDisplayManager.getInstance().getDataMapContainer().setTemporaryAnimatedElementState(true);
            };
            Atouin.getInstance().displayGrid(this._roleplayGridDisplayed);
            OptionManager.getOptionManager("dofus").removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            Berilia.getInstance().removeEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE, this.onUiUnloaded);
            var simf:SpellInventoryManagementFrame = (Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame);
            simf.deleteSpellsGlobalCoolDownsData();
            PlayedCharacterManager.getInstance().isSpectator = false;
            Berilia.getInstance().removeEventListener(UiUnloadEvent.UNLOAD_UI_STARTED, this.onUiUnloadStarted);
            Berilia.getInstance().removeEventListener(TooltipEvent.TOOLTIPS_ORDERED, this.onTooltipsOrdered);
            try
            {
                Berilia.getInstance().uiSavedModificationPresetName = null;
            }
            catch(error:Error)
            {
                _log.error(((("Failed to reset uiSavedModificationPresetName!\n" + error.message) + "\n") + error.getStackTrace()));
            };
            return (true);
        }

        public function outEntity(id:Number):void
        {
            var entityId:Number;
            var ttName:String;
            var entitiesOnCell:Array;
            var entityOnCell:AnimatedCharacter;
            this._timerFighterInfo.reset();
            this._timerMovementRange.reset();
            var tooltipsEntitiesIds:Vector.<Number> = new Vector.<Number>(0);
            tooltipsEntitiesIds.push(id);
            var entitiesIdsList:Vector.<Number> = this._entitiesFrame.getEntitiesIdsList();
            fighterEntityTooltipId = id;
            var entity:IEntity = DofusEntities.getEntity(fighterEntityTooltipId);
            if (((!(entity)) || (!(entity.position))))
            {
                if (entitiesIdsList.indexOf(fighterEntityTooltipId) == -1)
                {
                    _log.info(("Mouse out an unknown entity : " + id));
                    return;
                };
            }
            else
            {
                entitiesOnCell = EntitiesManager.getInstance().getEntitiesOnCell(entity.position.cellId, AnimatedCharacter);
                for each (entityOnCell in entitiesOnCell)
                {
                    if (tooltipsEntitiesIds.indexOf(entityOnCell.id) == -1)
                    {
                        tooltipsEntitiesIds.push(entityOnCell.id);
                    };
                };
            };
            if (((this._lastEffectEntity) && (this._lastEffectEntity.object)))
            {
                Sprite(this._lastEffectEntity.object).filters = [];
            };
            this._lastEffectEntity = null;
            var fscf:FightSpellCastFrame = (Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame);
            for each (entityId in tooltipsEntitiesIds)
            {
                ttName = ("tooltipOverEntity_" + entityId);
                if (((((!(this._showPermanentTooltips)) || ((this._showPermanentTooltips) && (this.battleFrame.targetedEntities.indexOf(entityId) == -1))) && (TooltipManager.isVisible(ttName))) && ((fscf == null) || (!(fscf.isTeleportationPreviewEntity(entityId))))))
                {
                    TooltipManager.hide(ttName);
                };
            };
            if (this._showPermanentTooltips)
            {
                for each (entityId in this.battleFrame.targetedEntities)
                {
                    this.displayEntityTooltip(entityId);
                };
            };
            if (entity != null)
            {
                Sprite(entity).filters = [];
            };
            this.hideMovementRange();
            var inviSel:Selection = SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
            if (inviSel)
            {
                inviSel.remove();
            };
            this.removeAsLinkEntityEffect();
            if (((this._currentFighterInfo) && (this._currentFighterInfo.contextualId == id)))
            {
                KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate, null);
                if (((PlayedCharacterManager.getInstance().isSpectator) && (OptionManager.getOptionManager("dofus").getOption("spectatorAutoShowCurrentFighterInfo") == true)))
                {
                    KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate, (FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._battleFrame.currentPlayerId) as GameFightFighterInformations));
                };
            };
            var fightPreparationFrame:FightPreparationFrame = (Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame);
            if (fightPreparationFrame)
            {
                fightPreparationFrame.updateSwapPositionRequestsIcons();
            };
        }

        public function removeSpellTargetsTooltips():void
        {
            var ttEntityId:*;
            for (ttEntityId in this._spellTargetsTooltips)
            {
                TooltipPlacer.removeTooltipPositionByName(("tooltip_tooltipOverEntity_" + ttEntityId));
                delete this._spellTargetsTooltips[ttEntityId];
                TooltipManager.hide(("tooltipOverEntity_" + ttEntityId));
                SpellDamagesManager.getInstance().removeSpellDamages(ttEntityId);
                if ((((this._showPermanentTooltips) && (this._battleFrame)) && (!(this._battleFrame.targetedEntities.indexOf(ttEntityId) == -1))))
                {
                    this.displayEntityTooltip(ttEntityId);
                };
            };
        }

        public function displayEntityTooltip(pEntityId:Number, pSpell:Object=null, pForceRefresh:Boolean=false, pSpellImpactCell:int=-1, pMakerParams:Object=null):void
        {
            var entitiesOnCell:Array;
            var fighterNamedInfo:GameFightFighterNamedInformations;
            var infos:GameFightFighterInformations = (this._entitiesFrame.getEntityInfos(pEntityId) as GameFightFighterInformations);
            var updateTime:uint = getTimer();
            this._tooltipLastUpdate[pEntityId] = updateTime;
            if (((!(infos)) || ((!(this._battleFrame.targetedEntities.indexOf(pEntityId) == -1)) && (!(this._hiddenEntites.indexOf(pEntityId) == -1)))))
            {
                return;
            };
            var spellImpactCell:int = ((pSpellImpactCell != -1) ? pSpellImpactCell : currentCell);
            if (((pSpell) && (spellImpactCell == -1)))
            {
                return;
            };
            if ((pSpell is SpellWrapper))
            {
                entitiesOnCell = EntitiesManager.getInstance().getEntitiesOnCell(spellImpactCell, AnimatedCharacter);
                if ((((pSpell.spellLevelInfos as SpellLevel).needTakenCell) && (entitiesOnCell.length == 0)))
                {
                    return;
                };
            };
            var tooltipCacheName:String = ("EntityShortInfos" + infos.contextualId);
            infos = (this._entitiesFrame.getEntityInfos(pEntityId) as GameFightFighterInformations);
            var entity:IDisplayable = (DofusEntities.getEntity(pEntityId) as IDisplayable);
            if (((!(pMakerParams == null)) && (!(pMakerParams.previewEntity == null))))
            {
                entity = pMakerParams.previewEntity;
            };
            if (entity == null)
            {
                return;
            };
            var target:IRectangle = entity.absoluteBounds;
            var typeString:String = "monsterFighter";
            if ((infos is GameFightCharacterInformations))
            {
                tooltipCacheName = ("PlayerShortInfos" + infos.contextualId);
                typeString = null;
                fighterNamedInfo = (infos as GameFightFighterNamedInformations);
                if (((fighterNamedInfo) && (fighterNamedInfo.hiddenInPrefight)))
                {
                    return;
                };
            }
            else
            {
                if ((infos is GameFightEntityInformation))
                {
                    typeString = "companionFighter";
                };
            };
            TooltipManager.show(infos, target, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, ("tooltipOverEntity_" + infos.contextualId), LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, typeString, null, pMakerParams, tooltipCacheName, false, StrataEnum.STRATA_WORLD, Atouin.getInstance().currentZoom);
            var fightPreparationFrame:FightPreparationFrame = (Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame);
            if (fightPreparationFrame)
            {
                fightPreparationFrame.updateSwapPositionRequestsIcons();
            };
            if (((tooltipCacheName) && (TooltipManager.hasCache(tooltipCacheName))))
            {
                this._entitiesFrame.updateEntityIconPosition(pEntityId);
            };
        }

        public function addToHiddenEntities(entityId:Number):void
        {
            if (this._hiddenEntites.indexOf(entityId) == -1)
            {
                this._hiddenEntites.push(entityId);
            };
        }

        public function removeFromHiddenEntities(entityId:Number):void
        {
            if (this._hiddenEntites.indexOf(entityId) != -1)
            {
                this._hiddenEntites.splice(this._hiddenEntites.indexOf(entityId), 1);
            };
        }

        private function initFighterPositionHistory(pFighterId:Number):void
        {
            var fightContextFrame:FightContextFrame;
            if (!this._fightersPositionsHistory[pFighterId])
            {
                fightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                this._fightersPositionsHistory[pFighterId] = [{
                    "cellId":fightContextFrame.entitiesFrame.getEntityInfos(pFighterId).disposition.cellId,
                    "lives":2
                }];
            };
        }

        public function getFighterPreviousPosition(pFighterId:Number):int
        {
            this.initFighterPositionHistory(pFighterId);
            var positions:Array = this._fightersPositionsHistory[pFighterId];
            var savedPos:Object = ((positions.length > 1) ? positions[(positions.length - 2)] : null);
            return ((savedPos) ? savedPos.cellId : -1);
        }

        public function deleteFighterPreviousPosition(pFighterId:Number):void
        {
            if (this._fightersPositionsHistory[pFighterId])
            {
                this._fightersPositionsHistory[pFighterId].pop();
            };
        }

        public function saveFighterPosition(pFighterId:Number, pCellId:uint):void
        {
            this.initFighterPositionHistory(pFighterId);
            this._fightersPositionsHistory[pFighterId].push({
                "cellId":pCellId,
                "lives":2
            });
        }

        public function getFighterRoundStartPosition(pFighterId:Number):int
        {
            return (this._fightersRoundStartPosition[pFighterId]);
        }

        public function setFighterRoundStartPosition(pFighterId:Number, cellId:int):int
        {
            return (this._fightersRoundStartPosition[pFighterId] = cellId);
        }

        public function refreshTimelineOverEntityInfos():void
        {
            var entity:IEntity;
            if (((this._timelineOverEntity) && (this._timelineOverEntityId)))
            {
                entity = DofusEntities.getEntity(this._timelineOverEntityId);
                if (((entity) && (entity.position)))
                {
                    FightContextFrame.currentCell = entity.position.cellId;
                    this.overEntity(this._timelineOverEntityId);
                };
            };
        }

        private function getFighterInfos(fighterId:Number):GameFightFighterInformations
        {
            return (this.entitiesFrame.getEntityInfos(fighterId) as GameFightFighterInformations);
        }

        private function showFighterInfo(event:TimerEvent):void
        {
            this._timerFighterInfo.reset();
            KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate, this._currentFighterInfo);
        }

        private function showMovementRange(event:TimerEvent):void
        {
            this._timerMovementRange.reset();
            var reachableRangeSelection:Selection = new Selection();
            reachableRangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA, 0.7);
            reachableRangeSelection.color = new Color(this.REACHABLE_CELL_COLOR);
            var unreachableRangeSelection:Selection = new Selection();
            unreachableRangeSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA, 0.7);
            unreachableRangeSelection.color = new Color(this.UNREACHABLE_CELL_COLOR);
            var fightReachableCellsMaker:FightReachableCellsMaker = new FightReachableCellsMaker(this._currentFighterInfo);
            reachableRangeSelection.zone = new Custom(fightReachableCellsMaker.reachableCells);
            unreachableRangeSelection.zone = new Custom(fightReachableCellsMaker.unreachableCells);
            SelectionManager.getInstance().addSelection(reachableRangeSelection, "movementReachableRange", this._currentFighterInfo.disposition.cellId);
            SelectionManager.getInstance().addSelection(unreachableRangeSelection, "movementUnreachableRange", this._currentFighterInfo.disposition.cellId);
        }

        private function hideMovementRange():void
        {
            var s:Selection = SelectionManager.getInstance().getSelection("movementReachableRange");
            if (s)
            {
                s.remove();
            };
            s = SelectionManager.getInstance().getSelection("movementUnreachableRange");
            if (s)
            {
                s.remove();
            };
        }

        private function addMarks(marks:Vector.<GameActionMark>):void
        {
            var mark:GameActionMark;
            var spell:Spell;
            var step:AddGlyphGfxStep;
            var cellZone:GameActionMarkedCell;
            for each (mark in marks)
            {
                spell = Spell.getSpellById(mark.markSpellId);
                if (((mark.markType == GameActionMarkTypeEnum.WALL) || (spell.getSpellLevel(mark.markSpellLevel).hasZoneShape(SpellShapeEnum.semicolon))))
                {
                    if (spell.getParamByName("glyphGfxId"))
                    {
                        for each (cellZone in mark.cells)
                        {
                            step = new AddGlyphGfxStep(spell.getParamByName("glyphGfxId"), cellZone.cellId, mark.markId, mark.markType, mark.markTeamId, mark.active);
                            step.start();
                        };
                    };
                }
                else
                {
                    if ((((spell.getParamByName("glyphGfxId")) && (!(MarkedCellsManager.getInstance().getGlyph(mark.markId)))) && (!(mark.markimpactCell == -1))))
                    {
                        step = new AddGlyphGfxStep(spell.getParamByName("glyphGfxId"), mark.markimpactCell, mark.markId, mark.markType, mark.markTeamId, mark.active);
                        step.start();
                    };
                };
                MarkedCellsManager.getInstance().addMark(mark.markAuthorId, mark.markId, mark.markType, spell, spell.getSpellLevel(mark.markSpellLevel), mark.cells, mark.markTeamId, mark.active, mark.markimpactCell);
            };
        }

        private function removeAsLinkEntityEffect():void
        {
            var entityId:Number;
            var entity:DisplayObject;
            var index:int;
            for each (entityId in this._entitiesFrame.getEntitiesIdsList())
            {
                entity = (DofusEntities.getEntity(entityId) as DisplayObject);
                if ((((entity) && (entity.filters)) && (entity.filters.length)))
                {
                    index = 0;
                    while (index < entity.filters.length)
                    {
                        if ((entity.filters[index] is ColorMatrixFilter))
                        {
                            entity.filters = entity.filters.splice(index, index);
                            break;
                        };
                        index++;
                    };
                };
            };
        }

        private function highlightAsLinkedEntity(id:Number, isMainEntity:Boolean):void
        {
            var filter:ColorMatrixFilter;
            var entity:IEntity = DofusEntities.getEntity(id);
            if (!entity)
            {
                return;
            };
            var entitySprite:Sprite = (entity as Sprite);
            if (entitySprite)
            {
                filter = ((isMainEntity) ? this._linkedMainEffect : this._linkedEffect);
                if (entitySprite.filters.length)
                {
                    if (entitySprite.filters[0] != filter)
                    {
                        entitySprite.filters = [filter];
                    };
                }
                else
                {
                    entitySprite.filters = [filter];
                };
            };
        }

        private function overEntity(id:Number, showRange:Boolean=true, highlightTimelineFighter:Boolean=true, timelineTarget:IRectangle=null):void
        {
            var entityId:Number;
            var showInfos:Boolean;
            var entityInfo:GameFightFighterInformations;
            var inviSelection:Selection;
            var pos:int;
            var lastMovPoint:int;
            var reachableCells:FightReachableCellsMaker;
            var makerParams:Object;
            var effect:GlowFilter;
            var fightTurnFrame:FightTurnFrame;
            var myTurn:Boolean;
            var entitiesIdsList:Vector.<Number> = this._entitiesFrame.getEntitiesIdsList();
            fighterEntityTooltipId = id;
            var entity:IEntity = DofusEntities.getEntity(fighterEntityTooltipId);
            if (!entity)
            {
                if (entitiesIdsList.indexOf(fighterEntityTooltipId) == -1)
                {
                    _log.warn(("Mouse over an unknown entity : " + id));
                    return;
                };
                showRange = false;
            };
            var infos:GameFightFighterInformations = (this._entitiesFrame.getEntityInfos(id) as GameFightFighterInformations);
            if (!infos)
            {
                _log.warn(("Mouse over an unknown entity : " + id));
                return;
            };
            var summonerId:Number = infos.stats.summoner;
            if ((infos is GameFightEntityInformation))
            {
                summonerId = (infos as GameFightEntityInformation).masterId;
            };
            for each (entityId in entitiesIdsList)
            {
                if (entityId != id)
                {
                    entityInfo = (this._entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations);
                    if (((entityInfo) && ((((entityInfo.stats.summoner == id) || (summonerId == entityId)) || ((entityInfo.stats.summoner == summonerId) && (summonerId))) || ((entityInfo is GameFightEntityInformation) && ((entityInfo as GameFightEntityInformation).masterId == id)))))
                    {
                        this.highlightAsLinkedEntity(entityId, (summonerId == entityId));
                    };
                };
            };
            this._currentFighterInfo = infos;
            showInfos = true;
            if (((PlayedCharacterManager.getInstance().isSpectator) && (OptionManager.getOptionManager("dofus").getOption("spectatorAutoShowCurrentFighterInfo") == true)))
            {
                showInfos = (!(this._battleFrame.currentPlayerId == id));
            };
            if (((showInfos) && (highlightTimelineFighter)))
            {
                this._timerFighterInfo.reset();
                this._timerFighterInfo.start();
            };
            if (infos.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)
            {
                _log.info("Mouse over an invisible entity in timeline");
                inviSelection = SelectionManager.getInstance().getSelection(this.INVISIBLE_POSITION_SELECTION);
                if (!inviSelection)
                {
                    inviSelection = new Selection();
                    inviSelection.color = new Color(52326);
                    inviSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
                    SelectionManager.getInstance().addSelection(inviSelection, this.INVISIBLE_POSITION_SELECTION);
                };
                pos = FightEntitiesFrame.getCurrentInstance().getLastKnownEntityPosition(infos.contextualId);
                if (pos > -1)
                {
                    lastMovPoint = FightEntitiesFrame.getCurrentInstance().getLastKnownEntityMovementPoint(infos.contextualId);
                    reachableCells = new FightReachableCellsMaker(this._currentFighterInfo, pos, lastMovPoint);
                    inviSelection.zone = new Custom(reachableCells.reachableCells);
                    SelectionManager.getInstance().update(this.INVISIBLE_POSITION_SELECTION, pos);
                };
                return;
            };
            var fscf:FightSpellCastFrame = (Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame);
            if (!fscf)
            {
                makerParams = {"target":timelineTarget};
                this.displayEntityTooltip(id, null, false, -1, makerParams);
            };
            var movementSelection:Selection = SelectionManager.getInstance().getSelection(FightTurnFrame.SELECTION_PATH);
            if (movementSelection)
            {
                movementSelection.remove();
            };
            if (showRange)
            {
                if (((Kernel.getWorker().contains(FightBattleFrame)) && (!(Kernel.getWorker().contains(FightSpellCastFrame)))))
                {
                    this._timerMovementRange.reset();
                    this._timerMovementRange.start();
                };
            };
            if ((((this._lastEffectEntity) && (this._lastEffectEntity.object is Sprite)) && (!(this._lastEffectEntity.object == entity))))
            {
                Sprite(this._lastEffectEntity.object).filters = [];
            };
            var entitySprite:Sprite = (entity as Sprite);
            if (entitySprite)
            {
                fightTurnFrame = (Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame);
                myTurn = ((fightTurnFrame) ? fightTurnFrame.myTurn : true);
                if ((((!(fscf)) || (FightSpellCastFrame.isCurrentTargetTargetable())) && (myTurn)))
                {
                    effect = this._overEffectOk;
                }
                else
                {
                    effect = this._overEffectKo;
                };
                if (entitySprite.filters.length)
                {
                    if (entitySprite.filters[0] != effect)
                    {
                        entitySprite.filters = [effect];
                    };
                }
                else
                {
                    entitySprite.filters = [effect];
                };
                this._lastEffectEntity = new WeakReference(entity);
            };
        }

        private function tacticModeHandler(forceOpen:Boolean=false):void
        {
            if (((forceOpen) && (!(TacticModeManager.getInstance().tacticModeActivated))))
            {
                TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap);
            }
            else
            {
                if (TacticModeManager.getInstance().tacticModeActivated)
                {
                    TacticModeManager.getInstance().hide();
                };
            };
        }

        private function onPropertyChanged(pEvent:PropertyChangeEvent):void
        {
            var entityId:Number;
            var showInfos:Boolean;
            switch (pEvent.propertyName)
            {
                case "showPermanentTargetsTooltips":
                    this._showPermanentTooltips = (pEvent.propertyValue as Boolean);
                    for each (entityId in this._battleFrame.targetedEntities)
                    {
                        if (!this._showPermanentTooltips)
                        {
                            TooltipManager.hide(("tooltipOverEntity_" + entityId));
                        }
                        else
                        {
                            this.displayEntityTooltip(entityId);
                        };
                    };
                    break;
                case "spectatorAutoShowCurrentFighterInfo":
                    if (PlayedCharacterManager.getInstance().isSpectator)
                    {
                        showInfos = (pEvent.propertyValue as Boolean);
                        if (!showInfos)
                        {
                            KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate, null);
                        }
                        else
                        {
                            KernelEventsManager.getInstance().processCallback(FightHookList.FighterInfoUpdate, (FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._battleFrame.currentPlayerId) as GameFightFighterInformations));
                        };
                    };
                    break;
            };
        }

        private function onUiUnloadStarted(pEvent:UiUnloadEvent):void
        {
            var nameSplit:Array;
            var entityId:Number;
            var entity:AnimatedCharacter;
            if (((pEvent.name) && (!(pEvent.name.indexOf("tooltipOverEntity_") == -1))))
            {
                nameSplit = pEvent.name.split("_");
                entityId = nameSplit[(nameSplit.length - 1)];
                entity = (DofusEntities.getEntity(entityId) as AnimatedCharacter);
                if (((((entity) && (entity.parent)) && (entity.displayed)) && (this._entitiesFrame.hasIcon(entityId))))
                {
                    this._entitiesFrame.getIcon(entityId).place(this._entitiesFrame.getIconEntityBounds(entity));
                };
            };
        }

        private function onTooltipsOrdered(pEvent:TooltipEvent):void
        {
            var entityId:Number;
            var entitiesIds:Vector.<Number> = this.entitiesFrame.getEntitiesIdsList();
            for each (entityId in entitiesIds)
            {
                if (Berilia.getInstance().getUi(("tooltip_tooltipOverEntity_" + entityId)))
                {
                    this._entitiesFrame.updateEntityIconPosition(entityId);
                };
            };
        }


    }
} com.ankamagames.dofus.logic.game.fight.frames

