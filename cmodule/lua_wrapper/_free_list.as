package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.gstaticInitter;

    internal const _free_list:int = gstaticInitter.alloc(20, 8);
}

