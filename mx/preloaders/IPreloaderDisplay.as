package mx.preloaders
{
    import flash.events.IEventDispatcher;
    import flash.display.Sprite;

    public interface IPreloaderDisplay extends IEventDispatcher 
    {

        function get backgroundAlpha():Number;
        function set backgroundAlpha(_arg_1:Number):void;
        function get backgroundColor():uint;
        function set backgroundColor(_arg_1:uint):void;
        function get backgroundImage():Object;
        function set backgroundImage(_arg_1:Object):void;
        function get backgroundSize():String;
        function set backgroundSize(_arg_1:String):void;
        function set preloader(_arg_1:Sprite):void;
        function get stageHeight():Number;
        function set stageHeight(_arg_1:Number):void;
        function get stageWidth():Number;
        function set stageWidth(_arg_1:Number):void;
        function initialize():void;

    }
}

