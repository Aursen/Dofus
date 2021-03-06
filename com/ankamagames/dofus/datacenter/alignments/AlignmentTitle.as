package com.ankamagames.dofus.datacenter.alignments
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.types.IdAccessors;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;

    public class AlignmentTitle implements IDataCenter 
    {

        public static const MODULE:String = "AlignmentTitles";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentTitle));
        public static var idAccessors:IdAccessors = new IdAccessors(getAlignmentTitlesById, getAlignmentTitles);

        public var sideId:int;
        public var namesId:Vector.<int>;
        public var shortsId:Vector.<int>;


        public static function getAlignmentTitlesById(id:int):AlignmentTitle
        {
            return (GameData.getObject(MODULE, id) as AlignmentTitle);
        }

        public static function getAlignmentTitles():Array
        {
            return (GameData.getObjects(MODULE));
        }


        public function getNameFromGrade(grade:int):String
        {
            return (I18n.getText(this.namesId[grade]));
        }

        public function getShortNameFromGrade(grade:int):String
        {
            return (I18n.getText(this.shortsId[grade]));
        }


    }
}

