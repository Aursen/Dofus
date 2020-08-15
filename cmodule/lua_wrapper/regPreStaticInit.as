package cmodule.lua_wrapper
{
    public function regPreStaticInit(_arg_1:Function):void
    {
        if (!gpreStaticInits)
        {
            gpreStaticInits = [];
        };
        gpreStaticInits.push(_arg_1);
    }

}

