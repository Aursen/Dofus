package mx.utils
{
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class StringUtil 
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
                    items[i] = StringUtil.trim(items[i]);
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
                case "　":
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

        public static function repeat(str:String, n:int):String
        {
            if (n == 0)
            {
                return ("");
            };
            var s:String = str;
            var i:int = 1;
            while (i < n)
            {
                s = (s + str);
                i++;
            };
            return (s);
        }

        public static function restrict(str:String, restrict:String):String
        {
            var charCode:uint;
            if (restrict == null)
            {
                return (str);
            };
            if (restrict == "")
            {
                return ("");
            };
            var charCodes:Array = [];
            var n:int = str.length;
            var i:int;
            while (i < n)
            {
                charCode = str.charCodeAt(i);
                if (testCharacter(charCode, restrict))
                {
                    charCodes.push(charCode);
                };
                i++;
            };
            return (String.fromCharCode.apply(null, charCodes));
        }

        private static function testCharacter(charCode:uint, restrict:String):Boolean
        {
            var code:uint;
            var acceptCode:Boolean;
            var allowIt:Boolean;
            var inBackSlash:Boolean;
            var inRange:Boolean;
            var setFlag:Boolean = true;
            var lastCode:uint;
            var n:int = restrict.length;
            if (n > 0)
            {
                code = restrict.charCodeAt(0);
                if (code == 94)
                {
                    allowIt = true;
                };
            };
            var i:int;
            while (i < n)
            {
                code = restrict.charCodeAt(i);
                acceptCode = false;
                if (!inBackSlash)
                {
                    if (code == 45)
                    {
                        inRange = true;
                    }
                    else
                    {
                        if (code == 94)
                        {
                            setFlag = (!(setFlag));
                        }
                        else
                        {
                            if (code == 92)
                            {
                                inBackSlash = true;
                            }
                            else
                            {
                                acceptCode = true;
                            };
                        };
                    };
                }
                else
                {
                    acceptCode = true;
                    inBackSlash = false;
                };
                if (acceptCode)
                {
                    if (inRange)
                    {
                        if (((lastCode <= charCode) && (charCode <= code)))
                        {
                            allowIt = setFlag;
                        };
                        inRange = false;
                        lastCode = 0;
                    }
                    else
                    {
                        if (charCode == code)
                        {
                            allowIt = setFlag;
                        };
                        lastCode = code;
                    };
                };
                i++;
            };
            return (allowIt);
        }


    }
} mx.utils

