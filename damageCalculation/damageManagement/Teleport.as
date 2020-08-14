package damageCalculation.damageManagement
{
    import damageCalculation.fighterManagement.HaxeFighter;
    import tools.ActionIdHelper;
    import mapTools.MapTools;
    import damageCalculation.DamageCalculator;
    import damageCalculation.FightContext;
    import damageCalculation.spellManagement.RunningEffect;
    import mapTools.Point;
    import mapTools.SpellZone;
    import haxe.ds.ArraySort;
    import damageCalculation.spellManagement.HaxeSpellEffect;
    import damageCalculation.fighterManagement.HaxeBuff;

    public class Teleport 
    {

        public static var SAME_DIRECTION:int = -1;
        public static var OPPOSITE_DIRECTION:int = -2;

        public function Teleport():void
        {
        }

        public static function teleportFighter(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:Boolean):Array
        {
            var _local_6:* = (null as HaxeFighter);
            var _local_7:int;
            var _local_9:Boolean;
            var _local_11:* = (null as HaxeFighter);
            var _local_12:Boolean;
            var _local_13:int;
            var _local_5:Array = [];
            var _local_8:int = _arg_2.getSpellEffect().actionId;
            var _local_10:int = _local_8;
            if( (_local_10 == 4) || (_local_10 == 1104) )
            {
                _local_6 = _arg_2.getCaster();
                goto _label_1;
            };
            _local_9 = ActionIdHelper.isExchange(_local_8);
            if (_local_9 == true)
            {
                _local_6 = _arg_2.getCaster();
            }
            else
            {
                _local_6 = _arg_3;
            };
            
        _label_1: 
            _local_10 = _local_8;
            if( (_local_10 == 1099) || (_local_10 == 1100) )
            {
                _local_7 = -1;
                goto _label_2;
            };
            if( (_local_10 == 4) || (_local_10 == 1104) )
            {
                _local_7 = MapTools.getLookDirection4(_arg_2.getCaster().getCurrentPositionCell(), _arg_1.targetedCell);
                goto _label_2;
            };
            _local_9 = ActionIdHelper.isExchange(_local_8);
            _local_7 = ((_local_9 == true) ? -1 : -2);
            
        _label_2: 
            _local_10 = Teleport.getTeleportedPosition(_arg_1, _arg_2, _local_6, _arg_1.targetedCell);
            if (((_local_10 == (_local_6.getCurrentPositionCell())) && (ActionIdHelper.isExchange(_local_8))))
            {
                _local_10 = _arg_3.getCurrentPositionCell();
            };
            if (_local_10 != _local_6.getCurrentPositionCell())
            {
                _local_11 = null;
                if (_arg_1.map.isCellWalkable(_local_10))
                {
                    _local_11 = _arg_1.getFighterFromCell(_local_10, true);
                    if (((_local_11 != (null)) && (_local_11.isAlive())))
                    {
                        if (_local_8 != 1023)
                        {
                            _local_13 = -1;
                            _local_12 = ((((((_local_11.hasStateEffect(3)) && (!((_local_11.hasStateEffect(18)) && ((((((_local_13 == (1104)) || (_local_13 == 1105)) || (_local_13 == 1106)) || (_local_13 == 784)) || (_local_13 == 1099)) || (_local_13 == 1100))))) && (!(_local_11.hasState(3)))) && ((_local_11.data.canBreedSwitchPos()) || (ActionIdHelper.canTeleportOverBreedSwitchPos(_local_13)))) && (!(_local_11.hasState(8)))) && (((((_local_6.hasStateEffect(3)) && (!((_local_6.hasStateEffect(18)) && ((((((_local_8 == (1104)) || (_local_8 == 1105)) || (_local_8 == 1106)) || (_local_8 == 784)) || (_local_8 == 1099)) || (_local_8 == 1100))))) && (!(_local_6.hasState(3)))) && ((_local_6.data.canBreedSwitchPos()) || (ActionIdHelper.canTeleportOverBreedSwitchPos(_local_8)))) && (!(_local_6.hasState(8)))));
                        }
                        else
                        {
                            _local_12 = true;
                        };
                        if (_local_12)
                        {
                            _local_5.push(EffectOutput.fromMovement(_local_11.id, _local_6.getCurrentPositionCell(), -1, _local_6));
                            _local_11.setCurrentPositionCell(_local_6.getCurrentPositionCell());
                        }
                        else
                        {
                            return ([]);
                        };
                    }
                    else
                    {
                        _local_11 = null;
                    };
                    if (_local_6.hasState(8))
                    {
                        Teleport.releaseFighter(_arg_1, _local_6.getCarrier(_arg_1));
                    };
                    _local_6.setCurrentPositionCell(_local_10);
                }
                else
                {
                    _local_10 = -1;
                };
                if (_local_6.getCurrentPositionCell() == _local_10)
                {
                    DamageCalculator.executeMarks(_arg_1, _arg_2, _local_6, _local_6.getCurrentPositionCell(), _arg_4);
                };
                if (_local_11 != null)
                {
                    DamageCalculator.executeMarks(_arg_1, _arg_2, _local_11, _local_11.getCurrentPositionCell(), _arg_4);
                };
                _local_5.push(EffectOutput.fromMovement(_local_6.id, _local_10, _local_7, _local_11));
            };
            return (_local_5);
        }

        public static function getTeleportedPosition(fightContext:FightContext, runningEffect:RunningEffect, _arg_3:HaxeFighter, _arg_4:int):int
        {
            var _local_5:Boolean;
            var _local_6:int;
            var _local_7:* = (null as Point);
            var _local_8:Boolean;
            var _local_9:int;
            var _local_10:* = (null as SpellZone);
            var _local_11:* = (null as Array);
            var _local_12:int;
            var _local_13:int;
            var _local_14:* = (null as Point);
            var _local_15:* = (null as Point);
            if (_arg_3.isAlive())
            {
                _local_6 = runningEffect.getSpellEffect().actionId;
                _local_5 = ((((_arg_3.hasStateEffect(3)) && (!((_arg_3.hasStateEffect(18)) && ((((((_local_6 == (1104)) || (_local_6 == 1105)) || (_local_6 == 1106)) || (_local_6 == 784)) || (_local_6 == 1099)) || (_local_6 == 1100))))) && (!(_arg_3.hasState(3)))) && ((_arg_3.data.canBreedSwitchPos()) || (ActionIdHelper.canTeleportOverBreedSwitchPos(_local_6))));
            }
            else
            {
                _local_5 = false;
            };
            if (_local_5)
            {
                _local_6 = runningEffect.getSpellEffect().actionId;
                _local_9 = _local_6;
                if (_local_9 == 4)
                {
                    _local_8 = ActionIdHelper.isExchange(_local_6);
                    if (_local_8 == true)
                    {
                        return (_arg_4);
                    };
                    if (fightContext.isCellEmptyForMovement(_arg_4))
                    {
                        return (_arg_4);
                    };
                    if (runningEffect.getSpellEffect().rawZone.charAt(0) != "P")
                    {
                        _local_10 = SpellZone.fromRawZone(runningEffect.getSpellEffect().rawZone);
                        _local_11 = _local_10.getCells(_arg_4, _arg_3.getCurrentPositionCell());
                        ArraySort.sort(_local_11, function (_arg_1:int, _arg_2:int):int
                        {
                            return (TargetManagement.comparePositions(fightContext.targetedCell, ActionIdHelper.isPush(runningEffect.getSpellEffect().actionId), _arg_1, _arg_2));
                        });
                        _local_12 = 0;
                        while (_local_12 < _local_11.length)
                        {
                            _local_13 = _local_11[_local_12];
                            _local_12++;
                            if (fightContext.isCellEmptyForMovement(_local_13))
                            {
                                return (_local_13);
                            };
                        };
                    };
                    return (_arg_3.getCurrentPositionCell());
                };
                if (_local_9 == 1099)
                {
                    return (_arg_3.data.getTurnBeginPosition());
                };
                if (_local_9 == 1100)
                {
                    return (_arg_3.getPendingPreviousPosition());
                };
                    
                outer_block:
                {

                    if( (_local_9 == 1104) || (_local_9 == 1106) )
                    {
                        _local_7 = MapTools.getCellCoordById(_arg_4);
                        break outer_block;
                    };
                    if (_local_9 == 1105)
                    {
                        _local_7 = MapTools.getCellCoordById(runningEffect.getCaster().getCurrentPositionCell());
                    }
                    else
                    {
                        _local_8 = ActionIdHelper.isExchange(_local_6);
                        if (_local_8 == true)
                        {
                            return (_arg_4);
                        };
                        _local_7 = null;
                    };
                
                }//outer_block
                if (_local_7 != null)
                {
                    _local_14 = new Point(0, 0);
                    _local_15 = new Point(0, 0);
                    _local_14.x = (_local_7.x - MapTools.getCellCoordById(_arg_3.getCurrentPositionCell()).x);
                    _local_14.y = (_local_7.y - MapTools.getCellCoordById(_arg_3.getCurrentPositionCell()).y);
                    _local_15.x = (_local_7.x + _local_14.x);
                    _local_15.y = (_local_7.y + _local_14.y);
                    return (MapTools.getCellIdByCoord(_local_15.x, _local_15.y));
                };
            };
            return (_arg_3.getCurrentPositionCell());
        }

        public static function throwFighter(_arg_1:FightContext, _arg_2:HaxeFighter, _arg_3:RunningEffect, _arg_4:Boolean):Array
        {
            var _local_5:HaxeFighter = _arg_2.getCarried(_arg_1);
            if (_local_5 == null)
            {
                return ([]);
            };
            _arg_2.removeState(3);
            _arg_2.carryFighter(null);
            _local_5.removeState(8);
            _local_5.setCurrentPositionCell(_arg_1.targetedCell);
            var _local_6:int = MapTools.getLookDirection4(_arg_2.getCurrentPositionCell(), _arg_1.targetedCell);
            var _local_7:EffectOutput = EffectOutput.fromMovement(_local_5.id, _arg_1.targetedCell, _local_6);
            _local_7.throwedBy = _arg_2.id;
            DamageCalculator.executeMarks(_arg_1, _arg_3, _local_5, _arg_1.targetedCell, _arg_4);
            return ([EffectOutput.fromStateChange(_arg_2.id, 3, false), EffectOutput.fromStateChange(_local_5.id, 8, false), _local_7]);
        }

        public static function releaseFighter(_arg_1:FightContext, _arg_2:HaxeFighter):Array
        {
            if (_arg_2 == null)
            {
                return ([]);
            };
            var _local_3:HaxeFighter = _arg_2.getCarried(_arg_1);
            if (_local_3 == null)
            {
                return ([]);
            };
            _arg_2.removeState(3);
            _arg_2.carryFighter(null);
            _local_3.removeState(8);
            return ([EffectOutput.fromStateChange(_arg_2.id, 3, false), EffectOutput.fromStateChange(_local_3.id, 8, false)]);
        }

        public static function breakCarrierLink(_arg_1:HaxeFighter, _arg_2:HaxeFighter):void
        {
            _arg_1.removeState(3);
            _arg_1.carryFighter(null);
            _arg_2.removeState(8);
        }

        public static function carryFighter(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:HaxeFighter):Array
        {
            if (!(((_arg_3.hasStateEffect(3)) && (_arg_3.data.canBreedBeCarried())) && (!(_arg_3.hasStateEffect(4)))))
            {
                return ([]);
            };
            var _local_4:HaxeSpellEffect = _arg_2.getSpellEffect().clone();
            _local_4.actionId = 950;
            _local_4.param3 = 3;
            _local_4.param1 = 0;
            _arg_2.getCaster().storePendingBuff(new HaxeBuff(_arg_2.getCaster().id, _arg_2.getSpell(), _local_4));
            _arg_2.getCaster().carryFighter(_arg_3);
            var _local_5:HaxeSpellEffect = _arg_2.getSpellEffect().clone();
            _local_5.actionId = 950;
            _local_5.param3 = 8;
            _local_5.param1 = 0;
            _arg_3.storePendingBuff(new HaxeBuff(_arg_2.getCaster().id, _arg_2.getSpell(), _local_5));
            _arg_3.setCurrentPositionCell(_arg_2.getCaster().getCurrentPositionCell());
            var _local_6:int = MapTools.getLookDirection4(_arg_2.getCaster().getCurrentPositionCell(), _arg_1.targetedCell);
            var _local_7:EffectOutput = EffectOutput.fromMovement(_arg_3.id, _arg_2.getCaster().getCurrentPositionCell(), _local_6);
            _local_7.carriedBy = _arg_2.getCaster().id;
            return ([EffectOutput.fromStateChange(_arg_2.getCaster().id, 3, true), EffectOutput.fromStateChange(_arg_3.id, 8, true), _local_7]);
        }


    }
} damageCalculation.damageManagement

