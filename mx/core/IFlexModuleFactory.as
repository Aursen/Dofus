package mx.core
{
    import flash.utils.Dictionary;
    import flash.display.LoaderInfo;
    import __AS3__.vec.Vector;

    public interface IFlexModuleFactory 
    {

        function get allowDomainsInNewRSLs():Boolean;
        function set allowDomainsInNewRSLs(_arg_1:Boolean):void;
        function get allowInsecureDomainsInNewRSLs():Boolean;
        function set allowInsecureDomainsInNewRSLs(_arg_1:Boolean):void;
        function get preloadedRSLs():Dictionary;
        function addPreloadedRSL(_arg_1:LoaderInfo, _arg_2:Vector.<RSLData>):void;
        function allowDomain(... _args):void;
        function allowInsecureDomain(... _args):void;
        function callInContext(_arg_1:Function, _arg_2:Object, _arg_3:Array, _arg_4:Boolean=true):*;
        function create(... _args):Object;
        function getImplementation(_arg_1:String):Object;
        function info():Object;
        function registerImplementation(_arg_1:String, _arg_2:Object):void;

    }
} mx.core

