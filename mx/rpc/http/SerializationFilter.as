package mx.rpc.http
{
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class SerializationFilter 
    {

        mx_internal static var filterForResultFormatTable:Object = {};


        public static function registerFilterForResultFormat(resultFormat:String, filter:SerializationFilter):SerializationFilter
        {
            var old:SerializationFilter = filterForResultFormatTable[resultFormat];
            filterForResultFormatTable[resultFormat] = filter;
            return (old);
        }


        public function deserializeResult(operation:AbstractOperation, result:Object):Object
        {
            return (result);
        }

        public function getRequestContentType(operation:AbstractOperation, obj:Object, contentType:String):String
        {
            return (contentType);
        }

        public function serializeParameters(operation:AbstractOperation, params:Array):Object
        {
            var argNames:Array = operation.argumentNames;
            if (((params == null) || (params.length == 0)))
            {
                return (params);
            };
            if (((argNames == null) || (!(params.length == argNames.length))))
            {
                throw (new ArgumentError((((("HTTPMultiService operation called with " + ((argNames == null) ? 0 : argNames.length)) + " argumentNames and ") + params.length) + " number of parameters.  When argumentNames is specified, it must match the number of arguments passed to the invocation")));
            };
            var obj:Object = new Object();
            var i:int;
            while (i < argNames.length)
            {
                obj[argNames[i]] = params[i];
                i++;
            };
            return (obj);
        }

        public function serializeBody(operation:AbstractOperation, obj:Object):Object
        {
            return (obj);
        }

        public function serializeURL(operation:AbstractOperation, obj:Object, url:String):String
        {
            return (url);
        }


    }
} mx.rpc.http

