package damageCalculation.fighterManagement
{
    import damageCalculation.tools.LinkedList;
    import damageCalculation.tools.LinkedListNode;
    import haxe.ds.List;
    import damageCalculation.damageManagement.DamageRange;
    import damageCalculation.damageManagement.EffectOutput;
    import haxe.ds._List.ListNode;
    import damageCalculation.FightContext;
    import damageCalculation.spellManagement.HaxeSpellEffect;
    import tools.ActionIdHelper;
    import damageCalculation.spellManagement.HaxeSpell;
    import tools.FpUtils;
    import damageCalculation.spellManagement.RunningEffect;
    import damageCalculation.spellManagement.SpellManager;
    import damageCalculation.tools.Interval;
    import mapTools.MapTools;

    public class HaxeFighter 
    {

        public static var MAX_RESIST_HUMAN:int = 50;
        public static var MAX_RESIST_MONSTER:int = 100;
        public static var INVALID_ID:Number = 0;
        public static var BOMB_BREED_ID:Array = [3112, 3113, 3114, 5161];
        public static var STEAMER_TURRET_BREED_ID:Array = [3287, 3288, 3289, 5143, 5141, 5142];
        public static var MIN_PERMANENT_DAMAGE_PERCENT:int = 0;
        public static var BASE_PERMANENT_DAMAGE_PERCENT:int = 10;
        public static var MAX_PERMANENT_DAMAGE_PERCENT:int = 50;

        public var id:Number;
        public var data:IFighterData;
        public var _turnBeginPosition:int;

        public var _save:Object = null;
        public var _carriedFighter:HaxeFighter = null;
        public var _currentPosition:int = -1;
        public var _pendingPreviousPosition:int = -1;
        public var _pendingDispelledBuffs:LinkedList = new LinkedList();
        public var _pendingBuffHead:LinkedListNode = null;
        public var _buffs:LinkedList = new LinkedList();
        public var totalEffects:List = new List();
        public var lastTheoreticalRawDamageTaken:DamageRange = null;
        public var lastRawDamageTaken:DamageRange = null;
        public var beforeLastSpellPosition:int = -1;
        public var pendingEffects:List = new List();
        public var isStaticElement:Boolean = false;
        public var teamId:uint = 0;
        public var playerType:PlayerTypeEnum = PlayerTypeEnum.UNKNOWN;
        public var level:int = 200;
        public var breed:int = -1;

        public function HaxeFighter(_arg_1:Number, _arg_2:int, _arg_3:int, _arg_4:PlayerTypeEnum, _arg_5:uint, _arg_6:Boolean, _arg_7:Array, _arg_8:IFighterData):void
        {
            var _local_10:* = (null as HaxeBuff);
            id = _arg_1;
            level = _arg_2;
            breed = _arg_3;
            playerType = _arg_4;
            isStaticElement = _arg_6;
            data = _arg_8;
            teamId = _arg_5;
            var _local_9:int;
            while (_local_9 < _arg_7.length)
            {
                _local_10 = _arg_7[_local_9];
                _local_9++;
                _buffs.add(_local_10);
            };
        }

        public function wasTeleportedInInvalidCellThisTurn(_arg_1:FightContext):Boolean
        {
            var _local_3:* = (null as EffectOutput);
            var _local_4:* = (null as EffectOutput);
            var _local_2:ListNode = pendingEffects.h;
            while (_local_2 != null)
            {
                _local_3 = _local_2.item;
                _local_2 = _local_2.next;
                _local_4 = _local_3;
                if (((_local_4.movement != (null)) && (!(_arg_1.map.isCellWalkable(_local_4.movement.newPosition)))))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function wasTelefraggedThisTurn():Boolean
        {
            var _local_2:* = (null as EffectOutput);
            var _local_3:* = (null as EffectOutput);
            var _local_1:ListNode = pendingEffects.h;
            while (_local_1 != null)
            {
                _local_2 = _local_1.item;
                _local_1 = _local_1.next;
                _local_3 = _local_2;
                if (((_local_3.movement != (null)) && (!(_local_3.movement.swappedWith == null))))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function underMaximizeRollEffect():Boolean
        {
            var _local_2:* = (null as LinkedListNode);
            var _local_3:* = (null as LinkedListNode);
            var _local_4:* = (null as HaxeBuff);
            var _local_1:LinkedListNode = _buffs.head;
            while (_local_1 != null)
            {
                _local_2 = _local_1;
                _local_1 = _local_1.next;
                _local_3 = _local_2;
                _local_4 = _local_3.item;
                if (_local_4.effect.actionId == 782)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function storeSpellEffectStatBoost(_arg_1:HaxeSpell, _arg_2:HaxeSpellEffect):void
        {
            var _local_3:HaxeSpellEffect = _arg_2.clone();
            _local_3.actionId = ActionIdHelper.statBoostToBuffActionId(_arg_2.actionId);
            var _local_4:HaxeBuff = new HaxeBuff(id, _arg_1, _local_3);
            storePendingBuff(_local_4);
        }

        public function storePendingBuff(_arg_1:HaxeBuff):void
        {
            var _local_2:* = (null as Function);
            var _local_3:int;
            var _local_4:int;
            var _local_5:Boolean;
            var _local_6:* = (null as LinkedListNode);
            var _local_7:* = (null as LinkedListNode);
            var _local_8:* = (null as LinkedListNode);
            if (_arg_1.spell.maxEffectsStack != -1)
            {
                _local_2 = function (_arg_1:HaxeBuff, _arg_2:HaxeBuff):Boolean
                {
                    if (_arg_1.effect.id != _arg_2.effect.id)
                    {
                        if (((_arg_1.spell.id == (_arg_2.spell.id)) && (_arg_1.effect.actionId == _arg_2.effect.actionId)))
                        {
                            if (!((_arg_1.effect.order == (_arg_2.effect.order)) && (!(_arg_1.effect.level == _arg_2.effect.level))))
                            {
                                return (!(_arg_1.effect.isCritical == _arg_2.effect.isCritical));
                            };
                            return (true);
                        };
                        return (false);
                    };
                    return (true);
                };
                _local_3 = 0;
                _local_4 = 0;
                _local_5 = false;
                _local_6 = _buffs.head;
                while (_local_6 != null)
                {
                    _local_7 = _local_6;
                    _local_6 = _local_6.next;
                    _local_8 = _local_7;
                    if (_local_8 == _pendingBuffHead)
                    {
                        _local_5 = true;
                    };
                    if (_local_2(_arg_1, _local_8.item))
                    {
                        if (!_local_5)
                        {
                            _local_3++;
                        }
                        else
                        {
                            _local_4++;
                        };
                    };
                };
                if ((_local_3 + _local_4) >= _arg_1.spell.maxEffectsStack)
                {
                    _local_5 = false;
                    _local_6 = _buffs.head;
                    while (_local_6 != null)
                    {
                        _local_7 = _local_6;
                        _local_6 = _local_6.next;
                        _local_8 = _local_7;
                        if (_local_8 == _pendingBuffHead)
                        {
                            _local_5 = true;
                        };
                        if (_local_2(_local_8.item, _arg_1))
                        {
                            if (!_local_5)
                            {
                                _pendingDispelledBuffs.add(_local_8.item);
                            };
                            safeRemoveBuff(_local_8);
                            break;
                        };
                    };
                };
            };
            if (_pendingBuffHead == null)
            {
                _pendingBuffHead = _buffs.add(_arg_1);
            }
            else
            {
                _buffs.add(_arg_1);
            };
        }

        public function setCurrentPositionCell(_arg_1:int):void
        {
            _pendingPreviousPosition = getCurrentPositionCell();
            _currentPosition = _arg_1;
        }

        public function setBeforeLastSpellPosition(_arg_1:int):void
        {
            beforeLastSpellPosition = _arg_1;
        }

        public function savePositionBeforeSpellExecution():void
        {
            setBeforeLastSpellPosition(getCurrentPositionCell());
        }

        public function savePendingEffects():void
        {
            if (((totalEffects != (null)) && (!(pendingEffects == null))))
            {
                totalEffects = FpUtils.listConcat_damageCalculation_damageManagement_EffectOutput(totalEffects, pendingEffects);
            }
            else
            {
                totalEffects = pendingEffects;
            };
            pendingEffects = new List();
        }

        public function save():Object
        {
            _save = {
                "id":id,
                "outputs":pendingEffects.map(function (_arg_1:EffectOutput):EffectOutput
                {
                    return (_arg_1);
                }),
                "buffs":_buffs.copy(),
                "cell":getCurrentPositionCell(),
                "previousPosition":_pendingPreviousPosition
            };
            return (_save);
        }

        public function safeRemoveBuff(_arg_1:LinkedListNode):void
        {
            if (_arg_1 == _pendingBuffHead)
            {
                _pendingBuffHead = _arg_1.next;
            };
            _buffs.remove(_arg_1);
        }

        public function resetToInitialState():void
        {
            lastRawDamageTaken = null;
            setCurrentPositionCell(-1);
            setBeforeLastSpellPosition(-1);
            _pendingPreviousPosition = -1;
            flushPendingBuffs();
            pendingEffects = new List();
        }

        public function removeState(_arg_1:int):Boolean
        {
            var _local_4:* = (null as LinkedListNode);
            var _local_5:* = (null as LinkedListNode);
            var _local_2:Boolean;
            var _local_3:LinkedListNode = _buffs.head;
            while (_local_3 != null)
            {
                _local_4 = _local_3;
                _local_3 = _local_3.next;
                _local_5 = _local_4;
                if (((_local_5.item.effect.actionId == (950)) && (_local_5.item.effect.getMinRoll() == _arg_1)))
                {
                    if (_local_5 == _pendingBuffHead)
                    {
                        _local_2 = true;
                    };
                    if (!_local_2)
                    {
                        _pendingDispelledBuffs.add(_local_5.item);
                    };
                    safeRemoveBuff(_local_5);
                    return (true);
                };
            };
            return (false);
        }

        public function removeBuffBySpellId(_arg_1:int):void
        {
            var _local_4:* = (null as LinkedListNode);
            var _local_5:* = (null as LinkedListNode);
            var _local_2:Boolean;
            var _local_3:LinkedListNode = _buffs.head;
            while (_local_3 != null)
            {
                _local_4 = _local_3;
                _local_3 = _local_3.next;
                _local_5 = _local_4;
                if (_local_5.item.spell.id == _arg_1)
                {
                    if (_local_5 == _pendingBuffHead)
                    {
                        _local_2 = true;
                    };
                    if (!_local_2)
                    {
                        _pendingDispelledBuffs.add(_local_5.item);
                    };
                    safeRemoveBuff(_local_5);
                };
            };
        }

        public function removeBuffByActionId(_arg_1:int):void
        {
            var _local_4:* = (null as LinkedListNode);
            var _local_5:* = (null as LinkedListNode);
            var _local_2:Boolean;
            var _local_3:LinkedListNode = _buffs.head;
            while (_local_3 != null)
            {
                _local_4 = _local_3;
                _local_3 = _local_3.next;
                _local_5 = _local_4;
                if (_local_5.item.effect.actionId == _arg_1)
                {
                    if (_local_5 == _pendingBuffHead)
                    {
                        _local_2 = true;
                    };
                    if (!_local_2)
                    {
                        _pendingDispelledBuffs.add(_local_5.item);
                    };
                    safeRemoveBuff(_local_5);
                };
            };
        }

        public function reduceBuffDurations(_arg_1:int):Array
        {
            var _local_5:* = (null as LinkedListNode);
            var _local_6:* = (null as LinkedListNode);
            var _local_7:* = (null as HaxeBuff);
            var _local_2:Array = [];
            var _local_3:Boolean;
            var _local_4:LinkedListNode = _buffs.head;
            while (_local_4 != null)
            {
                _local_5 = _local_4;
                _local_4 = _local_4.next;
                _local_6 = _local_5;
                _local_7 = _local_6.item;
                if ((((_local_7.effect.duration > (0)) && (_local_7.effect.duration <= _arg_1)) && (_local_7.effect.isDispellable)))
                {
                    if (_local_6 == _pendingBuffHead)
                    {
                        _local_3 = true;
                    };
                    if (!_local_3)
                    {
                        _local_2.push(_local_7);
                        _pendingDispelledBuffs.add(_local_7);
                    };
                    safeRemoveBuff(_local_6);
                };
            };
            return (_local_2);
        }

        public function load(_arg_1:Object=undefined):Boolean
        {
            if (_arg_1 == null)
            {
                if (_save != null)
                {
                    return (load(_save));
                };
                return (false);
            };
            if (id == _arg_1.id)
            {
                pendingEffects = FpUtils.listCopy_damageCalculation_damageManagement_EffectOutput(_arg_1.outputs);
                _buffs = _arg_1.buffs.copy();
                setCurrentPositionCell(_arg_1.cell);
                _pendingPreviousPosition = _arg_1.previousPosition;
                return (true);
            };
            return (false);
        }

        public function isUnlucky():Boolean
        {
            var _local_3:* = (null as LinkedListNode);
            var _local_4:* = (null as LinkedListNode);
            var _local_5:* = (null as HaxeBuff);
            var _local_1:Boolean;
            var _local_2:LinkedListNode = _buffs.head;
            while (_local_2 != null)
            {
                _local_3 = _local_2;
                _local_2 = _local_2.next;
                _local_4 = _local_3;
                _local_5 = _local_4.item;
                if (_local_5.effect.actionId == 781)
                {
                    _local_1 = true;
                    break;
                };
            };
            return (_local_1);
        }

        public function isSwitchTeleport(_arg_1:int=-1):Boolean
        {
            if (!(((((_arg_1 == (1104)) || (_arg_1 == 1105)) || (_arg_1 == 1106)) || (_arg_1 == 784)) || (_arg_1 == 1099)))
            {
                return (_arg_1 == 1100);
            };
            return (true);
        }

        public function isSteamerTurret():Boolean
        {
            if (((playerType == (PlayerTypeEnum.MONSTER)) && (data.isSummon())))
            {
                return (!(HaxeFighter.STEAMER_TURRET_BREED_ID.indexOf(breed) == -1));
            };
            return (false);
        }

        public function isPacifist():Boolean
        {
            return (hasStateEffect(6));
        }

        public function isLinkedBomb(_arg_1:HaxeFighter):Boolean
        {
            if (((_arg_1 != (null)) && (((_arg_1.playerType == (PlayerTypeEnum.MONSTER)) && (_arg_1.data.isSummon())) && (!(HaxeFighter.BOMB_BREED_ID.indexOf(_arg_1.breed) == -1)))))
            {
                if (_arg_1.data.getSummonerId() != data.getSummonerId())
                {
                    return (_arg_1.data.getSummonerId() == id);
                };
                return (true);
            };
            return (false);
        }

        public function isInvulnerableWeapon():Boolean
        {
            return (hasStateEffect(28));
        }

        public function isInvulnerableWater():Boolean
        {
            return (hasStateEffect(23));
        }

        public function isInvulnerableTo(_arg_1:RunningEffect, _arg_2:Boolean=false, _arg_3:int=undefined):Boolean
        {
            var _local_4:HaxeSpellEffect = _arg_1.getSpellEffect();
            var _local_5:HaxeFighter = _arg_1.getCaster();
            if (((((((((((((hasStateEffect(7)) || ((hasStateEffect(27)) && (_local_4.isCritical))) || ((hasStateEffect(28)) && (_arg_1.getSpell().isWeapon))) || (((hasStateEffect(31)) && (!(_local_5 == null))) && (_local_5.data.isSummon()))) || ((hasStateEffect(26)) && (_local_4.actionId == 80))) || ((hasStateEffect(25)) && (_arg_3 == 0))) || ((hasStateEffect(24)) && (_arg_3 == 1))) || ((hasStateEffect(23)) && (_arg_3 == 3))) || ((hasStateEffect(21)) && (_arg_3 == 2))) || ((hasStateEffect(22)) && (_arg_3 == 4))) || ((hasStateEffect(19)) && (_arg_2))) || ((hasStateEffect(20)) && (!(_arg_2)))))
            {
                return (true);
            };
            return (false);
        }

        public function isInvulnerableSummon():Boolean
        {
            return (hasStateEffect(31));
        }

        public function isInvulnerableRange():Boolean
        {
            return (hasStateEffect(20));
        }

        public function isInvulnerablePush():Boolean
        {
            return (hasStateEffect(26));
        }

        public function isInvulnerableNeutral():Boolean
        {
            return (hasStateEffect(25));
        }

        public function isInvulnerableMelee():Boolean
        {
            return (hasStateEffect(19));
        }

        public function isInvulnerableFire():Boolean
        {
            return (hasStateEffect(21));
        }

        public function isInvulnerableEarth():Boolean
        {
            return (hasStateEffect(24));
        }

        public function isInvulnerableCritical():Boolean
        {
            return (hasStateEffect(27));
        }

        public function isInvulnerableAir():Boolean
        {
            return (hasStateEffect(22));
        }

        public function isInvulnerable():Boolean
        {
            return (hasStateEffect(7));
        }

        public function isIncurable():Boolean
        {
            return (hasStateEffect(5));
        }

        public function isCarrying():Boolean
        {
            return (hasState(3));
        }

        public function isCarried():Boolean
        {
            return (hasState(8));
        }

        public function isBomb():Boolean
        {
            if (((playerType == (PlayerTypeEnum.MONSTER)) && (data.isSummon())))
            {
                return (!(HaxeFighter.BOMB_BREED_ID.indexOf(breed) == -1));
            };
            return (false);
        }

        public function isAppearing():Boolean
        {
            var _local_2:* = (null as EffectOutput);
            var _local_3:* = (null as EffectOutput);
            var _local_1:ListNode = pendingEffects.h;
            while (_local_1 != null)
            {
                _local_2 = _local_1.item;
                _local_1 = _local_1.next;
                _local_3 = _local_2;
                if (_local_3.summon != null)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function isAlive():Boolean
        {
            var _local_3:* = (null as EffectOutput);
            var _local_4:* = (null as EffectOutput);
            var _local_1:Boolean;
            var _local_2:ListNode = pendingEffects.h;
            while (_local_2 != null)
            {
                _local_3 = _local_2.item;
                _local_2 = _local_2.next;
                _local_4 = _local_3;
                if (_local_4.death)
                {
                    _local_1 = true;
                }
                else
                {
                    if (_local_4.summon != null)
                    {
                        _local_1 = false;
                    };
                };
            };
            if (!_local_1)
            {
                return (getCharacteristicValue("lifePoints") > 0);
            };
            return (false);
        }

        public function hasStateEffect(_arg_1:int):Boolean
        {
            var _local_3:* = (null as LinkedListNode);
            var _local_4:* = (null as LinkedListNode);
            var _local_5:* = (null as HaxeBuff);
            var _local_2:LinkedListNode = _buffs.head;
            while (_local_2 != null)
            {
                _local_3 = _local_2;
                _local_2 = _local_2.next;
                _local_4 = _local_3;
                _local_5 = _local_4.item;
                if ((((_local_5.spellState != (null)) && (!(_local_5.spellState._stateEffects.indexOf(_arg_1) == -1))) && (SpellManager.isInstantaneousSpellEffect(_local_5.effect))))
                {
                    if (hasState(_local_5.effect.param3))
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        public function hasState(_arg_1:int):Boolean
        {
            var _local_5:* = (null as LinkedListNode);
            var _local_6:* = (null as LinkedListNode);
            var _local_7:* = (null as HaxeBuff);
            var _local_2:Boolean;
            var _local_3:Boolean;
            var _local_4:LinkedListNode = _buffs.head;
            while (_local_4 != null)
            {
                _local_5 = _local_4;
                _local_4 = _local_4.next;
                _local_6 = _local_5;
                _local_7 = _local_6.item;
                if ((((_local_7.effect.actionId == (950)) && (_local_7.effect.getMinRoll() == _arg_1)) && (SpellManager.isInstantaneousSpellEffect(_local_7.effect))))
                {
                    _local_2 = true;
                };
                if ((((_local_7.effect.actionId == (952)) && (_local_7.effect.getMinRoll() == _arg_1)) && (SpellManager.isInstantaneousSpellEffect(_local_7.effect))))
                {
                    _local_3 = true;
                    break;
                };
            };
            if (_local_2)
            {
                return (!(_local_3));
            };
            return (false);
        }

        public function getSummoner(_arg_1:FightContext):HaxeFighter
        {
            var _local_2:Number = data.getSummonerId();
            return (_arg_1.getFighterById(_local_2));
        }

        public function getSpellDamageModification(_arg_1:int):int
        {
            var _local_4:* = (null as LinkedListNode);
            var _local_5:* = (null as LinkedListNode);
            var _local_6:* = (null as HaxeBuff);
            var _local_2:int;
            var _local_3:LinkedListNode = _buffs.head;
            while (_local_3 != null)
            {
                _local_4 = _local_3;
                _local_3 = _local_3.next;
                _local_5 = _local_4;
                _local_6 = _local_5.item;
                if (((_local_6.effect.actionId == (283)) && (_local_6.effect.param1 == _arg_1)))
                {
                    _local_2 = (_local_2 + _local_6.effect.param3);
                };
            };
            return (_local_2);
        }

        public function getSpellBaseDamageModification(_arg_1:int):int
        {
            var _local_4:* = (null as LinkedListNode);
            var _local_5:* = (null as LinkedListNode);
            var _local_6:* = (null as HaxeBuff);
            var _local_2:int;
            var _local_3:LinkedListNode = _buffs.head;
            while (_local_3 != null)
            {
                _local_4 = _local_3;
                _local_3 = _local_3.next;
                _local_5 = _local_4;
                _local_6 = _local_5.item;
                if (((_local_6.effect.actionId == (293)) && (_local_6.effect.param1 == _arg_1)))
                {
                    _local_2 = (_local_2 + _local_6.effect.param3);
                };
            };
            return (_local_2);
        }

        public function getSharingDamageTargets(_arg_1:FightContext):Array
        {
            var _local_2:* = (null as Array);
            var _local_5:* = (null as LinkedListNode);
            var _local_6:* = (null as LinkedListNode);
            var _local_7:* = (null as HaxeBuff);
            var _local_8:int;
            var _local_9:* = (null as Array);
            var _local_10:* = (null as HaxeFighter);
            var _local_11:* = (null as LinkedListNode);
            var _local_12:* = (null as LinkedListNode);
            var _local_13:* = (null as LinkedListNode);
            var _local_14:* = (null as HaxeBuff);
            var _local_3:Array = [];
            var _local_4:LinkedListNode = _buffs.head;
            while (_local_4 != null)
            {
                _local_5 = _local_4;
                _local_4 = _local_4.next;
                _local_6 = _local_5;
                _local_7 = _local_6.item;
                if (_local_7.effect.actionId == 1061)
                {
                    _local_2 = [];
                    _local_8 = 0;
                    _local_9 = _arg_1.getEveryFighter();
                    while (_local_8 < _local_9.length)
                    {
                        _local_10 = _local_9[_local_8];
                        _local_8++;
                        if (_local_10.id != id)
                        {
                            _local_11 = _local_10._buffs.head;
                            while (_local_11 != null)
                            {
                                _local_12 = _local_11;
                                _local_11 = _local_11.next;
                                _local_13 = _local_12;
                                _local_14 = _local_13.item;
                                if ((((_local_14.effect.actionId == (1061)) && (_local_7.spell.id == _local_14.spell.id)) && (_local_7.casterId == _local_14.casterId)))
                                {
                                    _local_2.push(_local_10);
                                    break;
                                };
                            };
                        };
                    };
                    _local_2.push(this);
                    _local_3.push(_local_2);
                };
            };
            return (_local_3);
        }

        public function getPendingShield():Interval
        {
            var _local_3:* = (null as DamageRange);
            var _local_4:* = (null as DamageRange);
            var _local_1:Interval = new Interval(getCharacteristicValue("shieldPoints"), getCharacteristicValue("shieldPoints"));
            var _local_2:ListNode = FpUtils.listConcat_damageCalculation_damageManagement_DamageRange(pendingEffects.map(function (_arg_1:EffectOutput):DamageRange
            {
                return (_arg_1.computeLifeDamage());
            }), pendingEffects.map(function (_arg_1:EffectOutput):DamageRange
            {
                return (_arg_1.computeShieldDamage());
            })).h;
            while (_local_2 != null)
            {
                _local_3 = _local_2.item;
                _local_2 = _local_2.next;
                _local_4 = _local_3;
                if (((_local_4.isHeal) && (_local_4.isShieldDamage)))
                {
                    _local_1.addInterval(_local_4);
                }
                else
                {
                    if (((_local_4.isHeal) && (_local_4.isShieldDamage)))
                    {
                        _local_1.subInterval(_local_4);
                    };
                };
            };
            _local_1.minimizeBy(0);
            return (_local_1);
        }

        public function getPendingPreviousPosition():int
        {
            if (_pendingPreviousPosition != -1)
            {
                return (_pendingPreviousPosition);
            };
            var _local_1:int = data.getPreviousPosition();
            if (_local_1 != -1)
            {
                return (_local_1);
            };
            return (getCurrentPositionCell());
        }

        public function getPendingMissingLifePoints():Interval
        {
            var _local_3:* = (null as EffectOutput);
            var _local_4:* = (null as EffectOutput);
            var _local_5:* = (null as DamageRange);
            var _local_1:Interval = new Interval((getCharacteristicValue("maxLifePoints") - getCharacteristicValue("lifePoints")), (getCharacteristicValue("maxLifePoints") - getCharacteristicValue("lifePoints")));
            var _local_2:ListNode = pendingEffects.h;
            while (_local_2 != null)
            {
                _local_3 = _local_2.item;
                _local_2 = _local_2.next;
                _local_4 = _local_3;
                _local_5 = _local_4.damageRange;
                if (_local_5 != null)
                {
                    if (((_local_5.isHeal) && (!(_local_5.isShieldDamage))))
                    {
                        _local_1.subInterval(_local_5);
                    }
                    else
                    {
                        if ((((_local_5.isHeal) && (!(_local_5.isShieldDamage))) && (!(_local_5.isInvulnerable))))
                        {
                            _local_1.addInterval(_local_5);
                        };
                    };
                };
            };
            _local_1.minimizeBy(0);
            _local_1.maximizeBy(getCharacteristicValue("maxLifePoints"));
            return (_local_1);
        }

        public function getPendingLifePoints():Interval
        {
            var _local_3:* = (null as EffectOutput);
            var _local_4:* = (null as EffectOutput);
            var _local_5:* = (null as DamageRange);
            var _local_1:Interval = new Interval(getCharacteristicValue("lifePoints"), getCharacteristicValue("lifePoints"));
            var _local_2:ListNode = pendingEffects.h;
            while (_local_2 != null)
            {
                _local_3 = _local_2.item;
                _local_2 = _local_2.next;
                _local_4 = _local_3;
                _local_5 = _local_4.damageRange;
                if (_local_5 != null)
                {
                    if (((_local_5.isHeal) && (!(_local_5.isShieldDamage))))
                    {
                        _local_1.addInterval(_local_5);
                    }
                    else
                    {
                        if ((((_local_5.isHeal) && (!(_local_5.isShieldDamage))) && (!(_local_5.isInvulnerable))))
                        {
                            _local_1.subInterval(_local_5);
                        };
                    };
                };
            };
            _local_1.minimizeBy(0);
            _local_1.maximizeBy(getCharacteristicValue("maxLifePoints"));
            return (_local_1);
        }

        public function getPendingEffects():List
        {
            return (pendingEffects);
        }

        public function getModelId():uint
        {
            return (0);
        }

        public function getMaxLife():int
        {
            return (getCharacteristicValue("maxLifePoints"));
        }

        public function getLifePoint():int
        {
            return (getCharacteristicValue("lifePoints"));
        }

        public function getHealOnDamageRatio(_arg_1:RunningEffect, _arg_2:Boolean):int
        {
            var _local_4:* = (null as LinkedListNode);
            var _local_5:* = (null as LinkedListNode);
            var _local_6:* = (null as HaxeBuff);
            var _local_3:LinkedListNode = _buffs.head;
            while (_local_3 != null)
            {
                _local_4 = _local_3;
                _local_3 = _local_3.next;
                _local_5 = _local_4;
                _local_6 = _local_5.item;
                if (((_local_6.effect.actionId == (1164)) && ((SpellManager.isInstantaneousSpellEffect(_local_6.effect)) || (_local_6.shouldBeTriggeredOnTargetDamage(_arg_1, this, _arg_2, false)))))
                {
                    return (_local_6.effect.param1);
                };
            };
            return (0);
        }

        public function getElementMainStat(_arg_1:int):int
        {
            switch (_arg_1)
            {
                default:
                    return (0);
                case 0:
                    return (getCharacteristicValue("strength"));
                case 1:
                    return (getCharacteristicValue("strength"));
                case 2:
                    return (getCharacteristicValue("intelligence"));
                case 3:
                    return (getCharacteristicValue("chance"));
                case 4:
                    return (getCharacteristicValue("agility"));
                case 6:
                    return (getElementMainStat(getBestElement()));
                    return; //dead code
            };
        }

        public function getElementMainResist(_arg_1:int):int
        {
            var _local_3:int;
            var _local_2:int = ((playerType == PlayerTypeEnum.HUMAN) ? 50 : 100);
            switch (_arg_1)
            {
                default:
                    _local_3 = 0;
                    break;
                case 0:
                    _local_3 = getCharacteristicValue("neutralElementResistPercent");
                    break;
                case 1:
                    _local_3 = getCharacteristicValue("earthElementResistPercent");
                    break;
                case 2:
                    _local_3 = getCharacteristicValue("fireElementResistPercent");
                    break;
                case 3:
                    _local_3 = getCharacteristicValue("waterElementResistPercent");
                    break;
                case 4:
                    _local_3 = getCharacteristicValue("airElementResistPercent");
            };
            if (_local_3 > _local_2)
            {
                return (_local_2);
            };
            return (_local_3);
        }

        public function getElementMainReduction(_arg_1:int):int
        {
            switch (_arg_1)
            {
                default:
                    return (0);
                case 0:
                    return (getCharacteristicValue("neutralElementReduction"));
                case 1:
                    return (getCharacteristicValue("earthElementReduction"));
                case 2:
                    return (getCharacteristicValue("fireElementReduction"));
                case 3:
                    return (getCharacteristicValue("waterElementReduction"));
                case 4:
                    return (getCharacteristicValue("airElementReduction"));
                    return; //dead code
            };
        }

        public function getElementFlatDamageBonus(_arg_1:int):int
        {
            switch (_arg_1)
            {
                default:
                    return (0);
                case 0:
                    return (getCharacteristicValue("neutralDamageBonus"));
                case 1:
                    return (getCharacteristicValue("earthDamageBonus"));
                case 2:
                    return (getCharacteristicValue("fireDamageBonus"));
                case 3:
                    return (getCharacteristicValue("waterDamageBonus"));
                case 4:
                    return (getCharacteristicValue("airDamageBonus"));
                case 6:
                    return (getElementFlatDamageBonus(getBestElement()));
                    return; //dead code
            };
        }

        public function getEffectsDeltaFromSave():List
        {
            var _local_1:* = (null as EffectOutput);
            var _local_2:* = (null as ListNode);
            var _local_3:* = (null as EffectOutput);
            if (((_save != (null)) && (!(_save.outputs == null))))
            {
                if (_save.outputs.isEmpty())
                {
                    return (pendingEffects);
                };
                _local_1 = null;
                _local_2 = _save.outputs.h;
                while (_local_2 != null)
                {
                    _local_3 = _local_2.item;
                    _local_2 = _local_2.next;
                    _local_1 = _local_3;
                };
                return (FpUtils.listAfter_damageCalculation_damageManagement_EffectOutput(pendingEffects, _local_1));
            };
            return (null);
        }

        public function getDynamicalDamageReflect():DamageRange
        {
            var _local_3:* = (null as LinkedListNode);
            var _local_4:* = (null as LinkedListNode);
            var _local_5:* = (null as HaxeBuff);
            var _local_6:* = (null as Interval);
            var _local_1:DamageRange = new DamageRange(0, 0);
            var _local_2:LinkedListNode = _buffs.head;
            while (_local_2 != null)
            {
                _local_3 = _local_2;
                _local_2 = _local_2.next;
                _local_4 = _local_3;
                _local_5 = _local_4.item;
                if (_local_5.effect.actionId == 220)
                {
                    _local_1.addInterval(_local_5.effect.getDamageInterval());
                }
                else
                {
                    if (_local_5.effect.actionId == 107)
                    {
                        _local_6 = _local_5.effect.getDamageInterval().multiply((int((level / 20)) + 1));
                        _local_1.addInterval(_local_6);
                    };
                };
            };
            return (_local_1);
        }

        public function getDamageReductor(_arg_1:RunningEffect, _arg_2:DamageRange, _arg_3:Boolean):Interval
        {
            var _local_5:* = (null as LinkedListNode);
            var _local_6:* = (null as LinkedListNode);
            var _local_7:* = (null as LinkedListNode);
            var _local_8:* = (null as HaxeBuff);
            var _local_4:Interval = new Interval(0, 0);
            if (ActionIdHelper.canTriggerDamageMultiplier(_arg_1.getSpellEffect().actionId))
            {
                _local_5 = _buffs.head;
                while (_local_5 != null)
                {
                    _local_6 = _local_5;
                    _local_5 = _local_5.next;
                    _local_7 = _local_6;
                    _local_8 = _local_7.item;
                    if (((_local_8.effect.actionId == (265)) && ((SpellManager.isInstantaneousSpellEffect(_local_8.effect)) || (_local_8.shouldBeTriggeredOnTargetDamage(_arg_1, this, _arg_3, _arg_2.isCollision)))))
                    {
                        _local_4.addInterval(_local_8.effect.getDamageInterval().multiply(((level / 20) + 1)));
                    };
                };
            };
            return (_local_4);
        }

        public function getDamageMultiplicator(_arg_1:RunningEffect, _arg_2:Boolean, _arg_3:Boolean):int
        {
            var _local_5:* = (null as LinkedListNode);
            var _local_6:* = (null as LinkedListNode);
            var _local_7:* = (null as LinkedListNode);
            var _local_8:* = (null as HaxeBuff);
            var _local_4:int = 100;
            if (ActionIdHelper.canTriggerDamageMultiplier(_arg_1.getSpellEffect().actionId))
            {
                _local_5 = _buffs.head;
                while (_local_5 != null)
                {
                    _local_6 = _local_5;
                    _local_5 = _local_5.next;
                    _local_7 = _local_6;
                    _local_8 = _local_7.item;
                    if (((_local_8.effect.actionId == (1163)) && ((SpellManager.isInstantaneousSpellEffect(_local_8.effect)) || (_local_8.shouldBeTriggeredOnTargetDamage(_arg_1, this, _arg_2, _arg_3)))))
                    {
                        _local_4 = ((_local_4 * _local_8.effect.param1) * 0.01);
                    };
                };
            };
            return (_local_4);
        }

        public function getDamageEffects():List
        {
            return (totalEffects.filter(function (_arg_1:EffectOutput):Boolean
            {
                return (!(_arg_1.damageRange == null));
            }).map(function (_arg_1:EffectOutput):DamageRange
            {
                return (_arg_1.damageRange);
            }));
        }

        public function getCurrentReceivedDamageMultiplierMelee(_arg_1:Boolean):int
        {
            var _local_2:String = ((_arg_1) ? "meleeDamageReceivedPercent" : "rangedDamageReceivedPercent");
            var _local_3:Number = getCharacteristicValue(_local_2);
            return (Math.max(0, _local_3));
        }

        public function getCurrentReceivedDamageMultiplierCategory(_arg_1:Boolean):int
        {
            var _local_2:String = ((_arg_1) ? "weaponDamageReceivedPercent" : "spellDamageReceivedPercent");
            var _local_3:Number = getCharacteristicValue(_local_2);
            return (Math.max(0, _local_3));
        }

        public function getCurrentPositionCell():int
        {
            if (MapTools.isValidCellId(_currentPosition))
            {
                return (_currentPosition);
            };
            return (data.getStartedPositionCell());
        }

        public function getCurrentDealtDamageMultiplierMelee(_arg_1:Boolean):int
        {
            var _local_2:String = ((_arg_1) ? "meleeDamageDonePercent" : "rangedDamageDonePercent");
            var _local_3:Number = (100 + getCharacteristicValue(_local_2));
            return (Math.max(0, _local_3));
        }

        public function getCurrentDealtDamageMultiplierCategory(_arg_1:Boolean):int
        {
            var _local_2:String = ((_arg_1) ? "weaponDamageDonePercent" : "spellDamageDonePercent");
            var _local_3:Number = (100 + getCharacteristicValue(_local_2));
            return (Math.max(0, _local_3));
        }

        public function getCharacteristicValue(_arg_1:String):int
        {
            var _local_2:int = data.getBaseCharacteristicValue(_arg_1);
            var _local_3:Boolean = ActionIdHelper.isLinearBuffActionIds(_arg_1);
            var _local_4:int = getBuffStatBoost(_arg_1);
            var _local_5:int = getBuffStatBoostPercent(_arg_1);
            if (_local_3)
            {
                _local_2 = (_local_2 + _local_4);
            }
            else
            {
                if (_local_2 == 0)
                {
                    _local_2 = _local_4;
                }
                else
                {
                    _local_2 = Math.floor((_local_2 * (1 + (_local_4 * 0.01))));
                };
            };
            if (_local_2 != 0)
            {
                _local_2 = Math.floor((_local_2 * (1 + (_local_5 * 0.01))));
            };
            return (_local_2);
        }

        public function getCarrier(_arg_1:FightContext):HaxeFighter
        {
            var _local_6:* = (null as HaxeFighter);
            var _local_2:HaxeFighter;
            var _local_3:int = getCurrentPositionCell();
            var _local_4:int;
            var _local_5:Array = _arg_1.fighters;
            while (_local_4 < _local_5.length)
            {
                _local_6 = _local_5[_local_4];
                _local_4++;
                if (((_local_6.getCurrentPositionCell() == (_local_3)) && (_local_6.getCarried(_arg_1) == this)))
                {
                    return (_local_6);
                };
            };
            return (null);
        }

        public function getCarried(_arg_1:FightContext):HaxeFighter
        {
            var _local_2:* = (null as HaxeFighter);
            if (_carriedFighter == null)
            {
                _local_2 = _arg_1.getCarriedFighterBy(this);
                if (((_local_2 != (null)) && (_local_2.hasState(8))))
                {
                    _carriedFighter = _local_2;
                };
            };
            return (_carriedFighter);
        }

        public function getBuffs():LinkedList
        {
            return (_buffs);
        }

        public function getBuffStatBoostPercent(_arg_1:String):int
        {
            var _local_6:* = (null as LinkedListNode);
            var _local_7:* = (null as LinkedListNode);
            var _local_8:* = (null as HaxeBuff);
            var _local_2:int = ActionIdHelper.StatToBuffPercentActionIds(_arg_1);
            var _local_3:int = ActionIdHelper.StatToDebuffPercentActionIds(_arg_1);
            if (((_local_2 == (-1)) && (_local_3 == -1)))
            {
                return (0);
            };
            var _local_4:int = 100;
            var _local_5:LinkedListNode = _buffs.head;
            while (_local_5 != null)
            {
                _local_6 = _local_5;
                _local_5 = _local_5.next;
                _local_7 = _local_6;
                _local_8 = _local_7.item;
                if (SpellManager.isInstantaneousSpellEffect(_local_8.effect))
                {
                    if (_local_8.effect.actionId == _local_2)
                    {
                        _local_4 = Math.floor((_local_4 * (1 + (_local_8.effect.getMinRoll() * 0.01))));
                    }
                    else
                    {
                        if (_local_8.effect.actionId == _local_3)
                        {
                            _local_4 = Math.floor((_local_4 * (1 - (_local_8.effect.getMinRoll() * 0.01))));
                        };
                    };
                };
            };
            return (_local_4 - 100);
        }

        public function getBuffStatBoost(_arg_1:String):int
        {
            var _local_6:* = (null as LinkedListNode);
            var _local_7:* = (null as LinkedListNode);
            var _local_8:* = (null as LinkedListNode);
            var _local_9:* = (null as HaxeBuff);
            var _local_2:int = ActionIdHelper.StatToBuffActionIds(_arg_1);
            var _local_3:int = ActionIdHelper.StatToDebuffActionIds(_arg_1);
            var _local_4:Boolean = ActionIdHelper.isLinearBuffActionIds(_arg_1);
            var _local_5:int;
            if (_local_4)
            {
                _local_6 = _buffs.head;
                while (_local_6 != null)
                {
                    _local_7 = _local_6;
                    _local_6 = _local_6.next;
                    _local_8 = _local_7;
                    _local_9 = _local_8.item;
                    if (SpellManager.isInstantaneousSpellEffect(_local_9.effect))
                    {
                        if (_local_9.effect.actionId == _local_2)
                        {
                            _local_5 = (_local_5 + _local_9.effect.getMinRoll());
                        }
                        else
                        {
                            if (_local_9.effect.actionId == _local_3)
                            {
                                _local_5 = (_local_5 - _local_9.effect.getMinRoll());
                            };
                        };
                    };
                };
            }
            else
            {
                _local_5 = 100;
                _local_6 = _buffs.head;
                while (_local_6 != null)
                {
                    _local_7 = _local_6;
                    _local_6 = _local_6.next;
                    _local_8 = _local_7;
                    _local_9 = _local_8.item;
                    if (SpellManager.isInstantaneousSpellEffect(_local_9.effect))
                    {
                        if (_local_9.effect.actionId == _local_2)
                        {
                            _local_5 = Math.floor((_local_5 * (1 + (_local_9.effect.getMinRoll() * 0.01))));
                        }
                        else
                        {
                            if (_local_9.effect.actionId == _local_3)
                            {
                                _local_5 = Math.floor((_local_5 * (1 - (_local_9.effect.getMinRoll() * 0.01))));
                            };
                        };
                    };
                };
                _local_5 = (_local_5 - 100);
            };
            return (_local_5);
        }

        public function getBestElement():int
        {
            var _local_4:int;
            var _local_1:int = 1;
            var _local_2:Array = [0, 2, 3, 4];
            var _local_3:int;
            while (_local_3 < _local_2.length)
            {
                _local_4 = _local_2[_local_3];
                _local_3++;
                if (((getElementMainStat(_local_4) > (getElementMainStat(_local_1))) || ((getElementMainStat(_local_4) == (getElementMainStat(_local_1))) && (getElementFlatDamageBonus(_local_4) > getElementFlatDamageBonus(_local_1)))))
                {
                    _local_1 = _local_4;
                };
            };
            return (_local_1);
        }

        public function getBeforeLastSpellPosition():int
        {
            if (beforeLastSpellPosition == -1)
            {
                return (data.getStartedPositionCell());
            };
            return (beforeLastSpellPosition);
        }

        public function getAllSacrificed():Array
        {
            var _local_3:* = (null as LinkedListNode);
            var _local_4:* = (null as LinkedListNode);
            var _local_5:* = (null as HaxeBuff);
            var _local_1:Array = [];
            var _local_2:LinkedListNode = _buffs.head;
            while (_local_2 != null)
            {
                _local_3 = _local_2;
                _local_2 = _local_2.next;
                _local_4 = _local_3;
                _local_5 = _local_4.item;
                if (_local_5.effect.actionId == 765)
                {
                    _local_1.push(_local_5.casterId);
                };
            };
            return (_local_1);
        }

        public function flushPendingBuffs():void
        {
            if (_pendingBuffHead != null)
            {
                if (_pendingBuffHead.previous != null)
                {
                    _pendingBuffHead.previous.next = null;
                    if (_pendingBuffHead == _buffs.tail)
                    {
                        _buffs.tail = _pendingBuffHead.previous;
                    };
                }
                else
                {
                    if (_pendingBuffHead == _buffs.head)
                    {
                        _buffs.clear();
                    };
                };
                _pendingBuffHead = null;
            };
            if (_pendingDispelledBuffs.head != null)
            {
                _buffs = _pendingDispelledBuffs.append(_buffs);
                _pendingDispelledBuffs = new LinkedList();
            };
        }

        public function copy(_arg_1:FightContext):HaxeFighter
        {
            var _local_10:* = (null as LinkedListNode);
            var _local_11:* = (null as LinkedListNode);
            var _local_2:Number = _arg_1.getFreeId();
            var _local_3:int = level;
            var _local_4:int = breed;
            var _local_5:PlayerTypeEnum = playerType;
            var _local_6:uint = teamId;
            var _local_7:Boolean = isStaticElement;
            var _local_8:Array = [];
            var _local_9:LinkedListNode = _buffs.head;
            while (_local_9 != null)
            {
                _local_10 = _local_9;
                _local_9 = _local_9.next;
                _local_11 = _local_10;
                _local_8.push(_local_11.item);
            };
            return (new HaxeFighter(_local_2, _local_3, _local_4, _local_5, _local_6, _local_7, _local_8, data));
        }

        public function computeSeparatedPendingDamages():List
        {
            return (FpUtils.listConcat_damageCalculation_damageManagement_DamageRange(pendingEffects.map(function (_arg_1:EffectOutput):DamageRange
            {
                return (_arg_1.computeLifeDamage());
            }), pendingEffects.map(function (_arg_1:EffectOutput):DamageRange
            {
                return (_arg_1.computeShieldDamage());
            })));
        }

        public function carryFighter(_arg_1:HaxeFighter):void
        {
            _carriedFighter = _arg_1;
        }

        public function canUsePortals():Boolean
        {
            if (data.canBreedUsePortals())
            {
                return (!(hasStateEffect(17)));
            };
            return (false);
        }

        public function canTeleport(_arg_1:int=-1):Boolean
        {
            if ((((hasStateEffect(3)) && (!((hasStateEffect(18)) && ((((((_arg_1 == (1104)) || (_arg_1 == 1105)) || (_arg_1 == 1106)) || (_arg_1 == 784)) || (_arg_1 == 1099)) || (_arg_1 == 1100))))) && (!(hasState(3)))))
            {
                if (!data.canBreedSwitchPos())
                {
                    return (ActionIdHelper.canTeleportOverBreedSwitchPos(_arg_1));
                };
                return (true);
            };
            return (false);
        }

        public function canSwitchPosition(_arg_1:int=-1):Boolean
        {
            if (((((hasStateEffect(3)) && (!((hasStateEffect(18)) && ((((((_arg_1 == (1104)) || (_arg_1 == 1105)) || (_arg_1 == 1106)) || (_arg_1 == 784)) || (_arg_1 == 1099)) || (_arg_1 == 1100))))) && (!(hasState(3)))) && ((data.canBreedSwitchPos()) || (ActionIdHelper.canTeleportOverBreedSwitchPos(_arg_1)))))
            {
                return (!(hasState(8)));
            };
            return (false);
        }

        public function canBePushed():Boolean
        {
            if (((hasStateEffect(3)) && (data.canBreedBePushed())))
            {
                return (!(hasStateEffect(0)));
            };
            return (false);
        }

        public function canBeMoved():Boolean
        {
            return (!(hasStateEffect(3)));
        }

        public function canBeCarried():Boolean
        {
            if (((hasStateEffect(3)) && (data.canBreedBeCarried())))
            {
                return (!(hasStateEffect(4)));
            };
            return (false);
        }

        public function addTotalEffects(_arg_1:List):void
        {
            if (totalEffects != null)
            {
                totalEffects = FpUtils.listConcat_damageCalculation_damageManagement_EffectOutput(totalEffects, _arg_1);
            }
            else
            {
                totalEffects = _arg_1;
            };
        }

        public function addPendingEffects(_arg_1:EffectOutput):void
        {
            pendingEffects.add(_arg_1);
        }

        public function addPendingBuffs(_arg_1:LinkedList):void
        {
            if (_pendingBuffHead == null)
            {
                _pendingBuffHead = _arg_1.head;
            };
            _buffs = _buffs.append(_arg_1);
        }

        public function addPendingBuff(_arg_1:HaxeBuff):void
        {
            if (_pendingBuffHead == null)
            {
                _pendingBuffHead = _buffs.add(_arg_1);
            }
            else
            {
                _buffs.add(_arg_1);
            };
        }


    }
} damageCalculation.fighterManagement

