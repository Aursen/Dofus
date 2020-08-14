package damageCalculation.damageManagement
{
    import mapTools.SpellZone;
    import tools.FpUtils;
    import damageCalculation.spellManagement.SpellManager;
    import mapTools.MapTools;
    import damageCalculation.fighterManagement.HaxeFighter;
    import damageCalculation.FightContext;
    import damageCalculation.spellManagement.HaxeSpell;
    import damageCalculation.spellManagement.HaxeSpellEffect;
    import damageCalculation.tools.LinkedListNode;
    import damageCalculation.spellManagement.RunningEffect;
    import damageCalculation.fighterManagement.PlayerTypeEnum;
    import damageCalculation.DamageCalculator;

    public class TargetManagement 
    {

        public static var DEFAULT_SORT_DIRECTION:int = 7;

        public function TargetManagement():void
        {
        }

        public static function getTargets(fightContext:FightContext, caster:HaxeFighter, _arg_3:HaxeSpell, effect:HaxeSpellEffect, triggeringFighter:HaxeFighter):Object
        {
            var _local_7:* = (null as String);
            var _local_8:* = (null as Array);
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:int;
            var _local_19:int;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            var _local_24:int;
            var _local_25:int;
            var _local_26:int;
            var _local_27:* = (null as SpellZone);
            var _local_6:Boolean = fightContext.usingPortal();
            var i:int = -1;
            while ((i = (_local_9 = (i + 1))) < effect.masks.length)
            {
                _local_7 = effect.masks[i];
                if (_local_7.charCodeAt(0) == "*".charCodeAt(0))
                {
                    _local_8 = FpUtils.arrayCopy_String(effect.masks);
                    if (!SpellManager.targetPassMaskExclusion(caster, caster, triggeringFighter, fightContext, _local_7, _local_8, _local_6, true))
                    {
                        return ({
                            "targetedFighters":null,
                            "additionalTargets":null,
                            "isUsed":false
                        });
                    };
                }
                else
                {
                    break;
                };
            };
            _local_8 = [];
            if (effect.actionId == 783)
            {
                _local_9 = caster.getCurrentPositionCell();
                _local_10 = fightContext.targetedCell;
                _local_11 = int(Math.floor((_local_9 / MapTools.MAP_GRID_WIDTH)));
                _local_12 = int(Math.floor(((_local_11 + 1) / 2)));
                _local_13 = (_local_9 - (_local_11 * MapTools.MAP_GRID_WIDTH));
                _local_14 = int(Math.floor((_local_9 / MapTools.MAP_GRID_WIDTH)));
                _local_15 = int(Math.floor(((_local_14 + 1) / 2)));
                _local_16 = (_local_14 - _local_15);
                _local_17 = (_local_9 - (_local_14 * MapTools.MAP_GRID_WIDTH));
                _local_18 = int(Math.floor((_local_10 / MapTools.MAP_GRID_WIDTH)));
                _local_19 = int(Math.floor(((_local_18 + 1) / 2)));
                _local_20 = (_local_10 - (_local_18 * MapTools.MAP_GRID_WIDTH));
                _local_21 = int(Math.floor((_local_10 / MapTools.MAP_GRID_WIDTH)));
                _local_22 = int(Math.floor(((_local_21 + 1) / 2)));
                _local_23 = (_local_21 - _local_22);
                _local_24 = (_local_10 - (_local_21 * MapTools.MAP_GRID_WIDTH));
                _local_25 = MapTools.getLookDirection8ExactByCoord((_local_12 + _local_13), (_local_17 - _local_16), (_local_19 + _local_20), (_local_24 - _local_23));
                _local_26 = caster.getCurrentPositionCell();
                _local_8 = fightContext.getFightersUpTo(_local_26, _local_25, 1, 1, 1);
            }
            else
            {
                if (effect.actionId == 1043)
                {
                    _local_9 = caster.getCurrentPositionCell();
                    _local_10 = fightContext.targetedCell;
                    _local_11 = int(Math.floor((_local_9 / MapTools.MAP_GRID_WIDTH)));
                    _local_12 = int(Math.floor(((_local_11 + 1) / 2)));
                    _local_13 = (_local_9 - (_local_11 * MapTools.MAP_GRID_WIDTH));
                    _local_14 = int(Math.floor((_local_9 / MapTools.MAP_GRID_WIDTH)));
                    _local_15 = int(Math.floor(((_local_14 + 1) / 2)));
                    _local_16 = (_local_14 - _local_15);
                    _local_17 = (_local_9 - (_local_14 * MapTools.MAP_GRID_WIDTH));
                    _local_18 = int(Math.floor((_local_10 / MapTools.MAP_GRID_WIDTH)));
                    _local_19 = int(Math.floor(((_local_18 + 1) / 2)));
                    _local_20 = (_local_10 - (_local_18 * MapTools.MAP_GRID_WIDTH));
                    _local_21 = int(Math.floor((_local_10 / MapTools.MAP_GRID_WIDTH)));
                    _local_22 = int(Math.floor(((_local_21 + 1) / 2)));
                    _local_23 = (_local_21 - _local_22);
                    _local_24 = (_local_10 - (_local_21 * MapTools.MAP_GRID_WIDTH));
                    _local_25 = MapTools.getLookDirection8ExactByCoord((_local_12 + _local_13), (_local_17 - _local_16), (_local_19 + _local_20), (_local_24 - _local_23));
                    _local_26 = caster.getCurrentPositionCell();
                    _local_8 = fightContext.getFightersUpTo(_local_26, _local_25, _arg_3.minimaleRange, _arg_3.maximaleRange, 1);
                }
                else
                {
                    _local_27 = effect.zone;
                    _local_9 = fightContext.targetedCell;
                    _local_10 = caster.getCurrentPositionCell();
                    _local_8 = fightContext.getFightersFromZone(_local_27, _local_9, _local_10);
                };
            };
            var _local_28:Array = TargetManagement.getOutOfAreaTarget(fightContext, caster, effect, triggeringFighter, _local_8);
            if (_local_28.length > 0)
            {
                _local_8 = _local_8.concat(_local_28);
            };
            _local_8 = FpUtils.arrayFilter_damageCalculation_fighterManagement_HaxeFighter(_local_8, function (_arg_1:HaxeFighter):Boolean
            {
                var _local_2:* = (null as Array);
                if (!((caster == (_arg_1)) && (effect.actionId == 90)))
                {
                    _local_2 = effect.masks.slice(i);
                    return (SpellManager.isSelectedByMask(caster, _local_2, _arg_1, triggeringFighter, fightContext));
                };
                return (true);
            });
            return ({
                "targetedFighters":_local_8,
                "additionalTargets":_local_28,
                "isUsed":true
            });
        }

        public static function forceSelection(_arg_1:HaxeFighter, _arg_2:HaxeSpellEffect, _arg_3:HaxeFighter):Boolean
        {
            if (_arg_1 == _arg_3)
            {
                return (_arg_2.actionId == 90);
            };
            return (false);
        }

        public static function applyComboBonusToCaster(_arg_1:HaxeFighter, _arg_2:FightContext):void
        {
            var _local_4:* = (null as LinkedListNode);
            var _local_5:* = (null as LinkedListNode);
            var _local_3:LinkedListNode = _arg_1._buffs.head;
            while (_local_3 != null)
            {
                _local_4 = _local_3;
                _local_3 = _local_3.next;
                _local_5 = _local_4;
                if (_local_5.item.effect.actionId == 1027)
                {
                    _arg_1.getSummoner(_arg_2).storePendingBuff(_local_5.item);
                };
            };
            _arg_1.removeBuffByActionId(1027);
        }

        public static function getOutOfAreaTarget(_arg_1:FightContext, _arg_2:HaxeFighter, _arg_3:HaxeSpellEffect, _arg_4:HaxeFighter, _arg_5:Array):Array
        {
            var _local_6:Array = _arg_3.masks;
            var _local_7:Array = [];
            if ((((_arg_5.indexOf(_arg_2) == (-1)) && (((_local_6.indexOf("C") != (-1)) || (_arg_3.actionId == 90)) || (_arg_3.actionId == 4))) && (!(_arg_3.actionId == 780))))
            {
                _local_7.push(_arg_2);
            };
            if ((((_local_6.indexOf("O") != (-1)) && (!(_arg_4 == null))) && (_arg_5.indexOf(_arg_4) == -1)))
            {
                _local_7.push(_arg_4);
            };
            var _local_8:HaxeFighter = _arg_2.getCarried(_arg_1);
            if (_local_8 != null)
            {
                if (((((_local_6.indexOf("K") != (-1)) || (_arg_3.actionId == 51)) && (_arg_5.indexOf(_local_8) == -1)) && (_local_7.indexOf(_local_8) == -1)))
                {
                    _local_7.push(_local_8);
                };
            };
            return (_local_7);
        }

        public static function comparePositions(_arg_1:int, _arg_2:Boolean, _arg_3:int, _arg_4:int):int
        {
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:int;
            var _local_19:int;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            var _local_24:int;
            var _local_25:int;
            var _local_26:int;
            var _local_27:int;
            var _local_28:int;
            var _local_29:int;
            var _local_30:int;
            var _local_31:int;
            var _local_32:int;
            var _local_33:int;
            var _local_34:int;
            var _local_35:int;
            var _local_5:int = MapTools.getDistance(_arg_3, _arg_1);
            var _local_6:int = MapTools.getDistance(_arg_4, _arg_1);
            if (_local_5 == _local_6)
            {
                _local_7 = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
                _local_8 = int(Math.floor(((_local_7 + 1) / 2)));
                _local_9 = (_arg_1 - (_local_7 * MapTools.MAP_GRID_WIDTH));
                _local_10 = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
                _local_11 = int(Math.floor(((_local_10 + 1) / 2)));
                _local_12 = (_local_10 - _local_11);
                _local_13 = (_arg_1 - (_local_10 * MapTools.MAP_GRID_WIDTH));
                _local_14 = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
                _local_15 = int(Math.floor(((_local_14 + 1) / 2)));
                _local_16 = (_arg_3 - (_local_14 * MapTools.MAP_GRID_WIDTH));
                _local_17 = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
                _local_18 = int(Math.floor(((_local_17 + 1) / 2)));
                _local_19 = (_local_17 - _local_18);
                _local_20 = (_arg_3 - (_local_17 * MapTools.MAP_GRID_WIDTH));
                _local_5 = MapTools.getLookDirection8ByCoord((_local_8 + _local_9), (_local_13 - _local_12), (_local_15 + _local_16), (_local_20 - _local_19));
                _local_21 = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
                _local_22 = int(Math.floor(((_local_21 + 1) / 2)));
                _local_23 = (_arg_1 - (_local_21 * MapTools.MAP_GRID_WIDTH));
                _local_24 = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
                _local_25 = int(Math.floor(((_local_24 + 1) / 2)));
                _local_26 = (_local_24 - _local_25);
                _local_27 = (_arg_1 - (_local_24 * MapTools.MAP_GRID_WIDTH));
                _local_28 = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
                _local_29 = int(Math.floor(((_local_28 + 1) / 2)));
                _local_30 = (_arg_4 - (_local_28 * MapTools.MAP_GRID_WIDTH));
                _local_31 = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
                _local_32 = int(Math.floor(((_local_31 + 1) / 2)));
                _local_33 = (_local_31 - _local_32);
                _local_34 = (_arg_4 - (_local_31 * MapTools.MAP_GRID_WIDTH));
                _local_6 = MapTools.getLookDirection8ByCoord((_local_22 + _local_23), (_local_27 - _local_26), (_local_29 + _local_30), (_local_34 - _local_33));
                if (_local_5 == _local_6)
                {
                    _local_6 = 0;
                    if ((((_local_5 == (0)) || (_local_5 == 1)) || (_local_5 == 6)))
                    {
                        _local_5 = ((_arg_3 < _arg_4) ? -1 : 1);
                    }
                    else
                    {
                        _local_5 = ((_arg_3 < _arg_4) ? 1 : -1);
                    };
                }
                else
                {
                    _local_35 = 1;
                    _local_5 = ((_local_5 + _local_35) % 8);
                    _local_6 = ((_local_6 + _local_35) % 8);
                };
            };
            return ((_local_6 - _local_5) * ((_arg_2) ? 1 : -1));
        }

        public static function getBombsAboutToExplode(_arg_1:HaxeFighter, _arg_2:FightContext, _arg_3:RunningEffect, _arg_4:Array=undefined):Array
        {
            var _local_7:* = (null as RunningEffect);
            var _local_10:* = (null as LinkedListNode);
            var _local_11:* = (null as LinkedListNode);
            var _local_14:* = (null as HaxeSpellEffect);
            var _local_15:* = null;
            var _local_16:int;
            var _local_17:* = (null as Array);
            var _local_18:* = (null as HaxeFighter);
            if (!(((_arg_1.playerType == (PlayerTypeEnum.MONSTER)) && (_arg_1.data.isSummon())) && (!(HaxeFighter.BOMB_BREED_ID.indexOf(_arg_1.breed) == -1))))
            {
                return ([]);
            };
            var _local_5:Array = ((_arg_4 == null) ? [] : _arg_4);
            if (_local_5.indexOf(_arg_1) != -1)
            {
                return (_local_5);
            };
            var _local_6:HaxeSpell = DamageCalculator.dataInterface.getLinkedExplosionSpellFromFighter(_arg_1);
            if (_local_6 == null)
            {
                return (_local_5);
            };
            var _local_8:int = _arg_2.targetedCell;
            var _local_9:LinkedListNode = _arg_1._buffs.head;
            while (_local_9 != null)
            {
                _local_10 = _local_9;
                _local_9 = _local_9.next;
                _local_11 = _local_10;
                if (_local_11.item.effect.actionId == 1027)
                {
                    _arg_1.getSummoner(_arg_2).storePendingBuff(_local_11.item);
                };
            };
            _arg_1.removeBuffByActionId(1027);
            _local_5.push(_arg_1);
            var _local_12:int;
            var _local_13:Array = _local_6.getEffects();
            while (_local_12 < _local_13.length)
            {
                _local_14 = _local_13[_local_12];
                _local_12++;
                if (_local_14.actionId == 1009)
                {
                    _local_7 = new RunningEffect(_arg_1, _local_6, _local_14);
                    _local_7.setParentEffect(_arg_3);
                    _local_7.forceCritical = _arg_3.forceCritical;
                    _local_15 = TargetManagement.getTargets(_arg_2, _arg_1, _local_6, _local_14, null);
                    _local_16 = 0;
                    _local_17 = _local_15.targetedFighters;
                    while (_local_16 < _local_17.length)
                    {
                        _local_18 = _local_17[_local_16];
                        _local_16++;
                        if (!(((_local_18 == (_arg_1)) || (_arg_3.isTargetingAnAncestor(_local_18))) || (!(_local_18.isLinkedBomb(_arg_1)))))
                        {
                            _arg_2.targetedCell = _local_18.getCurrentPositionCell();
                            _local_5 = TargetManagement.getBombsAboutToExplode(_local_18, _arg_2, _local_7, _local_5);
                        };
                    };
                    _arg_2.targetedCell = _local_8;
                };
            };
            return (_local_5);
        }


    }
} damageCalculation.damageManagement

