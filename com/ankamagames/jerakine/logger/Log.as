package com.ankamagames.jerakine.logger
{
    import com.ankamagames.jerakine.logger.targets.TargetsPreparator;
    import com.ankamagames.jerakine.logger.targets.TemporaryBufferTarget;
    import com.ankamagames.jerakine.logger.targets.LoggingTarget;
    import flash.utils.Dictionary;
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.logger.targets.SentryTarget;
    import flash.utils.getDefinitionByName;
    import com.ankamagames.jerakine.logger.targets.ConfigurableLoggingTarget;
    import com.ankamagames.jerakine.logger.targets.AbstractTarget;
    import com.ankamagames.jerakine.logger.targets.*;

    public final class Log 
    {

        protected static const _preparator:TargetsPreparator = null;
        private static var _tempTarget:TemporaryBufferTarget;
        private static var _initializing:Boolean;
        private static var _manualInit:Boolean;
        private static var _targets:Array = new Array();
        private static var _sentryTarget:LoggingTarget;
        private static var _loggers:Dictionary = new Dictionary();
        private static var _dispatcher:EventDispatcher = new EventDispatcher();
        private static var _configfile:String = "";
        public static var PREFIX:String = "";
        protected static var _log:Logger;
        public static var exitIfNoConfigFile:Boolean = true;


        public static function get CONFIG_FILE():String
        {
            return (_configfile);
        }

        public static function initFromString(xml:String):void
        {
            _manualInit = true;
            _initializing = true;
            parseConfiguration(new XML(xml));
            LogLogger.activeLog(true);
        }

        public static function getLogger(category:String, configFile:String="log4as.xml"):Logger
        {
            var xmlLoader:URLLoader;
            var logger:LogLogger;
            if (!_initializing)
            {
                _initializing = true;
                _configfile = configFile;
                _tempTarget = new TemporaryBufferTarget();
                addTarget(_tempTarget);
                xmlLoader = new URLLoader();
                xmlLoader.addEventListener(Event.COMPLETE, completeHandler);
                xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
                xmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
                try
                {
                    xmlLoader.load(new URLRequest(_configfile));
                    _log = Log.getLogger(getQualifiedClassName(Log));
                }
                catch(e:Error)
                {
                };
            };
            if (_loggers[category] != null)
            {
                return (_loggers[category]);
            };
            logger = new LogLogger(category);
            _loggers[category] = logger;
            return (logger);
        }

        public static function addTarget(target:LoggingTarget):void
        {
            if (containsTarget(target))
            {
                return;
            };
            _dispatcher.addEventListener(LogEvent.LOG_EVENT, target.onLog);
            _targets.push(target);
            if ((target is SentryTarget))
            {
                _sentryTarget = target;
            };
        }

        public static function deactivateLevel(level:uint, deactive:Boolean):void
        {
            var logger:LogLogger;
            for each (logger in _loggers)
            {
                logger.setLevelDectivation(level, deactive);
            };
        }

        public static function removeTargetType(qualifiedClassName:String):void
        {
            var target:LoggingTarget;
            var i:int;
            var targetToDelete:Array = new Array();
            for each (target in _targets)
            {
                if (getQualifiedClassName(target) == qualifiedClassName)
                {
                    targetToDelete.push(target);
                };
            };
            if (targetToDelete.length > 0)
            {
                i = 0;
                while (i < targetToDelete.length)
                {
                    removeTarget(targetToDelete[i]);
                    i++;
                };
            };
        }

        public static function removeTarget(target:LoggingTarget):void
        {
            var index:int = _targets.indexOf(target);
            if (index > -1)
            {
                _dispatcher.removeEventListener(LogEvent.LOG_EVENT, target.onLog);
                _targets.splice(index, 1);
            };
        }

        private static function containsTarget(target:LoggingTarget):Boolean
        {
            return (_targets.indexOf(target) > -1);
        }

        private static function parseConfiguration(config:XML):void
        {
            var filter:XML;
            var target:XML;
            var allow:Boolean;
            var ltf:LogTargetFilter;
            var x:XMLList;
            var moduleClass:Object;
            var targetInstance:LoggingTarget;
            var filters:Array = new Array();
            for each (filter in config..filter)
            {
                allow = true;
                try
                {
                    x = filter.attribute("allow");
                    if (x.length() > 0)
                    {
                        allow = (filter.@allow == "true");
                    };
                }
                catch(e:Error)
                {
                };
                ltf = new LogTargetFilter(filter.@value, allow);
                filters.push(ltf);
            };
            for each (target in config..target)
            {
                try
                {
                    moduleClass = getDefinitionByName(target.@module);
                    targetInstance = new ((moduleClass as Class))();
                    targetInstance.filters = filters;
                    if (((target.hasComplexContent()) && (targetInstance is ConfigurableLoggingTarget)))
                    {
                        ConfigurableLoggingTarget(targetInstance).configure(target);
                    };
                    addTarget(targetInstance);
                }
                catch(ife:InvalidFilterError)
                {
                    _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log", ife.getStackTrace(), LogLevel.WARN));
                    _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log", "Filtre invalide.", LogLevel.WARN));
                }
                catch(re:ReferenceError)
                {
                    _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log", re.getStackTrace(), LogLevel.WARN));
                    _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log", (("Module " + target.@module) + " introuvable."), LogLevel.WARN));
                };
            };
        }

        private static function configurationFileMissing(txt:String):void
        {
            _log.warn(txt);
            if (exitIfNoConfigFile)
            {
                LogLogger.activeLog(false);
            };
            flushBuffer();
        }

        private static function flushBuffer():void
        {
            var target:AbstractTarget;
            var bufferedEvent:LogEvent;
            var bufferedEvents:Array = _tempTarget.getBuffer();
            removeTarget(_tempTarget);
            for each (target in _targets)
            {
                if ((target is TemporaryBufferTarget))
                {
                    TemporaryBufferTarget(target).clearBuffer();
                    break;
                };
            };
            for each (bufferedEvent in bufferedEvents)
            {
                _dispatcher.dispatchEvent(bufferedEvent.clone());
            };
            _tempTarget.clearBuffer();
            _tempTarget = null;
        }

        internal static function broadcastToTargets(event:LogEvent):void
        {
            _dispatcher.dispatchEvent(event);
        }

        internal static function broadcastToSentryTarget(event:LogEvent):void
        {
            if (_sentryTarget != null)
            {
                _sentryTarget.onLog(event);
            };
        }

        private static function completeHandler(e:Event):void
        {
            try
            {
                parseConfiguration(new XML(URLLoader(e.target).data));
            }
            catch(e:Error)
            {
            };
            flushBuffer();
        }

        private static function ioErrorHandler(ioe:IOErrorEvent):void
        {
            if (_manualInit)
            {
                return;
            };
            configurationFileMissing((("Missing " + _configfile) + " file."));
        }

        private static function securityErrorHandler(se:SecurityErrorEvent):void
        {
            if (_manualInit)
            {
                return;
            };
            configurationFileMissing((("Can't load " + _configfile) + " file : forbidden by sandbox."));
        }


    }
} com.ankamagames.jerakine.logger

