package damageCalculation.spellManagement
{
    import damageCalculation.fighterManagement.HaxeFighter;
    import damageCalculation.FightContext;
    import damageCalculation.fighterManagement.PlayerTypeEnum;
    import damageCalculation.damageManagement.EffectOutput;

    public class SpellManager 
    {

        public static var EXCLUSIVE_MASKS_LIST:String = "*bBeEfFzZKoOPpTWUvVrRQq";
        public static var TELEFRAG_STATE:int = 251;

        public function SpellManager():void
        {
        }

        public static function isSelectedByMask(_arg_1:HaxeFighter, _arg_2:Array, _arg_3:HaxeFighter, _arg_4:HaxeFighter, _arg_5:FightContext):Boolean
        {
            if (((_arg_2 == (null)) || (_arg_2.length == 0)))
            {
                return (true);
            };
            if (_arg_3 == null)
            {
                return (false);
            };
            if (SpellManager.isIncludedByMask(_arg_1, _arg_2, _arg_3))
            {
                return (SpellManager.passMaskExclusion(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5));
            };
            return (false);
        }

        public static function isIncludedByMask(_arg_1:HaxeFighter, _arg_2:Array, _arg_3:HaxeFighter):Boolean
        {
            var _local_5:Boolean;
            var _local_6:Boolean;
            var _local_7:int;
            var _local_8:* = (null as String);
            var _local_9:* = (null as String);
            var _local_4:* = (_arg_3.id == _arg_1.id);
            if (_local_4)
            {
                if ((((_arg_2.indexOf("c") != (-1)) || (!(_arg_2.indexOf("C") == -1))) || (!(_arg_2.indexOf("a") == -1))))
                {
                    return (true);
                };
            }
            else
            {
                _local_5 = (_arg_1.teamId == _arg_3.teamId);
                _local_6 = _arg_3.data.isSummon();
                _local_7 = 0;
                while (_local_7 < _arg_2.length)
                {
                    _local_8 = _arg_2[_local_7];
                    _local_7++;
                    _local_9 = _local_8;
                    if (_local_9 == "A")
                    {
                        if (!_local_5)
                        {
                            return (true);
                        };
                    }
                    else
                    {
                        if (_local_9 == "D")
                        {
                            if (((_local_5) && (_arg_3.playerType == PlayerTypeEnum.SIDEKICK)))
                            {
                                return (true);
                            };
                        }
                        else
                        {
                            if (_local_9 == "H")
                            {
                                if ((((_local_5) && (_arg_3.playerType == PlayerTypeEnum.HUMAN)) && (!(_local_6))))
                                {
                                    return (true);
                                };
                            }
                            else
                            {
                                if (_local_9 == "I")
                                {
                                    if (((((_local_5) && (!(_arg_3.playerType == PlayerTypeEnum.SIDEKICK))) && (_local_6)) && (!(_arg_3.isStaticElement))))
                                    {
                                        return (true);
                                    };
                                }
                                else
                                {
                                    if (_local_9 == "J")
                                    {
                                        if ((((_local_5) && (!(_arg_3.playerType == PlayerTypeEnum.SIDEKICK))) && (_local_6)))
                                        {
                                            return (true);
                                        };
                                    }
                                    else
                                    {
                                        if (_local_9 == "L")
                                        {
                                            if (((_local_5) && (((_arg_3.playerType == (PlayerTypeEnum.HUMAN)) && (!(_local_6))) || (_arg_3.playerType == PlayerTypeEnum.SIDEKICK))))
                                            {
                                                return (true);
                                            };
                                        }
                                        else
                                        {
                                            if (_local_9 == "M")
                                            {
                                                if (((((_local_5) && (!(_arg_3.playerType == PlayerTypeEnum.HUMAN))) && (!(_local_6))) && (!(_arg_3.isStaticElement))))
                                                {
                                                    return (true);
                                                };
                                            }
                                            else
                                            {
                                                if (_local_9 == "S")
                                                {
                                                    if (((((_local_5) && (!(_arg_3.playerType == PlayerTypeEnum.SIDEKICK))) && (_local_6)) && (_arg_3.isStaticElement)))
                                                    {
                                                        return (true);
                                                    };
                                                }
                                                else
                                                {
                                                    if( (_local_9 == "a") || (_local_9 == "g") )
                                                    {
                                                        if (_local_5)
                                                        {
                                                            return (true);
                                                        };
                                                        continue;
                                                    };
                                                    if (_local_9 == "d")
                                                    {
                                                        if (((_local_5) && (_arg_3.playerType == PlayerTypeEnum.SIDEKICK)))
                                                        {
                                                            return (true);
                                                        };
                                                    }
                                                    else
                                                    {
                                                        if (_local_9 == "h")
                                                        {
                                                            if ((((_local_5) && (_arg_3.playerType == PlayerTypeEnum.HUMAN)) && (!(_local_6))))
                                                            {
                                                                return (true);
                                                            };
                                                        }
                                                        else
                                                        {
                                                            if (_local_9 == "i")
                                                            {
                                                                if (((((_local_5) && (!(_arg_3.playerType == PlayerTypeEnum.SIDEKICK))) && (_local_6)) && (!(_arg_3.isStaticElement))))
                                                                {
                                                                    return (true);
                                                                };
                                                            }
                                                            else
                                                            {
                                                                if (_local_9 == "j")
                                                                {
                                                                    if ((((_local_5) && (!(_arg_3.playerType == PlayerTypeEnum.SIDEKICK))) && (_local_6)))
                                                                    {
                                                                        return (true);
                                                                    };
                                                                }
                                                                else
                                                                {
                                                                    if (_local_9 == "l")
                                                                    {
                                                                        if (((_local_5) && (((_arg_3.playerType == (PlayerTypeEnum.HUMAN)) && (!(_local_6))) || (_arg_3.playerType == PlayerTypeEnum.SIDEKICK))))
                                                                        {
                                                                            return (true);
                                                                        };
                                                                    }
                                                                    else
                                                                    {
                                                                        if (_local_9 == "m")
                                                                        {
                                                                            if (((((_local_5) && (!(_arg_3.playerType == PlayerTypeEnum.HUMAN))) && (!(_local_6))) && (!(_arg_3.isStaticElement))))
                                                                            {
                                                                                return (true);
                                                                            };
                                                                        }
                                                                        else
                                                                        {
                                                                            if (_local_9 == "s")
                                                                            {
                                                                                if (((((_local_5) && (!(_arg_3.playerType == PlayerTypeEnum.SIDEKICK))) && (_local_6)) && (_arg_3.isStaticElement)))
                                                                                {
                                                                                    return (true);
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
            return (false);
        }

        public static function splitMasks(_arg_1:String):Array
        {
            var _local_4:int;
            var _local_2:Array = [];
            var _local_3:int;
            while (_local_3 < _arg_1.length)
            {
                while (((_arg_1.charAt(_local_3) == (" ")) || (_arg_1.charAt(_local_3) == ",")))
                {
                    _local_3++;
                };
                _local_4 = _local_3;
                while (((_local_4 < (_arg_1.length)) && (!(_arg_1.charAt(_local_4) == ","))))
                {
                    _local_4++;
                };
                if (_local_4 != _local_3)
                {
                    _local_2.push(_arg_1.substring(_local_3, _local_4));
                };
                _local_3 = _local_4;
            };
            return (_local_2);
        }

        public static function splitTriggers(_arg_1:String):Array
        {
            var _local_4:int;
            var _local_2:Array = [];
            var _local_3:int;
            if (_arg_1 != null)
            {
                while (_local_3 < _arg_1.length)
                {
                    while (((_arg_1.charAt(_local_3) == (" ")) || (_arg_1.charAt(_local_3) == "|")))
                    {
                        _local_3++;
                    };
                    _local_4 = _local_3;
                    while (((_local_4 < (_arg_1.length)) && (!(_arg_1.charAt(_local_4) == "|"))))
                    {
                        _local_4++;
                    };
                    if (_local_4 != _local_3)
                    {
                        _local_2.push(_arg_1.substring(_local_3, _local_4));
                    };
                    _local_3 = _local_4;
                };
            };
            return (_local_2);
        }

        public static function maskIsOneOfCondition(_arg_1:String):Boolean
        {
            var _local_2:String = ((_arg_1.charAt(0) == "*") ? _arg_1.charAt(1) : _arg_1.charAt(0));
                
            outer_block:
            {

                if (_local_2 != "B")
                {
                    if (_local_2 != "F")
                    {
                        if (_local_2 != "Z") return (false); //break outer_block;
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }

        public static function passMaskExclusion(_arg_1:HaxeFighter, _arg_2:Array, _arg_3:HaxeFighter, _arg_4:HaxeFighter, _arg_5:FightContext):Boolean
        {
            var _local_8:* = (null as String);
            var _local_9:* = (null as HaxeFighter);
            var _local_10:Boolean;
            var _local_6:Boolean = _arg_5.usingPortal();
            var _local_7:int;
            while (_local_7 < _arg_2.length)
            {
                _local_8 = _arg_2[_local_7];
                _local_7++;
                if ("*bBeEfFzZKoOPpTWUvVrRQq".indexOf(_local_8.charAt(0)) != -1)
                {
                    if (_local_8.charCodeAt(0) == "*".charCodeAt(0))
                    {
                        _local_9 = _arg_1;
                        _local_10 = true;
                    }
                    else
                    {
                        _local_9 = _arg_3;
                        _local_10 = false;
                    };
                    if (!SpellManager.targetPassMaskExclusion(_arg_1, _local_9, _arg_4, _arg_5, _local_8, _arg_2, _local_6, _local_10))
                    {
                        return (false);
                    };
                };
            };
            return (true);
        }

        public static function targetPassMaskExclusion(caster:HaxeFighter, _arg_2:HaxeFighter, _arg_3:HaxeFighter, _arg_4:FightContext, _arg_5:String, _arg_6:Array, _arg_7:Boolean, _arg_8:Boolean):Boolean
        {
            var _local_10:* = (null as Object);
            var _local_12:Boolean;
            var _local_14:Number;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:int;
            var _local_9:int = ((_arg_8) ? 1 : 0);
            switch (_arg_5.length)
            {
                default:
                    _local_10 = Std.parseInt(_arg_5.substring((_local_9 + 1)));
                    break;
                case 0:
                case 1:
                    _local_10 = 0;
            };
            var _local_11:String = _arg_5.charAt(_local_9);
            var _local_13:String = _local_11;
                
            outer_block:
            {

                if (_local_13 == "B")
                {
                    _local_12 = ((_arg_2.playerType == (PlayerTypeEnum.HUMAN)) && (_arg_2.breed == _local_10));
                }
                else
                {
                    if (_local_13 == "E")
                    {
                        _local_12 = _arg_2.hasState(_local_10);
                    }
                    else
                    {
                        if (_local_13 == "F")
                        {
                            _local_12 = ((_arg_2.playerType != (PlayerTypeEnum.HUMAN)) && (_arg_2.breed == _local_10));
                        }
                        else
                        {
                            if (_local_13 == "K")
                            {
                                _local_12 = (((_arg_2.hasState(8)) && (caster.getCarried(_arg_4) == _arg_2)) || (_arg_2.pendingEffects.filter(function (_arg_1:EffectOutput):Boolean
                                {
                                    return (_arg_1.throwedBy == caster.id);
                                }).length > 0));
                            }
                            else
                            {
                                if (_local_13 == "P")
                                {
                                    _local_12 = ((((_arg_2.id == (caster.id)) || ((_arg_2.data.isSummon()) && (_arg_2.data.getSummonerId() == caster.id))) || ((_arg_2.data.isSummon()) && (caster.data.getSummonerId() == _arg_2.data.getSummonerId()))) || ((caster.data.isSummon()) && (caster.data.getSummonerId() == _arg_2.id)));
                                }
                                else
                                {
                                    if (_local_13 == "Q")
                                    {
                                        _local_12 = (_arg_4.getFighterCurrentSummonCount(_arg_2) >= _arg_2.getCharacteristicValue("maxSummonableCreatures"));
                                    }
                                    else
                                    {
                                        if (_local_13 == "R")
                                        {
                                            _local_12 = _arg_7;
                                        }
                                        else
                                        {
                                            if (_local_13 == "T")
                                            {
                                                _local_12 = _arg_2.wasTelefraggedThisTurn();
                                            }
                                            else
                                            {
                                                if (_local_13 == "U")
                                                {
                                                    _local_12 = _arg_2.isAppearing();
                                                }
                                                else
                                                {
                                                    if (_local_13 == "V")
                                                    {
                                                        _local_14 = ((_arg_2.getPendingLifePoints().min / _arg_2.getCharacteristicValue("maxLifePoints")) * 100);
                                                        _local_12 = (_local_14 <= _local_10);
                                                    }
                                                    else
                                                    {
                                                        if (_local_13 == "W")
                                                        {
                                                            _local_12 = _arg_2.wasTeleportedInInvalidCellThisTurn(_arg_4);
                                                        }
                                                        else
                                                        {
                                                            if (_local_13 == "Z")
                                                            {
                                                                _local_12 = ((_arg_2.playerType == (PlayerTypeEnum.SIDEKICK)) && (_arg_2.breed == _local_10));
                                                            }
                                                            else
                                                            {
                                                                if (_local_13 == "b")
                                                                {
                                                                    _local_12 = ((_arg_2.playerType != (PlayerTypeEnum.HUMAN)) || (!(_arg_2.breed == _local_10)));
                                                                }
                                                                else
                                                                {
                                                                    if (_local_13 == "e")
                                                                    {
                                                                        _local_12 = (!(_arg_2.hasState(_local_10)));
                                                                    }
                                                                    else
                                                                    {
                                                                        if (_local_13 == "f")
                                                                        {
                                                                            _local_12 = ((_arg_2.playerType == (PlayerTypeEnum.HUMAN)) || (!(_arg_2.breed == _local_10)));
                                                                        }
                                                                        else
                                                                        {
                                                                            if( (_local_13 == "O") || (_local_13 == "o") )
                                                                            {
                                                                                _local_12 = ((_arg_3 != (null)) && (_arg_2.id == _arg_3.id));
                                                                                break outer_block;
                                                                            };
                                                                            if (_local_13 == "p")
                                                                            {
                                                                                _local_12 = (!((((_arg_2.id == (caster.id)) || ((_arg_2.data.isSummon()) && (_arg_2.data.getSummonerId() == caster.id))) || ((_arg_2.data.isSummon()) && (caster.data.getSummonerId() == _arg_2.data.getSummonerId()))) || ((caster.data.isSummon()) && (caster.data.getSummonerId() == _arg_2.id))));
                                                                            }
                                                                            else
                                                                            {
                                                                                if (_local_13 == "q")
                                                                                {
                                                                                    _local_12 = (_arg_4.getFighterCurrentSummonCount(_arg_2) < _arg_2.getCharacteristicValue("maxSummonableCreatures"));
                                                                                }
                                                                                else
                                                                                {
                                                                                    if (_local_13 == "r")
                                                                                    {
                                                                                        _local_12 = (!(_arg_7));
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        if (_local_13 == "v")
                                                                                        {
                                                                                            _local_14 = ((_arg_2.getPendingLifePoints().min / _arg_2.getCharacteristicValue("maxLifePoints")) * 100);
                                                                                            _local_12 = (_local_14 > _local_10);
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            if (_local_13 == "z")
                                                                                            {
                                                                                                _local_12 = ((_arg_2.playerType != (PlayerTypeEnum.SIDEKICK)) || (!(_arg_2.breed == _local_10)));
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
                    };
                };
            
            }//outer_block
            if (SpellManager.maskIsOneOfCondition(_arg_5))
            {
                _local_15 = (_arg_6.indexOf(_arg_5) + 1);
                if (_local_12)
                {
                    _local_16 = _local_15;
                    _local_17 = _arg_6.length;
                    while (_local_16 < _local_17)
                    {
                        _local_18 = _local_16++;
                        if (_arg_6[_local_18].charCodeAt(_local_9) == _arg_5.charCodeAt(_local_9))
                        {
                            _arg_6[_local_18] = " ";
                        };
                    };
                }
                else
                {
                    _local_16 = _local_15;
                    _local_17 = _arg_6.length;
                    while (_local_16 < _local_17)
                    {
                        _local_18 = _local_16++;
                        if (_arg_6[_local_18].charCodeAt(_local_9) == _arg_5.charCodeAt(_local_9))
                        {
                            _local_12 = true;
                            break;
                        };
                    };
                };
            };
            return (_local_12);
        }

        public static function isInstantaneousSpellEffect(_arg_1:HaxeSpellEffect):Boolean
        {
            if (((_arg_1.triggers == (null)) || (!(_arg_1.triggers.indexOf("I") == -1))))
            {
                return (true);
            };
            return (false);
        }


    }
}

