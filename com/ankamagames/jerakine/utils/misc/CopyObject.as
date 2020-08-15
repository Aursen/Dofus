package com.ankamagames.jerakine.utils.misc
{
    import __AS3__.vec.Vector;

    public class CopyObject 
    {


        public static function copyObject(o:Object, exclude:Array=null, output:Object=null):Object
        {
            var propertyName:String;
            if (!output)
            {
                output = {};
            };
            var properties:Vector.<String> = DescribeTypeCache.getVariables(o);
            for each (propertyName in properties)
            {
                if (!(((exclude) && (!(exclude.indexOf(propertyName) == -1))) || (propertyName == "prototype")))
                {
                    try
                    {
                        output[propertyName] = o[propertyName];
                    }
                    catch(e:SecurityError)
                    {
                    };
                };
            };
            return (output);
        }


    }
}

