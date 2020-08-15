package mx.formatters
{
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class DateFormatter extends Formatter 
    {

        mx_internal static const VERSION:String = "4.16.1.0";
        private static const VALID_PATTERN_CHARS:String = "Y,M,D,A,E,H,J,K,L,N,S,Q,O,Z";

        private var _formatString:String;
        private var formatStringOverride:String;

        public function DateFormatter(formatString:String=null)
        {
            this.formatString = formatString;
        }

        public static function parseDateString(str:String, format:String=null):Date
        {
            var word:String;
            var n:int;
            var i:int;
            var s:String;
            var numbers:String;
            var num:int;
            var monthFirst:Boolean;
            if (((!(str)) || (str == "")))
            {
                return (null);
            };
            var year:int = -1;
            var mon:int = -1;
            var day:int = -1;
            var hour:int = -1;
            var min:int = -1;
            var sec:int = -1;
            var milli:int = -1;
            var letter:String = "";
            var marker:Object = 0;
            var count:int;
            var len:int;
            var isPM:Boolean;
            var punctuation:Object = {};
            var ampm:Object = {};
            punctuation["/"] = {
                "general":true,
                "date":true,
                "time":false
            };
            punctuation[":"] = {
                "general":true,
                "date":false,
                "time":true
            };
            punctuation[" "] = {
                "general":true,
                "date":true,
                "time":false
            };
            punctuation["."] = {
                "general":true,
                "date":true,
                "time":true
            };
            punctuation[","] = {
                "general":true,
                "date":true,
                "time":false
            };
            punctuation["+"] = {
                "general":true,
                "date":false,
                "time":false
            };
            punctuation["-"] = {
                "general":true,
                "date":true,
                "time":false
            };
            punctuation["年"] = {
                "general":true,
                "date":true,
                "time":false
            };
            punctuation["月"] = {
                "general":true,
                "date":true,
                "time":false
            };
            punctuation["日"] = {
                "general":true,
                "date":true,
                "time":false
            };
            punctuation["午"] = {
                "general":false,
                "date":false,
                "time":true
            };
            punctuation["년"] = {
                "general":true,
                "date":true,
                "time":false
            };
            punctuation["월"] = {
                "general":true,
                "date":true,
                "time":false
            };
            punctuation["일"] = {
                "general":true,
                "date":true,
                "time":false
            };
            ampm["PM"] = true;
            ampm["pm"] = true;
            ampm["㏘"] = true;
            ampm["μμ"] = true;
            ampm["午後"] = true;
            ampm["上午"] = true;
            ampm["오후"] = true;
            var timezoneRegEx:RegExp = /(GMT|UTC)((\+|-)\d\d\d\d )?/ig;
            str = str.replace(timezoneRegEx, "");
            len = str.length;
            while (count < len)
            {
                letter = str.charAt(count);
                count++;
                if (((letter <= " ") || (letter == ",")))
                {
                }
                else
                {
                    if (((punctuation.hasOwnProperty(letter)) && (punctuation[letter].general)))
                    {
                        marker = letter;
                    }
                    else
                    {
                        if (!((("0" <= letter) && (letter <= "9")) || ((punctuation.hasOwnProperty(letter)) && (punctuation[letter].general))))
                        {
                            word = letter;
                            while (count < len)
                            {
                                letter = str.charAt(count);
                                if (((("0" <= letter) && (letter <= "9")) || ((punctuation.hasOwnProperty(letter)) && (punctuation[letter].general))))
                                {
                                    break;
                                };
                                word = (word + letter);
                                count++;
                            };
                            n = DateBase.defaultStringKey.length;
                            i = 0;
                            while (i < n)
                            {
                                s = String(DateBase.defaultStringKey[i]);
                                if (((s.toLowerCase() == word.toLowerCase()) || (s.toLowerCase().substr(0, 3) == word.toLowerCase())))
                                {
                                    if (i == 13)
                                    {
                                        if (((hour > 12) || (hour < 1)))
                                        {
                                            break;
                                        };
                                        if (hour < 12)
                                        {
                                            hour = (hour + 12);
                                        };
                                    }
                                    else
                                    {
                                        if (i == 12)
                                        {
                                            if (((hour > 12) || (hour < 1)))
                                            {
                                                break;
                                            };
                                            if (hour == 12)
                                            {
                                                hour = 0;
                                            };
                                        }
                                        else
                                        {
                                            if (i < 12)
                                            {
                                                if (mon < 0)
                                                {
                                                    mon = i;
                                                }
                                                else
                                                {
                                                    break;
                                                };
                                            };
                                        };
                                    };
                                    break;
                                };
                                i++;
                            };
                            marker = 0;
                            if (ampm.hasOwnProperty(word))
                            {
                                isPM = true;
                                if (hour > 12)
                                {
                                    break;
                                };
                                if (((hour >= 0) && (hour < 12)))
                                {
                                    hour = (hour + 12);
                                };
                            };
                        }
                        else
                        {
                            if ((("0" <= letter) && (letter <= "9")))
                            {
                                numbers = letter;
                                while (((("0" <= (letter = str.charAt(count))) && (letter <= "9")) && (count < len)))
                                {
                                    numbers = (numbers + letter);
                                    count++;
                                };
                                num = int(numbers);
                                if (((num >= 70) && (!(((punctuation.hasOwnProperty(letter)) && (punctuation[letter].time)) && (sec >= 0)))))
                                {
                                    if (year != -1)
                                    {
                                        break;
                                    };
                                    if ((((punctuation.hasOwnProperty(letter)) && (punctuation[letter].date)) || (count >= len)))
                                    {
                                        year = num;
                                    }
                                    else
                                    {
                                        break;
                                    };
                                }
                                else
                                {
                                    if (((punctuation.hasOwnProperty(letter)) && (punctuation[letter].date)))
                                    {
                                        monthFirst = (!(year == -1));
                                        if (format)
                                        {
                                            monthFirst = ((monthFirst) || (format.search("M") < format.search("D")));
                                        };
                                        if (((monthFirst) && (mon < 0)))
                                        {
                                            mon = (num - 1);
                                        }
                                        else
                                        {
                                            if (day < 0)
                                            {
                                                day = num;
                                            }
                                            else
                                            {
                                                if (((!(monthFirst)) && (mon < 0)))
                                                {
                                                    mon = (num - 1);
                                                }
                                                else
                                                {
                                                    if (min < 0)
                                                    {
                                                        min = num;
                                                    }
                                                    else
                                                    {
                                                        if (sec < 0)
                                                        {
                                                            sec = num;
                                                        }
                                                        else
                                                        {
                                                            if (milli < 0)
                                                            {
                                                                milli = num;
                                                            }
                                                            else
                                                            {
                                                                break;
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    }
                                    else
                                    {
                                        if (((punctuation.hasOwnProperty(letter)) && (punctuation[letter].time)))
                                        {
                                            if (hour < 0)
                                            {
                                                hour = num;
                                                if (isPM)
                                                {
                                                    if (hour > 12)
                                                    {
                                                        break;
                                                    };
                                                    if (((hour >= 0) && (hour < 12)))
                                                    {
                                                        hour = (hour + 12);
                                                    };
                                                };
                                            }
                                            else
                                            {
                                                if (min < 0)
                                                {
                                                    min = num;
                                                }
                                                else
                                                {
                                                    if (sec < 0)
                                                    {
                                                        sec = num;
                                                    }
                                                    else
                                                    {
                                                        if (milli < 0)
                                                        {
                                                            milli = num;
                                                        }
                                                        else
                                                        {
                                                            break;
                                                        };
                                                    };
                                                };
                                            };
                                        }
                                        else
                                        {
                                            if (((hour >= 0) && (min < 0)))
                                            {
                                                min = num;
                                            }
                                            else
                                            {
                                                if (((min >= 0) && (sec < 0)))
                                                {
                                                    sec = num;
                                                }
                                                else
                                                {
                                                    if (((sec >= 0) && (milli < 0)))
                                                    {
                                                        milli = num;
                                                    }
                                                    else
                                                    {
                                                        if (day < 0)
                                                        {
                                                            day = num;
                                                        }
                                                        else
                                                        {
                                                            if ((((year < 0) && (mon >= 0)) && (day >= 0)))
                                                            {
                                                                year = (2000 + num);
                                                            }
                                                            else
                                                            {
                                                                break;
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                                marker = 0;
                            };
                        };
                    };
                };
            };
            if ((((((year < 0) || (mon < 0)) || (mon > 11)) || (day < 1)) || (day > 31)))
            {
                return (null);
            };
            if (milli < 0)
            {
                milli = 0;
            };
            if (sec < 0)
            {
                sec = 0;
            };
            if (min < 0)
            {
                min = 0;
            };
            if (hour < 0)
            {
                hour = 0;
            };
            var newDate:Date = new Date(year, mon, day, hour, min, sec, milli);
            if (((!(day == newDate.getDate())) || (!(mon == newDate.getMonth()))))
            {
                return (null);
            };
            return (newDate);
        }


        [Inspectable(category="General", defaultValue="null")]
        public function get formatString():String
        {
            return (this._formatString);
        }

        public function set formatString(value:String):void
        {
            this.formatStringOverride = value;
            this._formatString = ((value != null) ? (value) : (resourceManager.getString("SharedResources", "dateFormat")));
        }

        override protected function resourcesChanged():void
        {
            super.resourcesChanged();
            this.formatString = this.formatStringOverride;
        }

        override public function format(value:Object):String
        {
            var letter:String;
            if (error)
            {
                error = null;
            };
            if (((!(value)) || ((value is String) && (value == ""))))
            {
                error = defaultInvalidValueError;
                return ("");
            };
            if ((value is String))
            {
                value = DateFormatter.parseDateString(String(value), this.formatString);
                if (!value)
                {
                    error = defaultInvalidValueError;
                    return ("");
                };
            }
            else
            {
                if (!(value is Date))
                {
                    error = defaultInvalidValueError;
                    return ("");
                };
            };
            var nTokens:int;
            var tokens:String = "";
            var n:int = this.formatString.length;
            var i:int;
            while (i < n)
            {
                letter = this.formatString.charAt(i);
                if (((!(VALID_PATTERN_CHARS.indexOf(letter) == -1)) && (!(letter == ","))))
                {
                    nTokens++;
                    if (tokens.indexOf(letter) == -1)
                    {
                        tokens = (tokens + letter);
                    }
                    else
                    {
                        if (letter != this.formatString.charAt(Math.max((i - 1), 0)))
                        {
                            error = defaultInvalidFormatError;
                            return ("");
                        };
                    };
                };
                i++;
            };
            if (nTokens < 1)
            {
                error = defaultInvalidFormatError;
                return ("");
            };
            var dataFormatter:StringFormatter = new StringFormatter(this.formatString, VALID_PATTERN_CHARS, DateBase.extractTokenDate);
            return (dataFormatter.formatValue(value));
        }


    }
}

