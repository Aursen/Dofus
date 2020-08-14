package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaD_throw extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_luaD_throw;
            _local_1 = new (FSM_luaD_throw)();
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
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(this.i0 + 104);
                    this.i2 = (this.i0 + 104);
                    this.i3 = li32(public::mstate.ebp + 12);
                    if (this.i1 == 0) goto _label_1;
                    this.i0 = 1;
                    si32(this.i3, (this.i1 + 52));
                    this.i2 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 + 4);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[__longjmp]());
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    si8(this.i3, (this.i0 + 6));
                    this.i1 = li32(this.i0 + 16);
                    this.i1 = li32(this.i1 + 88);
                    this.i4 = (this.i0 + 16);
                    if (this.i1 == 0) goto _label_6;
                    this.i1 = li32(this.i0 + 40);
                    si32(this.i1, (this.i0 + 20));
                    this.i1 = li32(this.i1);
                    si32(this.i1, (this.i0 + 12));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaF_close.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i1 = li32(this.i0 + 12);
                    this.i5 = (this.i3 + -2);
                    if (uint(this.i5) < uint(2)) goto _label_3;
                    if (this.i3 == 5) goto _label_2;
                    if (!(this.i3 == 4)) goto _label_4;
                    this.i3 = __2E_str111;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 17;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i1);
                    this.i3 = 4;
                    si32(this.i3, (this.i1 + 8));
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, (this.i0 + 8));
                    goto _label_5;
                    
                _label_2: 
                    this.i3 = __2E_str212;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = 23;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 4:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, this.i1);
                    this.i3 = 4;
                    si32(this.i3, (this.i1 + 8));
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, (this.i0 + 8));
                    goto _label_5;
                    
                _label_3: 
                    this.i3 = li32(this.i0 + 8);
                    this.f0 = lf64(this.i3 + -12);
                    sf64(this.f0, this.i1);
                    this.i3 = li32(this.i3 + -4);
                    si32(this.i3, (this.i1 + 8));
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, (this.i0 + 8));
                    goto _label_5;
                    
                _label_4: 
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, (this.i0 + 8));
                    
                _label_5: 
                    this.i1 = 1;
                    this.i3 = li16(this.i0 + 54);
                    si16(this.i3, (this.i0 + 52));
                    si8(this.i1, (this.i0 + 57));
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_restore_stack_limit.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i3 = 0;
                    si32(this.i3, (this.i0 + 108));
                    si32(this.i3, this.i2);
                    this.i2 = li32(this.i4);
                    this.i2 = li32(this.i2 + 88);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i2]());
                    return;
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    goto _label_7;
                    
                _label_6: 
                    this.i0 = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    
                _label_7: 
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_exit.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 4);
                default:
                    throw ("Invalid state in _luaD_throw");
            };
        }


    }
} cmodule.lua_wrapper

