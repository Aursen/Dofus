package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.IPostInit;
    import com.ankamagames.dofus.types.IdAccessors;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;

    public class Dungeon implements IDataCenter, IPostInit 
    {

        public static const MODULE:String = "Dungeons";
        private static var _allDungeons:Array;
        public static var idAccessors:IdAccessors = new IdAccessors(getDungeonById, getAllDungeons);

        public var id:int;
        public var nameId:uint;
        public var optimalPlayerLevel:int;
        public var mapIds:Vector.<Number>;
        public var entranceMapId:Number;
        public var exitMapId:Number;
        private var _name:String;
        private var _undiatricalName:String;


        public static function getDungeonById(id:int):Dungeon
        {
            var dungeon:Dungeon = (GameData.getObject(MODULE, id) as Dungeon);
            return (dungeon);
        }

        public static function getAllDungeons():Array
        {
            if (_allDungeons)
            {
                return (_allDungeons);
            };
            _allDungeons = (GameData.getObjects(MODULE) as Array);
            return (_allDungeons);
        }


        public function get name():String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            };
            return (this._name);
        }

        public function get undiatricalName():String
        {
            if (!this._undiatricalName)
            {
                this._undiatricalName = I18n.getUnDiacriticalText(this.nameId);
            };
            return (this._undiatricalName);
        }

        public function postInit():void
        {
            this.name;
            this.undiatricalName;
        }


    }
}

