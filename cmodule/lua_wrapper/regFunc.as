package cmodule.lua_wrapper
{
    public function regFunc(_arg_1:Function):int
    {
        return (gstate.funcs.push(_arg_1) - 1);
    }

} cmodule.lua_wrapper

