package damageCalculation
{
    import damageCalculation.fighterManagement.HaxeFighter;
    import haxe.ds.List;
    import haxe.ds._List.ListNode;
    import damageCalculation.spellManagement.Mark;
    import damageCalculation.spellManagement.HaxeSpellEffect;
    import tools.FpUtils;
    import haxe.ds.ArraySort;
    import damageCalculation.damageManagement.TargetManagement;
    import mapTools.MapTools;
    import mapTools.SpellZone;
    import damageCalculation.damageManagement.EffectOutput;
    import damageCalculation.fighterManagement.PlayerTypeEnum;

    public class FightContext 
    {

        public var triggeredMarks:Array;
        public var targetedCell:int;
        public var originalCaster:HaxeFighter;
        public var map:IMapInfo;
        public var inputPortalCellId:int;
        public var gameTurn:int;
        public var fighters:Array;
        public var fighterInitialPositions:List;
        public var debugMode:Boolean;

        public var lastKilledDefenders:Array = [];
        public var lastKilledChallengers:Array = [];
        public var inMovement:Boolean = false;
        public var tempFighters:Array = [];

        public function FightContext(_arg_1:int, _arg_2:IMapInfo, _arg_3:int, _arg_4:HaxeFighter, _arg_5:Array=undefined, _arg_6:List=undefined, _arg_7:int=-1, _arg_8:Boolean=false):void
        {
            var _local_9:int;
            var _local_10:* = (null as Array);
            var _local_11:* = (null as HaxeFighter);
            gameTurn = _arg_1;
            map = _arg_2;
            targetedCell = _arg_3;
            originalCaster = _arg_4;
            triggeredMarks = [];
            inputPortalCellId = _arg_7;
            debugMode = _arg_8;
            if (_arg_5 == null)
            {
                fighters = [];
            }
            else
            {
                fighters = _arg_5;
            };
            if (fighters.indexOf(_arg_4) == -1)
            {
                fighters.push(_arg_4);
            };
            if (_arg_6 == null)
            {
                fighterInitialPositions = _arg_2.getFightersInitialPositions();
                _local_9 = 0;
                _local_10 = fighters;
                while (_local_9 < _local_10.length)
                {
                    _local_11 = _local_10[_local_9];
                    _local_9++;
                    removeFighterCells(_local_11.id);
                };
            }
            else
            {
                fighterInitialPositions = _arg_6;
            };
        }

        public function usingPortal():Boolean
        {
            return (!(inputPortalCellId == -1));
        }

        public function removeFighterCells(_arg_1:Number):void
        {
            var _local_3:* = null;
            var _local_4:* = null;
            var _local_2:ListNode = fighterInitialPositions.h;
            while (_local_2 != null)
            {
                _local_3 = _local_2.item;
                _local_2 = _local_2.next;
                _local_4 = _local_3;
                if (_local_4.id == _arg_1)
                {
                    fighterInitialPositions.remove(_local_4);
                    return;
                };
            };
        }

        public function isCellEmptyForMovement(_arg_1:int):Boolean
        {
            var _local_4:* = (null as HaxeFighter);
            var _local_6:* = null;
            var _local_7:* = null;
            var _local_2:int;
            var _local_3:Array = fighters;
            while (_local_2 < _local_3.length)
            {
                _local_4 = _local_3[_local_2];
                _local_2++;
                if (_local_4.getCurrentPositionCell() == _arg_1)
                {
                    return (false);
                };
            };
            var _local_5:ListNode = fighterInitialPositions.h;
            while (_local_5 != null)
            {
                _local_6 = _local_5.item;
                _local_5 = _local_5.next;
                _local_7 = _local_6;
                if (_local_7.cell == _arg_1)
                {
                    return (false);
                };
            };
            return (map.isCellWalkable(_arg_1));
        }

        public function getPortalBonus():int
        {
            var _local_5:int;
            var _local_8:int;
            var _local_9:* = (null as Mark);
            var _local_10:* = (null as Array);
            var _local_11:* = (null as HaxeSpellEffect);
            var _gthis:FightContext = this;
            var _local_1:Array = FpUtils.arrayFilter_damageCalculation_spellManagement_Mark(map.getMarks(4), function (_arg_1:Mark):Boolean
            {
                return (_arg_1.active);
            });
            if (_local_1.length == 0)
            {
                return (0);
            };
            var _local_2:int;
            var _local_3:int;
            var _local_4:Mark = FpUtils.arrayFind_damageCalculation_spellManagement_Mark(_local_1, function (_arg_1:Mark):Boolean
            {
                return (_arg_1.mainCell == _gthis.inputPortalCellId);
            });
            if (_local_4 == null)
            {
                return (0);
            };
            var _local_6:Mark;
            var _local_7:int;
            var currentPortal:Mark = _local_4;
            _local_1 = FpUtils.arrayFilter_damageCalculation_spellManagement_Mark(_local_1, function (_arg_1:Mark):Boolean
            {
                return (_arg_1.teamId == currentPortal.teamId);
            });
            FpUtils.arrayRemove_damageCalculation_spellManagement_Mark(_local_1, currentPortal);
            while (true)
            {
                _local_5 = -1;
                ArraySort.sort(_local_1, function (_arg_1:Mark, _arg_2:Mark):int
                {
                    return (TargetManagement.comparePositions(currentPortal.mainCell, false, _arg_1.mainCell, _arg_2.mainCell));
                });
                _local_8 = 0;
                while (_local_8 < _local_1.length)
                {
                    _local_9 = _local_1[_local_8];
                    _local_8++;
                    _local_7 = MapTools.getDistance(_local_9.mainCell, currentPortal.mainCell);
                    if (((_local_7 < (_local_5)) || (_local_5 == -1)))
                    {
                        _local_5 = _local_7;
                        _local_6 = _local_9;
                    };
                };
                if (_local_6 != null)
                {
                    _local_8 = 0;
                    _local_10 = _local_6.associatedSpell.getEffects();
                    while (_local_8 < _local_10.length)
                    {
                        _local_11 = _local_10[_local_8];
                        _local_8++;
                        if (_local_11.actionId == 1181)
                        {
                            _local_3 = Math.max(_local_3, _local_11.getMinRoll());
                        };
                    };
                    _local_2 = (_local_2 + _local_5);
                    currentPortal = _local_6;
                    FpUtils.arrayRemove_damageCalculation_spellManagement_Mark(_local_1, currentPortal);
                }
                else
                {
                    throw ("There is no nearest Portal");
                };
                if (!(_local_1.length > 0)) break;
            };
            return (_local_3 + (_local_2 << 1));
        }

        public function getLastKilledAlly(_arg_1:uint):HaxeFighter
        {
            if ((((_arg_1 == 0) && (!(lastKilledChallengers == null))) && (lastKilledChallengers.length > 0)))
            {
                return (lastKilledChallengers[0]);
            };
            if ((((_arg_1 == 1) && (!(lastKilledDefenders == null))) && (lastKilledDefenders.length > 0)))
            {
                return (lastKilledDefenders[0]);
            };
            return (map.getLastKilledAlly(_arg_1));
        }

        public function getFreeId():Number
        {
            var _local_3:int;
            var _local_4:* = (null as Array);
            var _local_5:* = (null as HaxeFighter);
            var _local_1:Number = 1;
            var _local_2:Boolean;
            while ((!(_local_2)))
            {
                _local_2 = true;
                _local_3 = 0;
                _local_4 = getEveryFighter();
                while (_local_3 < _local_4.length)
                {
                    _local_5 = _local_4[_local_3];
                    _local_3++;
                    if (_local_1 == _local_5.id)
                    {
                        _local_1++;
                        _local_2 = false;
                        break;
                    };
                };
            };
            return (_local_1);
        }

        public function getFightersUpTo(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):Array
        {
            var _local_6:Array = [];
            var _local_7:HaxeFighter;
            while (true)
            {
                _arg_1 = MapTools.getNextCellByDirection(_arg_1, _arg_2);
                _arg_3--;
                _arg_4--;
                if (_arg_3 <= 0)
                {
                    _local_7 = getFighterFromCell(_arg_1);
                    if (_local_7 != null)
                    {
                        _local_6.push(_local_7);
                        _arg_5--;
                    };
                };
                if (!((((_local_7 == (null)) && (MapTools.isValidCellId(_arg_1))) && (_arg_4 > 0)) && (_arg_5 > 0))) break;
            };
            return (_local_6);
        }

        public function getFightersFromZone(_arg_1:SpellZone, _arg_2:int, _arg_3:int):Array
        {
            var _local_8:* = (null as HaxeFighter);
            var _local_10:* = null;
            var _local_11:* = null;
            if (((!(MapTools.isValidCellId(_arg_2))) || (!(MapTools.isValidCellId(_arg_3)))))
            {
                return ([]);
            };
            var _local_4:Array = [];
            var _local_5:Function = function (_arg_1:HaxeFighter, _arg_2:String):Boolean
            {
                if (((_arg_2 == ("A")) || ((_arg_1.isAlive()) && ((!(_arg_1.hasState(8))) || (_arg_2 == "a")))))
                {
                    return (MapTools.isValidCellId(_arg_1.getBeforeLastSpellPosition()));
                };
                return (false);
            };
            var _local_6:int;
            var _local_7:Array = fighters;
            while (_local_6 < _local_7.length)
            {
                _local_8 = _local_7[_local_6];
                _local_6++;
                if (((_local_5(_local_8, _arg_1.shape)) && (_arg_1.isCellInZone(_local_8.getBeforeLastSpellPosition(), _arg_2, _arg_3))))
                {
                    _local_4.push(_local_8);
                };
            };
            var _local_9:ListNode = fighterInitialPositions.h;
            while (_local_9 != null)
            {
                _local_10 = _local_9.item;
                _local_9 = _local_9.next;
                _local_11 = _local_10;
                if (((MapTools.isValidCellId(_local_11.cell)) && (_arg_1.isCellInZone(_local_11.cell, _arg_2, _arg_3))))
                {
                    _local_8 = createFighterById(_local_11.id);
                    if (((_local_8 != (null)) && (_local_5(_local_8, _arg_1.shape))))
                    {
                        _local_4.push(_local_8);
                    };
                };
            };
            return (_local_4);
        }

        public function getFighterFromCell(_arg_1:int, _arg_2:Boolean=false):HaxeFighter
        {
            var _local_5:* = (null as HaxeFighter);
            var _local_7:* = null;
            var _local_8:* = null;
            var _local_3:int;
            var _local_4:Array = fighters;
            while (_local_3 < _local_4.length)
            {
                _local_5 = _local_4[_local_3];
                _local_3++;
                if ((((_arg_2) && (_local_5.getCurrentPositionCell() == _arg_1)) || ((_arg_2) && (_local_5.getBeforeLastSpellPosition() == _arg_1))))
                {
                    return (_local_5);
                };
            };
            var _local_6:ListNode = fighterInitialPositions.h;
            while (_local_6 != null)
            {
                _local_7 = _local_6.item;
                _local_6 = _local_6.next;
                _local_8 = _local_7;
                if (_local_8.cell == _arg_1)
                {
                    return (createFighterById(_local_8.id));
                };
            };
            return (null);
        }

        public function getFighterCurrentSummonCount(_arg_1:HaxeFighter):int
        {
            var _local_5:* = (null as HaxeFighter);
            var _local_2:Array = getEveryFighter();
            var _local_3:int;
            var _local_4:int;
            while (_local_4 < _local_2.length)
            {
                _local_5 = _local_2[_local_4];
                _local_4++;
                if (((((((_local_5.id != (_arg_1.id)) && (_local_5.isAlive())) && (_local_5.data.isSummon())) && (_local_5.data.useSummonSlot())) && (_local_5.data.getSummonerId() == _arg_1.id)) && (!(_local_5.isStaticElement))))
                {
                    _local_3++;
                };
            };
            return (_local_3);
        }

        public function getFighterById(_arg_1:Number):HaxeFighter
        {
            var _local_4:* = (null as HaxeFighter);
            var _local_2:int;
            var _local_3:Array = fighters;
            while (_local_2 < _local_3.length)
            {
                _local_4 = _local_3[_local_2];
                _local_2++;
                if (_local_4.id == _arg_1)
                {
                    return (_local_4);
                };
            };
            return (createFighterById(_arg_1));
        }

        public function getEveryFighter():Array
        {
            var _local_3:Number;
            var _local_1:int;
            var _local_2:Array = map.getEveryFighterId();
            while (_local_1 < _local_2.length)
            {
                _local_3 = _local_2[_local_1];
                _local_1++;
                getFighterById(_local_3);
            };
            return (fighters);
        }

        public function getCarriedFighterBy(_arg_1:HaxeFighter):HaxeFighter
        {
            var _local_2:Number = map.getCarriedFighterIdBy(_arg_1);
            if (_local_2 != 0)
            {
                return (getFighterById(_local_2));
            };
            return (null);
        }

        public function getAffectedFighters():Array
        {
            var _local_1:Function = function (_arg_1:HaxeFighter):Boolean
            {
                var _local_3:* = (null as EffectOutput);
                var _local_4:* = (null as EffectOutput);
                var _local_2:ListNode = _arg_1.totalEffects.h;
                while (_local_2 != null)
                {
                    _local_3 = _local_2.item;
                    _local_2 = _local_2.next;
                    _local_4 = _local_3;
                    if ((((((((((((_local_4.damageRange != (null)) || (!(_local_4.movement == null))) || (_local_4.attemptedApTheft)) || (_local_4.attemptedAmTheft)) || (!(_local_4.apStolen == 0))) || (!(_local_4.amStolen == 0))) || (!(_local_4.rangeStolen == 0))) || (!(_local_4.summon == null))) || (_local_4.isSummoning)) || (_local_4.dispell)) || (_local_4.death)))
                    {
                        return (true);
                    };
                };
                return (false);
            };
            return (FpUtils.arrayFilter_damageCalculation_fighterManagement_HaxeFighter(fighters, _local_1));
        }

        public function createFighterById(_arg_1:Number):HaxeFighter
        {
            var _local_2:HaxeFighter = map.getFighterById(_arg_1);
            if (_local_2 != null)
            {
                fighters.push(_local_2);
                removeFighterCells(_local_2.id);
            };
            return (_local_2);
        }

        public function copy():FightContext
        {
            var _local_1:FightContext = new FightContext(gameTurn, map, targetedCell, originalCaster, fighters, fighterInitialPositions);
            _local_1.triggeredMarks = triggeredMarks;
            _local_1.tempFighters = tempFighters;
            _local_1.debugMode = debugMode;
            return (_local_1);
        }

        public function addLastKilledAlly(_arg_1:HaxeFighter):void
        {
            var _local_2:Array = ((_arg_1.teamId == 0) ? lastKilledChallengers : lastKilledDefenders);
            var _local_3:int;
            if (_arg_1.playerType == PlayerTypeEnum.HUMAN)
            {
                _local_3 = 0;
            };
            if (_arg_1.playerType != PlayerTypeEnum.HUMAN)
            {
                while (((_local_3 < (_local_2.length)) && (_local_2[_local_3].playerType == PlayerTypeEnum.HUMAN)))
                {
                    _local_3++;
                };
                if (_arg_1.playerType != PlayerTypeEnum.SIDEKICK)
                {
                    while (((_local_3 < (_local_2.length)) && (_local_2[_local_3].playerType == PlayerTypeEnum.SIDEKICK)))
                    {
                        _local_3++;
                    };
                };
            };
            if ((_arg_1.teamId == 0))
            {
                lastKilledChallengers.insert(_local_3, _arg_1);
            }
            else
            {
                lastKilledDefenders.insert(_local_3, _arg_1);
            };
        }


    }
}

