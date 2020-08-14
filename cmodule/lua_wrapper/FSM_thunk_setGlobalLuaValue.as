package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_thunk_setGlobalLuaValue extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;


        public static function start():void
        {
            var _local_1:FSM_thunk_setGlobalLuaValue;
            _local_1 = new (FSM_thunk_setGlobalLuaValue)();
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
                    public::mstate.esp = (public::mstate.esp - 28);
                    this.i0 = __2E_str15114;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = (public::mstate.ebp + -28);
                    this.i3 = (public::mstate.ebp + -24);
                    this.i4 = (public::mstate.ebp + -20);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i2, (public::mstate.esp + 16));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[_AS3_ArrayValue]());
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i0 = li32(public::mstate.ebp + -28);
                    this.i1 = li32(public::mstate.ebp + -24);
                    this.i2 = li32(public::mstate.ebp + -20);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_push_as3_to_lua_stack.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -10002;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = li8(this.i1);
                    this.i4 = this.i1;
                        
                    outer_block:
                    {

                        if (!(this.i3 == 0))
                        {
                            this.i3 = this.i1;
                            do 
                            {
                                this.i5 = li8(this.i3 + 1);
                                this.i3 = (this.i3 + 1);
                                this.i6 = this.i3;
                                if (this.i5 == 0) break outer_block;
                                this.i3 = this.i6;
                            } while (true);
                        };
                        this.i3 = this.i4;
                    
                    }//outer_block
                    this.i5 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = (this.i3 - this.i1);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 4:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i1, (public::mstate.ebp + -16));
                    si32(this.i5, (public::mstate.ebp + -8));
                    this.i1 = li32(this.i2 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i1 = (this.i1 + -12);
                    this.i3 = (public::mstate.ebp + -16);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i2 + 8);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _thunk_setGlobalLuaValue");
            };
        }


    }
} cmodule.lua_wrapper

