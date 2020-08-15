package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;

    public function modPostStaticInit():void
    {
        var _local_1:int;
        if (gpostStaticInits)
        {
            _local_1 = 0;
            while (_local_1 < gpostStaticInits.length)
            {
                var _local_2:* = gpostStaticInits;
                (_local_2[_local_1]());
                _local_1++;
            };
        };
    }

}

