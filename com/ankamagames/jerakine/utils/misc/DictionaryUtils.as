package com.ankamagames.jerakine.utils.misc
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;

    public class DictionaryUtils 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StringUtils));


        public static function getLength(d:Dictionary):int
        {
            var length:int;
            var key:Object;
            for (key in d)
            {
                length++;
            };
            return (length);
        }


    }
}

