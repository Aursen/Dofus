package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.berilia.types.data.ApiAction;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;

    public class DofusApiAction extends ApiAction 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DofusApiAction));

        public function DofusApiAction(name:String, actionClass:Class)
        {
            super(name, actionClass, false, 0, 0, false);
        }

        public static function getApiActionByName(name:String):DofusApiAction
        {
            return (_apiActionNameList[name]);
        }

        public static function getApiActionsList():Array
        {
            return (_apiActionNameList);
        }


    }
} com.ankamagames.dofus.misc.utils

