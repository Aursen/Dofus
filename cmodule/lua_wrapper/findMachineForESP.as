package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.gsetjmpMachine2ESPMap;
    import cmodule.lua_wrapper.Machine;
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal function findMachineForESP(_arg_1:int):Machine
    {
        var _local_2:Object;
        for (_local_2 in gsetjmpMachine2ESPMap)
        {
            if (gsetjmpMachine2ESPMap[_local_2] == _arg_1)
            {
                return (Machine(_local_2));
            };
        };
        return (null);
    }

}

