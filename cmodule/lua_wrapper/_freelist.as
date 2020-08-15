package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.gstaticInitter;

    internal const _freelist:int = gstaticInitter.alloc(64, 4);
}

