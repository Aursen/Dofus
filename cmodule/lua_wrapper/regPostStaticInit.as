package cmodule.lua_wrapper
{
    public function regPostStaticInit(_arg_1:Function):void
    {
        if (!gpostStaticInits)
        {
            gpostStaticInits = [];
        };
        gpostStaticInits.push(_arg_1);
    }

} cmodule.lua_wrapper

