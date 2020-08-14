package mx.utils
{
    import mx.core.mx_internal;
    import flash.xml.XMLNode;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import flash.utils.describeType;

    use namespace mx_internal;

    public class RPCObjectUtil 
    {

        mx_internal static const VERSION:String = "4.16.1.0";
        private static var defaultToStringExcludes:Array = ["password", "credentials"];
        private static var _externalToString:Function = null;
        private static var refCount:int = 0;
        private static var CLASS_INFO_CACHE:Object = {};


        public static function setToStringExcludes(excludes:Array):void
        {
            defaultToStringExcludes = excludes;
        }

        public static function externalToString(value:Function):void
        {
            _externalToString = value;
        }

        public static function toString(value:Object, namespaceURIs:Array=null, exclude:Array=null):String
        {
            if (exclude == null)
            {
                exclude = defaultToStringExcludes;
            };
            refCount = 0;
            if (_externalToString != null)
            {
                return (_externalToString(value, namespaceURIs, exclude));
            };
            return (internalToString(value, 0, null, namespaceURIs, exclude));
        }

        private static function internalToString(value:Object, indent:int=0, refs:Dictionary=null, namespaceURIs:Array=null, exclude:Array=null):String
        {
            var str:String;
            var classInfo:Object;
            var properties:Array;
            var id:Object;
            var isArray:Boolean;
            var prop:* = undefined;
            var length:int;
            var j:int;
            var type:String = ((value == null) ? "null" : typeof(value));
            switch (type)
            {
                case "boolean":
                case "number":
                    return (value.toString());
                case "string":
                    return (('"' + value.toString()) + '"');
                case "object":
                    if ((value is Date))
                    {
                        return (value.toString());
                    };
                    if ((value is XMLNode))
                    {
                        return (value.toString());
                    };
                    if ((value is Class))
                    {
                        return (("(" + getQualifiedClassName(value)) + ")");
                    };
                    classInfo = getClassInfo(value, exclude, {
                        "includeReadOnly":true,
                        "uris":namespaceURIs,
                        "includeTransient":false
                    });
                    properties = classInfo.properties;
                    str = (("(" + classInfo.name) + ")");
                    if (refs == null)
                    {
                        refs = new Dictionary(true);
                    };
                    id = refs[value];
                    if (id != null)
                    {
                        str = (str + ("#" + int(id)));
                        return (str);
                    };
                    if (value != null)
                    {
                        str = (str + ("#" + refCount.toString()));
                        refs[value] = refCount;
                        refCount++;
                    };
                    isArray = (value is Array);
                    indent = (indent + 2);
                    length = properties.length;
                    j = 0;
                    while (j < length)
                    {
                        str = newline(str, indent);
                        prop = properties[j];
                        if (isArray)
                        {
                            str = (str + "[");
                        };
                        str = (str + prop.toString());
                        if (isArray)
                        {
                            str = (str + "] ");
                        }
                        else
                        {
                            str = (str + " = ");
                        };
                        try
                        {
                            str = (str + internalToString(value[prop], indent, refs, namespaceURIs, exclude));
                        }
                        catch(e:Error)
                        {
                            str = (str + "?");
                        };
                        j = (j + 1);
                    };
                    indent = (indent - 2);
                    return (str);
                case "xml":
                    return (value.toString());
                default:
                    return (("(" + type) + ")");
            };
        }

        private static function newline(str:String, length:int=0):String
        {
            var result:* = (str + "\n");
            var i:int;
            while (i < length)
            {
                result = (result + " ");
                i++;
            };
            return (result);
        }

        public static function getClassInfo(obj:Object, excludes:Array=null, options:Object=null):Object
        {
            var length:int;
            var i:int;
            var result:Object;
            var cacheKey:String;
            var className:String;
            var classAlias:String;
            var properties:XMLList;
            var prop:XML;
            var metadataInfo:Object;
            var classInfo:XML;
            var numericIndex:Boolean;
            var p:String;
            var pi:Number;
            var uris:Array;
            var uri:String;
            var qName:QName;
            var includeTransients:Boolean;
            var j:int;
            if (options == null)
            {
                options = {
                    "includeReadOnly":true,
                    "uris":null,
                    "includeTransient":true
                };
            };
            var propertyNames:Array = [];
            var dynamic:Boolean;
            if (typeof(obj) == "xml")
            {
                className = "XML";
                properties = obj.text();
                if (properties.length())
                {
                    propertyNames.push("*");
                };
                properties = obj.attributes();
            }
            else
            {
                classInfo = describeType(obj);
                className = classInfo.@name.toString();
                classAlias = classInfo.@alias.toString();
                dynamic = (classInfo.@isDynamic.toString() == "true");
                if (options.includeReadOnly)
                {
                    properties = (classInfo..accessor.(@access != "writeonly") + classInfo..variable);
                }
                else
                {
                    properties = (classInfo..accessor.(@access == "readwrite") + classInfo..variable);
                };
                numericIndex = false;
            };
            if (!dynamic)
            {
                cacheKey = getCacheKey(obj, excludes, options);
                result = CLASS_INFO_CACHE[cacheKey];
                if (result != null)
                {
                    return (result);
                };
            };
            result = {};
            result["name"] = className;
            result["alias"] = classAlias;
            result["properties"] = propertyNames;
            result["dynamic"] = dynamic;
            result["metadata"] = (metadataInfo = recordMetadata(properties));
            var excludeObject:Object = {};
            if (excludes)
            {
                length = excludes.length;
                i = 0;
                while (i < length)
                {
                    excludeObject[excludes[i]] = 1;
                    i = (i + 1);
                };
            };
            var isArray:Boolean = (className == "Array");
            if (dynamic)
            {
                for (p in obj)
                {
                    if (excludeObject[p] != 1)
                    {
                        if (isArray)
                        {
                            pi = parseInt(p);
                            if (isNaN(pi))
                            {
                                propertyNames.push(new QName("", p));
                            }
                            else
                            {
                                propertyNames.push(pi);
                            };
                        }
                        else
                        {
                            propertyNames.push(new QName("", p));
                        };
                    };
                };
                numericIndex = ((isArray) && (!(isNaN(Number(p)))));
            };
            if (!((className == "Object") || (isArray)))
            {
                if (className == "XML")
                {
                    length = properties.length();
                    i = 0;
                    while (i < length)
                    {
                        p = properties[i].name();
                        if (excludeObject[p] != 1)
                        {
                            propertyNames.push(new QName("", ("@" + p)));
                        };
                        i = (i + 1);
                    };
                }
                else
                {
                    length = properties.length();
                    uris = options.uris;
                    includeTransients = ((options.hasOwnProperty("includeTransient")) && (options.includeTransient));
                    i = 0;
                    while (i < length)
                    {
                        prop = properties[i];
                        p = prop.@name.toString();
                        uri = prop.@uri.toString();
                        if (excludeObject[p] == 1)
                        {
                        }
                        else
                        {
                            if (((!(includeTransients)) && (internalHasMetadata(metadataInfo, p, "Transient"))))
                            {
                            }
                            else
                            {
                                if (uris != null)
                                {
                                    if (((uris.length == 1) && (uris[0] == "*")))
                                    {
                                        qName = new QName(uri, p);
                                        try
                                        {
                                            obj[qName];
                                            propertyNames.push();
                                        }
                                        catch(e:Error)
                                        {
                                        };
                                    }
                                    else
                                    {
                                        j = 0;
                                        while (j < uris.length)
                                        {
                                            uri = uris[j];
                                            if (prop.@uri.toString() == uri)
                                            {
                                                qName = new QName(uri, p);
                                                try
                                                {
                                                    obj[qName];
                                                    propertyNames.push(qName);
                                                }
                                                catch(e:Error)
                                                {
                                                };
                                            };
                                            j = (j + 1);
                                        };
                                    };
                                }
                                else
                                {
                                    if (uri.length == 0)
                                    {
                                        qName = new QName(uri, p);
                                        try
                                        {
                                            obj[qName];
                                            propertyNames.push(qName);
                                        }
                                        catch(e:Error)
                                        {
                                        };
                                    };
                                };
                            };
                        };
                        i = (i + 1);
                    };
                };
            };
            propertyNames.sort((Array.CASEINSENSITIVE | ((numericIndex) ? Array.NUMERIC : 0)));
            length = propertyNames.length;
            i = 0;
            while (i < (length - 1))
            {
                if (propertyNames[i].toString() == propertyNames[(i + 1)].toString())
                {
                    propertyNames.splice(i, 1);
                    i = (i - 1);
                };
                i = (i + 1);
            };
            if (!dynamic)
            {
                cacheKey = getCacheKey(obj, excludes, options);
                CLASS_INFO_CACHE[cacheKey] = result;
            };
            return (result);
        }

        private static function internalHasMetadata(metadataInfo:Object, propName:String, metadataName:String):Boolean
        {
            var metadata:Object;
            if (metadataInfo != null)
            {
                metadata = metadataInfo[propName];
                if (metadata != null)
                {
                    if (metadata[metadataName] != null)
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        private static function recordMetadata(properties:XMLList):Object
        {
            var prop:XML;
            var propName:String;
            var metadataList:XMLList;
            var metadata:Object;
            var md:XML;
            var mdName:String;
            var argsList:XMLList;
            var value:Object;
            var arg:XML;
            var existing:Object;
            var argKey:String;
            var argValue:String;
            var existingArray:Array;
            var result:Object;
            try
            {
                for each (prop in properties)
                {
                    propName = prop.attribute("name").toString();
                    metadataList = prop.metadata;
                    if (metadataList.length() > 0)
                    {
                        if (result == null)
                        {
                            result = {};
                        };
                        metadata = {};
                        result[propName] = metadata;
                        for each (md in metadataList)
                        {
                            mdName = md.attribute("name").toString();
                            argsList = md.arg;
                            value = {};
                            for each (arg in argsList)
                            {
                                argKey = arg.attribute("key").toString();
                                if (argKey != null)
                                {
                                    argValue = arg.attribute("value").toString();
                                    value[argKey] = argValue;
                                };
                            };
                            existing = metadata[mdName];
                            if (existing != null)
                            {
                                if ((existing is Array))
                                {
                                    existingArray = (existing as Array);
                                }
                                else
                                {
                                    existingArray = [];
                                };
                                existingArray.push(value);
                                existing = existingArray;
                            }
                            else
                            {
                                existing = value;
                            };
                            metadata[mdName] = existing;
                        };
                    };
                };
            }
            catch(e:Error)
            {
            };
            return (result);
        }

        private static function getCacheKey(o:Object, excludes:Array=null, options:Object=null):String
        {
            var length:int;
            var i:uint;
            var excl:String;
            var flag:String;
            var value:String;
            var key:String = getQualifiedClassName(o);
            if (excludes != null)
            {
                length = excludes.length;
                i = 0;
                while (i < length)
                {
                    excl = (excludes[i] as String);
                    if (excl != null)
                    {
                        key = (key + excl);
                    };
                    i++;
                };
            };
            if (options != null)
            {
                for (flag in options)
                {
                    key = (key + flag);
                    value = options[flag];
                    if (value != null)
                    {
                        key = (key + value.toString());
                    };
                };
            };
            return (key);
        }


    }
} mx.utils

