package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;

    public class FSM__setjmp extends Machine 
    {


        public static function start():void
        {
            gstate.gworker = new (FSM__setjmp)();
            throw (new AlchemyDispatch());
        }


        override public function work():void
        {
            var _local_1:int;
            var _local_2:Machine;
            public::mstate.pop();
            _local_1 = _mr32(public::mstate.esp);
            _mw32((_local_1 + 0), 667788);
            _mw32((_local_1 + 4), caller.state);
            _mw32((_local_1 + 8), public::mstate.esp);
            _mw32((_local_1 + 12), public::mstate.ebp);
            _mw32((_local_1 + 16), 887766);
            log(4, ("setjmp: " + _local_1));
            _local_2 = findMachineForESP(public::mstate.esp);
            if (_local_2)
            {
                delete gsetjmpMachine2ESPMap[_local_2];
            };
            gsetjmpMachine2ESPMap[caller] = public::mstate.esp;
            public::mstate.gworker = caller;
            public::mstate.eax = 0;
        }


    }
} cmodule.lua_wrapper

