package mx.modules
{
    import flash.events.IEventDispatcher;
    import mx.core.IFlexModuleFactory;
    import flash.system.ApplicationDomain;
    import flash.system.SecurityDomain;
    import flash.utils.ByteArray;

    [Event(name="error", type="mx.events.ModuleEvent")]
    [Event(name="progress", type="mx.events.ModuleEvent")]
    [Event(name="ready", type="mx.events.ModuleEvent")]
    [Event(name="setup", type="mx.events.ModuleEvent")]
    [Event(name="unload", type="mx.events.ModuleEvent")]
    public interface IModuleInfo extends IEventDispatcher 
    {

        function get data():Object;
        function set data(_arg_1:Object):void;
        function get error():Boolean;
        function get factory():IFlexModuleFactory;
        function get loaded():Boolean;
        function get ready():Boolean;
        function get setup():Boolean;
        function get url():String;
        function load(_arg_1:ApplicationDomain=null, _arg_2:SecurityDomain=null, _arg_3:ByteArray=null, _arg_4:IFlexModuleFactory=null):void;
        function release():void;
        function unload():void;
        function publish(_arg_1:IFlexModuleFactory):void;

    }
}

