package damageCalculation
{
    import tools.LoggerInterface;
    import mapTools.SpellZone;
    import damageCalculation.fighterManagement.HaxeFighter;
    import tools.FpUtils;
    import damageCalculation.spellManagement.HaxeSpell;
    import damageCalculation.spellManagement.RunningEffect;
    import damageCalculation.spellManagement.HaxeSpellEffect;
    import haxe.IMap;
    import damageCalculation.spellManagement.RandomGroup;
    import haxe.ds.List;
    import damageCalculation.debug.Debug;
    import haxe.ds.IntMap;
    import damageCalculation.damageManagement.TargetManagement;
    import haxe.ds._IntMap.IntMapValuesIterator;
    import damageCalculation.spellManagement.SpellManager;
    import damageCalculation.damageManagement.DamageRange;
    import damageCalculation.spellManagement.Mark;
    import mapTools.Point;
    import damageCalculation.fighterManagement.HaxeBuff;
    import damageCalculation.damageManagement.EffectOutput;
    import damageCalculation.tools.Interval;
    import tools.HaxeLogger;
    import tools.ActionIdHelper;
    import mapTools.MapTools;
    import damageCalculation.fighterManagement.PlayerTypeEnum;
    import damageCalculation.damageManagement.DamageSender;
    import haxe.ds.ArraySort;
    import damageCalculation.damageManagement.DamageReceiver;
    import haxe.ds.ObjectMap;
    import damageCalculation.damageManagement.Teleport;
    import damageCalculation.damageManagement.PushUtils;
    import damageCalculation.tools.LinkedListNode;
    import damageCalculation.tools.LinkedList;

    public class DamageCalculator 
    {

        public static var ALLOW_SPLASH_DEGRESSION:Boolean = true;
        public static var dataInterface:DamageCalculationInterface;
        public static var logger:LoggerInterface;
        public static var loopCountIterations:int = 0;
        public static var MAX_LOOP_ITERATIONS:int = 500;
        public static var START_TIME:Number = -1;
        public static var MAX_WALL_LENGTH:int = 7;
        public static var WALL_ZONE:SpellZone = mapTools.SpellZone.fromRawZone(("X" + 7));

        public function DamageCalculator():void
        {
        }

        public static function damageComputation(_arg_1:HaxeFighter, _arg_2:HaxeSpell, _arg_3:int, _arg_4:IMapInfo, _arg_5:int, _arg_6:int, _arg_7:Boolean=false, _arg_8:Boolean=false, _arg_9:Boolean=false):Array
        {
            var _local_12:int;
            var _local_13:* = (null as Array);
            var _local_14:* = (null as HaxeFighter);
            DamageCalculator.loopCountIterations = 0;
            var _local_10:FightContext = new FightContext(_arg_3, _arg_4, _arg_5, _arg_1, null, null, _arg_6, _arg_9);
            var _local_11:HaxeFighter = _local_10.getFighterFromCell(_local_10.targetedCell);
            if (((((_arg_2.needsFreeCell) && (!(_local_11 == null))) && (_local_11.isAlive())) || ((_arg_2.needsTakenCell) && ((_local_11 == (null)) || (!(_local_11.isAlive()))))))
            {
                return ([]);
            };
            DamageCalculator.START_TIME = Date.now().getTime();
            if ((((!(_arg_8)) || (_arg_1.isUnlucky())) || (_arg_2.getCriticalEffects().length == 0)))
            {
                DamageCalculator.executeSpell(_local_10, _arg_1, _arg_2, false, null, _arg_7);
                _local_12 = 0;
                _local_13 = _local_10.fighters;
                while (_local_12 < _local_13.length)
                {
                    _local_14 = _local_13[_local_12];
                    _local_12++;
                    _local_14.savePendingEffects();
                };
            };
            if (((_arg_1.isUnlucky()) && ((((_arg_7) && (_arg_2.criticalHitProbability > 0)) || (_arg_8)) && (!(_arg_2.getCriticalEffects().length == 0)))))
            {
                if (_arg_7)
                {
                    _local_12 = 0;
                    _local_13 = _local_10.fighters;
                    while (_local_12 < _local_13.length)
                    {
                        _local_14 = _local_13[_local_12];
                        _local_12++;
                        if (_local_10.tempFighters.indexOf(_local_14) != -1)
                        {
                            FpUtils.arrayRemove_damageCalculation_fighterManagement_HaxeFighter(_local_10.fighters, _local_14);
                        }
                        else
                        {
                            _local_14.resetToInitialState();
                        };
                    };
                    _local_10.tempFighters = [];
                    _local_10.inMovement = false;
                    _local_10.triggeredMarks = [];
                };
                DamageCalculator.loopCountIterations = 0;
                DamageCalculator.executeSpell(_local_10, _arg_1, _arg_2, true, null, _arg_7);
                _local_12 = 0;
                _local_13 = _local_10.fighters;
                while (_local_12 < _local_13.length)
                {
                    _local_14 = _local_13[_local_12];
                    _local_12++;
                    _local_14.savePendingEffects();
                };
            };
            return (_local_10.getAffectedFighters());
        }

        public static function executeSpell(_arg_1:FightContext, _arg_2:HaxeFighter, _arg_3:HaxeSpell, _arg_4:Boolean, _arg_5:RunningEffect, _arg_6:Boolean=false, _arg_7:Boolean=false):void
        {
            var _local_8:* = (null as RunningEffect);
            var _local_9:* = (null as Array);
            var _local_13:* = (null as HaxeSpellEffect);
            var _local_14:* = (null as HaxeFighter);
            var _local_15:* = null;
            var _local_16:int;
            var _local_17:* = (null as IMap);
            var _local_18:int;
            var _local_19:* = (null as Array);
            var _local_20:* = (null as RandomGroup);
            var _local_21:* = (null as List);
            if (_arg_1.debugMode)
            {
                Debug.storeSpell(_arg_3);
            };
            if (!_arg_2.isAlive())
            {
                return;
            };
            if (((_arg_5 == (null)) && ((_arg_3.criticalHitProbability == (0)) || (_arg_3.getCriticalEffects().length == 0))))
            {
                _arg_4 = false;
            };
            if ((((!(_arg_4)) || (!(_arg_5 == null))) || (_arg_3.getCriticalEffects().length == 0)))
            {
                _local_9 = _arg_3.getEffects();
            }
            else
            {
                _local_9 = _arg_3.getCriticalEffects();
            };
            _local_9 = FpUtils.arrayCopy_damageCalculation_spellManagement_HaxeSpellEffect(_local_9);
            var _local_10:IMap = new IntMap();
            var _local_11:IMap = new IntMap();
            var _local_12:int;
            while (_local_12 < _local_9.length)
            {
                _local_13 = _local_9[_local_12];
                _local_14 = ((_arg_5 != null) ? _arg_5.triggeringFighter : null);
                _local_15 = TargetManagement.getTargets(_arg_1, _arg_2, _arg_3, _local_13, _local_14);
                if (_local_15.isUsed)
                {
                    _local_10.h[_local_13.id] = _local_15.targetedFighters;
                    _local_11.h[_local_13.id] = _local_15.additionalTargets;
                    _local_12++;
                }
                else
                {
                    _local_9.splice(_local_12, 1);
                };
            };
            _local_16 = 0;
            while (_local_16 < _local_9.length)
            {
                _local_13 = _local_9[_local_16];
                _local_16++;
                if (_local_13.randomWeight <= 0)
                {
                    _local_8 = new RunningEffect(_arg_2, _arg_3, _local_13);
                    _local_8.setParentEffect(_arg_5);
                    _local_8.forceCritical = ((_arg_4) || (_local_13.isCritical));
                    DamageCalculator.computeEffect(_arg_1, _local_8, _arg_6, _local_10.h[_local_13.id], _local_11.h[_local_13.id], _arg_7);
                };
            };
            if (((_arg_3.hasAtLeastOneRandomEffect()) && (!(_local_9 == null))))
            {
                _local_17 = RandomGroup.createGroups(_local_9);
                _local_16 = RandomGroup.totalWeight(_local_17);
                _local_18 = 0;
                _local_19 = _arg_1.fighters;
                while (_local_18 < _local_19.length)
                {
                    _local_14 = _local_19[_local_18];
                    _local_18++;
                    _local_14.save();
                };
                _local_15 = new IntMapValuesIterator(_local_17.h);
                while (_local_15.hasNext())
                {
                    _local_20 = _local_15.next();
                    _local_18 = 0;
                    _local_19 = _local_20.effects;
                    while (_local_18 < _local_19.length)
                    {
                        _local_13 = _local_19[_local_18];
                        _local_18++;
                        if (SpellManager.isInstantaneousSpellEffect(_local_13))
                        {
                            _local_8 = new RunningEffect(_arg_2, _arg_3, _local_13);
                            _local_8.setParentEffect(_arg_5);
                            _local_8.forceCritical = ((_arg_4) || (_local_13.isCritical));
                            _local_8.probability = int(((_local_20.weight / _local_16) * 100));
                            DamageCalculator.computeEffect(_arg_1, _local_8, _arg_6, _local_10.h[_local_13.id], _local_11.h[_local_13.id]);
                        };
                    };
                    _local_18 = 0;
                    _local_19 = _arg_1.fighters;
                    while (_local_18 < _local_19.length)
                    {
                        _local_14 = _local_19[_local_18];
                        _local_18++;
                        _local_21 = _local_14.getEffectsDeltaFromSave();
                        if (_local_21 != null)
                        {
                            if (_local_14.totalEffects != null)
                            {
                                _local_14.totalEffects = FpUtils.listConcat_damageCalculation_damageManagement_EffectOutput(_local_14.totalEffects, _local_21);
                            }
                            else
                            {
                                _local_14.totalEffects = _local_21;
                            };
                        };
                        if (!_local_14.load())
                        {
                            _local_14.savePendingEffects();
                            _local_14.resetToInitialState();
                        };
                    };
                };
            };
        }

        public static function computeEffect(fightContext:FightContext, _arg_2:RunningEffect, _arg_3:Boolean, _arg_4:Array, _arg_5:Array, _arg_6:Boolean=false):void
        {
            var _local_11:* = (null as DamageRange);
            var _local_12:* = (null as String);
            var _local_13:Boolean;
            var _local_14:* = (null as Array);
            var _local_15:int;
            var _local_16:* = (null as Mark);
            var _local_17:* = (null as HaxeFighter);
            var _local_18:* = (null as Point);
            var _local_19:int;
            var _local_20:* = (null as Point);
            var _local_21:int;
            var _local_22:Boolean;
            var _local_23:* = (null as HaxeFighter);
            var _local_24:Boolean;
            var _local_25:* = (null as HaxeBuff);
            var _local_26:* = (null as IMap);
            var _local_27:* = null;
            var _local_28:Boolean;
            var _local_29:* = null;
            var _local_30:* = (null as HaxeSpell);
            var _local_31:* = (null as FightContext);
            var _local_32:int;
            var _local_33:Number;
            var _local_34:* = (null as DamageRange);
            var _local_35:Boolean;
            var _local_36:Boolean;
            var _local_37:Boolean;
            var _local_38:int;
            var _local_39:Boolean;
            var _local_40:Boolean;
            var _local_41:* = (null as EffectOutput);
            var _local_42:* = (null as Interval);
            var _local_43:* = (null as Array);
            var _local_44:* = (null as Array);
            var _local_45:* = (null as SpellZone);
            var _local_46:Boolean;
            var _local_47:Boolean;
            var _local_48:* = (null as DamageRange);
            var _local_49:* = (null as RunningEffect);
            var _local_50:int;
            var _local_51:Boolean;
            var _local_7:HaxeSpell = _arg_2.getSpell();
            var effect:HaxeSpellEffect = _arg_2.getSpellEffect();
            var _local_8:HaxeFighter = _arg_2.getCaster();
            var _local_9:int;
            var _local_10:HaxeFighter;
            _arg_2.forceCritical = ((_arg_2.forceCritical) || (effect.isCritical));
            DamageCalculator.loopCountIterations = (DamageCalculator.loopCountIterations + 1);
            if (DamageCalculator.loopCountIterations > DamageCalculator.MAX_LOOP_ITERATIONS)
            {
                _local_12 = (("[Damage Preview] Infinite loop detected after " + DamageCalculator.MAX_LOOP_ITERATIONS) + " iterations");
                HaxeLogger.logInfiniteLoop(_local_12, _arg_2);
                throw (_local_12);
            };
            if (((DamageCalculator.START_TIME != (-1)) && ((Date.now().getTime() - DamageCalculator.START_TIME) > 1000)))
            {
                _local_12 = "[Damage Preview] Preview takes too long to run";
                HaxeLogger.logInfiniteLoop(_local_12, _arg_2);
                throw (_local_12);
            };
            if (((SpellManager.isInstantaneousSpellEffect(effect)) || (_arg_2.isTriggered)))
            {
                if (effect.actionId == 2023)
                {
                    if (effect.zone.shape == "P")
                    {
                        _local_14 = fightContext.map.getMarkInteractingWithCell(fightContext.targetedCell, 5);
                        _local_15 = 0;
                        while (_local_15 < _local_14.length)
                        {
                            _local_16 = _local_14[_local_15];
                            _local_15++;
                            if (_local_16.casterId == _local_8.id)
                            {
                                DamageCalculator.executeMarkSpell(null, _local_16, _arg_2, fightContext, _arg_3);
                            };
                        };
                    }
                    else
                    {
                        _local_14 = fightContext.map.getMarks(5, _local_8.teamId);
                        _local_15 = 0;
                        while (_local_15 < _local_14.length)
                        {
                            _local_16 = _local_14[_local_15];
                            _local_15++;
                            if (((_local_16.casterId == (_local_8.id)) && (effect.zone.isCellInZone(_local_16.mainCell, fightContext.targetedCell, _local_8.getCurrentPositionCell()))))
                            {
                                DamageCalculator.executeMarkSpell(null, _local_16, _arg_2, fightContext, _arg_3);
                            };
                        };
                    };
                    return;
                };
                _local_13 = ActionIdHelper.isSummonWithoutTarget(effect.actionId);
                if (_local_13 == true)
                {
                    _local_17 = fightContext.getFighterFromCell(fightContext.targetedCell);
                    if (((DamageCalculator.summonTakesSlot(effect, fightContext, _local_8)) && (fightContext.getFighterCurrentSummonCount(_local_8) >= _local_8.getCharacteristicValue("maxSummonableCreatures"))))
                    {
                        return;
                    };
                    if (((fightContext.map.isCellWalkable(fightContext.targetedCell)) && ((_local_17 == (null)) || (!(_local_17.isAlive())))))
                    {
                        if (effect.actionId == 1097)
                        {
                            _local_18 = MapTools.getCellCoordById(_local_8.getCurrentPositionCell());
                            _local_15 = MapTools.getDistance(_local_8.getCurrentPositionCell(), fightContext.targetedCell);
                            _local_14 = [new Point((_local_18.x + _local_15), _local_18.y), new Point((_local_18.x - _local_15), _local_18.y), new Point(_local_18.x, (_local_18.y + _local_15)), new Point(_local_18.x, (_local_18.y - _local_15))];
                            _local_19 = 0;
                            while (_local_19 < _local_14.length)
                            {
                                _local_20 = _local_14[_local_19];
                                _local_19++;
                                _local_21 = MapTools.getCellIdByCoord(_local_20.x, _local_20.y);
                                if (((fightContext.map.isCellWalkable(_local_21)) && (fightContext.getFighterFromCell(_local_21) == null)))
                                {
                                    _local_10 = DamageCalculator.summon(effect, fightContext, _local_8, _local_21);
                                    if (_local_10 != null)
                                    {
                                        _arg_4.push(_local_10);
                                    };
                                };
                            };
                        }
                        else
                        {
                            _local_10 = DamageCalculator.summon(effect, fightContext, _local_8);
                            if (_local_10 != null)
                            {
                                _arg_4.push(_local_10);
                            };
                        };
                    };
                }
                else
                {
                    _local_17 = _arg_2.getCaster();
                    if (!(((_local_17.playerType == (PlayerTypeEnum.MONSTER)) && (_local_17.data.isSummon())) && (!(HaxeFighter.BOMB_BREED_ID.indexOf(_local_17.breed) == -1))))
                    {
                        _local_23 = _arg_2.getCaster();
                        _local_22 = (((_local_23.playerType == (PlayerTypeEnum.MONSTER)) && (_local_23.data.isSummon())) && (!(HaxeFighter.STEAMER_TURRET_BREED_ID.indexOf(_local_23.breed) == -1)));
                    }
                    else
                    {
                        _local_22 = true;
                    };
                    if (_local_22)
                    {
                        _arg_2.overrideCaster(_arg_2.getCaster().getSummoner(fightContext));
                    };
                    if (((ActionIdHelper.isDamage(effect.category)) || (ActionIdHelper.isHeal(effect.actionId))) == true)
                    {
                        _local_11 = DamageSender.getTotalDamage(fightContext, _arg_2, _arg_3);
                    }
                    else
                    {
                        _local_24 = ActionIdHelper.isShield(effect.actionId);
                        _local_11 = ((_local_24 == true) ? DamageSender.getTotalShield(_arg_2, _arg_3) : DamageRange.ZERO);
                    };
                    _local_11.probability = _arg_2.probability;
                    if (_local_8 != _arg_2.getCaster())
                    {
                        _arg_2.overrideCaster(_local_8);
                    };
                };
            };
            ArraySort.sort(_arg_4, function (_arg_1:HaxeFighter, _arg_2:HaxeFighter):int
            {
                return (TargetManagement.comparePositions(fightContext.targetedCell, ActionIdHelper.isPush(effect.actionId), _arg_1.getCurrentPositionCell(), _arg_2.getCurrentPositionCell()));
            });
            _local_15 = 0;
            for (;_local_15 < _arg_4.length;(_local_39 = false), if (ActionIdHelper.isTargetMaxLifeAffected(effect.actionId))
            {
                _local_14.push(EffectOutput.fromAffectedMaxLifePoints(_local_17.id));
            }, (_local_32 = 0), while (_local_32 < _local_14.length)
            {
                _local_41 = _local_14[_local_32];
                _local_32++;
                if (((_local_41.damageRange != (null)) && (_arg_6 == true)))
                {
                    _local_41.unknown = true;
                };
                _local_23 = fightContext.getFighterById(_local_41.fighterId);
                if (_local_41.damageRange != null)
                {
                    _local_34 = _local_41.damageRange;
                    _local_40 = (!((_local_34.min == (0)) && (_local_34.max == 0)));
                }
                else
                {
                    _local_40 = false;
                };
                if (_local_40)
                {
                    _local_41.areLifePointsAffected = true;
                    _local_34 = DamageReceiver.getPermanentDamage(_local_41.damageRange, _local_23);
                    _local_41.areErodedLifePointsAffected = ((_local_34 != (null)) && (!((_local_34.min == (0)) && (_local_34.max == 0))));
                };
                if (_local_41.areErodedLifePointsAffected)
                {
                    _local_41.areMaxLifePointsAffected = true;
                };
                if (_local_41.death)
                {
                    fightContext.addLastKilledAlly(_local_23);
                };
                if (_local_41.summon != null)
                {
                    _local_39 = true;
                };
                _local_23.pendingEffects.add(_local_41);
            }, DamageCalculator.triggerHandler(_local_14, _arg_2, fightContext, _local_17, _local_28, _arg_3), if (((_local_39 == (true)) && (!(_local_10 == null))))
            {
                _local_30 = DamageCalculator.dataInterface.getStartingSpell(_local_10, effect.param2);
                if (_local_30 != null)
                {
                    DamageCalculator.executeSpell(fightContext, _local_10, _local_30, _arg_2.forceCritical, null, _arg_3, _arg_6);
                };
            })
            {
                _local_17 = _arg_4[_local_15];
                _local_15++;
                //unresolved if
                if (((SpellManager.isInstantaneousSpellEffect(effect)) && (!(_arg_2.isTriggered))))
                {
                    _local_17.storePendingBuff(HaxeBuff.fromRunningEffect(_arg_2));
                    //unresolved jump
                };
                _local_19 = effect.actionId;
                if (ActionIdHelper.isBuff(_local_19) == true)
                {
                    _local_25 = HaxeBuff.fromRunningEffect(_arg_2);
                    if (_arg_2.isTriggered)
                    {
                        _local_25.effect.triggers = ["I"];
                    };
                    _local_17.storePendingBuff(_local_25);
                    if (((_local_25.effect.actionId == (169)) || (_local_25.effect.actionId == 168)))
                    {
                        if (_local_25.effect.actionId == 169)
                        {
                            effect.actionId = 1080;
                        }
                        else
                        {
                            if (_local_25.effect.actionId == 168)
                            {
                                effect.actionId = 1079;
                            };
                        };
                        DamageCalculator.computeEffect(fightContext, _arg_2, _arg_3, [_local_17], null, _arg_6);
                    };
                    //unresolved jump
                };
                _local_13 = ActionIdHelper.isStatBoost(_local_19);
                if (_local_13 == true)
                {
                    _local_8.storeSpellEffectStatBoost(_local_7, effect);
                    //unresolved jump
                };
                _local_22 = (((_local_19 == (1008)) && (_local_10 == null)) || (ActionIdHelper.isSpellExecution(_local_19)));
                if (_local_22 == true)
                {
                    if (ActionIdHelper.spellExecutionHasGlobalLimitation(effect.actionId))
                    {
                        if (++_local_9 > effect.param3)
                        {
                            return;
                        };
                    };
                    _local_26 = new ObjectMap();
                    _local_21 = 0;
                    _local_14 = fightContext.fighters;
                    while (_local_21 < _local_14.length)
                    {
                        _local_23 = _local_14[_local_21];
                        _local_21++;
                        _local_26[_local_23] = _local_23.getBeforeLastSpellPosition();
                        _local_23.savePositionBeforeSpellExecution();
                    };
                    _local_27 = DamageCalculator.solveSpellExecution(fightContext, _arg_2, _local_17, _arg_3);
                    if (_local_27 != null)
                    {
                        _local_28 = ((_local_8.id != (fightContext.originalCaster.id)) && (fightContext.originalCaster.playerType == PlayerTypeEnum.HUMAN));
                        DamageCalculator.executeSpell(_local_27.context, _local_27.caster, _local_27.spell, _local_27.isCritical, _arg_2, _arg_3, _local_28);
                    };
                    _local_29 = _local_26.keys();
                    while (_local_29.hasNext())
                    {
                        _local_23 = _local_29.next();
                        _local_23.setBeforeLastSpellPosition(_local_26[_local_23]);
                    };
                    //unresolved jump
                };
                _local_21 = _local_19;
                if (_local_21 == 406)
                {
                    _local_8.removeBuffBySpellId(effect.param3);
                    //unresolved jump
                };
                if (_local_21 == 952)
                {
                    _local_17.removeState(effect.param3);
                    //unresolved jump
                };
                if (_local_21 == 1009)
                {
                    _local_14 = TargetManagement.getBombsAboutToExplode(_local_17, fightContext, _arg_2);
                    _local_32 = 0;
                    while (_local_32 < _local_14.length)
                    {
                        _local_23 = _local_14[_local_32];
                        _local_32++;
                        _local_30 = DamageCalculator.dataInterface.getBombExplosionSpellFromFighter(_local_23);
                        if (_local_30 != null)
                        {
                            _local_31 = fightContext.copy();
                            _local_31.targetedCell = _local_23.getCurrentPositionCell();
                            DamageCalculator.executeSpell(_local_31, _local_23, _local_30, _arg_2.forceCritical, _arg_2, _arg_3);
                        };
                    };
                    //unresolved jump
                };
                if (_local_21 == 1159)
                {
                    _local_33 = (effect.param1 * 0.01);
                    _local_34 = _arg_2.triggeringOutput.damageRange;
                    if (((((_local_34 != (null)) && (!(_local_34.isInvulnerable))) && (!(_local_34.isCollision))) && (_local_34.isHeal)))
                    {
                        _local_34.multiply(_local_33);
                    };
                    //unresolved jump
                };
                _local_24 = ActionIdHelper.isTargetMarkDispell(_local_19);
                if (_local_24 == true)
                {
                    _local_32 = effect.actionId;
                    if (_local_32 == 2018)
                    {
                        _local_21 = 1;
                    }
                    else
                    {
                        if (_local_32 == 2019)
                        {
                            _local_21 = 2;
                        }
                        else
                        {
                            if (_local_32 == 2024)
                            {
                                _local_21 = 5;
                            }
                            else
                            {
                                _local_21 = 0;
                            };
                        };
                    };
                    _local_32 = 0;
                    _local_14 = fightContext.map.getMarks(_local_21, _local_17.teamId);
                    while (_local_32 < _local_14.length)
                    {
                        _local_16 = _local_14[_local_32];
                        _local_32++;
                        if (((_local_16.casterId == (_local_17.id)) && ((effect.param1 == (0)) || (effect.param1 == _local_16.associatedSpell.id))))
                        {
                            _local_16.active = false;
                        };
                    };
                    //unresolved jump
                };
                _local_28 = MapTools.areCellsAdjacent(_arg_2.getCaster().getCurrentPositionCell(), _local_17.getCurrentPositionCell());
                _local_21 = effect.actionId;
                if (ActionIdHelper.isTeleport(_local_21) == true)
                {
                    _local_14 = Teleport.teleportFighter(fightContext, _arg_2, _local_17, _arg_3);
                }
                else
                {
                    _local_32 = _local_21;
                    if (_local_32 == 50)
                    {
                        _local_14 = Teleport.carryFighter(fightContext, _arg_2, _local_17);
                    }
                    else
                    {
                        if (_local_32 == 51)
                        {
                            _local_23 = _arg_2.getCaster();
                            _local_14 = Teleport.throwFighter(fightContext, _local_23, _arg_2, _arg_3);
                        }
                        else
                        {
                            if (_local_32 == 141)
                            {
                                _local_35 = ActionIdHelper.isPush(_local_21);
                                if (_local_35 == true)
                                {
                                    _local_38 = effect.param1;
                                    _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                    _local_40 = ActionIdHelper.allowCollisionDamages(effect.actionId);
                                    _local_14 = PushUtils.push(fightContext, _arg_2, _local_17, _local_38, _local_39, _local_40, _arg_3);
                                }
                                else
                                {
                                    _local_36 = ActionIdHelper.isPull(_local_21);
                                    if (_local_36 == true)
                                    {
                                        _local_38 = effect.param1;
                                        _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                        _local_14 = PushUtils.pull(fightContext, _arg_2, _local_17, _local_38, _local_39, _arg_3);
                                    }
                                    else
                                    {
                                        _local_14 = [EffectOutput.deathOf(_local_17.id)];
                                    };
                                };
                            }
                            else
                            {
                                if (_local_32 == 320)
                                {
                                    _local_35 = ActionIdHelper.isPush(_local_21);
                                    if (_local_35 == true)
                                    {
                                        _local_38 = effect.param1;
                                        _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                        _local_40 = ActionIdHelper.allowCollisionDamages(effect.actionId);
                                        _local_14 = PushUtils.push(fightContext, _arg_2, _local_17, _local_38, _local_39, _local_40, _arg_3);
                                    }
                                    else
                                    {
                                        _local_36 = ActionIdHelper.isPull(_local_21);
                                        if (_local_36 == true)
                                        {
                                            _local_38 = effect.param1;
                                            _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                            _local_14 = PushUtils.pull(fightContext, _arg_2, _local_17, _local_38, _local_39, _arg_3);
                                        }
                                        else
                                        {
                                            _local_41 = new EffectOutput(_local_17.id);
                                            _local_41.rangeStolen = effect.getDamageInterval().min;
                                            _local_14 = [_local_41];
                                        };
                                    };
                                }
                                else
                                {
                                    if (_local_32 == 783)
                                    {
                                        _local_14 = PushUtils.pushTo(fightContext, _arg_2, _local_17, false, false, _arg_3);
                                    }
                                    else
                                    {
                                        if (_local_32 == 786)
                                        {
                                            _local_35 = ActionIdHelper.isPush(_local_21);
                                            if (_local_35 == true)
                                            {
                                                _local_38 = effect.param1;
                                                _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                _local_40 = ActionIdHelper.allowCollisionDamages(effect.actionId);
                                                _local_14 = PushUtils.push(fightContext, _arg_2, _local_17, _local_38, _local_39, _local_40, _arg_3);
                                            }
                                            else
                                            {
                                                _local_36 = ActionIdHelper.isPull(_local_21);
                                                if (_local_36 == true)
                                                {
                                                    _local_38 = effect.param1;
                                                    _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                    _local_14 = PushUtils.pull(fightContext, _arg_2, _local_17, _local_38, _local_39, _arg_3);
                                                }
                                                else
                                                {
                                                    _local_42 = effect.getDamageInterval();
                                                    _local_34 = _arg_2.triggeringOutput.damageRange.copy();
                                                    _local_23 = ((_arg_2.getParentEffect() != null) ? _arg_2.getParentEffect().getCaster() : null);
                                                    if (((((_local_34 != (null)) && (!(_local_23 == null))) && (!(_local_34.isHeal))) && (!(_local_34.isInvulnerable))))
                                                    {
                                                        _local_34.multiply(_local_42.min);
                                                        _local_34.multiply(0.01);
                                                        _local_34.isHeal = true;
                                                        _local_34.isShieldDamage = false;
                                                        _local_14 = [EffectOutput.fromDamageRange(_local_23.id, _local_34)];
                                                    }
                                                    else
                                                    {
                                                        _local_14 = [];
                                                    };
                                                };
                                            };
                                        }
                                        else
                                        {
                                            if (_local_32 == 950)
                                            {
                                                _local_35 = ActionIdHelper.isPush(_local_21);
                                                if (_local_35 == true)
                                                {
                                                    _local_38 = effect.param1;
                                                    _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                    _local_40 = ActionIdHelper.allowCollisionDamages(effect.actionId);
                                                    _local_14 = PushUtils.push(fightContext, _arg_2, _local_17, _local_38, _local_39, _local_40, _arg_3);
                                                }
                                                else
                                                {
                                                    _local_36 = ActionIdHelper.isPull(_local_21);
                                                    if (_local_36 == true)
                                                    {
                                                        _local_38 = effect.param1;
                                                        _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                        _local_14 = PushUtils.pull(fightContext, _arg_2, _local_17, _local_38, _local_39, _arg_3);
                                                    }
                                                    else
                                                    {
                                                        _local_25 = HaxeBuff.fromRunningEffect(_arg_2);
                                                        if (_arg_2.isTriggered)
                                                        {
                                                            _local_25.effect.triggers = ["I"];
                                                        };
                                                        _local_17.storePendingBuff(_local_25);
                                                        _local_14 = [EffectOutput.fromStateChange(_local_17.id, effect.param3, true)];
                                                    };
                                                };
                                            }
                                            else
                                            {
                                                if (_local_32 == 951)
                                                {
                                                    _local_35 = ActionIdHelper.isPush(_local_21);
                                                    if (_local_35 == true)
                                                    {
                                                        _local_38 = effect.param1;
                                                        _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                        _local_40 = ActionIdHelper.allowCollisionDamages(effect.actionId);
                                                        _local_14 = PushUtils.push(fightContext, _arg_2, _local_17, _local_38, _local_39, _local_40, _arg_3);
                                                    }
                                                    else
                                                    {
                                                        _local_36 = ActionIdHelper.isPull(_local_21);
                                                        if (_local_36 == true)
                                                        {
                                                            _local_38 = effect.param1;
                                                            _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                            _local_14 = PushUtils.pull(fightContext, _arg_2, _local_17, _local_38, _local_39, _arg_3);
                                                        }
                                                        else
                                                        {
                                                            _local_14 = ((_local_17.removeState(effect.getMinRoll())) ? [EffectOutput.fromStateChange(_local_17.id, effect.param3, false)] : []);
                                                        };
                                                    };
                                                }
                                                else
                                                {
                                                    if (_local_32 == 1043)
                                                    {
                                                        _local_14 = PushUtils.pullTo(fightContext, _arg_2, _local_17, false, _arg_3);
                                                    }
                                                    else
                                                    {
                                                        if (_local_32 == 1075)
                                                        {
                                                            _local_35 = ActionIdHelper.isPush(_local_21);
                                                            if (_local_35 == true)
                                                            {
                                                                _local_38 = effect.param1;
                                                                _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                                _local_40 = ActionIdHelper.allowCollisionDamages(effect.actionId);
                                                                _local_14 = PushUtils.push(fightContext, _arg_2, _local_17, _local_38, _local_39, _local_40, _arg_3);
                                                            }
                                                            else
                                                            {
                                                                _local_36 = ActionIdHelper.isPull(_local_21);
                                                                if (_local_36 == true)
                                                                {
                                                                    _local_38 = effect.param1;
                                                                    _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                                    _local_14 = PushUtils.pull(fightContext, _arg_2, _local_17, _local_38, _local_39, _arg_3);
                                                                }
                                                                else
                                                                {
                                                                    _local_43 = _local_17.reduceBuffDurations(effect.getMinRoll());
                                                                    if (((_local_43 != (null)) && (_local_43.length > 0)))
                                                                    {
                                                                        _local_44 = [EffectOutput.fromDispell(_local_17.id)];
                                                                        _local_38 = 0;
                                                                        while (_local_38 < _local_43.length)
                                                                        {
                                                                            _local_25 = _local_43[_local_38];
                                                                            _local_38++;
                                                                            if (_local_25.effect.actionId == 950)
                                                                            {
                                                                                _local_44.push(EffectOutput.fromStateChange(_local_17.id, _local_25.effect.param3, false));
                                                                            };
                                                                        };
                                                                        _local_14 = _local_44;
                                                                    }
                                                                    else
                                                                    {
                                                                        _local_14 = [];
                                                                    };
                                                                };
                                                            };
                                                        }
                                                        else
                                                        {
                                                            if( (_local_32 == 84) || (_local_32 == 1079) )
                                                            {
                                                                _local_35 = ActionIdHelper.isPush(_local_21);
                                                                if (_local_35 == true)
                                                                {
                                                                    _local_38 = effect.param1;
                                                                    _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                                    _local_40 = ActionIdHelper.allowCollisionDamages(effect.actionId);
                                                                    _local_14 = PushUtils.push(fightContext, _arg_2, _local_17, _local_38, _local_39, _local_40, _arg_3);
                                                                }
                                                                else
                                                                {
                                                                    _local_36 = ActionIdHelper.isPull(_local_21);
                                                                    if (_local_36 == true)
                                                                    {
                                                                        _local_38 = effect.param1;
                                                                        _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                                        _local_14 = PushUtils.pull(fightContext, _arg_2, _local_17, _local_38, _local_39, _arg_3);
                                                                    }
                                                                    else
                                                                    {
                                                                        _local_14 = [EffectOutput.fromApTheft(_local_17.id, effect.getDamageInterval().min)];
                                                                    };
                                                                };
                                                                continue;
                                                            };
                                                            if( (_local_32 == 77) || (_local_32 == 1080) )
                                                            {
                                                                _local_35 = ActionIdHelper.isPush(_local_21);
                                                                if (_local_35 == true)
                                                                {
                                                                    _local_38 = effect.param1;
                                                                    _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                                    _local_40 = ActionIdHelper.allowCollisionDamages(effect.actionId);
                                                                    _local_14 = PushUtils.push(fightContext, _arg_2, _local_17, _local_38, _local_39, _local_40, _arg_3);
                                                                }
                                                                else
                                                                {
                                                                    _local_36 = ActionIdHelper.isPull(_local_21);
                                                                    if (_local_36 == true)
                                                                    {
                                                                        _local_38 = effect.param1;
                                                                        _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                                        _local_14 = PushUtils.pull(fightContext, _arg_2, _local_17, _local_38, _local_39, _arg_3);
                                                                    }
                                                                    else
                                                                    {
                                                                        _local_14 = [EffectOutput.fromAmTheft(_local_17.id, effect.getDamageInterval().min)];
                                                                    };
                                                                };
                                                                continue;
                                                            };
                                                            _local_35 = ActionIdHelper.isPush(_local_21);
                                                            if (_local_35 == true)
                                                            {
                                                                _local_32 = effect.param1;
                                                                _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                                _local_40 = ActionIdHelper.allowCollisionDamages(effect.actionId);
                                                                _local_14 = PushUtils.push(fightContext, _arg_2, _local_17, _local_32, _local_39, _local_40, _arg_3);
                                                            }
                                                            else
                                                            {
                                                                _local_36 = ActionIdHelper.isPull(_local_21);
                                                                if (_local_36 == true)
                                                                {
                                                                    _local_32 = effect.param1;
                                                                    _local_39 = ActionIdHelper.isForcedDrag(effect.actionId);
                                                                    _local_14 = PushUtils.pull(fightContext, _arg_2, _local_17, _local_32, _local_39, _arg_3);
                                                                }
                                                                else
                                                                {
                                                                    _local_37 = ActionIdHelper.isSummon(_local_21);
                                                                    if (_local_37 == true)
                                                                    {
                                                                        if (((ActionIdHelper.isSummonWithoutTarget(effect.actionId)) && (!(_local_10 == null))))
                                                                        {
                                                                            _local_32 = effect.actionId;
                                                                            if (_local_32 != 180)
                                                                            {
                                                                                if (_local_32 != 1097)
                                                                                {
                                                                                    if (_local_32 != 1189) goto _label_1;
                                                                                };
                                                                            };
                                                                            _local_33 = _local_8.id;
                                                                            goto _label_2;
                                                                            
                                                                        _label_1: 
                                                                            _local_33 = 0;
                                                                            
                                                                        _label_2: 
                                                                            _local_32 = MapTools.getLookDirection4(_local_8.getCurrentPositionCell(), _local_17.getCurrentPositionCell());
                                                                            _local_14 = [EffectOutput.fromSummon(_local_17.id, _local_17.getCurrentPositionCell(), _local_32, _local_33), EffectOutput.fromSummoning(_local_8.id)];
                                                                        }
                                                                        else
                                                                        {
                                                                            if (((ActionIdHelper.isKillAndSummon(effect.actionId)) && ((!(DamageCalculator.summonTakesSlot(effect, fightContext, _local_8))) || (fightContext.getFighterCurrentSummonCount(_local_8) > _local_8.getCharacteristicValue("maxSummonableCreatures")))))
                                                                            {
                                                                                _local_43 = [EffectOutput.deathOf(_local_17.id)];
                                                                                _local_23 = DamageCalculator.summon(effect, fightContext, _local_8);
                                                                                _local_32 = MapTools.getLookDirection4(_local_8.getCurrentPositionCell(), _local_23.getCurrentPositionCell());
                                                                                if (_local_23 != null)
                                                                                {
                                                                                    _local_43.push(EffectOutput.fromSummon(_local_23.id, _local_23.getCurrentPositionCell(), _local_32));
                                                                                    _local_43.push(EffectOutput.fromSummoning(_local_8.id));
                                                                                };
                                                                                _local_14 = _local_43;
                                                                            }
                                                                            else
                                                                            {
                                                                                _local_14 = [];
                                                                            };
                                                                        };
                                                                    }
                                                                    else
                                                                    {
                                                                        _local_32 = effect.actionId;
                                                                        if (_local_32 == 80)
                                                                        {
                                                                            _local_34 = PushUtils.getCollisionDamages(fightContext, _local_8, _local_17, effect.param1, effect.param2);
                                                                        }
                                                                        else
                                                                        {
                                                                            _local_39 = ActionIdHelper.isBasedOnTargetLife(_local_32);
                                                                            _local_34 = ((_local_39 == true) ? DamageReceiver.getDamageBasedOnTargetLife(_arg_2.getSpellEffect(), _local_17, _local_11.copy()) : _local_11.copy());
                                                                        };
                                                                        if (_arg_2.getCaster() == _local_17)
                                                                        {
                                                                            _local_28 = false;
                                                                            if (effect.actionId == 90)
                                                                            {
                                                                                _local_34.isHeal = false;
                                                                            };
                                                                        };
                                                                        if ((((ActionIdHelper.isFakeDamage(effect.actionId)) && (!(effect.actionId == 80))) && (!((_local_34.min == (0)) && (_local_34.max == 0)))))
                                                                        {
                                                                            _local_33 = 1;
                                                                            if ((((_arg_5 == (null)) || (_arg_5.indexOf(_local_17) == -1)) && (ActionIdHelper.allowAOEMalus(effect.actionId))))
                                                                            {
                                                                                _local_38 = 0;
                                                                                if (effect.zone.radius >= 1)
                                                                                {
                                                                                    _local_45 = effect.zone;
                                                                                    _local_38 = _local_45.getAOEMalus(fightContext.targetedCell, _local_8.getCurrentPositionCell(), _local_17.getBeforeLastSpellPosition());
                                                                                };
                                                                                _local_33 = (_local_33 * ((100 - _local_38) / 100));
                                                                            };
                                                                            if (fightContext.usingPortal())
                                                                            {
                                                                                _local_33 = (_local_33 * (1 + (fightContext.getPortalBonus() * 0.01)));
                                                                            };
                                                                            _local_34.multiply(_local_33);
                                                                        };
                                                                        _local_38 = effect.actionId;
                                                                        if (_local_38 == 106)
                                                                        {
                                                                            _local_41 = _arg_2.triggeringOutput;
                                                                            _local_48 = _arg_2.triggeringOutput.damageRange;
                                                                            _local_49 = _arg_2.getParentEffect();
                                                                            _local_23 = ((_local_49 != null) ? _local_49.getCaster() : null);
                                                                            _local_50 = ((_local_49 != null) ? _local_49.getSpell().level : 1);
                                                                            _local_51 = ((_local_49 != (null)) && (_local_49.getSpell().isWeapon));
                                                                            if (((((((_local_23 != (null)) && (!(_local_49 == null))) && (!(_local_48 == null))) && (!(_local_41.damageRange.isCollision))) && (_local_50 <= effect.param2)) && (!(_local_51))))
                                                                            {
                                                                                _local_17.pendingEffects.remove(_local_41);
                                                                                _local_14 = DamageReceiver.receiveDamageOrHeal(fightContext, _local_49, _local_41.damageRange, _local_23, _local_28, _arg_3);
                                                                            }
                                                                            else
                                                                            {
                                                                                _local_14 = [];
                                                                            };
                                                                        }
                                                                        else
                                                                        {
                                                                            _local_40 = ActionIdHelper.isShield(_local_38);
                                                                            if (_local_40 == true)
                                                                            {
                                                                                _local_14 = [EffectOutput.fromDamageRange(_local_17.id, _local_34)];
                                                                            }
                                                                            else
                                                                            {
                                                                                _local_46 = ActionIdHelper.isHeal(_local_38);
                                                                                if (_local_46 == true)
                                                                                {
                                                                                    _local_14 = DamageReceiver.receiveDamageOrHeal(fightContext, _arg_2, _local_34, _local_17, _local_28, _arg_3);
                                                                                }
                                                                                else
                                                                                {
                                                                                    _local_47 = ActionIdHelper.isDamage(effect.category);
                                                                                    _local_14 = ((_local_47 == true) ? DamageReceiver.receiveDamageOrHeal(fightContext, _arg_2, _local_34, _local_17, _local_28, _arg_3) : []);
                                                                                };
                                                                            };
                                                                        };
                                                                    };
                                                                };
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        public static function summonTakesSlot(_arg_1:HaxeSpellEffect, _arg_2:FightContext, _arg_3:HaxeFighter):Boolean
        {
            if (!ActionIdHelper.isSummonWithSlot(_arg_1.actionId))
            {
                if (_arg_1.actionId == 181)
                {
                    return (DamageCalculator.dataInterface.summonMonster(_arg_3, _arg_1.param1, _arg_1.param2).data.useSummonSlot());
                };
                return (false);
            };
            return (true);
        }

        public static function summon(_arg_1:HaxeSpellEffect, _arg_2:FightContext, _arg_3:HaxeFighter, _arg_4:int=-1):HaxeFighter
        {
            var _local_6:* = (null as HaxeFighter);
            var _local_8:Boolean;
            if (!MapTools.isValidCellId(_arg_4))
            {
                _arg_4 = _arg_2.targetedCell;
            };
            var _local_5:HaxeFighter = _arg_2.getFighterFromCell(_arg_4);
            if (((!(_arg_2.map.isCellWalkable(_arg_4))) || ((_local_5 != (null)) && (_local_5.isAlive()))))
            {
                return (null);
            };
            var _local_7:int = _arg_1.actionId;
            var _local_9:int = _local_7;
            if (_local_9 != 180)
            {
                if (_local_9 != 1097)
                {
                    if (_local_9 != 1189) goto _label_1;
                };
            };
            _local_6 = _arg_3.copy(_arg_2);
            goto _label_2;
            
        _label_1: 
            _local_8 = ActionIdHelper.isRevive(_local_7);
            _local_6 = ((_local_8 == true) ? _arg_2.getLastKilledAlly(_arg_3.teamId) : DamageCalculator.dataInterface.summonMonster(_arg_3, _arg_1.param1, _arg_1.param2));
            
        _label_2: 
            if (_local_6 == null)
            {
                return (null);
            };
            var _local_10:HaxeFighter = _arg_2.getFighterById(_local_6.id);
            if ((((ActionIdHelper.isRevive(_arg_1.actionId)) && (!(_local_10 == null))) && (_local_10.isAlive())))
            {
                return (null);
            };
            _local_6.setCurrentPositionCell(_arg_4);
            _local_6.beforeLastSpellPosition = _arg_4;
            if (_arg_2.getFighterById(_local_6.id) == null)
            {
                _arg_2.tempFighters.push(_local_6);
                _arg_2.fighters.push(_local_6);
            };
            return (_local_6);
        }

        public static function triggerHandler(_arg_1:Array, _arg_2:RunningEffect, _arg_3:FightContext, _arg_4:HaxeFighter, _arg_5:Boolean, _arg_6:Boolean):void
        {
            var _local_8:* = (null as EffectOutput);
            var _local_9:* = (null as HaxeFighter);
            var _local_10:Boolean;
            var _local_7:int;
            while (_local_7 < _arg_1.length)
            {
                _local_8 = _arg_1[_local_7];
                _local_7++;
                if (((_local_8.damageRange != (null)) && (_arg_2.forceCritical)))
                {
                    _local_8.damageRange.isCritical = true;
                };
                _local_9 = _arg_3.getFighterById(_local_8.fighterId);
                _local_10 = MapTools.areCellsAdjacent(_arg_2.getCaster().getCurrentPositionCell(), _local_9.getCurrentPositionCell());
                DamageCalculator.triggerEffects(_arg_3, _arg_2, _local_9, _local_10, _local_8, _arg_6);
            };
        }

        public static function getAOEMalus(_arg_1:HaxeSpellEffect, _arg_2:int, _arg_3:HaxeFighter, _arg_4:HaxeFighter):Number
        {
            var _local_6:* = (null as SpellZone);
            var _local_5:int;
            if (_arg_1.zone.radius >= 1)
            {
                _local_6 = _arg_1.zone;
                _local_5 = _local_6.getAOEMalus(_arg_2, _arg_3.getCurrentPositionCell(), _arg_4.getBeforeLastSpellPosition());
            };
            return ((100 - _local_5) / 100);
        }

        public static function triggerEffects(fightContext:FightContext, triggeringRunningEffect:RunningEffect, target:HaxeFighter, melee:Boolean, triggeringOutput:EffectOutput, isPreview:Boolean):Boolean
        {
            var hasTriggerEffect:Boolean;
            var _local_7:Function = function (_arg_1:LinkedList, _arg_2:Boolean, _arg_3:Function, _arg_4:HaxeFighter):void
            {
                var _local_6:* = (null as LinkedListNode);
                var _local_7:* = (null as LinkedListNode);
                var _local_8:* = (null as HaxeBuff);
                var _local_9:* = (null as HaxeFighter);
                var _local_10:* = (null as HaxeSpellEffect);
                var _local_11:* = (null as RunningEffect);
                var _local_12:* = (null as FightContext);
                var _local_5:LinkedListNode = _arg_1.head;
                while (_local_5 != null)
                {
                    _local_6 = _local_5;
                    _local_5 = _local_5.next;
                    _local_7 = _local_6;
                    _local_8 = _local_7.item;
                    if (((_local_8.effect.actionId == (792)) || (_local_8.effect.actionId == 793)))
                    {
                        _local_9 = _arg_4;
                    }
                    else
                    {
                        _local_9 = target;
                    };
                    if (!((((((_local_8.effect.triggers == (null)) || (_local_8.effect.triggers.length == 0)) || ((_local_8.effect.triggers.length == (1)) && (_local_8.effect.triggers[0] == "I"))) || (!(_local_8.canBeTriggeredBy(triggeringRunningEffect)))) || (((ActionIdHelper.isSpellExecution(_local_8.effect.actionId)) && (_local_8.effect.param3 > 0)) && (_local_8.triggerCount >= _local_8.effect.param3))) || ((_arg_2) && (!(_local_8.hasBeenTriggeredOn.indexOf(_local_9.id) == -1)))))
                    {
                        if (_arg_3(_local_8))
                        {
                            if (_local_8.effect.isCritical)
                            {
                                _local_10 = _local_8.effect.clone();
                                _local_10.isCritical = false;
                            }
                            else
                            {
                                _local_10 = _local_8.effect;
                            };
                            _local_11 = new RunningEffect(fightContext.getFighterById(_local_8.casterId), _local_8.spell, _local_10);
                            _local_11.triggeredByEffectSetting(triggeringRunningEffect);
                            _local_11.triggeringOutput = triggeringOutput;
                            _local_11.isTriggered = true;
                            _local_11.forceCritical = triggeringRunningEffect.forceCritical;
                            _local_12 = fightContext.copy();
                            _local_12.targetedCell = _local_9.getBeforeLastSpellPosition();
                            if (_arg_2)
                            {
                                _local_8.hasBeenTriggeredOn.push(_local_9.id);
                            };
                            _local_8.triggerCount = (_local_8.triggerCount + 1);
                            DamageCalculator.computeEffect(_local_12, _local_11, isPreview, [_local_9], null);
                            hasTriggerEffect = true;
                        };
                    };
                };
            };
            var _local_8:HaxeFighter = triggeringRunningEffect.getCaster();
            (_local_7(target._buffs.copy(), false, function (_arg_1:HaxeBuff):Boolean
            {
                return (_arg_1.shouldBeTriggeredOnTarget(triggeringOutput, triggeringRunningEffect, target, melee, fightContext));
            }, target));
            (_local_7(_local_8._buffs.copy(), true, function (_arg_1:HaxeBuff):Boolean
            {
                return (_arg_1.shouldBeTriggeredOnCaster(triggeringOutput, triggeringRunningEffect, target, melee, fightContext));
            }, _local_8));
            return (hasTriggerEffect);
        }

        public static function solveSpellExecution(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:Boolean):Object
        {
            var _local_10:int;
            var _local_5:HaxeFighter = _arg_2.getCaster();
            var _local_6:HaxeFighter = ((_arg_2.isTriggered) ? _arg_2.triggeringFighter : _local_5);
            var _local_7:HaxeFighter;
            var _local_8:HaxeFighter;
            var _local_9:Boolean;
            _local_10 = _arg_2.getSpellEffect().actionId;
            if (_local_10 != 792)
            {
                if (_local_10 != 793)
                {
                    if (_local_10 != 2792)
                    {
                        if (_local_10 != 2793) goto _label_1;
                    };
                };
            };
            _local_7 = _arg_3;
            _local_8 = _arg_3;
            goto _label_3;
            
        _label_1: 
            if (_local_10 == 1018)
            {
                _local_7 = _local_6;
                _local_8 = _arg_3;
            }
            else
            {
                if (_local_10 == 1019)
                {
                    _local_7 = _local_6;
                    _local_8 = _local_6;
                }
                else
                {
                    if( (_local_10 == 1017) || (_local_10 == 2017) )
                    {
                        _local_7 = _arg_3;
                        _local_8 = _local_6;
                        goto _label_3;
                    };
                    if (_local_10 != 1008)
                    {
                        if (_local_10 != 1160)
                        {
                            if (_local_10 != 2160) goto _label_2;
                        };
                    };
                    _local_7 = _local_5;
                    _local_8 = _arg_3;
                    goto _label_3;
                    
                _label_2: 
                    if( (_local_10 == 2794) || (_local_10 == 2795) )
                    {
                        _local_7 = _arg_3;
                        _local_8 = _arg_3;
                        _local_9 = true;
                        goto _label_3;
                    };
                    throw (("ActionId " + _arg_2.getSpellEffect().actionId) + " is not a spell execution");
                };
            };
            
        _label_3: 
            var _local_11:HaxeSpellEffect = _arg_2.getSpellEffect();
            var _local_12:Boolean = _local_9;
            if (_local_12 == false)
            {
                _local_10 = _local_8.getBeforeLastSpellPosition();
            }
            else
            {
                if (_local_12 == true)
                {
                    _local_10 = _arg_1.targetedCell;
                };
            };
            var _local_13:FightContext = _arg_1.copy();
            _local_13.targetedCell = _local_10;
            _local_12 = _arg_2.getFirstParentEffect().getSpellEffect().isCritical;
            var _local_14:HaxeSpell = ((_local_11.actionId == 1008) ? DamageCalculator.dataInterface.getBombCastOnFighterSpell(_local_11.param1, _local_11.param2) : DamageCalculator.dataInterface.createSpellFromId(_local_11.param1, _local_11.param2));
            if (_local_14 != null)
            {
                return ({
                    "context":_local_13,
                    "caster":_local_7,
                    "spell":_local_14,
                    "isCritical":_local_12
                });
            };
            return (null);
        }

        public static function executeMarks(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:int, _arg_5:Boolean):void
        {
            var _local_7:int;
            var _local_8:* = (null as Mark);
            var _local_9:int;
            var _local_10:* = (null as Array);
            var _local_6:Array = _arg_1.map.getMarkInteractingWithCell(_arg_4);
            if (_local_6 != null)
            {
                _local_7 = 0;
                while (_local_7 < _local_6.length)
                {
                    _local_8 = _local_6[_local_7];
                    _local_7++;
                    if (((_local_8.active) && (_arg_1.triggeredMarks.indexOf(_local_8.markId) == -1)))
                    {
                        switch (_local_8.markType)
                        {
                            default:
                                break;
                            case 2:
                                DamageCalculator.executeMarkSpell(_arg_3, _local_8, _arg_2, _arg_1, _arg_5);
                                break;
                            case 3:
                                DamageCalculator.executeWallDamage(_arg_3, _local_8, _arg_2, _arg_1, _arg_5);
                                break;
                            case 4:
                                _local_9 = _arg_1.map.getOutputPortalCell(_arg_4);
                                _local_10 = _arg_1.map.getMarkInteractingWithCell(_local_9, 4);
                                _arg_1.triggeredMarks.push(_local_8.markId);
                                _arg_1.triggeredMarks.push(_local_10[0].markId);
                                _arg_3.setCurrentPositionCell(_local_9);
                        };
                    };
                };
            };
        }

        public static function executeMarkSpell(_arg_1:HaxeFighter, _arg_2:Mark, _arg_3:RunningEffect, _arg_4:FightContext, _arg_5:Boolean):void
        {
            if (((!(_arg_2.active)) || (FpUtils.arrayContains_Int(_arg_4.triggeredMarks, _arg_2.markId))))
            {
                return;
            };
            _arg_4.triggeredMarks.push(_arg_2.markId);
            var _local_6:FightContext = _arg_4.copy();
            _local_6.targetedCell = _arg_2.mainCell;
            _local_6.inMovement = true;
            var _local_7:HaxeFighter = _arg_4.getFighterById(_arg_2.casterId);
            if (_arg_1 != null)
            {
                _arg_1.savePositionBeforeSpellExecution();
            };
            var _local_8:Boolean = ((_local_7.id != (_arg_4.originalCaster.id)) && (_local_7.playerType == PlayerTypeEnum.HUMAN));
            DamageCalculator.executeSpell(_local_6, _local_7, _arg_2.associatedSpell, _arg_3.forceCritical, _arg_3, _arg_5, _local_8);
        }

        public static function executeWallDamage(_arg_1:HaxeFighter, _arg_2:Mark, _arg_3:RunningEffect, _arg_4:FightContext, _arg_5:Boolean):void
        {
            var _local_8:* = (null as HaxeFighter);
            var _local_9:* = (null as LinkedListNode);
            var _local_10:* = (null as LinkedListNode);
            var _local_11:* = (null as LinkedListNode);
            var _local_6:int;
            var _local_7:Array = DamageCalculator.getBombsLinkedToWall(_arg_1, _arg_4);
            while (_local_6 < _local_7.length)
            {
                _local_8 = _local_7[_local_6];
                _local_6++;
                _local_9 = _local_8._buffs.head;
                while (_local_9 != null)
                {
                    _local_10 = _local_9;
                    _local_9 = _local_9.next;
                    _local_11 = _local_10;
                    if (_local_11.item.effect.actionId == 1027)
                    {
                        _local_8.getSummoner(_arg_4).storePendingBuff(_local_11.item);
                    };
                };
                _local_8.removeBuffByActionId(1027);
            };
            DamageCalculator.executeMarkSpell(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public static function getBombsLinkedToWall(_arg_1:HaxeFighter, _arg_2:FightContext):Array
        {
            var _local_6:int;
            var _local_7:* = (null as HaxeFighter);
            var _local_8:int;
            var _local_9:* = (null as HaxeFighter);
            var _local_3:Array = [];
            var _local_4:Array = [];
            var mainMark:Mark = _arg_2.map.getMarkInteractingWithCell(_arg_1.getCurrentPositionCell(), 3)[0];
            var _local_5:Array = _arg_2.getFightersFromZone(DamageCalculator.WALL_ZONE, mainMark.mainCell, mainMark.mainCell);
            _local_5.sort(function (_arg_1:HaxeFighter, _arg_2:HaxeFighter):int
            {
                return (TargetManagement.comparePositions(mainMark.mainCell, false, _arg_1.getCurrentPositionCell(), _arg_2.getCurrentPositionCell()));
            });
            _local_6 = 0;
            while (_local_6 < _local_5.length)
            {
                _local_7 = _local_5[_local_6];
                _local_6++;
                if (((((_local_7.playerType == (PlayerTypeEnum.MONSTER)) && (_local_7.data.isSummon())) && (!(HaxeFighter.BOMB_BREED_ID.indexOf(_local_7.breed) == -1))) && (_local_7.data.getSummonerId() == mainMark.casterId)))
                {
                    if (_local_3.length == 0)
                    {
                        _local_3.push(_local_7);
                    }
                    else
                    {
                        _local_8 = 0;
                        while (_local_8 < _local_3.length)
                        {
                            _local_9 = _local_3[_local_8];
                            _local_8++;
                            if (_local_3.indexOf(_local_7) == -1)
                            {
                                _local_3.push(_local_7);
                            };
                            if (((((_local_9 != (_local_7)) && (_local_7.breed == _local_9.breed)) && (!(MapTools.getLookDirection4(_local_7.getCurrentPositionCell(), _local_9.getCurrentPositionCell()) == -1))) && (MapTools.getDistance(_local_7.getCurrentPositionCell(), _local_9.getCurrentPositionCell()) <= 7)))
                            {
                                if (_local_4.indexOf(_local_7) == -1)
                                {
                                    _local_4.push(_local_7);
                                };
                                if (_local_4.indexOf(_local_9) == -1)
                                {
                                    _local_4.push(_local_9);
                                };
                                if (_local_4.length == 3)
                                {
                                    return (_local_4);
                                };
                            };
                        };
                    };
                };
            };
            if (((_local_4.length < (3)) && (_local_3.length < 3)))
            {
                _local_6 = 0;
                while (_local_6 < _local_4.length)
                {
                    _local_7 = _local_4[_local_6];
                    _local_6++;
                    if (_local_4.length == 3) break;
                    _local_5 = _arg_2.getFightersFromZone(DamageCalculator.WALL_ZONE, _local_7.getCurrentPositionCell(), _local_7.getCurrentPositionCell());
                    _local_8 = 0;
                    while (_local_8 < _local_5.length)
                    {
                        _local_9 = _local_5[_local_8];
                        _local_8++;
                        if (((((_local_9.data.getSummonerId() == (mainMark.casterId)) && (((_local_9.playerType == (PlayerTypeEnum.MONSTER)) && (_local_9.data.isSummon())) && (!(HaxeFighter.BOMB_BREED_ID.indexOf(_local_9.breed) == -1)))) && (_local_4.indexOf(_local_9) == -1)) && (_local_9.breed == _local_7.breed)))
                        {
                            _local_4.push(_local_9);
                            break;
                        };
                    };
                };
            };
            return (_local_4);
        }

        public static function create32BitHashSpellLevel(_arg_1:int, _arg_2:int):int
        {
            return ((_arg_2 << 24) | _arg_1);
        }


    }
}

