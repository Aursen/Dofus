package scopart.raven
{
    import com.adobe.utils.StringUtil;
    import flash.utils.getQualifiedClassName;

    public class RavenUtils 
    {


        public static function uuid4():String
        {
            var result:String = "";
            result = (result + zeroPad(randInt(0, 0xFFFF)));
            result = (result + zeroPad(randInt(0, 0xFFFF)));
            result = (result + zeroPad(randInt(0, 0xFFFF)));
            result = (result + zeroPad((randInt(0, 4095) | 0x4000)));
            result = (result + zeroPad((randInt(0, 16383) | 0x8000)));
            result = (result + zeroPad(randInt(0, 0xFFFF)));
            result = (result + zeroPad(randInt(0, 0xFFFF)));
            result = (result + zeroPad(randInt(0, 0xFFFF)));
            return (result);
        }

        public static function zeroPad(number:Number):String
        {
            return (("0000" + number.toString(16)).substr(-4, 4));
        }

        public static function randInt(min:int, max:int):int
        {
            return (Math.round((min + (Math.random() * (max - min)))));
        }

        public static function parseStackTrace(error:Error):Array
        {
            var element:String;
            var causedFrame:Object;
            var frame:Object;
            var subelements:Array;
            var fileAndLine:String;
            var separator:int;
            var absFile:String;
            var splitFilename:Array;
            var result:Array = new Array();
            var elements:Array = error.getStackTrace().split("\n");
            elements.shift();
            var causedClass:String = RavenUtils.getClassName(error);
            if (causedClass)
            {
                causedFrame = new Object();
                causedFrame["filename"] = (((("Caused by " + causedClass) + "(") + error.message) + ")");
                result.push(causedFrame);
            };
            for each (element in elements)
            {
                frame = new Object();
                subelements = element.split("[");
                frame["function"] = StringUtil.trim(subelements[0]).substr(3);
                if (subelements.length > 1)
                {
                    fileAndLine = String(subelements[1]);
                    separator = fileAndLine.lastIndexOf(":");
                    absFile = fileAndLine.substr(0, separator);
                    splitFilename = absFile.split(/src\/main\/flex\//);
                    frame["abs_path"] = absFile;
                    frame["filename"] = splitFilename[(splitFilename.length - 1)];
                    frame["lineno"] = parseInt(fileAndLine.substr((separator + 1)));
                };
                if (frame["function"])
                {
                    result.push(frame);
                };
            };
            result.reverse();
            return (result);
        }

        public static function getFirstStackTraceLine(error:Error):String
        {
            var element:String;
            var subelements:Array;
            var fct:String;
            var lineno:uint;
            var fileAndLine:String;
            var separator:int;
            var elements:Array = error.getStackTrace().split("\n");
            if (elements.length == 1)
            {
                return (elements[0]);
            };
            var i:uint = 1;
            while (i < elements.length)
            {
                element = elements[i];
                subelements = element.split("[");
                fct = StringUtil.trim(subelements[0]).substr(3);
                if ((((!(fct.indexOf("ErrorManager") == -1)) || (!(fct.indexOf("com.ankamagames.jerakine.logger") == -1))) || (!(fct.indexOf("EventDispatcher") == -1))))
                {
                }
                else
                {
                    if (subelements.length > 1)
                    {
                        fileAndLine = String(subelements[1]);
                        separator = fileAndLine.lastIndexOf(":");
                        lineno = parseInt(fileAndLine.substr((separator + 1)));
                    };
                    if (((fct) && (lineno)))
                    {
                        return ((fct + ":") + lineno);
                    };
                };
                i++;
            };
            return (elements[0]);
        }

        public static function getClassName(object:Object):String
        {
            var fullClassName:String = getQualifiedClassName(object);
            var splittedClassName:Array = fullClassName.split("::");
            return (splittedClassName[1]);
        }

        public static function getModuleName(object:Object):String
        {
            var fullClassName:String = getQualifiedClassName(object);
            var splittedClassName:Array = fullClassName.split("::");
            return (splittedClassName[0]);
        }

        public static function formatTimestamp(date:Date):String
        {
            var result:String = "";
            var month:int = (date.monthUTC + 1);
            result = (result + (date.fullYearUTC + "-"));
            result = (result + ((month < 10) ? (("0" + month) + "-") : (month + "-")));
            result = (result + (date.dateUTC + "T"));
            result = (result + (date.hoursUTC + ":"));
            result = (result + (date.minutesUTC + ":"));
            result = (result + date.secondsUTC);
            return (result);
        }


    }
} scopart.raven

