package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;

    public function modPreStaticInit():void
    {
        var _local_1:int;
        if (gpreStaticInits)
        {
            _local_1 = 0;
            while (_local_1 < gpreStaticInits.length)
            {
                var _local_2:* = gpreStaticInits;
                (_local_2[_local_1]());
                _local_1++;
            };
        };
    }

}

