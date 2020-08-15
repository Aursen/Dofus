package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_load extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_luaB_load;
            _local_1 = new (FSM_luaB_load)();
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
                    public::mstate.esp = (public::mstate.esp - 64);
                    this.i0 = 2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i2 = _luaO_nilobject_;
                    if (!(!(this.i0 == this.i2)))
                    {
                        
                    _label_1: 
                        this.i0 = __2E_str52342;
                        goto _label_2;
                    };
                    this.i0 = li32(this.i0 + 8);
                    if (this.i0 < 1) goto _label_1;
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 2;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_checklstring.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_2: 
                    this.i2 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = _luaO_nilobject_;
                    if (!(this.i2 == this.i3))
                    {
                        this.i2 = li32(this.i2 + 8);
                        if (this.i2 == 6) goto _label_3;
                    };
                    this.i2 = 6;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tag_error.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    this.i2 = li32(this.i1 + 12);
                    this.i3 = li32(this.i1 + 8);
                    this.i4 = (this.i1 + 12);
                    this.i5 = (this.i1 + 8);
                    this.i6 = (this.i2 + 36);
                    if (!(uint(this.i3) < uint(this.i6)))
                    {
                        this.i3 = this.i2;
                        goto _label_5;
                    };
                    
                _label_4: 
                    this.i2 = 0;
                    si32(this.i2, (this.i3 + 8));
                    this.i3 = (this.i3 + 12);
                    si32(this.i3, this.i5);
                    this.i2 = li32(this.i4);
                    this.i6 = (this.i2 + 36);
                    if (uint(this.i3) < uint(this.i6)) goto _label_4;
                    this.i3 = this.i2;
                    
                _label_5: 
                    this.i2 = this.i3;
                    this.i3 = _generic_reader;
                    this.i2 = (this.i2 + 36);
                    si32(this.i2, this.i5);
                    si32(this.i1, (public::mstate.ebp + -48));
                    si32(this.i3, (public::mstate.ebp + -56));
                    this.i3 = 0;
                    si32(this.i3, (public::mstate.ebp + -52));
                    si32(this.i3, (public::mstate.ebp + -64));
                    si32(this.i3, (public::mstate.ebp + -60));
                    this.i4 = (public::mstate.ebp + -64);
                    this.i5 = __2E_str6354;
                    si32(this.i4, (public::mstate.ebp + -32));
                    this.i0 = ((this.i0 == 0) ? this.i5 : this.i0);
                    si32(this.i0, (public::mstate.ebp + -16));
                    si32(this.i3, (public::mstate.ebp + -28));
                    si32(this.i3, (public::mstate.ebp + -20));
                    this.i0 = li32(this.i1 + 32);
                    this.i4 = li32(this.i1 + 108);
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i5 = _f_parser;
                    this.i0 = (this.i2 - this.i0);
                    this.i2 = (public::mstate.ebp + -32);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i0, (public::mstate.esp + 12));
                    si32(this.i4, (public::mstate.esp + 16));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_pcall.start();
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i2 = li32(this.i1 + 16);
                    this.i4 = li32(public::mstate.ebp + -20);
                    this.i5 = li32(public::mstate.ebp + -28);
                    this.i6 = li32(this.i2 + 12);
                    this.i7 = li32(this.i2 + 16);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i6]());
                    return;
                case 6:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i3 = li32(this.i2 + 68);
                    this.i3 = (this.i3 - this.i4);
                    si32(this.i3, (this.i2 + 68));
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_load_aux.start();
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaB_load");
            };
        }


    }
}

