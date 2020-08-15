package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal function AS3_Object(_arg_1:String, _arg_2:int):*
    {
        var _local_3:Object;
        var _local_4:Array;
        var _local_5:int;
        var _local_6:String;
        var _local_7:CTypemap;
        var _local_8:int;
        var _local_9:Array;
        _local_3 = {};
        if (((!(_arg_1)) || (!(_arg_1.length))))
        {
            return (_local_3);
        };
        _local_4 = _arg_1.split(/\s*[,\:]\s*/);
        _local_5 = 0;
        while (_local_5 < _local_4.length)
        {
            _local_6 = _local_4[_local_5];
            _local_7 = CTypemap.getTypeByName(_local_4[(_local_5 + 1)]);
            _local_8 = _local_7.typeSize;
            _local_9 = [];
            mstate.ds.position = _arg_2;
            _arg_2 = (_arg_2 + _local_8);
            while (_local_8)
            {
                _local_9.push(mstate.ds.readInt());
                _local_8 = (_local_8 - 4);
            };
            _local_3[_local_6] = _local_7.fromC(_local_9);
            _local_5 = (_local_5 + 2);
        };
        return (_local_3);
    }

}

