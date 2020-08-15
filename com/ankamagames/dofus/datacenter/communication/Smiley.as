package com.ankamagames.dofus.datacenter.communication
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.types.IdAccessors;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;

    public class Smiley implements IDataCenter 
    {

        public static const MODULE:String = "Smileys";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Smiley));
        public static var idAccessors:IdAccessors = new IdAccessors(getSmileyById, getSmileys);

        public var id:uint;
        public var order:uint;
        public var gfxId:String;
        public var forPlayers:Boolean;
        public var triggers:Vector.<String>;
        public var referenceId:uint;
        public var categoryId:uint;


        public static function getSmileyById(id:int):Smiley
        {
            return (GameData.getObject(MODULE, id) as Smiley);
        }

        public static function getSmileys():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}

