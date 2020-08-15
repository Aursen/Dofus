package com.ankamagames.jerakine.json
{
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.utils.misc.classInfo.MetadataInfo;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
    import __AS3__.vec.*;

    public class JSONEncoder 
    {

        protected var _depthLimit:uint = 0;
        protected var _showObjectType:Boolean = false;
        protected var _processDictionaryKeys:Boolean = false;
        protected var jsonString:String;

        public function JSONEncoder(value:*, pMaxDepth:uint=0, pShowObjectType:Boolean=false, processDictionaryKeys:Boolean=false)
        {
            this.init(value, pMaxDepth, pShowObjectType, processDictionaryKeys);
        }

        private static function escapeString(str:String):String
        {
            var ch:String;
            var hexCode:String;
            var zeroPad:String;
            var s:String = "";
            var len:Number = str.length;
            var i:int;
            while (i < len)
            {
                ch = str.charAt(i);
                switch (ch)
                {
                    case '"':
                        s = (s + '\\"');
                        break;
                    case "\\":
                        s = (s + "\\\\");
                        break;
                    case "\b":
                        s = (s + "\\b");
                        break;
                    case "\f":
                        s = (s + "\\f");
                        break;
                    case "\n":
                        s = (s + "\\n");
                        break;
                    case "\r":
                        s = (s + "\\r");
                        break;
                    case "\t":
                        s = (s + "\\t");
                        break;
                    default:
                        if (ch < " ")
                        {
                            hexCode = ch.charCodeAt(0).toString(16);
                            zeroPad = ((hexCode.length == 2) ? "00" : "000");
                            s = (s + (("\\u" + zeroPad) + hexCode));
                        }
                        else
                        {
                            s = (s + ch);
                        };
                };
                i++;
            };
            return (('"' + s) + '"');
        }


        protected function init(value:*, pMaxDepth:uint=0, pShowObjectType:Boolean=false, processDictionaryKeys:Boolean=false):void
        {
            this._depthLimit = pMaxDepth;
            this._showObjectType = pShowObjectType;
            this._processDictionaryKeys = processDictionaryKeys;
            this.jsonString = this.convertToString(value, 0);
        }

        public function getString():String
        {
            return (this.jsonString);
        }

        private function convertToString(value:*, depth:int=0):String
        {
            if (((!(this._depthLimit == 0)) && (depth > this._depthLimit)))
            {
                return ("");
            };
            if ((value is String))
            {
                return (escapeString((value as String)));
            };
            if ((value is Number))
            {
                return ((isFinite((value as Number))) ? value.toString() : "null");
            };
            if ((value is Boolean))
            {
                return ((value) ? "true" : "false");
            };
            if ((((((((value is Array) || (value is Vector.<int>)) || (value is Vector.<uint>)) || (value is Vector.<String>)) || (value is Vector.<Boolean>)) || (value is Vector.<*>)) || ((value is Dictionary) && (!(this._processDictionaryKeys)))))
            {
                return (this.arrayToString(value, (depth + 1)));
            };
            if (((value is Dictionary) && (this._processDictionaryKeys)))
            {
                return (this.dictionaryToString(value, (depth + 1)));
            };
            if (((value is Object) && (!(value == null))))
            {
                return (this.objectToString(value, (depth + 1)));
            };
            return ("null");
        }

        private function arrayToString(a:*, depth:int):String
        {
            var value:*;
            if (((!(this._depthLimit == 0)) && (depth > this._depthLimit)))
            {
                return ("");
            };
            var s:String = "";
            for each (value in a)
            {
                if (s.length > 0)
                {
                    s = (s + ",");
                };
                s = (s + this.convertToString(value));
            };
            return (("[" + s) + "]");
        }

        private function dictionaryToString(a:*, depth:int):String
        {
            var key:*;
            if (((!(this._depthLimit == 0)) && (depth > this._depthLimit)))
            {
                return ("");
            };
            var s:String = "";
            for (key in a)
            {
                if (s.length > 0)
                {
                    s = (s + ",");
                };
                s = (s + ((escapeString(key) + ":") + this.convertToString(a[key])));
            };
            return (("{" + s) + "}");
        }

        private function objectToString(o:Object, depth:int):String
        {
            var className:Array;
            var value:Object;
            var key:String;
            var classInfo:Vector.<String>;
            var v:String;
            var metadatas:Vector.<MetadataInfo>;
            if (((!(this._depthLimit == 0)) && (depth > this._depthLimit)))
            {
                return ("");
            };
            var s:String = "";
            if (getQualifiedClassName(o) == "Object")
            {
                for (key in o)
                {
                    value = o[key];
                    if ((value is Function))
                    {
                    }
                    else
                    {
                        if (s.length > 0)
                        {
                            s = (s + ",");
                        };
                        s = (s + ((escapeString(key) + ":") + this.convertToString(value)));
                    };
                };
            }
            else
            {
                classInfo = DescribeTypeCache.getVariables(o, false, true, false, true);
                for each (v in classInfo)
                {
                    metadatas = DescribeTypeCache.getVariableMetadata(o, v);
                    if ((((metadatas) && (metadatas.length > 0)) && (metadatas[0].name == "Transient")))
                    {
                    }
                    else
                    {
                        if (s.length > 0)
                        {
                            s = (s + ",");
                        };
                        try
                        {
                            s = (s + ((escapeString(v) + ":") + this.convertToString(o[v])));
                        }
                        catch(e:Error)
                        {
                        };
                    };
                };
            };
            if (this._showObjectType)
            {
                className = getQualifiedClassName(o).split("::");
            };
            if (className != null)
            {
                return (((((((("{" + escapeString("type")) + ":") + escapeString(className.pop())) + ", ") + escapeString("value")) + ":{") + s) + "}}");
            };
            return (("{" + s) + "}");
        }


    }
}

