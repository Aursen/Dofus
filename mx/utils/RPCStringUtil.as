package mx.utils
{
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class RPCStringUtil 
    {

        mx_internal static const VERSION:String = "4.16.1.0";


        public static function trim(str:String):String
        {
            if (str == null)
            {
                return ("");
            };
            var startIndex:int;
            while (isWhitespace(str.charAt(startIndex)))
            {
                startIndex++;
            };
            var endIndex:int = (str.length - 1);
            while (isWhitespace(str.charAt(endIndex)))
            {
                endIndex--;
            };
            if (endIndex >= startIndex)
            {
                return (str.slice(startIndex, (endIndex + 1)));
            };
            return ("");
        }

        public static function trimArrayElements(value:String, delimiter:String):String
        {
            var items:Array;
            var len:int;
            var i:int;
            if (((!(value == "")) && (!(value == null))))
            {
                items = value.split(delimiter);
                len = items.length;
                i = 0;
                while (i < len)
                {
                    items[i] = trim(items[i]);
                    i++;
                };
                if (len > 0)
                {
                    value = items.join(delimiter);
                };
            };
            return (value);
        }

        public static function isWhitespace(character:String):Boolean
        {
            switch (character)
            {
                case " ":
                case "\t":
                case "\r":
                case "\n":
                case "\f":
                case " ":
                case " ":
                case "\u2029":
                    return (true);
                default:
                    return (false);
            };
        }

        public static function substitute(str:String, ... rest):String
        {
            var args:Array;
            if (str == null)
            {
                return ("");
            };
            var len:uint = rest.length;
            if (((len == 1) && (rest[0] is Array)))
            {
                args = (rest[0] as Array);
                len = args.length;
            }
            else
            {
                args = rest;
            };
            var i:int;
            while (i < len)
            {
                str = str.replace(new RegExp((("\\{" + i) + "\\}"), "g"), args[i]);
                i++;
            };
            return (str);
        }


    }
}

