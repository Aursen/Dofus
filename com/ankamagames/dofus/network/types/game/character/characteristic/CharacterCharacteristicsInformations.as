package com.ankamagames.dofus.network.types.game.character.characteristic
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.character.alignment.ActorExtendedAlignmentInformations;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.utils.FuncTree;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class CharacterCharacteristicsInformations implements INetworkType 
    {

        public static const protocolId:uint = 8;

        public var experience:Number = 0;
        public var experienceLevelFloor:Number = 0;
        public var experienceNextLevelFloor:Number = 0;
        public var experienceBonusLimit:Number = 0;
        public var kamas:Number = 0;
        public var statsPoints:uint = 0;
        public var additionnalPoints:uint = 0;
        public var spellsPoints:uint = 0;
        public var alignmentInfos:ActorExtendedAlignmentInformations = new ActorExtendedAlignmentInformations();
        public var lifePoints:uint = 0;
        public var maxLifePoints:uint = 0;
        public var energyPoints:uint = 0;
        public var maxEnergyPoints:uint = 0;
        public var actionPointsCurrent:int = 0;
        public var movementPointsCurrent:int = 0;
        public var initiative:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var prospecting:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var actionPoints:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var movementPoints:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var strength:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var vitality:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var wisdom:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var chance:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var agility:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var intelligence:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var range:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var summonableCreaturesBoost:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var reflect:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var criticalHit:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var criticalHitWeapon:uint = 0;
        public var criticalMiss:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var healBonus:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var allDamagesBonus:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var weaponDamagesBonusPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var damagesBonusPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var trapBonus:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var trapBonusPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var glyphBonusPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var runeBonusPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var permanentDamagePercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var tackleBlock:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var tackleEvade:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var PAAttack:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var PMAttack:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var pushDamageBonus:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var criticalDamageBonus:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var neutralDamageBonus:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var earthDamageBonus:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var waterDamageBonus:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var airDamageBonus:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var fireDamageBonus:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var dodgePALostProbability:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var dodgePMLostProbability:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var neutralElementResistPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var earthElementResistPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var waterElementResistPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var airElementResistPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var fireElementResistPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var neutralElementReduction:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var earthElementReduction:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var waterElementReduction:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var airElementReduction:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var fireElementReduction:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var pushDamageReduction:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var criticalDamageReduction:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var pvpNeutralElementResistPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var pvpEarthElementResistPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var pvpWaterElementResistPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var pvpAirElementResistPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var pvpFireElementResistPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var pvpNeutralElementReduction:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var pvpEarthElementReduction:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var pvpWaterElementReduction:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var pvpAirElementReduction:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var pvpFireElementReduction:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var meleeDamageDonePercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var meleeDamageReceivedPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var rangedDamageDonePercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var rangedDamageReceivedPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var weaponDamageDonePercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var weaponDamageReceivedPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var spellDamageDonePercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var spellDamageReceivedPercent:CharacterBaseCharacteristic = new CharacterBaseCharacteristic();
        public var spellModifications:Vector.<CharacterSpellModification> = new Vector.<CharacterSpellModification>();
        public var probationTime:uint = 0;
        private var _alignmentInfostree:FuncTree;
        private var _initiativetree:FuncTree;
        private var _prospectingtree:FuncTree;
        private var _actionPointstree:FuncTree;
        private var _movementPointstree:FuncTree;
        private var _strengthtree:FuncTree;
        private var _vitalitytree:FuncTree;
        private var _wisdomtree:FuncTree;
        private var _chancetree:FuncTree;
        private var _agilitytree:FuncTree;
        private var _intelligencetree:FuncTree;
        private var _rangetree:FuncTree;
        private var _summonableCreaturesBoosttree:FuncTree;
        private var _reflecttree:FuncTree;
        private var _criticalHittree:FuncTree;
        private var _criticalMisstree:FuncTree;
        private var _healBonustree:FuncTree;
        private var _allDamagesBonustree:FuncTree;
        private var _weaponDamagesBonusPercenttree:FuncTree;
        private var _damagesBonusPercenttree:FuncTree;
        private var _trapBonustree:FuncTree;
        private var _trapBonusPercenttree:FuncTree;
        private var _glyphBonusPercenttree:FuncTree;
        private var _runeBonusPercenttree:FuncTree;
        private var _permanentDamagePercenttree:FuncTree;
        private var _tackleBlocktree:FuncTree;
        private var _tackleEvadetree:FuncTree;
        private var _PAAttacktree:FuncTree;
        private var _PMAttacktree:FuncTree;
        private var _pushDamageBonustree:FuncTree;
        private var _criticalDamageBonustree:FuncTree;
        private var _neutralDamageBonustree:FuncTree;
        private var _earthDamageBonustree:FuncTree;
        private var _waterDamageBonustree:FuncTree;
        private var _airDamageBonustree:FuncTree;
        private var _fireDamageBonustree:FuncTree;
        private var _dodgePALostProbabilitytree:FuncTree;
        private var _dodgePMLostProbabilitytree:FuncTree;
        private var _neutralElementResistPercenttree:FuncTree;
        private var _earthElementResistPercenttree:FuncTree;
        private var _waterElementResistPercenttree:FuncTree;
        private var _airElementResistPercenttree:FuncTree;
        private var _fireElementResistPercenttree:FuncTree;
        private var _neutralElementReductiontree:FuncTree;
        private var _earthElementReductiontree:FuncTree;
        private var _waterElementReductiontree:FuncTree;
        private var _airElementReductiontree:FuncTree;
        private var _fireElementReductiontree:FuncTree;
        private var _pushDamageReductiontree:FuncTree;
        private var _criticalDamageReductiontree:FuncTree;
        private var _pvpNeutralElementResistPercenttree:FuncTree;
        private var _pvpEarthElementResistPercenttree:FuncTree;
        private var _pvpWaterElementResistPercenttree:FuncTree;
        private var _pvpAirElementResistPercenttree:FuncTree;
        private var _pvpFireElementResistPercenttree:FuncTree;
        private var _pvpNeutralElementReductiontree:FuncTree;
        private var _pvpEarthElementReductiontree:FuncTree;
        private var _pvpWaterElementReductiontree:FuncTree;
        private var _pvpAirElementReductiontree:FuncTree;
        private var _pvpFireElementReductiontree:FuncTree;
        private var _meleeDamageDonePercenttree:FuncTree;
        private var _meleeDamageReceivedPercenttree:FuncTree;
        private var _rangedDamageDonePercenttree:FuncTree;
        private var _rangedDamageReceivedPercenttree:FuncTree;
        private var _weaponDamageDonePercenttree:FuncTree;
        private var _weaponDamageReceivedPercenttree:FuncTree;
        private var _spellDamageDonePercenttree:FuncTree;
        private var _spellDamageReceivedPercenttree:FuncTree;
        private var _spellModificationstree:FuncTree;


        public function getTypeId():uint
        {
            return (8);
        }

        public function initCharacterCharacteristicsInformations(experience:Number=0, experienceLevelFloor:Number=0, experienceNextLevelFloor:Number=0, experienceBonusLimit:Number=0, kamas:Number=0, statsPoints:uint=0, additionnalPoints:uint=0, spellsPoints:uint=0, alignmentInfos:ActorExtendedAlignmentInformations=null, lifePoints:uint=0, maxLifePoints:uint=0, energyPoints:uint=0, maxEnergyPoints:uint=0, actionPointsCurrent:int=0, movementPointsCurrent:int=0, initiative:CharacterBaseCharacteristic=null, prospecting:CharacterBaseCharacteristic=null, actionPoints:CharacterBaseCharacteristic=null, movementPoints:CharacterBaseCharacteristic=null, strength:CharacterBaseCharacteristic=null, vitality:CharacterBaseCharacteristic=null, wisdom:CharacterBaseCharacteristic=null, chance:CharacterBaseCharacteristic=null, agility:CharacterBaseCharacteristic=null, intelligence:CharacterBaseCharacteristic=null, range:CharacterBaseCharacteristic=null, summonableCreaturesBoost:CharacterBaseCharacteristic=null, reflect:CharacterBaseCharacteristic=null, criticalHit:CharacterBaseCharacteristic=null, criticalHitWeapon:uint=0, criticalMiss:CharacterBaseCharacteristic=null, healBonus:CharacterBaseCharacteristic=null, allDamagesBonus:CharacterBaseCharacteristic=null, weaponDamagesBonusPercent:CharacterBaseCharacteristic=null, damagesBonusPercent:CharacterBaseCharacteristic=null, trapBonus:CharacterBaseCharacteristic=null, trapBonusPercent:CharacterBaseCharacteristic=null, glyphBonusPercent:CharacterBaseCharacteristic=null, runeBonusPercent:CharacterBaseCharacteristic=null, permanentDamagePercent:CharacterBaseCharacteristic=null, tackleBlock:CharacterBaseCharacteristic=null, tackleEvade:CharacterBaseCharacteristic=null, PAAttack:CharacterBaseCharacteristic=null, PMAttack:CharacterBaseCharacteristic=null, pushDamageBonus:CharacterBaseCharacteristic=null, criticalDamageBonus:CharacterBaseCharacteristic=null, neutralDamageBonus:CharacterBaseCharacteristic=null, earthDamageBonus:CharacterBaseCharacteristic=null, waterDamageBonus:CharacterBaseCharacteristic=null, airDamageBonus:CharacterBaseCharacteristic=null, fireDamageBonus:CharacterBaseCharacteristic=null, dodgePALostProbability:CharacterBaseCharacteristic=null, dodgePMLostProbability:CharacterBaseCharacteristic=null, neutralElementResistPercent:CharacterBaseCharacteristic=null, earthElementResistPercent:CharacterBaseCharacteristic=null, waterElementResistPercent:CharacterBaseCharacteristic=null, airElementResistPercent:CharacterBaseCharacteristic=null, fireElementResistPercent:CharacterBaseCharacteristic=null, neutralElementReduction:CharacterBaseCharacteristic=null, earthElementReduction:CharacterBaseCharacteristic=null, waterElementReduction:CharacterBaseCharacteristic=null, airElementReduction:CharacterBaseCharacteristic=null, fireElementReduction:CharacterBaseCharacteristic=null, pushDamageReduction:CharacterBaseCharacteristic=null, criticalDamageReduction:CharacterBaseCharacteristic=null, pvpNeutralElementResistPercent:CharacterBaseCharacteristic=null, pvpEarthElementResistPercent:CharacterBaseCharacteristic=null, pvpWaterElementResistPercent:CharacterBaseCharacteristic=null, pvpAirElementResistPercent:CharacterBaseCharacteristic=null, pvpFireElementResistPercent:CharacterBaseCharacteristic=null, pvpNeutralElementReduction:CharacterBaseCharacteristic=null, pvpEarthElementReduction:CharacterBaseCharacteristic=null, pvpWaterElementReduction:CharacterBaseCharacteristic=null, pvpAirElementReduction:CharacterBaseCharacteristic=null, pvpFireElementReduction:CharacterBaseCharacteristic=null, meleeDamageDonePercent:CharacterBaseCharacteristic=null, meleeDamageReceivedPercent:CharacterBaseCharacteristic=null, rangedDamageDonePercent:CharacterBaseCharacteristic=null, rangedDamageReceivedPercent:CharacterBaseCharacteristic=null, weaponDamageDonePercent:CharacterBaseCharacteristic=null, weaponDamageReceivedPercent:CharacterBaseCharacteristic=null, spellDamageDonePercent:CharacterBaseCharacteristic=null, spellDamageReceivedPercent:CharacterBaseCharacteristic=null, spellModifications:Vector.<CharacterSpellModification>=null, probationTime:uint=0):CharacterCharacteristicsInformations
        {
            this.experience = experience;
            this.experienceLevelFloor = experienceLevelFloor;
            this.experienceNextLevelFloor = experienceNextLevelFloor;
            this.experienceBonusLimit = experienceBonusLimit;
            this.kamas = kamas;
            this.statsPoints = statsPoints;
            this.additionnalPoints = additionnalPoints;
            this.spellsPoints = spellsPoints;
            this.alignmentInfos = alignmentInfos;
            this.lifePoints = lifePoints;
            this.maxLifePoints = maxLifePoints;
            this.energyPoints = energyPoints;
            this.maxEnergyPoints = maxEnergyPoints;
            this.actionPointsCurrent = actionPointsCurrent;
            this.movementPointsCurrent = movementPointsCurrent;
            this.initiative = initiative;
            this.prospecting = prospecting;
            this.actionPoints = actionPoints;
            this.movementPoints = movementPoints;
            this.strength = strength;
            this.vitality = vitality;
            this.wisdom = wisdom;
            this.chance = chance;
            this.agility = agility;
            this.intelligence = intelligence;
            this.range = range;
            this.summonableCreaturesBoost = summonableCreaturesBoost;
            this.reflect = reflect;
            this.criticalHit = criticalHit;
            this.criticalHitWeapon = criticalHitWeapon;
            this.criticalMiss = criticalMiss;
            this.healBonus = healBonus;
            this.allDamagesBonus = allDamagesBonus;
            this.weaponDamagesBonusPercent = weaponDamagesBonusPercent;
            this.damagesBonusPercent = damagesBonusPercent;
            this.trapBonus = trapBonus;
            this.trapBonusPercent = trapBonusPercent;
            this.glyphBonusPercent = glyphBonusPercent;
            this.runeBonusPercent = runeBonusPercent;
            this.permanentDamagePercent = permanentDamagePercent;
            this.tackleBlock = tackleBlock;
            this.tackleEvade = tackleEvade;
            this.PAAttack = PAAttack;
            this.PMAttack = PMAttack;
            this.pushDamageBonus = pushDamageBonus;
            this.criticalDamageBonus = criticalDamageBonus;
            this.neutralDamageBonus = neutralDamageBonus;
            this.earthDamageBonus = earthDamageBonus;
            this.waterDamageBonus = waterDamageBonus;
            this.airDamageBonus = airDamageBonus;
            this.fireDamageBonus = fireDamageBonus;
            this.dodgePALostProbability = dodgePALostProbability;
            this.dodgePMLostProbability = dodgePMLostProbability;
            this.neutralElementResistPercent = neutralElementResistPercent;
            this.earthElementResistPercent = earthElementResistPercent;
            this.waterElementResistPercent = waterElementResistPercent;
            this.airElementResistPercent = airElementResistPercent;
            this.fireElementResistPercent = fireElementResistPercent;
            this.neutralElementReduction = neutralElementReduction;
            this.earthElementReduction = earthElementReduction;
            this.waterElementReduction = waterElementReduction;
            this.airElementReduction = airElementReduction;
            this.fireElementReduction = fireElementReduction;
            this.pushDamageReduction = pushDamageReduction;
            this.criticalDamageReduction = criticalDamageReduction;
            this.pvpNeutralElementResistPercent = pvpNeutralElementResistPercent;
            this.pvpEarthElementResistPercent = pvpEarthElementResistPercent;
            this.pvpWaterElementResistPercent = pvpWaterElementResistPercent;
            this.pvpAirElementResistPercent = pvpAirElementResistPercent;
            this.pvpFireElementResistPercent = pvpFireElementResistPercent;
            this.pvpNeutralElementReduction = pvpNeutralElementReduction;
            this.pvpEarthElementReduction = pvpEarthElementReduction;
            this.pvpWaterElementReduction = pvpWaterElementReduction;
            this.pvpAirElementReduction = pvpAirElementReduction;
            this.pvpFireElementReduction = pvpFireElementReduction;
            this.meleeDamageDonePercent = meleeDamageDonePercent;
            this.meleeDamageReceivedPercent = meleeDamageReceivedPercent;
            this.rangedDamageDonePercent = rangedDamageDonePercent;
            this.rangedDamageReceivedPercent = rangedDamageReceivedPercent;
            this.weaponDamageDonePercent = weaponDamageDonePercent;
            this.weaponDamageReceivedPercent = weaponDamageReceivedPercent;
            this.spellDamageDonePercent = spellDamageDonePercent;
            this.spellDamageReceivedPercent = spellDamageReceivedPercent;
            this.spellModifications = spellModifications;
            this.probationTime = probationTime;
            return (this);
        }

        public function reset():void
        {
            this.experience = 0;
            this.experienceLevelFloor = 0;
            this.experienceNextLevelFloor = 0;
            this.experienceBonusLimit = 0;
            this.kamas = 0;
            this.statsPoints = 0;
            this.additionnalPoints = 0;
            this.spellsPoints = 0;
            this.alignmentInfos = new ActorExtendedAlignmentInformations();
            this.maxLifePoints = 0;
            this.energyPoints = 0;
            this.maxEnergyPoints = 0;
            this.actionPointsCurrent = 0;
            this.movementPointsCurrent = 0;
            this.initiative = new CharacterBaseCharacteristic();
            this.criticalMiss = new CharacterBaseCharacteristic();
            this.probationTime = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_CharacterCharacteristicsInformations(output);
        }

        public function serializeAs_CharacterCharacteristicsInformations(output:ICustomDataOutput):void
        {
            if (((this.experience < 0) || (this.experience > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.experience) + ") on element experience.")));
            };
            output.writeVarLong(this.experience);
            if (((this.experienceLevelFloor < 0) || (this.experienceLevelFloor > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.experienceLevelFloor) + ") on element experienceLevelFloor.")));
            };
            output.writeVarLong(this.experienceLevelFloor);
            if (((this.experienceNextLevelFloor < 0) || (this.experienceNextLevelFloor > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.experienceNextLevelFloor) + ") on element experienceNextLevelFloor.")));
            };
            output.writeVarLong(this.experienceNextLevelFloor);
            if (((this.experienceBonusLimit < 0) || (this.experienceBonusLimit > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.experienceBonusLimit) + ") on element experienceBonusLimit.")));
            };
            output.writeVarLong(this.experienceBonusLimit);
            if (((this.kamas < 0) || (this.kamas > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.kamas) + ") on element kamas.")));
            };
            output.writeVarLong(this.kamas);
            if (this.statsPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.statsPoints) + ") on element statsPoints.")));
            };
            output.writeVarShort(this.statsPoints);
            if (this.additionnalPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.additionnalPoints) + ") on element additionnalPoints.")));
            };
            output.writeVarShort(this.additionnalPoints);
            if (this.spellsPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellsPoints) + ") on element spellsPoints.")));
            };
            output.writeVarShort(this.spellsPoints);
            this.alignmentInfos.serializeAs_ActorExtendedAlignmentInformations(output);
            if (this.lifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.lifePoints) + ") on element lifePoints.")));
            };
            output.writeVarInt(this.lifePoints);
            if (this.maxLifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxLifePoints) + ") on element maxLifePoints.")));
            };
            output.writeVarInt(this.maxLifePoints);
            if (this.energyPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.energyPoints) + ") on element energyPoints.")));
            };
            output.writeVarShort(this.energyPoints);
            if (this.maxEnergyPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxEnergyPoints) + ") on element maxEnergyPoints.")));
            };
            output.writeVarShort(this.maxEnergyPoints);
            output.writeVarShort(this.actionPointsCurrent);
            output.writeVarShort(this.movementPointsCurrent);
            this.initiative.serializeAs_CharacterBaseCharacteristic(output);
            this.prospecting.serializeAs_CharacterBaseCharacteristic(output);
            this.actionPoints.serializeAs_CharacterBaseCharacteristic(output);
            this.movementPoints.serializeAs_CharacterBaseCharacteristic(output);
            this.strength.serializeAs_CharacterBaseCharacteristic(output);
            this.vitality.serializeAs_CharacterBaseCharacteristic(output);
            this.wisdom.serializeAs_CharacterBaseCharacteristic(output);
            this.chance.serializeAs_CharacterBaseCharacteristic(output);
            this.agility.serializeAs_CharacterBaseCharacteristic(output);
            this.intelligence.serializeAs_CharacterBaseCharacteristic(output);
            this.range.serializeAs_CharacterBaseCharacteristic(output);
            this.summonableCreaturesBoost.serializeAs_CharacterBaseCharacteristic(output);
            this.reflect.serializeAs_CharacterBaseCharacteristic(output);
            this.criticalHit.serializeAs_CharacterBaseCharacteristic(output);
            if (this.criticalHitWeapon < 0)
            {
                throw (new Error((("Forbidden value (" + this.criticalHitWeapon) + ") on element criticalHitWeapon.")));
            };
            output.writeVarShort(this.criticalHitWeapon);
            this.criticalMiss.serializeAs_CharacterBaseCharacteristic(output);
            this.healBonus.serializeAs_CharacterBaseCharacteristic(output);
            this.allDamagesBonus.serializeAs_CharacterBaseCharacteristic(output);
            this.weaponDamagesBonusPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.damagesBonusPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.trapBonus.serializeAs_CharacterBaseCharacteristic(output);
            this.trapBonusPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.glyphBonusPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.runeBonusPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.permanentDamagePercent.serializeAs_CharacterBaseCharacteristic(output);
            this.tackleBlock.serializeAs_CharacterBaseCharacteristic(output);
            this.tackleEvade.serializeAs_CharacterBaseCharacteristic(output);
            this.PAAttack.serializeAs_CharacterBaseCharacteristic(output);
            this.PMAttack.serializeAs_CharacterBaseCharacteristic(output);
            this.pushDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
            this.criticalDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
            this.neutralDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
            this.earthDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
            this.waterDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
            this.airDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
            this.fireDamageBonus.serializeAs_CharacterBaseCharacteristic(output);
            this.dodgePALostProbability.serializeAs_CharacterBaseCharacteristic(output);
            this.dodgePMLostProbability.serializeAs_CharacterBaseCharacteristic(output);
            this.neutralElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.earthElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.waterElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.airElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.fireElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.neutralElementReduction.serializeAs_CharacterBaseCharacteristic(output);
            this.earthElementReduction.serializeAs_CharacterBaseCharacteristic(output);
            this.waterElementReduction.serializeAs_CharacterBaseCharacteristic(output);
            this.airElementReduction.serializeAs_CharacterBaseCharacteristic(output);
            this.fireElementReduction.serializeAs_CharacterBaseCharacteristic(output);
            this.pushDamageReduction.serializeAs_CharacterBaseCharacteristic(output);
            this.criticalDamageReduction.serializeAs_CharacterBaseCharacteristic(output);
            this.pvpNeutralElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.pvpEarthElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.pvpWaterElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.pvpAirElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.pvpFireElementResistPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.pvpNeutralElementReduction.serializeAs_CharacterBaseCharacteristic(output);
            this.pvpEarthElementReduction.serializeAs_CharacterBaseCharacteristic(output);
            this.pvpWaterElementReduction.serializeAs_CharacterBaseCharacteristic(output);
            this.pvpAirElementReduction.serializeAs_CharacterBaseCharacteristic(output);
            this.pvpFireElementReduction.serializeAs_CharacterBaseCharacteristic(output);
            this.meleeDamageDonePercent.serializeAs_CharacterBaseCharacteristic(output);
            this.meleeDamageReceivedPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.rangedDamageDonePercent.serializeAs_CharacterBaseCharacteristic(output);
            this.rangedDamageReceivedPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.weaponDamageDonePercent.serializeAs_CharacterBaseCharacteristic(output);
            this.weaponDamageReceivedPercent.serializeAs_CharacterBaseCharacteristic(output);
            this.spellDamageDonePercent.serializeAs_CharacterBaseCharacteristic(output);
            this.spellDamageReceivedPercent.serializeAs_CharacterBaseCharacteristic(output);
            output.writeShort(this.spellModifications.length);
            var _i84:uint;
            while (_i84 < this.spellModifications.length)
            {
                (this.spellModifications[_i84] as CharacterSpellModification).serializeAs_CharacterSpellModification(output);
                _i84++;
            };
            if (this.probationTime < 0)
            {
                throw (new Error((("Forbidden value (" + this.probationTime) + ") on element probationTime.")));
            };
            output.writeInt(this.probationTime);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterCharacteristicsInformations(input);
        }

        public function deserializeAs_CharacterCharacteristicsInformations(input:ICustomDataInput):void
        {
            var _item84:CharacterSpellModification;
            this._experienceFunc(input);
            this._experienceLevelFloorFunc(input);
            this._experienceNextLevelFloorFunc(input);
            this._experienceBonusLimitFunc(input);
            this._kamasFunc(input);
            this._statsPointsFunc(input);
            this._additionnalPointsFunc(input);
            this._spellsPointsFunc(input);
            this.alignmentInfos = new ActorExtendedAlignmentInformations();
            this.alignmentInfos.deserialize(input);
            this._lifePointsFunc(input);
            this._maxLifePointsFunc(input);
            this._energyPointsFunc(input);
            this._maxEnergyPointsFunc(input);
            this._actionPointsCurrentFunc(input);
            this._movementPointsCurrentFunc(input);
            this.initiative = new CharacterBaseCharacteristic();
            this.initiative.deserialize(input);
            this.prospecting = new CharacterBaseCharacteristic();
            this.prospecting.deserialize(input);
            this.actionPoints = new CharacterBaseCharacteristic();
            this.actionPoints.deserialize(input);
            this.movementPoints = new CharacterBaseCharacteristic();
            this.movementPoints.deserialize(input);
            this.strength = new CharacterBaseCharacteristic();
            this.strength.deserialize(input);
            this.vitality = new CharacterBaseCharacteristic();
            this.vitality.deserialize(input);
            this.wisdom = new CharacterBaseCharacteristic();
            this.wisdom.deserialize(input);
            this.chance = new CharacterBaseCharacteristic();
            this.chance.deserialize(input);
            this.agility = new CharacterBaseCharacteristic();
            this.agility.deserialize(input);
            this.intelligence = new CharacterBaseCharacteristic();
            this.intelligence.deserialize(input);
            this.range = new CharacterBaseCharacteristic();
            this.range.deserialize(input);
            this.summonableCreaturesBoost = new CharacterBaseCharacteristic();
            this.summonableCreaturesBoost.deserialize(input);
            this.reflect = new CharacterBaseCharacteristic();
            this.reflect.deserialize(input);
            this.criticalHit = new CharacterBaseCharacteristic();
            this.criticalHit.deserialize(input);
            this._criticalHitWeaponFunc(input);
            this.criticalMiss = new CharacterBaseCharacteristic();
            this.criticalMiss.deserialize(input);
            this.healBonus = new CharacterBaseCharacteristic();
            this.healBonus.deserialize(input);
            this.allDamagesBonus = new CharacterBaseCharacteristic();
            this.allDamagesBonus.deserialize(input);
            this.weaponDamagesBonusPercent = new CharacterBaseCharacteristic();
            this.weaponDamagesBonusPercent.deserialize(input);
            this.damagesBonusPercent = new CharacterBaseCharacteristic();
            this.damagesBonusPercent.deserialize(input);
            this.trapBonus = new CharacterBaseCharacteristic();
            this.trapBonus.deserialize(input);
            this.trapBonusPercent = new CharacterBaseCharacteristic();
            this.trapBonusPercent.deserialize(input);
            this.glyphBonusPercent = new CharacterBaseCharacteristic();
            this.glyphBonusPercent.deserialize(input);
            this.runeBonusPercent = new CharacterBaseCharacteristic();
            this.runeBonusPercent.deserialize(input);
            this.permanentDamagePercent = new CharacterBaseCharacteristic();
            this.permanentDamagePercent.deserialize(input);
            this.tackleBlock = new CharacterBaseCharacteristic();
            this.tackleBlock.deserialize(input);
            this.tackleEvade = new CharacterBaseCharacteristic();
            this.tackleEvade.deserialize(input);
            this.PAAttack = new CharacterBaseCharacteristic();
            this.PAAttack.deserialize(input);
            this.PMAttack = new CharacterBaseCharacteristic();
            this.PMAttack.deserialize(input);
            this.pushDamageBonus = new CharacterBaseCharacteristic();
            this.pushDamageBonus.deserialize(input);
            this.criticalDamageBonus = new CharacterBaseCharacteristic();
            this.criticalDamageBonus.deserialize(input);
            this.neutralDamageBonus = new CharacterBaseCharacteristic();
            this.neutralDamageBonus.deserialize(input);
            this.earthDamageBonus = new CharacterBaseCharacteristic();
            this.earthDamageBonus.deserialize(input);
            this.waterDamageBonus = new CharacterBaseCharacteristic();
            this.waterDamageBonus.deserialize(input);
            this.airDamageBonus = new CharacterBaseCharacteristic();
            this.airDamageBonus.deserialize(input);
            this.fireDamageBonus = new CharacterBaseCharacteristic();
            this.fireDamageBonus.deserialize(input);
            this.dodgePALostProbability = new CharacterBaseCharacteristic();
            this.dodgePALostProbability.deserialize(input);
            this.dodgePMLostProbability = new CharacterBaseCharacteristic();
            this.dodgePMLostProbability.deserialize(input);
            this.neutralElementResistPercent = new CharacterBaseCharacteristic();
            this.neutralElementResistPercent.deserialize(input);
            this.earthElementResistPercent = new CharacterBaseCharacteristic();
            this.earthElementResistPercent.deserialize(input);
            this.waterElementResistPercent = new CharacterBaseCharacteristic();
            this.waterElementResistPercent.deserialize(input);
            this.airElementResistPercent = new CharacterBaseCharacteristic();
            this.airElementResistPercent.deserialize(input);
            this.fireElementResistPercent = new CharacterBaseCharacteristic();
            this.fireElementResistPercent.deserialize(input);
            this.neutralElementReduction = new CharacterBaseCharacteristic();
            this.neutralElementReduction.deserialize(input);
            this.earthElementReduction = new CharacterBaseCharacteristic();
            this.earthElementReduction.deserialize(input);
            this.waterElementReduction = new CharacterBaseCharacteristic();
            this.waterElementReduction.deserialize(input);
            this.airElementReduction = new CharacterBaseCharacteristic();
            this.airElementReduction.deserialize(input);
            this.fireElementReduction = new CharacterBaseCharacteristic();
            this.fireElementReduction.deserialize(input);
            this.pushDamageReduction = new CharacterBaseCharacteristic();
            this.pushDamageReduction.deserialize(input);
            this.criticalDamageReduction = new CharacterBaseCharacteristic();
            this.criticalDamageReduction.deserialize(input);
            this.pvpNeutralElementResistPercent = new CharacterBaseCharacteristic();
            this.pvpNeutralElementResistPercent.deserialize(input);
            this.pvpEarthElementResistPercent = new CharacterBaseCharacteristic();
            this.pvpEarthElementResistPercent.deserialize(input);
            this.pvpWaterElementResistPercent = new CharacterBaseCharacteristic();
            this.pvpWaterElementResistPercent.deserialize(input);
            this.pvpAirElementResistPercent = new CharacterBaseCharacteristic();
            this.pvpAirElementResistPercent.deserialize(input);
            this.pvpFireElementResistPercent = new CharacterBaseCharacteristic();
            this.pvpFireElementResistPercent.deserialize(input);
            this.pvpNeutralElementReduction = new CharacterBaseCharacteristic();
            this.pvpNeutralElementReduction.deserialize(input);
            this.pvpEarthElementReduction = new CharacterBaseCharacteristic();
            this.pvpEarthElementReduction.deserialize(input);
            this.pvpWaterElementReduction = new CharacterBaseCharacteristic();
            this.pvpWaterElementReduction.deserialize(input);
            this.pvpAirElementReduction = new CharacterBaseCharacteristic();
            this.pvpAirElementReduction.deserialize(input);
            this.pvpFireElementReduction = new CharacterBaseCharacteristic();
            this.pvpFireElementReduction.deserialize(input);
            this.meleeDamageDonePercent = new CharacterBaseCharacteristic();
            this.meleeDamageDonePercent.deserialize(input);
            this.meleeDamageReceivedPercent = new CharacterBaseCharacteristic();
            this.meleeDamageReceivedPercent.deserialize(input);
            this.rangedDamageDonePercent = new CharacterBaseCharacteristic();
            this.rangedDamageDonePercent.deserialize(input);
            this.rangedDamageReceivedPercent = new CharacterBaseCharacteristic();
            this.rangedDamageReceivedPercent.deserialize(input);
            this.weaponDamageDonePercent = new CharacterBaseCharacteristic();
            this.weaponDamageDonePercent.deserialize(input);
            this.weaponDamageReceivedPercent = new CharacterBaseCharacteristic();
            this.weaponDamageReceivedPercent.deserialize(input);
            this.spellDamageDonePercent = new CharacterBaseCharacteristic();
            this.spellDamageDonePercent.deserialize(input);
            this.spellDamageReceivedPercent = new CharacterBaseCharacteristic();
            this.spellDamageReceivedPercent.deserialize(input);
            var _spellModificationsLen:uint = input.readUnsignedShort();
            var _i84:uint;
            while (_i84 < _spellModificationsLen)
            {
                _item84 = new CharacterSpellModification();
                _item84.deserialize(input);
                this.spellModifications.push(_item84);
                _i84++;
            };
            this._probationTimeFunc(input);
        }

        public function deserializeAsync(tree:FuncTree):void
        {
            this.deserializeAsyncAs_CharacterCharacteristicsInformations(tree);
        }

        public function deserializeAsyncAs_CharacterCharacteristicsInformations(tree:FuncTree):void
        {
            tree.addChild(this._experienceFunc);
            tree.addChild(this._experienceLevelFloorFunc);
            tree.addChild(this._experienceNextLevelFloorFunc);
            tree.addChild(this._experienceBonusLimitFunc);
            tree.addChild(this._kamasFunc);
            tree.addChild(this._statsPointsFunc);
            tree.addChild(this._additionnalPointsFunc);
            tree.addChild(this._spellsPointsFunc);
            this._alignmentInfostree = tree.addChild(this._alignmentInfostreeFunc);
            tree.addChild(this._lifePointsFunc);
            tree.addChild(this._maxLifePointsFunc);
            tree.addChild(this._energyPointsFunc);
            tree.addChild(this._maxEnergyPointsFunc);
            tree.addChild(this._actionPointsCurrentFunc);
            tree.addChild(this._movementPointsCurrentFunc);
            this._initiativetree = tree.addChild(this._initiativetreeFunc);
            this._prospectingtree = tree.addChild(this._prospectingtreeFunc);
            this._actionPointstree = tree.addChild(this._actionPointstreeFunc);
            this._movementPointstree = tree.addChild(this._movementPointstreeFunc);
            this._strengthtree = tree.addChild(this._strengthtreeFunc);
            this._vitalitytree = tree.addChild(this._vitalitytreeFunc);
            this._wisdomtree = tree.addChild(this._wisdomtreeFunc);
            this._chancetree = tree.addChild(this._chancetreeFunc);
            this._agilitytree = tree.addChild(this._agilitytreeFunc);
            this._intelligencetree = tree.addChild(this._intelligencetreeFunc);
            this._rangetree = tree.addChild(this._rangetreeFunc);
            this._summonableCreaturesBoosttree = tree.addChild(this._summonableCreaturesBoosttreeFunc);
            this._reflecttree = tree.addChild(this._reflecttreeFunc);
            this._criticalHittree = tree.addChild(this._criticalHittreeFunc);
            tree.addChild(this._criticalHitWeaponFunc);
            this._criticalMisstree = tree.addChild(this._criticalMisstreeFunc);
            this._healBonustree = tree.addChild(this._healBonustreeFunc);
            this._allDamagesBonustree = tree.addChild(this._allDamagesBonustreeFunc);
            this._weaponDamagesBonusPercenttree = tree.addChild(this._weaponDamagesBonusPercenttreeFunc);
            this._damagesBonusPercenttree = tree.addChild(this._damagesBonusPercenttreeFunc);
            this._trapBonustree = tree.addChild(this._trapBonustreeFunc);
            this._trapBonusPercenttree = tree.addChild(this._trapBonusPercenttreeFunc);
            this._glyphBonusPercenttree = tree.addChild(this._glyphBonusPercenttreeFunc);
            this._runeBonusPercenttree = tree.addChild(this._runeBonusPercenttreeFunc);
            this._permanentDamagePercenttree = tree.addChild(this._permanentDamagePercenttreeFunc);
            this._tackleBlocktree = tree.addChild(this._tackleBlocktreeFunc);
            this._tackleEvadetree = tree.addChild(this._tackleEvadetreeFunc);
            this._PAAttacktree = tree.addChild(this._PAAttacktreeFunc);
            this._PMAttacktree = tree.addChild(this._PMAttacktreeFunc);
            this._pushDamageBonustree = tree.addChild(this._pushDamageBonustreeFunc);
            this._criticalDamageBonustree = tree.addChild(this._criticalDamageBonustreeFunc);
            this._neutralDamageBonustree = tree.addChild(this._neutralDamageBonustreeFunc);
            this._earthDamageBonustree = tree.addChild(this._earthDamageBonustreeFunc);
            this._waterDamageBonustree = tree.addChild(this._waterDamageBonustreeFunc);
            this._airDamageBonustree = tree.addChild(this._airDamageBonustreeFunc);
            this._fireDamageBonustree = tree.addChild(this._fireDamageBonustreeFunc);
            this._dodgePALostProbabilitytree = tree.addChild(this._dodgePALostProbabilitytreeFunc);
            this._dodgePMLostProbabilitytree = tree.addChild(this._dodgePMLostProbabilitytreeFunc);
            this._neutralElementResistPercenttree = tree.addChild(this._neutralElementResistPercenttreeFunc);
            this._earthElementResistPercenttree = tree.addChild(this._earthElementResistPercenttreeFunc);
            this._waterElementResistPercenttree = tree.addChild(this._waterElementResistPercenttreeFunc);
            this._airElementResistPercenttree = tree.addChild(this._airElementResistPercenttreeFunc);
            this._fireElementResistPercenttree = tree.addChild(this._fireElementResistPercenttreeFunc);
            this._neutralElementReductiontree = tree.addChild(this._neutralElementReductiontreeFunc);
            this._earthElementReductiontree = tree.addChild(this._earthElementReductiontreeFunc);
            this._waterElementReductiontree = tree.addChild(this._waterElementReductiontreeFunc);
            this._airElementReductiontree = tree.addChild(this._airElementReductiontreeFunc);
            this._fireElementReductiontree = tree.addChild(this._fireElementReductiontreeFunc);
            this._pushDamageReductiontree = tree.addChild(this._pushDamageReductiontreeFunc);
            this._criticalDamageReductiontree = tree.addChild(this._criticalDamageReductiontreeFunc);
            this._pvpNeutralElementResistPercenttree = tree.addChild(this._pvpNeutralElementResistPercenttreeFunc);
            this._pvpEarthElementResistPercenttree = tree.addChild(this._pvpEarthElementResistPercenttreeFunc);
            this._pvpWaterElementResistPercenttree = tree.addChild(this._pvpWaterElementResistPercenttreeFunc);
            this._pvpAirElementResistPercenttree = tree.addChild(this._pvpAirElementResistPercenttreeFunc);
            this._pvpFireElementResistPercenttree = tree.addChild(this._pvpFireElementResistPercenttreeFunc);
            this._pvpNeutralElementReductiontree = tree.addChild(this._pvpNeutralElementReductiontreeFunc);
            this._pvpEarthElementReductiontree = tree.addChild(this._pvpEarthElementReductiontreeFunc);
            this._pvpWaterElementReductiontree = tree.addChild(this._pvpWaterElementReductiontreeFunc);
            this._pvpAirElementReductiontree = tree.addChild(this._pvpAirElementReductiontreeFunc);
            this._pvpFireElementReductiontree = tree.addChild(this._pvpFireElementReductiontreeFunc);
            this._meleeDamageDonePercenttree = tree.addChild(this._meleeDamageDonePercenttreeFunc);
            this._meleeDamageReceivedPercenttree = tree.addChild(this._meleeDamageReceivedPercenttreeFunc);
            this._rangedDamageDonePercenttree = tree.addChild(this._rangedDamageDonePercenttreeFunc);
            this._rangedDamageReceivedPercenttree = tree.addChild(this._rangedDamageReceivedPercenttreeFunc);
            this._weaponDamageDonePercenttree = tree.addChild(this._weaponDamageDonePercenttreeFunc);
            this._weaponDamageReceivedPercenttree = tree.addChild(this._weaponDamageReceivedPercenttreeFunc);
            this._spellDamageDonePercenttree = tree.addChild(this._spellDamageDonePercenttreeFunc);
            this._spellDamageReceivedPercenttree = tree.addChild(this._spellDamageReceivedPercenttreeFunc);
            this._spellModificationstree = tree.addChild(this._spellModificationstreeFunc);
            tree.addChild(this._probationTimeFunc);
        }

        private function _experienceFunc(input:ICustomDataInput):void
        {
            this.experience = input.readVarUhLong();
            if (((this.experience < 0) || (this.experience > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.experience) + ") on element of CharacterCharacteristicsInformations.experience.")));
            };
        }

        private function _experienceLevelFloorFunc(input:ICustomDataInput):void
        {
            this.experienceLevelFloor = input.readVarUhLong();
            if (((this.experienceLevelFloor < 0) || (this.experienceLevelFloor > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.experienceLevelFloor) + ") on element of CharacterCharacteristicsInformations.experienceLevelFloor.")));
            };
        }

        private function _experienceNextLevelFloorFunc(input:ICustomDataInput):void
        {
            this.experienceNextLevelFloor = input.readVarUhLong();
            if (((this.experienceNextLevelFloor < 0) || (this.experienceNextLevelFloor > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.experienceNextLevelFloor) + ") on element of CharacterCharacteristicsInformations.experienceNextLevelFloor.")));
            };
        }

        private function _experienceBonusLimitFunc(input:ICustomDataInput):void
        {
            this.experienceBonusLimit = input.readVarUhLong();
            if (((this.experienceBonusLimit < 0) || (this.experienceBonusLimit > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.experienceBonusLimit) + ") on element of CharacterCharacteristicsInformations.experienceBonusLimit.")));
            };
        }

        private function _kamasFunc(input:ICustomDataInput):void
        {
            this.kamas = input.readVarUhLong();
            if (((this.kamas < 0) || (this.kamas > 9007199254740992)))
            {
                throw (new Error((("Forbidden value (" + this.kamas) + ") on element of CharacterCharacteristicsInformations.kamas.")));
            };
        }

        private function _statsPointsFunc(input:ICustomDataInput):void
        {
            this.statsPoints = input.readVarUhShort();
            if (this.statsPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.statsPoints) + ") on element of CharacterCharacteristicsInformations.statsPoints.")));
            };
        }

        private function _additionnalPointsFunc(input:ICustomDataInput):void
        {
            this.additionnalPoints = input.readVarUhShort();
            if (this.additionnalPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.additionnalPoints) + ") on element of CharacterCharacteristicsInformations.additionnalPoints.")));
            };
        }

        private function _spellsPointsFunc(input:ICustomDataInput):void
        {
            this.spellsPoints = input.readVarUhShort();
            if (this.spellsPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellsPoints) + ") on element of CharacterCharacteristicsInformations.spellsPoints.")));
            };
        }

        private function _alignmentInfostreeFunc(input:ICustomDataInput):void
        {
            this.alignmentInfos = new ActorExtendedAlignmentInformations();
            this.alignmentInfos.deserializeAsync(this._alignmentInfostree);
        }

        private function _lifePointsFunc(input:ICustomDataInput):void
        {
            this.lifePoints = input.readVarUhInt();
            if (this.lifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.lifePoints) + ") on element of CharacterCharacteristicsInformations.lifePoints.")));
            };
        }

        private function _maxLifePointsFunc(input:ICustomDataInput):void
        {
            this.maxLifePoints = input.readVarUhInt();
            if (this.maxLifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxLifePoints) + ") on element of CharacterCharacteristicsInformations.maxLifePoints.")));
            };
        }

        private function _energyPointsFunc(input:ICustomDataInput):void
        {
            this.energyPoints = input.readVarUhShort();
            if (this.energyPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.energyPoints) + ") on element of CharacterCharacteristicsInformations.energyPoints.")));
            };
        }

        private function _maxEnergyPointsFunc(input:ICustomDataInput):void
        {
            this.maxEnergyPoints = input.readVarUhShort();
            if (this.maxEnergyPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxEnergyPoints) + ") on element of CharacterCharacteristicsInformations.maxEnergyPoints.")));
            };
        }

        private function _actionPointsCurrentFunc(input:ICustomDataInput):void
        {
            this.actionPointsCurrent = input.readVarShort();
        }

        private function _movementPointsCurrentFunc(input:ICustomDataInput):void
        {
            this.movementPointsCurrent = input.readVarShort();
        }

        private function _initiativetreeFunc(input:ICustomDataInput):void
        {
            this.initiative = new CharacterBaseCharacteristic();
            this.initiative.deserializeAsync(this._initiativetree);
        }

        private function _prospectingtreeFunc(input:ICustomDataInput):void
        {
            this.prospecting = new CharacterBaseCharacteristic();
            this.prospecting.deserializeAsync(this._prospectingtree);
        }

        private function _actionPointstreeFunc(input:ICustomDataInput):void
        {
            this.actionPoints = new CharacterBaseCharacteristic();
            this.actionPoints.deserializeAsync(this._actionPointstree);
        }

        private function _movementPointstreeFunc(input:ICustomDataInput):void
        {
            this.movementPoints = new CharacterBaseCharacteristic();
            this.movementPoints.deserializeAsync(this._movementPointstree);
        }

        private function _strengthtreeFunc(input:ICustomDataInput):void
        {
            this.strength = new CharacterBaseCharacteristic();
            this.strength.deserializeAsync(this._strengthtree);
        }

        private function _vitalitytreeFunc(input:ICustomDataInput):void
        {
            this.vitality = new CharacterBaseCharacteristic();
            this.vitality.deserializeAsync(this._vitalitytree);
        }

        private function _wisdomtreeFunc(input:ICustomDataInput):void
        {
            this.wisdom = new CharacterBaseCharacteristic();
            this.wisdom.deserializeAsync(this._wisdomtree);
        }

        private function _chancetreeFunc(input:ICustomDataInput):void
        {
            this.chance = new CharacterBaseCharacteristic();
            this.chance.deserializeAsync(this._chancetree);
        }

        private function _agilitytreeFunc(input:ICustomDataInput):void
        {
            this.agility = new CharacterBaseCharacteristic();
            this.agility.deserializeAsync(this._agilitytree);
        }

        private function _intelligencetreeFunc(input:ICustomDataInput):void
        {
            this.intelligence = new CharacterBaseCharacteristic();
            this.intelligence.deserializeAsync(this._intelligencetree);
        }

        private function _rangetreeFunc(input:ICustomDataInput):void
        {
            this.range = new CharacterBaseCharacteristic();
            this.range.deserializeAsync(this._rangetree);
        }

        private function _summonableCreaturesBoosttreeFunc(input:ICustomDataInput):void
        {
            this.summonableCreaturesBoost = new CharacterBaseCharacteristic();
            this.summonableCreaturesBoost.deserializeAsync(this._summonableCreaturesBoosttree);
        }

        private function _reflecttreeFunc(input:ICustomDataInput):void
        {
            this.reflect = new CharacterBaseCharacteristic();
            this.reflect.deserializeAsync(this._reflecttree);
        }

        private function _criticalHittreeFunc(input:ICustomDataInput):void
        {
            this.criticalHit = new CharacterBaseCharacteristic();
            this.criticalHit.deserializeAsync(this._criticalHittree);
        }

        private function _criticalHitWeaponFunc(input:ICustomDataInput):void
        {
            this.criticalHitWeapon = input.readVarUhShort();
            if (this.criticalHitWeapon < 0)
            {
                throw (new Error((("Forbidden value (" + this.criticalHitWeapon) + ") on element of CharacterCharacteristicsInformations.criticalHitWeapon.")));
            };
        }

        private function _criticalMisstreeFunc(input:ICustomDataInput):void
        {
            this.criticalMiss = new CharacterBaseCharacteristic();
            this.criticalMiss.deserializeAsync(this._criticalMisstree);
        }

        private function _healBonustreeFunc(input:ICustomDataInput):void
        {
            this.healBonus = new CharacterBaseCharacteristic();
            this.healBonus.deserializeAsync(this._healBonustree);
        }

        private function _allDamagesBonustreeFunc(input:ICustomDataInput):void
        {
            this.allDamagesBonus = new CharacterBaseCharacteristic();
            this.allDamagesBonus.deserializeAsync(this._allDamagesBonustree);
        }

        private function _weaponDamagesBonusPercenttreeFunc(input:ICustomDataInput):void
        {
            this.weaponDamagesBonusPercent = new CharacterBaseCharacteristic();
            this.weaponDamagesBonusPercent.deserializeAsync(this._weaponDamagesBonusPercenttree);
        }

        private function _damagesBonusPercenttreeFunc(input:ICustomDataInput):void
        {
            this.damagesBonusPercent = new CharacterBaseCharacteristic();
            this.damagesBonusPercent.deserializeAsync(this._damagesBonusPercenttree);
        }

        private function _trapBonustreeFunc(input:ICustomDataInput):void
        {
            this.trapBonus = new CharacterBaseCharacteristic();
            this.trapBonus.deserializeAsync(this._trapBonustree);
        }

        private function _trapBonusPercenttreeFunc(input:ICustomDataInput):void
        {
            this.trapBonusPercent = new CharacterBaseCharacteristic();
            this.trapBonusPercent.deserializeAsync(this._trapBonusPercenttree);
        }

        private function _glyphBonusPercenttreeFunc(input:ICustomDataInput):void
        {
            this.glyphBonusPercent = new CharacterBaseCharacteristic();
            this.glyphBonusPercent.deserializeAsync(this._glyphBonusPercenttree);
        }

        private function _runeBonusPercenttreeFunc(input:ICustomDataInput):void
        {
            this.runeBonusPercent = new CharacterBaseCharacteristic();
            this.runeBonusPercent.deserializeAsync(this._runeBonusPercenttree);
        }

        private function _permanentDamagePercenttreeFunc(input:ICustomDataInput):void
        {
            this.permanentDamagePercent = new CharacterBaseCharacteristic();
            this.permanentDamagePercent.deserializeAsync(this._permanentDamagePercenttree);
        }

        private function _tackleBlocktreeFunc(input:ICustomDataInput):void
        {
            this.tackleBlock = new CharacterBaseCharacteristic();
            this.tackleBlock.deserializeAsync(this._tackleBlocktree);
        }

        private function _tackleEvadetreeFunc(input:ICustomDataInput):void
        {
            this.tackleEvade = new CharacterBaseCharacteristic();
            this.tackleEvade.deserializeAsync(this._tackleEvadetree);
        }

        private function _PAAttacktreeFunc(input:ICustomDataInput):void
        {
            this.PAAttack = new CharacterBaseCharacteristic();
            this.PAAttack.deserializeAsync(this._PAAttacktree);
        }

        private function _PMAttacktreeFunc(input:ICustomDataInput):void
        {
            this.PMAttack = new CharacterBaseCharacteristic();
            this.PMAttack.deserializeAsync(this._PMAttacktree);
        }

        private function _pushDamageBonustreeFunc(input:ICustomDataInput):void
        {
            this.pushDamageBonus = new CharacterBaseCharacteristic();
            this.pushDamageBonus.deserializeAsync(this._pushDamageBonustree);
        }

        private function _criticalDamageBonustreeFunc(input:ICustomDataInput):void
        {
            this.criticalDamageBonus = new CharacterBaseCharacteristic();
            this.criticalDamageBonus.deserializeAsync(this._criticalDamageBonustree);
        }

        private function _neutralDamageBonustreeFunc(input:ICustomDataInput):void
        {
            this.neutralDamageBonus = new CharacterBaseCharacteristic();
            this.neutralDamageBonus.deserializeAsync(this._neutralDamageBonustree);
        }

        private function _earthDamageBonustreeFunc(input:ICustomDataInput):void
        {
            this.earthDamageBonus = new CharacterBaseCharacteristic();
            this.earthDamageBonus.deserializeAsync(this._earthDamageBonustree);
        }

        private function _waterDamageBonustreeFunc(input:ICustomDataInput):void
        {
            this.waterDamageBonus = new CharacterBaseCharacteristic();
            this.waterDamageBonus.deserializeAsync(this._waterDamageBonustree);
        }

        private function _airDamageBonustreeFunc(input:ICustomDataInput):void
        {
            this.airDamageBonus = new CharacterBaseCharacteristic();
            this.airDamageBonus.deserializeAsync(this._airDamageBonustree);
        }

        private function _fireDamageBonustreeFunc(input:ICustomDataInput):void
        {
            this.fireDamageBonus = new CharacterBaseCharacteristic();
            this.fireDamageBonus.deserializeAsync(this._fireDamageBonustree);
        }

        private function _dodgePALostProbabilitytreeFunc(input:ICustomDataInput):void
        {
            this.dodgePALostProbability = new CharacterBaseCharacteristic();
            this.dodgePALostProbability.deserializeAsync(this._dodgePALostProbabilitytree);
        }

        private function _dodgePMLostProbabilitytreeFunc(input:ICustomDataInput):void
        {
            this.dodgePMLostProbability = new CharacterBaseCharacteristic();
            this.dodgePMLostProbability.deserializeAsync(this._dodgePMLostProbabilitytree);
        }

        private function _neutralElementResistPercenttreeFunc(input:ICustomDataInput):void
        {
            this.neutralElementResistPercent = new CharacterBaseCharacteristic();
            this.neutralElementResistPercent.deserializeAsync(this._neutralElementResistPercenttree);
        }

        private function _earthElementResistPercenttreeFunc(input:ICustomDataInput):void
        {
            this.earthElementResistPercent = new CharacterBaseCharacteristic();
            this.earthElementResistPercent.deserializeAsync(this._earthElementResistPercenttree);
        }

        private function _waterElementResistPercenttreeFunc(input:ICustomDataInput):void
        {
            this.waterElementResistPercent = new CharacterBaseCharacteristic();
            this.waterElementResistPercent.deserializeAsync(this._waterElementResistPercenttree);
        }

        private function _airElementResistPercenttreeFunc(input:ICustomDataInput):void
        {
            this.airElementResistPercent = new CharacterBaseCharacteristic();
            this.airElementResistPercent.deserializeAsync(this._airElementResistPercenttree);
        }

        private function _fireElementResistPercenttreeFunc(input:ICustomDataInput):void
        {
            this.fireElementResistPercent = new CharacterBaseCharacteristic();
            this.fireElementResistPercent.deserializeAsync(this._fireElementResistPercenttree);
        }

        private function _neutralElementReductiontreeFunc(input:ICustomDataInput):void
        {
            this.neutralElementReduction = new CharacterBaseCharacteristic();
            this.neutralElementReduction.deserializeAsync(this._neutralElementReductiontree);
        }

        private function _earthElementReductiontreeFunc(input:ICustomDataInput):void
        {
            this.earthElementReduction = new CharacterBaseCharacteristic();
            this.earthElementReduction.deserializeAsync(this._earthElementReductiontree);
        }

        private function _waterElementReductiontreeFunc(input:ICustomDataInput):void
        {
            this.waterElementReduction = new CharacterBaseCharacteristic();
            this.waterElementReduction.deserializeAsync(this._waterElementReductiontree);
        }

        private function _airElementReductiontreeFunc(input:ICustomDataInput):void
        {
            this.airElementReduction = new CharacterBaseCharacteristic();
            this.airElementReduction.deserializeAsync(this._airElementReductiontree);
        }

        private function _fireElementReductiontreeFunc(input:ICustomDataInput):void
        {
            this.fireElementReduction = new CharacterBaseCharacteristic();
            this.fireElementReduction.deserializeAsync(this._fireElementReductiontree);
        }

        private function _pushDamageReductiontreeFunc(input:ICustomDataInput):void
        {
            this.pushDamageReduction = new CharacterBaseCharacteristic();
            this.pushDamageReduction.deserializeAsync(this._pushDamageReductiontree);
        }

        private function _criticalDamageReductiontreeFunc(input:ICustomDataInput):void
        {
            this.criticalDamageReduction = new CharacterBaseCharacteristic();
            this.criticalDamageReduction.deserializeAsync(this._criticalDamageReductiontree);
        }

        private function _pvpNeutralElementResistPercenttreeFunc(input:ICustomDataInput):void
        {
            this.pvpNeutralElementResistPercent = new CharacterBaseCharacteristic();
            this.pvpNeutralElementResistPercent.deserializeAsync(this._pvpNeutralElementResistPercenttree);
        }

        private function _pvpEarthElementResistPercenttreeFunc(input:ICustomDataInput):void
        {
            this.pvpEarthElementResistPercent = new CharacterBaseCharacteristic();
            this.pvpEarthElementResistPercent.deserializeAsync(this._pvpEarthElementResistPercenttree);
        }

        private function _pvpWaterElementResistPercenttreeFunc(input:ICustomDataInput):void
        {
            this.pvpWaterElementResistPercent = new CharacterBaseCharacteristic();
            this.pvpWaterElementResistPercent.deserializeAsync(this._pvpWaterElementResistPercenttree);
        }

        private function _pvpAirElementResistPercenttreeFunc(input:ICustomDataInput):void
        {
            this.pvpAirElementResistPercent = new CharacterBaseCharacteristic();
            this.pvpAirElementResistPercent.deserializeAsync(this._pvpAirElementResistPercenttree);
        }

        private function _pvpFireElementResistPercenttreeFunc(input:ICustomDataInput):void
        {
            this.pvpFireElementResistPercent = new CharacterBaseCharacteristic();
            this.pvpFireElementResistPercent.deserializeAsync(this._pvpFireElementResistPercenttree);
        }

        private function _pvpNeutralElementReductiontreeFunc(input:ICustomDataInput):void
        {
            this.pvpNeutralElementReduction = new CharacterBaseCharacteristic();
            this.pvpNeutralElementReduction.deserializeAsync(this._pvpNeutralElementReductiontree);
        }

        private function _pvpEarthElementReductiontreeFunc(input:ICustomDataInput):void
        {
            this.pvpEarthElementReduction = new CharacterBaseCharacteristic();
            this.pvpEarthElementReduction.deserializeAsync(this._pvpEarthElementReductiontree);
        }

        private function _pvpWaterElementReductiontreeFunc(input:ICustomDataInput):void
        {
            this.pvpWaterElementReduction = new CharacterBaseCharacteristic();
            this.pvpWaterElementReduction.deserializeAsync(this._pvpWaterElementReductiontree);
        }

        private function _pvpAirElementReductiontreeFunc(input:ICustomDataInput):void
        {
            this.pvpAirElementReduction = new CharacterBaseCharacteristic();
            this.pvpAirElementReduction.deserializeAsync(this._pvpAirElementReductiontree);
        }

        private function _pvpFireElementReductiontreeFunc(input:ICustomDataInput):void
        {
            this.pvpFireElementReduction = new CharacterBaseCharacteristic();
            this.pvpFireElementReduction.deserializeAsync(this._pvpFireElementReductiontree);
        }

        private function _meleeDamageDonePercenttreeFunc(input:ICustomDataInput):void
        {
            this.meleeDamageDonePercent = new CharacterBaseCharacteristic();
            this.meleeDamageDonePercent.deserializeAsync(this._meleeDamageDonePercenttree);
        }

        private function _meleeDamageReceivedPercenttreeFunc(input:ICustomDataInput):void
        {
            this.meleeDamageReceivedPercent = new CharacterBaseCharacteristic();
            this.meleeDamageReceivedPercent.deserializeAsync(this._meleeDamageReceivedPercenttree);
        }

        private function _rangedDamageDonePercenttreeFunc(input:ICustomDataInput):void
        {
            this.rangedDamageDonePercent = new CharacterBaseCharacteristic();
            this.rangedDamageDonePercent.deserializeAsync(this._rangedDamageDonePercenttree);
        }

        private function _rangedDamageReceivedPercenttreeFunc(input:ICustomDataInput):void
        {
            this.rangedDamageReceivedPercent = new CharacterBaseCharacteristic();
            this.rangedDamageReceivedPercent.deserializeAsync(this._rangedDamageReceivedPercenttree);
        }

        private function _weaponDamageDonePercenttreeFunc(input:ICustomDataInput):void
        {
            this.weaponDamageDonePercent = new CharacterBaseCharacteristic();
            this.weaponDamageDonePercent.deserializeAsync(this._weaponDamageDonePercenttree);
        }

        private function _weaponDamageReceivedPercenttreeFunc(input:ICustomDataInput):void
        {
            this.weaponDamageReceivedPercent = new CharacterBaseCharacteristic();
            this.weaponDamageReceivedPercent.deserializeAsync(this._weaponDamageReceivedPercenttree);
        }

        private function _spellDamageDonePercenttreeFunc(input:ICustomDataInput):void
        {
            this.spellDamageDonePercent = new CharacterBaseCharacteristic();
            this.spellDamageDonePercent.deserializeAsync(this._spellDamageDonePercenttree);
        }

        private function _spellDamageReceivedPercenttreeFunc(input:ICustomDataInput):void
        {
            this.spellDamageReceivedPercent = new CharacterBaseCharacteristic();
            this.spellDamageReceivedPercent.deserializeAsync(this._spellDamageReceivedPercenttree);
        }

        private function _spellModificationstreeFunc(input:ICustomDataInput):void
        {
            var length:uint = input.readUnsignedShort();
            var i:uint;
            while (i < length)
            {
                this._spellModificationstree.addChild(this._spellModificationsFunc);
                i++;
            };
        }

        private function _spellModificationsFunc(input:ICustomDataInput):void
        {
            var _item:CharacterSpellModification = new CharacterSpellModification();
            _item.deserialize(input);
            this.spellModifications.push(_item);
        }

        private function _probationTimeFunc(input:ICustomDataInput):void
        {
            this.probationTime = input.readInt();
            if (this.probationTime < 0)
            {
                throw (new Error((("Forbidden value (" + this.probationTime) + ") on element of CharacterCharacteristicsInformations.probationTime.")));
            };
        }


    }
} com.ankamagames.dofus.network.types.game.character.characteristic

