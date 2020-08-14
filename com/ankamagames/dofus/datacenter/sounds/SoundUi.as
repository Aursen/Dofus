package com.ankamagames.dofus.datacenter.sounds
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;

    public class SoundUi implements IDataCenter 
    {

        public static var MODULE:String = "SoundUi";
        public static var idAccessors:IdAccessors = new IdAccessors(getSoundUiById, getSoundUis);

        public var id:uint;
        public var uiName:String;
        public var openFile:String;
        public var closeFile:String;
        public var subElements:Vector.<SoundUiElement>;


        public static function getSoundUiById(id:uint):SoundUi
        {
            var sb:SoundUi = (GameData.getObject(MODULE, id) as SoundUi);
            return (sb);
        }

        public static function getSoundUis():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
} com.ankamagames.dofus.datacenter.sounds

