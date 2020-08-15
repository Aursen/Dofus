package com.ankamagames.dofus.logic.game.fight.frames.Preview
{
    import flash.utils.Dictionary;
    import flash.display.MovieClip;
    import damageCalculation.DamageCalculator;
    import damageCalculation.fighterManagement.HaxeFighter;
    import damageCalculation.spellManagement.HaxeSpell;
    import damageCalculation.IMapInfo;
    import mapTools.MapTools;
    import mapTools.MapToolsConfig;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.dofus.misc.utils.GameDebugManager;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import damageCalculation.debug.Debug;
    import damageCalculation.FightContext;
    import flash.filesystem.File;
    import com.ankamagames.jerakine.types.CustomSharedObject;
    import flash.filesystem.FileStream;
    import flash.filesystem.FileMode;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
    import tools.enumeration.GameActionMarkTypeEnum;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import damageCalculation.spellManagement.HaxeSpellEffect;
    import com.ankamagames.dofus.logic.game.fight.types.TriggeredBuff;
    import damageCalculation.fighterManagement.HaxeBuff;
    import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import __AS3__.vec.*;

    public class DamagePreview 
    {

        private static var _isInit:Boolean = false;
        private static var haxeSpellCache:Dictionary = new Dictionary();
        private static const FIST_SPELL_ID:int = 0;


        public static function init():void
        {
            if (!_isInit)
            {
                haxe.initSwc(new MovieClip());
                DamageCalculator.dataInterface = new DamageCalculationTranslator();
                DamageCalculator.logger = new HaxeLoggerTranslator();
                _isInit = true;
            };
        }

        public static function computePreview(context:FightContextFrame, rawSpell:Object, casterId:Number, targetedCell:int):Array
        {
            var caster:HaxeFighter;
            var spell:HaxeSpell;
            var map:IMapInfo;
            var gameTurn:int;
            var list:Array;
            if (rawSpell == null)
            {
                return ([]);
            };
            if (!MapTools.isInit)
            {
                MapTools.init(MapToolsConfig.DOFUS2_CONFIG);
            };
            var infos:GameFightFighterInformations = (context.entitiesFrame.getEntityInfos(casterId) as GameFightFighterInformations);
            caster = new FighterTranslator(infos, casterId);
            spell = createHaxeSpell(rawSpell);
            map = new MapTranslator(context);
            var critical:Boolean;
            var criticalHit:CharacterBaseCharacteristic = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(casterId).criticalHit;
            if (((FighterDataTranslator.totalPoint(criticalHit) + criticalHit.contextModif) + spell.criticalHitProbability) >= 100)
            {
                critical = true;
            };
            gameTurn = (1 + CurrentPlayedFighterManager.getInstance().getSpellCastManager().currentTurn);
            try
            {
                list = DamageCalculator.damageComputation(caster, spell, gameTurn, map, targetedCell, getInputPortal(), true, critical, GameDebugManager.getInstance().haxeGenerateTestFromNextSpellCast);
            }
            catch(e)
            {
                if (GameDebugManager.getInstance().haxeGenerateTestFromNextSpellCast)
                {
                    generateTest(gameTurn, map, targetedCell, caster, spell);
                };
                throw (e);
            };
            if (GameDebugManager.getInstance().haxeGenerateTestFromNextSpellCast)
            {
                generateTest(gameTurn, map, targetedCell, caster, spell);
            };
            SpellEffectTranslator.clearCache();
            return (list);
        }

        private static function generateTest(gameTurn:int, map:IMapInfo, targetedCell:int, caster:HaxeFighter, spell:HaxeSpell):void
        {
            var gameDebugManager:GameDebugManager = GameDebugManager.getInstance();
            var testText:String = Debug.traceTestEnvironment(new FightContext(gameTurn, map, targetedCell, caster), spell, gameDebugManager.haxeGenerateTestFromNextSpellCast_stats, gameDebugManager.haxeGenerateTestFromNextSpellCast_infos);
            gameDebugManager.haxeGenerateTestFromNextSpellCast = false;
            gameDebugManager.haxeGenerateTestFromNextSpellCast_infos = false;
            gameDebugManager.haxeGenerateTestFromNextSpellCast_stats = false;
            var currentDate:Date = new Date();
            var pattern:RegExp = /[ :]/g;
            var file:File = new File(((((CustomSharedObject.getCustomSharedObjectDirectory() + "/DDP_FightSituations/log_") + currentDate.toLocaleDateString().replace(pattern, "_")) + "_") + currentDate.toLocaleTimeString().replace(pattern, "_")));
            var stream:FileStream = new FileStream();
            stream.open(file, FileMode.APPEND);
            stream.writeUTFBytes(testText);
            stream.writeUTFBytes(Debug.printStoredSpell());
            stream.close();
        }

        private static function getInputPortal():int
        {
            var mapPoint:MapPoint;
            var inputPortalCell:int = MapTools.INVALID_CELL_ID;
            var PortalMapPoints:Vector.<MapPoint> = MarkedCellsManager.getInstance().getMarksMapPoint(GameActionMarkTypeEnum.PORTAL);
            for each (mapPoint in PortalMapPoints)
            {
                if (mapPoint.cellId == FightContextFrame.currentCell)
                {
                    inputPortalCell = FightContextFrame.currentCell;
                    break;
                };
            };
            return (inputPortalCell);
        }

        public static function createHaxeBuff(buff:BasicBuff):HaxeBuff
        {
            var casterId:Number = buff.castingSpell.casterId;
            var grade:int = ((buff.castingSpell.spellRank != null) ? buff.castingSpell.spellRank.grade : 1);
            var spellLevel:SpellLevel = Spell.getSpellById(buff.castingSpell.spell.id).getSpellLevel(grade);
            var newSpell:HaxeSpell = createHaxeSpell(spellLevel);
            var effect:HaxeSpellEffect = SpellEffectTranslator.fromBuff(buff, spellLevel.grade);
            var isCritical:* = (!(newSpell.getCriticalEffectById(effect.id) == null));
            effect.isCritical = isCritical;
            var triggerCount:int = ((buff is TriggeredBuff) ? (buff as TriggeredBuff).triggerCount : -1);
            return (new HaxeBuff(casterId, newSpell, effect, triggerCount));
        }

        public static function createHaxeSpell(spell:Object):HaxeSpell
        {
            var cacheKey:int;
            if ((spell is SpellWrapper))
            {
                spell = (spell as SpellWrapper).spellLevelInfos;
            };
            var spellLevel:int = ((spell is WeaponWrapper) ? 1 : spell.grade);
            var spellId:int = spell.spellId;
            var isFist:* = (spell.spellId == FIST_SPELL_ID);
            var isWeapon:Boolean = ((!(spell is SpellLevel)) || (isFist));
            if (((isWeapon) && (!(isFist))))
            {
                spell = PlayedCharacterManager.getInstance().currentWeapon;
                spellId = 0;
            };
            if (!isWeapon)
            {
                cacheKey = DamageCalculator.create32BitHashSpellLevel(spellId, spellLevel);
                if (haxeSpellCache[cacheKey] != null)
                {
                    return (haxeSpellCache[cacheKey]);
                };
            };
            var spellEffects:Vector.<EffectInstance> = (((isWeapon) && (!(isFist))) ? spell.effects : Vector.<EffectInstance>(spell.effects));
            var spellCriticalEffects:Vector.<EffectInstance> = (((isWeapon) && (!(isFist))) ? spellEffects : Vector.<EffectInstance>(spell.criticalEffect));
            var translatedEffects:Array = loadEffectArray(spell, spellEffects, isWeapon, false);
            var translatedCriticalEffects:Array = loadEffectArray(spell, spellCriticalEffects, isWeapon, true);
            var canAlwaysTriggerSpells:Boolean = ((isWeapon) || ((spell as SpellLevel).spell.canAlwaysTriggerSpells));
            if (((isWeapon) && (!(spell is SpellLevel))))
            {
                spell = PlayedCharacterManager.getInstance().currentWeapon;
            };
            var haxeSpell:HaxeSpell = new HaxeSpell(((isWeapon) ? 0 : spell.spellId), translatedEffects, translatedCriticalEffects, spellLevel, canAlwaysTriggerSpells, isWeapon, spell.minRange, spell.range, spell.criticalHitProbability, ((spell is SpellLevel) ? (spell as SpellLevel).needFreeCell : false), ((spell is SpellLevel) ? (spell as SpellLevel).needTakenCell : false), ((spell is SpellLevel) ? (spell as SpellLevel).maxStack : -1));
            return (haxeSpell);
        }

        private static function loadEffectArray(spell:Object, sourceEffects:Vector.<EffectInstance>, isWeapon:Boolean, isCritical:Boolean):Array
        {
            var effect:EffectInstance;
            var targetEffects:Array = [];
            for each (effect in sourceEffects)
            {
                if (((!(effect.forClientOnly)) && (effect.delay == 0)))
                {
                    if (isWeapon)
                    {
                        targetEffects.push(SpellEffectTranslator.fromWeapon(effect, PlayedCharacterManager.getInstance().currentWeapon, isCritical));
                    }
                    else
                    {
                        if ((spell is SpellLevel))
                        {
                            targetEffects.push(SpellEffectTranslator.fromSpell(effect, (spell as SpellLevel).grade, isCritical));
                        };
                    };
                };
            };
            return (targetEffects);
        }


    }
}

