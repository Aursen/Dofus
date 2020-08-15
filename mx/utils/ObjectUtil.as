package mx.utils
{
    import mx.core.mx_internal;
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;
    import flash.xml.XMLNode;
    import flash.utils.getQualifiedClassName;
    import mx.collections.IList;

    use namespace mx_internal;

    public class ObjectUtil 
    {

        mx_internal static const VERSION:String = "4.16.1.0";
        private static var defaultToStringExcludes:Array = ["password", "credentials"];
        private static var refCount:int = 0;
        private static var CLASS_INFO_CACHE:Object = {};


        public static function compare(a:Object, b:Object, depth:int=-1):int
        {
            return (internalCompare(a, b, 0, depth, new Dictionary(true)));
        }

        public static function copy(value:Object):Object
        {
            var buffer:ByteArray = new ByteArray();
            buffer.writeObject(value);
            buffer.position = 0;
            var result:Object = buffer.readObject();
            return (result);
        }

        public static function clone(value:Object):Object
        {
            var result:Object = copy(value);
            cloneInternal(result, value);
            return (result);
        }

        private static function cloneInternal(result:Object, value:Object):void
        {
            var v:Object;
            var p:*;
            if (((value) && (value.hasOwnProperty("uid"))))
            {
                result.uid = value.uid;
            };
            var classInfo:Object = getClassInfo(value);
            for each (p in classInfo.properties)
            {
                v = value[p];
                if (((v) && (v.hasOwnProperty("uid"))))
                {
                    cloneInternal(result[p], v);
                };
            };
        }

        public static function isSimple(value:Object):Boolean
        {
            var objectType:* = typeof(value);
            switch (objectType)
            {
                case "number":
                case "string":
                case "boolean":
                    return (true);
                case "object":
                    return ((value is Date) || (value is Array));
            };
            return (false);
        }

        public static function numericCompare(a:Number, b:Number):int
        {
            if (((isNaN(a)) && (isNaN(b))))
            {
                return (0);
            };
            if (isNaN(a))
            {
                return (1);
            };
            if (isNaN(b))
            {
                return (-1);
            };
            if (a < b)
            {
                return (-1);
            };
            if (a > b)
            {
                return (1);
            };
            return (0);
        }

        public static function stringCompare(a:String, b:String, caseInsensitive:Boolean=false):int
        {
            if (((a == null) && (b == null)))
            {
                return (0);
            };
            if (a == null)
            {
                return (1);
            };
            if (b == null)
            {
                return (-1);
            };
            if (caseInsensitive)
            {
                a = a.toLocaleLowerCase();
                b = b.toLocaleLowerCase();
            };
            var result:int = a.localeCompare(b);
            if (result < -1)
            {
                result = -1;
            }
            else
            {
                if (result > 1)
                {
                    result = 1;
                };
            };
            return (result);
        }

        public static function dateCompare(a:Date, b:Date):int
        {
            if (((a == null) && (b == null)))
            {
                return (0);
            };
            if (a == null)
            {
                return (1);
            };
            if (b == null)
            {
                return (-1);
            };
            var na:Number = a.getTime();
            var nb:Number = b.getTime();
            if (na < nb)
            {
                return (-1);
            };
            if (na > nb)
            {
                return (1);
            };
            if (((isNaN(na)) && (isNaN(nb))))
            {
                return (0);
            };
            if (isNaN(na))
            {
                return (1);
            };
            if (isNaN(nb))
            {
                return (-1);
            };
            return (0);
        }

        public static function toString(value:Object, namespaceURIs:Array=null, exclude:Array=null):String
        {
            if (exclude == null)
            {
                exclude = defaultToStringExcludes;
            };
            refCount = 0;
            return (internalToString(value, 0, null, namespaceURIs, exclude));
        }

        private static function internalToString(value:Object, indent:int=0, refs:Dictionary=null, namespaceURIs:Array=null, exclude:Array=null):String
        {
            var str:String;
            var classInfo:Object;
            var properties:Array;
            var isArray:Boolean;
            var isDict:Boolean;
            var prop:* = undefined;
            var j:int;
            var id:Object;
            var objectType:String = ((value == null) ? "null" : typeof(value));
            switch (objectType)
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
                        "uris":namespaceURIs
                    });
                    properties = classInfo.properties;
                    str = (("(" + classInfo.name) + ")");
                    if (refs == null)
                    {
                        refs = new Dictionary(true);
                    };
                    try
                    {
                        id = refs[value];
                        if (id != null)
                        {
                            str = (str + ("#" + int(id)));
                            return (str);
                        };
                    }
                    catch(e:Error)
                    {
                        return (String(value));
                    };
                    if (value != null)
                    {
                        str = (str + ("#" + refCount.toString()));
                        refs[value] = refCount;
                        refCount++;
                    };
                    isArray = (value is Array);
                    isDict = (value is Dictionary);
                    indent = (indent + 2);
                    j = 0;
                    while (j < properties.length)
                    {
                        str = newline(str, indent);
                        prop = properties[j];
                        if (isArray)
                        {
                            str = (str + "[");
                        }
                        else
                        {
                            if (isDict)
                            {
                                str = (str + "{");
                            };
                        };
                        if (isDict)
                        {
                            str = (str + internalToString(prop, indent, refs, namespaceURIs, exclude));
                        }
                        else
                        {
                            str = (str + prop.toString());
                        };
                        if (isArray)
                        {
                            str = (str + "] ");
                        }
                        else
                        {
                            if (isDict)
                            {
                                str = (str + "} = ");
                            }
                            else
                            {
                                str = (str + " = ");
                            };
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
                    return (value.toXMLString());
                default:
                    return (("(" + objectType) + ")");
            };
        }

        private static function newline(str:String, n:int=0):String
        {
            var result:String = str;
            result = (result + "\n");
            var i:int;
            while (i < n)
            {
                result = (result + " ");
                i++;
            };
            return (result);
        }

        private static function internalCompare(a:Object, b:Object, currentDepth:int, desiredDepth:int, refs:Dictionary):int
        {
            var newDepth:int;
            var aRef:Object;
            var bRef:Object;
            var aProps:Array;
            var bProps:Array;
            var isObjectDynamic:Boolean;
            var propName:QName;
            var aProp:Object;
            var bProp:Object;
            var i:int;
            if (((a == null) && (b == null)))
            {
                return (0);
            };
            if (a == null)
            {
                return (1);
            };
            if (b == null)
            {
                return (-1);
            };
            if ((a is ObjectProxy))
            {
                a = ObjectProxy(a).object_proxy::object;
            };
            if ((b is ObjectProxy))
            {
                b = ObjectProxy(b).object_proxy::object;
            };
            var typeOfA:* = typeof(a);
            var typeOfB:* = typeof(b);
            var result:int;
            if (typeOfA == typeOfB)
            {
                switch (typeOfA)
                {
                    case "boolean":
                        result = numericCompare(Number(a), Number(b));
                        break;
                    case "number":
                        result = numericCompare((a as Number), (b as Number));
                        break;
                    case "string":
                        result = stringCompare((a as String), (b as String));
                        break;
                    case "object":
                        newDepth = ((desiredDepth > 0) ? (desiredDepth - 1) : desiredDepth);
                        aRef = getRef(a, refs);
                        bRef = getRef(b, refs);
                        if (aRef == bRef)
                        {
                            return (0);
                        };
                        refs[bRef] = aRef;
                        if (((!(desiredDepth == -1)) && (currentDepth > desiredDepth)))
                        {
                            result = stringCompare(a.toString(), b.toString());
                        }
                        else
                        {
                            if (((a is Array) && (b is Array)))
                            {
                                result = arrayCompare((a as Array), (b as Array), currentDepth, desiredDepth, refs);
                            }
                            else
                            {
                                if (((a is Date) && (b is Date)))
                                {
                                    result = dateCompare((a as Date), (b as Date));
                                }
                                else
                                {
                                    if (((a is IList) && (b is IList)))
                                    {
                                        result = listCompare((a as IList), (b as IList), currentDepth, desiredDepth, refs);
                                    }
                                    else
                                    {
                                        if (((a is ByteArray) && (b is ByteArray)))
                                        {
                                            result = byteArrayCompare((a as ByteArray), (b as ByteArray));
                                        }
                                        else
                                        {
                                            if (getQualifiedClassName(a) == getQualifiedClassName(b))
                                            {
                                                aProps = getClassInfo(a).properties;
                                                isObjectDynamic = isDynamicObject(a);
                                                if (isObjectDynamic)
                                                {
                                                    bProps = getClassInfo(b).properties;
                                                    result = arrayCompare(aProps, bProps, currentDepth, newDepth, refs);
                                                    if (result != 0)
                                                    {
                                                        return (result);
                                                    };
                                                };
                                                i = 0;
                                                while (i < aProps.length)
                                                {
                                                    propName = aProps[i];
                                                    aProp = a[propName];
                                                    bProp = b[propName];
                                                    result = internalCompare(aProp, bProp, (currentDepth + 1), newDepth, refs);
                                                    if (result != 0)
                                                    {
                                                        return (result);
                                                    };
                                                    i++;
                                                };
                                            }
                                            else
                                            {
                                                return (1);
                                            };
                                        };
                                    };
                                };
                            };
                        };
                        break;
                };
            }
            else
            {
                return (stringCompare(typeOfA, typeOfB));
            };
            return (result);
        }

        public static function getClassInfo(obj:Object, excludes:Array=null, options:Object=null):Object
        {
            var n:int;
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
            var key:* = undefined;
            var p:String;
            var pi:Number;
            var uris:Array;
            var uri:String;
            var qName:QName;
            var j:int;
            if ((obj is ObjectProxy))
            {
                obj = ObjectProxy(obj).object_proxy::object;
            };
            if (options == null)
            {
                options = {
                    "includeReadOnly":true,
                    "uris":null,
                    "includeTransient":true
                };
            };
            var propertyNames:Array = [];
            var isDynamic:Boolean;
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
                classInfo = DescribeTypeCache.describeType(obj).typeDescription;
                className = classInfo.@name.toString();
                classAlias = classInfo.@alias.toString();
                isDynamic = (classInfo.@isDynamic.toString() == "true");
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
            if (!isDynamic)
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
            result["dynamic"] = isDynamic;
            result["metadata"] = (metadataInfo = recordMetadata(properties));
            var excludeObject:Object = {};
            if (excludes)
            {
                n = excludes.length;
                i = 0;
                while (i < n)
                {
                    excludeObject[excludes[i]] = 1;
                    i = (i + 1);
                };
            };
            var isArray:Boolean = (obj is Array);
            var isDict:Boolean = (obj is Dictionary);
            if (isDict)
            {
                for (key in obj)
                {
                    propertyNames.push(key);
                };
            }
            else
            {
                if (isDynamic)
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
            };
            if (!(((isArray) || (isDict)) || (className == "Object")))
            {
                if (className == "XML")
                {
                    n = properties.length();
                    i = 0;
                    while (i < n)
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
                    n = properties.length();
                    uris = options.uris;
                    i = 0;
                    while (i < n)
                    {
                        prop = properties[i];
                        p = prop.@name.toString();
                        uri = prop.@uri.toString();
                        if (excludeObject[p] == 1)
                        {
                        }
                        else
                        {
                            if (((!(options.includeTransient)) && (internalHasMetadata(metadataInfo, p, "Transient"))))
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
            if (!isDict)
            {
                i = 0;
                while (i < (propertyNames.length - 1))
                {
                    if (propertyNames[i].toString() == propertyNames[(i + 1)].toString())
                    {
                        propertyNames.splice(i, 1);
                        i = (i - 1);
                    };
                    i = (i + 1);
                };
            };
            if (((!(isDynamic)) && (!(className == "XML"))))
            {
                cacheKey = getCacheKey(obj, excludes, options);
                CLASS_INFO_CACHE[cacheKey] = result;
            };
            return (result);
        }

        public static function hasMetadata(obj:Object, propName:String, metadataName:String, excludes:Array=null, options:Object=null):Boolean
        {
            var classInfo:Object = getClassInfo(obj, excludes, options);
            var metadataInfo:Object = classInfo["metadata"];
            return (internalHasMetadata(metadataInfo, propName, metadataName));
        }

        public static function isDynamicObject(object:Object):Boolean
        {
            try
            {
                object["wootHackwoot"];
            }
            catch(e:Error)
            {
                return (false);
            };
            return (true);
        }

        public static function getEnumerableProperties(object:Object):Array
        {
            var property:Object;
            var result:Array = [];
            if (!isDynamicObject(object))
            {
                return (result);
            };
            for (property in object)
            {
                result.push(property);
            };
            return (result);
        }

        public static function valuesAreSubsetOfObject(values:Object, object:Object):Boolean
        {
            var property:String;
            if (((!(object)) && (!(values))))
            {
                return (true);
            };
            if (((!(object)) || (!(values))))
            {
                return (false);
            };
            if (object === values)
            {
                return (true);
            };
            var enumerableProperties:Array = ObjectUtil.getEnumerableProperties(values);
            var matches:Boolean = ((enumerableProperties.length > 0) || (ObjectUtil.isDynamicObject(values)));
            for each (property in enumerableProperties)
            {
                if (((!(object.hasOwnProperty(property))) || (!(object[property] == values[property]))))
                {
                    matches = false;
                    break;
                };
            };
            return (matches);
        }

        public static function getValue(obj:Object, path:Array):*
        {
            if (!obj)
            {
                return (undefined);
            };
            if (((!(path)) || (!(path.length))))
            {
                return (obj);
            };
            var result:* = obj;
            var i:int = -1;
            while (((++i < path.length) && (result)))
            {
                result = ((result.hasOwnProperty(path[i])) ? result[path[i]] : undefined);
            };
            return (result);
        }

        public static function setValue(obj:Object, path:Array, newValue:*):Boolean
        {
            if ((((!(obj)) || (!(path))) || (!(path.length))))
            {
                return (false);
            };
            var secondToLastLink:* = getValue(obj, path.slice(0, -1));
            if (((secondToLastLink) && (secondToLastLink.hasOwnProperty(path[(path.length - 1)]))))
            {
                secondToLastLink[path[(path.length - 1)]] = newValue;
                return (true);
            };
            return (false);
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
                                    existingArray = [existing];
                                    delete metadata[mdName];
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

        private static function arrayCompare(a:Array, b:Array, currentDepth:int, desiredDepth:int, refs:Dictionary):int
        {
            var key:Object;
            var result:int;
            if (a.length != b.length)
            {
                if (a.length < b.length)
                {
                    result = -1;
                }
                else
                {
                    result = 1;
                };
            }
            else
            {
                for (key in a)
                {
                    if (b.hasOwnProperty(key))
                    {
                        result = internalCompare(a[key], b[key], currentDepth, desiredDepth, refs);
                        if (result != 0)
                        {
                            return (result);
                        };
                    }
                    else
                    {
                        return (-1);
                    };
                };
                for (key in b)
                {
                    if (!a.hasOwnProperty(key))
                    {
                        return (1);
                    };
                };
            };
            return (result);
        }

        private static function byteArrayCompare(a:ByteArray, b:ByteArray):int
        {
            var i:int;
            var result:int;
            if (a == b)
            {
                return (result);
            };
            if (a.length != b.length)
            {
                if (a.length < b.length)
                {
                    result = -1;
                }
                else
                {
                    result = 1;
                };
            }
            else
            {
                i = 0;
                while (i < a.length)
                {
                    result = numericCompare(a[i], b[i]);
                    if (result != 0)
                    {
                        i = a.length;
                    };
                    i++;
                };
            };
            return (result);
        }

        private static function listCompare(a:IList, b:IList, currentDepth:int, desiredDepth:int, refs:Dictionary):int
        {
            var i:int;
            var result:int;
            if (a.length != b.length)
            {
                if (a.length < b.length)
                {
                    result = -1;
                }
                else
                {
                    result = 1;
                };
            }
            else
            {
                i = 0;
                while (i < a.length)
                {
                    result = internalCompare(a.getItemAt(i), b.getItemAt(i), (currentDepth + 1), desiredDepth, refs);
                    if (result != 0)
                    {
                        i = a.length;
                    };
                    i++;
                };
            };
            return (result);
        }

        private static function getRef(o:Object, refs:Dictionary):Object
        {
            var oRef:Object = refs[o];
            while (((oRef) && (!(oRef == refs[oRef]))))
            {
                oRef = refs[oRef];
            };
            if (!oRef)
            {
                oRef = o;
            };
            if (oRef != refs[o])
            {
                refs[o] = oRef;
            };
            return (oRef);
        }


    }
}

