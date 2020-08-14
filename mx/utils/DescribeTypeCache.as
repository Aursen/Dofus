package mx.utils
{
    import mx.core.mx_internal;
    import flash.utils.getQualifiedClassName;
    import flash.utils.getDefinitionByName;
    import flash.utils.describeType;
    import mx.binding.BindabilityInfo;

    use namespace mx_internal;

    [ExcludeClass]
    public class DescribeTypeCache 
    {

        mx_internal static const VERSION:String = "4.16.1.0";
        private static var typeCache:Object = {};
        private static var cacheHandlers:Object = {};

        {
            registerCacheHandler("bindabilityInfo", bindabilityInfoHandler);
        }


        public static function describeType(o:*):DescribeTypeCacheRecord
        {
            var className:String;
            var cacheKey:String;
            var typeDescription:XML;
            var record:DescribeTypeCacheRecord;
            if ((o is String))
            {
                cacheKey = (className = o);
            }
            else
            {
                cacheKey = (className = getQualifiedClassName(o));
            };
            if ((o is Class))
            {
                cacheKey = (cacheKey + "$");
            };
            if ((cacheKey in typeCache))
            {
                return (typeCache[cacheKey]);
            };
            if ((o is String))
            {
                try
                {
                    o = getDefinitionByName(o);
                }
                catch(error:ReferenceError)
                {
                };
            };
            typeDescription = flash.utils.describeType(o);
            record = new DescribeTypeCacheRecord();
            record.typeDescription = typeDescription;
            record.typeName = className;
            typeCache[cacheKey] = record;
            return (record);
        }

        public static function registerCacheHandler(valueName:String, handler:Function):void
        {
            cacheHandlers[valueName] = handler;
        }

        internal static function extractValue(valueName:String, record:DescribeTypeCacheRecord):*
        {
            if ((valueName in cacheHandlers))
            {
                return (cacheHandlers[valueName](record));
            };
            return (undefined);
        }

        private static function bindabilityInfoHandler(record:DescribeTypeCacheRecord):*
        {
            return (new BindabilityInfo(record.typeDescription));
        }


    }
} mx.utils

