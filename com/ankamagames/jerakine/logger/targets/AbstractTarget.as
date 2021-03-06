package com.ankamagames.jerakine.logger.targets
{
    import com.ankamagames.jerakine.logger.InvalidFilterError;
    import com.ankamagames.jerakine.logger.LogEvent;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.LogTargetFilter;

    public class AbstractTarget implements LoggingTarget 
    {

        private static const FILTERS_FORBIDDEN_CHARS:String = "[]~$^&/(){}<>+=`!#%?,:;'\"@";

        private var _loggers:Array = new Array();
        private var _filters:Array = new Array();


        public function set filters(value:Array):void
        {
            if (!this.checkIsFiltersValid(value))
            {
                throw (new InvalidFilterError(("These characters are invalid on a filter : " + FILTERS_FORBIDDEN_CHARS)));
            };
            this._filters = value;
        }

        public function get filters():Array
        {
            return (this._filters);
        }

        public function logEvent(event:LogEvent):void
        {
        }

        public function addLogger(logger:Logger):void
        {
            this._loggers.push(logger);
        }

        public function removeLogger(logger:Logger):void
        {
            var index:int = this._loggers.indexOf(logger);
            if (index > -1)
            {
                this._loggers.splice(index, 1);
            };
        }

        private function checkIsFiltersValid(filters:Array):Boolean
        {
            var filter:LogTargetFilter;
            for each (filter in filters)
            {
                if (!this.checkIsFilterValid(filter.target))
                {
                    return (false);
                };
            };
            return (true);
        }

        private function checkIsFilterValid(filter:String):Boolean
        {
            var i:int;
            while (i < FILTERS_FORBIDDEN_CHARS.length)
            {
                if (filter.indexOf(FILTERS_FORBIDDEN_CHARS.charAt(i)) > -1)
                {
                    return (false);
                };
                i++;
            };
            return (true);
        }

        public function onLog(e:LogEvent):void
        {
            var filter:LogTargetFilter;
            var reg:RegExp;
            var testResult:Boolean;
            var passing:Boolean;
            if (this._filters.length > 0)
            {
                for each (filter in this._filters)
                {
                    reg = new RegExp(filter.target.replace("*", ".*"), "i");
                    testResult = reg.test(e.category);
                    if (((e.category == filter.target) && (!(filter.allow))))
                    {
                        passing = false;
                        break;
                    };
                    if (((testResult) && (filter.allow)))
                    {
                        passing = true;
                    };
                };
            }
            else
            {
                passing = true;
            };
            if (passing)
            {
                this.logEvent(e);
            };
        }


    }
}

