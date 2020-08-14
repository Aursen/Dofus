package damageCalculation.debug
{
    import haxe.Log;
    import damageCalculation.fighterManagement.HaxeFighter;
    import damageCalculation.spellManagement.HaxeSpellEffect;
    import damageCalculation.spellManagement.HaxeSpell;
    import damageCalculation.tools.LinkedListNode;
    import damageCalculation.spellManagement.Mark;
    import damageCalculation.FightContext;
    import damageCalculation.fighterManagement.PlayerTypeEnum;
    import damageCalculation.fighterManagement.HaxeBuff;

    public class Debug 
    {

        public static var INDENTATION:String = "    ";
        public static var NBR_INDENTATION:int = 1;
        public static var additionalSpellLog:String = "";
        public static var additionalSpellUsed:Array = [];
        public static var chars:Array = ["maxLifePoints", "lifePoints", "actionPoints", "maxMouvementPoints", "movementPoints", "strength", "vitality", "chance", "agility", "intelligence", "wisdom", "reflect", "maxSummonableCreatures", "dodgePALostProbability", "dodgePMLostProbability", "earthElementResistPercent", "fireElementResistPercent", "waterElementResistPercent", "airElementResistPercent", "neutralElementResistPercent", "earthElementReduction", "fireElementReduction", "waterElementReduction", "airElementReduction", "neutralElementReduction", "pvpEarthElementPercentResist", "pvpFireElementResistPercent", "pvpWaterElementPercentResist", "pvpAirElementPercentResist", "pvpNeutralElementPercentResist", "pvpEarthElementReduction", "pvpFireElementReduction", "pvpWaterElementReduction", "pvpAirElementReduction", "pvpNeutralElementReduction", "trapBonusPercent", "trapBonus", "glyphPower", "runePower", "PAAttack", "PMAttack", "pushDamageBonus", "pushDamageFixedResist", "healBonus", "criticalHit", "invisibilityState", "energyPoints", "weaponDamagesBonusPercent", "damagesBonusPercent", "criticalMiss", "criticalDamageBonus", "criticalDamageReduction", "allDamagesBonus", "earthDamageBonus", "fireDamageBonus", "waterDamageBonus", "airDamageBonus", "neutralDamageBonus", "maxBomb", "bombCombo", "shieldPoints", "curPermanentDamages", "weaponPower", "spellPercentDamages", "meleeDamageDonePercent", "meleeDamageReceivedPercent", "rangedDamageDonePercent", "rangedDamageReceivedPercent", "spellDamageDonePercent", "spellDamageReceivedPercent", "permanentDamagePercent", "percentResist", "incomingPercentDamageMultiplicator", "incomingPercentHealMultiplicator", "dealtDamagesMultiplicator", "weaponDamageDonePercent", "weaponDamageReceivedPercent", "unlucky", "maximizeRoll", "confusion"];

        public function Debug():void
        {
        }

        public static function traceCasterChars(_arg_1:HaxeFighter):void
        {
            var _local_4:* = (null as String);
            Log.trace("[", {
                "fileName":"src/main/haxe/damageCalculation/debug/Debug.hx",
                "lineNumber":18,
                "className":"damageCalculation.debug.Debug",
                "methodName":"traceCasterChars"
            });
            var _local_2:int;
            var _local_3:Array = Debug.chars;
            while (_local_2 < _local_3.length)
            {
                _local_4 = _local_3[_local_2];
                _local_2++;
                if (_arg_1.getCharacteristicValue(_local_4) != 0)
                {
                    Log.trace(((((("    " + '"') + _local_4) + '" => ') + _arg_1.getCharacteristicValue(_local_4)) + ","), {
                        "fileName":"src/main/haxe/damageCalculation/debug/Debug.hx",
                        "lineNumber":21,
                        "className":"damageCalculation.debug.Debug",
                        "methodName":"traceCasterChars"
                    });
                };
            };
            Log.trace("]", {
                "fileName":"src/main/haxe/damageCalculation/debug/Debug.hx",
                "lineNumber":24,
                "className":"damageCalculation.debug.Debug",
                "methodName":"traceCasterChars"
            });
        }

        public static function traceSpell(_arg_1:HaxeSpell):void
        {
            var _local_5:int;
            var _local_6:* = (null as HaxeSpellEffect);
            var _local_2:String = "";
            _local_2 = (_local_2 + "new MockSpell(\n");
            var _local_3:Array = _arg_1.getEffects();
            var _local_4:Array = _arg_1.getCriticalEffects();
            _local_2 = (_local_2 + ("    " + "    [\n"));
            if (((_local_3 != (null)) && (_local_3.length > 0)))
            {
                _local_5 = 0;
                while (_local_5 < _local_3.length)
                {
                    _local_6 = _local_3[_local_5];
                    _local_5++;
                    _local_2 = (_local_2 + Debug.printEffects(_local_6));
                };
            };
            _local_2 = (_local_2 + ("    " + "    ],\n"));
            _local_2 = (_local_2 + ("    " + "    [\n"));
            if (((_local_4 != (null)) && (_local_4.length > 0)))
            {
                _local_5 = 0;
                while (_local_5 < _local_4.length)
                {
                    _local_6 = _local_4[_local_5];
                    _local_5++;
                    _local_2 = (_local_2 + Debug.printEffects(_local_6));
                };
            };
            _local_2 = (_local_2 + ("    " + "    ],\n"));
            _local_2 = (_local_2 + ((("    " + "    ") + _arg_1.id) + "\n    );"));
            Log.trace(_local_2, {
                "fileName":"src/main/haxe/damageCalculation/debug/Debug.hx",
                "lineNumber":48,
                "className":"damageCalculation.debug.Debug",
                "methodName":"traceSpell"
            });
        }

        public static function traceTestEnvironment(_arg_1:FightContext, _arg_2:HaxeSpell, _arg_3:Boolean=false, _arg_4:Boolean=false):String
        {
            var _local_9:int;
            var _local_11:* = (null as HaxeFighter);
            var _local_12:* = (null as String);
            var _local_13:* = (null as LinkedListNode);
            var _local_14:* = (null as LinkedListNode);
            var _local_15:* = (null as LinkedListNode);
            var _local_16:* = (null as Mark);
            var _local_5:String = "===================== TEST =====================";
            _local_5 = (_local_5 + "\n \n");
            _local_5 = (_local_5 + "public function testAutoTraced()\n");
            _local_5 = Debug.indent(_local_5);
            _local_5 = (_local_5 + "{\n");
            Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION + 1);
            var _local_6:int;
            var _local_7:int;
            var _local_8:Boolean = true;
            _local_9 = 0;
            var _local_10:Array = _arg_1.getEveryFighter();
            while (_local_9 < _local_10.length)
            {
                _local_11 = _local_10[_local_9];
                _local_9++;
                if (_local_11.id == _arg_1.originalCaster.id)
                {
                    _local_12 = "caster";
                    _local_8 = false;
                }
                else
                {
                    _local_8 = true;
                    if (_local_11.teamId != _arg_1.originalCaster.teamId)
                    {
                        _local_12 = ("target" + ++_local_7);
                    }
                    else
                    {
                        _local_12 = ("ally" + ++_local_6);
                    };
                };
                _local_5 = Debug.indent(_local_5);
                if (_local_8)
                {
                    _local_5 = (_local_5 + "var ");
                };
                _local_5 = (_local_5 + (_local_12 + " = new MockFighter("));
                Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION + 1);
                if (_arg_3)
                {
                    _local_5 = (_local_5 + (Debug.indent("\n") + Debug.printBaseCasterChars(_local_11)));
                    _local_5 = (_local_5 + ",");
                    _local_5 = (_local_5 + Debug.indent("\n"));
                };
                _local_5 = (_local_5 + Debug.printInfos(_local_11, _arg_4));
                _local_5 = (_local_5 + ");\n");
                Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION - 1);
                if (_local_11._buffs.head != null)
                {
                    _local_5 = Debug.indent(_local_5);
                    _local_5 = (_local_5 + (_local_12 + ".addBuffs([\n"));
                    Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION + 1);
                    _local_13 = _local_11._buffs.head;
                    while (_local_13 != null)
                    {
                        _local_14 = _local_13;
                        _local_13 = _local_13.next;
                        _local_15 = _local_14;
                        _local_5 = (_local_5 + Debug.printBuff(_local_15.item));
                        _local_5 = (_local_5 + ",\n");
                    };
                    _local_5 = Debug.indent(_local_5);
                    Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION - 1);
                    _local_5 = (_local_5 + "]); \n");
                };
                _local_5 = Debug.indent(_local_5);
                _local_5 = (_local_5 + (((_local_12 + ".setStartedPositionCell(") + _local_11.data.getStartedPositionCell()) + "); \n"));
                _local_5 = Debug.indent(_local_5);
                _local_5 = (_local_5 + ((("map.addFighter(" + _local_12) + ");\n") + "\n"));
            };
            _local_10 = _arg_1.map.getMarks();
            if (((_local_10 != (null)) && (_local_10.length > 0)))
            {
                _local_9 = 0;
                while (_local_9 < _local_10.length)
                {
                    _local_16 = _local_10[_local_9];
                    _local_9++;
                    _local_5 = (_local_5 + Debug.printMark(_local_16));
                };
            };
            _local_5 = Debug.indent(_local_5);
            _local_5 = (_local_5 + "spell = ");
            _local_5 = (_local_5 + Debug.printSpell(_arg_2));
            _local_5 = (_local_5 + ";\n");
            _local_5 = Debug.indent(_local_5);
            _local_5 = (_local_5 + ((("targetedCell = " + _arg_1.targetedCell) + ";\n") + "\n"));
            _local_5 = Debug.indent(_local_5);
            _local_5 = (_local_5 + "var base = spell.getBaseDamages();\n");
            _local_5 = Debug.indent(_local_5);
            _local_5 = (_local_5 + ("var crit = spell.getCriticalBaseDamages();\n" + "\n"));
            _local_5 = Debug.indent(_local_5);
            _local_5 = (_local_5 + (("createExpectedSimpleDamage(target" + _local_7) + ", base.toArray(), crit.toArray(),false,false,0,null);\n"));
            _local_5 = Debug.indent(_local_5);
            _local_5 = (_local_5 + "run();\n");
            Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION - 1);
            _local_5 = Debug.indent(_local_5);
            return (_local_5 + "}");
        }

        public static function printInfos(_arg_1:HaxeFighter, _arg_2:Boolean=false):String
        {
            var _local_3:String = "[";
            _local_3 = (_local_3 + ('"TeamId" => ' + Std.string((_arg_1.teamId == 1))));
            if (_arg_2)
            {
                _local_3 = (_local_3 + ",");
                _local_3 = (_local_3 + (('"Human" => ' + Std.string((_arg_1.playerType == PlayerTypeEnum.HUMAN))) + ", "));
                _local_3 = (_local_3 + (('"Carried" => ' + Std.string(_arg_1.hasState(8))) + ", "));
                _local_3 = (_local_3 + (('"Sidekick" => ' + Std.string((_arg_1.playerType == PlayerTypeEnum.SIDEKICK))) + ", "));
                _local_3 = (_local_3 + (('"isSummoned" => ' + Std.string(_arg_1.data.isSummon())) + ", "));
                _local_3 = (_local_3 + (('"isStatic" => ' + ("" + _arg_1.isStaticElement)) + ", "));
                _local_3 = (_local_3 + (('"breedSwitchPos" => ' + Std.string(_arg_1.data.canBreedSwitchPos())) + ", "));
                _local_3 = (_local_3 + (('"breedUsePortals" => ' + Std.string(_arg_1.data.canBreedUsePortals())) + ", "));
                _local_3 = (_local_3 + (('"breedBePushed" => ' + Std.string(_arg_1.data.canBreedBePushed())) + ", "));
                _local_3 = (_local_3 + ('"breedBeCarried" => ' + Std.string(_arg_1.data.canBreedBeCarried())));
            };
            return (_local_3 + "]");
        }

        public static function printBaseCasterChars(_arg_1:HaxeFighter):String
        {
            var _local_5:* = (null as String);
            var _local_2:String = "[";
            var _local_3:int;
            var _local_4:Array = Debug.chars;
            while (_local_3 < _local_4.length)
            {
                _local_5 = _local_4[_local_3];
                _local_3++;
                if (_arg_1.data.getBaseCharacteristicValue(_local_5) != 0)
                {
                    _local_2 = (_local_2 + (((('"' + _local_5) + '" => ') + _arg_1.data.getBaseCharacteristicValue(_local_5)) + ", "));
                };
            };
            return (_local_2 + "]");
        }

        public static function printBuff(_arg_1:HaxeBuff):String
        {
            var _local_2:String = "";
            _local_2 = Debug.indent(_local_2);
            _local_2 = (_local_2 + (("new MockBuff(" + _arg_1.casterId) + ",\n"));
            Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION + 1);
            _local_2 = Debug.indent(_local_2);
            _local_2 = (_local_2 + (("new MockSpell(null,null," + _arg_1.spell.id) + "),\n"));
            _local_2 = Debug.indent(_local_2);
            _local_2 = (_local_2 + Debug.printEffects(_arg_1.effect));
            _local_2 = (_local_2 + ")");
            Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION - 1);
            return (_local_2);
        }

        public static function printEffects(_arg_1:HaxeSpellEffect):String
        {
            return ((((((((((((((((((((((((((((((((((((("MockSpellEffect.fromAGT(" + ("" + _arg_1.id)) + ", ") + _arg_1.level) + ", ") + _arg_1.order) + ", ") + _arg_1.actionId) + ", ") + _arg_1.param1) + ", ") + _arg_1.param2) + ", ") + _arg_1.param3) + ", ") + _arg_1.duration) + ", ") + ("" + _arg_1.isCritical)) + ", ") + '"') + _arg_1.triggers.join("|")) + '", ') + '"') + _arg_1.rawZone) + '", ') + '"') + _arg_1.masks.join(",")) + '", ') + _arg_1.randomWeight) + ", ") + _arg_1.randomGroup) + ", ") + ("" + _arg_1.isDispellable)) + ", ") + _arg_1.delay) + ", ") + _arg_1.category) + ") ");
        }

        public static function printSpell(_arg_1:HaxeSpell):String
        {
            var _local_5:int;
            var _local_6:* = (null as HaxeSpellEffect);
            var _local_2:String = "";
            _local_2 = Debug.indent(_local_2);
            _local_2 = (_local_2 + "new MockSpell(\n");
            var _local_3:Array = _arg_1.getEffects();
            var _local_4:Array = _arg_1.getCriticalEffects();
            Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION + 1);
            _local_2 = Debug.indent(_local_2);
            _local_2 = (_local_2 + "[\n");
            Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION + 1);
            if (((_local_3 != (null)) && (_local_3.length > 0)))
            {
                _local_5 = 0;
                while (_local_5 < _local_3.length)
                {
                    _local_6 = _local_3[_local_5];
                    _local_5++;
                    _local_2 = Debug.indent(_local_2);
                    _local_2 = (_local_2 + (Debug.printEffects(_local_6) + ",\n"));
                };
                _local_2.substr(0, (_local_2.length - 2));
            };
            Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION - 1);
            _local_2 = Debug.indent(_local_2);
            _local_2 = (_local_2 + "],\n");
            _local_2 = Debug.indent(_local_2);
            _local_2 = (_local_2 + "[");
            if (((_local_4 != (null)) && (_local_4.length > 0)))
            {
                Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION + 1);
                _local_2 = (_local_2 + "\n");
                _local_5 = 0;
                while (_local_5 < _local_4.length)
                {
                    _local_6 = _local_4[_local_5];
                    _local_5++;
                    _local_2 = Debug.indent(_local_2);
                    _local_2 = (_local_2 + (Debug.printEffects(_local_6) + ",\n"));
                };
                _local_2.substr(0, (_local_2.length - 2));
                Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION - 1);
                _local_2 = Debug.indent(_local_2);
            };
            _local_2 = (_local_2 + "],\n");
            _local_2 = Debug.indent(_local_2);
            _local_2 = (_local_2 + (_arg_1.id + ")"));
            Debug.NBR_INDENTATION = (Debug.NBR_INDENTATION - 1);
            return (_local_2);
        }

        public static function printMark(_arg_1:Mark):String
        {
            var _local_2:String = "";
            _local_2 = (((Debug.indent(_local_2) + "var mark") + _arg_1.markId) + " = new Mark();\n");
            _local_2 = (((((Debug.indent(_local_2) + "mark") + _arg_1.markId) + ".markId = ") + _arg_1.markId) + ";\n");
            _local_2 = (((((Debug.indent(_local_2) + "mark") + _arg_1.markId) + ".setMarkType(") + _arg_1.markType) + ");\n");
            _local_2 = (((((Debug.indent(_local_2) + "mark") + _arg_1.markId) + ".mainCell = ") + _arg_1.mainCell) + ";\n");
            _local_2 = (((((Debug.indent(_local_2) + "mark") + _arg_1.markId) + ".cells = ") + Std.string(_arg_1.cells)) + ";\n");
            _local_2 = (((((Debug.indent(_local_2) + "mark") + _arg_1.markId) + ".casterId = ") + _arg_1.casterId) + ";\n");
            _local_2 = (((((Debug.indent(_local_2) + "mark") + _arg_1.markId) + ".teamId = ") + ("" + _arg_1.teamId)) + ";\n");
            _local_2 = (((((Debug.indent(_local_2) + "mark") + _arg_1.markId) + ".active = ") + ("" + _arg_1.active)) + ";\n");
            _local_2 = (((Debug.indent(_local_2) + "mark") + _arg_1.markId) + ".setAssociatedSpell(\n");
            _local_2 = (_local_2 + Debug.printSpell(_arg_1.associatedSpell));
            _local_2 = (_local_2 + ");\n");
            return (((Debug.indent(_local_2) + "map.addMark(mark") + _arg_1.markId) + ");\n \n");
        }

        public static function indent(_arg_1:String):String
        {
            var _local_4:int;
            var _local_2:int;
            var _local_3:int = Debug.NBR_INDENTATION;
            while (_local_2 < _local_3)
            {
                _local_4 = _local_2++;
                _arg_1 = (_arg_1 + "    ");
            };
            return (_arg_1);
        }

        public static function storeSpell(_arg_1:HaxeSpell):void
        {
            var _local_2:* = ((_arg_1.level << 24) | _arg_1.id);
            if (Debug.additionalSpellUsed.indexOf(_local_2) == -1)
            {
                Debug.additionalSpellUsed.push(_local_2);
                Debug.additionalSpellLog = (Debug.additionalSpellLog + Debug.printSpell(_arg_1));
                Debug.additionalSpellLog = (Debug.additionalSpellLog + "\n \n");
            };
        }

        public static function printStoredSpell():String
        {
            var _local_1:String = "\n \n===================== ADDITIONNAL SPELLS =====================";
            _local_1 = (_local_1 + "\n \n");
            _local_1 = (_local_1 + (Debug.additionalSpellLog + ""));
            Debug.additionalSpellLog = "";
            Debug.additionalSpellUsed = [];
            return (_local_1);
        }


    }
} damageCalculation.debug

