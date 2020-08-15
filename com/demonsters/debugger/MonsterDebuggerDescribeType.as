package com.demonsters.debugger
{
    import flash.utils.getQualifiedClassName;
    import flash.utils.describeType;
    import com.demonsters.debugger.*;

    internal class MonsterDebuggerDescribeType 
    {

        private static var cache:Object = {};


        internal static function get(object:*):XML
        {
            var key:String = getQualifiedClassName(object);
            if ((key in cache))
            {
                return (cache[key]);
            };
            var xml:XML = describeType(object);
            cache[key] = xml;
            return (xml);
        }


    }
}

