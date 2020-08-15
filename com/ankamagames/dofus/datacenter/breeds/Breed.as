package com.ankamagames.dofus.datacenter.breeds
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.types.IdAccessors;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.datacenter.spells.SpellVariant;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.dofus.datacenter.appearance.SkinMapping;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import __AS3__.vec.*;

    public class Breed implements IDataCenter 
    {

        public static const MODULE:String = "Breeds";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Breed));
        private static var _skinsForBreed:Array = new Array();
        public static var idAccessors:IdAccessors = new IdAccessors(getBreedById, getBreeds);

        public var id:int;
        public var shortNameId:uint;
        public var longNameId:uint;
        public var descriptionId:uint;
        public var gameplayDescriptionId:uint;
        public var gameplayClassDescriptionId:uint;
        public var maleLook:String;
        public var femaleLook:String;
        public var creatureBonesId:uint;
        public var maleArtwork:int;
        public var femaleArtwork:int;
        public var statsPointsForStrength:Vector.<Vector.<uint>>;
        public var statsPointsForIntelligence:Vector.<Vector.<uint>>;
        public var statsPointsForChance:Vector.<Vector.<uint>>;
        public var statsPointsForAgility:Vector.<Vector.<uint>>;
        public var statsPointsForVitality:Vector.<Vector.<uint>>;
        public var statsPointsForWisdom:Vector.<Vector.<uint>>;
        public var breedSpellsId:Vector.<uint>;
        public var breedRoles:Vector.<BreedRoleByBreed>;
        public var maleColors:Vector.<uint>;
        public var femaleColors:Vector.<uint>;
        public var spawnMap:uint;
        public var complexity:uint;
        public var sortIndex:uint;
        private var _shortName:String;
        private var _longName:String;
        private var _description:String;
        private var _gameplayDescription:String;
        private var _gameplayClassDescription:String;
        private var _allSpellsId:Array;
        private var _breedSpellsVariants:Vector.<Spell>;
        private var _breedSpellVariants:Vector.<SpellVariant>;


        public static function getBreedById(id:int):Breed
        {
            return (GameData.getObject(MODULE, id) as Breed);
        }

        public static function getBreeds():Array
        {
            return (GameData.getObjects(MODULE));
        }

        public static function getBreedFromSkin(skin:int):Breed
        {
            var skinKnown:Object;
            var breed:Breed;
            var look:String;
            var id:int;
            if (!_skinsForBreed.length)
            {
                for each (breed in getBreeds())
                {
                    look = breed.maleLook.split("|")[1];
                    look = look.split(",")[0];
                    _skinsForBreed[look] = breed.id;
                    _skinsForBreed[SkinMapping.getSkinMappingById(int(look)).lowDefId] = breed.id;
                    look = breed.femaleLook.split("|")[1];
                    look = look.split(",")[0];
                    _skinsForBreed[look] = breed.id;
                    _skinsForBreed[SkinMapping.getSkinMappingById(int(look)).lowDefId] = breed.id;
                };
            };
            for (skinKnown in _skinsForBreed)
            {
                if (skinKnown == skin.toString())
                {
                    id = _skinsForBreed[skinKnown];
                };
            };
            return (GameData.getObject(MODULE, id) as Breed);
        }


        public function get name():String
        {
            return (this.shortName);
        }

        public function get shortName():String
        {
            if (!this._shortName)
            {
                this._shortName = I18n.getText(this.shortNameId);
            };
            return (this._shortName);
        }

        public function get longName():String
        {
            if (!this._longName)
            {
                this._longName = I18n.getText(this.longNameId);
            };
            return (this._longName);
        }

        public function get description():String
        {
            if (!this._description)
            {
                this._description = I18n.getText(this.descriptionId);
            };
            return (this._description);
        }

        public function get gameplayDescription():String
        {
            if (!this._gameplayDescription)
            {
                this._gameplayDescription = I18n.getText(this.gameplayDescriptionId);
            };
            return (this._gameplayDescription);
        }

        public function get gameplayClassDescription():String
        {
            if (!this._gameplayClassDescription)
            {
                this._gameplayClassDescription = I18n.getText(this.gameplayClassDescriptionId);
            };
            return (this._gameplayClassDescription);
        }

        public function get allSpellsId():Array
        {
            var variant:SpellVariant;
            var spellId:int;
            if (!this._allSpellsId)
            {
                this._allSpellsId = new Array();
                for each (variant in this.breedSpellVariants)
                {
                    for each (spellId in variant.spellIds)
                    {
                        this._allSpellsId.push(spellId);
                    };
                };
            };
            return (this._allSpellsId);
        }

        public function get breedSpellVariants():Vector.<SpellVariant>
        {
            var spellVariants:Array;
            var variant:SpellVariant;
            if (!this._breedSpellVariants)
            {
                this._breedSpellVariants = new Vector.<SpellVariant>();
                spellVariants = SpellVariant.getSpellVariants();
                for each (variant in spellVariants)
                {
                    if (variant.breedId == this.id)
                    {
                        this._breedSpellVariants.push(variant);
                    };
                };
            };
            return (this._breedSpellVariants);
        }

        public function get femaleLookWithColors():TiphonEntityLook
        {
            var look:TiphonEntityLook = TiphonEntityLook.fromString(this.femaleLook);
            var num:int = this.femaleColors.length;
            var i:int;
            while (i < num)
            {
                look.setColor((i + 1), this.femaleColors[i]);
                i++;
            };
            return (look);
        }

        public function get maleLookWithColors():TiphonEntityLook
        {
            var look:TiphonEntityLook = TiphonEntityLook.fromString(this.maleLook);
            var num:int = this.maleColors.length;
            var i:int;
            while (i < num)
            {
                look.setColor((i + 1), this.maleColors[i]);
                i++;
            };
            return (look);
        }

        public function getStatsPointsNeededForStrength(stat:uint):uint
        {
            var i:*;
            for (i in this.statsPointsForStrength)
            {
                if (stat < this.statsPointsForStrength[i][0])
                {
                    return (this.statsPointsForStrength[(i - 1)][1]);
                };
            };
            return (this.statsPointsForStrength[i][1]);
        }

        public function getStatsPointsNeededForIntelligence(stat:uint):uint
        {
            var i:*;
            for (i in this.statsPointsForIntelligence)
            {
                if (stat < this.statsPointsForIntelligence[i][0])
                {
                    return (this.statsPointsForIntelligence[(i - 1)][1]);
                };
            };
            return (this.statsPointsForIntelligence[i][1]);
        }

        public function getStatsPointsNeededForChance(stat:uint):uint
        {
            var i:*;
            for (i in this.statsPointsForChance)
            {
                if (stat < this.statsPointsForChance[i][0])
                {
                    return (this.statsPointsForChance[(i - 1)][1]);
                };
            };
            return (this.statsPointsForChance[i][1]);
        }

        public function getStatsPointsNeededForAgility(stat:uint):uint
        {
            var i:*;
            for (i in this.statsPointsForAgility)
            {
                if (stat < this.statsPointsForAgility[i][0])
                {
                    return (this.statsPointsForAgility[(i - 1)][1]);
                };
            };
            return (this.statsPointsForAgility[i][1]);
        }

        public function getStatsPointsNeededForVitality(stat:uint):uint
        {
            var i:*;
            for (i in this.statsPointsForVitality)
            {
                if (stat < this.statsPointsForVitality[i][0])
                {
                    return (this.statsPointsForVitality[(i - 1)][1]);
                };
            };
            return (this.statsPointsForVitality[i][1]);
        }

        public function getStatsPointsNeededForWisdom(stat:uint):uint
        {
            var i:*;
            for (i in this.statsPointsForWisdom)
            {
                if (stat < this.statsPointsForWisdom[i][0])
                {
                    return (this.statsPointsForWisdom[(i - 1)][1]);
                };
            };
            return (this.statsPointsForWisdom[i][1]);
        }


    }
}

