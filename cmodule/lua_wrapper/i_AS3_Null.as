package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Null:int = cmodule.lua_wrapper.exportSym("_AS3_Null", new CProcTypemap(CTypemap.AS3ValType, []).createC(function ():*
    {
        return (null);
    })[0]);
} cmodule.lua_wrapper

