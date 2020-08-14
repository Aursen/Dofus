package mx.styles
{
    import flash.system.ApplicationDomain;
    import flash.system.SecurityDomain;
    import flash.events.IEventDispatcher;

    public interface IStyleManager2 extends IStyleManager 
    {

        function get parent():IStyleManager2;
        function get qualifiedTypeSelectors():Boolean;
        function set qualifiedTypeSelectors(_arg_1:Boolean):void;
        function get selectors():Array;
        function get typeHierarchyCache():Object;
        function set typeHierarchyCache(_arg_1:Object):void;
        function getStyleDeclarations(_arg_1:String):Object;
        function getMergedStyleDeclaration(_arg_1:String):CSSStyleDeclaration;
        function hasPseudoCondition(_arg_1:String):Boolean;
        function hasAdvancedSelectors():Boolean;
        function loadStyleDeclarations2(_arg_1:String, _arg_2:Boolean=true, _arg_3:ApplicationDomain=null, _arg_4:SecurityDomain=null):IEventDispatcher;
        function acceptMediaList(_arg_1:String):Boolean;

    }
} mx.styles

