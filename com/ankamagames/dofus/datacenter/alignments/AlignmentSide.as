package com.ankamagames.dofus.datacenter.alignments
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;

    public class AlignmentSide implements IDataCenter 
    {

        public static const MODULE:String = "AlignmentSides";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentSide));
        public static var idAccessors:IdAccessors = new IdAccessors(getAlignmentSideById, getAlignmentSides);

        public var id:int;
        public var nameId:uint;
        public var canConquest:Boolean;
        private var _name:String;


        public static function getAlignmentSideById(id:int):AlignmentSide
        {
            return (GameData.getObject(MODULE, id) as AlignmentSide);
        }

        public static function getAlignmentSides():Array
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
} com.ankamagames.dofus.datacenter.alignments

