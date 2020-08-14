package com.ankamagames.dofus.logic.game.fight.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.dofus.logic.game.common.misc.ISpellCastProvider;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.sequencer.ISequencable;
    import com.ankamagames.jerakine.sequencer.SerialSequencer;
    import com.ankamagames.dofus.logic.game.fight.steps.FightPlaySpellScriptStep;
    import com.ankamagames.dofus.logic.game.fight.miscs.SpellScriptBuffer;
    import com.ankamagames.jerakine.types.Callback;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.jerakine.sequencer.ParallelStartSequenceStep;
    import com.ankamagames.jerakine.sequencer.ISequencer;
    import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightRefreshFighterMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSpellCastMessage;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.network.messages.game.context.GameMapMovementMessage;
    import com.ankamagames.dofus.network.messages.game.character.stats.FighterStatsListMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightPointsVariationMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifeAndShieldPointsLostMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifePointsGainMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightLifePointsLostMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTeleportOnSameMapMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightExchangePositionsMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSlideMessage;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSummonMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightMultipleSummonMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightMarkCellsMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightUnmarkCellsMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightChangeLookMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightInvisibilityMessage;
    import com.ankamagames.dofus.logic.game.fight.messages.GameActionFightLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDeathMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightVanishMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellEffectMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellSpellMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDodgePointLossMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSpellCooldownVariationMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightSpellImmunityMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightKillMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightReduceDamagesMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightReflectDamagesMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightReflectSpellMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightStealKamaMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTackledMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTriggerGlyphTrapMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightActivateGlyphTrapMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDispellableEffectMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightModifyEffectsDurationMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCarryCharacterMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightThrowCharacterMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDropCharacterMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightInvisibleDetectedMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnListMessage;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCloseCombatMessage;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.atouin.types.GraphicCell;
    import flash.geom.Point;
    import com.ankamagames.dofus.logic.game.fight.steps.FightRefreshFighterStep;
    import com.ankamagames.dofus.misc.utils.GameDebugManager;
    import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
    import com.ankamagames.dofus.network.enums.FightSpellCastCriticalEnum;
    import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
    import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankama.dofus.enums.ActionIds;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
    import com.ankamagames.dofus.logic.game.fight.steps.FightChangeLookStep;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.tiphon.types.TiphonUtility;
    import com.ankamagames.dofus.logic.game.fight.steps.FightCloseCombatStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightSpellCastStep;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.TriggerHookList;
    import com.ankamagames.dofus.logic.game.fight.steps.FightSpellCooldownVariationStep;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
    import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.dofus.logic.game.fight.steps.FightFighterStatsListStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightShieldPointsVariationStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightLifeVariationStep;
    import tools.enumeration.ElementEnum;
    import com.ankamagames.dofus.logic.game.fight.steps.FightUnmarkCellsStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightChangeVisibilityStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightVanishStep;
    import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTriggerEffectMessage;
    import com.ankamagames.dofus.logic.game.fight.steps.FightDispellEffectStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightDispellSpellStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightDispellStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightSpellImmunityStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightKillStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightReducedDamagesStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightReflectedDamagesStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightReflectedSpellStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightStealingKamasStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightTackledStep;
    import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceEndMessage;
    import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceStartMessage;
    import com.ankamagames.dofus.logic.game.fight.steps.FightMarkActivateStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightModifyEffectsDurationStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightCarryCharacterStep;
    import com.ankamagames.jerakine.sequencer.CallbackStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightInvisibleTemporarilyDetectedStep;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.logic.game.fight.steps.FightTurnListStep;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSynchronizeMessage;
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.types.events.SequencerEvent;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.logic.game.fight.steps.FightDeathStep;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
    import com.ankamagames.dofus.logic.game.fight.miscs.TackleUtil;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
    import com.ankamagames.dofus.logic.game.fight.steps.FightMarkCellsStep;
    import com.ankamagames.dofus.network.types.game.context.fight.GameContextSummonsInformation;
    import com.ankamagames.dofus.network.types.game.context.fight.GameContextBasicSpawnInformation;
    import com.ankamagames.dofus.network.types.game.context.fight.SpawnCharacterInformation;
    import com.ankamagames.dofus.network.types.game.context.fight.SpawnCompanionInformation;
    import com.ankamagames.dofus.network.types.game.context.fight.SpawnMonsterInformation;
    import com.ankamagames.dofus.network.types.game.context.fight.SpawnScaledMonsterInformation;
    import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterRandomStaticPoseMessage;
    import flash.display.Sprite;
    import com.ankamagames.dofus.logic.game.fight.steps.FightVisibilityStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightExchangePositionsStep;
    import com.ankamagames.dofus.logic.game.common.managers.MapMovementAdapter;
    import com.ankamagames.jerakine.types.positions.MovementPath;
    import com.ankamagames.dofus.logic.game.fight.steps.FightEntityMovementStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightMarkTriggeredStep;
    import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
    import tools.enumeration.GameActionMarkTypeEnum;
    import com.ankamagames.dofus.datacenter.effects.Effect;
    import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdProtocol;
    import com.ankamagames.dofus.network.types.game.actions.fight.AbstractFightDispellableEffect;
    import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
    import com.ankamagames.dofus.logic.game.fight.steps.FightLeavingStateStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightEnteringStateStep;
    import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
    import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostEffect;
    import com.ankamagames.dofus.logic.game.fight.steps.FightTemporaryBoostStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightDisplayBuffStep;
    import com.ankamagames.tiphon.sequence.WaitAnimationEventStep;
    import com.ankamagames.tiphon.sequence.PlayAnimationStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightActionPointsVariationStep;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.types.enums.AnimationEnum;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
    import com.ankamagames.dofus.types.sequences.AddGfxInLineStep;
    import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
    import com.ankamagames.atouin.types.sequences.ParableGfxMovementStep;
    import com.ankamagames.atouin.types.sequences.AddWorldEntityStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightLossAnimStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightTeleportStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightEntitySlideStep;
    import com.ankamagames.dofus.logic.game.fight.steps.IFightStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightMovementPointsVariationStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightActionPointsLossDodgeStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightMovementPointsLossDodgeStep;
    import com.ankamagames.dofus.logic.game.fight.steps.FightThrowCharacterStep;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
    import tools.ActionIdHelper;
    import com.ankamagames.dofus.logic.game.fight.steps.FightSummonStep;
    import __AS3__.vec.*;

    public class FightSequenceFrame implements Frame, ISpellCastProvider 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightSequenceFrame));
        private static var _lastCastingSpell:CastingSpell;
        private static var _currentInstanceId:uint;
        public static const FIGHT_SEQUENCERS_CATEGORY:String = "FightSequencer";

        private var _castingSpell:CastingSpell;
        private var _castingSpells:Vector.<CastingSpell>;
        private var _stepsBuffer:Vector.<ISequencable>;
        public var mustAck:Boolean;
        public var ackIdent:int;
        private var _sequenceEndCallback:Function;
        private var _subSequenceWaitingCount:uint = 0;
        private var _scriptInit:Boolean;
        private var _sequencer:SerialSequencer;
        private var _parent:FightSequenceFrame;
        private var _fightBattleFrame:FightBattleFrame;
        private var _fightEntitiesFrame:FightEntitiesFrame;
        private var _instanceId:uint;
        private var _teleportThroughPortal:Boolean;
        private var _teleportPortalId:int;
        private var _updateMovementAreaAtSequenceEnd:Boolean;
        private var _playSpellScriptStep:FightPlaySpellScriptStep;
        private var _spellScriptTemporaryBuffer:SpellScriptBuffer;
        private var _permanentTooltipsCallback:Callback;

        public function FightSequenceFrame(pFightBattleFrame:FightBattleFrame, parent:FightSequenceFrame=null)
        {
            this._instanceId = _currentInstanceId++;
            this._fightBattleFrame = pFightBattleFrame;
            this._parent = parent;
            this.clearBuffer();
        }

        public static function get lastCastingSpell():CastingSpell
        {
            return (_lastCastingSpell);
        }

        public static function get currentInstanceId():uint
        {
            return (_currentInstanceId);
        }

        private static function deleteTooltip(fighterId:Number):void
        {
            var fightContextFrame:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            if (((FightContextFrame.fighterEntityTooltipId == fighterId) && (!(FightContextFrame.fighterEntityTooltipId == fightContextFrame.timelineOverEntityId))))
            {
                if (fightContextFrame)
                {
                    fightContextFrame.outEntity(fighterId);
                };
            };
        }


        public function get priority():int
        {
            return (Priority.HIGHEST);
        }

        public function get castingSpell():CastingSpell
        {
            if (((this._castingSpells) && (this._castingSpells.length > 1)))
            {
                return (this._castingSpells[(this._castingSpells.length - 1)]);
            };
            return (this._castingSpell);
        }

        public function get stepsBuffer():Vector.<ISequencable>
        {
            return (this._stepsBuffer);
        }

        public function get parent():FightSequenceFrame
        {
            return (this._parent);
        }

        public function get isWaiting():Boolean
        {
            return ((!(this._subSequenceWaitingCount == 0)) || (!(this._scriptInit)));
        }

        public function get instanceId():uint
        {
            return (this._instanceId);
        }

        public function pushed():Boolean
        {
            this._scriptInit = false;
            return (true);
        }

        public function pulled():Boolean
        {
            this._stepsBuffer = null;
            this._castingSpell = null;
            this._castingSpells = null;
            _lastCastingSpell = null;
            this._sequenceEndCallback = null;
            this._parent = null;
            this._fightBattleFrame = null;
            this._fightEntitiesFrame = null;
            this._sequencer.clear();
            return (true);
        }

        public function get fightEntitiesFrame():FightEntitiesFrame
        {
            if (!this._fightEntitiesFrame)
            {
                this._fightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            };
            return (this._fightEntitiesFrame);
        }

        public function addSubSequence(sequence:ISequencer):void
        {
            this._subSequenceWaitingCount++;
            this._stepsBuffer.push(new ParallelStartSequenceStep([sequence], false));
        }

        public function process(msg:Message):Boolean
        {
            var gfrfmsg:GameFightRefreshFighterMessage;
            var gafscmsg:GameActionFightSpellCastMessage;
            var forceDetailedLogs:Boolean;
            var closeCombatWeaponId:uint;
            var fxScriptId:int;
            var fightEntitiesFrame_gfcc_gfsc_msg:FightEntitiesFrame;
            var sourceCellId:int;
            var tempCastingSpell:CastingSpell;
            var critical:Boolean;
            var entities:Dictionary;
            var fighter:GameFightFighterInformations;
            var playerManager:PlayedCharacterManager;
            var isAlly:Boolean;
            var playerId:Number;
            var sourceInfos:GameFightFighterInformations;
            var playerInfos:GameFightFighterInformations;
            var target:GameFightFighterInformations;
            var gmmmsg:GameMapMovementMessage;
            var fslmsg:FighterStatsListMessage;
            var gafpvmsg:GameActionFightPointsVariationMessage;
            var gaflasplmsg:GameActionFightLifeAndShieldPointsLostMessage;
            var gaflpgmsg:GameActionFightLifePointsGainMessage;
            var gaflplmsg:GameActionFightLifePointsLostMessage;
            var gaftosmmsg:GameActionFightTeleportOnSameMapMessage;
            var gafepmsg:GameActionFightExchangePositionsMessage;
            var gafsmsg:GameActionFightSlideMessage;
            var fightContextFrame_gafsmsg:FightContextFrame;
            var slideTargetInfos:GameContextActorInformations;
            var gafsnmsg:GameActionFightSummonMessage;
            var gafmsmsg:GameActionFightMultipleSummonMessage;
            var gffinfos:GameFightFighterInformations;
            var gafmcmsg:GameActionFightMarkCellsMessage;
            var gafucmsg:GameActionFightUnmarkCellsMessage;
            var gafclmsg:GameActionFightChangeLookMessage;
            var gafimsg:GameActionFightInvisibilityMessage;
            var fightEntitiesFrame:FightEntitiesFrame;
            var inviInfo:GameContextActorInformations;
            var gaflmsg:GameActionFightLeaveMessage;
            var gafdmsg:GameActionFightDeathMessage;
            var gafvmsg:GameActionFightVanishMessage;
            var entityInfosv:GameContextActorInformations;
            var fightContextFrame_gafvmsg:FightContextFrame;
            var gafdiemsg:GameActionFightDispellEffectMessage;
            var gafdsmsg:GameActionFightDispellSpellMessage;
            var gafdimsg:GameActionFightDispellMessage;
            var gafdplmsg:GameActionFightDodgePointLossMessage;
            var gafscvmsg:GameActionFightSpellCooldownVariationMessage;
            var gafsimsg:GameActionFightSpellImmunityMessage;
            var gafkmsg:GameActionFightKillMessage;
            var gafredmsg:GameActionFightReduceDamagesMessage;
            var gafrfdmsg:GameActionFightReflectDamagesMessage;
            var gafrsmsg:GameActionFightReflectSpellMessage;
            var gafskmsg:GameActionFightStealKamaMessage;
            var gaftmsg:GameActionFightTackledMessage;
            var gaftgtmsg:GameActionFightTriggerGlyphTrapMessage;
            var gafagtmsg:GameActionFightActivateGlyphTrapMessage;
            var gaftbmsg:GameActionFightDispellableEffectMessage;
            var gafmedmsg:GameActionFightModifyEffectsDurationMessage;
            var gafcchmsg:GameActionFightCarryCharacterMessage;
            var gaftcmsg:GameActionFightThrowCharacterMessage;
            var throwCellId:uint;
            var fightContextFrame_gaftcmsg:FightContextFrame;
            var gafdcmsg:GameActionFightDropCharacterMessage;
            var dropCellId:uint;
            var gafidMsg:GameActionFightInvisibleDetectedMessage;
            var gftmsg:GameFightTurnListMessage;
            var gafccmsg:GameActionFightCloseCombatMessage;
            var cssb:SpellScriptBuffer;
            var startIndex:uint;
            var stepsChanged:Boolean;
            var playSpellScriptStepPosition:uint;
            var lookWithMount:TiphonEntityLook;
            var sliced:Vector.<ISequencable>;
            var stepIndex:uint;
            var stepSubIndex:uint;
            var spellTargetEntities:Array;
            var isSpellKnown:Boolean;
            var playerSpellLevel:SpellLevel;
            var spellKnown:SpellWrapper;
            var spell:Spell;
            var castSpellLevel:SpellLevel;
            var fe:Dictionary;
            var fighterInfos:GameFightFighterInformations;
            var simf:SpellInventoryManagementFrame;
            var gcdValue:int;
            var gfsc:GameFightSpellCooldown;
            var shape:uint;
            var ei:EffectInstance;
            var ts:TiphonSprite;
            var targetedCell:GraphicCell;
            var cellPos:Point;
            var fightContextFrame_gafcchmsg:FightContextFrame;
            switch (true)
            {
                case (msg is GameFightRefreshFighterMessage):
                    gfrfmsg = (msg as GameFightRefreshFighterMessage);
                    this.keepInMindToUpdateMovementArea();
                    this._stepsBuffer.push(new FightRefreshFighterStep(gfrfmsg.informations));
                    return (true);
                case (msg is GameActionFightCloseCombatMessage):
                case (msg is GameActionFightSpellCastMessage):
                    forceDetailedLogs = GameDebugManager.getInstance().detailedFightLog_showEverything;
                    if (!this._castingSpells)
                    {
                        this._castingSpells = new Vector.<CastingSpell>();
                    };
                    if ((msg is GameActionFightSpellCastMessage))
                    {
                        gafscmsg = (msg as GameActionFightSpellCastMessage);
                        if (forceDetailedLogs)
                        {
                            gafscmsg.verboseCast = true;
                        };
                    }
                    else
                    {
                        gafccmsg = (msg as GameActionFightCloseCombatMessage);
                        closeCombatWeaponId = gafccmsg.weaponGenericId;
                        gafscmsg = new GameActionFightSpellCastMessage();
                        gafscmsg.initGameActionFightSpellCastMessage(gafccmsg.actionId, gafccmsg.sourceId, gafccmsg.targetId, gafccmsg.destinationCellId, gafccmsg.critical, gafccmsg.silentCast, gafccmsg.verboseCast);
                        if (forceDetailedLogs)
                        {
                            gafscmsg.verboseCast = true;
                        };
                        if (gafccmsg.sourceId == PlayedCharacterManager.getInstance().id)
                        {
                            SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_PLAYER_CLOSE_COMBAT);
                        };
                    };
                    fightEntitiesFrame_gfcc_gfsc_msg = FightEntitiesFrame.getCurrentInstance();
                    sourceCellId = fightEntitiesFrame_gfcc_gfsc_msg.getEntityInfos(gafscmsg.sourceId).disposition.cellId;
                    tempCastingSpell = new CastingSpell();
                    tempCastingSpell.casterId = gafscmsg.sourceId;
                    tempCastingSpell.spell = Spell.getSpellById(gafscmsg.spellId);
                    tempCastingSpell.spellRank = tempCastingSpell.spell.getSpellLevel(gafscmsg.spellLevel);
                    tempCastingSpell.isCriticalFail = (gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL);
                    tempCastingSpell.isCriticalHit = (gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_HIT);
                    tempCastingSpell.silentCast = gafscmsg.silentCast;
                    tempCastingSpell.portalIds = gafscmsg.portalsIds;
                    tempCastingSpell.portalMapPoints = MarkedCellsManager.getInstance().getMapPointsFromMarkIds(gafscmsg.portalsIds);
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug((((((((((("\r[BUFFS DEBUG] Sort " + tempCastingSpell.spell.name) + " (") + gafscmsg.spellId) + ") lancé par ") + gafscmsg.sourceId) + " sur ") + gafscmsg.targetId) + " (cellule ") + gafscmsg.destinationCellId) + ")"));
                    };
                    if (!this._fightBattleFrame.currentPlayerId)
                    {
                        BuffManager.getInstance().spellBuffsToIgnore.push(tempCastingSpell);
                    };
                    if (gafscmsg.destinationCellId != -1)
                    {
                        tempCastingSpell.targetedCell = MapPoint.fromCellId(gafscmsg.destinationCellId);
                    };
                    if (((gafscmsg) && (gafscmsg.actionId == ActionIds.ACTION_FINISH_MOVE)))
                    {
                        if (!OptionManager.getOptionManager("dofus").getOption("showFinishMoves"))
                        {
                            return (true);
                        };
                        cssb = new SpellScriptBuffer(tempCastingSpell);
                        fxScriptId = tempCastingSpell.spell.getScriptId(tempCastingSpell.isCriticalHit);
                        this.pushPlaySpellScriptStep(fxScriptId, gafscmsg.sourceId, gafscmsg.destinationCellId, gafscmsg.spellId, gafscmsg.spellLevel, cssb);
                        startIndex = 0;
                        stepsChanged = true;
                        playSpellScriptStepPosition = 0;
                        while (stepsChanged)
                        {
                            stepsChanged = false;
                            stepIndex = 0;
                            while (stepIndex < this._stepsBuffer.length)
                            {
                                if (this._stepsBuffer[stepIndex] == this._playSpellScriptStep)
                                {
                                    playSpellScriptStepPosition = stepIndex;
                                };
                                if (this._spellScriptTemporaryBuffer)
                                {
                                    stepSubIndex = startIndex;
                                    while (stepSubIndex < this._spellScriptTemporaryBuffer.stepsBuffer.length)
                                    {
                                        if (this._stepsBuffer[stepIndex] == this._spellScriptTemporaryBuffer.stepsBuffer[stepSubIndex])
                                        {
                                            stepsChanged = true;
                                            startIndex = stepSubIndex;
                                            this._stepsBuffer = this._stepsBuffer.slice(0, stepIndex).concat(this._stepsBuffer.slice((stepIndex + 1)));
                                            break;
                                        };
                                        stepSubIndex++;
                                    };
                                };
                                if (stepsChanged)
                                {
                                    break;
                                };
                                stepIndex++;
                            };
                        };
                        lookWithMount = EntitiesLooksManager.getInstance().getRealTiphonEntityLook(gafscmsg.sourceId);
                        sliced = this._stepsBuffer.slice((playSpellScriptStepPosition + 1));
                        this._stepsBuffer = this._stepsBuffer.slice(0, (playSpellScriptStepPosition + 1));
                        this.pushStep(new FightChangeLookStep(gafscmsg.sourceId, EntityLookAdapter.fromNetwork(EntityLookAdapter.toNetwork(TiphonUtility.getLookWithoutMount(lookWithMount)))));
                        this._stepsBuffer = this._stepsBuffer.concat(cssb.stepsBuffer).concat(sliced);
                        return (true);
                    };
                    if (this._castingSpell)
                    {
                        if (closeCombatWeaponId != 0)
                        {
                            this.pushStep(new FightCloseCombatStep(gafscmsg.sourceId, closeCombatWeaponId, gafscmsg.critical, gafscmsg.verboseCast));
                        }
                        else
                        {
                            this.pushStep(new FightSpellCastStep(gafscmsg.sourceId, gafscmsg.destinationCellId, sourceCellId, gafscmsg.spellId, gafscmsg.spellLevel, gafscmsg.critical, gafscmsg.verboseCast));
                        };
                        this._castingSpells.push(tempCastingSpell);
                        if ((msg is GameActionFightCloseCombatMessage))
                        {
                            this._castingSpell.weaponId = GameActionFightCloseCombatMessage(msg).weaponGenericId;
                            this.pushPlaySpellScriptStep(7, gafscmsg.sourceId, gafscmsg.destinationCellId, gafscmsg.spellId, gafscmsg.spellLevel);
                        }
                        else
                        {
                            if (!tempCastingSpell.isCriticalFail)
                            {
                                fxScriptId = tempCastingSpell.spell.getScriptId(tempCastingSpell.isCriticalHit);
                                this.pushPlaySpellScriptStep(fxScriptId, gafscmsg.sourceId, gafscmsg.destinationCellId, gafscmsg.spellId, gafscmsg.spellLevel);
                            };
                        };
                        return (true);
                    };
                    this._castingSpell = tempCastingSpell;
                    this._spellScriptTemporaryBuffer = new SpellScriptBuffer(this._castingSpell);
                    if ((msg is GameActionFightCloseCombatMessage))
                    {
                        this._castingSpell.weaponId = GameActionFightCloseCombatMessage(msg).weaponGenericId;
                        this._playSpellScriptStep = this.pushPlaySpellScriptStep(7, gafscmsg.sourceId, gafscmsg.destinationCellId, gafscmsg.spellId, gafscmsg.spellLevel, this._spellScriptTemporaryBuffer);
                    }
                    else
                    {
                        if (!this._castingSpell.isCriticalFail)
                        {
                            fxScriptId = this._castingSpell.spell.getScriptId(this._castingSpell.isCriticalHit);
                            this._playSpellScriptStep = this.pushPlaySpellScriptStep(fxScriptId, gafscmsg.sourceId, gafscmsg.destinationCellId, gafscmsg.spellId, gafscmsg.spellLevel, this._spellScriptTemporaryBuffer);
                        };
                    };
                    this._stepsBuffer = this._stepsBuffer.concat(this._spellScriptTemporaryBuffer.stepsBuffer);
                    if (((gafscmsg.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId) && (!(gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL))))
                    {
                        spellTargetEntities = [];
                        spellTargetEntities.push(gafscmsg.targetId);
                        CurrentPlayedFighterManager.getInstance().getSpellCastManager().castSpell(gafscmsg.spellId, gafscmsg.spellLevel, spellTargetEntities);
                    };
                    critical = (gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_HIT);
                    entities = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
                    fighter = entities[gafscmsg.sourceId];
                    if (closeCombatWeaponId != 0)
                    {
                        this.pushStep(new FightCloseCombatStep(gafscmsg.sourceId, closeCombatWeaponId, gafscmsg.critical, gafscmsg.verboseCast));
                    }
                    else
                    {
                        this.pushStep(new FightSpellCastStep(gafscmsg.sourceId, gafscmsg.destinationCellId, sourceCellId, gafscmsg.spellId, gafscmsg.spellLevel, gafscmsg.critical, gafscmsg.verboseCast));
                    };
                    if (gafscmsg.sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId)
                    {
                        KernelEventsManager.getInstance().processCallback(TriggerHookList.FightSpellCast);
                    };
                    playerManager = PlayedCharacterManager.getInstance();
                    isAlly = false;
                    if ((((entities[playerManager.id]) && (fighter)) && ((entities[playerManager.id] as GameFightFighterInformations).spawnInfo.teamId == fighter.spawnInfo.teamId)))
                    {
                        isAlly = true;
                    };
                    if ((((!(gafscmsg.sourceId == playerManager.id)) && (isAlly)) && (!(this._castingSpell.isCriticalFail))))
                    {
                        isSpellKnown = false;
                        for each (spellKnown in playerManager.spellsInventory)
                        {
                            if (spellKnown.id == gafscmsg.spellId)
                            {
                                isSpellKnown = true;
                                playerSpellLevel = spellKnown.spellLevelInfos;
                                break;
                            };
                        };
                        spell = Spell.getSpellById(gafscmsg.spellId);
                        castSpellLevel = spell.getSpellLevel(gafscmsg.spellLevel);
                        if (castSpellLevel.globalCooldown)
                        {
                            if (isSpellKnown)
                            {
                                if (castSpellLevel.globalCooldown == -1)
                                {
                                    gcdValue = playerSpellLevel.minCastInterval;
                                }
                                else
                                {
                                    gcdValue = castSpellLevel.globalCooldown;
                                };
                                this.pushStep(new FightSpellCooldownVariationStep(playerManager.id, 0, gafscmsg.spellId, gcdValue));
                            };
                            fe = fightEntitiesFrame_gfcc_gfsc_msg.getEntitiesDictionnary();
                            simf = (Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame);
                            for each (fighterInfos in fe)
                            {
                                if ((((fighterInfos is GameFightEntityInformation) && (!(gafscmsg.sourceId == fighterInfos.contextualId))) && ((fighterInfos as GameFightEntityInformation).masterId == playerManager.id)))
                                {
                                    gfsc = new GameFightSpellCooldown();
                                    gfsc.initGameFightSpellCooldown(gafscmsg.spellId, castSpellLevel.globalCooldown);
                                    simf.addSpellGlobalCoolDownInfo(fighterInfos.contextualId, gfsc);
                                };
                            };
                        };
                    };
                    playerId = PlayedCharacterManager.getInstance().id;
                    sourceInfos = (fightEntitiesFrame_gfcc_gfsc_msg.getEntityInfos(gafscmsg.sourceId) as GameFightFighterInformations);
                    playerInfos = (fightEntitiesFrame_gfcc_gfsc_msg.getEntityInfos(playerId) as GameFightFighterInformations);
                    if (critical)
                    {
                        if (gafscmsg.sourceId == playerId)
                        {
                            SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_OWNER);
                        }
                        else
                        {
                            if (((playerInfos) && (sourceInfos.spawnInfo.teamId == playerInfos.spawnInfo.teamId)))
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_ALLIED);
                            }
                            else
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_CC_ENEMY);
                            };
                        };
                    }
                    else
                    {
                        if (gafscmsg.critical == FightSpellCastCriticalEnum.CRITICAL_FAIL)
                        {
                            if (gafscmsg.sourceId == playerId)
                            {
                                SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_OWNER);
                            }
                            else
                            {
                                if (((playerInfos) && (sourceInfos.spawnInfo.teamId == playerInfos.spawnInfo.teamId)))
                                {
                                    SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_ALLIED);
                                }
                                else
                                {
                                    SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_EC_ENEMY);
                                };
                            };
                        };
                    };
                    target = (fightEntitiesFrame_gfcc_gfsc_msg.getEntityInfos(gafscmsg.targetId) as GameFightFighterInformations);
                    if (((target) && (target.disposition.cellId == -1)))
                    {
                        for each (ei in this._castingSpell.spellRank.effects)
                        {
                            if (ei.hasOwnProperty("zoneShape"))
                            {
                                shape = ei.zoneShape;
                                break;
                            };
                        };
                        if (shape == SpellShapeEnum.P)
                        {
                            ts = (DofusEntities.getEntity(gafscmsg.targetId) as TiphonSprite);
                            if ((((ts) && (this._castingSpell)) && (this._castingSpell.targetedCell)))
                            {
                                targetedCell = InteractiveCellManager.getInstance().getCell(this._castingSpell.targetedCell.cellId);
                                cellPos = targetedCell.parent.localToGlobal(new Point((targetedCell.x + (targetedCell.width / 2)), (targetedCell.y + (targetedCell.height / 2))));
                                ts.x = cellPos.x;
                                ts.y = cellPos.y;
                            };
                        };
                    };
                    this._castingSpells.push(this._castingSpell);
                    return (true);
                case (msg is GameMapMovementMessage):
                    gmmmsg = (msg as GameMapMovementMessage);
                    this.keepInMindToUpdateMovementArea();
                    this.fighterHasMoved(gmmmsg);
                    return (true);
                case (msg is FighterStatsListMessage):
                    fslmsg = (msg as FighterStatsListMessage);
                    this.pushStep(new FightFighterStatsListStep(fslmsg.stats));
                    return (true);
                case (msg is GameActionFightPointsVariationMessage):
                    gafpvmsg = (msg as GameActionFightPointsVariationMessage);
                    this.pushPointsVariationStep(gafpvmsg.targetId, gafpvmsg.actionId, gafpvmsg.delta);
                    return (true);
                case (msg is GameActionFightLifeAndShieldPointsLostMessage):
                    gaflasplmsg = (msg as GameActionFightLifeAndShieldPointsLostMessage);
                    this.pushStep(new FightShieldPointsVariationStep(gaflasplmsg.targetId, -(gaflasplmsg.shieldLoss), gaflasplmsg.elementId));
                    this.pushStep(new FightLifeVariationStep(gaflasplmsg.targetId, -(gaflasplmsg.loss), -(gaflasplmsg.permanentDamages), gaflasplmsg.elementId));
                    return (true);
                case (msg is GameActionFightLifePointsGainMessage):
                    gaflpgmsg = (msg as GameActionFightLifePointsGainMessage);
                    this.pushStep(new FightLifeVariationStep(gaflpgmsg.targetId, gaflpgmsg.delta, 0, ElementEnum.ELEMENT_NONE));
                    return (true);
                case (msg is GameActionFightLifePointsLostMessage):
                    gaflplmsg = (msg as GameActionFightLifePointsLostMessage);
                    this.pushStep(new FightLifeVariationStep(gaflplmsg.targetId, -(gaflplmsg.loss), -(gaflplmsg.permanentDamages), gaflplmsg.elementId));
                    return (true);
                case (msg is GameActionFightTeleportOnSameMapMessage):
                    gaftosmmsg = (msg as GameActionFightTeleportOnSameMapMessage);
                    this.keepInMindToUpdateMovementArea();
                    this.fighterHasBeenTeleported(gaftosmmsg);
                    return (true);
                case (msg is GameActionFightExchangePositionsMessage):
                    gafepmsg = (msg as GameActionFightExchangePositionsMessage);
                    this.keepInMindToUpdateMovementArea();
                    this.fightersExchangedPositions(gafepmsg);
                    return (true);
                case (msg is GameActionFightSlideMessage):
                    gafsmsg = (msg as GameActionFightSlideMessage);
                    this.keepInMindToUpdateMovementArea();
                    fightContextFrame_gafsmsg = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    slideTargetInfos = fightContextFrame_gafsmsg.entitiesFrame.getEntityInfos(gafsmsg.targetId);
                    if (slideTargetInfos)
                    {
                        fightContextFrame_gafsmsg.saveFighterPosition(gafsmsg.targetId, gafsmsg.endCellId);
                        this.pushSlideStep(gafsmsg.targetId, gafsmsg.startCellId, gafsmsg.endCellId);
                    };
                    return (true);
                case (msg is GameActionFightSummonMessage):
                    gafsnmsg = (msg as GameActionFightSummonMessage);
                    this.keepInMindToUpdateMovementArea();
                    this.fighterSummonEntity(gafsnmsg);
                    return (true);
                case (msg is GameActionFightMultipleSummonMessage):
                    gafmsmsg = (msg as GameActionFightMultipleSummonMessage);
                    this.keepInMindToUpdateMovementArea();
                    gffinfos = new GameFightFighterInformations();
                    gffinfos = this.fighterSummonMultipleEntities(gafmsmsg, gffinfos);
                    return (true);
                case (msg is GameActionFightMarkCellsMessage):
                    gafmcmsg = (msg as GameActionFightMarkCellsMessage);
                    this.cellsHasBeenMarked(gafmcmsg);
                    return (true);
                case (msg is GameActionFightUnmarkCellsMessage):
                    gafucmsg = (msg as GameActionFightUnmarkCellsMessage);
                    this.pushStep(new FightUnmarkCellsStep(gafucmsg.markId));
                    return (true);
                case (msg is GameActionFightChangeLookMessage):
                    gafclmsg = (msg as GameActionFightChangeLookMessage);
                    this.pushStep(new FightChangeLookStep(gafclmsg.targetId, EntityLookAdapter.fromNetwork(gafclmsg.entityLook)));
                    return (true);
                case (msg is GameActionFightInvisibilityMessage):
                    gafimsg = (msg as GameActionFightInvisibilityMessage);
                    this.keepInMindToUpdateMovementArea();
                    fightEntitiesFrame = FightEntitiesFrame.getCurrentInstance();
                    inviInfo = fightEntitiesFrame.getEntityInfos(gafimsg.targetId);
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug((((((("[BUFFS DEBUG] Changement de l'invisibilité de " + gafimsg.targetId) + " (cellule ") + inviInfo.disposition.cellId) + ")") + " nouvel état ") + gafimsg.state));
                    };
                    fightEntitiesFrame.setLastKnownEntityPosition(gafimsg.targetId, inviInfo.disposition.cellId);
                    fightEntitiesFrame.setLastKnownEntityMovementPoint(gafimsg.targetId, 0, true);
                    this.pushStep(new FightChangeVisibilityStep(gafimsg.targetId, gafimsg.state));
                    return (true);
                case (msg is GameActionFightLeaveMessage):
                    gaflmsg = (msg as GameActionFightLeaveMessage);
                    this.keepInMindToUpdateMovementArea();
                    this.fighterHasLeftBattle(gaflmsg);
                    return (true);
                case (msg is GameActionFightDeathMessage):
                    gafdmsg = (msg as GameActionFightDeathMessage);
                    this.keepInMindToUpdateMovementArea();
                    this.fighterHasBeenKilled(gafdmsg);
                    return (true);
                case (msg is GameActionFightVanishMessage):
                    gafvmsg = (msg as GameActionFightVanishMessage);
                    this.keepInMindToUpdateMovementArea();
                    this.pushStep(new FightVanishStep(gafvmsg.targetId, gafvmsg.sourceId));
                    entityInfosv = FightEntitiesFrame.getCurrentInstance().getEntityInfos(gafvmsg.targetId);
                    if ((entityInfosv is GameFightFighterInformations))
                    {
                        (entityInfosv as GameFightFighterInformations).spawnInfo.alive = false;
                    };
                    fightContextFrame_gafvmsg = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    if (fightContextFrame_gafvmsg)
                    {
                        fightContextFrame_gafvmsg.outEntity(gafvmsg.targetId);
                    };
                    FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(gafvmsg.targetId);
                    return (true);
                case (msg is GameActionFightTriggerEffectMessage):
                    return (true);
                case (msg is GameActionFightDispellEffectMessage):
                    gafdiemsg = (msg as GameActionFightDispellEffectMessage);
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug(((("[BUFFS DEBUG] Message de retrait du buff " + gafdiemsg.boostUID) + " de ") + gafdiemsg.targetId));
                    };
                    this.pushStep(new FightDispellEffectStep(gafdiemsg.targetId, gafdiemsg.boostUID));
                    return (true);
                case (msg is GameActionFightDispellSpellMessage):
                    gafdsmsg = (msg as GameActionFightDispellSpellMessage);
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug(((("[BUFFS DEBUG] Message de retrait des buffs du sort " + gafdsmsg.spellId) + " de ") + gafdsmsg.targetId));
                    };
                    this.pushStep(new FightDispellSpellStep(gafdsmsg.targetId, gafdsmsg.spellId, gafdsmsg.verboseCast));
                    return (true);
                case (msg is GameActionFightDispellMessage):
                    gafdimsg = (msg as GameActionFightDispellMessage);
                    if (GameDebugManager.getInstance().buffsDebugActivated)
                    {
                        _log.debug(("[BUFFS DEBUG] Message de retrait de tous les buffs de " + gafdimsg.targetId));
                    };
                    this.pushStep(new FightDispellStep(gafdimsg.targetId));
                    return (true);
                case (msg is GameActionFightDodgePointLossMessage):
                    gafdplmsg = (msg as GameActionFightDodgePointLossMessage);
                    this.pushPointsLossDodgeStep(gafdplmsg.targetId, gafdplmsg.actionId, gafdplmsg.amount);
                    return (true);
                case (msg is GameActionFightSpellCooldownVariationMessage):
                    gafscvmsg = (msg as GameActionFightSpellCooldownVariationMessage);
                    this.pushStep(new FightSpellCooldownVariationStep(gafscvmsg.targetId, gafscvmsg.actionId, gafscvmsg.spellId, gafscvmsg.value));
                    return (true);
                case (msg is GameActionFightSpellImmunityMessage):
                    gafsimsg = (msg as GameActionFightSpellImmunityMessage);
                    this.pushStep(new FightSpellImmunityStep(gafsimsg.targetId));
                    return (true);
                case (msg is GameActionFightKillMessage):
                    gafkmsg = (msg as GameActionFightKillMessage);
                    this.pushStep(new FightKillStep(gafkmsg.targetId, gafkmsg.sourceId));
                    return (true);
                case (msg is GameActionFightReduceDamagesMessage):
                    gafredmsg = (msg as GameActionFightReduceDamagesMessage);
                    this.pushStep(new FightReducedDamagesStep(gafredmsg.targetId, gafredmsg.amount));
                    return (true);
                case (msg is GameActionFightReflectDamagesMessage):
                    gafrfdmsg = (msg as GameActionFightReflectDamagesMessage);
                    this.pushStep(new FightReflectedDamagesStep(gafrfdmsg.sourceId));
                    return (true);
                case (msg is GameActionFightReflectSpellMessage):
                    gafrsmsg = (msg as GameActionFightReflectSpellMessage);
                    this.pushStep(new FightReflectedSpellStep(gafrsmsg.targetId));
                    return (true);
                case (msg is GameActionFightStealKamaMessage):
                    gafskmsg = (msg as GameActionFightStealKamaMessage);
                    this.pushStep(new FightStealingKamasStep(gafskmsg.sourceId, gafskmsg.targetId, gafskmsg.amount));
                    return (true);
                case (msg is GameActionFightTackledMessage):
                    gaftmsg = (msg as GameActionFightTackledMessage);
                    if (gaftmsg.sourceId == PlayedCharacterManager.getInstance().id)
                    {
                        SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_PLAYER_TACKLED);
                    };
                    this.pushStep(new FightTackledStep(gaftmsg.sourceId));
                    return (true);
                case (msg is GameActionFightTriggerGlyphTrapMessage):
                    if (this._castingSpell)
                    {
                        this._fightBattleFrame.process(new SequenceEndMessage());
                        this._fightBattleFrame.process(new SequenceStartMessage());
                        this._fightBattleFrame.currentSequenceFrame.process(msg);
                        return (true);
                    };
                    gaftgtmsg = (msg as GameActionFightTriggerGlyphTrapMessage);
                    this.fighterHasTriggeredGlyphOrTrap(gaftgtmsg);
                    return (true);
                case (msg is GameActionFightActivateGlyphTrapMessage):
                    gafagtmsg = (msg as GameActionFightActivateGlyphTrapMessage);
                    this.pushStep(new FightMarkActivateStep(gafagtmsg.markId, gafagtmsg.active));
                    return (true);
                case (msg is GameActionFightDispellableEffectMessage):
                    gaftbmsg = (msg as GameActionFightDispellableEffectMessage);
                    this.keepInMindToUpdateMovementArea();
                    this.fighterHasBeenBuffed(gaftbmsg);
                    return (true);
                case (msg is GameActionFightModifyEffectsDurationMessage):
                    gafmedmsg = (msg as GameActionFightModifyEffectsDurationMessage);
                    this.pushStep(new FightModifyEffectsDurationStep(gafmedmsg.sourceId, gafmedmsg.targetId, gafmedmsg.delta));
                    return (false);
                case (msg is GameActionFightCarryCharacterMessage):
                    gafcchmsg = (msg as GameActionFightCarryCharacterMessage);
                    this.keepInMindToUpdateMovementArea();
                    if (gafcchmsg.cellId != -1)
                    {
                        fightContextFrame_gafcchmsg = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                        fightContextFrame_gafcchmsg.saveFighterPosition(gafcchmsg.targetId, gafcchmsg.cellId);
                        this.pushStep(new FightCarryCharacterStep(gafcchmsg.sourceId, gafcchmsg.targetId, gafcchmsg.cellId));
                        this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip, gafcchmsg.targetId)));
                    };
                    return (false);
                case (msg is GameActionFightThrowCharacterMessage):
                    gaftcmsg = (msg as GameActionFightThrowCharacterMessage);
                    this.keepInMindToUpdateMovementArea();
                    throwCellId = (((this._castingSpell) && (this._castingSpell.targetedCell)) ? this._castingSpell.targetedCell.cellId : gaftcmsg.cellId);
                    fightContextFrame_gaftcmsg = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    fightContextFrame_gaftcmsg.saveFighterPosition(gaftcmsg.targetId, throwCellId);
                    this.pushThrowCharacterStep(gaftcmsg.sourceId, gaftcmsg.targetId, throwCellId);
                    return (false);
                case (msg is GameActionFightDropCharacterMessage):
                    gafdcmsg = (msg as GameActionFightDropCharacterMessage);
                    this.keepInMindToUpdateMovementArea();
                    dropCellId = gafdcmsg.cellId;
                    if (((dropCellId == -1) && (this._castingSpell)))
                    {
                        dropCellId = this._castingSpell.targetedCell.cellId;
                    };
                    this.pushThrowCharacterStep(gafdcmsg.sourceId, gafdcmsg.targetId, dropCellId);
                    return (false);
                case (msg is GameActionFightInvisibleDetectedMessage):
                    gafidMsg = (msg as GameActionFightInvisibleDetectedMessage);
                    this.pushStep(new FightInvisibleTemporarilyDetectedStep((DofusEntities.getEntity(gafidMsg.sourceId) as AnimatedCharacter), gafidMsg.cellId));
                    FightEntitiesFrame.getCurrentInstance().setLastKnownEntityPosition(gafidMsg.targetId, gafidMsg.cellId);
                    FightEntitiesFrame.getCurrentInstance().setLastKnownEntityMovementPoint(gafidMsg.targetId, 0);
                    return (true);
                case (msg is GameFightTurnListMessage):
                    gftmsg = (msg as GameFightTurnListMessage);
                    this.pushStep(new FightTurnListStep(gftmsg.ids, gftmsg.deadsIds));
                    return (true);
                case (msg is GameFightSynchronizeMessage):
                    this.keepInMindToUpdateMovementArea();
                    return (false);
                case (msg is AbstractGameActionMessage):
                    _log.error((("Unsupported game action " + msg) + " ! This action was discarded."));
                    return (true);
            };
            return (false);
        }

        public function execute(callback:Function=null):void
        {
            this._sequencer = new SerialSequencer(FIGHT_SEQUENCERS_CATEGORY);
            this._sequencer.addEventListener(SequencerEvent.SEQUENCE_STEP_FINISH, this.onStepEnd);
            if (this._parent)
            {
                _log.info("Process sub sequence");
                this._parent.addSubSequence(this._sequencer);
            }
            else
            {
                _log.info("Execute sequence");
            };
            this.executeBuffer(callback);
        }

        private function fighterHasBeenKilled(gafdmsg:GameActionFightDeathMessage):void
        {
            var actorInfo:GameFightFighterInformations;
            var gcai:GameContextActorInformations;
            var playerId:Number;
            var sourceInfos:GameFightFighterInformations;
            var targetInfos:GameFightFighterInformations;
            var playerInfos:GameFightFighterInformations;
            var summonDestroyedWithSummoner:Boolean;
            var summonerIsMe:Boolean;
            var step:ISequencable;
            var summonerInfos:GameFightFighterInformations;
            var summonedEntityInfos:GameFightMonsterInformations;
            var monster:Monster;
            var fighterInfos:GameFightFighterInformations;
            var entitiesDictionnary:Dictionary = FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary();
            for each (gcai in entitiesDictionnary)
            {
                if ((gcai is GameFightFighterInformations))
                {
                    actorInfo = (gcai as GameFightFighterInformations);
                    if (((actorInfo.spawnInfo.alive) && (actorInfo.stats.summoner == gafdmsg.targetId)))
                    {
                        this.pushStep(new FightDeathStep(gcai.contextualId));
                    };
                };
            };
            playerId = PlayedCharacterManager.getInstance().id;
            sourceInfos = (this.fightEntitiesFrame.getEntityInfos(gafdmsg.sourceId) as GameFightFighterInformations);
            targetInfos = (this.fightEntitiesFrame.getEntityInfos(gafdmsg.targetId) as GameFightFighterInformations);
            playerInfos = (this.fightEntitiesFrame.getEntityInfos(playerId) as GameFightFighterInformations);
            summonDestroyedWithSummoner = false;
            summonerIsMe = true;
            if ((((targetInfos.stats.summoned) && (!(targetInfos is GameFightFighterNamedInformations))) && (!(targetInfos is GameFightEntityInformation))))
            {
                summonerInfos = (this.fightEntitiesFrame.getEntityInfos(targetInfos.stats.summoner) as GameFightFighterInformations);
                summonDestroyedWithSummoner = ((summonerInfos == null) || (!(summonerInfos.spawnInfo.alive)));
                summonerIsMe = ((!(summonerInfos == null)) && (summonerInfos == playerInfos));
            };
            if (((!(summonDestroyedWithSummoner)) && (summonerIsMe)))
            {
                this.fightEntitiesFrame.addLastKilledAlly(targetInfos);
            };
            if (((!(gafdmsg.targetId == this._fightBattleFrame.currentPlayerId)) && ((this._fightBattleFrame.slaveId == gafdmsg.targetId) || (this._fightBattleFrame.masterId == gafdmsg.targetId))))
            {
                this._fightBattleFrame.prepareNextPlayableCharacter(gafdmsg.targetId);
            };
            var speakingItemManager:SpeakingItemManager = SpeakingItemManager.getInstance();
            if (gafdmsg.targetId == playerId)
            {
                if (gafdmsg.sourceId == gafdmsg.targetId)
                {
                    speakingItemManager.triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_HIMSELF);
                }
                else
                {
                    if (sourceInfos.spawnInfo.teamId != playerInfos.spawnInfo.teamId)
                    {
                        speakingItemManager.triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_BY_ENEMY);
                    }
                    else
                    {
                        speakingItemManager.triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILLED_BY_ENEMY);
                    };
                };
            }
            else
            {
                if (gafdmsg.sourceId == playerId)
                {
                    if (targetInfos)
                    {
                        if (targetInfos.spawnInfo.teamId != playerInfos.spawnInfo.teamId)
                        {
                            speakingItemManager.triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ENEMY);
                        }
                        else
                        {
                            speakingItemManager.triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_KILL_ALLY);
                        };
                    };
                };
            };
            var entityDeathStepAlreadyInBuffer:Boolean;
            for each (step in this._stepsBuffer)
            {
                if (((step is FightDeathStep) && ((step as FightDeathStep).entityId == gafdmsg.targetId)))
                {
                    entityDeathStepAlreadyInBuffer = true;
                };
            };
            if (!entityDeathStepAlreadyInBuffer)
            {
                this.pushStep(new FightDeathStep(gafdmsg.targetId));
            };
            var entityInfos:GameContextActorInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(gafdmsg.targetId);
            var ftf:FightTurnFrame = (Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame);
            var updatePath:Boolean = ((((ftf) && (ftf.myTurn)) && (!(gafdmsg.targetId == playerId))) && (TackleUtil.isTackling(playerInfos, targetInfos, ftf.lastPath)));
            var currentPlayedFighterManager:CurrentPlayedFighterManager = CurrentPlayedFighterManager.getInstance();
            if ((entityInfos is GameFightMonsterInformations))
            {
                summonedEntityInfos = (entityInfos as GameFightMonsterInformations);
                summonedEntityInfos.spawnInfo.alive = false;
                if (currentPlayedFighterManager.checkPlayableEntity(summonedEntityInfos.stats.summoner))
                {
                    monster = Monster.getMonsterById(summonedEntityInfos.creatureGenericId);
                    if (monster.useSummonSlot)
                    {
                        currentPlayedFighterManager.removeSummonedCreature(summonedEntityInfos.stats.summoner);
                    };
                    if (monster.useBombSlot)
                    {
                        currentPlayedFighterManager.removeSummonedBomb(summonedEntityInfos.stats.summoner);
                    };
                    SpellWrapper.refreshAllPlayerSpellHolder(summonedEntityInfos.stats.summoner);
                };
            }
            else
            {
                if ((entityInfos is GameFightFighterInformations))
                {
                    fighterInfos = (entityInfos as GameFightFighterInformations);
                    fighterInfos.spawnInfo.alive = false;
                    if (fighterInfos.stats.summoner != 0)
                    {
                        if (currentPlayedFighterManager.checkPlayableEntity(fighterInfos.stats.summoner))
                        {
                            currentPlayedFighterManager.removeSummonedCreature(fighterInfos.stats.summoner);
                            SpellWrapper.refreshAllPlayerSpellHolder(fighterInfos.stats.summoner);
                        };
                    };
                };
            };
            var fightContextFrame:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            if (fightContextFrame)
            {
                fightContextFrame.outEntity(gafdmsg.targetId);
            };
            FightEntitiesFrame.getCurrentInstance().updateRemovedEntity(gafdmsg.targetId);
            if (updatePath)
            {
                ftf.updatePath();
            };
        }

        private function fighterHasLeftBattle(gaflmsg:GameActionFightLeaveMessage):void
        {
            var gcaiL:GameContextActorInformations;
            var entityInfosL:GameContextActorInformations;
            var summonerIdL:Number;
            var summonedEntityInfosL:GameFightMonsterInformations;
            var currentPlayedFighterManager:CurrentPlayedFighterManager;
            var monster:Monster;
            var fightEntityFrame_gaflmsg:FightEntitiesFrame = FightEntitiesFrame.getCurrentInstance();
            var entitiesL:Dictionary = fightEntityFrame_gaflmsg.getEntitiesDictionnary();
            for each (gcaiL in entitiesL)
            {
                if ((gcaiL is GameFightFighterInformations))
                {
                    summonerIdL = (gcaiL as GameFightFighterInformations).stats.summoner;
                    if (summonerIdL == gaflmsg.targetId)
                    {
                        this.pushStep(new FightDeathStep(gcaiL.contextualId));
                    };
                };
            };
            this.pushStep(new FightDeathStep(gaflmsg.targetId, false));
            entityInfosL = fightEntityFrame_gaflmsg.getEntityInfos(gaflmsg.targetId);
            if ((entityInfosL is GameFightMonsterInformations))
            {
                summonedEntityInfosL = (entityInfosL as GameFightMonsterInformations);
                currentPlayedFighterManager = CurrentPlayedFighterManager.getInstance();
                if (currentPlayedFighterManager.checkPlayableEntity(summonedEntityInfosL.stats.summoner))
                {
                    monster = Monster.getMonsterById(summonedEntityInfosL.creatureGenericId);
                    if (monster.useSummonSlot)
                    {
                        currentPlayedFighterManager.removeSummonedCreature(summonedEntityInfosL.stats.summoner);
                    };
                    if (monster.useBombSlot)
                    {
                        currentPlayedFighterManager.removeSummonedBomb(summonedEntityInfosL.stats.summoner);
                    };
                };
            };
            if (((entityInfosL) && (entityInfosL is GameFightFighterInformations)))
            {
                fightEntityFrame_gaflmsg.removeSpecificKilledAlly((entityInfosL as GameFightFighterInformations));
            };
        }

        private function cellsHasBeenMarked(gafmcmsg:GameActionFightMarkCellsMessage):void
        {
            var spellGrade:uint;
            var tmpSpell:Spell;
            var spellLevel:SpellLevel;
            var effect:EffectInstanceDice;
            var spellId:uint = gafmcmsg.mark.markSpellId;
            if ((((this._castingSpell) && (this._castingSpell.spell)) && (!(this._castingSpell.spell.id == 1750))))
            {
                this._castingSpell.markId = gafmcmsg.mark.markId;
                this._castingSpell.markType = gafmcmsg.mark.markType;
                this._castingSpell.casterId = gafmcmsg.sourceId;
                spellGrade = gafmcmsg.mark.markSpellLevel;
            }
            else
            {
                tmpSpell = Spell.getSpellById(spellId);
                spellLevel = tmpSpell.getSpellLevel(gafmcmsg.mark.markSpellLevel);
                for each (effect in spellLevel.effects)
                {
                    if ((((effect.effectId == ActionIds.ACTION_FIGHT_ADD_TRAP_CASTING_SPELL) || (effect.effectId == ActionIds.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL)) || (effect.effectId == ActionIds.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL_ENDTURN)))
                    {
                        spellId = (effect.parameter0 as uint);
                        spellGrade = Spell.getSpellById(spellId).getSpellLevel((effect.parameter1 as uint)).grade;
                        break;
                    };
                };
            };
            this.pushStep(new FightMarkCellsStep(gafmcmsg.mark.markId, gafmcmsg.mark.markType, gafmcmsg.mark.cells, spellId, spellGrade, gafmcmsg.mark.markTeamId, gafmcmsg.mark.markimpactCell, gafmcmsg.sourceId));
        }

        private function fighterSummonMultipleEntities(gafmsmsg:GameActionFightMultipleSummonMessage, gffinfos:GameFightFighterInformations):GameFightFighterInformations
        {
            var summons:GameContextSummonsInformation;
            var sum:GameContextBasicSpawnInformation;
            var gffninfos:GameFightFighterNamedInformations;
            var gfeinfos:GameFightEntityInformation;
            var gfminfos:GameFightMonsterInformations;
            var gfsminfos:GameFightMonsterInformations;
            for each (summons in gafmsmsg.summons)
            {
                for each (sum in summons.summons)
                {
                    switch (true)
                    {
                        case (summons.spawnInformation is SpawnCharacterInformation):
                            gffninfos = new GameFightFighterNamedInformations();
                            gffninfos.initGameFightFighterNamedInformations(sum.informations.contextualId, sum.informations.disposition, summons.look, sum, summons.wave, summons.stats, null, (summons.spawnInformation as SpawnCharacterInformation).name);
                            gffinfos = gffninfos;
                            break;
                        case (summons.spawnInformation is SpawnCompanionInformation):
                            gfeinfos = new GameFightEntityInformation();
                            gfeinfos.initGameFightEntityInformation(sum.informations.contextualId, sum.informations.disposition, summons.look, sum, summons.wave, summons.stats, null, (summons.spawnInformation as SpawnCompanionInformation).modelId, (summons.spawnInformation as SpawnCompanionInformation).level, (summons.spawnInformation as SpawnCompanionInformation).ownerId);
                            gffinfos = gfeinfos;
                            break;
                        case (summons.spawnInformation is SpawnMonsterInformation):
                            gfminfos = new GameFightMonsterInformations();
                            gfminfos.initGameFightMonsterInformations(sum.informations.contextualId, sum.informations.disposition, summons.look, sum, summons.wave, summons.stats, null, (summons.spawnInformation as SpawnMonsterInformation).creatureGenericId, (summons.spawnInformation as SpawnMonsterInformation).creatureGrade);
                            gffinfos = gfminfos;
                            break;
                        case (summons.spawnInformation is SpawnScaledMonsterInformation):
                            gfsminfos = new GameFightMonsterInformations();
                            gfsminfos.initGameFightMonsterInformations(sum.informations.contextualId, sum.informations.disposition, summons.look, sum, summons.wave, summons.stats, null, (summons.spawnInformation as SpawnScaledMonsterInformation).creatureGenericId, 0, (summons.spawnInformation as SpawnScaledMonsterInformation).creatureLevel);
                            gffinfos = gfsminfos;
                            break;
                        default:
                            gffinfos = new GameFightFighterInformations();
                            gffinfos.initGameFightFighterInformations(sum.informations.contextualId, sum.informations.disposition, summons.look, sum, summons.wave, summons.stats);
                    };
                    this.summonEntity(gffinfos, gafmsmsg.sourceId, gafmsmsg.actionId);
                };
            };
            return (gffinfos);
        }

        private function fighterSummonEntity(gafsnmsg:GameActionFightSummonMessage):void
        {
            var summon:GameFightFighterInformations;
            var fightEntities:Dictionary;
            var fighterId:*;
            var gfsfrsmsg:GameFightShowFighterRandomStaticPoseMessage;
            var illusionCreature:Sprite;
            var infos:GameFightFighterInformations;
            for each (summon in gafsnmsg.summons)
            {
                if (((gafsnmsg.actionId == ActionIds.ACTION_CHARACTER_ADD_ILLUSION_RANDOM) || (gafsnmsg.actionId == ActionIds.ACTION_CHARACTER_ADD_ILLUSION_MIRROR)))
                {
                    fightEntities = this.fightEntitiesFrame.getEntitiesDictionnary();
                    for (fighterId in fightEntities)
                    {
                        infos = (this.fightEntitiesFrame.getEntityInfos(fighterId) as GameFightFighterInformations);
                        if (((((!(this.fightEntitiesFrame.entityIsIllusion(fighterId))) && (infos.hasOwnProperty("name"))) && (summon.hasOwnProperty("name"))) && (infos["name"] == summon["name"])))
                        {
                            summon.stats.summoner = infos.contextualId;
                            break;
                        };
                    };
                    gfsfrsmsg = new GameFightShowFighterRandomStaticPoseMessage();
                    gfsfrsmsg.initGameFightShowFighterRandomStaticPoseMessage(summon);
                    Kernel.getWorker().getFrame(FightEntitiesFrame).process(gfsfrsmsg);
                    illusionCreature = (DofusEntities.getEntity(summon.contextualId) as Sprite);
                    if (illusionCreature)
                    {
                        illusionCreature.visible = false;
                    };
                    this.pushStep(new FightVisibilityStep(summon.contextualId, true));
                }
                else
                {
                    this.summonEntity(summon, gafsnmsg.sourceId, gafsnmsg.actionId);
                };
            };
        }

        private function fightersExchangedPositions(gafepmsg:GameActionFightExchangePositionsMessage):void
        {
            var fightContextFrame:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            if (!this.isSpellTeleportingToPreviousPosition())
            {
                fightContextFrame.saveFighterPosition(gafepmsg.sourceId, gafepmsg.targetCellId);
            }
            else
            {
                fightContextFrame.deleteFighterPreviousPosition(gafepmsg.sourceId);
            };
            fightContextFrame.saveFighterPosition(gafepmsg.targetId, gafepmsg.targetCellId);
            this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip, gafepmsg.targetId)));
            this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip, gafepmsg.targetCellId)));
            this.pushStep(new FightExchangePositionsStep(gafepmsg.sourceId, gafepmsg.casterCellId, gafepmsg.targetId, gafepmsg.targetCellId));
        }

        private function fighterHasBeenTeleported(gaftosmmsg:GameActionFightTeleportOnSameMapMessage):void
        {
            var fightContextFrame:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            if (!this.isSpellTeleportingToPreviousPosition())
            {
                if (!this._teleportThroughPortal)
                {
                    fightContextFrame.saveFighterPosition(gaftosmmsg.targetId, gaftosmmsg.cellId);
                }
                else
                {
                    fightContextFrame.saveFighterPosition(gaftosmmsg.targetId, gaftosmmsg.cellId);
                };
            }
            else
            {
                if (fightContextFrame.getFighterPreviousPosition(gaftosmmsg.targetId) == gaftosmmsg.cellId)
                {
                    fightContextFrame.deleteFighterPreviousPosition(gaftosmmsg.targetId);
                };
            };
            this.pushTeleportStep(gaftosmmsg.targetId, gaftosmmsg.cellId);
            this._teleportThroughPortal = false;
        }

        private function fighterHasMoved(gmmmsg:GameMapMovementMessage):void
        {
            var i:int;
            var carriedEntity:AnimatedCharacter;
            if (gmmmsg.actorId == CurrentPlayedFighterManager.getInstance().currentFighterId)
            {
                KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerFightMove);
            };
            var movementPath:MovementPath = MapMovementAdapter.getClientMovement(gmmmsg.keyMovements);
            var movementPathCells:Vector.<uint> = movementPath.getCells();
            var fightContextFrame:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            var nbCells:int = movementPathCells.length;
            var movingEntity:TiphonSprite = (DofusEntities.getEntity(gmmmsg.actorId) as TiphonSprite);
            i = 1;
            while (i < nbCells)
            {
                fightContextFrame.saveFighterPosition(gmmmsg.actorId, movementPathCells[i]);
                carriedEntity = (movingEntity.carriedEntity as AnimatedCharacter);
                while (carriedEntity)
                {
                    fightContextFrame.saveFighterPosition(carriedEntity.id, movementPathCells[i]);
                    carriedEntity = (carriedEntity.carriedEntity as AnimatedCharacter);
                };
                i++;
            };
            var fscf:FightSpellCastFrame = (Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame);
            if (fscf)
            {
                fscf.entityMovement(gmmmsg.actorId);
            };
            this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip, gmmmsg.actorId)));
            this.pushStep(new FightEntityMovementStep(gmmmsg.actorId, movementPath));
        }

        private function fighterHasTriggeredGlyphOrTrap(gaftgtmsg:GameActionFightTriggerGlyphTrapMessage):void
        {
            var triggeredSpellId:int;
            var eid:EffectInstanceDice;
            this.pushStep(new FightMarkTriggeredStep(gaftgtmsg.triggeringCharacterId, gaftgtmsg.sourceId, gaftgtmsg.markId));
            this._castingSpell = new CastingSpell();
            this._castingSpell.casterId = gaftgtmsg.sourceId;
            var triggeringCharacterInfos:GameFightFighterInformations = (FightEntitiesFrame.getCurrentInstance().getEntityInfos(gaftgtmsg.triggeringCharacterId) as GameFightFighterInformations);
            var triggeredCellId:int = ((triggeringCharacterInfos) ? triggeringCharacterInfos.disposition.cellId : -1);
            var mark:MarkInstance = MarkedCellsManager.getInstance().getMarkDatas(gaftgtmsg.markId);
            if (triggeredCellId != -1)
            {
                if (mark)
                {
                    for each (eid in mark.associatedSpellLevel.effects)
                    {
                        if ((((mark.markType == GameActionMarkTypeEnum.GLYPH) && (eid.effectId == ActionIds.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL)) || ((mark.markType == GameActionMarkTypeEnum.TRAP) && (eid.effectId == ActionIds.ACTION_FIGHT_ADD_TRAP_CASTING_SPELL))))
                        {
                            triggeredSpellId = (eid.parameter0 as int);
                            break;
                        };
                    };
                    if (triggeredSpellId)
                    {
                        this._castingSpell.spell = Spell.getSpellById(triggeredSpellId);
                        this._castingSpell.spellRank = this._castingSpell.spell.getSpellLevel(mark.associatedSpellLevel.grade);
                        this._castingSpell.targetedCell = MapPoint.fromCellId(gaftgtmsg.markImpactCell);
                        if (mark.markType == GameActionMarkTypeEnum.GLYPH)
                        {
                            this._castingSpell.defaultTargetGfxId = 1016;
                        }
                        else
                        {
                            if (mark.markType == GameActionMarkTypeEnum.TRAP)
                            {
                                this._castingSpell.defaultTargetGfxId = 1017;
                            };
                        };
                        this.pushPlaySpellScriptStep(1, gaftgtmsg.sourceId, triggeredCellId, this._castingSpell.spell.id, this._castingSpell.spellRank.grade);
                    };
                };
            };
            if (((mark) && (mark.markType == GameActionMarkTypeEnum.PORTAL)))
            {
                this._teleportThroughPortal = true;
                this._teleportPortalId = mark.markId;
            };
        }

        private function fighterHasBeenBuffed(gaftbmsg:GameActionFightDispellableEffectMessage):void
        {
            var myCastingSpell:CastingSpell;
            var castedSpell:CastingSpell;
            var e:Effect;
            var description:String;
            var sb:StateBuff;
            var step:AbstractSequencable;
            var actionId:int;
            if (GameDebugManager.getInstance().buffsDebugActivated)
            {
                e = Effect.getEffectById(gaftbmsg.actionId);
                description = "";
                if (e != null)
                {
                    description = e.description;
                };
                _log.debug((((((((((((((((((("\r[BUFFS DEBUG] Message de nouveau buff '" + description) + "' (") + gaftbmsg.actionId) + ") lancé par ") + gaftbmsg.sourceId) + " sur ") + gaftbmsg.effect.targetId) + " (uid ") + gaftbmsg.effect.uid) + ", sort ") + gaftbmsg.effect.spellId) + ", durée ") + gaftbmsg.effect.turnDuration) + ", desenvoutable ") + gaftbmsg.effect.dispelable) + ", buff parent ") + gaftbmsg.effect.parentBoostUid) + ")"));
            };
            for each (castedSpell in this._castingSpells)
            {
                if (((castedSpell.spell.id == gaftbmsg.effect.spellId) && (castedSpell.casterId == gaftbmsg.sourceId)))
                {
                    myCastingSpell = castedSpell;
                    break;
                };
            };
            if (!myCastingSpell)
            {
                if (gaftbmsg.actionId == ActionIdProtocol.ACTION_CHARACTER_UPDATE_BOOST)
                {
                    myCastingSpell = new CastingSpell(false);
                }
                else
                {
                    myCastingSpell = new CastingSpell((this._castingSpell == null));
                };
                if (this._castingSpell)
                {
                    myCastingSpell.castingSpellId = this._castingSpell.castingSpellId;
                    if (((this._castingSpell.spell) && (this._castingSpell.spell.id == gaftbmsg.effect.spellId)))
                    {
                        myCastingSpell.spellRank = this._castingSpell.spellRank;
                    };
                };
                myCastingSpell.spell = Spell.getSpellById(gaftbmsg.effect.spellId);
                myCastingSpell.casterId = gaftbmsg.sourceId;
            };
            var buffEffect:AbstractFightDispellableEffect = gaftbmsg.effect;
            var buff:BasicBuff = BuffManager.makeBuffFromEffect(buffEffect, myCastingSpell, gaftbmsg.actionId);
            if ((buff is StateBuff))
            {
                sb = (buff as StateBuff);
                if (sb.actionId == ActionIds.ACTION_FIGHT_DISABLE_STATE)
                {
                    step = new FightLeavingStateStep(sb.targetId, sb.stateId, buff);
                }
                else
                {
                    step = new FightEnteringStateStep(sb.targetId, sb.stateId, sb.effect.durationString, buff);
                };
                if (myCastingSpell != null)
                {
                    step.castingSpellId = myCastingSpell.castingSpellId;
                };
                this._stepsBuffer.push(step);
            };
            if ((buff is StatBuff))
            {
                (buff as StatBuff).isRecent = true;
            };
            if ((buffEffect is FightTemporaryBoostEffect))
            {
                actionId = gaftbmsg.actionId;
                if (((((((!(actionId == ActionIds.ACTION_CHARACTER_MAKE_INVISIBLE)) && (!(actionId == ActionIdProtocol.ACTION_CHARACTER_UPDATE_BOOST))) && (!(actionId == ActionIds.ACTION_CHARACTER_CHANGE_LOOK))) && (!(actionId == ActionIds.ACTION_CHARACTER_CHANGE_COLOR))) && (!(actionId == ActionIds.ACTION_CHARACTER_ADD_APPEARANCE))) && (!(actionId == ActionIds.ACTION_FIGHT_SET_STATE))))
                {
                    if (GameDebugManager.getInstance().detailedFightLog_showEverything)
                    {
                        buff.effect.visibleInFightLog = true;
                    };
                    if (GameDebugManager.getInstance().detailedFightLog_showBuffsInUi)
                    {
                        buff.effect.visibleInBuffUi = true;
                    };
                    this.pushStep(new FightTemporaryBoostStep(gaftbmsg.effect.targetId, buff.effect.description, buff.effect.duration, buff.effect.durationString, buff.effect.visibleInFightLog, buff));
                };
                if (actionId == ActionIds.ACTION_CHARACTER_BOOST_SHIELD)
                {
                    this.pushStep(new FightShieldPointsVariationStep(gaftbmsg.effect.targetId, (buff as StatBuff).delta, ElementEnum.ELEMENT_NONE));
                };
            };
            this.pushStep(new FightDisplayBuffStep(buff));
        }

        private function executeBuffer(callback:Function):void
        {
            var step:ISequencable;
            var allowHitAnim:Boolean;
            var allowSpellEffects:Boolean;
            var startStep:Array;
            var endStep:Array;
            var removed:Boolean;
            var entityAttaqueAnimWait:Dictionary;
            var lifeLoseSum:Dictionary;
            var lifeLoseLastStep:Dictionary;
            var shieldLoseSum:Dictionary;
            var shieldLoseLastStep:Dictionary;
            var deathNumber:int;
            var i:int;
            var b:*;
            var index:*;
            var waitStep:WaitAnimationEventStep;
            var animStep:PlayAnimationStep;
            var deathStep:FightDeathStep;
            var deadEntityIndex:int;
            var fapvs:FightActionPointsVariationStep;
            var fspvs:FightShieldPointsVariationStep;
            var fspvsTarget:IEntity;
            var flvs:FightLifeVariationStep;
            var flvsTarget:IEntity;
            var idx:int;
            var idx2:int;
            var loseLifeTarget:*;
            var j:uint;
            var cleanedBuffer:Array = [];
            var deathStepRef:Dictionary = new Dictionary(true);
            var hitStep:Vector.<TiphonSprite> = new Vector.<TiphonSprite>();
            var loseLifeStep:Dictionary = new Dictionary(true);
            var waitHitEnd:Boolean;
            for each (step in this._stepsBuffer)
            {
                if ((step is FightMarkTriggeredStep))
                {
                    waitHitEnd = true;
                };
            };
            allowHitAnim = OptionManager.getOptionManager("dofus").getOption("allowHitAnim");
            allowSpellEffects = OptionManager.getOptionManager("dofus").getOption("allowSpellEffects");
            startStep = [];
            endStep = [];
            entityAttaqueAnimWait = new Dictionary();
            lifeLoseSum = new Dictionary(true);
            lifeLoseLastStep = new Dictionary(true);
            shieldLoseSum = new Dictionary(true);
            shieldLoseLastStep = new Dictionary(true);
            deathNumber = 0;
            i = this._stepsBuffer.length;
            _loop_1:
            for (;--i >= 0;)
            {
                if (((removed) && (step)))
                {
                    step.clear();
                };
                removed = true;
                step = this._stepsBuffer[i];
                switch (true)
                {
                    case (step is PlayAnimationStep):
                        animStep = (step as PlayAnimationStep);
                        if (animStep.animation.indexOf(AnimationEnum.ANIM_HIT) != -1)
                        {
                            if (!allowHitAnim)
                            {
                                continue _loop_1;
                            };
                            animStep.waitEvent = waitHitEnd;
                            if ((((animStep.target == null) || (deathStepRef[EntitiesManager.getInstance().getEntityID((animStep.target as IEntity))])) || (hitStep.indexOf(animStep.target))))
                            {
                                continue _loop_1;
                            };
                            if ((((!(animStep.animation == AnimationEnum.ANIM_HIT)) && (!(animStep.animation == AnimationEnum.ANIM_HIT_CARRYING))) && (!(animStep.target.hasAnimation(animStep.animation, 1)))))
                            {
                                animStep.animation = AnimationEnum.ANIM_HIT;
                            };
                            hitStep.push(animStep.target);
                        };
                        if (((this._castingSpell) && (this._castingSpell.casterId < 0)))
                        {
                            if (entityAttaqueAnimWait[animStep.target])
                            {
                                cleanedBuffer.unshift(entityAttaqueAnimWait[animStep.target]);
                                delete entityAttaqueAnimWait[animStep.target];
                            };
                            if (animStep.animation.indexOf(AnimationEnum.ANIM_ATTAQUE_BASE) != -1)
                            {
                                entityAttaqueAnimWait[animStep.target] = new WaitAnimationEventStep(animStep);
                            };
                        };
                        break;
                    case (step is FightDeathStep):
                        deathStep = (step as FightDeathStep);
                        deathStepRef[deathStep.entityId] = true;
                        deadEntityIndex = this._fightBattleFrame.targetedEntities.indexOf(deathStep.entityId);
                        if (deadEntityIndex != -1)
                        {
                            this._fightBattleFrame.targetedEntities.splice(deadEntityIndex, 1);
                            TooltipManager.hide(("tooltipOverEntity_" + deathStep.entityId));
                        };
                        deathNumber++;
                        break;
                    case (step is FightActionPointsVariationStep):
                        fapvs = (step as FightActionPointsVariationStep);
                        if (fapvs.voluntarlyUsed)
                        {
                            startStep.push(fapvs);
                            removed = false;
                            continue _loop_1;
                        };
                        break;
                    case (step is FightShieldPointsVariationStep):
                        fspvs = (step as FightShieldPointsVariationStep);
                        fspvsTarget = fspvs.target;
                        if (fspvsTarget == null)
                        {
                            break;
                        };
                        if (fspvs.value < 0)
                        {
                            fspvs.virtual = true;
                            if (shieldLoseSum[fspvsTarget] == null)
                            {
                                shieldLoseSum[fspvsTarget] = 0;
                            };
                            shieldLoseSum[fspvsTarget] = (shieldLoseSum[fspvsTarget] + fspvs.value);
                            shieldLoseLastStep[fspvsTarget] = fspvs;
                        };
                        break;
                    case (step is FightLifeVariationStep):
                        flvs = (step as FightLifeVariationStep);
                        flvsTarget = flvs.target;
                        if (flvsTarget == null)
                        {
                            break;
                        };
                        if (flvs.delta < 0)
                        {
                            loseLifeStep[flvsTarget] = flvs;
                        };
                        if (lifeLoseSum[flvsTarget] == null)
                        {
                            lifeLoseSum[flvsTarget] = 0;
                        };
                        lifeLoseSum[flvsTarget] = (lifeLoseSum[flvsTarget] + flvs.delta);
                        lifeLoseLastStep[flvsTarget] = flvs;
                        break;
                    case (step is AddGfxEntityStep):
                    case (step is AddGfxInLineStep):
                    case (step is AddGlyphGfxStep):
                    case (step is ParableGfxMovementStep):
                    case (step is AddWorldEntityStep):
                        if (((!(allowSpellEffects)) && (PlayedCharacterManager.getInstance().isFighting)))
                        {
                            continue _loop_1;
                        };
                        break;
                };
                removed = false;
                cleanedBuffer.unshift(step);
            };
            this._fightBattleFrame.deathPlayingNumber = deathNumber;
            for each (b in cleanedBuffer)
            {
                if ((((b is FightLifeVariationStep) && (lifeLoseSum[b.target] == 0)) && (!(shieldLoseSum[b.target] == null))))
                {
                    b.skipTextEvent = true;
                };
            };
            for (index in lifeLoseSum)
            {
                if (((!(index == "null")) && (!(lifeLoseSum[index] == 0))))
                {
                    idx = cleanedBuffer.indexOf(lifeLoseLastStep[index]);
                    cleanedBuffer.splice(idx, 0, new FightLossAnimStep(index, lifeLoseSum[index], FightLifeVariationStep.COLOR));
                };
                lifeLoseLastStep[index] = -1;
                lifeLoseSum[index] = 0;
            };
            for (index in shieldLoseSum)
            {
                if (((!(index == "null")) && (!(shieldLoseSum[index] == 0))))
                {
                    idx2 = cleanedBuffer.indexOf(shieldLoseLastStep[index]);
                    cleanedBuffer.splice(idx2, 0, new FightLossAnimStep(index, shieldLoseSum[index], FightShieldPointsVariationStep.COLOR));
                };
                shieldLoseLastStep[index] = -1;
                shieldLoseSum[index] = 0;
            };
            for each (waitStep in entityAttaqueAnimWait)
            {
                endStep.push(waitStep);
            };
            if (allowHitAnim)
            {
                for (loseLifeTarget in loseLifeStep)
                {
                    if (hitStep.indexOf(loseLifeTarget) == -1)
                    {
                        j = 0;
                        while (j < cleanedBuffer.length)
                        {
                            if (cleanedBuffer[j] == loseLifeStep[loseLifeTarget])
                            {
                                cleanedBuffer.splice(j, 0, new PlayAnimationStep((loseLifeTarget as TiphonSprite), AnimationEnum.ANIM_HIT, true, false));
                                break;
                            };
                            j++;
                        };
                    };
                };
            };
            cleanedBuffer = startStep.concat(cleanedBuffer).concat(endStep);
            for each (step in cleanedBuffer)
            {
                this._sequencer.addStep(step);
            };
            this.clearBuffer();
            if (((!(callback == null)) && (!(this._parent))))
            {
                this._sequenceEndCallback = callback;
                this._permanentTooltipsCallback = new Callback(this.showPermanentTooltips, cleanedBuffer);
                this._sequencer.addEventListener(SequencerEvent.SEQUENCE_END, this.onSequenceEnd);
            };
            _lastCastingSpell = this._castingSpell;
            this._scriptInit = true;
            if (!this._parent)
            {
                if (!this._subSequenceWaitingCount)
                {
                    this._sequencer.start();
                }
                else
                {
                    _log.warn((("Waiting sub sequence init end (" + this._subSequenceWaitingCount) + " seq)"));
                };
            }
            else
            {
                if (callback != null)
                {
                    (callback());
                };
                this._parent.subSequenceInitDone();
            };
        }

        private function onSequenceEnd(e:SequencerEvent):void
        {
            this._sequencer.removeEventListener(SequencerEvent.SEQUENCE_END, this.onSequenceEnd);
            if (this._permanentTooltipsCallback)
            {
                this._permanentTooltipsCallback.exec();
            };
            this._sequenceEndCallback();
            this.updateMovementArea();
        }

        private function onStepEnd(e:SequencerEvent, isEnd:Boolean=true):void
        {
            this._sequencer.removeEventListener(SequencerEvent.SEQUENCE_STEP_FINISH, this.onStepEnd);
        }

        private function subSequenceInitDone():void
        {
            this._subSequenceWaitingCount--;
            if ((((!(this.isWaiting)) && (this._sequencer)) && (!(this._sequencer.running))))
            {
                _log.warn("Sub sequence init end -- Run main sequence");
                this._sequencer.start();
            };
        }

        private function pushTeleportStep(fighterId:Number, destinationCell:int):void
        {
            var step:FightTeleportStep;
            this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip, fighterId)));
            if (destinationCell != -1)
            {
                step = new FightTeleportStep(fighterId, MapPoint.fromCellId(destinationCell));
                if (this.castingSpell != null)
                {
                    step.castingSpellId = this.castingSpell.castingSpellId;
                };
                this._stepsBuffer.push(step);
            };
        }

        private function pushSlideStep(fighterId:Number, startCell:int, endCell:int):void
        {
            if (((startCell < 0) || (endCell < 0)))
            {
                return;
            };
            this._stepsBuffer.push(new CallbackStep(new Callback(deleteTooltip, fighterId)));
            var step:FightEntitySlideStep = new FightEntitySlideStep(fighterId, MapPoint.fromCellId(startCell), MapPoint.fromCellId(endCell));
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushPointsVariationStep(fighterId:Number, actionId:uint, delta:int):void
        {
            var step:IFightStep;
            switch (actionId)
            {
                case ActionIdProtocol.ACTION_CHARACTER_ACTION_POINTS_USE:
                    step = new FightActionPointsVariationStep(fighterId, delta, true);
                    break;
                case ActionIds.ACTION_CHARACTER_ACTION_POINTS_LOST:
                case ActionIds.ACTION_CHARACTER_ACTION_POINTS_WIN:
                    step = new FightActionPointsVariationStep(fighterId, delta, false);
                    break;
                case ActionIdProtocol.ACTION_CHARACTER_MOVEMENT_POINTS_USE:
                    step = new FightMovementPointsVariationStep(fighterId, delta, true);
                    break;
                case ActionIds.ACTION_CHARACTER_MOVEMENT_POINTS_LOST:
                case ActionIds.ACTION_CHARACTER_MOVEMENT_POINTS_WIN:
                    step = new FightMovementPointsVariationStep(fighterId, delta, false);
                    break;
                default:
                    _log.warn((("Points variation with unsupported action (" + actionId) + "), skipping."));
                    return;
            };
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushStep(step:AbstractSequencable):void
        {
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushPointsLossDodgeStep(fighterId:Number, actionId:uint, amount:int):void
        {
            var step:IFightStep;
            switch (actionId)
            {
                case ActionIdProtocol.ACTION_FIGHT_SPELL_DODGED_PA:
                    step = new FightActionPointsLossDodgeStep(fighterId, amount);
                    break;
                case ActionIdProtocol.ACTION_FIGHT_SPELL_DODGED_PM:
                    step = new FightMovementPointsLossDodgeStep(fighterId, amount);
                    break;
                default:
                    _log.warn((("Points dodge with unsupported action (" + actionId) + "), skipping."));
                    return;
            };
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
        }

        private function pushPlaySpellScriptStep(fxScriptId:int, fighterId:Number, cellId:int, spellId:int, spellRank:uint, stepBuff:SpellScriptBuffer=null):FightPlaySpellScriptStep
        {
            var step:FightPlaySpellScriptStep = new FightPlaySpellScriptStep(fxScriptId, fighterId, cellId, spellId, spellRank, ((stepBuff) ? stepBuff : this));
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
            };
            this._stepsBuffer.push(step);
            return (step);
        }

        private function pushThrowCharacterStep(fighterId:Number, carriedId:Number, cellId:int):void
        {
            var step:FightThrowCharacterStep = new FightThrowCharacterStep(fighterId, carriedId, cellId);
            if (this.castingSpell != null)
            {
                step.castingSpellId = this.castingSpell.castingSpellId;
                step.portals = this.castingSpell.portalMapPoints;
                step.portalIds = this.castingSpell.portalIds;
            };
            this._stepsBuffer.push(step);
        }

        private function clearBuffer():void
        {
            this._stepsBuffer = new Vector.<ISequencable>(0, false);
        }

        private function keepInMindToUpdateMovementArea():void
        {
            if (this._updateMovementAreaAtSequenceEnd)
            {
                return;
            };
            var fightTurnFrame:FightTurnFrame = (Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame);
            if (((fightTurnFrame) && (fightTurnFrame.myTurn)))
            {
                this._updateMovementAreaAtSequenceEnd = true;
            };
        }

        private function updateMovementArea():void
        {
            if (!this._updateMovementAreaAtSequenceEnd)
            {
                return;
            };
            var fightTurnFrame:FightTurnFrame = (Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame);
            if (((fightTurnFrame) && (fightTurnFrame.myTurn)))
            {
                fightTurnFrame.drawMovementArea();
                this._updateMovementAreaAtSequenceEnd = false;
            };
        }

        private function showTargetTooltip(pEntityId:Number):void
        {
            var fcf:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            var entityInfos:GameFightFighterInformations = (this.fightEntitiesFrame.getEntityInfos(pEntityId) as GameFightFighterInformations);
            if (((((((entityInfos.spawnInfo.alive) && (this._castingSpell)) && ((this._castingSpell.casterId == PlayedCharacterManager.getInstance().id) || (fcf.battleFrame.playingSlaveEntity))) && (!(pEntityId == this.castingSpell.casterId))) && (this._fightBattleFrame.targetedEntities.indexOf(pEntityId) == -1)) && (fcf.hiddenEntites.indexOf(pEntityId) == -1)))
            {
                this._fightBattleFrame.targetedEntities.push(pEntityId);
                if (OptionManager.getOptionManager("dofus").getOption("showPermanentTargetsTooltips") == true)
                {
                    fcf.displayEntityTooltip(pEntityId);
                };
            };
        }

        private function isSpellTeleportingToPreviousPosition():Boolean
        {
            var spellEffect:EffectInstanceDice;
            if (((this.castingSpell) && (this.castingSpell.spellRank)))
            {
                for each (spellEffect in this.castingSpell.spellRank.effects)
                {
                    if (spellEffect.effectId == ActionIds.ACTION_FIGHT_ROLLBACK_PREVIOUS_POSITION)
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        private function showPermanentTooltips(pSteps:Array):void
        {
            var step:AbstractSequencable;
            var targetId:Number;
            for each (step in pSteps)
            {
                if (((step is IFightStep) && (!(step is FightTurnListStep))))
                {
                    for each (targetId in (step as IFightStep).targets)
                    {
                        if (((this.fightEntitiesFrame.getEntityInfos(targetId)) && (!(this.fightEntitiesFrame.getEntityInfos(targetId).disposition.cellId == -1))))
                        {
                            this.showTargetTooltip(targetId);
                        };
                    };
                };
            };
        }

        private function summonEntity(entity:GameFightFighterInformations, sourceId:Number, actionId:uint):void
        {
            var isBomb:Boolean;
            var isCreature:Boolean;
            var entityInfosS:GameContextActorInformations;
            var summonedEntityInfosS:GameFightMonsterInformations;
            var monsterS:Monster;
            var summonedCharacterInfoS:GameFightCharacterInformations;
            var gfsgmsg:GameFightShowFighterMessage = new GameFightShowFighterMessage();
            gfsgmsg.initGameFightShowFighterMessage(entity);
            Kernel.getWorker().getFrame(FightEntitiesFrame).process(gfsgmsg);
            if (ActionIdHelper.isRevive(actionId))
            {
                this.fightEntitiesFrame.removeLastKilledAlly(entity.spawnInfo.teamId);
            };
            var summonedCreature:Sprite = (DofusEntities.getEntity(entity.contextualId) as Sprite);
            if (summonedCreature)
            {
                summonedCreature.visible = false;
            };
            this.pushStep(new FightSummonStep(sourceId, entity));
            if (sourceId == CurrentPlayedFighterManager.getInstance().currentFighterId)
            {
                isBomb = false;
                isCreature = false;
                if (actionId == ActionIds.ACTION_SUMMON_BOMB)
                {
                    isBomb = true;
                }
                else
                {
                    entityInfosS = FightEntitiesFrame.getCurrentInstance().getEntityInfos(entity.contextualId);
                    isBomb = false;
                    summonedEntityInfosS = (entityInfosS as GameFightMonsterInformations);
                    if (summonedEntityInfosS)
                    {
                        monsterS = Monster.getMonsterById(summonedEntityInfosS.creatureGenericId);
                        if (((monsterS) && (monsterS.useBombSlot)))
                        {
                            isBomb = true;
                        };
                        if (((monsterS) && (monsterS.useSummonSlot)))
                        {
                            isCreature = true;
                        };
                    }
                    else
                    {
                        summonedCharacterInfoS = (entityInfosS as GameFightCharacterInformations);
                    };
                };
                if (((isCreature) || (summonedCharacterInfoS)))
                {
                    CurrentPlayedFighterManager.getInstance().addSummonedCreature();
                }
                else
                {
                    if (isBomb)
                    {
                        CurrentPlayedFighterManager.getInstance().addSummonedBomb();
                    };
                };
            };
            var nextPlayableCharacterId:Number = this._fightBattleFrame.getNextPlayableCharacterId();
            if ((((!(this._fightBattleFrame.currentPlayerId == CurrentPlayedFighterManager.getInstance().currentFighterId)) && (!(nextPlayableCharacterId == CurrentPlayedFighterManager.getInstance().currentFighterId))) && (nextPlayableCharacterId == entity.contextualId)))
            {
                this._fightBattleFrame.prepareNextPlayableCharacter();
            };
        }


    }
} com.ankamagames.dofus.logic.game.fight.frames

