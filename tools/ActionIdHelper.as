package tools
{
    import haxe.IMap;

    public class ActionIdHelper 
    {

        public static var STAT_BUFF_ACTION_IDS:Array = [283, 293, 110, 118, 125, 2844, 123, 119, 126, 124, 422, 424, 426, 428, 430, 138, 112, 165, 1054, 414, 416, 418, 420, 1171, 2808, 2812, 2800, 2804, 2802, 2806, 2814, 2810, 178, 2872, 226, 225, 1166, 1167, 240, 243, 241, 242, 244, 1076, 111, 128, 1144, 182, 210, 211, 212, 213, 214, 117, 115, 174, 176, 1039, 1040, 220, 158, 161, 160, 752, 753, 776, 412, 410, 121, 150, 2846, 2848, 2852, 2850, 2854, 2856, 2858, 2860, 2836, 2838, 2840, 2834, 2842, 2844];
        public static var STAT_DEBUFF_ACTION_IDS:Array = [157, 153, 2845, 152, 154, 155, 156, 423, 425, 427, 429, 431, 186, 145, 415, 417, 419, 421, 1172, 2809, 2813, 2801, 2805, 2803, 2807, 2815, 2811, 179, 245, 248, 246, 247, 249, 1077, 168, 169, 215, 216, 217, 218, 219, 116, 171, 175, 177, 159, 163, 162, 754, 755, 413, 411, 2857, 2855, 2861, 2859, 2853, 2851, 2849, 2847, 2843, 2841, 2839, 2837, 2835];
        public static var actionIdToStatNameMap:IMap = _local_1;

        public function ActionIdHelper():void
        {
        }

        public static function isBasedOnCasterLife(_arg_1:int):Boolean
        {
            if (!(((ActionIdHelper.isBasedOnCasterLifePercent(_arg_1)) || (ActionIdHelper.isBasedOnCasterLifeMidlife(_arg_1))) || (ActionIdHelper.isBasedOnCasterLifeMissing(_arg_1))))
            {
                return (ActionIdHelper.isBasedOnCasterLifeMissingMaxLife(_arg_1));
            };
            return (true);
        }

        public static function isBasedOnCasterLifePercent(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
                
            outer_block:
            {

                if (_local_2 != 85)
                {
                    if (_local_2 != 86)
                    {
                        if (_local_2 != 87)
                        {
                            if (_local_2 != 88)
                            {
                                if (_local_2 != 89)
                                {
                                    if (_local_2 != 90)
                                    {
                                        if (_local_2 != 671) return (false); //break outer_block;
                                    };
                                };
                            };
                        };
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }

        public static function isBasedOnCasterLifeMissing(_arg_1:int):Boolean
        {
            if ((((((_arg_1 == (279)) || (_arg_1 == 275)) || (_arg_1 == 276)) || (_arg_1 == 277)) || (_arg_1 == 278)))
            {
                return (true);
            };
            return (false);
        }

        public static function isBasedOnCasterLifeMissingMaxLife(_arg_1:int):Boolean
        {
            if ((((((_arg_1 == (1118)) || (_arg_1 == 1121)) || (_arg_1 == 1122)) || (_arg_1 == 1119)) || (_arg_1 == 1120)))
            {
                return (true);
            };
            return (false);
        }

        public static function isBasedOnCasterLifeMidlife(_arg_1:int):Boolean
        {
            return (_arg_1 == 672);
        }

        public static function isSplash(_arg_1:int):Boolean
        {
            if (!ActionIdHelper.isSplashDamage(_arg_1))
            {
                return (ActionIdHelper.isSplashHeal(_arg_1));
            };
            return (true);
        }

        public static function isSplashDamage(_arg_1:int):Boolean
        {
            if (!ActionIdHelper.isSplashFinalDamage(_arg_1))
            {
                return (ActionIdHelper.isSplashRawDamage(_arg_1));
            };
            return (true);
        }

        public static function isSplashFinalDamage(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
                
            outer_block:
            {

                if (_local_2 != 1223)
                {
                    if (_local_2 != 1224)
                    {
                        if (_local_2 != 1225)
                        {
                            if (_local_2 != 1226)
                            {
                                if (_local_2 != 1227)
                                {
                                    if (_local_2 != 1228) return (false); //break outer_block;
                                };
                            };
                        };
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }

        public static function isSplashRawDamage(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
                
            outer_block:
            {

                if (_local_2 != 1123)
                {
                    if (_local_2 != 1124)
                    {
                        if (_local_2 != 1125)
                        {
                            if (_local_2 != 1126)
                            {
                                if (_local_2 != 1127)
                                {
                                    if (_local_2 != 1128) return (false); //break outer_block;
                                };
                            };
                        };
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }

        public static function isSplashHeal(_arg_1:int):Boolean
        {
            if (_arg_1 == 2020)
            {
                return (true);
            };
            return (false);
        }

        public static function isBasedOnMovementPoints(_arg_1:int):Boolean
        {
            if ((((((_arg_1 == (1012)) || (_arg_1 == 1013)) || (_arg_1 == 1016)) || (_arg_1 == 1015)) || (_arg_1 == 1014)))
            {
                return (true);
            };
            return (false);
        }

        public static function isBasedOnTargetLifePercent(_arg_1:int):Boolean
        {
            if (((((((_arg_1 == (1071)) || (_arg_1 == 1068)) || (_arg_1 == 1070)) || (_arg_1 == 1067)) || (_arg_1 == 1069)) || (_arg_1 == 1048)))
            {
                return (true);
            };
            return (false);
        }

        public static function isTargetMaxLifeAffected(_arg_1:int):Boolean
        {
            if (!((((((((_arg_1 == (1037)) || (_arg_1 == 153)) || (_arg_1 == 1033)) || (_arg_1 == 125)) || (_arg_1 == 1078)) || (_arg_1 == 610)) || (_arg_1 == 267)) || (_arg_1 == 2844)))
            {
                return (_arg_1 == 2845);
            };
            return (true);
        }

        public static function isBasedOnTargetLife(_arg_1:int):Boolean
        {
            if (!((ActionIdHelper.isBasedOnTargetLifePercent(_arg_1)) || (ActionIdHelper.isBasedOnTargetMaxLife(_arg_1))))
            {
                return (ActionIdHelper.isBasedOnTargetLifeMissingMaxLife(_arg_1));
            };
            return (true);
        }

        public static function isBasedOnTargetMaxLife(_arg_1:int):Boolean
        {
            return (_arg_1 == 1109);
        }

        public static function isBasedOnTargetLifeMissingMaxLife(_arg_1:int):Boolean
        {
            if ((((((_arg_1 == (1092)) || (_arg_1 == 1095)) || (_arg_1 == 1096)) || (_arg_1 == 1093)) || (_arg_1 == 1094)))
            {
                return (true);
            };
            return (false);
        }

        public static function isBoostable(_arg_1:int):Boolean
        {
            var _local_2:Boolean;
            var _local_3:int = _arg_1;
            if (_local_3 != 80)
            {
                if (_local_3 != 82)
                {
                    if (_local_3 != 144)
                    {
                        if (_local_3 != 1063)
                        {
                            if (_local_3 != 1064)
                            {
                                if (_local_3 != 1065)
                                {
                                    //unresolved if
                                };
                            };
                        };
                    };
                };
            };
            return (false);
            _local_2 = (((ActionIdHelper.isBasedOnCasterLife(_arg_1)) || (ActionIdHelper.isBasedOnTargetLife(_arg_1))) || (ActionIdHelper.isSplash(_arg_1)));
            if (_local_2 == true)
            {
                return (false);
            };
            return (true);
        }

        public static function isLifeSteal(_arg_1:int):Boolean
        {
            if (((((((_arg_1 == (95)) || (_arg_1 == 82)) || (_arg_1 == 92)) || (_arg_1 == 94)) || (_arg_1 == 91)) || (_arg_1 == 93)))
            {
                return (true);
            };
            return (false);
        }

        public static function isHeal(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
                
            outer_block:
            {

                if (_local_2 != 81)
                {
                    if (_local_2 != 90)
                    {
                        if (_local_2 != 108)
                        {
                            if (_local_2 != 143)
                            {
                                if (_local_2 != 407)
                                {
                                    if (_local_2 != 786)
                                    {
                                        if (_local_2 != 1037)
                                        {
                                            if (_local_2 != 1109)
                                            {
                                                if (_local_2 != 2020) return (false); //break outer_block;
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }

        public static function isShield(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
                
            outer_block:
            {

                if (_local_2 != 1020)
                {
                    if (_local_2 != 1039)
                    {
                        if (_local_2 != 1040) return (false); //break outer_block;
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }

        public static function isTargetMarkDispell(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
                
            outer_block:
            {

                if (_local_2 != 2018)
                {
                    if (_local_2 != 2019)
                    {
                        if (_local_2 != 2024) return (false); //break outer_block;
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }

        public static function isStatBoost(_arg_1:int):Boolean
        {
            switch (_arg_1)
            {
                default:
                    return (false);
                case 266:
                case 268:
                case 269:
                case 270:
                case 271:
                case 414:
                    return (true);
                    return; //dead code
            };
        }

        public static function statBoostToStatName(_arg_1:int):String
        {
            switch (_arg_1)
            {
                default:
                    return (null);
                case 266:
                    return ("chance");
                case 268:
                    return ("agility");
                case 269:
                    return ("intelligence");
                case 270:
                    return ("wisdom");
                case 271:
                    return ("strength");
                    return; //dead code
            };
        }

        public static function statBoostToBuffActionId(_arg_1:int):int
        {
            switch (_arg_1)
            {
                default:
                    return (0);
                case 266:
                    return (123);
                case 268:
                    return (119);
                case 269:
                    return (126);
                case 270:
                    return (124);
                case 271:
                    return (118);
                    return; //dead code
            };
        }

        public static function statBoostToDebuffActionId(_arg_1:int):int
        {
            switch (_arg_1)
            {
                default:
                    return (-1);
                case 266:
                    return (152);
                case 268:
                    return (154);
                case 269:
                    return (155);
                case 270:
                    return (156);
                case 271:
                    return (157);
                    return; //dead code
            };
        }

        public static function isDamage(_arg_1:int):Boolean
        {
            if (_arg_1 == 2)
            {
                return (true);
            };
            return (false);
        }

        public static function isPush(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
                
            outer_block:
            {

                if (_local_2 != 5)
                {
                    if (_local_2 != 1021)
                    {
                        if (_local_2 != 1041)
                        {
                            if (_local_2 != 1103) return (false); //break outer_block;
                        };
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }

        public static function isPull(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
                
            outer_block:
            {

                if (_local_2 != 6)
                {
                    if (_local_2 != 1022)
                    {
                        if (_local_2 != 1042) return (false); //break outer_block;
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }

        public static function isForcedDrag(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
            if( (_local_2 == 1021) || (_local_2 == 1022) )
            {
                return (true);
            };
            return (false);
        }

        public static function isDrag(_arg_1:int):Boolean
        {
            if (!ActionIdHelper.isPush(_arg_1))
            {
                return (ActionIdHelper.isPull(_arg_1));
            };
            return (true);
        }

        public static function allowCollisionDamages(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
            if( (_local_2 == 5) || (_local_2 == 1041) )
            {
                return (true);
            };
            return (false);
        }

        public static function isSummon(_arg_1:int):Boolean
        {
            var _local_2:Boolean;
            var _local_3:int = _arg_1;
            if (_local_3 == 181)
            {
                _local_2 = ActionIdHelper.isSummonWithSlot(_arg_1);
                if (_local_2 == true)
                {
                    return (true);
                };
                return (true);
            };
                
            outer_block:
            {

                if (_local_3 != 780)
                {
                    if (_local_3 != 1008)
                    {
                        if (_local_3 != 1097)
                        {
                            if (_local_3 != 1189) break outer_block;
                        };
                    };
                };
                return (true);
            
            }//outer_block
            _local_2 = ActionIdHelper.isSummonWithSlot(_arg_1);
            if (_local_2 == true)
            {
                return (true);
            };
            return (false);
        }

        public static function isSummonWithSlot(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
                
            outer_block:
            {

                if (_local_2 != 180)
                {
                    if (_local_2 != 405)
                    {
                        if (_local_2 != 1011)
                        {
                            if (_local_2 != 1034)
                            {
                                if (_local_2 != 2796) return (false); //break outer_block;
                            };
                        };
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }

        public static function isSummonWithoutTarget(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
                
            outer_block:
            {

                if (_local_2 != 180)
                {
                    if (_local_2 != 181)
                    {
                        if (_local_2 != 780)
                        {
                            if (_local_2 != 1008)
                            {
                                if (_local_2 != 1011)
                                {
                                    if (_local_2 != 1034)
                                    {
                                        if (_local_2 != 1097)
                                        {
                                            if (_local_2 != 1189) return (false); //break outer_block;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }

        public static function isKillAndSummon(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
            if( (_local_2 == 405) || (_local_2 == 2796) )
            {
                return (true);
            };
            return (false);
        }

        public static function isRevive(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
            if( (_local_2 == 780) || (_local_2 == 1034) )
            {
                return (true);
            };
            return (false);
        }

        public static function getSplashFinalTakenDamageElement(_arg_1:int):int
        {
            switch (_arg_1)
            {
                default:
                    return (1223);
                case 0:
                    return (1224);
                case 1:
                    return (1228);
                case 2:
                    return (1226);
                case 3:
                    return (1227);
                case 4:
                    return (1225);
                    return; //dead code
            };
        }

        public static function getSplashRawTakenDamageElement(_arg_1:int):int
        {
            switch (_arg_1)
            {
                default:
                    return (1123);
                case 0:
                    return (1124);
                case 1:
                    return (1128);
                case 2:
                    return (1126);
                case 3:
                    return (1127);
                case 4:
                    return (1125);
                    return; //dead code
            };
        }

        public static function isFakeDamage(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
                
            outer_block:
            {

                if (_local_2 != 90)
                {
                    if (_local_2 != 1047)
                    {
                        if (_local_2 != 1048) return (false); //break outer_block;
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }

        public static function isSpellExecution(_arg_1:int):Boolean
        {
            if (((((((((((((_arg_1 == (1160)) || (_arg_1 == 2160)) || (_arg_1 == 1019)) || (_arg_1 == 1018)) || (_arg_1 == 792)) || (_arg_1 == 2792)) || (_arg_1 == 2794)) || (_arg_1 == 2795)) || (_arg_1 == 1017)) || (_arg_1 == 2017)) || (_arg_1 == 793)) || (_arg_1 == 2793)))
            {
                return (true);
            };
            return (false);
        }

        public static function isTeleport(_arg_1:int):Boolean
        {
            var _local_2:Boolean;
            var _local_3:int = _arg_1;
                
            outer_block:
            {

                if (_local_3 != 4)
                {
                    if (_local_3 != 1099)
                    {
                        if (_local_3 != 1100)
                        {
                            if (_local_3 != 1101)
                            {
                                if (_local_3 != 1104)
                                {
                                    if (_local_3 != 1105)
                                    {
                                        if (_local_3 != 1106) break outer_block;
                                    };
                                };
                            };
                        };
                    };
                };
                return (true);
            
            }//outer_block
            _local_2 = ActionIdHelper.isExchange(_arg_1);
            if (_local_2 == true)
            {
                return (true);
            };
            return (false);
        }

        public static function isExchange(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
            if( (_local_2 == 8) || (_local_2 == 1023) )
            {
                return (true);
            };
            return (false);
        }

        public static function canTeleportOverBreedSwitchPos(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
                
            outer_block:
            {

                if (_local_2 != 4)
                {
                    if (_local_2 != 8)
                    {
                        if (_local_2 != 1023) return (false); //break outer_block;
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }

        public static function allowAOEMalus(_arg_1:int):Boolean
        {
            if ((((ActionIdHelper.isSplash(_arg_1)) && (false)) || (ActionIdHelper.isShield(_arg_1))))
            {
                return (false);
            };
            return (true);
        }

        public static function canTriggerHealMultiplier(_arg_1:int):Boolean
        {
            if (_arg_1 == 90)
            {
                return (false);
            };
            return (true);
        }

        public static function canTriggerDamageMultiplier(_arg_1:int):Boolean
        {
            if (_arg_1 == 90)
            {
                return (false);
            };
            return (true);
        }

        public static function canTriggerOnHeal(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
            if( (_local_2 == 90) || (_local_2 == 786) )
            {
                return (false);
            };
            return (true);
        }

        public static function canTriggerOnDamage(_arg_1:int):Boolean
        {
            if (_arg_1 == 1048)
            {
                return (false);
            };
            return (true);
        }

        public static function StatToBuffPercentActionIds(_arg_1:String):int
        {
            var _local_2:String = _arg_1;
            if (_local_2 == "actionPoints")
            {
                return (2846);
            };
            if (_local_2 == "agility")
            {
                return (2836);
            };
            if (_local_2 == "chance")
            {
                return (2840);
            };
            if (_local_2 == "intelligence")
            {
                return (2838);
            };
            if( (_local_2 == "maxMouvementPoints") || (_local_2 == "movementPoints") )
            {
                return (2848);
            };
            if (_local_2 == "strength")
            {
                return (2834);
            };
            if (_local_2 == "vitality")
            {
                return (2844);
            };
            if (_local_2 == "wisdom")
            {
                return (2842);
            };
            return (-1);
        }

        public static function StatToDebuffPercentActionIds(_arg_1:String):int
        {
            var _local_2:String = _arg_1;
            if (_local_2 == "actionPoints")
            {
                return (2847);
            };
            if (_local_2 == "agility")
            {
                return (2837);
            };
            if (_local_2 == "chance")
            {
                return (2841);
            };
            if (_local_2 == "intelligence")
            {
                return (2839);
            };
            if( (_local_2 == "maxMouvementPoints") || (_local_2 == "movementPoints") )
            {
                return (2848);
            };
            if (_local_2 == "strength")
            {
                return (2835);
            };
            if (_local_2 == "vitality")
            {
                return (2845);
            };
            if (_local_2 == "wisdom")
            {
                return (2843);
            };
            return (-1);
        }

        public static function StatToBuffActionIds(_arg_1:String):int
        {
            var _local_2:String = _arg_1;
            if (_local_2 == "actionPoints")
            {
                return (111);
            };
            if (_local_2 == "agility")
            {
                return (119);
            };
            if (_local_2 == "airDamageBonus")
            {
                return (428);
            };
            if (_local_2 == "airElementReduction")
            {
                return (242);
            };
            if (_local_2 == "airElementResistPercent")
            {
                return (212);
            };
            if (_local_2 == "allDamagesBonus")
            {
                return (112);
            };
            if (_local_2 == "bombCombo")
            {
                return (1027);
            };
            if (_local_2 == "chance")
            {
                return (123);
            };
            if (_local_2 == "criticalDamageBonus")
            {
                return (418);
            };
            if (_local_2 == "criticalDamageReduction")
            {
                return (420);
            };
            if (_local_2 == "damagesBonusPercent")
            {
                return (138);
            };
            if (_local_2 == "dealtDamagesMultiplicator")
            {
                return (1171);
            };
            if (_local_2 == "earthDamageBonus")
            {
                return (422);
            };
            if (_local_2 == "earthElementReduction")
            {
                return (240);
            };
            if (_local_2 == "earthElementResistPercent")
            {
                return (210);
            };
            if (_local_2 == "fireDamageBonus")
            {
                return (424);
            };
            if (_local_2 == "fireElementReduction")
            {
                return (243);
            };
            if (_local_2 == "fireElementResistPercent")
            {
                return (213);
            };
            if (_local_2 == "glyphPower")
            {
                return (1166);
            };
            if (_local_2 == "healBonus")
            {
                return (178);
            };
            if (_local_2 == "intelligence")
            {
                return (126);
            };
            if (_local_2 == "maxLifePoints")
            {
                return (110);
            };
            if (_local_2 == "meleeDamageDonePercent")
            {
                return (2800);
            };
            if (_local_2 == "meleeDamageReceivedPercent")
            {
                return (2802);
            };
            if( (_local_2 == "maxMouvementPoints") || (_local_2 == "movementPoints") )
            {
                return (128);
            };
            if (_local_2 == "neutralDamageBonus")
            {
                return (430);
            };
            if (_local_2 == "neutralElementReduction")
            {
                return (244);
            };
            if (_local_2 == "neutralElementResistPercent")
            {
                return (214);
            };
            if (_local_2 == "percentResist")
            {
                return (1076);
            };
            if (_local_2 == "pushDamageBonus")
            {
                return (414);
            };
            if (_local_2 == "pushDamageFixedResist")
            {
                return (416);
            };
            if (_local_2 == "pvpAirElementPercentResist")
            {
                return (252);
            };
            if (_local_2 == "pvpAirElementReduction")
            {
                return (262);
            };
            if (_local_2 == "pvpEarthElementPercentResist")
            {
                return (250);
            };
            if (_local_2 == "pvpEarthElementReduction")
            {
                return (260);
            };
            if (_local_2 == "pvpFireElementReduction")
            {
                return (263);
            };
            if (_local_2 == "pvpFireElementResistPercent")
            {
                return (253);
            };
            if (_local_2 == "pvpNeutralElementPercentResist")
            {
                return (254);
            };
            if (_local_2 == "pvpNeutralElementReduction")
            {
                return (264);
            };
            if (_local_2 == "pvpWaterElementPercentResist")
            {
                return (251);
            };
            if (_local_2 == "pvpWaterElementReduction")
            {
                return (261);
            };
            if (_local_2 == "rangedDamageDonePercent")
            {
                return (2804);
            };
            if (_local_2 == "rangedDamageReceivedPercent")
            {
                return (2806);
            };
            if (_local_2 == "runePower")
            {
                return (1167);
            };
            if (_local_2 == "shieldPoints")
            {
                return (1040);
            };
            if (_local_2 == "spellDamageDonePercent")
            {
                return (2812);
            };
            if (_local_2 == "spellDamageReceivedPercent")
            {
                return (2814);
            };
            if (_local_2 == "spellPercentDamages")
            {
                return (1054);
            };
            if (_local_2 == "strength")
            {
                return (118);
            };
            if (_local_2 == "trapBonus")
            {
                return (225);
            };
            if (_local_2 == "trapBonusPercent")
            {
                return (226);
            };
            if (_local_2 == "vitality")
            {
                return (125);
            };
            if (_local_2 == "waterDamageBonus")
            {
                return (426);
            };
            if (_local_2 == "waterElementReduction")
            {
                return (241);
            };
            if (_local_2 == "waterElementResistPercent")
            {
                return (211);
            };
            if (_local_2 == "weaponDamageDonePercent")
            {
                return (2808);
            };
            if (_local_2 == "weaponDamageReceivedPercent")
            {
                return (2810);
            };
            if (_local_2 == "weaponDamagesBonusPercent")
            {
                return (165);
            };
            if (_local_2 == "weaponPower")
            {
                return (1144);
            };
            if (_local_2 == "wisdom")
            {
                return (124);
            };
            return (-1);
        }

        public static function StatToDebuffActionIds(_arg_1:String):int
        {
            var _local_2:String = _arg_1;
            if (_local_2 == "actionPoints")
            {
                return (168);
            };
            if (_local_2 == "agility")
            {
                return (154);
            };
            if (_local_2 == "airDamageBonus")
            {
                return (429);
            };
            if (_local_2 == "airElementReduction")
            {
                return (247);
            };
            if (_local_2 == "airElementResistPercent")
            {
                return (217);
            };
            if (_local_2 == "allDamagesBonus")
            {
                return (145);
            };
            if (_local_2 == "chance")
            {
                return (152);
            };
            if (_local_2 == "criticalDamageBonus")
            {
                return (419);
            };
            if (_local_2 == "criticalDamageReduction")
            {
                return (421);
            };
            if (_local_2 == "damagesBonusPercent")
            {
                return (186);
            };
            if (_local_2 == "dealtDamagesMultiplicator")
            {
                return (1172);
            };
            if (_local_2 == "earthDamageBonus")
            {
                return (423);
            };
            if (_local_2 == "earthElementReduction")
            {
                return (245);
            };
            if (_local_2 == "earthElementResistPercent")
            {
                return (215);
            };
            if (_local_2 == "fireDamageBonus")
            {
                return (425);
            };
            if (_local_2 == "fireElementReduction")
            {
                return (248);
            };
            if (_local_2 == "fireElementResistPercent")
            {
                return (218);
            };
            if (_local_2 == "healBonus")
            {
                return (179);
            };
            if (_local_2 == "intelligence")
            {
                return (155);
            };
            if (_local_2 == "meleeDamageDonePercent")
            {
                return (2801);
            };
            if (_local_2 == "meleeDamageReceivedPercent")
            {
                return (2803);
            };
            if( (_local_2 == "maxMouvementPoints") || (_local_2 == "movementPoints") )
            {
                return (128);
            };
            if (_local_2 == "neutralDamageBonus")
            {
                return (431);
            };
            if (_local_2 == "neutralElementReduction")
            {
                return (249);
            };
            if (_local_2 == "neutralElementResistPercent")
            {
                return (219);
            };
            if (_local_2 == "percentResist")
            {
                return (1077);
            };
            if (_local_2 == "pushDamageBonus")
            {
                return (415);
            };
            if (_local_2 == "pushDamageFixedResist")
            {
                return (417);
            };
            if (_local_2 == "pvpAirElementPercentResist")
            {
                return (0x0101);
            };
            if (_local_2 == "pvpEarthElementPercentResist")
            {
                return (0xFF);
            };
            if (_local_2 == "pvpFireElementResistPercent")
            {
                return (258);
            };
            if (_local_2 == "pvpNeutralElementPercentResist")
            {
                return (259);
            };
            if (_local_2 == "pvpWaterElementPercentResist")
            {
                return (0x0100);
            };
            if (_local_2 == "rangedDamageDonePercent")
            {
                return (2805);
            };
            if (_local_2 == "rangedDamageReceivedPercent")
            {
                return (2807);
            };
            if (_local_2 == "spellDamageDonePercent")
            {
                return (2813);
            };
            if (_local_2 == "spellDamageReceivedPercent")
            {
                return (2815);
            };
            if (_local_2 == "strength")
            {
                return (157);
            };
            if (_local_2 == "vitality")
            {
                return (153);
            };
            if (_local_2 == "waterDamageBonus")
            {
                return (427);
            };
            if (_local_2 == "waterElementReduction")
            {
                return (246);
            };
            if (_local_2 == "waterElementResistPercent")
            {
                return (216);
            };
            if (_local_2 == "weaponDamageDonePercent")
            {
                return (2809);
            };
            if (_local_2 == "weaponDamageReceivedPercent")
            {
                return (2811);
            };
            if (_local_2 == "wisdom")
            {
                return (156);
            };
            return (-1);
        }

        public static function isLinearBuffActionIds(_arg_1:String):Boolean
        {
            var _local_2:String = _arg_1;
                
            outer_block:
            {

                if (_local_2 != "airElementResistPercent")
                {
                    if (_local_2 != "earthElementResistPercent")
                    {
                        if (_local_2 != "fireElementResistPercent")
                        {
                            if (_local_2 != "meleeDamageReceivedPercent")
                            {
                                if (_local_2 != "neutralElementResistPercent")
                                {
                                    if (_local_2 != "percentResist")
                                    {
                                        if (_local_2 != "pvpAirElementPercentResist")
                                        {
                                            if (_local_2 != "pvpEarthElementPercentResist")
                                            {
                                                if (_local_2 != "pvpFireElementResistPercent")
                                                {
                                                    if (_local_2 != "pvpNeutralElementPercentResist")
                                                    {
                                                        if (_local_2 != "pvpWaterElementPercentResist")
                                                        {
                                                            if (_local_2 != "rangedDamageReceivedPercent")
                                                            {
                                                                if (_local_2 != "spellDamageReceivedPercent")
                                                                {
                                                                    if (_local_2 != "trapBonusPercent")
                                                                    {
                                                                        if (_local_2 != "waterElementResistPercent")
                                                                        {
                                                                            if (_local_2 != "weaponDamageReceivedPercent")
                                                                            {
                                                                                if (_local_2 != "weaponDamagesBonusPercent") return (true); //break outer_block;
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
                return (false);
            
            }//outer_block
            return (true);
        }

        public static function isBuff(_arg_1:int):Boolean
        {
            if ((((ActionIdHelper.STAT_BUFF_ACTION_IDS.indexOf(_arg_1) != (-1)) || (!(ActionIdHelper.STAT_DEBUFF_ACTION_IDS.indexOf(_arg_1) == -1))) && (!(ActionIdHelper.isShield(_arg_1)))))
            {
                return (true);
            };
            return (false);
        }

        public static function isPositiveBoost(_arg_1:int):Boolean
        {
            return (!(ActionIdHelper.STAT_BUFF_ACTION_IDS.indexOf(_arg_1) == -1));
        }

        public static function isNegativeBoost(_arg_1:int):Boolean
        {
            return (!(ActionIdHelper.STAT_DEBUFF_ACTION_IDS.indexOf(_arg_1) == -1));
        }

        public static function getActionIdStatName(_arg_1:int):String
        {
            return (ActionIdHelper.actionIdToStatNameMap.h[_arg_1]);
        }

        public static function spellExecutionHasGlobalLimitation(_arg_1:int):Boolean
        {
            var _local_2:int = _arg_1;
                
            outer_block:
            {

                if (_local_2 != 2017)
                {
                    if (_local_2 != 2160)
                    {
                        if (_local_2 != 2792)
                        {
                            if (_local_2 != 2793)
                            {
                                if (_local_2 != 2795) return (false); //break outer_block;
                            };
                        };
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }


    }
}
import haxe.ds.IntMap;
import haxe.IMap;

var _local_1:IMap = new IntMap();
_local_1.h[110] = "lifePoints";
_local_1.h[127] = "movementPoints";
_local_1.h[128] = "movementPoints";
_local_1.h[169] = "movementPoints";
_local_1.h[2848] = "movementPointsPercent";
_local_1.h[2849] = "movementPointsPercent";
_local_1.h[101] = "actionPoints";
_local_1.h[111] = "actionPoints";
_local_1.h[168] = "actionPoints";
_local_1.h[2846] = "actionPointsPercent";
_local_1.h[2847] = "actionPointsPercent";
_local_1.h[145] = "allDamagesBonus";
_local_1.h[112] = "allDamagesBonus";
_local_1.h[142] = "physicalDamagesBonus";
_local_1.h[186] = "damagesBonusPercent";
_local_1.h[138] = "damagesBonusPercent";
_local_1.h[182] = "summonableCreaturesBoost";
_local_1.h[215] = "earthElementResistPercent";
_local_1.h[210] = "earthElementResistPercent";
_local_1.h[216] = "waterElementResistPercent";
_local_1.h[211] = "waterElementResistPercent";
_local_1.h[217] = "airElementResistPercent";
_local_1.h[212] = "airElementResistPercent";
_local_1.h[218] = "fireElementResistPercent";
_local_1.h[213] = "fireElementResistPercent";
_local_1.h[219] = "neutralElementResistPercent";
_local_1.h[214] = "neutralElementResistPercent";
_local_1.h[116] = "range";
_local_1.h[117] = "range";
_local_1.h[157] = "strength";
_local_1.h[118] = "strength";
_local_1.h[2835] = "strengthPercent";
_local_1.h[2834] = "strengthPercent";
_local_1.h[154] = "agility";
_local_1.h[119] = "agility";
_local_1.h[2837] = "agilityPercent";
_local_1.h[2836] = "agilityPercent";
_local_1.h[152] = "chance";
_local_1.h[123] = "chance";
_local_1.h[2841] = "chancePercent";
_local_1.h[2840] = "chancePercent";
_local_1.h[156] = "wisdom";
_local_1.h[124] = "wisdom";
_local_1.h[2843] = "wisdomPercent";
_local_1.h[2842] = "wisdomPercent";
_local_1.h[153] = "vitality";
_local_1.h[125] = "vitality";
_local_1.h[2844] = "vitality";
_local_1.h[2845] = "vitality";
_local_1.h[155] = "intelligence";
_local_1.h[126] = "intelligence";
_local_1.h[2839] = "intelligencePercent";
_local_1.h[2838] = "intelligencePercent";
_local_1.h[225] = "trapBonus";
_local_1.h[226] = "trapBonusPercent";
_local_1.h[245] = "earthElementReduction";
_local_1.h[240] = "earthElementReduction";
_local_1.h[246] = "waterElementReduction";
_local_1.h[241] = "waterElementReduction";
_local_1.h[247] = "airElementReduction";
_local_1.h[242] = "airElementReduction";
_local_1.h[248] = "fireElementReduction";
_local_1.h[243] = "fireElementReduction";
_local_1.h[249] = "neutralElementReduction";
_local_1.h[244] = "neutralElementReduction";
_local_1.h[122] = "criticalMiss";
_local_1.h[115] = "criticalHit";
_local_1.h[171] = "criticalHit";
_local_1.h[174] = "initiative";
_local_1.h[175] = "initiative";
_local_1.h[176] = "prospecting";
_local_1.h[177] = "prospecting";
_local_1.h[178] = "healBonus";
_local_1.h[1039] = "shieldPoints";
_local_1.h[1040] = "shieldPoints";
_local_1.h[1047] = "lifePointsMalus";
_local_1.h[1048] = "lifePointsMalus";
_local_1.h[220] = "reflectorUnboosted";
_local_1.h[162] = "dodgePALostProbability";
_local_1.h[160] = "dodgePALostProbability";
_local_1.h[2854] = "dodgePALostProbabilityPercent";
_local_1.h[2855] = "dodgePALostProbabilityPercent";
_local_1.h[163] = "dodgePMLostProbability";
_local_1.h[161] = "dodgePMLostProbability";
_local_1.h[2856] = "dodgePMLostProbabilityPercent";
_local_1.h[2857] = "dodgePMLostProbabilityPercent";
_local_1.h[121] = "allDamagesBonus";
_local_1.h[159] = "maximumWeight";
_local_1.h[158] = "maximumWeight";
_local_1.h[173] = "physicalReduction";
_local_1.h[184] = "physicalReduction";
_local_1.h[172] = "magicalReduction";
_local_1.h[183] = "magicalReduction";
_local_1.h[752] = "tackleEvade";
_local_1.h[2852] = "tackleEvadePercent";
_local_1.h[753] = "tackleBlock";
_local_1.h[2850] = "tackleBlockPercent";
_local_1.h[754] = "tackleEvade";
_local_1.h[2853] = "tackleEvadePercent";
_local_1.h[755] = "tackleBlock";
_local_1.h[2851] = "tackleBlockPercent";
_local_1.h[776] = "permanentDamagePercent";
_local_1.h[1076] = "globalResistPercentBonus";
_local_1.h[1077] = "globalResistPercentMalus";
_local_1.h[410] = "PAAttack";
_local_1.h[411] = "PAAttack";
_local_1.h[2858] = "PAAttackPercent";
_local_1.h[2859] = "PAAttackPercent";
_local_1.h[412] = "PMAttack";
_local_1.h[413] = "PMAttack";
_local_1.h[2860] = "PMAttackPercent";
_local_1.h[2861] = "PMAttackPercent";
_local_1.h[414] = "pushDamageBonus";
_local_1.h[415] = "pushDamageBonus";
_local_1.h[417] = "pushDamageFixedResist";
_local_1.h[150] = "invisibilityState";
_local_1.h[1144] = "weaponDamagesBonusPercent";
_local_1.h[2807] = "rangedDamageReceivedPercent";
_local_1.h[2806] = "rangedDamageReceivedPercent";
_local_1.h[2804] = "rangedDamageDonePercent";
_local_1.h[2805] = "rangedDamageDonePercent";
_local_1.h[2803] = "meleeDamageReceivedPercent";
_local_1.h[2802] = "meleeDamageReceivedPercent";
_local_1.h[2800] = "meleeDamageDonePercent";
_local_1.h[2801] = "meleeDamageDonePercent";

