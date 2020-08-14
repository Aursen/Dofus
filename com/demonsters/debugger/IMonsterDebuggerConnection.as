package com.demonsters.debugger
{
    internal interface IMonsterDebuggerConnection 
    {

        function processQueue():void;
        function set address(_arg_1:String):void;
        function get connected():Boolean;
        function connect():void;
        function send(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false):void;

    }
} com.demonsters.debugger

