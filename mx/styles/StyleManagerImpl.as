package mx.styles
{
    import flash.events.EventDispatcher;
    import mx.core.mx_internal;
    import __AS3__.vec.Vector;
    import mx.utils.MediaQueryParser;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.core.IFlexModuleFactory;
    import mx.events.Request;
    import flash.display.DisplayObject;
    import flash.events.IEventDispatcher;
    import mx.events.FlexChangeEvent;
    import mx.managers.SystemManagerGlobals;
    import mx.core.FlexVersion;
    import mx.managers.ISystemManager;
    import flash.system.ApplicationDomain;
    import flash.system.SecurityDomain;
    import mx.modules.IModuleInfo;
    import flash.utils.Timer;
    import mx.modules.ModuleManager;
    import mx.events.ModuleEvent;
    import mx.events.StyleEvent;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import __AS3__.vec.*;

    use namespace mx_internal;

    [ExcludeClass]
    public class StyleManagerImpl extends EventDispatcher implements IStyleManager2 
    {

        mx_internal static const VERSION:String = "4.16.1.0";
        private static var instance:IStyleManager2;
        private static var propList1:Vector.<String> = new Vector.<String>();
        private static var propList2:Vector.<String> = new Vector.<String>();
        private static var _qualifiedTypeSelectors:Boolean = true;
        private static var propNames:Array = ["class", "id", "pseudo", "unconditional"];

        private var selectorIndex:int = 0;
        private var mqp:MediaQueryParser;
        private var inheritingTextFormatStyles:Object = {
            "align":true,
            "bold":true,
            "color":true,
            "font":true,
            "indent":true,
            "italic":true,
            "size":true
        };
        private var sizeInvalidatingStyles:Object = {
            "alignmentBaseline":true,
            "baselineShift":true,
            "blockProgression":true,
            "borderStyle":true,
            "borderThickness":true,
            "breakOpportunity":true,
            "cffHinting":true,
            "columnCount":true,
            "columnGap":true,
            "columnWidth":true,
            "digitCase":true,
            "digitWidth":true,
            "direction":true,
            "dominantBaseline":true,
            "firstBaselineOffset":true,
            "fontAntiAliasType":true,
            "fontFamily":true,
            "fontGridFitType":true,
            "fontLookup":true,
            "fontSharpness":true,
            "fontSize":true,
            "fontStyle":true,
            "fontThickness":true,
            "fontWeight":true,
            "headerHeight":true,
            "horizontalAlign":true,
            "horizontalGap":true,
            "justificationRule":true,
            "justificationStyle":true,
            "kerning":true,
            "leading":true,
            "leadingModel":true,
            "letterSpacing":true,
            "ligatureLevel":true,
            "lineBreak":true,
            "lineHeight":true,
            "lineThrough":true,
            "listAutoPadding":true,
            "listStylePosition":true,
            "listStyleType":true,
            "locale":true,
            "marginBottom":true,
            "marginLeft":true,
            "marginRight":true,
            "marginTop":true,
            "paddingBottom":true,
            "paddingLeft":true,
            "paddingRight":true,
            "paddingTop":true,
            "paragraphEndIndent":true,
            "paragraphStartIndent":true,
            "paragraphSpaceAfter":true,
            "paragraphSpaceBefore":true,
            "renderingMode":true,
            "strokeWidth":true,
            "tabHeight":true,
            "tabWidth":true,
            "tabStops":true,
            "textAlign":true,
            "textAlignLast":true,
            "textDecoration":true,
            "textIndent":true,
            "textJustify":true,
            "textRotation":true,
            "tracking":true,
            "trackingLeft":true,
            "trackingRight":true,
            "typographicCase":true,
            "verticalAlign":true,
            "verticalGap":true,
            "wordSpacing":true,
            "whitespaceCollapse":true
        };
        private var parentSizeInvalidatingStyles:Object = {
            "baseline":true,
            "bottom":true,
            "horizontalCenter":true,
            "left":true,
            "right":true,
            "top":true,
            "verticalCenter":true
        };
        private var parentDisplayListInvalidatingStyles:Object = {
            "baseline":true,
            "bottom":true,
            "horizontalCenter":true,
            "left":true,
            "right":true,
            "top":true,
            "verticalCenter":true
        };
        private var colorNames:Object = {
            "transparent":"transparent",
            "black":0,
            "blue":0xFF,
            "green":0x8000,
            "gray":0x808080,
            "silver":0xC0C0C0,
            "lime":0xFF00,
            "olive":0x808000,
            "white":0xFFFFFF,
            "yellow":0xFFFF00,
            "maroon":0x800000,
            "navy":128,
            "red":0xFF0000,
            "purple":0x800080,
            "teal":0x8080,
            "fuchsia":0xFF00FF,
            "aqua":0xFFFF,
            "magenta":0xFF00FF,
            "cyan":0xFFFF,
            "halogreen":8453965,
            "haloblue":40447,
            "haloorange":0xFFB600,
            "halosilver":11455193
        };
        private var _hasAdvancedSelectors:Boolean;
        private var _pseudoCSSStates:Object;
        private var _selectors:Object = {};
        private var styleModules:Object = {};
        private var _subjects:Object = {};
        private var resourceManager:IResourceManager = ResourceManager.getInstance();
        private var mergedInheritingStylesCache:Object;
        private var moduleFactory:IFlexModuleFactory;
        private var _parent:IStyleManager2;
        private var _stylesRoot:Object;
        private var _inheritingStyles:Object = {};
        private var _typeHierarchyCache:Object;
        private var _typeSelectorCache:Object;

        public function StyleManagerImpl(moduleFactory:IFlexModuleFactory=null)
        {
            var request:Request;
            var parentModuleFactory:IFlexModuleFactory;
            super();
            if (!moduleFactory)
            {
                return;
            };
            this.moduleFactory = moduleFactory;
            this.moduleFactory.registerImplementation("mx.styles::IStyleManager2", this);
            if ((moduleFactory is DisplayObject))
            {
                request = new Request(Request.GET_PARENT_FLEX_MODULE_FACTORY_REQUEST);
                DisplayObject(moduleFactory).dispatchEvent(request);
                parentModuleFactory = (request.value as IFlexModuleFactory);
                if (parentModuleFactory)
                {
                    this._parent = IStyleManager2(parentModuleFactory.getImplementation("mx.styles::IStyleManager2"));
                    if ((this._parent is IEventDispatcher))
                    {
                        IEventDispatcher(this._parent).addEventListener(FlexChangeEvent.STYLE_MANAGER_CHANGE, this.styleManagerChangeHandler, false, 0, true);
                    };
                };
            };
        }

        public static function init(fbs:IFlexModuleFactory):void
        {
            var sm:StyleManagerImpl;
            var styleDataClass:Class;
            var styleNames:Array;
            var s:String;
            var styleDataClassName:String = fbs.info()["styleDataClassName"];
            if (styleDataClassName)
            {
                sm = (fbs.getImplementation("mx.styles::IStyleManager2") as StyleManagerImpl);
                if (!sm)
                {
                    sm = new StyleManagerImpl(fbs);
                };
                styleDataClass = fbs.info()["currentDomain"].getDefinition(styleDataClassName);
                styleNames = styleDataClass["inheritingStyles"];
                for each (s in styleNames)
                {
                    sm.registerInheritingStyle(s);
                };
                generateCSSStyleDeclarations(sm, styleDataClass["factoryFunctions"], styleDataClass["data"]);
                sm.initProtoChainRoots();
            };
        }

        public static function generateCSSStyleDeclarations(styleManager:StyleManagerImpl, factoryFunctions:Object, data:Array, newSelectors:Array=null, overrideMap:Object=null):void
        {
            var style:CSSStyleDeclaration;
            var effects:Array;
            var mergedStyle:CSSStyleDeclaration;
            var className:int;
            var selectorName:String;
            var conditionType:String;
            var conditionName:String;
            var factoryName:int;
            var defaultFactory:Boolean;
            var moduleStyles:Object;
            var styleProp:String;
            var arr:Array = data;
            var conditions:Array;
            var condition:CSSCondition;
            var selector:CSSSelector;
            var declarationName:String = "";
            var segmentName:String = "";
            var conditionCombiners:Object = {};
            conditionCombiners[CSSConditionKind.CLASS] = ".";
            conditionCombiners[CSSConditionKind.ID] = "#";
            conditionCombiners[CSSConditionKind.PSEUDO] = ":";
            var n:int = arr.length;
            var i:int;
            while (i < n)
            {
                className = arr[i];
                if (className == CSSClass.CSSSelector)
                {
                    selectorName = arr[++i];
                    selector = new CSSSelector(selectorName, conditions, selector);
                    segmentName = (selectorName + segmentName);
                    if (declarationName != "")
                    {
                        declarationName = (declarationName + " ");
                    };
                    declarationName = (declarationName + segmentName);
                    segmentName = "";
                    conditions = null;
                }
                else
                {
                    if (className == CSSClass.CSSCondition)
                    {
                        if (!conditions)
                        {
                            conditions = [];
                        };
                        conditionType = arr[++i];
                        conditionName = arr[++i];
                        condition = new CSSCondition(conditionType, conditionName);
                        conditions.push(condition);
                        segmentName = ((segmentName + conditionCombiners[conditionType]) + conditionName);
                    }
                    else
                    {
                        if (className == CSSClass.CSSStyleDeclaration)
                        {
                            factoryName = arr[++i];
                            defaultFactory = (factoryName == CSSFactory.DefaultFactory);
                            if (defaultFactory)
                            {
                                mergedStyle = styleManager.getMergedStyleDeclaration(declarationName);
                                style = new CSSStyleDeclaration(selector, styleManager, (mergedStyle == null));
                            }
                            else
                            {
                                style = styleManager.getStyleDeclaration(declarationName);
                                if (!style)
                                {
                                    style = new CSSStyleDeclaration(selector, styleManager, (mergedStyle == null));
                                    if (factoryName == CSSFactory.Override)
                                    {
                                        newSelectors.push(style);
                                    };
                                };
                            };
                            if (defaultFactory)
                            {
                                if (style.defaultFactory == null)
                                {
                                    style.defaultFactory = factoryFunctions[declarationName];
                                };
                            }
                            else
                            {
                                if (factoryName == CSSFactory.Factory)
                                {
                                    if (style.factory == null)
                                    {
                                        style.factory = factoryFunctions[declarationName];
                                    };
                                }
                                else
                                {
                                    moduleStyles = new (factoryFunctions[declarationName])();
                                    for (styleProp in moduleStyles)
                                    {
                                        style.setLocalStyle(styleProp, moduleStyles[styleProp]);
                                        if (!overrideMap[declarationName])
                                        {
                                            overrideMap[declarationName] = [];
                                        };
                                        overrideMap[declarationName].push(styleProp);
                                    };
                                };
                            };
                            if ((((defaultFactory) && (!(mergedStyle == null))) && ((mergedStyle.defaultFactory == null) || (compareFactories(new style.defaultFactory(), new mergedStyle.defaultFactory())))))
                            {
                                styleManager.setStyleDeclaration(style.selectorString, style, false);
                            };
                            selector = null;
                            conditions = null;
                            declarationName = "";
                            mergedStyle = null;
                        };
                    };
                };
                i++;
            };
        }

        private static function compareFactories(obj1:Object, obj2:Object):int
        {
            var p:String;
            propList1.length = (propList2.length = 0);
            for (p in obj1)
            {
                propList1.push(p);
            };
            for (p in obj2)
            {
                propList2.push(p);
            };
            if (propList1.length != propList2.length)
            {
                return (1);
            };
            for each (p in propList1)
            {
                if (obj1[p] !== obj2[p])
                {
                    return (1);
                };
            };
            return (0);
        }

        public static function getInstance():IStyleManager2
        {
            if (!instance)
            {
                instance = IStyleManager2(IFlexModuleFactory(SystemManagerGlobals.topLevelSystemManagers[0]).getImplementation("mx.styles::IStyleManager2"));
                if (!instance)
                {
                    instance = new StyleManagerImpl(SystemManagerGlobals.topLevelSystemManagers[0]);
                };
            };
            return (instance);
        }


        public function get parent():IStyleManager2
        {
            return (this._parent);
        }

        public function get qualifiedTypeSelectors():Boolean
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_4_0)
            {
                return (false);
            };
            if (_qualifiedTypeSelectors)
            {
                return (_qualifiedTypeSelectors);
            };
            if (this.parent)
            {
                return (this.parent.qualifiedTypeSelectors);
            };
            return (false);
        }

        public function set qualifiedTypeSelectors(value:Boolean):void
        {
            _qualifiedTypeSelectors = value;
        }

        public function get stylesRoot():Object
        {
            return (this._stylesRoot);
        }

        public function set stylesRoot(value:Object):void
        {
            this._stylesRoot = value;
        }

        public function get inheritingStyles():Object
        {
            var otherStyles:Object;
            var obj:Object;
            if (this.mergedInheritingStylesCache)
            {
                return (this.mergedInheritingStylesCache);
            };
            var mergedStyles:Object = this._inheritingStyles;
            if (this.parent)
            {
                otherStyles = this.parent.inheritingStyles;
                for (obj in otherStyles)
                {
                    if (mergedStyles[obj] === undefined)
                    {
                        mergedStyles[obj] = otherStyles[obj];
                    };
                };
            };
            this.mergedInheritingStylesCache = mergedStyles;
            return (mergedStyles);
        }

        public function set inheritingStyles(value:Object):void
        {
            this._inheritingStyles = value;
            this.mergedInheritingStylesCache = null;
            if (hasEventListener(FlexChangeEvent.STYLE_MANAGER_CHANGE))
            {
                this.dispatchInheritingStylesChangeEvent();
            };
        }

        public function get typeHierarchyCache():Object
        {
            if (this._typeHierarchyCache == null)
            {
                this._typeHierarchyCache = {};
            };
            return (this._typeHierarchyCache);
        }

        public function set typeHierarchyCache(value:Object):void
        {
            this._typeHierarchyCache = value;
        }

        public function get typeSelectorCache():Object
        {
            if (this._typeSelectorCache == null)
            {
                this._typeSelectorCache = {};
            };
            return (this._typeSelectorCache);
        }

        public function set typeSelectorCache(value:Object):void
        {
            this._typeSelectorCache = value;
        }

        public function initProtoChainRoots():void
        {
            var style:CSSStyleDeclaration;
            if (!this.stylesRoot)
            {
                style = this.getMergedStyleDeclaration("global");
                if (style != null)
                {
                    this.stylesRoot = style.addStyleToProtoChain({}, null);
                };
            };
        }

        public function get selectors():Array
        {
            var i:String;
            var otherSelectors:Array;
            var theSelectors:Array = [];
            for (i in this._selectors)
            {
                theSelectors.push(i);
            };
            if (this.parent)
            {
                otherSelectors = this.parent.selectors;
                for (i in otherSelectors)
                {
                    theSelectors.push(i);
                };
            };
            return (theSelectors);
        }

        public function hasAdvancedSelectors():Boolean
        {
            if (this._hasAdvancedSelectors)
            {
                return (true);
            };
            if (this.parent)
            {
                return (this.parent.hasAdvancedSelectors());
            };
            return (false);
        }

        public function hasPseudoCondition(cssState:String):Boolean
        {
            if (((!(this._pseudoCSSStates == null)) && (!(this._pseudoCSSStates[cssState] == null))))
            {
                return (true);
            };
            if (this.parent)
            {
                return (this.parent.hasPseudoCondition(cssState));
            };
            return (false);
        }

        public function getStyleDeclarations(subject:String):Object
        {
            var index:int;
            var mergedSubjects:Object;
            var prop:String;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_4_0)
            {
                if (subject.charAt(0) != ".")
                {
                    index = subject.lastIndexOf(".");
                    if (index != -1)
                    {
                        subject = subject.substr((index + 1));
                    };
                };
            };
            var theSubjects:Object;
            if (this.parent)
            {
                theSubjects = this.parent.getStyleDeclarations(subject);
            };
            var subjectsObject:Object = this._subjects[subject];
            if (!theSubjects)
            {
                if (subjectsObject)
                {
                    theSubjects = subjectsObject;
                };
            }
            else
            {
                if (subjectsObject)
                {
                    mergedSubjects = {};
                    for each (prop in propNames)
                    {
                        mergedSubjects[prop] = subjectsObject[prop];
                    };
                    mergedSubjects.parent = theSubjects;
                    theSubjects = mergedSubjects;
                };
            };
            return (theSubjects);
        }

        private function isUnique(element:*, index:int, arr:Array):Boolean
        {
            return (arr.indexOf(element) >= 0);
        }

        public function getStyleDeclaration(selector:String):CSSStyleDeclaration
        {
            var index:int;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_4_0)
            {
                if (selector.charAt(0) != ".")
                {
                    index = selector.lastIndexOf(".");
                    if (index != -1)
                    {
                        selector = selector.substr((index + 1));
                    };
                };
            };
            return (this._selectors[selector]);
        }

        public function getMergedStyleDeclaration(selector:String):CSSStyleDeclaration
        {
            var style:CSSStyleDeclaration = this.getStyleDeclaration(selector);
            var parentStyle:CSSStyleDeclaration;
            if (this.parent)
            {
                parentStyle = this.parent.getMergedStyleDeclaration(selector);
            };
            if (((style) || (parentStyle)))
            {
                style = new CSSMergedStyleDeclaration(style, parentStyle, ((style) ? style.selectorString : parentStyle.selectorString), this, false);
            };
            return (style);
        }

        public function setStyleDeclaration(selector:String, styleDeclaration:CSSStyleDeclaration, update:Boolean):void
        {
            var index:int;
            var firstChar:String;
            var kind:String;
            var declarations:Object;
            var declarationList:Array;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_4_0)
            {
                if (selector.charAt(0) != ".")
                {
                    index = selector.lastIndexOf(".");
                    if (index != -1)
                    {
                        selector = selector.substr((index + 1));
                    };
                };
            };
            styleDeclaration.selectorRefCount++;
            styleDeclaration.selectorIndex = this.selectorIndex++;
            this._selectors[selector] = styleDeclaration;
            var subject:String = styleDeclaration.subject;
            if (selector)
            {
                if (!styleDeclaration.subject)
                {
                    styleDeclaration.selectorString = selector;
                    subject = styleDeclaration.subject;
                }
                else
                {
                    if (selector != styleDeclaration.selectorString)
                    {
                        firstChar = selector.charAt(0);
                        if ((((firstChar == ".") || (firstChar == ":")) || (firstChar == "#")))
                        {
                            subject = "*";
                        }
                        else
                        {
                            subject = selector;
                        };
                        styleDeclaration.selectorString = selector;
                    };
                };
            };
            if (subject != null)
            {
                kind = ((styleDeclaration.selector.conditions) ? (styleDeclaration.selector.conditions[0].kind) : ("unconditional"));
                declarations = this._subjects[subject];
                if (declarations == null)
                {
                    declarations = {};
                    declarations[kind] = [styleDeclaration];
                    this._subjects[subject] = declarations;
                }
                else
                {
                    declarationList = (declarations[kind] as Array);
                    if (declarationList == null)
                    {
                        declarations[kind] = [styleDeclaration];
                    }
                    else
                    {
                        declarationList.push(styleDeclaration);
                    };
                };
            };
            var pseudoCondition:String = styleDeclaration.getPseudoCondition();
            if (pseudoCondition != null)
            {
                if (this._pseudoCSSStates == null)
                {
                    this._pseudoCSSStates = {};
                };
                this._pseudoCSSStates[pseudoCondition] = true;
            };
            if (styleDeclaration.isAdvanced())
            {
                this._hasAdvancedSelectors = true;
            };
            if (this._typeSelectorCache)
            {
                this._typeSelectorCache = {};
            };
            if (update)
            {
                this.styleDeclarationsChanged();
            };
        }

        public function clearStyleDeclaration(selector:String, update:Boolean):void
        {
            var decls:Array;
            var i:int;
            var decl:CSSStyleDeclaration;
            var matchingSubject:Boolean;
            var styleDeclaration:CSSStyleDeclaration = this.getStyleDeclaration(selector);
            if (((styleDeclaration) && (styleDeclaration.selectorRefCount > 0)))
            {
                styleDeclaration.selectorRefCount--;
            };
            delete this._selectors[selector];
            if (((styleDeclaration) && (styleDeclaration.subject)))
            {
                decls = (this._subjects[styleDeclaration.subject] as Array);
                if (decls)
                {
                    i = (decls.length - 1);
                    while (i >= 0)
                    {
                        decl = decls[i];
                        if (((decl) && (decl.selectorString == selector)))
                        {
                            if (decls.length == 1)
                            {
                                delete this._subjects[styleDeclaration.subject];
                            }
                            else
                            {
                                decls.splice(i, 1);
                            };
                        };
                        i--;
                    };
                };
            }
            else
            {
                matchingSubject = false;
                for each (decls in this._subjects)
                {
                    if (decls)
                    {
                        i = (decls.length - 1);
                        while (i >= 0)
                        {
                            decl = decls[i];
                            if (((decl) && (decl.selectorString == selector)))
                            {
                                matchingSubject = true;
                                if (decls.length == 1)
                                {
                                    delete this._subjects[decl.subject];
                                }
                                else
                                {
                                    decls.splice(i, 1);
                                };
                            };
                            i--;
                        };
                        if (matchingSubject)
                        {
                            break;
                        };
                    };
                };
            };
            if (update)
            {
                this.styleDeclarationsChanged();
            };
        }

        public function styleDeclarationsChanged():void
        {
            var sm:ISystemManager;
            var cm:Object;
            var sms:Array = SystemManagerGlobals.topLevelSystemManagers;
            var n:int = sms.length;
            var i:int;
            while (i < n)
            {
                sm = sms[i];
                cm = sm.getImplementation("mx.managers::ISystemManagerChildManager");
                Object(cm).regenerateStyleCache(true);
                Object(cm).notifyStyleChangeInChildren(null, true);
                i++;
            };
        }

        public function registerInheritingStyle(styleName:String):void
        {
            if (this._inheritingStyles[styleName] != true)
            {
                this._inheritingStyles[styleName] = true;
                this.mergedInheritingStylesCache = null;
                if (hasEventListener(FlexChangeEvent.STYLE_MANAGER_CHANGE))
                {
                    this.dispatchInheritingStylesChangeEvent();
                };
            };
        }

        public function isInheritingStyle(styleName:String):Boolean
        {
            if (this.mergedInheritingStylesCache)
            {
                return (this.mergedInheritingStylesCache[styleName] == true);
            };
            if (this._inheritingStyles[styleName] == true)
            {
                return (true);
            };
            if (((this.parent) && (this.parent.isInheritingStyle(styleName))))
            {
                return (true);
            };
            return (false);
        }

        public function isInheritingTextFormatStyle(styleName:String):Boolean
        {
            if (this.inheritingTextFormatStyles[styleName] == true)
            {
                return (true);
            };
            if (((this.parent) && (this.parent.isInheritingTextFormatStyle(styleName))))
            {
                return (true);
            };
            return (false);
        }

        public function registerSizeInvalidatingStyle(styleName:String):void
        {
            this.sizeInvalidatingStyles[styleName] = true;
        }

        public function isSizeInvalidatingStyle(styleName:String):Boolean
        {
            if (this.sizeInvalidatingStyles[styleName] == true)
            {
                return (true);
            };
            if (((this.parent) && (this.parent.isSizeInvalidatingStyle(styleName))))
            {
                return (true);
            };
            return (false);
        }

        public function registerParentSizeInvalidatingStyle(styleName:String):void
        {
            this.parentSizeInvalidatingStyles[styleName] = true;
        }

        public function isParentSizeInvalidatingStyle(styleName:String):Boolean
        {
            if (this.parentSizeInvalidatingStyles[styleName] == true)
            {
                return (true);
            };
            if (((this.parent) && (this.parent.isParentSizeInvalidatingStyle(styleName))))
            {
                return (true);
            };
            return (false);
        }

        public function registerParentDisplayListInvalidatingStyle(styleName:String):void
        {
            this.parentDisplayListInvalidatingStyles[styleName] = true;
        }

        public function isParentDisplayListInvalidatingStyle(styleName:String):Boolean
        {
            if (this.parentDisplayListInvalidatingStyles[styleName] == true)
            {
                return (true);
            };
            if (((this.parent) && (this.parent.isParentDisplayListInvalidatingStyle(styleName))))
            {
                return (true);
            };
            return (false);
        }

        public function registerColorName(colorName:String, colorValue:uint):void
        {
            this.colorNames[colorName.toLowerCase()] = colorValue;
        }

        public function isColorName(colorName:String):Boolean
        {
            if (this.colorNames[colorName.toLowerCase()] !== undefined)
            {
                return (true);
            };
            if (((this.parent) && (this.parent.isColorName(colorName))))
            {
                return (true);
            };
            return (false);
        }

        public function getColorName(colorName:Object):uint
        {
            var n:Number;
            var c:*;
            if ((colorName is String))
            {
                if (colorName.charAt(0) == "#")
                {
                    n = Number(("0x" + colorName.slice(1)));
                    return ((isNaN(n)) ? StyleManager.NOT_A_COLOR : uint(n));
                };
                if (((colorName.charAt(1) == "x") && (colorName.charAt(0) == "0")))
                {
                    n = Number(colorName);
                    return ((isNaN(n)) ? StyleManager.NOT_A_COLOR : uint(n));
                };
                c = this.colorNames[colorName.toLowerCase()];
                if (c === undefined)
                {
                    if (this.parent)
                    {
                        c = this.parent.getColorName(colorName);
                    };
                };
                if (c === undefined)
                {
                    return (StyleManager.NOT_A_COLOR);
                };
                return (uint(c));
            };
            return (uint(colorName));
        }

        public function getColorNames(colors:Array):void
        {
            var colorNumber:uint;
            if (!colors)
            {
                return;
            };
            var n:int = colors.length;
            var i:int;
            while (i < n)
            {
                if (((!(colors[i] == null)) && (isNaN(colors[i]))))
                {
                    colorNumber = this.getColorName(colors[i]);
                    if (colorNumber != StyleManager.NOT_A_COLOR)
                    {
                        colors[i] = colorNumber;
                    };
                };
                i++;
            };
        }

        public function isValidStyleValue(value:*):Boolean
        {
            if (value !== undefined)
            {
                return (true);
            };
            if (this.parent)
            {
                return (this.parent.isValidStyleValue(value));
            };
            return (false);
        }

        public function loadStyleDeclarations(url:String, update:Boolean=true, trustContent:Boolean=false, applicationDomain:ApplicationDomain=null, securityDomain:SecurityDomain=null):IEventDispatcher
        {
            return (this.loadStyleDeclarations2(url, update, applicationDomain, securityDomain));
        }

        public function loadStyleDeclarations2(url:String, update:Boolean=true, applicationDomain:ApplicationDomain=null, securityDomain:SecurityDomain=null):IEventDispatcher
        {
            var module:IModuleInfo;
            var thisStyleManager:IStyleManager2;
            var styleEventDispatcher:StyleEventDispatcher;
            var timer:Timer;
            var timerHandler:Function;
            module = ModuleManager.getModule(url);
            thisStyleManager = this;
            var readyHandler:Function = function (moduleEvent:ModuleEvent):void
            {
                var styleModule:IStyleModule = IStyleModule(moduleEvent.module.factory.create());
                moduleEvent.module.factory.registerImplementation("mx.styles::IStyleManager2", thisStyleManager);
                styleModule.setStyleDeclarations(thisStyleManager);
                styleModules[moduleEvent.module.url].styleModule = styleModule;
                if (update)
                {
                    styleDeclarationsChanged();
                };
            };
            module.addEventListener(ModuleEvent.READY, readyHandler, false, 0, true);
            styleEventDispatcher = new StyleEventDispatcher(module);
            var errorHandler:Function = function (moduleEvent:ModuleEvent):void
            {
                var styleEvent:StyleEvent;
                var errorText:String = resourceManager.getString("styles", "unableToLoad", [moduleEvent.errorText, url]);
                if (styleEventDispatcher.willTrigger(StyleEvent.ERROR))
                {
                    styleEvent = new StyleEvent(StyleEvent.ERROR, moduleEvent.bubbles, moduleEvent.cancelable);
                    styleEvent.bytesLoaded = 0;
                    styleEvent.bytesTotal = 0;
                    styleEvent.errorText = errorText;
                    styleEventDispatcher.dispatchEvent(styleEvent);
                }
                else
                {
                    throw (new Error(errorText));
                };
            };
            module.addEventListener(ModuleEvent.ERROR, errorHandler, false, 0, true);
            this.styleModules[url] = new StyleModuleInfo(module, readyHandler, errorHandler);
            timer = new Timer(0);
            timerHandler = function (event:TimerEvent):void
            {
                timer.removeEventListener(TimerEvent.TIMER, timerHandler);
                timer.stop();
                module.load(applicationDomain, securityDomain, null, moduleFactory);
            };
            timer.addEventListener(TimerEvent.TIMER, timerHandler, false, 0, true);
            timer.start();
            return (styleEventDispatcher);
        }

        public function unloadStyleDeclarations(url:String, update:Boolean=true):void
        {
            var module:IModuleInfo;
            var styleModuleInfo:StyleModuleInfo = this.styleModules[url];
            if (styleModuleInfo)
            {
                styleModuleInfo.styleModule.unload();
                module = styleModuleInfo.module;
                module.unload();
                module.removeEventListener(ModuleEvent.READY, styleModuleInfo.readyHandler);
                module.removeEventListener(ModuleEvent.ERROR, styleModuleInfo.errorHandler);
                this.styleModules[url] = null;
            };
            if (update)
            {
                this.styleDeclarationsChanged();
            };
        }

        private function dispatchInheritingStylesChangeEvent():void
        {
            var event:Event = new FlexChangeEvent(FlexChangeEvent.STYLE_MANAGER_CHANGE, false, false, {"property":"inheritingStyles"});
            dispatchEvent(event);
        }

        public function acceptMediaList(value:String):Boolean
        {
            if (!this.mqp)
            {
                this.mqp = MediaQueryParser.instance;
                if (!this.mqp)
                {
                    this.mqp = new MediaQueryParser(this.moduleFactory);
                    MediaQueryParser.instance = this.mqp;
                };
            };
            return (this.mqp.parse(value));
        }

        private function styleManagerChangeHandler(event:FlexChangeEvent):void
        {
            if (!event.data)
            {
                return;
            };
            var property:String = event.data["property"];
            if (property == "inheritingStyles")
            {
                this.mergedInheritingStylesCache = null;
            };
            if (hasEventListener(FlexChangeEvent.STYLE_MANAGER_CHANGE))
            {
                dispatchEvent(event);
            };
        }


    }
}

import flash.events.EventDispatcher;
import mx.events.ModuleEvent;
import mx.modules.IModuleInfo;
import mx.events.StyleEvent;
import mx.styles.IStyleModule;

class StyleEventDispatcher extends EventDispatcher 
{

    public function StyleEventDispatcher(moduleInfo:IModuleInfo)
    {
        moduleInfo.addEventListener(ModuleEvent.PROGRESS, this.moduleInfo_progressHandler, false, 0, true);
        moduleInfo.addEventListener(ModuleEvent.READY, this.moduleInfo_readyHandler, false, 0, true);
    }

    /*private*/ function moduleInfo_progressHandler(event:ModuleEvent):void
    {
        var styleEvent:StyleEvent = new StyleEvent(StyleEvent.PROGRESS, event.bubbles, event.cancelable);
        styleEvent.bytesLoaded = event.bytesLoaded;
        styleEvent.bytesTotal = event.bytesTotal;
        dispatchEvent(styleEvent);
    }

    /*private*/ function moduleInfo_readyHandler(event:ModuleEvent):void
    {
        var styleEvent:StyleEvent = new StyleEvent(StyleEvent.COMPLETE);
        styleEvent.bytesLoaded = event.bytesLoaded;
        styleEvent.bytesTotal = event.bytesTotal;
        dispatchEvent(styleEvent);
    }


}

class StyleModuleInfo 
{

    public var errorHandler:Function;
    public var readyHandler:Function;
    public var styleModule:IStyleModule;
    public var module:IModuleInfo;

    public function StyleModuleInfo(module:IModuleInfo, readyHandler:Function, errorHandler:Function)
    {
        this.module = module;
        this.readyHandler = readyHandler;
        this.errorHandler = errorHandler;
    }

}

class CSSClass 
{

    public static const CSSSelector:int = 0;
    public static const CSSCondition:int = 1;
    public static const CSSStyleDeclaration:int = 2;


}

class CSSFactory 
{

    public static const DefaultFactory:int = 0;
    public static const Factory:int = 1;
    public static const Override:int = 2;


}

class CSSDataType 
{

    public static const Native:int = 0;
    public static const Definition:int = 1;


}


