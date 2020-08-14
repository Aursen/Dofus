package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_str_dump extends Machine 
    {

        public static const intRegCount:int = 10;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var i7:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_str_dump;
            _local_1 = new (FSM_str_dump)();
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
                    public::mstate.esp = (public::mstate.esp - 1088);
                    this.i0 = 1;
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
                    if (!(this.i0 == this.i2))
                    {
                        this.i0 = li32(this.i0 + 8);
                        if (this.i0 == 6) goto _label_1;
                    };
                    this.i0 = 6;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tag_error.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    this.i0 = li32(this.i1 + 12);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = (this.i1 + 12);
                    this.i4 = (this.i1 + 8);
                    this.i5 = (this.i0 + 12);
                    if (!(uint(this.i2) < uint(this.i5)))
                    {
                        this.i2 = this.i0;
                        goto _label_3;
                        
                    _label_2: 
                        this.i2 = this.i0;
                    };
                    this.i0 = 0;
                    si32(this.i0, (this.i2 + 8));
                    this.i0 = (this.i2 + 12);
                    si32(this.i0, this.i4);
                    this.i5 = li32(this.i3);
                    if (this.i2 < this.i5) goto _label_2;
                    this.i2 = this.i5;
                    
                _label_3: 
                    this.i0 = this.i2;
                    this.i2 = (public::mstate.ebp + -1088);
                    this.i3 = (this.i0 + 12);
                    si32(this.i3, this.i4);
                    si32(this.i1, (public::mstate.ebp + -1080));
                    this.i3 = (this.i2 + 12);
                    si32(this.i3, (public::mstate.ebp + -1088));
                    this.i3 = 0;
                    si32(this.i3, (public::mstate.ebp + -1084));
                    this.i3 = li32(this.i0 + 8);
                    this.i4 = (this.i2 + 4);
                    this.i5 = (this.i2 + 8);
                    if (!(this.i3 == 6)) goto _label_5;
                    this.i0 = li32(this.i0);
                    this.i3 = li8(this.i0 + 6);
                    if (!(this.i3 == 0)) goto _label_5;
                    this.i3 = _writer;
                    this.i0 = li32(this.i0 + 16);
                    si32(this.i1, (public::mstate.ebp + -32));
                    si32(this.i3, (public::mstate.ebp + -28));
                    si32(this.i2, (public::mstate.ebp + -24));
                    this.i2 = 0;
                    si32(this.i2, (public::mstate.ebp + -20));
                    si32(this.i2, (public::mstate.ebp + -16));
                    this.i3 = 27;
                    this.i6 = 76;
                    this.i7 = 117;
                    this.i8 = 97;
                    si8(this.i3, (public::mstate.ebp + -48));
                    si8(this.i6, (public::mstate.ebp + -47));
                    si8(this.i7, (public::mstate.ebp + -46));
                    si8(this.i8, (public::mstate.ebp + -45));
                    this.i3 = 81;
                    si8(this.i3, (public::mstate.ebp + -44));
                    si8(this.i2, (public::mstate.ebp + -43));
                    this.i3 = 1;
                    si8(this.i3, (public::mstate.ebp + -42));
                    this.i3 = 4;
                    si8(this.i3, (public::mstate.ebp + -41));
                    si8(this.i3, (public::mstate.ebp + -40));
                    si8(this.i3, (public::mstate.ebp + -39));
                    this.i3 = 8;
                    si8(this.i3, (public::mstate.ebp + -38));
                    this.i3 = (public::mstate.ebp + -32);
                    si8(this.i2, (public::mstate.ebp + -37));
                    this.i2 = li32(public::mstate.ebp + -16);
                    this.i6 = (public::mstate.ebp + -48);
                    this.i7 = (this.i3 + 16);
                    this.i8 = (this.i3 + 8);
                    this.i9 = (this.i3 + 4);
                    if (!(this.i2 == 0)) goto _label_4;
                    this.i2 = 12;
                    this.i9 = li32(this.i9);
                    this.i8 = li32(this.i8);
                    this.i3 = li32(this.i3);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i8, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i9]());
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    si32(this.i2, this.i7);
                    
                _label_4: 
                    this.i2 = (public::mstate.ebp + -32);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_DumpFunction.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i7);
                    if (this.i0 == 0) goto _label_6;
                    
                _label_5: 
                    this.i0 = __2E_str18448;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = (public::mstate.ebp + -1088);
                    si32(this.i0, public::mstate.esp);
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 6:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i4 = li32(this.i4);
                    this.i5 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = 1;
                    public::mstate.eax = this.i4;
                    goto _label_7;
                    
                _label_6: 
                    this.i0 = (public::mstate.ebp + -1088);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i4);
                    this.i1 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 9:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 1;
                    public::mstate.eax = this.i0;
                    
                _label_7: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _str_dump");
            };
        }


    }
} cmodule.lua_wrapper

