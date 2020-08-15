package com.ankamagames.dofus.datacenter.spells
{
    import com.ankamagames.jerakine.utils.display.spellZone.ICellZoneProvider;
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.types.IdAccessors;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
    import com.ankamagames.jerakine.utils.display.spellZone.IZoneShape;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.utils.display.spellZone.ZoneEffect;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankama.dofus.enums.ActionIds;
    import __AS3__.vec.*;

    public class SpellLevel implements ICellZoneProvider, IDataCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellLevel));
        public static const MODULE:String = "SpellLevels";
        public static var idAccessors:IdAccessors = new IdAccessors(getLevelById, null);

        public var id:uint;
        public var spellId:uint;
        public var grade:uint;
        public var spellBreed:uint;
        public var apCost:uint;
        public var minRange:uint;
        public var range:uint;
        public var castInLine:Boolean;
        public var castInDiagonal:Boolean;
        public var castTestLos:Boolean;
        public var criticalHitProbability:uint;
        public var needFreeCell:Boolean;
        public var needTakenCell:Boolean;
        public var needFreeTrapCell:Boolean;
        public var rangeCanBeBoosted:Boolean;
        public var maxStack:int;
        public var maxCastPerTurn:uint;
        public var maxCastPerTarget:uint;
        public var minCastInterval:uint;
        public var initialCooldown:uint;
        public var globalCooldown:int;
        public var minPlayerLevel:uint;
        public var hideEffects:Boolean;
        public var hidden:Boolean;
        public var playAnimation:Boolean;
        public var statesRequired:Vector.<int>;
        public var statesAuthorized:Vector.<int>;
        public var statesForbidden:Vector.<int>;
        public var effects:Vector.<EffectInstanceDice>;
        public var criticalEffect:Vector.<EffectInstanceDice>;
        public var additionalEffectsZones:Vector.<String>;
        private var _spell:Spell;
        private var _spellZoneEffects:Vector.<IZoneShape>;


        public static function getLevelById(id:int):SpellLevel
        {
            return (GameData.getObject(MODULE, id) as SpellLevel);
        }


        public function get spell():Spell
        {
            if (!this._spell)
            {
                this._spell = Spell.getSpellById(this.spellId);
            };
            return (this._spell);
        }

        public function get minimalRange():uint
        {
            return (this.minRange);
        }

        public function set minimalRange(pMinRange:uint):void
        {
            this.minRange = pMinRange;
        }

        public function get maximalRange():uint
        {
            return (this.range);
        }

        public function set maximalRange(pRange:uint):void
        {
            this.range = pRange;
        }

        public function get castZoneInLine():Boolean
        {
            return (this.castInLine);
        }

        public function set castZoneInLine(pCastInLine:Boolean):void
        {
            this.castInLine = pCastInLine;
        }

        public function get castZoneInDiagonal():Boolean
        {
            return (this.castInDiagonal);
        }

        public function set castZoneInDiagonal(pCastInDiagonal:Boolean):void
        {
            this.castInDiagonal = pCastInDiagonal;
        }

        public function get spellZoneEffects():Vector.<IZoneShape>
        {
            var numEffects:uint;
            var i:int;
            var zone:ZoneEffect;
            if (!this._spellZoneEffects)
            {
                this._spellZoneEffects = new Vector.<IZoneShape>();
                numEffects = this.effects.length;
                i = 0;
                while (i < numEffects)
                {
                    zone = new ZoneEffect(uint(this.effects[i].zoneSize), this.effects[i].zoneShape);
                    this._spellZoneEffects.push(zone);
                    i++;
                };
            };
            return (this._spellZoneEffects);
        }

        public function hasZoneShape(zoneShape:uint):Boolean
        {
            var i:int;
            while (i < this.spellZoneEffects.length)
            {
                if (this._spellZoneEffects[i].zoneShape == zoneShape)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function get canSummon():Boolean
        {
            var effect:EffectInstanceDice;
            var summonId:int;
            var monsterS:Monster;
            for each (effect in this.effects)
            {
                if (((effect.effectId == ActionIds.ACTION_CHARACTER_ADD_DOUBLE_USE_SUMMON_SLOT) || (effect.effectId == ActionIds.ACTION_SUMMON_SLAVE)))
                {
                    return (true);
                };
                if ((((effect.effectId == ActionIds.ACTION_SUMMON_CREATURE) || (effect.effectId == ActionIds.ACTION_FIGHT_KILL_AND_SUMMON)) || (effect.effectId == ActionIds.ACTION_FIGHT_KILL_AND_SUMMON_SLAVE)))
                {
                    summonId = effect.diceNum;
                    monsterS = Monster.getMonsterById(summonId);
                    if (((monsterS) && (monsterS.useSummonSlot)))
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        public function get canBomb():Boolean
        {
            var effect:EffectInstanceDice;
            var summonId:int;
            var monsterS:Monster;
            for each (effect in this.effects)
            {
                if (effect.effectId == ActionIds.ACTION_SUMMON_BOMB)
                {
                    return (true);
                };
                if ((((effect.effectId == ActionIds.ACTION_SUMMON_CREATURE) || (effect.effectId == ActionIds.ACTION_FIGHT_KILL_AND_SUMMON)) || (effect.effectId == ActionIds.ACTION_FIGHT_KILL_AND_SUMMON_SLAVE)))
                {
                    summonId = effect.diceNum;
                    monsterS = Monster.getMonsterById(summonId);
                    if (((monsterS) && (monsterS.useBombSlot)))
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        public function get canThrowPlayer():Boolean
        {
            var effect:EffectInstanceDice;
            for each (effect in this.effects)
            {
                if (effect.effectId == ActionIds.ACTION_THROW_CARRIED_CHARACTER)
                {
                    return (true);
                };
            };
            return (false);
        }


    }
}

