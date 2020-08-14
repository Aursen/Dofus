package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_True:int = cmodule.lua_wrapper.exportSym("_AS3_True", new CProcTypemap(CTypemap.AS3ValType, []).createC(function ():Boolean
    {
        return (true);
    })[0]);
} cmodule.lua_wrapper

