package cmodule.lua_wrapper
{
    internal function AS3_FunctionAsync(data:int, func:Function):Function
    {
        return (function (... _args):*
        {
            var _local_2:*;
            _local_2 = _args.shift();
            return (func(_local_2, data, _args));
        });
    }

} cmodule.lua_wrapper

