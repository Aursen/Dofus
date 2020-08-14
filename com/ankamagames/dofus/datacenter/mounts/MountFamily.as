package com.ankamagames.dofus.datacenter.mounts
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;

    public class MountFamily implements IDataCenter 
    {

        private static const MODULE:String = "MountFamily";
        public static var idAccessors:IdAccessors = new IdAccessors(getMountFamilyById, getMountFamilies);

        public var id:uint;
        public var nameId:uint;
        public var headUri:String;
        private var _name:String;


        public static function getMountFamilyById(id:uint):MountFamily
        {
            return (GameData.getObject(MODULE, id) as MountFamily);
        }

        public static function getMountFamilies():Array
        {
            return (GameData.getObjects(MODULE));
        }


        public function get name():String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            };
            return (this._name);
        }


    }
} com.ankamagames.dofus.datacenter.mounts

