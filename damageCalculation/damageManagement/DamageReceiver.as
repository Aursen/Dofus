package damageCalculation.damageManagement
{
    import tools.ActionIdHelper;
    import tools.FpUtils;
    import damageCalculation.FightContext;
    import damageCalculation.spellManagement.RunningEffect;
    import damageCalculation.fighterManagement.HaxeFighter;
    import damageCalculation.spellManagement.HaxeSpellEffect;
    import damageCalculation.tools.Interval;
    import damageCalculation.tools.LinkedListNode;
    import damageCalculation.fighterManagement.HaxeBuff;
    import mapTools.MapTools;

    public class DamageReceiver 
    {

        public static var LIFE_STEAL_MULTIPLICATOR:Number = 0.5;

        public function DamageReceiver():void
        {
        }

        public static function receiveDamageOrHeal(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:DamageRange, _arg_4:HaxeFighter, _arg_5:Boolean=false, _arg_6:Boolean=false):Array
        {
            var _local_9:int;
            var _local_11:Number;
            var _local_12:* = (null as DamageRange);
            var _local_13:int;
            var _local_14:* = (null as EffectOutput);
            var _local_15:Boolean;
            var _local_16:* = (null as DamageRange);
            var _local_7:DamageRange = _arg_3.copy();
            var _local_8:Array = [];
            if (ActionIdHelper.isFakeDamage(_arg_2.getSpellEffect().actionId))
            {
                _local_8 = [EffectOutput.fromDamageRange(_arg_4.id, _local_7)];
            }
            else
            {
                if (_arg_4.underMaximizeRollEffect())
                {
                    _local_7.minimizeBy(_local_7.max);
                };
                _local_9 = _arg_4.getHealOnDamageRatio(_arg_2, _arg_5);
                if ((((_local_9 > (0)) && (!(_local_7.isHeal))) && (!(_arg_4.isInvulnerableTo(_arg_2, _arg_5, _local_7.elemId)))))
                {
                    _local_7.isHeal = true;
                    _local_7.isShieldDamage = false;
                    _local_7.multiply((_local_9 * 0.01));
                };
                _local_8 = ((_local_7.isHeal) ? [DamageReceiver.executeLifePointsWin(_local_7, _arg_4)] : DamageReceiver.receiveDamage(_arg_1, _arg_2, _local_7, _arg_4, _arg_5, _arg_6));
            };
            var _local_10:Array = FpUtils.arrayDistinct_damageCalculation_FighterId(FpUtils.arrayMap_damageCalculation_damageManagement_EffectOutput_damageCalculation_FighterId(_local_8, function (_arg_1:EffectOutput):Number
            {
                return (_arg_1.fighterId);
            }));
            _local_9 = 0;
            while (_local_9 < _local_10.length)
            {
                _local_11 = _local_10[_local_9];
                _local_9++;
                _local_12 = new DamageRange(0, 0);
                _local_13 = 0;
                while (_local_13 < _local_8.length)
                {
                    _local_14 = _local_8[_local_13];
                    _local_13++;
                    if ((((_local_14.fighterId == (_local_11)) && (!(_local_14.damageRange == null))) && (!(_local_14.damageRange.isInvulnerable))))
                    {
                        _local_16 = _local_14.damageRange;
                        _local_15 = (!((_local_16.min == (0)) && (_local_16.max == 0)));
                    }
                    else
                    {
                        _local_15 = false;
                    };
                    if (((_local_15) && (!(_local_14.damageRange.isShieldDamage))))
                    {
                        if (_local_14.damageRange.isHeal)
                        {
                            _local_12.subInterval(_local_14.damageRange);
                        }
                        else
                        {
                            _local_12.addInterval(_local_14.computeLifeDamage());
                        };
                    };
                };
                if ((_arg_1.getFighterById(_local_11).getPendingLifePoints().max - _local_12.min) <= 0)
                {
                    _local_8 = _local_8.concat([EffectOutput.deathOf(_local_11)]);
                };
            };
            return (_local_8);
        }

        public static function receiveDamage(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:DamageRange, _arg_4:HaxeFighter, _arg_5:Boolean=false, _arg_6:Boolean=false):Array
        {
            var _local_10:* = (null as DamageRange);
            var _local_11:* = (null as RunningEffect);
            var _local_12:* = (null as Array);
            var _local_14:* = (null as EffectOutput);
            var _local_7:HaxeSpellEffect = _arg_2.getSpellEffect();
            var _local_8:Array = [];
            var _local_9:* = DamageReceiver.executeDodge(_arg_1, _arg_2, _arg_4, _arg_5, _arg_6);
            if (_local_9.done)
            {
                return (_local_9.damages);
            };
            if (!_arg_3.isCollision)
            {
                _arg_4.lastTheoreticalRawDamageTaken = _arg_3.copy();
                if (!_arg_2.getCaster().hasStateEffect(6))
                {
                    _arg_4.lastRawDamageTaken = _arg_4.lastTheoreticalRawDamageTaken;
                }
                else
                {
                    _local_10 = DamageRange.ZERO;
                    _arg_4.lastRawDamageTaken = _local_10;
                    _arg_3 = _local_10;
                };
                _arg_3.add(-(DamageReceiver.getFlatResistance(_arg_2, _arg_4, _arg_3.elemId)));
                _arg_3.subInterval(_arg_4.getDamageReductor(_arg_2, _arg_3, _arg_5));
                if (((((_arg_3.max > (0)) && (_arg_2.getSpell().canBeReflected)) && (!(_arg_2.isReflect))) && (!(_arg_2.getCaster() == _arg_4))))
                {
                    _local_10 = DamageReceiver.reflectDamages(_arg_1, _arg_2, _arg_3, _arg_4);
                    if (_local_10 != null)
                    {
                        _local_11 = _arg_2.copy();
                        _local_11.isReflect = true;
                        _local_8 = _local_8.concat(DamageReceiver.receiveDamageOrHeal(_arg_1, _local_11, _local_10, _arg_2.getCaster(), _arg_5));
                    };
                };
                _arg_3.multiply((1 - (_arg_4.getElementMainResist(_arg_3.elemId) / 100)));
                _arg_3.minimizeBy(0);
                _local_12 = DamageReceiver.getSplitDamages(_arg_1, _arg_2, _arg_3, _arg_4, _arg_6);
                if (_local_12 != null)
                {
                    return (_local_8.concat(_local_12));
                };
            };
            var _local_13:EffectOutput = DamageReceiver.applyDamages(_arg_2, _arg_4, _arg_3, _arg_5, _arg_6);
            if (((ActionIdHelper.isLifeSteal(_arg_2.getSpellEffect().actionId)) && (!(_arg_2.getCaster() == _arg_4))))
            {
                _local_14 = DamageReceiver.getLifeStealEffect(_local_13.computeLifeDamage(), _arg_2.getCaster());
                if (_local_14 != null)
                {
                    _local_8.push(_local_14);
                };
            };
            if (!_arg_3.isCollision)
            {
                _local_13.fighterId = DamageReceiver.changeTargetIfSacrifice(_arg_1, _arg_2, _local_13, _arg_4, _arg_5);
            };
            _local_8.push(_local_13);
            return (_local_8);
        }

        public static function getPermanentDamage(_arg_1:DamageRange, _arg_2:HaxeFighter):DamageRange
        {
            if (_arg_1.isHeal)
            {
                return (DamageRange.ZERO);
            };
            var _local_3:Number = (Math.floor(Math.max(0, Math.min(_arg_2.getCharacteristicValue("permanentDamagePercent"), 50))) / 100);
            var _local_4:DamageRange = new DamageRange(Math.floor((_arg_1.min * _local_3)), Math.floor((_arg_1.max * _local_3)));
            var _local_5:* = (_arg_2.getCharacteristicValue("lifePoints") - 1);
            return (new DamageRange(Math.floor(Math.min(_local_4.min, _local_5)), Math.floor(Math.min(_local_4.max, _local_5))));
        }

        public static function getDamageBasedOnTargetLife(_arg_1:HaxeSpellEffect, _arg_2:HaxeFighter, _arg_3:DamageRange):DamageRange
        {
            var _local_4:* = (null as Interval);
            if (ActionIdHelper.isBasedOnTargetMaxLife(_arg_1.actionId))
            {
                _arg_3.multiply((_arg_2.getCharacteristicValue("maxLifePoints") / 100));
            }
            else
            {
                if (ActionIdHelper.isBasedOnTargetLifePercent(_arg_1.actionId))
                {
                    _local_4 = _arg_2.getPendingLifePoints();
                    _arg_3.multiplyInterval(_local_4);
                    _arg_3.multiply(0.01);
                }
                else
                {
                    if (ActionIdHelper.isBasedOnTargetLifeMissingMaxLife(_arg_1.actionId))
                    {
                        _arg_3.multiply((_arg_2.getCharacteristicValue("permanentDamagePercent") / 100));
                    };
                };
            };
            return (_arg_3);
        }

        public static function changeTargetIfSacrifice(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:EffectOutput, _arg_4:HaxeFighter, _arg_5:Boolean):Number
        {
            var _local_6:* = (null as Array);
            var _local_7:int;
            var _local_8:Number;
            var _local_9:* = (null as LinkedListNode);
            var _local_10:* = (null as LinkedListNode);
            var _local_11:* = (null as LinkedListNode);
            var _local_12:* = (null as HaxeBuff);
            var _local_13:* = (null as HaxeFighter);
            if (((_arg_2.getSpellEffect().actionId != (80)) && (!(_arg_4.isInvulnerableTo(_arg_2, _arg_5, _arg_3.damageRange.elemId)))))
            {
                _local_6 = _arg_4.getAllSacrificed();
                _local_7 = 0;
                while (_local_7 < _local_6.length)
                {
                    _local_8 = _local_6[_local_7];
                    _local_7++;
                    _local_9 = _arg_4._buffs.head;
                    while (_local_9 != null)
                    {
                        _local_10 = _local_9;
                        _local_9 = _local_9.next;
                        _local_11 = _local_10;
                        _local_12 = _local_11.item;
                        if ((((_local_12.effect.actionId == (765)) && (_local_12.shouldBeTriggeredOnTarget(_arg_3, _arg_2, _arg_4, _arg_5, _arg_1))) && (_local_12.casterId == _local_8)))
                        {
                            _local_13 = _arg_1.getFighterById(_local_8);
                            if (_local_13 != null)
                            {
                                return (_local_13.id);
                            };
                        };
                    };
                };
            };
            return (_arg_4.id);
        }

        public static function applyDamages(_arg_1:RunningEffect, _arg_2:HaxeFighter, _arg_3:DamageRange, _arg_4:Boolean, _arg_5:Boolean):EffectOutput
        {
            if (_arg_2.isInvulnerableTo(_arg_1, _arg_4, _arg_3.elemId))
            {
                _arg_3.isInvulnerable = true;
            };
            _arg_3.minimizeBy(0);
            _arg_3 = DamageReceiver.applyDealtMultiplier(_arg_1, _arg_3, _arg_2, _arg_4);
            var _local_6:EffectOutput = EffectOutput.fromDamageRange(_arg_2.id, _arg_3);
            if (!ActionIdHelper.isFakeDamage(_arg_1.getSpellEffect().actionId))
            {
                _local_6.shield = _arg_2.getPendingShield();
            };
            return (_local_6);
        }

        public static function applyDealtMultiplier(_arg_1:RunningEffect, _arg_2:DamageRange, _arg_3:HaxeFighter, _arg_4:Boolean=false):DamageRange
        {
            var _local_5:HaxeFighter = _arg_1.getCaster();
            if (ActionIdHelper.isBoostable(_arg_1.getSpellEffect().actionId))
            {
                _arg_2.multiply((_local_5.getCurrentDealtDamageMultiplierCategory(_arg_1.getSpell().isWeapon) / 100));
                _arg_2.multiply((_local_5.getCurrentDealtDamageMultiplierMelee(_arg_4) / 100));
                _arg_2.multiply((_arg_3.getCurrentReceivedDamageMultiplierCategory(_arg_1.getSpell().isWeapon) / 100));
                _arg_2.multiply((_arg_3.getCurrentReceivedDamageMultiplierMelee(_arg_4) / 100));
                _arg_2.increaseByPercent(_local_5.getCharacteristicValue("dealtDamagesMultiplicator"));
            };
            _arg_2.multiply((_arg_3.getDamageMultiplicator(_arg_1, _arg_4, _arg_2.isCollision) / 100));
            return (_arg_2);
        }

        public static function reflectDamages(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:DamageRange, _arg_4:HaxeFighter):DamageRange
        {
            var _local_9:* = (null as DamageRange);
            var _local_10:int;
            var _local_5:HaxeSpellEffect = _arg_2.getSpellEffect();
            var _local_6:int = _arg_4.getCharacteristicValue("reflect");
            var _local_7:DamageRange = _arg_4.getDynamicalDamageReflect();
            var _local_8:DamageRange = new DamageRange(_local_6, _local_6);
            _local_8.addInterval(_local_7);
            if (!((_local_8.min == (0)) && (_local_8.max == 0)))
            {
                _local_9 = _arg_3.copy();
                if (ActionIdHelper.isBoostable(_local_5.actionId))
                {
                    _local_10 = _arg_2.getCaster().getCharacteristicValue("dealtDamagesMultiplicator");
                    _local_9.multiply((1 + (_local_10 / 100)));
                };
                _local_9.maximizeByInterval(_local_8);
                _local_10 = _arg_4.getElementMainResist(_arg_3.elemId);
                _local_9.maximizeByInterval(_local_9.copy().multiply((1 - (_local_10 / 100))));
                return (_local_9);
            };
            return (null);
        }

        public static function getFlatResistance(_arg_1:RunningEffect, _arg_2:HaxeFighter, _arg_3:int):int
        {
            var _local_4:HaxeSpellEffect = _arg_1.getSpellEffect();
            var _local_5:Boolean = _arg_1.getSpellEffect().isCritical;
            var _local_6:int;
            if (((_local_5) && (_arg_1.getSpell().getEffects().indexOf(_arg_1.getSpellEffect()) == -1)))
            {
                _local_6 = (_local_6 + _arg_2.getCharacteristicValue("criticalDamageReduction"));
            };
            return (_local_6 + _arg_2.getElementMainReduction(_arg_3));
        }

        public static function getSplitDamages(fightContext:FightContext, runningEffect:RunningEffect, _arg_3:DamageRange, target:HaxeFighter, isPreview:Boolean=false):Array
        {
            var _local_10:* = (null as Array);
            var _local_11:* = (null as Function);
            if (((ActionIdHelper.isDrag(runningEffect.getSpellEffect().actionId)) || (runningEffect.isReflect)))
            {
                return (null);
            };
            var _local_6:Function = function (_arg_1:HaxeFighter):Boolean
            {
                return (!(_arg_1 == null));
            };
            var _local_7:Array = target.getSharingDamageTargets(fightContext);
            if (_local_7.length == 0)
            {
                return (null);
            };
            var _local_8:Array = [];
            var _local_9:int;
            while (_local_9 < _local_7.length)
            {
                _local_10 = _local_7[_local_9];
                _local_9++;
                FpUtils.arrayFilter_damageCalculation_fighterManagement_HaxeFighter(_local_10, _local_6);
                if (_local_10.length != 0)
                {
                    var splitDamage:Array = [_arg_3.copy()];
                    splitDamage[0].multiply((1 / (_local_10.length * _local_7.length)));
                    _local_11 = (function (splitDamage1:Array):Function
                    {
                        return (function (_arg_1:HaxeFighter):Array
                        {
                            var _local_3:* = null;
                            var _local_2:Boolean = MapTools.areCellsAdjacent(runningEffect.getCaster().getCurrentPositionCell(), _arg_1.getCurrentPositionCell());
                            if (_arg_1 != target)
                            {
                                _local_3 = DamageReceiver.executeDodge(fightContext, runningEffect, _arg_1, _local_2, isPreview);
                                if (_local_3.done)
                                {
                                    return (_local_3.damages);
                                };
                            };
                            var _local_4:DamageRange = splitDamage1[0].copy();
                            return ([DamageReceiver.applyDamages(runningEffect, _arg_1, _local_4, _local_2, isPreview)]);
                        });
                    })(splitDamage);
                    _local_8 = _local_8.concat(FpUtils.arrayFold_Array_damageCalculation_damageManagement_EffectOutput_Array_damageCalculation_damageManagement_EffectOutput(FpUtils.arrayMap_damageCalculation_fighterManagement_HaxeFighter_Array_damageCalculation_damageManagement_EffectOutput(_local_10, _local_11), (function ():Function
                    {
                        return (function (_arg_1:Array, _arg_2:Array):Array
                        {
                            return (_arg_2.concat(_arg_1));
                        });
                    })(), []));
                };
            };
            return (_local_8);
        }

        public static function getLifeStealEffect(_arg_1:DamageRange, _arg_2:HaxeFighter):EffectOutput
        {
            var _local_4:* = (null as EffectOutput);
            var _local_5:* = (null as DamageRange);
            var _local_3:EffectOutput;
            if ((((_arg_1.min == (0)) && (_arg_1.max == 0)) && (!(_arg_1.isInvulnerable))))
            {
                _arg_1.multiply(0.5);
                _local_4 = DamageReceiver.executeLifePointsWin(_arg_1, _arg_2);
                _local_5 = _local_4.damageRange;
                if (!((_local_5.min == (0)) && (_local_5.max == 0)))
                {
                    _local_3 = _local_4;
                };
            };
            return (_local_3);
        }

        public static function executeLifePointsWin(_arg_1:DamageRange, _arg_2:HaxeFighter):EffectOutput
        {
            var _local_3:* = (null as Interval);
            _arg_1.isHeal = true;
            if (_arg_2.hasStateEffect(5))
            {
                _arg_1.isInvulnerable = true;
            }
            else
            {
                _local_3 = new Interval(_arg_2.getCharacteristicValue("maxLifePoints"), _arg_2.getCharacteristicValue("maxLifePoints")).subInterval(_arg_2.getPendingLifePoints());
                _arg_1.maximizeByInterval(_local_3.minimizeBy(0));
                _arg_1.minimizeBy(0);
            };
            return (EffectOutput.fromDamageRange(_arg_2.id, _arg_1));
        }

        public static function executeDodge(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:Boolean=false, _arg_5:Boolean=false):Object
        {
            var _local_6:int;
            if ((((_arg_5) && (_arg_4)) && (!(_arg_2.getCaster() == _arg_3))))
            {
                _local_6 = _arg_3.data.resolveDodge();
                if (_local_6 != -1)
                {
                    return ({
                        "done":true,
                        "damages":PushUtils.push(_arg_1, _arg_2, _arg_3, _local_6, true, true, _arg_5)
                    });
                };
            };
            return ({
                "done":false,
                "damages":[]
            });
        }


    }
}

