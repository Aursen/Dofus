package damageCalculation.damageManagement
{
    import mapTools.MapDirection;
    import mapTools.MapTools;
    import damageCalculation.FightContext;
    import damageCalculation.fighterManagement.HaxeFighter;
    import damageCalculation.spellManagement.RunningEffect;
    import damageCalculation.DamageCalculator;
    import damageCalculation.spellManagement.Mark;
    import damageCalculation.fighterManagement.PlayerTypeEnum;
    import damageCalculation.spellManagement.HaxeSpellEffect;

    public class PushUtils 
    {

        public static var ALLOW_MARK_PREVIEW:Boolean = true;

        public function PushUtils():void
        {
        }

        public static function getPullDirection(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean=true):int
        {
            var _local_5:int = PushUtils.getPushDirection(_arg_1, _arg_2, _arg_3, _arg_4);
            if (_local_5 == -1)
            {
                return (_local_5);
            };
            return (MapDirection.getOppositeDirection(_local_5));
        }

        public static function getPushDirection(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean=true):int
        {
            var _local_6:int;
            if (((_arg_3 == (_arg_2)) && ((_arg_3 == (_arg_1)) || (!(_arg_4)))))
            {
                return (-1);
            };
            var _local_5:int = ((_arg_2 == _arg_3) ? _arg_1 : _arg_2);
            if (MapTools.isInDiag(_local_5, _arg_3))
            {
                _local_6 = MapTools.getLookDirection4DiagExact(_local_5, _arg_3);
            }
            else
            {
                _local_6 = MapTools.getLookDirection4(_local_5, _arg_3);
            };
            return (_local_6);
        }

        public static function getCollisionDamages(_arg_1:FightContext, _arg_2:HaxeFighter, _arg_3:HaxeFighter, _arg_4:int, _arg_5:int):DamageRange
        {
            var _local_6:int;
            if (((_arg_2.data.isSummon()) && (!(_arg_2.data.getSummonerId() == 0))))
            {
                _local_6 = _arg_2.getSummoner(_arg_1).level;
            }
            else
            {
                _local_6 = _arg_2.level;
            };
            var _local_7:int = _arg_2.getCharacteristicValue("pushDamageBonus");
            var _local_8:int = _arg_3.getCharacteristicValue("pushDamageFixedResist");
            _local_7 = (_local_7 - _local_8);
            var _local_9:int = int(((_arg_4 * ((int(Math.floor((_local_6 / 2))) + 32) + _local_7)) / (4 * Math.pow(2, _arg_5))));
            var _local_10:DamageRange = new DamageRange(_local_9, _local_9);
            _local_10.minimizeBy(0);
            _local_10.isCollision = true;
            if (_arg_2.hasStateEffect(6))
            {
                _local_10.setToZero();
            };
            return (_local_10);
        }

        public static function pull(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:int, _arg_5:Boolean, _arg_6:Boolean):Array
        {
            var _local_8:* = (null as HaxeFighter);
            var _local_7:HaxeFighter = _arg_2.getCaster();
            if (_arg_2.getSpellEffect().actionId == 1042)
            {
                _local_8 = _local_7;
                _local_7 = _arg_3;
                _arg_3 = _local_8;
            };
            var _local_9:int = _local_7.getCurrentPositionCell();
            if (_arg_1.usingPortal())
            {
                _local_9 = _arg_1.map.getOutputPortalCell(_arg_1.inputPortalCellId);
            };
            var _local_10:int = ((_arg_1.inMovement) ? _arg_3.getCurrentPositionCell() : _arg_3.getBeforeLastSpellPosition());
            var _local_11:int = PushUtils.getPullDirection(_local_9, _arg_1.targetedCell, _local_10, (!(_arg_1.inMovement)));
            return (PushUtils.drag(_arg_1, _arg_2, _arg_3, _arg_4, _local_11, _arg_5, false, _arg_6, true));
        }

        public static function push(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:int, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean):Array
        {
            var _local_10:* = (null as HaxeFighter);
            var _local_8:HaxeFighter = _arg_2.getCaster();
            var _local_9:int = _local_8.getBeforeLastSpellPosition();
            if (_arg_1.usingPortal())
            {
                _local_9 = _arg_1.map.getOutputPortalCell(_arg_1.inputPortalCellId);
            };
            if (_arg_2.getSpellEffect().actionId == 1041)
            {
                _local_10 = _local_8;
                _local_8 = _arg_3;
                _arg_3 = _local_10;
            };
            var _local_11:int = ((_arg_1.inMovement) ? _arg_3.getCurrentPositionCell() : _arg_3.getBeforeLastSpellPosition());
            var _local_12:int = PushUtils.getPushDirection(_local_9, _arg_1.targetedCell, _local_11, (!(_arg_1.inMovement)));
            return (PushUtils.drag(_arg_1, _arg_2, _arg_3, _arg_4, _local_12, _arg_5, _arg_6, _arg_7, false));
        }

        public static function pullTo(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:Boolean, _arg_5:Boolean):Array
        {
            var _local_6:int = MapTools.getDistance(_arg_1.targetedCell, _arg_3.getBeforeLastSpellPosition());
            var _local_7:FightContext = _arg_1.copy();
            _local_7.targetedCell = _arg_2.getCaster().getBeforeLastSpellPosition();
            return (PushUtils.pull(_local_7, _arg_2, _arg_3, _local_6, _arg_4, _arg_5));
        }

        public static function pushTo(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean):Array
        {
            var _local_7:int = MapTools.getDistance(_arg_1.targetedCell, _arg_3.getBeforeLastSpellPosition());
            var _local_8:FightContext = _arg_1.copy();
            _local_8.targetedCell = _arg_2.getCaster().getBeforeLastSpellPosition();
            return (PushUtils.push(_local_8, _arg_2, _arg_3, _local_7, _arg_4, _arg_5, _arg_6));
        }

        public static function drag(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:int, _arg_5:int, _arg_6:Boolean, _arg_7:Boolean, _arg_8:Boolean, _arg_9:Boolean):Array
        {
            var _local_10:* = null;
            var _local_11:Boolean;
            var _local_15:* = (null as HaxeFighter);
            var _local_16:* = (null as FightContext);
            var _local_17:* = (null as EffectOutput);
            if ((((_arg_6) && (!(((_arg_3.hasStateEffect(3)) && (_arg_3.data.canBreedBePushed())) && (!(_arg_3.hasStateEffect(0)))))) || (_arg_5 == -1)))
            {
                return ([]);
            };
            if (MapDirection.isCardinal(_arg_5))
            {
                _arg_4 = int(Math.ceil((_arg_4 / 2)));
            };
            var _local_12:Boolean;
            var _local_13:Boolean;
            var _local_14:Array = [];
            while (true)
            {
                _local_10 = PushUtils.getDragCellDest(_arg_1, _arg_3, _arg_5, _arg_4);
                if (_local_10.cell != _arg_3.getCurrentPositionCell())
                {
                    _local_12 = true;
                    _local_13 = (_local_10.stopReason == DragResultEnum.PORTAL);
                    _local_15 = _arg_3.getCarried(_arg_1);
                    if (_local_15 != null)
                    {
                        _local_16 = _arg_1.copy();
                        _local_16.targetedCell = _arg_3.getCurrentPositionCell();
                        _local_14 = _local_14.concat(Teleport.throwFighter(_arg_1, _arg_3, _arg_2, _arg_8));
                    };
                };
                _local_11 = PushUtils.applyDrag(_arg_1, _arg_2, _arg_3, _local_10.cell, _arg_8);
                _arg_4 = _local_10.remainingForce;
                if (!(((_local_11) && (_local_10.stopReason == DragResultEnum.PORTAL)) && (_arg_4 > 0))) break;
            };
            if (_local_12)
            {
                _local_17 = new EffectOutput(_arg_3.id);
                _local_17.movement = new MovementInfos(_local_10.cell, -1);
                _local_17.throughPortal = _local_13;
                if (_arg_9)
                {
                    _local_17.isPulled = true;
                }
                else
                {
                    _local_17.isPushed = true;
                };
                _local_14.push(_local_17);
            };
            if (_arg_7)
            {
                PushUtils.applyCollisionDamages(_arg_1, _arg_2, _arg_3, _local_10, _arg_5, _arg_8);
            };
            if (_local_12)
            {
                DamageCalculator.executeMarks(_arg_1, _arg_2, _arg_3, _local_10.cell, _arg_8);
            };
            return (_local_14);
        }

        public static function getDragCellDest(_arg_1:FightContext, _arg_2:HaxeFighter, _arg_3:int, _arg_4:int):Object
        {
            var _local_6:int;
            var _local_9:int;
            var _local_10:* = (null as Array);
            var _local_11:Boolean;
            var _local_12:Boolean;
            var _local_13:int;
            var _local_14:* = (null as Mark);
            var _local_15:* = (null as DragResultEnum);
            var _local_5:int = _arg_2.getCurrentPositionCell();
            var _local_7:int;
            var _local_8:int = _arg_4;
            while (_local_7 < _local_8)
            {
                _local_9 = _local_7++;
                _local_6 = _local_5;
                _local_5 = MapTools.getNextCellByDirection(_local_5, _arg_3);
                if (PushUtils.isPathBlocked(_arg_1, _local_6, _local_5, _arg_3))
                {
                    return ({
                        "remainingForce":(_arg_4 - _local_9),
                        "cell":_local_6,
                        "stopReason":DragResultEnum.COLLISION
                    });
                };
                _local_10 = _arg_1.map.getMarkInteractingWithCell(_local_5);
                _local_11 = false;
                _local_12 = false;
                if (_local_10 != null)
                {
                    _local_13 = 0;
                    while (_local_13 < _local_10.length)
                    {
                        _local_14 = _local_10[_local_13];
                        _local_13++;
                        if (_local_14.markType != 0)
                        {
                            if (((_local_11) && ((_local_14.stopDrag()) || (_local_14.markType == 4))))
                            {
                                _local_11 = true;
                            };
                            if ((((_local_12) && (!(_local_14.markType == 4))) && (_local_14.stopDrag())))
                            {
                                _local_12 = true;
                            };
                            if (((_local_11) && (_local_12))) break;
                        };
                    };
                };
                if (_local_11)
                {
                    _local_15 = ((_local_12) ? DragResultEnum.ACTIVE_OBJECT : DragResultEnum.PORTAL);
                    return ({
                        "remainingForce":((_arg_4 - _local_9) - 1),
                        "cell":_local_5,
                        "stopReason":_local_15
                    });
                };
            };
            return ({
                "remainingForce":0,
                "cell":_local_5,
                "stopReason":DragResultEnum.COMPLETE
            });
        }

        public static function applyDrag(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:int, _arg_5:Boolean):Boolean
        {
            var _local_6:* = (null as Array);
            var _local_7:int;
            var _local_8:int;
            if (_arg_4 == _arg_3.getCurrentPositionCell())
            {
                return (false);
            };
            if (!_arg_5)
            {
                _local_6 = MapTools.getCellsIdOnLargeWay(_arg_3.getCurrentPositionCell(), _arg_4);
                if (_local_6 != null)
                {
                    _local_7 = 0;
                    while (_local_7 < _local_6.length)
                    {
                        _local_8 = _local_6[_local_7];
                        _local_7++;
                        _arg_1.map.dispellIllusionOnCell(_local_8);
                    };
                };
            };
            _arg_3.setCurrentPositionCell(_arg_4);
            if (((_arg_3.data.canBreedUsePortals()) && (!(_arg_3.hasStateEffect(17)))))
            {
                _local_6 = _arg_1.map.getMarkInteractingWithCell(_arg_4, 4);
                if (((_local_6.length > (0)) && ((_local_6[0].teamId == _arg_3.teamId) || (!(_arg_1.gameTurn == 1)))))
                {
                    _local_7 = _arg_1.map.getOutputPortalCell(_arg_4);
                    if (MapTools.isValidCellId(_local_7))
                    {
                        _arg_3.setCurrentPositionCell(_local_7);
                    };
                };
            };
            return (true);
        }

        public static function applyCollisionDamages(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:Object, _arg_5:int, _arg_6:Boolean):void
        {
            var _local_11:* = (null as HaxeFighter);
            if (((((!(_arg_3.isAlive())) || (_arg_4.remainingForce <= 0)) || (_arg_2.getCaster() == null)) || (_arg_4.stopReason == DragResultEnum.ACTIVE_OBJECT)))
            {
                return;
            };
            if (MapDirection.isCardinal(_arg_5))
            {
                _arg_4.remainingForce = (_arg_4.remainingForce * 2);
            };
            var _local_7:HaxeFighter = _arg_2.getCaster();
            if (((((_local_7.playerType == (PlayerTypeEnum.MONSTER)) && (_local_7.data.isSummon())) && (!(HaxeFighter.BOMB_BREED_ID.indexOf(_local_7.breed) == -1))) || (((_local_7.playerType == (PlayerTypeEnum.MONSTER)) && (_local_7.data.isSummon())) && (!(HaxeFighter.STEAMER_TURRET_BREED_ID.indexOf(_local_7.breed) == -1)))))
            {
                _local_7 = _local_7.getSummoner(_arg_1);
            };
            PushUtils.applyCollisionDamagesOnTarget(_arg_1, _arg_2, _arg_3, _arg_4.remainingForce, 0, _arg_6);
            var _local_8:Array = PushUtils.getCollateralTargets(_arg_1, _arg_4.cell, _arg_5, _arg_4.remainingForce);
            var _local_9:int = 1;
            var _local_10:int;
            while (_local_10 < _local_8.length)
            {
                _local_11 = _local_8[_local_10];
                _local_10++;
                PushUtils.applyCollisionDamagesOnTarget(_arg_1, _arg_2, _local_11, _arg_4.remainingForce, _local_9, _arg_6);
                _local_9++;
            };
        }

        public static function applyCollisionDamagesOnTarget(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:int, _arg_5:int, _arg_6:Boolean):void
        {
            var _local_7:HaxeSpellEffect = new HaxeSpellEffect(_arg_2.getSpellEffect().id, 1, 0, 80, _arg_4, _arg_5, 0, 0, _arg_2.getSpellEffect().isCritical, "I", "P", "a,A", 0, 0, true, 0, 2);
            var _local_8:RunningEffect = _arg_2.copy();
            _local_8.overrideSpellEffect(_local_7);
            DamageCalculator.computeEffect(_arg_1, _local_8, _arg_6, [_arg_3], null);
        }

        public static function getCollateralTargets(_arg_1:FightContext, _arg_2:int, _arg_3:int, _arg_4:int):Array
        {
            var _local_5:Array = [];
            _arg_2 = MapTools.getNextCellByDirection(_arg_2, _arg_3);
            var _local_6:HaxeFighter = _arg_1.getFighterFromCell(_arg_2, true);
            while ((((_arg_4 > (0)) && (!(_local_6 == null))) && (_local_6.isAlive())))
            {
                _local_5.push(_local_6);
                _arg_2 = MapTools.getNextCellByDirection(_arg_2, _arg_3);
                _local_6 = _arg_1.getFighterFromCell(_arg_2);
                _arg_4--;
            };
            return (_local_5);
        }

        public static function isPathBlocked(_arg_1:FightContext, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            if (((_arg_1.isCellEmptyForMovement(_arg_3)) && (MapTools.adjacentCellsAllowAccess(_arg_1, _arg_2, _arg_4))))
            {
                return (false);
            };
            return (true);
        }


    }
} damageCalculation.damageManagement

