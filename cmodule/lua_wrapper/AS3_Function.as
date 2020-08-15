package cmodule.lua_wrapper
{
    internal function AS3_Function(data:int, func:Function):Function
    {
        return (function (... _args):*
        {
            return (func(data, _args));
        });
    }

}

