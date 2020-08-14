package mx.styles
{
    import flash.system.ApplicationDomain;
    import flash.system.SecurityDomain;
    import flash.events.IEventDispatcher;

    public interface IStyleManager 
    {

        function get inheritingStyles():Object;
        function set inheritingStyles(_arg_1:Object):void;
        function get stylesRoot():Object;
        function set stylesRoot(_arg_1:Object):void;
        function get typeSelectorCache():Object;
        function set typeSelectorCache(_arg_1:Object):void;
        function getStyleDeclaration(_arg_1:String):CSSStyleDeclaration;
        function setStyleDeclaration(_arg_1:String, _arg_2:CSSStyleDeclaration, _arg_3:Boolean):void;
        function clearStyleDeclaration(_arg_1:String, _arg_2:Boolean):void;
        function registerInheritingStyle(_arg_1:String):void;
        function isInheritingStyle(_arg_1:String):Boolean;
        function isInheritingTextFormatStyle(_arg_1:String):Boolean;
        function registerSizeInvalidatingStyle(_arg_1:String):void;
        function isSizeInvalidatingStyle(_arg_1:String):Boolean;
        function registerParentSizeInvalidatingStyle(_arg_1:String):void;
        function isParentSizeInvalidatingStyle(_arg_1:String):Boolean;
        function registerParentDisplayListInvalidatingStyle(_arg_1:String):void;
        function isParentDisplayListInvalidatingStyle(_arg_1:String):Boolean;
        function registerColorName(_arg_1:String, _arg_2:uint):void;
        function isColorName(_arg_1:String):Boolean;
        function getColorName(_arg_1:Object):uint;
        function getColorNames(_arg_1:Array):void;
        function isValidStyleValue(_arg_1:*):Boolean;
        function loadStyleDeclarations(_arg_1:String, _arg_2:Boolean=true, _arg_3:Boolean=false, _arg_4:ApplicationDomain=null, _arg_5:SecurityDomain=null):IEventDispatcher;
        function unloadStyleDeclarations(_arg_1:String, _arg_2:Boolean=true):void;
        function initProtoChainRoots():void;
        function styleDeclarationsChanged():void;

    }
} mx.styles

