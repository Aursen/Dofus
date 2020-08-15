package cmodule.lua_wrapper
{
    internal interface ICAllocator 
    {

        function free(_arg_1:int):void;
        function alloc(_arg_1:int):int;

    }
}

