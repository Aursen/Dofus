package cmodule.lua_wrapper
{
    public function vgl_end(_arg_1:int):int
    {
        var _local_2:int;
        _local_2 = gvglpixels;
        gvglpixels = 0;
        return (_local_2);
    }

} cmodule.lua_wrapper

