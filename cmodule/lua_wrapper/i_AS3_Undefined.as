package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.exportSym;

    internal const i_AS3_Undefined:int = cmodule.lua_wrapper.exportSym("_AS3_Undefined", new CProcTypemap(CTypemap.AS3ValType, []).createC(function ():*
    {
        return (undefined);
    })[0]);
}

