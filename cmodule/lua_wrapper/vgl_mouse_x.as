package cmodule.lua_wrapper
{
    import flash.display.Stage;
    import cmodule.lua_wrapper.gsprite;

    internal function vgl_mouse_x():int
    {
        var _local_1:Stage;
        _local_1 = gsprite.stage;
        return (_local_1.mouseX);
    }

}

