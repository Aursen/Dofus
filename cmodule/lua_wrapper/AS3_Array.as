package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal function AS3_Array(_arg_1:String, _arg_2:int):*
    {
        var _local_3:Array;
        var _local_4:Array;
        var _local_5:int;
        var _local_6:CTypemap;
        var _local_7:int;
        var _local_8:Array;
        _local_3 = [];
        if (((!(_arg_1)) || (!(_arg_1.length))))
        {
            return (_local_3);
        };
        _local_4 = CTypemap.getTypesByNames(_arg_1);
        _local_5 = 0;
        while (_local_5 < _local_4.length)
        {
            _local_6 = _local_4[_local_5];
            _local_7 = _local_6.typeSize;
            _local_8 = [];
            mstate.ds.position = _arg_2;
            _arg_2 = (_arg_2 + _local_7);
            while (_local_7)
            {
                _local_8.push(mstate.ds.readInt());
                _local_7 = (_local_7 - 4);
            };
            _local_3.push(_local_6.fromC(_local_8));
            _local_5++;
        };
        return (_local_3);
    }

} cmodule.lua_wrapper

