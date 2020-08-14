package mx.styles
{
    public interface IStyleClient extends ISimpleStyleClient 
    {

        function get className():String;
        function get inheritingStyles():Object;
        function set inheritingStyles(_arg_1:Object):void;
        function get nonInheritingStyles():Object;
        function set nonInheritingStyles(_arg_1:Object):void;
        function get styleDeclaration():CSSStyleDeclaration;
        function set styleDeclaration(_arg_1:CSSStyleDeclaration):void;
        function getStyle(_arg_1:String):*;
        function setStyle(_arg_1:String, _arg_2:*):void;
        function clearStyle(_arg_1:String):void;
        function getClassStyleDeclarations():Array;
        function notifyStyleChangeInChildren(_arg_1:String, _arg_2:Boolean):void;
        function regenerateStyleCache(_arg_1:Boolean):void;
        function registerEffects(_arg_1:Array):void;

    }
} mx.styles

