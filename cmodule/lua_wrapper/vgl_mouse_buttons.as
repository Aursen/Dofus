package cmodule.lua_wrapper
{
    import flash.display.Stage;
    import cmodule.lua_wrapper.vglMouseFirst;
    import cmodule.lua_wrapper.gsprite;
    import flash.events.MouseEvent;
    import cmodule.lua_wrapper.vglMouseButtons;

    internal function vgl_mouse_buttons():int
    {
        var stage:Stage;
        if (vglMouseFirst)
        {
            stage = gsprite.stage;
            stage.addEventListener(MouseEvent.MOUSE_DOWN, function (_arg_1:MouseEvent):*
            {
                vglMouseButtons = 1;
            });
            stage.addEventListener(MouseEvent.MOUSE_UP, function (_arg_1:MouseEvent):*
            {
                vglMouseButtons = 0;
            });
            vglMouseFirst = false;
        };
        return (vglMouseButtons);
    }

}

