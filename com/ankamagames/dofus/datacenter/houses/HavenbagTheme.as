package com.ankamagames.dofus.datacenter.houses
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.misc.utils.GameDataQuery;
    import __AS3__.vec.*;

    public class HavenbagTheme implements IDataCenter 
    {

        public static const MODULE:String = "HavenbagThemes";
        private static var _mapIds:Vector.<Number>;
        public static var idAccessors:IdAccessors = new IdAccessors(getTheme, getAllThemes);

        public var id:int;
        public var nameId:int;
        public var mapId:Number;
        private var _name:String;
        private var _furnitureIds:Vector.<uint>;


        public static function getTheme(id:int):HavenbagTheme
        {
            return (GameData.getObject(MODULE, id) as HavenbagTheme);
        }

        public static function getAllThemes():Array
        {
            return (GameData.getObjects(MODULE));
        }

        public static function isMapIdInHavenbag(mapId:Number):Boolean
        {
            var tmpArr:Array;
            var i:int;
            if (!_mapIds)
            {
                tmpArr = getAllThemes();
                _mapIds = new Vector.<Number>(tmpArr.length, true);
                i = 0;
                while (i < tmpArr.length)
                {
                    _mapIds[i] = tmpArr[i].mapId;
                    i++;
                };
            };
            return (!(_mapIds.indexOf(mapId) == -1));
        }


        public function get name():String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            };
            return (this._name);
        }

        public function get furnitureIds():Vector.<uint>
        {
            if (!this._furnitureIds)
            {
                this._furnitureIds = GameDataQuery.queryEquals(HavenbagFurniture, "themeId", this.id);
            };
            return (this._furnitureIds);
        }


    }
} com.ankamagames.dofus.datacenter.houses

