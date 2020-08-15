package com.ankama.zaap
{
    public interface ZaapService 
    {

        function connect(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:String, _arg_5:Function, _arg_6:Function):void;
        function auth_getGameToken(_arg_1:String, _arg_2:int, _arg_3:Function, _arg_4:Function):void;
        function updater_isUpdateAvailable(_arg_1:String, _arg_2:Function, _arg_3:Function):void;
        function settings_get(_arg_1:String, _arg_2:String, _arg_3:Function, _arg_4:Function):void;
        function settings_set(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Function, _arg_5:Function):void;
        function userInfo_get(_arg_1:String, _arg_2:Function, _arg_3:Function):void;
        function release_restartOnExit(_arg_1:String, _arg_2:Function, _arg_3:Function):void;
        function release_exitAndRepair(_arg_1:String, _arg_2:Boolean, _arg_3:Function, _arg_4:Function):void;
        function zaapVersion_get(_arg_1:String, _arg_2:Function, _arg_3:Function):void;
        function zaapMustUpdate_get(_arg_1:String, _arg_2:Function, _arg_3:Function):void;

    }
}

