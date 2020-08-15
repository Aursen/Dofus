package cmodule.lua_wrapper
{
    public function memset(_arg_1:int, _arg_2:int, _arg_3:int):int
    {
        var _local_4:int;
        _local_4 = (((_arg_2 | (_arg_2 << 8)) | (_arg_2 << 16)) | (_arg_2 << 24));
        gstate.ds.position = _arg_1;
        while (_arg_3 >= 4)
        {
            gstate.ds.writeUnsignedInt(_local_4);
            _arg_3 = (_arg_3 - 4);
        };
        while (_arg_3--)
        {
            gstate.ds.writeByte(_arg_2);
        };
        return (_arg_1);
    }

}

