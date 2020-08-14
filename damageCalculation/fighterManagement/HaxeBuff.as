package damageCalculation.fighterManagement
{
    import damageCalculation.spellManagement.HaxeSpellState;
    import damageCalculation.spellManagement.HaxeSpell;
    import damageCalculation.spellManagement.HaxeSpellEffect;
    import damageCalculation.DamageCalculator;
    import damageCalculation.spellManagement.RunningEffect;
    import tools.enumeration.ElementEnum;
    import tools.ActionIdHelper;
    import damageCalculation.damageManagement.EffectOutput;
    import damageCalculation.FightContext;
    import damageCalculation.damageManagement.DamageRange;

    public class HaxeBuff 
    {

        public var triggerCount:int;
        public var spellState:HaxeSpellState = null;
        public var spell:HaxeSpell;
        public var hasBeenTriggeredOn:Array = [];
        public var effect:HaxeSpellEffect;
        public var casterId:Number;

        public function HaxeBuff(_arg_1:Number, _arg_2:HaxeSpell, _arg_3:HaxeSpellEffect, _arg_4:int=0):void
        {
            spell = _arg_2;
            casterId = _arg_1;
            effect = _arg_3;
            triggerCount = _arg_4;
            if (effect.actionId == 950)
            {
                spellState = DamageCalculator.dataInterface.createStateFromId(_arg_3.param3);
            };
        }

        public static function fromRunningEffect(_arg_1:RunningEffect):HaxeBuff
        {
            return (new HaxeBuff(_arg_1.getCaster().id, _arg_1.getSpell(), _arg_1.getSpellEffect()));
        }


        public function shouldBeTriggeredOnTargetDamage(_arg_1:RunningEffect, _arg_2:HaxeFighter, _arg_3:Boolean, _arg_4:Boolean=false):Boolean
        {
            var _local_5:HaxeSpellEffect = _arg_1.getSpellEffect();
            var _local_6:HaxeSpell = _arg_1.getSpell();
            var _local_7:HaxeFighter = _arg_1.getCaster();
            if (((effect.triggers.indexOf("D") != (-1)) && (!(_arg_4))))
            {
                return (true);
            };
            var _local_8:int = ElementEnum.getElementFromActionId(_local_5.actionId);
            if (_local_8 == 6)
            {
                _local_8 = _arg_1.getCaster().getBestElement();
            };
            switch (_local_8)
            {
                default:
                    break;
                case 0:
                    if (effect.triggers.indexOf("DN") != -1)
                    {
                        return (true);
                    };
                    break;
                case 1:
                    if (effect.triggers.indexOf("DE") != -1)
                    {
                        return (true);
                    };
                    break;
                case 2:
                    if (effect.triggers.indexOf("DF") != -1)
                    {
                        return (true);
                    };
                    break;
                case 3:
                    if (effect.triggers.indexOf("DW") != -1)
                    {
                        return (true);
                    };
                    break;
                case 4:
                    if (effect.triggers.indexOf("DA") != -1)
                    {
                        return (true);
                    };
            };
            if (((_local_6.isGlyph) && (!(effect.triggers.indexOf("DG") == -1))))
            {
                return (true);
            };
            if (((_local_6.isTrap) && (!(effect.triggers.indexOf("DT") == -1))))
            {
                return (true);
            };
            if (((_local_7.data.isSummon()) && (!(effect.triggers.indexOf("DI") == -1))))
            {
                return (true);
            };
            if ((_local_7.teamId == _arg_2.teamId))
            {
                if (effect.triggers.indexOf("DBA") != -1)
                {
                    return (true);
                };
                if (((_local_5.isCritical) && (!(effect.triggers.indexOf("CCBA") == -1))))
                {
                    return (true);
                };
            }
            else
            {
                if (effect.triggers.indexOf("DBE") != -1)
                {
                    return (true);
                };
                if (((_local_5.isCritical) && (!(effect.triggers.indexOf("CCBE") == -1))))
                {
                    return (true);
                };
            };
            if (_arg_3)
            {
                if (effect.triggers.indexOf("DM") != -1)
                {
                    return (true);
                };
            }
            else
            {
                if (effect.triggers.indexOf("DR") != -1)
                {
                    return (true);
                };
            };
            if (_arg_4)
            {
                if (effect.triggers.indexOf("PD") != -1)
                {
                    return (true);
                };
                if (((_arg_1.getSpellEffect().param2 == (0)) && (!(effect.triggers.indexOf("PMD") == -1))))
                {
                    return (true);
                };
                if (effect.triggers.indexOf("PPD") != -1)
                {
                    return (true);
                };
            };
            if (_local_6.isWeapon)
            {
                if (effect.triggers.indexOf("DCAC") != -1)
                {
                    return (true);
                };
            }
            else
            {
                if (((effect.triggers.indexOf("DS") != (-1)) && ((_arg_1.getParentEffect() == (null)) || (!(_arg_1.getParentEffect().isTriggered)))))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function shouldBeTriggeredOnTarget(_arg_1:EffectOutput, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:Boolean, _arg_5:FightContext=undefined):Boolean
        {
            if (!_arg_3.isAlive())
            {
                if (((_arg_1.death) && (!(effect.triggers.indexOf("X") == -1))))
                {
                    return (true);
                };
                return (false);
            };
            if (((_arg_1.isPushed) && (!(effect.triggers.indexOf("P") == -1))))
            {
                return (true);
            };
            if (((_arg_1.isPulled) && (!(effect.triggers.indexOf("MA") == -1))))
            {
                return (true);
            };
            if (((_arg_1.throughPortal) && (!(effect.triggers.indexOf("PT") == -1))))
            {
                return (true);
            };
            if ((((_arg_1.movement != (null)) && (_arg_5.map.isCellWalkable(_arg_1.movement.newPosition))) && (!(effect.triggers.indexOf("M") == -1))))
            {
                return (true);
            };
            if ((((_arg_1.movement != (null)) && (!(_arg_1.movement.swappedWith == null))) && (!(effect.triggers.indexOf("MS") == -1))))
            {
                return (true);
            };
            if (((_arg_1.apStolen > (0)) && (!(effect.triggers.indexOf("APA") == -1))))
            {
                return (true);
            };
            if (((_arg_1.amStolen > (0)) && (!(effect.triggers.indexOf("MPA") == -1))))
            {
                return (true);
            };
            if (((_arg_1.rangeStolen > (0)) && (!(effect.triggers.indexOf("R") == -1))))
            {
                return (true);
            };
            if (((_arg_1.dispell) && (!(effect.triggers.indexOf("DIS") == -1))))
            {
                return (true);
            };
            if (((_arg_1.newStateId != (-1)) && (hasTriggerState(_arg_1.newStateId, true))))
            {
                return (true);
            };
            if (((_arg_1.lostStateId != (-1)) && (hasTriggerState(_arg_1.lostStateId, false))))
            {
                return (true);
            };
            if (((_arg_1.areLifePointsAffected) && (!(effect.triggers.indexOf("VA") == -1))))
            {
                return (true);
            };
            if (((_arg_1.areMaxLifePointsAffected) && (!(effect.triggers.indexOf("VM") == -1))))
            {
                return (true);
            };
            if (((_arg_1.areErodedLifePointsAffected) && (!(effect.triggers.indexOf("VE") == -1))))
            {
                return (true);
            };
            if (((_arg_1.get_isLifeAffected()) && (!(effect.triggers.indexOf("V") == -1))))
            {
                return (true);
            };
            if (_arg_1.damageRange != null)
            {
                if (_arg_1.damageRange.isCollision)
                {
                    if (effect.triggers.indexOf("PD") != -1)
                    {
                        return (true);
                    };
                    if (((_arg_2.getSpellEffect().param2 == (0)) && (!(effect.triggers.indexOf("PMD") == -1))))
                    {
                        return (true);
                    };
                    if (effect.triggers.indexOf("PPD") != -1)
                    {
                        return (true);
                    };
                }
                else
                {
                    if (((_arg_1.damageRange.isHeal) && (_arg_1.damageRange.isShieldDamage)))
                    {
                        return (false);
                    };
                    if (_arg_1.damageRange.isHeal)
                    {
                        if (((effect.triggers.indexOf("H") != (-1)) && (!(ActionIdHelper.isLifeSteal(_arg_2.getSpellEffect().actionId)))))
                        {
                            return (true);
                        };
                        return (false);
                    };
                    return (shouldBeTriggeredOnTargetDamage(_arg_2, _arg_3, _arg_4, _arg_1.damageRange.isCollision));
                };
            };
            return (false);
        }

        public function shouldBeTriggeredOnCaster(_arg_1:EffectOutput, _arg_2:RunningEffect, _arg_3:HaxeFighter, _arg_4:Boolean, _arg_5:FightContext=undefined):Boolean
        {
            var _local_9:Boolean;
            var _local_10:* = (null as DamageRange);
            if (!_arg_3.isAlive())
            {
                return (false);
            };
            var _local_6:HaxeSpell = _arg_2.getSpell();
            var _local_7:HaxeSpellEffect = _arg_2.getSpellEffect();
            var _local_8:HaxeFighter = _arg_2.getCaster();
            if (((_arg_1.attemptedApTheft) && (!(effect.triggers.indexOf("CAPA") == -1))))
            {
                return (true);
            };
            if (((_arg_1.attemptedAmTheft) && (!(effect.triggers.indexOf("CMPA") == -1))))
            {
                return (true);
            };
            if ((((_arg_1.damageRange != (null)) && (_arg_1.damageRange.isCritical)) && (!(effect.triggers.indexOf("CC") == -1))))
            {
                return (true);
            };
            if (_arg_1.damageRange != null)
            {
                _local_10 = _arg_1.damageRange;
                _local_9 = (!((_local_10.min == (0)) && (_local_10.max == 0)));
            }
            else
            {
                _local_9 = false;
            };
            if (_local_9)
            {
                if ((((_arg_1.damageRange.isHeal) && (!(_arg_1.damageRange.isShieldDamage))) && (!(effect.triggers.indexOf("CH") == -1))))
                {
                    return (true);
                };
                if ((((_arg_1.damageRange.isHeal) && (_arg_1.damageRange.isShieldDamage)) && (!(effect.triggers.indexOf("CS") == -1))))
                {
                    return (true);
                };
                switch (_arg_1.damageRange.elemId)
                {
                    default:
                        break;
                    case 0:
                        if (effect.triggers.indexOf("CDN") != -1)
                        {
                            return (true);
                        };
                        break;
                    case 1:
                        if (effect.triggers.indexOf("CDE") != -1)
                        {
                            return (true);
                        };
                        break;
                    case 2:
                        if (effect.triggers.indexOf("CDF") != -1)
                        {
                            return (true);
                        };
                        break;
                    case 3:
                        if (effect.triggers.indexOf("CDW") != -1)
                        {
                            return (true);
                        };
                        break;
                    case 4:
                        if (effect.triggers.indexOf("CDA") != -1)
                        {
                            return (true);
                        };
                };
                if ((_local_8.teamId == _arg_3.teamId))
                {
                    if (effect.triggers.indexOf("CAA") != -1)
                    {
                        return (true);
                    };
                }
                else
                {
                    if (effect.triggers.indexOf("CAE") != -1)
                    {
                        return (true);
                    };
                };
                if (_arg_4)
                {
                    if (effect.triggers.indexOf("CDM") != -1)
                    {
                        return (true);
                    };
                }
                else
                {
                    if (effect.triggers.indexOf("CDR") != -1)
                    {
                        return (true);
                    };
                };
                if (_local_6.isWeapon)
                {
                    if (effect.triggers.indexOf("CDCAC") != -1)
                    {
                        return (true);
                    };
                }
                else
                {
                    if (effect.triggers.indexOf("CDS") != -1)
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        public function isTriggeredByParent(_arg_1:RunningEffect):Boolean
        {
            var _local_2:RunningEffect = _arg_1;
            while (_local_2 != null)
            {
                if ((_local_2.getSpellEffect().id == effect.id))
                {
                    return (true);
                };
                _local_2 = _local_2.getParentEffect();
            };
            return (false);
        }

        public function isState():Boolean
        {
            return (effect.actionId == 950);
        }

        public function hasTriggerState(_arg_1:int, _arg_2:Boolean):Boolean
        {
            var _local_5:* = (null as String);
            var _local_3:int;
            var _local_4:Array = effect.triggers;
            while (_local_3 < _local_4.length)
            {
                _local_5 = _local_4[_local_3];
                _local_3++;
                if (_arg_2)
                {
                    if (((_local_5.indexOf("EON") == (0)) && (Std.parseInt(_local_5.substr("EON".length)) == _arg_1)))
                    {
                        return (true);
                    };
                }
                else
                {
                    if (((_local_5.indexOf("EOFF") == (0)) && (Std.parseInt(_local_5.substr("EOFF".length)) == _arg_1)))
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        public function hasTrigger(_arg_1:String):Boolean
        {
            return (!(effect.triggers.indexOf(_arg_1) == -1));
        }

        public function getActionId():int
        {
            return (effect.actionId);
        }

        public function createBasicRunningEffect(_arg_1:FightContext):RunningEffect
        {
            var _local_2:* = (null as HaxeSpellEffect);
            if (effect.isCritical)
            {
                _local_2 = effect.clone();
                _local_2.isCritical = false;
            }
            else
            {
                _local_2 = effect;
            };
            return (new RunningEffect(_arg_1.getFighterById(casterId), spell, _local_2));
        }

        public function canBeTriggeredBy(_arg_1:RunningEffect):Boolean
        {
            if (!ActionIdHelper.canTriggerDamageMultiplier(_arg_1.getSpellEffect().actionId))
            {
                if (effect.actionId == 1163)
                {
                    return (false);
                };
                if (effect.actionId == 265)
                {
                    return (false);
                };
            };
            if (effect.actionId == 1159)
            {
                if (!ActionIdHelper.canTriggerHealMultiplier(_arg_1.getSpellEffect().actionId))
                {
                    return (false);
                };
            }
            else
            {
                if (((ActionIdHelper.isSplash(_arg_1.getSpellEffect().actionId)) && (!(effect.actionId == 1163))))
                {
                    return (false);
                };
            };
            if (((ActionIdHelper.isHeal(_arg_1.getSpellEffect().actionId)) && (!(ActionIdHelper.canTriggerOnHeal(_arg_1.getSpellEffect().actionId)))))
            {
                return (false);
            };
            if (((ActionIdHelper.isDamage(_arg_1.getSpellEffect().category)) && (!(ActionIdHelper.canTriggerOnDamage(_arg_1.getSpellEffect().actionId)))))
            {
                return (false);
            };
            if (((isTriggeredByParent(_arg_1)) && (!(_arg_1.getSpell().canAlwaysTriggerSpells))))
            {
                return (false);
            };
            if (_arg_1.isTriggered)
            {
                return (false);
            };
            return (true);
        }


    }
} damageCalculation.fighterManagement

