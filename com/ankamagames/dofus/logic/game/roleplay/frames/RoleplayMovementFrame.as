package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.game.context.GameMapMovementMessage;
    import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
    import com.ankamagames.atouin.messages.EntityMovementStoppedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.TeleportOnSameMapMessage;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.network.messages.game.context.GameMapNoMovementMessage;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.jerakine.types.positions.MovementPath;
    import com.ankamagames.dofus.network.messages.game.context.GameMapMovementConfirmMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameMapMovementCancelMessage;
    import com.ankamagames.dofus.logic.game.common.frames.StackManagementFrame;
    import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.MoveBehavior;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.logic.game.common.managers.MapMovementAdapter;
    import com.ankamagames.dofus.network.messages.game.context.GameCautiousMapMovementMessage;
    import com.ankamagames.jerakine.pathfinding.Pathfinding;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.messages.CharacterMovementStoppedMessage;
    import com.ankamagames.dofus.logic.common.actions.EmptyStackAction;
    import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightRequestAction;
    import com.ankamagames.jerakine.entities.interfaces.IMovable;
    import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUsedMessage;
    import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseEndedMessage;
    import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseErrorMessage;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.EditHavenBagFinishedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.delay.GameRolePlayDelayedActionFinishedMessage;
    import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightPlayersHelpersLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.prism.PrismFightDefenderLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayFightRequestCanceledMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.handlers.messages.Action;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.network.messages.game.context.GameCautiousMapMovementRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.GameMapMovementRequestMessage;
    import com.ankamagames.berilia.frames.ShortcutsFrame;
    import com.ankamagames.jerakine.utils.system.SystemManager;
    import com.ankamagames.jerakine.enum.OperatingSystem;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.dofus.types.data.Follower;
    import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
    import com.ankamagames.dofus.types.entities.RiderBehavior;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.TriggerHookList;
    import com.ankamagames.dofus.logic.game.roleplay.managers.AnimFunManager;
    import com.ankamagames.atouin.entities.behaviours.movements.WalkingMovementBehavior;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.ChangeMapMessage;
    import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseRequestMessage;
    import com.ankamagames.dofus.network.messages.game.interactive.skill.InteractiveUseWithParamRequestMessage;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayAttackMonsterRequestMessage;

    public class RoleplayMovementFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayMovementFrame));
        private static const CONSECUTIVE_MOVEMENT_DELAY:uint = 250;

        private var _wantToChangeMap:Number = -1;
        private var _changeMapByAutoTrip:Boolean = false;
        private var _followingMove:MapPoint;
        private var _followingIe:Object;
        private var _followingMonsterGroup:Object;
        private var _followingMessage:*;
        private var _isRequestingMovement:Boolean;
        private var _latestMovementRequest:uint;
        private var _destinationPoint:uint;
        private var _nextMovementBehavior:uint;
        private var _lastPlayerValidatedPosition:MapPoint;
        private var _lastMoveEndCellId:int;
        private var _canMove:Boolean = true;
        private var _mapHasAggressiveMonsters:Boolean = false;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get isRequestingMovement():Boolean
        {
            return (this._isRequestingMovement);
        }

        public function pushed():Boolean
        {
            this._wantToChangeMap = -1;
            this._changeMapByAutoTrip = false;
            this._followingIe = null;
            this._followingMonsterGroup = null;
            this._followingMove = null;
            this._isRequestingMovement = false;
            this._latestMovementRequest = 0;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var gmmmsg:GameMapMovementMessage;
            var emcmsg:EntityMovementCompleteMessage;
            var emsmsg:EntityMovementStoppedMessage;
            var tosmmsg:TeleportOnSameMapMessage;
            var teleportedEntity:IEntity;
            var gmnmm:GameMapNoMovementMessage;
            var newPos:MapPoint;
            var player:AnimatedCharacter;
            var playerEntity:IEntity;
            var requestedPath:MovementPath;
            var gmmcmsg:GameMapMovementConfirmMessage;
            var canceledMoveMessage:GameMapMovementCancelMessage;
            var stackFrame:StackManagementFrame;
            var moveBehavior:MoveBehavior;
            switch (true)
            {
                case (msg is GameMapNoMovementMessage):
                    this._isRequestingMovement = false;
                    if (this._followingIe)
                    {
                        this.activateSkill(this._followingIe.skillInstanceId, this._followingIe.ie, this._followingIe.additionalParam);
                        this._followingIe = null;
                    };
                    if (this._followingMonsterGroup)
                    {
                        this.requestMonsterFight(this._followingMonsterGroup.id);
                        this._followingMonsterGroup = null;
                    }
                    else
                    {
                        gmnmm = (msg as GameMapNoMovementMessage);
                        newPos = MapPoint.fromCoords(gmnmm.cellX, gmnmm.cellY);
                        player = AnimatedCharacter(DofusEntities.getEntity(PlayedCharacterManager.getInstance().id));
                        if (!player)
                        {
                            return (true);
                        };
                        if (player.isMoving)
                        {
                            player.stop(true);
                            player.setAnimation("AnimStatique");
                        };
                        player.position = newPos;
                        player.jump(newPos);
                    };
                    return (true);
                case (msg is GameMapMovementMessage):
                    gmmmsg = (msg as GameMapMovementMessage);
                    if (gmmmsg.actorId != PlayedCharacterManager.getInstance().id)
                    {
                        this.applyGameMapMovement(gmmmsg.actorId, MapMovementAdapter.getClientMovement(gmmmsg.keyMovements), (msg is GameCautiousMapMovementMessage));
                    }
                    else
                    {
                        this._lastPlayerValidatedPosition = MapMovementAdapter.getClientMovement(gmmmsg.keyMovements).end;
                        if (this._lastMoveEndCellId != this._lastPlayerValidatedPosition.cellId)
                        {
                            playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                            requestedPath = Pathfinding.findPath(DataMapProvider.getInstance(), playerEntity.position, this._lastPlayerValidatedPosition, (!(PlayedCharacterManager.getInstance().restrictions.cantWalk8Directions)), true);
                            this.applyGameMapMovement(gmmmsg.actorId, requestedPath, (msg is GameCautiousMapMovementMessage));
                        };
                    };
                    return (true);
                case (msg is EntityMovementCompleteMessage):
                    emcmsg = (msg as EntityMovementCompleteMessage);
                    if (emcmsg.entity.id == PlayedCharacterManager.getInstance().id)
                    {
                        gmmcmsg = new GameMapMovementConfirmMessage();
                        gmmcmsg.initGameMapMovementConfirmMessage();
                        ConnectionsHandler.getConnection().send(gmmcmsg);
                        if (((this._wantToChangeMap >= 0) && (emcmsg.entity.position.cellId == this._destinationPoint)))
                        {
                            this.askMapChange();
                            this._isRequestingMovement = false;
                        };
                        if (this._followingIe)
                        {
                            this.activateSkill(this._followingIe.skillInstanceId, this._followingIe.ie, this._followingIe.additionalParam);
                            this._followingIe = null;
                        };
                        if (this._followingMonsterGroup)
                        {
                            this.requestMonsterFight(this._followingMonsterGroup.id);
                            this._followingMonsterGroup = null;
                        };
                        Kernel.getWorker().process(new CharacterMovementStoppedMessage());
                    };
                    return (true);
                case (msg is EntityMovementStoppedMessage):
                    emsmsg = (msg as EntityMovementStoppedMessage);
                    if (emsmsg.entity.id == PlayedCharacterManager.getInstance().id)
                    {
                        canceledMoveMessage = new GameMapMovementCancelMessage();
                        canceledMoveMessage.initGameMapMovementCancelMessage(emsmsg.entity.position.cellId);
                        ConnectionsHandler.getConnection().send(canceledMoveMessage);
                        this._isRequestingMovement = false;
                        if (((this._followingMove) && (this._canMove)))
                        {
                            this.askMoveTo(this._followingMove);
                            stackFrame = (Kernel.getWorker().getFrame(StackManagementFrame) as StackManagementFrame);
                            if (stackFrame.stackOutputMessage.length > 0)
                            {
                                moveBehavior = (stackFrame.stackOutputMessage[0] as MoveBehavior);
                                if (((moveBehavior) && (!(moveBehavior.position.cellId == this._followingMove.cellId))))
                                {
                                    Kernel.getWorker().process(EmptyStackAction.create());
                                };
                            };
                            this._followingMove = null;
                        };
                        if (this._followingMessage)
                        {
                            switch (true)
                            {
                                case (this._followingMessage is PlayerFightRequestAction):
                                    Kernel.getWorker().process(this._followingMessage);
                                    break;
                                default:
                                    ConnectionsHandler.getConnection().send(this._followingMessage);
                            };
                            this._followingMessage = null;
                        };
                    };
                    return (true);
                case (msg is TeleportOnSameMapMessage):
                    tosmmsg = (msg as TeleportOnSameMapMessage);
                    teleportedEntity = DofusEntities.getEntity(tosmmsg.targetId);
                    if (teleportedEntity)
                    {
                        if ((teleportedEntity is IMovable))
                        {
                            if (IMovable(teleportedEntity).isMoving)
                            {
                                IMovable(teleportedEntity).stop(true);
                            };
                            (teleportedEntity as IMovable).jump(MapPoint.fromCellId(tosmmsg.cellId));
                        }
                        else
                        {
                            _log.warn("Cannot teleport a non IMovable entity. WTF ?");
                        };
                    }
                    else
                    {
                        _log.warn("Received a teleportation request for a non-existing entity. Aborting.");
                    };
                    return (true);
                case (msg is InteractiveUsedMessage):
                    if (InteractiveUsedMessage(msg).entityId == PlayedCharacterManager.getInstance().id)
                    {
                        this._canMove = InteractiveUsedMessage(msg).canMove;
                    };
                    return (true);
                case (msg is InteractiveUseEndedMessage):
                    this._canMove = true;
                    return (true);
                case (msg is InteractiveUseErrorMessage):
                    this._canMove = true;
                    return (true);
                case (msg is LeaveDialogMessage):
                    this._canMove = true;
                    return (false);
                case (msg is ExchangeLeaveMessage):
                    this._canMove = true;
                    return (false);
                case (msg is EditHavenBagFinishedMessage):
                    this._canMove = true;
                    return (false);
                case (msg is GameRolePlayDelayedActionFinishedMessage):
                    if (GameRolePlayDelayedActionFinishedMessage(msg).delayedCharacterId == PlayedCharacterManager.getInstance().id)
                    {
                        this._canMove = true;
                    };
                    return (false);
                case (msg is GuildFightPlayersHelpersLeaveMessage):
                    if (GuildFightPlayersHelpersLeaveMessage(msg).playerId == PlayedCharacterManager.getInstance().id)
                    {
                        this._canMove = true;
                    };
                    return (false);
                case (msg is PrismFightDefenderLeaveMessage):
                    if (PrismFightDefenderLeaveMessage(msg).fighterToRemoveId == PlayedCharacterManager.getInstance().id)
                    {
                        this._canMove = true;
                    };
                    return (false);
                case (msg is GameRolePlayFightRequestCanceledMessage):
                    if (((GameRolePlayFightRequestCanceledMessage(msg).targetId == PlayedCharacterManager.getInstance().id) || (GameRolePlayFightRequestCanceledMessage(msg).sourceId == PlayedCharacterManager.getInstance().id)))
                    {
                        this._canMove = true;
                    };
                    return (false);
                case (msg is MapComplementaryInformationsDataMessage):
                    this._mapHasAggressiveMonsters = MapComplementaryInformationsDataMessage(msg).hasAggressiveMonsters;
                    return (false);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        internal function setNextMoveMapChange(mapId:Number, autoTrip:Boolean=false):void
        {
            this._wantToChangeMap = mapId;
            this._changeMapByAutoTrip = autoTrip;
        }

        internal function resetNextMoveMapChange():void
        {
            this._wantToChangeMap = -1;
            this._changeMapByAutoTrip = false;
        }

        internal function setFollowingInteraction(interaction:Object):void
        {
            this._followingIe = interaction;
        }

        internal function setFollowingMonsterFight(monsterGroup:Object):void
        {
            this._followingMonsterGroup = monsterGroup;
        }

        public function setFollowingMessage(message:*):void
        {
            if (!((message is INetworkMessage) || (message is Action)))
            {
                throw (new Error("The message is neither INetworkMessage or Action"));
            };
            this._followingMessage = message;
        }

        public function forceNextMovementBehavior(pValue:uint):void
        {
            this._nextMovementBehavior = pValue;
        }

        internal function askMoveTo(cell:MapPoint):Boolean
        {
            if (((!(this._canMove)) || (PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_TOMBSTONE)))
            {
                return (false);
            };
            if (this._isRequestingMovement)
            {
                return (false);
            };
            var stackFrame:StackManagementFrame = (Kernel.getWorker().getFrame(StackManagementFrame) as StackManagementFrame);
            var stackMoveBehavior:MoveBehavior = ((stackFrame.stackOutputMessage.length > 0) ? (stackFrame.stackOutputMessage[0] as MoveBehavior) : null);
            var now:uint = getTimer();
            if ((((this._latestMovementRequest + CONSECUTIVE_MOVEMENT_DELAY) > now) && ((!(stackMoveBehavior)) || (!(stackMoveBehavior.getMapPoint().equals(cell))))))
            {
                return (false);
            };
            this._isRequestingMovement = true;
            var playerEntity:IEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            if (!playerEntity)
            {
                _log.warn("The player tried to move before its character was added to the scene. Aborting.");
                this._isRequestingMovement = false;
                return (false);
            };
            this._destinationPoint = cell.cellId;
            if (IMovable(playerEntity).isMoving)
            {
                IMovable(playerEntity).stop();
                this._followingMove = cell;
                return (false);
            };
            (playerEntity as AnimatedCharacter).visibleAura = false;
            this.sendPath(Pathfinding.findPath(DataMapProvider.getInstance(), playerEntity.position, cell, (!(PlayedCharacterManager.getInstance().restrictions.cantWalk8Directions)), true));
            return (true);
        }

        private function sendPath(path:MovementPath):void
        {
            var gcmmrmsg:GameCautiousMapMovementRequestMessage;
            var gmmrmsg:GameMapMovementRequestMessage;
            var originalPath:MovementPath = path.clone();
            if (path.start.cellId == path.end.cellId)
            {
                _log.warn((("Discarding a movement path that begins and ends on the same cell (" + path.start.cellId) + ")."));
                this._isRequestingMovement = false;
                if (this._followingIe)
                {
                    this.activateSkill(this._followingIe.skillInstanceId, this._followingIe.ie, this._followingIe.additionalParam);
                    this._followingIe = null;
                };
                if (this._followingMonsterGroup)
                {
                    this.requestMonsterFight(this._followingMonsterGroup.id);
                    this._followingMonsterGroup = null;
                };
                return;
            };
            var forceWalk:Boolean;
            if (((OptionManager.getOptionManager("dofus").getOption("enableForceWalk") == true) && ((this._nextMovementBehavior == AtouinConstants.MOVEMENT_WALK) || ((this._nextMovementBehavior == 0) && ((ShortcutsFrame.ctrlKeyDown) || ((SystemManager.getSingleton().os == OperatingSystem.MAC_OS) && (ShortcutsFrame.altKeyDown)))))))
            {
                gcmmrmsg = new GameCautiousMapMovementRequestMessage();
                gcmmrmsg.initGameCautiousMapMovementRequestMessage(MapMovementAdapter.getServerMovement(path), PlayedCharacterManager.getInstance().currentMap.mapId);
                ConnectionsHandler.getConnection().send(gcmmrmsg);
                forceWalk = true;
            }
            else
            {
                gmmrmsg = new GameMapMovementRequestMessage();
                gmmrmsg.initGameMapMovementRequestMessage(MapMovementAdapter.getServerMovement(path), PlayedCharacterManager.getInstance().currentMap.mapId);
                ConnectionsHandler.getConnection().send(gmmrmsg);
            };
            this.applyGameMapMovement(PlayedCharacterManager.getInstance().id, originalPath, forceWalk);
            this._nextMovementBehavior = 0;
            this._latestMovementRequest = getTimer();
        }

        private function applyGameMapMovement(actorId:Number, movement:MovementPath, forceWalking:Boolean=false):void
        {
            var monsterId:Number;
            var monster:AnimatedCharacter;
            var underling:Follower;
            SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_MOVE);
            var movedEntity:IEntity = DofusEntities.getEntity(actorId);
            if (!movedEntity)
            {
                _log.warn((("The entity " + actorId) + " moved before it was added to the scene. Aborting movement."));
                return;
            };
            var rpEntitiesFrame:RoleplayEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
            if (this._followingMonsterGroup)
            {
                for each (monsterId in rpEntitiesFrame.monstersIds)
                {
                    monster = (DofusEntities.getEntity(monsterId) as AnimatedCharacter);
                    if (((monster.position.cellId == movement.end.cellId) && (movement.path.length)))
                    {
                        movement.end = movement.path[(movement.path.length - 1)].step;
                        movement.path.splice((movement.path.length - 1), 1);
                        for each (underling in monster.followers)
                        {
                            if (((underling.entity.position.cellId == movement.end.cellId) && (movement.path.length)))
                            {
                                movement.end = movement.path[(movement.path.length - 1)].step;
                                movement.path.splice((movement.path.length - 1), 1);
                            };
                        };
                        break;
                    };
                };
            };
            this._lastMoveEndCellId = movement.end.cellId;
            var tiphonSpr:TiphonSprite = (movedEntity as TiphonSprite);
            if (((((tiphonSpr) && (!(rpEntitiesFrame.isCreatureMode))) && (tiphonSpr.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0))) && (!(tiphonSpr.getSubEntityBehavior(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER)))))
            {
                tiphonSpr.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, new RiderBehavior());
            };
            delete rpEntitiesFrame.lastStaticAnimations[actorId];
            TooltipManager.hide(("smiley" + actorId));
            TooltipManager.hide(("msg" + actorId));
            if (movedEntity.id == PlayedCharacterManager.getInstance().id)
            {
                this._isRequestingMovement = false;
                KernelEventsManager.getInstance().processCallback(TriggerHookList.PlayerMove);
            };
            if (OptionManager.getOptionManager("dofus").getOption("allowAnimsFun") == true)
            {
                AnimFunManager.getInstance().cancelAnim(actorId);
            };
            (movedEntity as IMovable).move(movement, null, ((forceWalking) ? WalkingMovementBehavior.getInstance() : null));
        }

        internal function askMapChange():void
        {
            var cmmsg:ChangeMapMessage = new ChangeMapMessage();
            cmmsg.initChangeMapMessage(this._wantToChangeMap, this._changeMapByAutoTrip);
            ConnectionsHandler.getConnection().send(cmmsg);
            this._wantToChangeMap = -1;
            this._changeMapByAutoTrip = false;
        }

        internal function activateSkill(skillInstanceId:uint, ie:InteractiveElement, additionalParam:int):void
        {
            var iurmsg:InteractiveUseRequestMessage;
            var iuwprmsg:InteractiveUseWithParamRequestMessage;
            var rpInteractivesFrame:RoleplayInteractivesFrame = (Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame);
            if (((((rpInteractivesFrame) && (!(rpInteractivesFrame.currentRequestedElementId == ie.elementId))) && (!(rpInteractivesFrame.usingInteractive))) && (!(rpInteractivesFrame.isElementChangingState(ie.elementId)))))
            {
                rpInteractivesFrame.currentRequestedElementId = ie.elementId;
                if (additionalParam == 0)
                {
                    iurmsg = new InteractiveUseRequestMessage();
                    iurmsg.initInteractiveUseRequestMessage(ie.elementId, skillInstanceId);
                    ConnectionsHandler.getConnection().send(iurmsg);
                }
                else
                {
                    iuwprmsg = new InteractiveUseWithParamRequestMessage();
                    iuwprmsg.initInteractiveUseWithParamRequestMessage(ie.elementId, skillInstanceId, additionalParam);
                    ConnectionsHandler.getConnection().send(iuwprmsg);
                };
                this._canMove = false;
            };
        }

        internal function requestMonsterFight(monsterGroupId:int):void
        {
            var grpamrmsg:GameRolePlayAttackMonsterRequestMessage = new GameRolePlayAttackMonsterRequestMessage();
            grpamrmsg.initGameRolePlayAttackMonsterRequestMessage(monsterGroupId);
            ConnectionsHandler.getConnection().send(grpamrmsg);
        }


    }
} com.ankamagames.dofus.logic.game.roleplay.frames

