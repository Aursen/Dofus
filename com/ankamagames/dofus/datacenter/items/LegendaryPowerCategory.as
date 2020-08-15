package com.ankamagames.dofus.datacenter.items
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.types.IdAccessors;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;

    public class LegendaryPowerCategory implements IDataCenter 
    {

        public static const MODULE:String = "LegendaryPowersCategories";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ItemType));
        public static var idAccessors:IdAccessors = new IdAccessors(getLegendaryPowerCategoryById, getLegendaryPowersCategories);

        public var id:int;
        public var categoryName:String;
        public var categoryOverridable:Boolean;
        public var categorySpells:Vector.<int>;


        public static function getLegendaryPowerCategoryById(id:uint):LegendaryPowerCategory
        {
            return (GameData.getObject(MODULE, id) as LegendaryPowerCategory);
        }

        public static function getLegendaryPowersCategories():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}

