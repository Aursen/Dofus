package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_release_callback extends Machine 
    {

        public static const intRegCount:int = 5;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;


        public static function start():void
        {
            var _local_1:FSM_release_callback;
            _local_1 = new (FSM_release_callback)();
            gstate.gworker = _local_1;
        }


        final override public function work():void
        {
            switch (state)
            {
                case 0:
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(public::mstate.ebp, public::mstate.esp);
                    public::mstate.ebp = public::mstate.esp;
                    public::mstate.esp = (public::mstate.esp - 0);
                    this.i0 = __2E_str185;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checkudata.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i0 == 0) goto _label_4;
                    this.i1 = li32(this.i0);
                    if (this.i1 == 0) goto _label_4;
                    this.i2 = li32(this.i1);
                    this.i3 = this.i1;
                    if (this.i2 == 0) goto _label_2;
                    this.i2 = li32(this.i1 + 8);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Undefined]());
                    return;
                case 2:
                    this.i4 = public::mstate.eax;
                    this.i1 = (this.i1 + 8);
                    if (this.i2 == this.i4) goto _label_1;
                    this.i2 = li32(this.i1);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Release]());
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 4);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_Undefined]());
                    return;
                case 4:
                    this.i2 = public::mstate.eax;
                    si32(this.i2, this.i1);
                    
                _label_1: 
                    this.i1 = 0;
                    si32(this.i1, this.i3);
                    goto _label_3;
                    
                _label_2: 
                    this.i1 = 0;
                    
                _label_3: 
                    si32(this.i1, this.i0);
                    public::mstate.eax = this.i1;
                    goto _label_5;
                    
                _label_4: 
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    
                _label_5: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _release_callback");
            };
        }


    }
}

