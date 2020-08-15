package mx.resources
{
    import flash.events.IEventDispatcher;
    import flash.system.ApplicationDomain;
    import flash.system.SecurityDomain;

    public interface IResourceManager extends IEventDispatcher 
    {

        function get localeChain():Array;
        function set localeChain(_arg_1:Array):void;
        function loadResourceModule(_arg_1:String, _arg_2:Boolean=true, _arg_3:ApplicationDomain=null, _arg_4:SecurityDomain=null):IEventDispatcher;
        function unloadResourceModule(_arg_1:String, _arg_2:Boolean=true):void;
        function addResourceBundle(_arg_1:IResourceBundle, _arg_2:Boolean=false):void;
        function removeResourceBundle(_arg_1:String, _arg_2:String):void;
        function removeResourceBundlesForLocale(_arg_1:String):void;
        function update():void;
        function getLocales():Array;
        function getPreferredLocaleChain():Array;
        function getBundleNamesForLocale(_arg_1:String):Array;
        function getResourceBundle(_arg_1:String, _arg_2:String):IResourceBundle;
        function findResourceBundleWithResource(_arg_1:String, _arg_2:String):IResourceBundle;
        [Bindable("change")]
        function getObject(_arg_1:String, _arg_2:String, _arg_3:String=null):*;
        [Bindable("change")]
        function getString(_arg_1:String, _arg_2:String, _arg_3:Array=null, _arg_4:String=null):String;
        [Bindable("change")]
        function getStringArray(_arg_1:String, _arg_2:String, _arg_3:String=null):Array;
        [Bindable("change")]
        function getNumber(_arg_1:String, _arg_2:String, _arg_3:String=null):Number;
        [Bindable("change")]
        function getInt(_arg_1:String, _arg_2:String, _arg_3:String=null):int;
        [Bindable("change")]
        function getUint(_arg_1:String, _arg_2:String, _arg_3:String=null):uint;
        [Bindable("change")]
        function getBoolean(_arg_1:String, _arg_2:String, _arg_3:String=null):Boolean;
        [Bindable("change")]
        function getClass(_arg_1:String, _arg_2:String, _arg_3:String=null):Class;
        function installCompiledResourceBundles(_arg_1:ApplicationDomain, _arg_2:Array, _arg_3:Array, _arg_4:Boolean=false):Array;
        function initializeLocaleChain(_arg_1:Array):void;

    }
}

