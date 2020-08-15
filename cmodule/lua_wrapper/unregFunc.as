package cmodule.lua_wrapper
{
    public function unregFunc(_arg_1:int):void
    {
        if ((_arg_1 + 1) == gstate.funcs.length)
        {
            gstate.funcs.pop();
        };
    }

}

