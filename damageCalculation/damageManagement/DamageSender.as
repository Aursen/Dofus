package damageCalculation.damageManagement
{
    import damageCalculation.fighterManagement.HaxeFighter;
    import damageCalculation.spellManagement.HaxeSpellEffect;
    import tools.ActionIdHelper;
    import damageCalculation.FightContext;
    import damageCalculation.spellManagement.RunningEffect;
    import damageCalculation.tools.Interval;
    import haxe.ds._List.ListNode;
    import damageCalculation.spellManagement.HaxeSpell;
    import tools.enumeration.ElementEnum;

    public class DamageSender 
    {

        public static var MIDLIFE_DAMAGE_PERCENT:Array = _local_1;

        public function DamageSender():void
        {
        }

        public static function getTotalDamage(_arg_1:FightContext, _arg_2:RunningEffect, _arg_3:Boolean=false):DamageRange
        {
            var _local_7:int;
            var _local_4:HaxeFighter = _arg_2.getCaster();
            var _local_5:HaxeSpellEffect = _arg_2.getSpellEffect();
            var _local_6:DamageRange = DamageRange.fromSpellEffect(_local_5, _arg_3);
            if (_local_6.elemId == 6)
            {
                _local_6.elemId = _local_4.getBestElement();
            };
            if (_arg_2.getCaster().isUnlucky())
            {
                _local_6.maximizeBy(_local_6.min);
            };
            _local_6.add(_local_4.data.getItemSpellBaseDamageModification(_arg_2.getSpell().id));
            if (ActionIdHelper.isBasedOnCasterLife(_local_5.actionId))
            {
                _local_6 = DamageSender.getDamageBasedOnCasterLife(_arg_2, _local_6);
            };
            if (ActionIdHelper.isSplash(_local_5.actionId))
            {
                _local_6 = DamageSender.getSplashDamage(_arg_2, _local_6);
            };
            if (ActionIdHelper.isBoostable(_local_5.actionId))
            {
                _local_6 = DamageSender.getBoostableDamage(_arg_2, _local_6);
            };
            if (ActionIdHelper.isBasedOnMovementPoints(_local_5.actionId))
            {
                if (_local_4.getCharacteristicValue("movementPoints") <= 0)
                {
                    _local_6.setToZero();
                }
                else
                {
                    _local_7 = _local_4.getCharacteristicValue("movementPoints");
                    _local_6.multiply((_local_7 / (_local_7 + _local_4.data.getUsedPM())));
                };
            };
            _local_6.add(_local_4.data.getItemSpellDamageModification(_arg_2.getSpell().id));
            _local_6.isHeal = ActionIdHelper.isHeal(_local_5.actionId);
            return (_local_6);
        }

        public static function getTotalShield(_arg_1:RunningEffect, _arg_2:Boolean=false):DamageRange
        {
            var _local_7:* = (null as Interval);
            var _local_8:* = (null as Interval);
            var _local_3:HaxeFighter = _arg_1.getCaster();
            var _local_4:HaxeSpellEffect = _arg_1.getSpellEffect();
            var _local_5:DamageRange = new DamageRange(0, 0);
            _local_5.isHeal = true;
            _local_5.isShieldDamage = true;
            _local_5.isCritical = _arg_1.getSpellEffect().isCritical;
            var _local_6:int = _local_4.actionId;
            if (_local_6 == 1040)
            {
                _local_5.addInterval(_local_4.getDamageInterval());
            }
            else
            {
                if (_local_6 == 1039)
                {
                    _local_7 = _local_4.getDamageInterval();
                    _local_8 = new Interval(_local_3.getCharacteristicValue("maxLifePoints"), _local_3.getCharacteristicValue("maxLifePoints"));
                    _local_5.addInterval(_local_8);
                    _local_5.multiplyInterval(_local_7).multiply(0.01);
                }
                else
                {
                    if (_local_6 == 1020)
                    {
                        _local_7 = _local_4.getDamageInterval();
                        _local_8 = new Interval(_local_3.level, _local_3.level).multiplyInterval(_local_7).multiply(0.01);
                        _local_5.addInterval(_local_8);
                    };
                };
            };
            return (_local_5);
        }

        public static function getDamageBasedOnCasterLife(_arg_1:RunningEffect, _arg_2:DamageRange):DamageRange
        {
            var _local_5:* = (null as Interval);
            var _local_6:int;
            var _local_7:* = (null as Interval);
            var _local_3:HaxeFighter = _arg_1.getCaster();
            var _local_4:HaxeSpellEffect = _arg_1.getSpellEffect();
            if (ActionIdHelper.isBasedOnCasterLifePercent(_local_4.actionId))
            {
                _local_5 = _local_3.getPendingLifePoints();
                _arg_2.multiplyInterval(_local_5);
                _arg_2.multiply(0.01);
            }
            else
            {
                if (ActionIdHelper.isBasedOnCasterLifeMissing(_local_4.actionId))
                {
                    _local_5 = _local_3.getPendingMissingLifePoints();
                    _arg_2.multiplyInterval(_local_5);
                    _arg_2.multiply(0.01);
                }
                else
                {
                    if (ActionIdHelper.isBasedOnCasterLifeMissingMaxLife(_local_4.actionId))
                    {
                        _local_6 = (_local_3.getCharacteristicValue("baseMaxLifePoints") - _local_3.getCharacteristicValue("maxLifePoints"));
                        if (_local_6 >= 0)
                        {
                            _arg_2.multiply((_local_6 / 100));
                        };
                    }
                    else
                    {
                        if (ActionIdHelper.isBasedOnCasterLifeMidlife(_local_4.actionId))
                        {
                            _local_5 = _local_3.getPendingLifePoints();
                            _local_7 = new Interval(0, 0);
                            _local_7.min = int((((100 * _local_5.min) / _local_3.getCharacteristicValue("maxLifePoints")) - 50));
                            _local_7.max = int((((100 * _local_5.max) / _local_3.getCharacteristicValue("maxLifePoints")) - 50));
                            _local_7.abs().minimizeBy(0).maximizeBy(50);
                            _arg_2.min = int((_arg_2.min * ((_local_3.getCharacteristicValue("baseMaxLifePoints") * DamageSender.MIDLIFE_DAMAGE_PERCENT[_local_7.min]) / 100)));
                            _arg_2.max = int((_arg_2.max * ((_local_3.getCharacteristicValue("baseMaxLifePoints") * DamageSender.MIDLIFE_DAMAGE_PERCENT[_local_7.max]) / 100)));
                        };
                    };
                };
            };
            return (_arg_2);
        }

        public static function getSplashDamage(_arg_1:RunningEffect, _arg_2:DamageRange):DamageRange
        {
            var _local_4:* = (null as HaxeFighter);
            var _local_5:* = (null as DamageRange);
            var _local_6:* = (null as ListNode);
            var _local_7:* = (null as EffectOutput);
            var _local_8:* = (null as EffectOutput);
            var _local_9:* = (null as DamageRange);
            var _local_3:HaxeSpellEffect = _arg_1.getSpellEffect();
            if (ActionIdHelper.isSplash(_local_3.actionId))
            {
                _local_4 = _arg_1.getCaster();
                _local_5 = DamageRange.ZERO;
                if (((ActionIdHelper.isSplashFinalDamage(_local_3.actionId)) || (ActionIdHelper.isSplashHeal(_local_3.actionId))))
                {
                    _local_6 = _local_4.pendingEffects.h;
                    while (_local_6 != null)
                    {
                        _local_7 = _local_6.item;
                        _local_6 = _local_6.next;
                        _local_8 = _local_7;
                        _local_9 = _local_8.damageRange;
                        if ((((((_local_9 != (null)) && (!(_local_9.isHeal))) && (!(_local_9.isInvulnerable))) && (!(_local_9.isCollision))) && (!((_local_9.min == (0)) && (_local_9.max == 0)))))
                        {
                            _local_5 = _local_9;
                        };
                    };
                }
                else
                {
                    if ((((ActionIdHelper.isSplashRawDamage(_local_3.actionId)) && (!(_local_4.lastRawDamageTaken == null))) && (!(_local_4.lastTheoreticalRawDamageTaken == null))))
                    {
                        if (_local_4.hasStateEffect(6))
                        {
                            _local_5 = _local_4.lastRawDamageTaken;
                        }
                        else
                        {
                            _local_5 = _local_4.lastTheoreticalRawDamageTaken;
                        };
                    };
                };
                _local_5 = _local_5.copy();
                _local_5.multiplyInterval(_local_3.getDamageInterval());
                _local_5.multiply(0.01);
                _arg_2.min = _local_5.min;
                _arg_2.max = _local_5.max;
                _arg_2.elemId = _local_5.elemId;
                if (_local_3.actionId == 1223)
                {
                    _arg_1.getSpellEffect().actionId = ActionIdHelper.getSplashFinalTakenDamageElement(_arg_2.elemId);
                }
                else
                {
                    if (_local_3.actionId == 1123)
                    {
                        _arg_1.getSpellEffect().actionId = ActionIdHelper.getSplashRawTakenDamageElement(_arg_2.elemId);
                    };
                };
            };
            return (_arg_2);
        }

        public static function getBoostableDamage(_arg_1:RunningEffect, _arg_2:DamageRange):DamageRange
        {
            _arg_2.add(DamageSender.baseDamageBonus(_arg_1));
            _arg_2.multiply(DamageSender.percentDamageBonus(_arg_1));
            _arg_2.add(DamageSender.flatDamageBonus(_arg_1));
            if (_arg_1.getSpell().isWeapon)
            {
                _arg_2.multiply(((100 + _arg_1.getCaster().getCharacteristicValue("weaponDamagesBonusPercent")) * 0.01));
            };
            _arg_2.multiply(DamageSender.bombComboBonus(_arg_1));
            return (_arg_2);
        }

        public static function flatDamageBonus(_arg_1:RunningEffect):int
        {
            var _local_2:HaxeFighter = _arg_1.getCaster();
            var _local_3:HaxeSpellEffect = _arg_1.getSpellEffect();
            var _local_4:HaxeSpell = _arg_1.getSpell();
            var _local_5:* = (((ActionIdHelper.isHeal(_local_3.actionId)) ? _local_2.getCharacteristicValue("healBonus") : _local_2.getCharacteristicValue("allDamagesBonus")) + ((_local_4.isTrap) ? _local_2.getCharacteristicValue("trapBonus") : 0));
            if (!ActionIdHelper.isHeal(_local_3.actionId))
            {
                _local_5 = (_local_5 + (_local_2.getElementFlatDamageBonus(ElementEnum.getElementFromActionId(_local_3.actionId)) + (((_local_3.isCritical) && (_arg_1.getSpell().getEffects().indexOf(_local_3) == -1)) ? _local_2.getCharacteristicValue("criticalDamageBonus") : 0)));
            };
            return (_local_5);
        }

        public static function baseDamageBonus(_arg_1:RunningEffect):int
        {
            return (_arg_1.getCaster().getSpellBaseDamageModification(_arg_1.getSpell().id));
        }

        public static function percentDamageBonus(_arg_1:RunningEffect):Number
        {
            var _local_2:HaxeFighter = _arg_1.getCaster();
            var _local_3:HaxeSpellEffect = _arg_1.getSpellEffect();
            var _local_4:HaxeSpell = _arg_1.getSpell();
            var _local_5:int = ElementEnum.getElementFromActionId(_local_3.actionId);
            if (_local_5 == 6)
            {
                _local_5 = _local_2.getBestElement();
            };
            var _local_6:* = (((((((ActionIdHelper.isHeal(_local_3.actionId)) ? 0 : _local_2.getCharacteristicValue("damagesBonusPercent")) + ((_local_4.isTrap) ? _local_2.getCharacteristicValue("trapBonusPercent") : 0)) + ((_local_4.isGlyph) ? _local_2.getCharacteristicValue("glyphPower") : 0)) + ((_local_4.isRune) ? _local_2.getCharacteristicValue("runePower") : 0)) + ((_local_4.isWeapon) ? _local_2.getCharacteristicValue("weaponPower") : (_local_2.getCharacteristicValue("spellPercentDamages") + _local_2.getSpellDamageModification(_arg_1.getSpell().id)))) + _local_2.getElementMainStat(_local_5));
            if (_local_6 < 0)
            {
                _local_6 = 0;
            };
            return ((100 + _local_6) * 0.01);
        }

        public static function bombComboBonus(_arg_1:RunningEffect):Number
        {
            return (1 + (_arg_1.getCaster().getCharacteristicValue("bombCombo") / 100));
        }


    }
}
var _local_3:int;
var _local_4:Number;
var _local_1:Array = [];
var _local_2:int;
while (_local_2 < 51)
{
    _local_3 = _local_2++;
    _local_4 = (Math.cos(((2 * Math.PI) * (_local_3 * 0.01))) + 1);
    _local_1.push(((_local_4 * _local_4) / 4));
};

