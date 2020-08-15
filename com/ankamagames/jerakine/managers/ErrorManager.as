package com.ankamagames.jerakine.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.events.EventDispatcher;
    import com.ankamagames.jerakine.utils.errors.Result;
    import com.ankamagames.jerakine.types.events.ErrorReportedEvent;
    import flash.system.ApplicationDomain;
    import flash.display.LoaderInfo;
    import flash.events.ErrorEvent;

    public class ErrorManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ErrorManager));
        public static var showPopup:Boolean = false;
        public static var eventDispatcher:EventDispatcher = new EventDispatcher();


        public static function tryFunction(fct:Function, params:Array=null, complementaryInformations:String="", context:Object=null):Result
        {
            var result:Result;
            var tags:Object;
            var i:int;
            var param:* = undefined;
            var paramToString:String;
            result = new Result();
            if (!eventDispatcher.hasEventListener(ErrorReportedEvent.ERROR))
            {
                result.result = fct.apply(context, params);
                result.success = true;
            }
            else
            {
                try
                {
                    result.result = fct.apply(context, params);
                    result.success = true;
                }
                catch(e:Error)
                {
                    result.success = false;
                    result.stackTrace = ((e.message + " : \n") + e.getStackTrace());
                    tags = new Object();
                    if (params)
                    {
                        i = 0;
                        while (i < params.length)
                        {
                            param = params[i];
                            paramToString = ((param) ? param.toString() : "null");
                            if (!paramToString)
                            {
                                paramToString = '""';
                            };
                            tags[("param" + int((i + 1)))] = paramToString.replace("\n", "\\n");
                            i = (i + 1);
                        };
                    };
                    addError(complementaryInformations, e, showPopup, tags);
                };
            };
            return (result);
        }

        public static function addError(txt:String="", error:Error=null, show:Boolean=true, tags:Object=null):void
        {
            var dynamicVar:String;
            if (!error)
            {
                error = new Error();
            };
            eventDispatcher.dispatchEvent(new ErrorReportedEvent(error, txt, show, tags));
            var errorLog:* = (("Error : '" + txt) + "'");
            if (tags)
            {
                errorLog = (errorLog + " with parameters : [");
                for (dynamicVar in tags)
                {
                    errorLog = (errorLog + (tags[dynamicVar] + ","));
                };
                errorLog = (errorLog.substr(0, (errorLog.length - 1)) + "]");
            };
            _log.warn(errorLog);
        }

        public static function registerLoaderInfo(loaderInfo:LoaderInfo):void
        {
            if (!ApplicationDomain.currentDomain.hasDefinition("flash.events::UncaughtErrorEvent"))
            {
                return;
            };
            var UncaughtErrorEvent:Object = ApplicationDomain.currentDomain.getDefinition("flash.events::UncaughtErrorEvent");
            loaderInfo["uncaughtErrorEvents"].addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError, false, 0, true);
        }

        public static function onUncaughtError(event:Object):void
        {
            var text:String;
            var error:Error;
            event.preventDefault();
            if ((event.error is Error))
            {
                text = Error(event.error).message;
                error = event.error;
            }
            else
            {
                if ((event.error is ErrorEvent))
                {
                    text = ErrorEvent(event.error).text;
                    error = new Error(text);
                }
                else
                {
                    text = event.error.toString();
                    error = new Error(text);
                };
            };
            addError(text, error, showPopup);
        }


    }
}

