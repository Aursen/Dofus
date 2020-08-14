package com.ankamagames.jerakine.utils.system
{
    import flash.system.LoaderContext;

    public class AirScanner 
    {


        public static function allowByteCodeExecution(pContext:LoaderContext, pVal:Boolean):void
        {
            if (pContext.hasOwnProperty("allowCodeImport"))
            {
                pContext["allowCodeImport"] = pVal;
            }
            else
            {
                pContext["allowLoadBytesCodeExecution"] = pVal;
            };
        }


    }
} com.ankamagames.jerakine.utils.system

