package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.DynamicProxy;

    internal function AS3_Proxy():*
    {
        return (new DynamicProxy());
    }

}

