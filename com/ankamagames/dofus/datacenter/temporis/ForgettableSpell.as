package com.ankamagames.dofus.datacenter.temporis
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;

    public class ForgettableSpell implements IDataCenter 
    {

        public static const MODULE:String = "ForgettableSpells";
        public static var idAccessors:IdAccessors = new IdAccessors(getForgettableSpellById, getForgettableSpells);

        public var id:int;
        public var pairId:int;
        public var itemId:int;


        public static function getForgettableSpellById(id:int):ForgettableSpell
        {
            return (GameData.getObject(MODULE, id) as ForgettableSpell);
        }

        public static function getForgettableSpellByScrollId(scrollId:int):ForgettableSpell
        {
            var forgettableSpell:ForgettableSpell;
            var forgettableSpells:Array = getForgettableSpells();
            for each (forgettableSpell in forgettableSpells)
            {
                if (forgettableSpell.itemId === scrollId)
                {
                    return (forgettableSpell);
                };
            };
            return (null);
        }

        public static function getForgettableSpells():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
} com.ankamagames.dofus.datacenter.temporis

