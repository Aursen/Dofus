package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.jerakine.entities.interfaces.IMovable;
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.jerakine.entities.interfaces.IAnimated;
    import com.ankamagames.jerakine.entities.interfaces.IInteractive;
    import com.ankamagames.jerakine.interfaces.IRectangle;
    import com.ankamagames.jerakine.interfaces.IObstacle;
    import com.ankamagames.jerakine.interfaces.ITransparency;
    import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.geom.ColorTransform;
    import com.ankamagames.atouin.AtouinConstants;
    import flash.geom.Matrix;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.types.data.Follower;
    import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
    import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
    import com.ankamagames.dofus.logic.game.common.behaviours.IEntityDeleteBehavior;
    import flash.display.Bitmap;
    import com.ankamagames.atouin.entities.behaviours.display.AtouinDisplayBehavior;
    import com.ankamagames.atouin.entities.behaviours.movements.WalkingMovementBehavior;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import com.ankamagames.dofus.logic.game.fight.behaviours.FightEntityDeleteBehavior;
    import com.ankamagames.dofus.logic.game.roleplay.behaviours.RoleplayEntityDeleteBehavior;
    import com.ankamagames.tiphon.events.TiphonEvent;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.jerakine.messages.MessageHandler;
    import com.ankamagames.jerakine.types.enums.InteractionsEnum;
    import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
    import com.ankamagames.dofus.types.enums.AnimationEnum;
    import com.ankamagames.jerakine.types.enums.DirectionsEnum;
    import com.ankamagames.jerakine.managers.OptionManager;
    import flash.filters.ColorMatrixFilter;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
    import com.ankamagames.jerakine.types.positions.MovementPath;
    import com.ankamagames.jerakine.types.positions.PathElement;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
    import com.ankamagames.atouin.entities.behaviours.movements.MountedMovementBehavior;
    import com.ankamagames.atouin.entities.behaviours.movements.RunningMovementBehavior;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.jerakine.map.IDataMapProvider;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.jerakine.pathfinding.Pathfinding;
    import com.ankamagames.dofus.logic.game.fight.frames.FightTurnFrame;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import flash.utils.Dictionary;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    import com.ankamagames.jerakine.utils.display.Rectangle2;
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.entities.interfaces.*;

    public class AnimatedCharacter extends TiphonSprite implements IEntity, IMovable, IDisplayable, IAnimated, IInteractive, IRectangle, IObstacle, ITransparency, ICustomUnicNameGetter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimatedCharacter));
        private static const LUMINOSITY_FACTOR:Number = 1.2;
        private static const LUMINOSITY_TRANSFORM:ColorTransform = new ColorTransform(LUMINOSITY_FACTOR, LUMINOSITY_FACTOR, LUMINOSITY_FACTOR);
        private static const NORMAL_TRANSFORM:ColorTransform = new ColorTransform();
        private static const TRANSPARENCY_TRANSFORM:ColorTransform = new ColorTransform(1, 1, 1, AtouinConstants.OVERLAY_MODE_ALPHA);
        private static const SHADOW_TRANSFORM_MATRIX:Matrix = new Matrix(0.77740478515625, -0.62744140625, -0.846054077148438, -0.531112670898438);
        private static const SHADOW_MIRROR_TRANSFORM_MATRIX:Matrix = new Matrix(-0.77740478515625, 0.62744140625, -0.846054077148438, -0.531112670898438);

        private var _id:Number;
        private var _position:MapPoint;
        private var _displayed:Boolean;
        private var _followers:Vector.<Follower>;
        private var _followed:AnimatedCharacter;
        private var _transparencyAllowed:Boolean = true;
        private var _name:String;
        private var _canSeeThrough:Boolean = false;
        private var _canWalkThrough:Boolean = false;
        private var _canWalkTo:Boolean = false;
        private var _shadow:TiphonSprite;
        protected var _movementBehavior:IMovementBehavior;
        protected var _displayBehavior:IDisplayBehavior;
        protected var _deleteBehavior:IEntityDeleteBehavior;
        private var _bmpAlpha:Bitmap;
        private var _auraEntity:TiphonSprite;
        private var _visibleAura:Boolean = true;
        private var _redrawMovementArea:Boolean = true;
        public var speedAdjust:Number = 0;
        public var slideOnNextMove:Boolean;

        public function AnimatedCharacter(nId:Number, look:TiphonEntityLook, followed:AnimatedCharacter=null, animation:String="AnimStatique", direction:uint=1)
        {
            this.id = nId;
            name = ("AnimatedCharacter" + nId);
            this._name = ("entity::" + nId);
            this._followers = new Vector.<Follower>();
            this._followed = followed;
            super(look);
            this._displayBehavior = AtouinDisplayBehavior.getInstance();
            this._movementBehavior = WalkingMovementBehavior.getInstance();
            this._deleteBehavior = ((Kernel.getWorker().getFrame(FightContextFrame) != null) ? FightEntityDeleteBehavior.getInstance() : RoleplayEntityDeleteBehavior.getInstance());
            addEventListener(TiphonEvent.RENDER_SUCCEED, this.onFirstRender);
            addEventListener(TiphonEvent.RENDER_FAILED, this.onFirstError);
            if (animation)
            {
                this.setAnimationAndDirection(animation, direction);
            };
        }

        private static function getFollowerAvailiableDirectionNumber(follower:Follower):uint
        {
            var b:Boolean;
            var avaibleDirection:Array = [];
            if ((follower.entity is TiphonSprite))
            {
                avaibleDirection = TiphonSprite(follower.entity).getAvaibleDirection();
            };
            var avaibleDirectionCount:uint;
            for each (b in avaibleDirection)
            {
                if (b)
                {
                    avaibleDirectionCount++;
                };
            };
            if (((avaibleDirection[1]) && (!(avaibleDirection[3]))))
            {
                avaibleDirectionCount++;
            };
            if (((!(avaibleDirection[1])) && (avaibleDirection[3])))
            {
                avaibleDirectionCount++;
            };
            if (((avaibleDirection[7]) && (!(avaibleDirection[5]))))
            {
                avaibleDirectionCount++;
            };
            if (((!(avaibleDirection[7])) && (avaibleDirection[5])))
            {
                avaibleDirectionCount++;
            };
            if (((!(avaibleDirection[0])) && (avaibleDirection[4])))
            {
                avaibleDirectionCount++;
            };
            if (((avaibleDirection[0]) && (!(avaibleDirection[4]))))
            {
                avaibleDirectionCount++;
            };
            return (avaibleDirectionCount);
        }

        public static function getFirstAnimatedParent(entity:TiphonSprite):AnimatedCharacter
        {
            var entityTmp:TiphonSprite = (entity as TiphonSprite);
            while (((!(entityTmp === null)) && (!(entityTmp is AnimatedCharacter))))
            {
                entityTmp = entityTmp.parentSprite;
            };
            return ((entityTmp !== null) ? (entityTmp as AnimatedCharacter) : null);
        }


        public function get id():Number
        {
            return (this._id);
        }

        public function set id(nValue:Number):void
        {
            this._id = nValue;
        }

        public function get customUnicName():String
        {
            return (this._name);
        }

        public function get position():MapPoint
        {
            return (this._position);
        }

        public function set position(oValue:MapPoint):void
        {
            var f:Follower;
            var lastPosition:MapPoint = this._position;
            this._position = oValue;
            if (!lastPosition)
            {
                for each (f in this._followers)
                {
                    if (!f.entity.position)
                    {
                        this.addFollower(f, true);
                    };
                };
            };
        }

        public function get movementBehavior():IMovementBehavior
        {
            return (this._movementBehavior);
        }

        public function set movementBehavior(oValue:IMovementBehavior):void
        {
            this._movementBehavior = oValue;
        }

        public function get followed():AnimatedCharacter
        {
            return (this._followed);
        }

        public function get displayBehaviors():IDisplayBehavior
        {
            return (this._displayBehavior);
        }

        public function set displayBehaviors(oValue:IDisplayBehavior):void
        {
            this._displayBehavior = oValue;
        }

        public function get displayed():Boolean
        {
            return (this._displayed);
        }

        public function get handler():MessageHandler
        {
            return (Kernel.getWorker());
        }

        public function get enabledInteractions():uint
        {
            return ((InteractionsEnum.CLICK | InteractionsEnum.OUT) | InteractionsEnum.OVER);
        }

        public function get isMoving():Boolean
        {
            return (this._movementBehavior.isMoving(this));
        }

        public function get absoluteBounds():IRectangle
        {
            return (this._displayBehavior.getAbsoluteBounds(this));
        }

        override public function get useHandCursor():Boolean
        {
            return (true);
        }

        public function get visibleAura():Boolean
        {
            return (this._visibleAura);
        }

        public function set visibleAura(visible:Boolean):void
        {
            if (this._visibleAura == visible)
            {
                return;
            };
            this._visibleAura = visible;
            var currentAura:TiphonSprite = (getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND, 0) as TiphonSprite);
            if (((currentAura) && (!(this.auraEntity))))
            {
                this.auraEntity = currentAura;
            };
            if (this.auraEntity)
            {
                this.auraEntity.visible = visible;
            };
        }

        public function get hasAura():Boolean
        {
            return ((!(this.auraEntity == null)) || (!(getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND, 0) == null)));
        }

        private function get auraEntity():TiphonSprite
        {
            return (this._auraEntity);
        }

        private function set auraEntity(aura:TiphonSprite):void
        {
            if (this._auraEntity == aura)
            {
                return;
            };
            if ((getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND, 0) as TiphonSprite))
            {
                this.removeSubEntity(this._auraEntity);
            };
            this._auraEntity = aura;
            this._auraEntity.visible = this.visibleAura;
            this.addSubEntity(this._auraEntity, SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND, 0);
        }

        public function getIsTransparencyAllowed():Boolean
        {
            return (this._transparencyAllowed);
        }

        public function set transparencyAllowed(allowed:Boolean):void
        {
            this._transparencyAllowed = allowed;
        }

        public function get followers():Vector.<Follower>
        {
            return (this._followers);
        }

        private function onFirstError(e:TiphonEvent):void
        {
            removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onFirstRender);
            removeEventListener(TiphonEvent.RENDER_FAILED, this.onFirstError);
            var dirList:Array = getAvaibleDirection(AnimationEnum.ANIM_STATIQUE);
            var dir:uint = DirectionsEnum.DOWN_RIGHT;
            while (dir < (DirectionsEnum.DOWN_RIGHT + 7))
            {
                if (dirList[(dir % 8)])
                {
                    this.setAnimationAndDirection(AnimationEnum.ANIM_STATIQUE, (dir % 8));
                };
                dir++;
            };
        }

        private function onFirstRender(e:TiphonEvent):void
        {
            removeEventListener(TiphonEvent.RENDER_SUCCEED, this.onFirstRender);
            removeEventListener(TiphonEvent.RENDER_FAILED, this.onFirstError);
        }

        public function initShadow(force:Boolean=false):void
        {
            var l:TiphonEntityLook;
            if (OptionManager.getOptionManager("dofus").getOption("shadowCharacter"))
            {
                if (this._shadow)
                {
                    return;
                };
                if (look.getBone() == 1)
                {
                    l = TiphonEntityLook.fromString("{1|1965,218}");
                    l.setScales((look.getScaleX() * 1.5), (look.getScaleY() * 1.5));
                }
                else
                {
                    l = look;
                };
                this._shadow = new TiphonSprite(l);
                this._shadow.filters = [new ColorMatrixFilter([0, 0, 0, 0, 20, 0, 0, 0, 0, 20, 0, 0, 0, 0, 50, 0, 0, 0, 0.2, 0])];
                addChildAt(this._shadow, 0);
                if (force)
                {
                    this.setAnimationAndDirection(getAnimation(), getDirection());
                };
            }
            else
            {
                if (!this._shadow)
                {
                    return;
                };
                this._shadow.destroy();
                this._shadow = null;
            };
        }

        override public function subEntitiesChanged(look:TiphonEntityLook):void
        {
            if (this._shadow)
            {
                this.removeSubEntity(this._shadow);
            };
            super.subEntitiesChanged(look);
            if (this._shadow)
            {
                addChildAt(this._shadow, 0);
            };
        }

        override protected function render():void
        {
            super.render();
            this.initShadow();
            this.processShadow();
        }

        private function processShadow():void
        {
            var direction:uint;
            if (((destroyed) || (!(this._shadow))))
            {
                return;
            };
            if (this._shadow)
            {
                direction = getDirection();
                this._shadow.transform.matrix = SHADOW_TRANSFORM_MATRIX;
                switch (direction)
                {
                    case 1:
                        if (hasAnimation(getAnimation(), 6))
                        {
                            direction = 6;
                        };
                        break;
                    case 2:
                        if (hasAnimation(getAnimation(), 3))
                        {
                            direction = 3;
                        };
                        break;
                    case 5:
                        if (hasAnimation(getAnimation(), 2))
                        {
                            direction = 2;
                        };
                        break;
                };
                this._shadow.setAnimationAndDirection(getAnimation(), direction);
                addChildAt(this._shadow, 0);
            };
        }

        public function canSeeThrough():Boolean
        {
            return (this._canSeeThrough);
        }

        public function setCanSeeThrough(value:Boolean):void
        {
            this._canSeeThrough = value;
        }

        public function setCanWalkThrough(value:Boolean):void
        {
            this._canWalkThrough = value;
        }

        public function canWalkThrough():Boolean
        {
            return (this._canWalkThrough);
        }

        public function setCanWalkTo(value:Boolean):void
        {
            this._canWalkTo = value;
        }

        public function canWalkTo():Boolean
        {
            return (this._canWalkTo);
        }

        public function move(path:MovementPath, callback:Function=null, movementBehavior:IMovementBehavior=null):void
        {
            var followerDirection:uint;
            var forbidenCellsId:Array;
            var follower:Follower;
            var infos:GameContextActorInformations;
            var isCreatureMode:Boolean;
            var rpContextFrame:RoleplayContextFrame;
            var ies:Vector.<InteractiveElement>;
            var ie:InteractiveElement;
            var mp:MapPoint;
            var iePos:int;
            var avaibleDirectionCount:uint;
            var endpoint:MapPoint;
            var followerPoint:MapPoint;
            var followedMovPath:MovementPath;
            var firstDrawPath:Vector.<PathElement>;
            var followerPath:MovementPath;
            var i:uint;
            var storedMovementPath:MovementPath;
            var pElem:PathElement;
            var lastElement:PathElement;
            if (!path.start.equals(this.position))
            {
                _log.warn((((((("Unsynchronized position for entity " + this.id) + ", jumping from ") + this.position) + " to ") + path.start) + "."));
                this.jump(path.start);
            };
            var distance:uint = (path.path.length + 1);
            this._movementBehavior = movementBehavior;
            if (!this._movementBehavior)
            {
                if (Kernel.getWorker().contains(RoleplayEntitiesFrame))
                {
                    infos = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).getEntityInfos(this.id);
                    if ((infos is GameRolePlayHumanoidInformations))
                    {
                        if ((infos as GameRolePlayHumanoidInformations).humanoidInfo.restrictions.cantRun)
                        {
                            this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
                        };
                    }
                    else
                    {
                        if ((infos is GameRolePlayGroupMonsterInformations))
                        {
                            this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
                        };
                    };
                };
                if (!this._movementBehavior)
                {
                    if (distance > 3)
                    {
                        isCreatureMode = false;
                        if (Kernel.getWorker().contains(RoleplayEntitiesFrame))
                        {
                            isCreatureMode = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).isCreatureMode;
                        };
                        if (((!(isCreatureMode)) && (this.isMounted())))
                        {
                            this._movementBehavior = MountedMovementBehavior.getInstance();
                        }
                        else
                        {
                            this._movementBehavior = RunningMovementBehavior.getInstance(this.speedAdjust);
                        };
                    }
                    else
                    {
                        if (distance > 0)
                        {
                            this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
                        }
                        else
                        {
                            return;
                        };
                    };
                };
            };
            var mapData:IDataMapProvider = DataMapProvider.getInstance();
            if (this._followers.length > 0)
            {
                forbidenCellsId = [];
                rpContextFrame = (Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame);
                if (rpContextFrame != null)
                {
                    ies = rpContextFrame.entitiesFrame.interactiveElements;
                    for each (ie in ies)
                    {
                        if (ie)
                        {
                            mp = Atouin.getInstance().getIdentifiedElementPosition(ie.elementId);
                            if (mp)
                            {
                                iePos = mp.cellId;
                                forbidenCellsId.push(iePos);
                            };
                        };
                    };
                };
            };
            var followersMovPath:Vector.<MovementPath> = new Vector.<MovementPath>();
            for each (follower in this._followers)
            {
                avaibleDirectionCount = getFollowerAvailiableDirectionNumber(follower);
                endpoint = path.end;
                forbidenCellsId.push(endpoint.cellId);
                if (((!(follower.type == Follower.TYPE_MONSTER)) && ((((!(avaibleDirectionCount)) < 8) && (!(this._followers.indexOf(follower) == 0))) && (followersMovPath.length > 0))))
                {
                    endpoint = followersMovPath[(followersMovPath.length - 1)].end;
                };
                followerDirection = endpoint.advancedOrientationTo(this.position);
                followerPoint = endpoint.getNearestFreeCellInDirection(followerDirection, mapData, false, true, true, forbidenCellsId);
                if (followerPoint)
                {
                    if (((!(avaibleDirectionCount < 8)) && (!(follower.type == Follower.TYPE_MONSTER))))
                    {
                        followerPath = new MovementPath();
                        if (((this._followers.indexOf(follower) == 0) || (followersMovPath.length <= 0)))
                        {
                            followedMovPath = path;
                            firstDrawPath = followedMovPath.path.concat();
                            followerPath.end = followerPoint;
                            if (firstDrawPath.length > 0)
                            {
                                firstDrawPath = firstDrawPath.concat(Pathfinding.findPath(mapData, firstDrawPath[(firstDrawPath.length - 1)].step, followerPoint).path);
                            }
                            else
                            {
                                firstDrawPath = firstDrawPath.concat(Pathfinding.findPath(mapData, path.start, followerPoint).path);
                            };
                        }
                        else
                        {
                            followedMovPath = followersMovPath[(followersMovPath.length - 1)];
                            firstDrawPath = followedMovPath.path.concat();
                            if (followedMovPath.length > 0)
                            {
                                followerPath.end = followedMovPath.getPointAtIndex((followedMovPath.length - 1)).step;
                            }
                            else
                            {
                                followerPath.end = followedMovPath.start;
                            };
                        };
                        if (forbidenCellsId.indexOf(followerPath.end) != -1)
                        {
                            followerPath.end = followerPath.end.getNearestFreeCellInDirection(followerDirection, mapData, false, false, true, forbidenCellsId);
                        };
                        forbidenCellsId.push(followerPath.end.cellId);
                        followerPath.start = follower.entity.position;
                        if (firstDrawPath.length > 0)
                        {
                            followerPath.addPoint(new PathElement(follower.entity.position, follower.entity.position.orientationTo(firstDrawPath[0].step)));
                        }
                        else
                        {
                            followerPath.addPoint(new PathElement(follower.entity.position, follower.entity.position.orientationTo(path.start)));
                        };
                        i = 0;
                        while (i < (firstDrawPath.length - 1))
                        {
                            pElem = new PathElement();
                            pElem.step.x = firstDrawPath[i].step.x;
                            pElem.step.y = firstDrawPath[i].step.y;
                            pElem.orientation = firstDrawPath[i].step.orientationTo(firstDrawPath[(i + 1)].step);
                            followerPath.addPoint(pElem);
                            i++;
                        };
                        storedMovementPath = new MovementPath();
                        storedMovementPath.path = followerPath.path.concat();
                        storedMovementPath.end = followerPath.end;
                        storedMovementPath.start = followerPath.start;
                        followersMovPath.push(storedMovementPath);
                        if (this._followers.indexOf(follower) == 0)
                        {
                            lastElement = followerPath.getPointAtIndex((followerPath.length - 1));
                            lastElement.orientation = followerPath.getPointAtIndex((followerPath.length - 1)).step.orientationTo(followerPoint);
                        };
                        this.processMove(followerPath, follower.entity, followerPoint);
                    }
                    else
                    {
                        if (forbidenCellsId.indexOf(followerPoint.cellId) == -1)
                        {
                            forbidenCellsId.push(followerPoint.cellId);
                        };
                        this.processMove(Pathfinding.findPath(mapData, follower.entity.position, followerPoint, (!(avaibleDirectionCount < 8)), true), follower.entity, followerPoint);
                    };
                }
                else
                {
                    _log.warn("Unable to get a proper destination for the follower.");
                };
            };
            this._movementBehavior.move(this, path, callback);
        }

        private function processMove(followPath:MovementPath, follower:IMovable, followerPoint:MapPoint):void
        {
            if (((followPath) && (followPath.path.length > 0)))
            {
                follower.movementBehavior = this._movementBehavior;
                follower.move(followPath, null, this._movementBehavior);
            }
            else
            {
                _log.warn((((("There was no path from " + follower.position) + " to ") + followerPoint) + " for a follower. Jumping !"));
                follower.jump(followerPoint);
            };
        }

        public function jump(newPosition:MapPoint):void
        {
            var fol:Follower;
            var mdp:IDataMapProvider;
            var mp:MapPoint;
            this._movementBehavior.jump(this, newPosition);
            for each (fol in this._followers)
            {
                mdp = DataMapProvider.getInstance();
                mp = this.position.getNearestFreeCell(mdp, false);
                if (!mp)
                {
                    mp = this.position.getNearestFreeCell(mdp, true);
                    if (!mp)
                    {
                        return;
                    };
                };
                fol.entity.jump(mp);
            };
        }

        public function stop(forceStop:Boolean=false):void
        {
            var fol:Follower;
            this._movementBehavior.stop(this, forceStop);
            for each (fol in this._followers)
            {
                fol.entity.stop(forceStop);
            };
        }

        public function display(strata:uint=10):void
        {
            var f:Follower;
            this._displayBehavior.display(this, strata);
            this._displayed = true;
            for each (f in this._followers)
            {
                if (((f.entity is IDisplayable) && (!(IDisplayable(f.entity).displayed))))
                {
                    IDisplayable(f.entity).display();
                };
            };
        }

        public function hide(redrawMovement:Boolean=true):void
        {
            this.alpha = 0;
            this._displayed = false;
            this.hideAllFollowers();
            if (redrawMovement)
            {
                this._displayBehavior.remove(this);
                this._deleteBehavior.entityDeleted(this);
            };
        }

        public function show(redrawMovement:Boolean=true):void
        {
            this.alpha = 1;
            this._displayed = true;
            this.showAllFollowers();
            if (redrawMovement)
            {
                this._displayBehavior.display(this);
            };
        }

        public function remove():void
        {
            var fightTurnFrame:FightTurnFrame;
            var fef:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            if (((fef) && (fef.justSwitchingCreaturesFightMode)))
            {
                this.dispatchEvent(new TiphonEvent(TiphonEvent.ANIMATION_DESTROY, this));
            };
            this.removeAllFollowers();
            this._displayed = false;
            this._movementBehavior.stop(this, true);
            this._displayBehavior.remove(this);
            this._deleteBehavior.entityDeleted(this);
            this._auraEntity = null;
            clearAnimation();
            if (Kernel.getWorker().terminating)
            {
                return;
            };
            if (this._redrawMovementArea)
            {
                fightTurnFrame = (Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame);
                if (((fightTurnFrame) && (fightTurnFrame.myTurn)))
                {
                    fightTurnFrame.drawMovementArea();
                };
            };
        }

        override public function destroy():void
        {
            this._followed = null;
            this.remove();
            super.destroy();
        }

        public function quickDestroy():void
        {
            this._redrawMovementArea = false;
            this.destroy();
        }

        public function getRootEntity():AnimatedCharacter
        {
            if (this._followed)
            {
                return (this._followed.getRootEntity());
            };
            return (this);
        }

        public function removeAllFollowers():void
        {
            var iFollower:Follower;
            var dfollower:IDisplayable;
            var sprite:TiphonSprite;
            for each (iFollower in this._followers)
            {
                dfollower = (iFollower.entity as IDisplayable);
                if (dfollower)
                {
                    dfollower.remove();
                };
                sprite = (iFollower.entity as TiphonSprite);
                if (sprite)
                {
                    sprite.destroy();
                };
            };
            this._followers = new Vector.<Follower>();
        }

        public function hideAllFollowers():void
        {
            var iFollower:Follower;
            var sprite:TiphonSprite;
            for each (iFollower in this._followers)
            {
                sprite = (iFollower.entity as TiphonSprite);
                if (sprite)
                {
                    sprite.alpha = 0;
                };
            };
        }

        public function showAllFollowers():void
        {
            var iFollower:Follower;
            var sprite:TiphonSprite;
            for each (iFollower in this._followers)
            {
                sprite = (iFollower.entity as TiphonSprite);
                if (sprite)
                {
                    sprite.alpha = 1;
                };
            };
        }

        public function removeFollower(follower:Follower):void
        {
            var dfollower:IDisplayable;
            var sprite:TiphonSprite;
            var index:int = this._followers.indexOf(follower);
            if (index != -1)
            {
                dfollower = (follower.entity as IDisplayable);
                if (dfollower)
                {
                    dfollower.remove();
                };
                sprite = (follower.entity as TiphonSprite);
                if (sprite)
                {
                    sprite.destroy();
                };
                this._followers.splice(index, 1);
            };
        }

        public function addFollower(follower:Follower, instantSync:Boolean=false):void
        {
            var followerIndex:int;
            var f:Follower;
            var avaibleDirectionCount:uint;
            var dfollower:IDisplayable;
            var found:Boolean;
            for each (f in this._followers)
            {
                if (f.entity.id == follower.entity.id)
                {
                    found = true;
                    break;
                };
            };
            if (!found)
            {
                if (follower.type == Follower.TYPE_PET)
                {
                    this._followers.unshift(follower);
                }
                else
                {
                    avaibleDirectionCount = getFollowerAvailiableDirectionNumber(follower);
                    if (((avaibleDirectionCount < 8) || (follower.type == Follower.TYPE_MONSTER)))
                    {
                        this._followers.push(follower);
                    }
                    else
                    {
                        if (((this._followers.length == 0) || (!(this._followers[0].type == Follower.TYPE_PET))))
                        {
                            followerIndex = 0;
                        };
                        this._followers.splice(followerIndex, 0, follower);
                    };
                };
            };
            if (!this.position)
            {
                return;
            };
            var mdp:IDataMapProvider = DataMapProvider.getInstance();
            var mp:MapPoint = this.position.getNearestFreeCell(mdp, false);
            if (!mp)
            {
                mp = this.position.getNearestFreeCell(mdp, true);
                if (!mp)
                {
                    return;
                };
            };
            if (follower.entity.position == null)
            {
                follower.entity.position = mp;
            };
            if ((follower.entity is IDisplayable))
            {
                dfollower = (follower.entity as IDisplayable);
                if (((this._displayed) && (!(dfollower.displayed))))
                {
                    dfollower.display();
                }
                else
                {
                    if (((!(this._displayed)) && (dfollower.displayed)))
                    {
                        dfollower.remove();
                    };
                };
            };
            if (mp.equals(follower.entity.position))
            {
                return;
            };
            if (instantSync)
            {
                follower.entity.jump(mp);
            }
            else
            {
                follower.entity.move(Pathfinding.findPath(mdp, follower.entity.position, mp, false, false));
            };
        }

        public function followersEqual(pEntityLooks:Vector.<EntityLook>):Boolean
        {
            var i:int;
            var ac:Follower;
            if (!pEntityLooks)
            {
                return (false);
            };
            var nbLooks:int = pEntityLooks.length;
            var nbEqual:int;
            if (this._followers.length != nbLooks)
            {
                return (false);
            };
            for each (ac in this._followers)
            {
                i = 0;
                while (i < nbLooks)
                {
                    if ((ac.entity as AnimatedCharacter).look.equals(EntityLookAdapter.fromNetwork(pEntityLooks[i])))
                    {
                        nbEqual++;
                        break;
                    };
                    i++;
                };
            };
            if (nbEqual != nbLooks)
            {
                return (false);
            };
            return (true);
        }

        public function isMounted():Boolean
        {
            var subEntities:Dictionary = this.look.getSubEntities(true);
            if (!subEntities)
            {
                return (false);
            };
            var mountedEntities:Array = subEntities[SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER];
            return ((mountedEntities) && (mountedEntities.length > 0));
        }

        public function highLightCharacterAndFollower(value:Boolean):void
        {
            var entity:AnimatedCharacter;
            var rootEntity:AnimatedCharacter = this.getRootEntity();
            var num:int = rootEntity._followers.length;
            var i:int = -1;
            while (++i < num)
            {
                entity = (rootEntity._followers[i].entity as AnimatedCharacter);
                if (entity)
                {
                    entity.highLight(value);
                };
            };
            this.highLight(value);
        }

        public function highLight(value:Boolean):void
        {
            if (value)
            {
                transform.colorTransform = LUMINOSITY_TRANSFORM;
            }
            else
            {
                if (Atouin.getInstance().options.getOption("transparentOverlayMode"))
                {
                    transform.colorTransform = TRANSPARENCY_TRANSFORM;
                }
                else
                {
                    transform.colorTransform = NORMAL_TRANSFORM;
                };
            };
        }

        public function showBitmapAlpha(alphaValue:Number):void
        {
            var bmpdt:BitmapData;
            var newCellSprite:Sprite;
            if (this._bmpAlpha == null)
            {
                bmpdt = new BitmapData(width, height, true, 0xFF0000);
                bmpdt.draw(this.bitmapData);
                this._bmpAlpha = new Bitmap(bmpdt);
                this._bmpAlpha.alpha = alphaValue;
                newCellSprite = InteractiveCellManager.getInstance().getCell(this.position.cellId);
                this._bmpAlpha.x = ((newCellSprite.x + (newCellSprite.width / 2)) - (this.width / 2));
                this._bmpAlpha.y = ((newCellSprite.y + newCellSprite.height) - this.height);
                this.parent.addChild(this._bmpAlpha);
                visible = false;
            };
        }

        public function hideBitmapAlpha():void
        {
            visible = true;
            if (((!(this._bmpAlpha == null)) && (StageShareManager.stage.contains(this._bmpAlpha))))
            {
                this.parent.removeChild(this._bmpAlpha);
                this._bmpAlpha = null;
            };
        }

        override public function addSubEntity(entity:DisplayObject, category:uint, slot:uint):void
        {
            if (((((category == SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND) && (slot == 0)) && (!(this._visibleAura))) && (!(this.auraEntity))))
            {
                this.auraEntity = (entity as TiphonSprite);
            }
            else
            {
                super.addSubEntity(entity, category, slot);
            };
        }

        override public function removeSubEntity(entity:DisplayObject):void
        {
            super.removeSubEntity(entity);
        }

        override public function setAnimationAndDirection(animation:String, direction:uint, pDisableAnimModifier:Boolean=false):void
        {
            super.setAnimationAndDirection(animation, direction, pDisableAnimModifier);
            if (this._shadow)
            {
                this.processShadow();
            };
        }

        public function getCreatureBounds():IRectangle
        {
            var minX:Number;
            var minY:Number;
            var maxX:Number;
            var maxY:Number;
            var index:uint;
            var child:DisplayObject;
            var childName:String;
            var childBounds:Rectangle;
            var currentChildMaxX:Number;
            var currentChildMaxY:Number;
            var fightEntitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            if (((fightEntitiesFrame === null) || (!(fightEntitiesFrame.isInCreaturesFightMode()))))
            {
                return (null);
            };
            var targetBounds:IRectangle = new Rectangle2();
            minX = (minY = Infinity);
            maxX = (maxY = -(Infinity));
            if (((!(_animMovieClip === null)) && (numChildren > 0)))
            {
                index = 0;
                while (index < _animMovieClip.numChildren)
                {
                    child = _animMovieClip.getChildAt(index);
                    childName = getQualifiedClassName(child);
                    if (((child === null) || (!(childName.indexOf("carried") === -1))))
                    {
                    }
                    else
                    {
                        childBounds = child.getBounds(StageShareManager.stage);
                        if (((childBounds.width <= 0) || (childBounds.height <= 0)))
                        {
                        }
                        else
                        {
                            currentChildMaxX = (childBounds.x + childBounds.width);
                            currentChildMaxY = (childBounds.y + childBounds.height);
                            if (minX > childBounds.x)
                            {
                                minX = childBounds.x;
                            };
                            if (minY > childBounds.y)
                            {
                                minY = childBounds.y;
                            };
                            if (maxX < currentChildMaxX)
                            {
                                maxX = currentChildMaxX;
                            };
                            if (maxY < currentChildMaxY)
                            {
                                maxY = currentChildMaxY;
                            };
                        };
                    };
                    index++;
                };
                targetBounds.x = minX;
                targetBounds.y = minY;
                targetBounds.width = (maxX - minX);
                targetBounds.height = (maxY - minY);
                return (targetBounds);
            };
            return (null);
        }


    }
} com.ankamagames.dofus.types.entities

