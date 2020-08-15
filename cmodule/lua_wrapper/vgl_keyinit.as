package cmodule.lua_wrapper
{
    public function vgl_keyinit(_arg_1:int):int
    {
        trace(("vgl_keymode: " + _arg_1));
        vglKeyMode = _arg_1;
        return (0);
    }

}

