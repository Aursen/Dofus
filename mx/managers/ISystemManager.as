package mx.managers
{
    import flash.events.IEventDispatcher;
    import mx.core.IChildList;
    import mx.core.IFlexModuleFactory;
    import flash.display.Sprite;
    import flash.display.LoaderInfo;
    import flash.geom.Rectangle;
    import flash.display.Stage;
    import flash.text.TextFormat;
    import flash.display.DisplayObject;

    public interface ISystemManager extends IEventDispatcher, IChildList, IFlexModuleFactory 
    {

        function get cursorChildren():IChildList;
        function get document():Object;
        function set document(_arg_1:Object):void;
        function get embeddedFontList():Object;
        function get focusPane():Sprite;
        function set focusPane(_arg_1:Sprite):void;
        function get isProxy():Boolean;
        function get loaderInfo():LoaderInfo;
        function get numModalWindows():int;
        function set numModalWindows(_arg_1:int):void;
        function get popUpChildren():IChildList;
        function get rawChildren():IChildList;
        function get screen():Rectangle;
        function get stage():Stage;
        function get toolTipChildren():IChildList;
        function get topLevelSystemManager():ISystemManager;
        function getDefinitionByName(_arg_1:String):Object;
        function isTopLevel():Boolean;
        function isFontFaceEmbedded(_arg_1:TextFormat):Boolean;
        function isTopLevelRoot():Boolean;
        function getTopLevelRoot():DisplayObject;
        function getSandboxRoot():DisplayObject;
        function getVisibleApplicationRect(_arg_1:Rectangle=null, _arg_2:Boolean=false):Rectangle;
        function deployMouseShields(_arg_1:Boolean):void;
        function invalidateParentSizeAndDisplayList():void;

    }
} mx.managers

