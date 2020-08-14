package com.demonsters.debugger
{
    import flash.utils.Dictionary;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.display.Stage;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.utils.getQualifiedClassName;
    import flash.system.System;
    import flash.geom.Point;
    import com.demonsters.debugger.*;

    internal class MonsterDebuggerUtils 
    {

        private static var _references:Dictionary = new Dictionary(true);
        private static var _reference:int = 0;


        public static function snapshot(object:DisplayObject, rectangle:Rectangle=null):BitmapData
        {
            var bitmapData:BitmapData;
            var m:Matrix;
            var scaled:Rectangle;
            var s:Number;
            var b:BitmapData;
            if (object == null)
            {
                return (null);
            };
            var visible:Boolean = object.visible;
            var alpha:Number = object.alpha;
            var rotation:Number = object.rotation;
            var scaleX:Number = object.scaleX;
            var scaleY:Number = object.scaleY;
            try
            {
                object.visible = true;
                object.alpha = 1;
                object.rotation = 0;
                object.scaleX = 1;
                object.scaleY = 1;
            }
            catch(e1:Error)
            {
            };
            var bounds:Rectangle = object.getBounds(object);
            bounds.x = int((bounds.x + 0.5));
            bounds.y = int((bounds.y + 0.5));
            bounds.width = int((bounds.width + 0.5));
            bounds.height = int((bounds.height + 0.5));
            if ((object is Stage))
            {
                bounds.x = 0;
                bounds.y = 0;
                bounds.width = Stage(object).stageWidth;
                bounds.height = Stage(object).stageHeight;
            };
            bitmapData = null;
            if (((bounds.width <= 0) || (bounds.height <= 0)))
            {
                return (null);
            };
            try
            {
                bitmapData = new BitmapData(bounds.width, bounds.height, false, 0xFFFFFF);
                m = new Matrix();
                m.tx = -(bounds.x);
                m.ty = -(bounds.y);
                bitmapData.draw(object, m, null, null, null, false);
            }
            catch(e2:Error)
            {
                bitmapData = null;
            };
            try
            {
                object.visible = visible;
                object.alpha = alpha;
                object.rotation = rotation;
                object.scaleX = scaleX;
                object.scaleY = scaleY;
            }
            catch(e3:Error)
            {
            };
            if (bitmapData == null)
            {
                return (null);
            };
            if (rectangle != null)
            {
                if (((bounds.width <= rectangle.width) && (bounds.height <= rectangle.height)))
                {
                    return (bitmapData);
                };
                scaled = bounds.clone();
                scaled.width = rectangle.width;
                scaled.height = (rectangle.width * (bounds.height / bounds.width));
                if (scaled.height > rectangle.height)
                {
                    scaled = bounds.clone();
                    scaled.width = (rectangle.height * (bounds.width / bounds.height));
                    scaled.height = rectangle.height;
                };
                s = (scaled.width / bounds.width);
                try
                {
                    b = new BitmapData(scaled.width, scaled.height, false, 0);
                    m = new Matrix();
                    m.scale(s, s);
                    b.draw(bitmapData, m, null, null, null, true);
                    bitmapData.dispose();
                    bitmapData = b;
                }
                catch(e4:Error)
                {
                    bitmapData.dispose();
                    bitmapData = null;
                };
            };
            return (bitmapData);
        }

        private static function parseClass(object:*, target:String, description:XML, currentDepth:int=1, maxDepth:int=5, includeDisplayObjects:Boolean=true):XML
        {
            var key:String;
            var itemsArrayLength:int;
            var item:* = undefined;
            var itemXML:XML;
            var itemAccess:String;
            var itemPermission:String;
            var itemIcon:String;
            var itemType:String;
            var itemName:String;
            var itemTarget:String;
            var i:int;
            var prop:* = undefined;
            var displayObject:DisplayObjectContainer;
            var displayObjects:Array;
            var child:DisplayObject;
            var rootXML:XML = new XML("<root/>");
            var nodeXML:XML = new XML("<node/>");
            var variables:XMLList = description..variable;
            var accessors:XMLList = description..accessor;
            var constants:XMLList = description..constant;
            var isDynamic:Boolean = Boolean(description.@isDynamic);
            var variablesLength:int = variables.length();
            var accessorsLength:int = accessors.length();
            var constantsLength:int = constants.length();
            var childLength:int;
            var keys:Object = {};
            var itemsArray:Array = [];
            if (isDynamic)
            {
                for (prop in object)
                {
                    key = String(prop);
                    if (!keys.hasOwnProperty(key))
                    {
                        keys[key] = key;
                        itemName = key;
                        itemType = parseType(getQualifiedClassName(object[key]));
                        itemTarget = ((target + ".") + key);
                        itemAccess = MonsterDebuggerConstants.ACCESS_VARIABLE;
                        itemPermission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                        itemIcon = MonsterDebuggerConstants.ICON_VARIABLE;
                        itemsArray[itemsArray.length] = {
                            "name":itemName,
                            "type":itemType,
                            "target":itemTarget,
                            "access":itemAccess,
                            "permission":itemPermission,
                            "icon":itemIcon
                        };
                    };
                };
            };
            i = 0;
            while (i < variablesLength)
            {
                key = variables[i].@name;
                if (!keys.hasOwnProperty(key))
                {
                    keys[key] = key;
                    itemName = key;
                    itemType = parseType(variables[i].@type);
                    itemTarget = ((target + ".") + key);
                    itemAccess = MonsterDebuggerConstants.ACCESS_VARIABLE;
                    itemPermission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                    itemIcon = MonsterDebuggerConstants.ICON_VARIABLE;
                    itemsArray[itemsArray.length] = {
                        "name":itemName,
                        "type":itemType,
                        "target":itemTarget,
                        "access":itemAccess,
                        "permission":itemPermission,
                        "icon":itemIcon
                    };
                };
                i = (i + 1);
            };
            i = 0;
            while (i < accessorsLength)
            {
                key = accessors[i].@name;
                if (!keys.hasOwnProperty(key))
                {
                    keys[key] = key;
                    itemName = key;
                    itemType = parseType(accessors[i].@type);
                    itemTarget = ((target + ".") + key);
                    itemAccess = MonsterDebuggerConstants.ACCESS_ACCESSOR;
                    itemPermission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                    itemIcon = MonsterDebuggerConstants.ICON_VARIABLE;
                    if (accessors[i].@access == MonsterDebuggerConstants.PERMISSION_READONLY)
                    {
                        itemPermission = MonsterDebuggerConstants.PERMISSION_READONLY;
                        itemIcon = MonsterDebuggerConstants.ICON_VARIABLE_READONLY;
                    };
                    if (accessors[i].@access == MonsterDebuggerConstants.PERMISSION_WRITEONLY)
                    {
                        itemPermission = MonsterDebuggerConstants.PERMISSION_WRITEONLY;
                        itemIcon = MonsterDebuggerConstants.ICON_VARIABLE_WRITEONLY;
                    };
                    itemsArray[itemsArray.length] = {
                        "name":itemName,
                        "type":itemType,
                        "target":itemTarget,
                        "access":itemAccess,
                        "permission":itemPermission,
                        "icon":itemIcon
                    };
                };
                i = (i + 1);
            };
            i = 0;
            while (i < constantsLength)
            {
                key = constants[i].@name;
                if (!keys.hasOwnProperty(key))
                {
                    keys[key] = key;
                    itemName = key;
                    itemType = parseType(constants[i].@type);
                    itemTarget = ((target + ".") + key);
                    itemAccess = MonsterDebuggerConstants.ACCESS_CONSTANT;
                    itemPermission = MonsterDebuggerConstants.PERMISSION_READONLY;
                    itemIcon = MonsterDebuggerConstants.ICON_VARIABLE_READONLY;
                    itemsArray[itemsArray.length] = {
                        "name":itemName,
                        "type":itemType,
                        "target":itemTarget,
                        "access":itemAccess,
                        "permission":itemPermission,
                        "icon":itemIcon
                    };
                };
                i = (i + 1);
            };
            itemsArray.sortOn("name", Array.CASEINSENSITIVE);
            if (((includeDisplayObjects) && (object is DisplayObjectContainer)))
            {
                displayObject = DisplayObjectContainer(object);
                displayObjects = [];
                childLength = displayObject.numChildren;
                i = 0;
                while (i < childLength)
                {
                    child = null;
                    try
                    {
                        child = displayObject.getChildAt(i);
                    }
                    catch(e1:Error)
                    {
                    };
                    if (child != null)
                    {
                        itemXML = MonsterDebuggerDescribeType.get(child);
                        itemType = parseType(itemXML.@name);
                        itemName = "DisplayObject";
                        if (child.name != null)
                        {
                            itemName = (itemName + (" - " + child.name));
                        };
                        itemTarget = ((((target + ".") + "getChildAt(") + i) + ")");
                        itemAccess = MonsterDebuggerConstants.ACCESS_DISPLAY_OBJECT;
                        itemPermission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                        itemIcon = ((child is DisplayObjectContainer) ? MonsterDebuggerConstants.ICON_ROOT : MonsterDebuggerConstants.ICON_DISPLAY_OBJECT);
                        displayObjects[displayObjects.length] = {
                            "name":itemName,
                            "type":itemType,
                            "target":itemTarget,
                            "access":itemAccess,
                            "permission":itemPermission,
                            "icon":itemIcon,
                            "index":i
                        };
                    };
                    i = (i + 1);
                };
                displayObjects.sortOn("name", Array.CASEINSENSITIVE);
                itemsArray = displayObjects.concat(itemsArray);
            };
            itemsArrayLength = itemsArray.length;
            i = 0;
            while (i < itemsArrayLength)
            {
                itemType = itemsArray[i].type;
                itemName = itemsArray[i].name;
                itemTarget = itemsArray[i].target;
                itemPermission = itemsArray[i].permission;
                itemAccess = itemsArray[i].access;
                itemIcon = itemsArray[i].icon;
                if (itemPermission == MonsterDebuggerConstants.PERMISSION_WRITEONLY)
                {
                }
                else
                {
                    try
                    {
                        if (itemAccess == MonsterDebuggerConstants.ACCESS_DISPLAY_OBJECT)
                        {
                            item = DisplayObjectContainer(object).getChildAt(itemsArray[i].index);
                        }
                        else
                        {
                            item = object[itemName];
                        };
                    }
                    catch(e2:Error)
                    {
                        item = null;
                    };
                    if (((((((itemType == MonsterDebuggerConstants.TYPE_STRING) || (itemType == MonsterDebuggerConstants.TYPE_BOOLEAN)) || (itemType == MonsterDebuggerConstants.TYPE_NUMBER)) || (itemType == MonsterDebuggerConstants.TYPE_INT)) || (itemType == MonsterDebuggerConstants.TYPE_UINT)) || (itemType == MonsterDebuggerConstants.TYPE_FUNCTION)))
                    {
                        nodeXML = new XML("<node/>");
                        nodeXML.@icon = itemIcon;
                        nodeXML.@label = ((((itemName + " (") + itemType) + ") = ") + printValue(item, itemType, true));
                        nodeXML.@name = itemName;
                        nodeXML.@type = itemType;
                        nodeXML.@value = printValue(item, itemType);
                        nodeXML.@target = itemTarget;
                        nodeXML.@access = itemAccess;
                        nodeXML.@permission = itemPermission;
                        rootXML.appendChild(nodeXML);
                    }
                    else
                    {
                        nodeXML = new XML("<node/>");
                        nodeXML.@icon = itemIcon;
                        nodeXML.@label = (((itemName + " (") + itemType) + ")");
                        nodeXML.@name = itemName;
                        nodeXML.@type = itemType;
                        nodeXML.@target = itemTarget;
                        nodeXML.@access = itemAccess;
                        nodeXML.@permission = itemPermission;
                        if (item == null)
                        {
                            nodeXML.@icon = MonsterDebuggerConstants.ICON_WARNING;
                            nodeXML.@label = (nodeXML.@label + " = null");
                        };
                        nodeXML.appendChild(parse(item, itemTarget, (currentDepth + 1), maxDepth, includeDisplayObjects).children());
                        rootXML.appendChild(nodeXML);
                    };
                };
                i = (i + 1);
            };
            return (rootXML);
        }

        private static function parseArray(object:*, target:String, currentDepth:int=1, maxDepth:int=5, includeDisplayObjects:Boolean=true):XML
        {
            var childXML:XML;
            var key:*;
            var rootXML:XML = new XML("<root/>");
            var childType:String = "";
            var childTarget:String = "";
            var i:int;
            var keys:Array = [];
            var isNumeric:Boolean = true;
            for (key in object)
            {
                if (!(key is int))
                {
                    isNumeric = false;
                };
                keys.push(key);
            };
            if (isNumeric)
            {
                keys.sort(Array.NUMERIC);
            }
            else
            {
                keys.sort(Array.CASEINSENSITIVE);
            };
            i = 0;
            while (i < keys.length)
            {
                childType = parseType(MonsterDebuggerDescribeType.get(object[keys[i]]).@name);
                childTarget = ((target + ".") + String(keys[i]));
                if (((((((childType == MonsterDebuggerConstants.TYPE_STRING) || (childType == MonsterDebuggerConstants.TYPE_BOOLEAN)) || (childType == MonsterDebuggerConstants.TYPE_NUMBER)) || (childType == MonsterDebuggerConstants.TYPE_INT)) || (childType == MonsterDebuggerConstants.TYPE_UINT)) || (childType == MonsterDebuggerConstants.TYPE_FUNCTION)))
                {
                    childXML = new XML("<node/>");
                    childXML.@icon = MonsterDebuggerConstants.ICON_VARIABLE;
                    childXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
                    childXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                    childXML.@label = ((((("[" + keys[i]) + "] (") + childType) + ") = ") + printValue(object[keys[i]], childType, true));
                    childXML.@name = (("[" + keys[i]) + "]");
                    childXML.@type = childType;
                    childXML.@value = printValue(object[keys[i]], childType);
                    childXML.@target = childTarget;
                    rootXML.appendChild(childXML);
                }
                else
                {
                    childXML = new XML("<node/>");
                    childXML.@icon = MonsterDebuggerConstants.ICON_VARIABLE;
                    childXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
                    childXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                    childXML.@label = (((("[" + keys[i]) + "] (") + childType) + ")");
                    childXML.@name = (("[" + keys[i]) + "]");
                    childXML.@type = childType;
                    childXML.@value = "";
                    childXML.@target = childTarget;
                    if (object[keys[i]] == null)
                    {
                        childXML.@icon = MonsterDebuggerConstants.ICON_WARNING;
                        childXML.@label = (childXML.@label + " = null");
                    };
                    childXML.appendChild(parse(object[keys[i]], childTarget, (currentDepth + 1), maxDepth, includeDisplayObjects).children());
                    rootXML.appendChild(childXML);
                };
                i++;
            };
            return (rootXML);
        }

        public static function parseFunctions(object:*, target:String=""):XML
        {
            var itemXML:XML;
            var key:String;
            var returnType:String;
            var parameters:XMLList;
            var parametersLength:int;
            var args:Array;
            var argsString:String;
            var methodXML:XML;
            var parameterXML:XML;
            var rootXML:XML = new XML("<root/>");
            var description:XML = MonsterDebuggerDescribeType.get(object);
            var type:String = parseType(description.@name);
            var itemType:String = "";
            var itemName:String = "";
            var itemTarget:String = "";
            var keys:Object = {};
            var methods:XMLList = description..method;
            var methodsArr:Array = [];
            var methodsLength:int = methods.length();
            var optional:Boolean;
            var i:int;
            var n:int;
            itemXML = new XML("<node/>");
            itemXML.@icon = MonsterDebuggerConstants.ICON_DEFAULT;
            itemXML.@label = (("(" + type) + ")");
            itemXML.@target = target;
            i = 0;
            while (i < methodsLength)
            {
                key = methods[i].@name;
                try
                {
                    if (!keys.hasOwnProperty(key))
                    {
                        keys[key] = key;
                        methodsArr[methodsArr.length] = {
                            "name":key,
                            "xml":methods[i],
                            "access":MonsterDebuggerConstants.ACCESS_METHOD
                        };
                    };
                }
                catch(e:Error)
                {
                };
                i = (i + 1);
            };
            methodsArr.sortOn("name", Array.CASEINSENSITIVE);
            methodsLength = methodsArr.length;
            i = 0;
            while (i < methodsLength)
            {
                itemType = MonsterDebuggerConstants.TYPE_FUNCTION;
                itemName = methodsArr[i].xml.@name;
                itemTarget = ((target + MonsterDebuggerConstants.DELIMITER) + itemName);
                returnType = parseType(methodsArr[i].xml.@returnType);
                parameters = methodsArr[i].xml..parameter;
                parametersLength = parameters.length();
                args = [];
                argsString = "";
                optional = false;
                n = 0;
                while (n < parametersLength)
                {
                    if (((parameters[n].@optional == "true") && (!(optional))))
                    {
                        optional = true;
                        args[args.length] = "[";
                    };
                    args[args.length] = parseType(parameters[n].@type);
                    n = (n + 1);
                };
                if (optional)
                {
                    args[args.length] = "]";
                };
                argsString = args.join(", ");
                argsString = argsString.replace("[, ", "[");
                argsString = argsString.replace(", ]", "]");
                methodXML = new XML("<node/>");
                methodXML.@icon = MonsterDebuggerConstants.ICON_FUNCTION;
                methodXML.@type = MonsterDebuggerConstants.TYPE_FUNCTION;
                methodXML.@access = MonsterDebuggerConstants.ACCESS_METHOD;
                methodXML.@label = ((((itemName + "(") + argsString) + "):") + returnType);
                methodXML.@name = itemName;
                methodXML.@target = itemTarget;
                methodXML.@args = argsString;
                methodXML.@returnType = returnType;
                n = 0;
                while (n < parametersLength)
                {
                    parameterXML = new XML("<node/>");
                    parameterXML.@type = parseType(parameters[n].@type);
                    parameterXML.@index = parameters[n].@index;
                    parameterXML.@optional = parameters[n].@optional;
                    methodXML.appendChild(parameterXML);
                    n = (n + 1);
                };
                itemXML.appendChild(methodXML);
                i = (i + 1);
            };
            rootXML.appendChild(itemXML);
            return (rootXML);
        }

        public static function parseXMLList(xml:*, target:String="", currentDepth:int=1, maxDepth:int=-1):XML
        {
            var rootXML:XML = new XML("<root/>");
            if (((!(maxDepth == -1)) && (currentDepth > maxDepth)))
            {
                return (rootXML);
            };
            var i:int;
            while (i < xml.length())
            {
                rootXML.appendChild(parseXML(xml[i], (((target + ".") + String(i)) + ".children()"), currentDepth, maxDepth).children());
                i++;
            };
            return (rootXML);
        }

        public static function parseXML(xml:*, target:String="", currentDepth:int=1, maxDepth:int=-1):XML
        {
            var nodeXML:XML;
            var childXML:XML;
            var childTarget:String;
            var rootXML:XML = new XML("<root/>");
            var i:int;
            if (((!(maxDepth == -1)) && (currentDepth > maxDepth)))
            {
                return (rootXML);
            };
            if (target.indexOf("@") != -1)
            {
                nodeXML = new XML("<node/>");
                nodeXML.@icon = MonsterDebuggerConstants.ICON_XMLATTRIBUTE;
                nodeXML.@type = MonsterDebuggerConstants.TYPE_XMLATTRIBUTE;
                nodeXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
                nodeXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                nodeXML.@label = xml;
                nodeXML.@name = "";
                nodeXML.@value = xml;
                nodeXML.@target = target;
                rootXML.appendChild(nodeXML);
            }
            else
            {
                if ((("name" in xml) && (xml.name() == null)))
                {
                    nodeXML = new XML("<node/>");
                    nodeXML.@icon = MonsterDebuggerConstants.ICON_XMLVALUE;
                    nodeXML.@type = MonsterDebuggerConstants.TYPE_XMLVALUE;
                    nodeXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
                    nodeXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                    nodeXML.@label = ((("(" + MonsterDebuggerConstants.TYPE_XMLVALUE) + ") = ") + printValue(xml, MonsterDebuggerConstants.TYPE_XMLVALUE, true));
                    nodeXML.@name = "";
                    nodeXML.@value = printValue(xml, MonsterDebuggerConstants.TYPE_XMLVALUE);
                    nodeXML.@target = target;
                    rootXML.appendChild(nodeXML);
                }
                else
                {
                    if ((("hasSimpleContent" in xml) && (xml.hasSimpleContent())))
                    {
                        nodeXML = new XML("<node/>");
                        nodeXML.@icon = MonsterDebuggerConstants.ICON_XMLNODE;
                        nodeXML.@type = MonsterDebuggerConstants.TYPE_XMLNODE;
                        nodeXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
                        nodeXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                        nodeXML.@label = (((xml.name() + " (") + MonsterDebuggerConstants.TYPE_XMLNODE) + ")");
                        nodeXML.@name = xml.name();
                        nodeXML.@value = "";
                        nodeXML.@target = target;
                        if (xml != "")
                        {
                            childXML = new XML("<node/>");
                            childXML.@icon = MonsterDebuggerConstants.ICON_XMLVALUE;
                            childXML.@type = MonsterDebuggerConstants.TYPE_XMLVALUE;
                            childXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
                            childXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                            childXML.@label = ((("(" + MonsterDebuggerConstants.TYPE_XMLVALUE) + ") = ") + printValue(xml, MonsterDebuggerConstants.TYPE_XMLVALUE));
                            childXML.@name = "";
                            childXML.@value = printValue(xml, MonsterDebuggerConstants.TYPE_XMLVALUE);
                            childXML.@target = target;
                            nodeXML.appendChild(childXML);
                        };
                        i = 0;
                        while (i < xml.attributes().length())
                        {
                            childXML = new XML("<node/>");
                            childXML.@icon = MonsterDebuggerConstants.ICON_XMLATTRIBUTE;
                            childXML.@type = MonsterDebuggerConstants.TYPE_XMLATTRIBUTE;
                            childXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
                            childXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                            childXML.@label = ((((("@" + xml.attributes()[i].name()) + " (") + MonsterDebuggerConstants.TYPE_XMLATTRIBUTE) + ") = ") + xml.attributes()[i]);
                            childXML.@name = "";
                            childXML.@value = xml.attributes()[i];
                            childXML.@target = (((target + ".") + "@") + xml.attributes()[i].name());
                            nodeXML.appendChild(childXML);
                            i++;
                        };
                        rootXML.appendChild(nodeXML);
                    }
                    else
                    {
                        nodeXML = new XML("<node/>");
                        nodeXML.@icon = MonsterDebuggerConstants.ICON_XMLNODE;
                        nodeXML.@type = MonsterDebuggerConstants.TYPE_XMLNODE;
                        nodeXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
                        nodeXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                        nodeXML.@label = (((xml.name() + " (") + MonsterDebuggerConstants.TYPE_XMLNODE) + ")");
                        nodeXML.@name = xml.name();
                        nodeXML.@value = "";
                        nodeXML.@target = target;
                        i = 0;
                        while (i < xml.attributes().length())
                        {
                            childXML = new XML("<node/>");
                            childXML.@icon = MonsterDebuggerConstants.ICON_XMLATTRIBUTE;
                            childXML.@type = MonsterDebuggerConstants.TYPE_XMLATTRIBUTE;
                            childXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
                            childXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                            childXML.@label = ((((("@" + xml.attributes()[i].name()) + " (") + MonsterDebuggerConstants.TYPE_XMLATTRIBUTE) + ") = ") + xml.attributes()[i]);
                            childXML.@name = "";
                            childXML.@value = xml.attributes()[i];
                            childXML.@target = (((target + ".") + "@") + xml.attributes()[i].name());
                            nodeXML.appendChild(childXML);
                            i++;
                        };
                        i = 0;
                        while (i < xml.children().length())
                        {
                            childTarget = ((((target + ".") + "children()") + ".") + i);
                            nodeXML.appendChild(parseXML(xml.children()[i], childTarget, (currentDepth + 1), maxDepth).children());
                            i++;
                        };
                        rootXML.appendChild(nodeXML);
                    };
                };
            };
            return (rootXML);
        }

        public static function resume():Boolean
        {
            try
            {
                System.resume();
                return (true);
            }
            catch(e:Error)
            {
            };
            return (false);
        }

        public static function getObjectUnderPoint(container:DisplayObjectContainer, point:Point):DisplayObject
        {
            var objects:Array;
            var object:DisplayObject;
            var o:DisplayObject;
            if (container.areInaccessibleObjectsUnderPoint(point))
            {
                return (container);
            };
            objects = container.getObjectsUnderPoint(point);
            objects.reverse();
            if (((objects == null) || (objects.length == 0)))
            {
                return (container);
            };
            object = objects[0];
            objects.length = 0;
            while (true)
            {
                objects[objects.length] = object;
                if (object.parent == null)
                {
                    break;
                };
                object = object.parent;
            };
            objects.reverse();
            var i:int;
            while (i < objects.length)
            {
                o = objects[i];
                if ((o is DisplayObjectContainer))
                {
                    object = o;
                    if (!DisplayObjectContainer(o).mouseChildren)
                    {
                        break;
                    };
                }
                else
                {
                    break;
                };
                i++;
            };
            return (object);
        }

        public static function getReferenceID(target:*):String
        {
            if ((target in _references))
            {
                return (_references[target]);
            };
            var reference:String = ("#" + String(_reference));
            _references[target] = reference;
            _reference++;
            return (reference);
        }

        public static function printValue(value:*, _arg_2:String, limit:Boolean=false):String
        {
            if (_arg_2 == MonsterDebuggerConstants.TYPE_BYTEARRAY)
            {
                return (value["length"] + " bytes");
            };
            if (value == null)
            {
                return ("null");
            };
            var v:String = String(value);
            if (((limit) && (v.length > 140)))
            {
                v = (v.substr(0, 140) + "...");
            };
            return (v);
        }

        private static function parseObject(object:*, target:String, currentDepth:int=1, maxDepth:int=5, includeDisplayObjects:Boolean=true):XML
        {
            var childXML:XML;
            var prop:*;
            var rootXML:XML = new XML("<root/>");
            var nodeXML:XML = new XML("<node/>");
            var childType:String = "";
            var childTarget:String = "";
            var i:int;
            var properties:Array = [];
            var isNumeric:Boolean = true;
            for (prop in object)
            {
                if (!(prop is int))
                {
                    isNumeric = false;
                };
                properties.push(prop);
            };
            if (isNumeric)
            {
                properties.sort(Array.NUMERIC);
            }
            else
            {
                properties.sort(Array.CASEINSENSITIVE);
            };
            i = 0;
            while (i < properties.length)
            {
                childType = parseType(MonsterDebuggerDescribeType.get(object[properties[i]]).@name);
                childTarget = ((target + ".") + properties[i]);
                if (((((((childType == MonsterDebuggerConstants.TYPE_STRING) || (childType == MonsterDebuggerConstants.TYPE_BOOLEAN)) || (childType == MonsterDebuggerConstants.TYPE_NUMBER)) || (childType == MonsterDebuggerConstants.TYPE_INT)) || (childType == MonsterDebuggerConstants.TYPE_UINT)) || (childType == MonsterDebuggerConstants.TYPE_FUNCTION)))
                {
                    childXML = new XML("<node/>");
                    childXML.@icon = MonsterDebuggerConstants.ICON_VARIABLE;
                    childXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
                    childXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                    childXML.@label = ((((properties[i] + " (") + childType) + ") = ") + printValue(object[properties[i]], childType, true));
                    childXML.@name = properties[i];
                    childXML.@type = childType;
                    childXML.@value = printValue(object[properties[i]], childType);
                    childXML.@target = childTarget;
                    nodeXML.appendChild(childXML);
                }
                else
                {
                    childXML = new XML("<node/>");
                    childXML.@icon = MonsterDebuggerConstants.ICON_VARIABLE;
                    childXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
                    childXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
                    childXML.@label = (((properties[i] + " (") + childType) + ")");
                    childXML.@name = properties[i];
                    childXML.@type = childType;
                    childXML.@value = "";
                    childXML.@target = childTarget;
                    if (object[properties[i]] == null)
                    {
                        childXML.@icon = MonsterDebuggerConstants.ICON_WARNING;
                        childXML.@label = (childXML.@label + " = null");
                    };
                    childXML.appendChild(parse(object[properties[i]], childTarget, (currentDepth + 1), maxDepth, includeDisplayObjects).children());
                    nodeXML.appendChild(childXML);
                };
                i++;
            };
            rootXML.appendChild(nodeXML.children());
            return (rootXML);
        }

        public static function parse(object:*, target:String="", currentDepth:int=1, maxDepth:int=5, includeDisplayObjects:Boolean=true):XML
        {
            var topXML:XML;
            var rootXML:XML = new XML("<root/>");
            var childXML:XML = new XML("<node/>");
            var description:XML = new XML();
            var _local_9:String = "";
            var base:String = "";
            var isDynamic:Boolean;
            var label:String;
            var icon:String = MonsterDebuggerConstants.ICON_ROOT;
            if (((!(maxDepth == -1)) && (currentDepth > maxDepth)))
            {
                return (rootXML);
            };
            if (object == null)
            {
                _local_9 = "null";
                label = "null";
                icon = MonsterDebuggerConstants.ICON_WARNING;
            }
            else
            {
                description = MonsterDebuggerDescribeType.get(object);
                _local_9 = parseType(description.@name);
                base = parseType(description.@base);
                isDynamic = Boolean(description.@isDynamic);
                if ((object is Class))
                {
                    label = ("Class = " + _local_9);
                    _local_9 = "Class";
                    childXML.appendChild(parseClass(object, target, description, currentDepth, maxDepth, includeDisplayObjects).children());
                }
                else
                {
                    if (_local_9 == MonsterDebuggerConstants.TYPE_XML)
                    {
                        childXML.appendChild(parseXML(object, (target + ".children()"), currentDepth, maxDepth).children());
                    }
                    else
                    {
                        if (_local_9 == MonsterDebuggerConstants.TYPE_XMLLIST)
                        {
                            label = (((_local_9 + " [") + String(object.length())) + "]");
                            childXML.appendChild(parseXMLList(object, target, currentDepth, maxDepth).children());
                        }
                        else
                        {
                            if (((_local_9 == MonsterDebuggerConstants.TYPE_ARRAY) || (_local_9.indexOf(MonsterDebuggerConstants.TYPE_VECTOR) == 0)))
                            {
                                label = (((_local_9 + " [") + String(object["length"])) + "]");
                                childXML.appendChild(parseArray(object, target, currentDepth, maxDepth).children());
                            }
                            else
                            {
                                if ((((((_local_9 == MonsterDebuggerConstants.TYPE_STRING) || (_local_9 == MonsterDebuggerConstants.TYPE_BOOLEAN)) || (_local_9 == MonsterDebuggerConstants.TYPE_NUMBER)) || (_local_9 == MonsterDebuggerConstants.TYPE_INT)) || (_local_9 == MonsterDebuggerConstants.TYPE_UINT)))
                                {
                                    childXML.appendChild(parseBasics(object, target, _local_9).children());
                                }
                                else
                                {
                                    if (_local_9 == MonsterDebuggerConstants.TYPE_OBJECT)
                                    {
                                        childXML.appendChild(parseObject(object, target, currentDepth, maxDepth, includeDisplayObjects).children());
                                    }
                                    else
                                    {
                                        childXML.appendChild(parseClass(object, target, description, currentDepth, maxDepth, includeDisplayObjects).children());
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (currentDepth == 1)
            {
                topXML = new XML("<node/>");
                topXML.@icon = icon;
                topXML.@label = _local_9;
                topXML.@type = _local_9;
                topXML.@target = target;
                if (label != null)
                {
                    topXML.@label = label;
                };
                topXML.appendChild(childXML.children());
                rootXML.appendChild(topXML);
            }
            else
            {
                rootXML.appendChild(childXML.children());
            };
            return (rootXML);
        }

        public static function parseType(_arg_1:String):String
        {
            var part1:String;
            var part2:String;
            if (_arg_1.indexOf("::") != -1)
            {
                _arg_1 = _arg_1.substring((_arg_1.indexOf("::") + 2), _arg_1.length);
            };
            if (_arg_1.indexOf("::") != -1)
            {
                part1 = _arg_1.substring(0, (_arg_1.indexOf("<") + 1));
                part2 = _arg_1.substring((_arg_1.indexOf("::") + 2), _arg_1.length);
                _arg_1 = (part1 + part2);
            };
            _arg_1 = _arg_1.replace("()", "");
            _arg_1 = _arg_1.replace(MonsterDebuggerConstants.TYPE_METHOD, MonsterDebuggerConstants.TYPE_FUNCTION);
            return (_arg_1);
        }

        public static function getReference(id:String):*
        {
            var key:*;
            var value:String;
            if (id.charAt(0) != "#")
            {
                return (null);
            };
            for (key in _references)
            {
                value = _references[key];
                if (value == id)
                {
                    return (key);
                };
            };
            return (null);
        }

        public static function pause():Boolean
        {
            try
            {
                System.pause();
                return (true);
            }
            catch(e:Error)
            {
            };
            return (false);
        }

        public static function getMemory():uint
        {
            return (System.totalMemory);
        }

        public static function getObject(base:*, target:String="", parent:int=0):*
        {
            var index:Number;
            if (((target == null) || (target == "")))
            {
                return (base);
            };
            if (target.charAt(0) == "#")
            {
                return (getReference(target));
            };
            var object:* = base;
            var splitted:Array = target.split(MonsterDebuggerConstants.DELIMITER);
            var i:int;
            while (i < (splitted.length - parent))
            {
                if (splitted[i] != "")
                {
                    try
                    {
                        if (splitted[i] == "children()")
                        {
                            object = object.children();
                        }
                        else
                        {
                            if (((object is DisplayObjectContainer) && (splitted[i].indexOf("getChildAt(") == 0)))
                            {
                                index = splitted[i].substring(11, splitted[i].indexOf(")", 11));
                                object = DisplayObjectContainer(object).getChildAt(index);
                            }
                            else
                            {
                                object = object[splitted[i]];
                            };
                        };
                    }
                    catch(e:Error)
                    {
                        break;
                    };
                };
                i = (i + 1);
            };
            return (object);
        }

        public static function stackTrace():XML
        {
            var childXML:XML;
            var stack:String;
            var lines:Array;
            var i:int;
            var s:String;
            var bracketIndex:int;
            var methodIndex:int;
            var classname:String;
            var method:String;
            var file:String;
            var line:String;
            var functionXML:XML;
            var rootXML:XML = new XML("<root/>");
            childXML = new XML("<node/>");
            try
            {
                throw (new Error());
            }
            catch(e:Error)
            {
                stack = e.getStackTrace();
                if (((stack == null) || (stack == "")))
                {
                    return (new XML("<root><error>Stack unavailable</error></root>"));
                };
                stack = stack.split("\t").join("");
                lines = stack.split("\n");
                if (lines.length <= 4)
                {
                    return (new XML("<root><error>Stack to short</error></root>"));
                };
                lines.shift();
                lines.shift();
                lines.shift();
                lines.shift();
                i = 0;
                while (i < lines.length)
                {
                    s = lines[i];
                    s = s.substring(3, s.length);
                    bracketIndex = s.indexOf("[");
                    methodIndex = s.indexOf("/");
                    if (bracketIndex == -1)
                    {
                        bracketIndex = s.length;
                    };
                    if (methodIndex == -1)
                    {
                        methodIndex = bracketIndex;
                    };
                    classname = MonsterDebuggerUtils.parseType(s.substring(0, methodIndex));
                    method = "";
                    file = "";
                    line = "";
                    if (((!(methodIndex == s.length)) && (!(methodIndex == bracketIndex))))
                    {
                        method = s.substring((methodIndex + 1), bracketIndex);
                    };
                    if (bracketIndex != s.length)
                    {
                        file = s.substring((bracketIndex + 1), s.lastIndexOf(":"));
                        line = s.substring((s.lastIndexOf(":") + 1), (s.length - 1));
                    };
                    functionXML = new XML("<node/>");
                    functionXML.@classname = classname;
                    functionXML.@method = method;
                    functionXML.@file = file;
                    functionXML.@line = line;
                    childXML.appendChild(functionXML);
                    i = (i + 1);
                };
            };
            rootXML.appendChild(childXML.children());
            return (rootXML);
        }

        public static function isDisplayObject(object:*):Boolean
        {
            return ((object is DisplayObject) || (object is DisplayObjectContainer));
        }

        private static function parseBasics(object:*, target:String, _arg_3:String):XML
        {
            var rootXML:XML = new XML("<root/>");
            var nodeXML:XML = new XML("<node/>");
            nodeXML.@icon = MonsterDebuggerConstants.ICON_VARIABLE;
            nodeXML.@access = MonsterDebuggerConstants.ACCESS_VARIABLE;
            nodeXML.@permission = MonsterDebuggerConstants.PERMISSION_READWRITE;
            nodeXML.@label = ((_arg_3 + " = ") + printValue(object, _arg_3, true));
            nodeXML.@name = "";
            nodeXML.@type = _arg_3;
            nodeXML.@value = printValue(object, _arg_3);
            nodeXML.@target = target;
            rootXML.appendChild(nodeXML);
            return (rootXML);
        }


    }
} com.demonsters.debugger

