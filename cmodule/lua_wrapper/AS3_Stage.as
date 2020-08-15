package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.gsprite;

    internal function AS3_Stage():Object
    {
        return ((gsprite) ? gsprite.stage : null);
    }

}

