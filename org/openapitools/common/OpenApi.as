package org.openapitools.common
{
    import flash.events.EventDispatcher;
    import flash.globalization.DateTimeFormatter;
    import mx.utils.UIDUtil;
    import flash.utils.Dictionary;

    public class OpenApi extends EventDispatcher 
    {

        protected var _apiUsageCredentials:ApiUserCredentials;
        protected var _apiEventNotifier:EventDispatcher;
        protected var _apiInvoker:ApiInvoker;
        protected var _useProxyServer:Boolean = false;
        protected var _dateFormater:DateTimeFormatter;

        public function OpenApi(apiCredentials:ApiUserCredentials, eventDispatcher:EventDispatcher=null)
        {
            this._apiUsageCredentials = apiCredentials;
            this._apiEventNotifier = eventDispatcher;
            this._dateFormater = new DateTimeFormatter("fr-FR");
            this._dateFormater.setDateTimePattern("yyyy-MM-dd'T'HH:mm:ss+00:00");
        }

        protected static function arrayToPathValue(objects:Array):String
        {
            var out:String = "";
            return (objects.join(","));
        }


        public function useProxyServer(value:Boolean, proxyServerUrl:String=null):void
        {
            this._useProxyServer = value;
        }

        protected function getApiInvoker():ApiInvoker
        {
            if (this._apiInvoker == null)
            {
                if (this._apiEventNotifier == null)
                {
                    this._apiEventNotifier = this;
                };
                this._apiInvoker = new ApiInvoker(this._apiUsageCredentials, this._apiEventNotifier, this._useProxyServer);
            };
            return (this._apiInvoker);
        }

        protected function getNewApiInvoker(eventDispatcher:EventDispatcher):ApiInvoker
        {
            return (new ApiInvoker(this._apiUsageCredentials, eventDispatcher, this._useProxyServer));
        }

        protected function getUniqueId():String
        {
            return (UIDUtil.createUID());
        }

        protected function toPathValue(value:Object):String
        {
            if ((value is Array))
            {
                return (arrayToPathValue((value as Array)));
            };
            return ((value == null) ? "" : this.parameterToString(value));
        }

        protected function parameterToString(value:Object):String
        {
            var b:String;
            var o:Object;
            if ((value is Date))
            {
                return (this._dateFormater.formatUTC((value as Date)));
            };
            if ((value is Dictionary))
            {
                b = "";
                for each (o in Dictionary(value))
                {
                    if (b.length > 0)
                    {
                        b = (b + ",");
                    };
                    b = (b + String(o));
                };
                return (b);
            };
            return (value.toString());
        }


    }
} org.openapitools.common

