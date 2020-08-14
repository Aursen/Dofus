package mx.core
{
    import flash.display.Sprite;
    import flash.display.DisplayObjectContainer;
    import mx.managers.ISystemManager;
    import flash.display.DisplayObject;

    public interface IUIComponent extends IFlexDisplayObject 
    {

        function get baselinePosition():Number;
        function get document():Object;
        function set document(_arg_1:Object):void;
        function get enabled():Boolean;
        function set enabled(_arg_1:Boolean):void;
        function get explicitHeight():Number;
        function set explicitHeight(_arg_1:Number):void;
        function get explicitMaxHeight():Number;
        function get explicitMaxWidth():Number;
        function get explicitMinHeight():Number;
        function get explicitMinWidth():Number;
        function get explicitWidth():Number;
        function set explicitWidth(_arg_1:Number):void;
        function get focusPane():Sprite;
        function set focusPane(_arg_1:Sprite):void;
        function get includeInLayout():Boolean;
        function set includeInLayout(_arg_1:Boolean):void;
        function get isPopUp():Boolean;
        function set isPopUp(_arg_1:Boolean):void;
        function get maxHeight():Number;
        function get maxWidth():Number;
        function get measuredMinHeight():Number;
        function set measuredMinHeight(_arg_1:Number):void;
        function get measuredMinWidth():Number;
        function set measuredMinWidth(_arg_1:Number):void;
        function get minHeight():Number;
        function get minWidth():Number;
        function get owner():DisplayObjectContainer;
        function set owner(_arg_1:DisplayObjectContainer):void;
        function get percentHeight():Number;
        function set percentHeight(_arg_1:Number):void;
        function get percentWidth():Number;
        function set percentWidth(_arg_1:Number):void;
        function get systemManager():ISystemManager;
        function set systemManager(_arg_1:ISystemManager):void;
        function get tweeningProperties():Array;
        function set tweeningProperties(_arg_1:Array):void;
        function initialize():void;
        function parentChanged(_arg_1:DisplayObjectContainer):void;
        function getExplicitOrMeasuredWidth():Number;
        function getExplicitOrMeasuredHeight():Number;
        function setVisible(_arg_1:Boolean, _arg_2:Boolean=false):void;
        function owns(_arg_1:DisplayObject):Boolean;

    }
} mx.core

