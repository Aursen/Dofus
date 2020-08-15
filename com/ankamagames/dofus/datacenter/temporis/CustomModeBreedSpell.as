package com.ankamagames.dofus.datacenter.temporis
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class CustomModeBreedSpell implements IDataCenter 
    {

        public static const MODULE:String = "CustomModeBreedSpells";
        private static var _allSpellsId:Array = null;
        public static var idAccessors:IdAccessors = new IdAccessors(getCustomModeBreedSpellById, getCustomModeBreedSpells);

        public var id:int;
        public var pairId:int;
        public var breedId:int;
        public var isInitialSpell:Boolean;
        public var isHidden:Boolean;


        public static function getCustomModeBreedSpellById(id:int):CustomModeBreedSpell
        {
            return (GameData.getObject(MODULE, id) as CustomModeBreedSpell);
        }

        public static function getCustomModeBreedSpells():Array
        {
            return (GameData.getObjects(MODULE));
        }

        public static function getAllCustomModeBreedSpellIds():Array
        {
            var customModeBreedSpells:Array;
            var index:uint;
            if (_allSpellsId === null)
            {
                _allSpellsId = [];
                customModeBreedSpells = getCustomModeBreedSpells();
                index = 0;
                while (index < customModeBreedSpells.length)
                {
                    _allSpellsId.push(customModeBreedSpells[index].id);
                    index++;
                };
            };
            return (_allSpellsId);
        }

        public static function getCustomModeBreedSpellIds(breedId:int):Array
        {
            var index:uint;
            var toReturn:Array = [];
            var customModeBreedSpells:Array = getCustomModeBreedSpells();
            var currentCustomModeBreedSpell:CustomModeBreedSpell;
            index = 0;
            while (index < customModeBreedSpells.length)
            {
                currentCustomModeBreedSpell = customModeBreedSpells[index];
                if (currentCustomModeBreedSpell.breedId === breedId)
                {
                    toReturn.push(currentCustomModeBreedSpell.id);
                };
                index++;
            };
            return (toReturn);
        }

        public static function getCustomModeBreedSpellList(breedId:int):Array
        {
            var index:uint;
            var toReturn:Array = [];
            var customModeBreedSpells:Array = getCustomModeBreedSpells();
            var currentCustomModeBreedSpell:CustomModeBreedSpell;
            index = 0;
            while (index < customModeBreedSpells.length)
            {
                currentCustomModeBreedSpell = customModeBreedSpells[index];
                if (currentCustomModeBreedSpell.breedId === breedId)
                {
                    toReturn.push(currentCustomModeBreedSpell);
                };
                index++;
            };
            return (toReturn);
        }


    }
}

