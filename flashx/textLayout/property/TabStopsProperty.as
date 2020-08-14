package flashx.textLayout.property
{
    import flashx.textLayout.formats.TabStopFormat;
    import __AS3__.vec.Vector;
    import flashx.textLayout.formats.FormatValue;
    import flash.text.engine.TabAlignment;

    [ExcludeClass]
    public class TabStopsProperty extends ArrayProperty 
    {

        private static const _tabStopRegex:RegExp = /([sScCeEdD]?)([^| ]+)(|[^ ]*)?( |$)/g;
        private static const _escapeBackslashRegex:RegExp = /\\\\/g;
        private static const _escapeSpaceRegex:RegExp = /\\ /g;
        private static const _backslashRegex:RegExp = /\\/g;
        private static const _spaceRegex:RegExp = / /g;
        private static const _backslashPlaceholderRegex:RegExp = //g;
        private static const _spacePlaceholderRegex:RegExp = //g;
        private static const _backslashPlaceHolder:String = String.fromCharCode(0xE000);
        private static const _spacePlaceHolder:String = String.fromCharCode(57345);

        public function TabStopsProperty(nameValue:String, defaultValue:Array, inherited:Boolean, categories:Vector.<String>)
        {
            super(nameValue, defaultValue, inherited, categories, TabStopFormat);
        }

        private static function compareTabStopFormats(a:TabStopFormat, b:TabStopFormat):Number
        {
            return ((a.position == b.position) ? 0 : ((a.position < b.position) ? -1 : 1));
        }


        override public function setHelper(currVal:*, newVal:*):*
        {
            var valString:String;
            var result:Object;
            var tabStop:TabStopFormat;
            var position:Number;
            if (((newVal == null) || (newVal == FormatValue.INHERIT)))
            {
                return (newVal);
            };
            var tabStops:Array = (newVal as Array);
            if (tabStops)
            {
                if (!checkArrayTypes(tabStops))
                {
                    Property.errorHandler(this, newVal);
                    return (currVal);
                };
            }
            else
            {
                valString = (newVal as String);
                if (!valString)
                {
                    Property.errorHandler(this, newVal);
                    return (currVal);
                };
                tabStops = new Array();
                valString = valString.replace(_escapeBackslashRegex, _backslashPlaceHolder);
                valString = valString.replace(_escapeSpaceRegex, _spacePlaceHolder);
                _tabStopRegex.lastIndex = 0;
                do 
                {
                    result = _tabStopRegex.exec(valString);
                    if (!result)
                    {
                        break;
                    };
                    tabStop = new TabStopFormat();
                    switch (result[1].toLowerCase())
                    {
                        case "s":
                        case "":
                            tabStop.alignment = TabAlignment.START;
                            break;
                        case "c":
                            tabStop.alignment = TabAlignment.CENTER;
                            break;
                        case "e":
                            tabStop.alignment = TabAlignment.END;
                            break;
                        case "d":
                            tabStop.alignment = TabAlignment.DECIMAL;
                            break;
                    };
                    position = Number(result[2]);
                    if (isNaN(position))
                    {
                        Property.errorHandler(this, newVal);
                        return (currVal);
                    };
                    tabStop.position = position;
                    if (tabStop.alignment == TabAlignment.DECIMAL)
                    {
                        if (result[3] == "")
                        {
                            tabStop.decimalAlignmentToken = ".";
                        }
                        else
                        {
                            tabStop.decimalAlignmentToken = result[3].slice(1).replace(_backslashPlaceholderRegex, "\\");
                            tabStop.decimalAlignmentToken = tabStop.decimalAlignmentToken.replace(_spacePlaceholderRegex, " ");
                        };
                    }
                    else
                    {
                        if (result[3] != "")
                        {
                            Property.errorHandler(this, newVal);
                            return (currVal);
                        };
                    };
                    tabStops.push(tabStop);
                } while (true);
            };
            return (tabStops.sort(compareTabStopFormats));
        }

        override public function toXMLString(val:Object):String
        {
            var tabStop:TabStopFormat;
            var escapedAlignmentToken:String;
            var str:String = "";
            var tabStops:Array = (val as Array);
            for each (tabStop in tabStops)
            {
                if (str.length)
                {
                    str = (str + " ");
                };
                switch (tabStop.alignment)
                {
                    case TabAlignment.START:
                        str = (str + "s");
                        break;
                    case TabAlignment.CENTER:
                        str = (str + "c");
                        break;
                    case TabAlignment.END:
                        str = (str + "e");
                        break;
                    case TabAlignment.DECIMAL:
                        str = (str + "d");
                        break;
                };
                str = (str + tabStop.position.toString());
                if (tabStop.alignment == TabAlignment.DECIMAL)
                {
                    escapedAlignmentToken = tabStop.decimalAlignmentToken.replace(_backslashRegex, "\\\\");
                    escapedAlignmentToken = escapedAlignmentToken.replace(_spaceRegex, "\\ ");
                    str = (str + ("|" + escapedAlignmentToken));
                };
            };
            return (str);
        }


    }
} flashx.textLayout.property

