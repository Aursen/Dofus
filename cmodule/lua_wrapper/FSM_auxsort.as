package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_auxsort extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var f0:Number;
        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;
        public var i8:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_auxsort;
            _local_1 = new (FSM_auxsort)();
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
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    if (this.i1 >= this.i2) goto _label_2;
                    this.i3 = (this.i0 + 8);
                    
                _label_1: 
                    this.i4 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 2:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i6 = li32(this.i3);
                    this.f0 = lf64(this.i5);
                    sf64(this.f0, this.i6);
                    this.i5 = li32(this.i5 + 8);
                    si32(this.i5, (this.i6 + 8));
                    this.i5 = li32(this.i3);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 4:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i3);
                    this.f0 = lf64(this.i4);
                    sf64(this.f0, this.i5);
                    this.i4 = li32(this.i4 + 8);
                    si32(this.i4, (this.i5 + 8));
                    this.i4 = li32(this.i3);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = -2;
                    this.i5 = -1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sort_comp.start();
                    return;
                case 5:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i4 == 0) goto _label_3;
                    this.i4 = 1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = (this.i2 - this.i1);
                    if (!(this.i4 == 1))
                    {
                        goto _label_4;
                    };
                    
                _label_2: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_3: 
                    this.i4 = li32(this.i3);
                    this.i4 = (this.i4 + -24);
                    si32(this.i4, this.i3);
                    this.i4 = (this.i2 - this.i1);
                    if (this.i4 == 1) goto _label_2;
                    
                _label_4: 
                    this.i4 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 8:
                    this.i5 = public::mstate.eax;
                    this.i6 = (this.i1 + this.i2);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = (this.i6 >>> 31);
                    this.i5 = li32(this.i5);
                    this.i6 = (this.i6 + this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = (this.i6 >> 1);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 9:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i3);
                    this.f0 = lf64(this.i5);
                    sf64(this.f0, this.i7);
                    this.i5 = li32(this.i5 + 8);
                    si32(this.i5, (this.i7 + 8));
                    this.i5 = li32(this.i3);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 10:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 11:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i3);
                    this.f0 = lf64(this.i4);
                    sf64(this.f0, this.i5);
                    this.i4 = li32(this.i4 + 8);
                    si32(this.i4, (this.i5 + 8));
                    this.i4 = li32(this.i3);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = -1;
                    this.i5 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sort_comp.start();
                    return;
                case 12:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i4 == 0) goto _label_5;
                    this.i4 = 1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 13:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 14:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = (this.i2 - this.i1);
                    if (this.i4 == 2) goto _label_2;
                    goto _label_7;
                    
                _label_5: 
                    this.i4 = 1;
                    this.i5 = li32(this.i3);
                    this.i5 = (this.i5 + -12);
                    si32(this.i5, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 15:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 16:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i3);
                    this.f0 = lf64(this.i4);
                    sf64(this.f0, this.i5);
                    this.i4 = li32(this.i4 + 8);
                    si32(this.i4, (this.i5 + 8));
                    this.i4 = li32(this.i3);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = -2;
                    this.i5 = -1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sort_comp.start();
                    return;
                case 17:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i4 == 0) goto _label_6;
                    this.i4 = 1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 18:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 19:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = (this.i2 - this.i1);
                    if (this.i4 == 2) goto _label_2;
                    goto _label_7;
                    
                _label_6: 
                    this.i4 = li32(this.i3);
                    this.i4 = (this.i4 + -24);
                    si32(this.i4, this.i3);
                    this.i4 = (this.i2 - this.i1);
                    if (this.i4 == 2) goto _label_2;
                    
                _label_7: 
                    this.i4 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 20:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 21:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i3);
                    this.f0 = lf64(this.i5);
                    sf64(this.f0, this.i7);
                    this.i5 = li32(this.i5 + 8);
                    si32(this.i5, (this.i7 + 8));
                    this.i5 = li32(this.i3);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = -1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 22:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i8 = li32(this.i3);
                    this.f0 = lf64(this.i7);
                    sf64(this.f0, this.i8);
                    this.i7 = li32(this.i7 + 8);
                    si32(this.i7, (this.i8 + 8));
                    this.i7 = li32(this.i3);
                    this.i7 = (this.i7 + 12);
                    si32(this.i7, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 23:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i8 = (this.i2 + -1);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 24:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = li32(this.i3);
                    this.f0 = lf64(this.i7);
                    sf64(this.f0, this.i9);
                    this.i7 = li32(this.i7 + 8);
                    si32(this.i7, (this.i9 + 8));
                    this.i7 = li32(this.i3);
                    this.i7 = (this.i7 + 12);
                    si32(this.i7, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 25;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 25:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 26;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 26:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 27:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i6 = (this.i1 + 1);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 28:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i3);
                    this.f0 = lf64(this.i4);
                    sf64(this.f0, this.i7);
                    this.i4 = li32(this.i4 + 8);
                    si32(this.i4, (this.i7 + 8));
                    this.i4 = li32(this.i3);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = -2;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 29;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sort_comp.start();
                    return;
                case 29:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i4 == 0) goto _label_16;
                    this.i4 = this.i8;
                    
                _label_8: 
                    if (this.i6 <= this.i2) goto _label_9;
                    this.i5 = __2E_str13428;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 30;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 30:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_9: 
                    this.i5 = li32(this.i3);
                    this.i5 = (this.i5 + -12);
                    si32(this.i5, this.i3);
                    
                _label_10: 
                    this.i5 = this.i4;
                    this.i4 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 31:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = (this.i6 + 1);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 32:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = li32(this.i3);
                    this.f0 = lf64(this.i4);
                    sf64(this.f0, this.i9);
                    this.i4 = li32(this.i4 + 8);
                    si32(this.i4, (this.i9 + 8));
                    this.i4 = li32(this.i3);
                    this.i4 = (this.i4 + 12);
                    si32(this.i4, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i4 = -2;
                    this.i9 = -1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 33;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sort_comp.start();
                    return;
                case 33:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i4 == 0))
                    {
                        this.i4 = this.i5;
                        this.i6 = this.i7;
                        goto _label_8;
                    };
                    this.i4 = this.i6;
                    this.i6 = this.i7;
                    
                _label_11: 
                    this.i7 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 34:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i9 = (this.i5 + -1);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 35:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i10 = li32(this.i3);
                    this.f0 = lf64(this.i7);
                    sf64(this.f0, this.i10);
                    this.i7 = li32(this.i7 + 8);
                    si32(this.i7, (this.i10 + 8));
                    this.i7 = li32(this.i3);
                    this.i7 = (this.i7 + 12);
                    si32(this.i7, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = -3;
                    this.i10 = -1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 36;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sort_comp.start();
                    return;
                case 36:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i7 == 0) goto _label_17;
                    this.i9 = this.i5;
                    
                _label_12: 
                    this.i5 = (this.i9 + -1);
                    if (this.i5 >= this.i1) goto _label_13;
                    this.i5 = __2E_str13428;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    state = 37;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 37:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_13: 
                    this.i5 = 1;
                    this.i7 = li32(this.i3);
                    this.i7 = (this.i7 + -12);
                    si32(this.i7, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 38:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = (this.i9 + -2);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 39:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i3);
                    this.f0 = lf64(this.i5);
                    sf64(this.f0, this.i7);
                    this.i5 = li32(this.i5 + 8);
                    si32(this.i5, (this.i7 + 8));
                    this.i5 = li32(this.i3);
                    this.i5 = (this.i5 + 12);
                    si32(this.i5, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i5 = -1;
                    this.i7 = -3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i7, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 40;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sort_comp.start();
                    return;
                case 40:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i9 = (this.i9 + -1);
                    if (!(this.i5 == 0)) goto _label_12;
                    this.i9 = (this.i9 + -1);
                    
                _label_14: 
                    this.i5 = this.i9;
                    if (this.i5 >= this.i6) goto _label_15;
                    this.i5 = 1;
                    this.i7 = li32(this.i3);
                    this.i7 = (this.i7 + -36);
                    si32(this.i7, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 41:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 42:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = li32(this.i3);
                    this.f0 = lf64(this.i7);
                    sf64(this.f0, this.i9);
                    this.i7 = li32(this.i7 + 8);
                    si32(this.i7, (this.i9 + 8));
                    this.i7 = li32(this.i3);
                    this.i7 = (this.i7 + 12);
                    si32(this.i7, this.i3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 43:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = li32(this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i7, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_getnum.start();
                case 44:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = li32(this.i3);
                    this.f0 = lf64(this.i7);
                    sf64(this.f0, this.i9);
                    this.i7 = li32(this.i7 + 8);
                    si32(this.i7, (this.i9 + 8));
                    this.i7 = li32(this.i3);
                    this.i7 = (this.i7 + 12);
                    si32(this.i7, this.i3);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    state = 45;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 45:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 46;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 46:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i5 = (this.i4 + 2);
                    this.i8 = (this.i2 - this.i6);
                    this.i6 = (this.i6 - this.i1);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i7 = ((this.i6 < this.i8) ? this.i4 : this.i2);
                    this.i9 = ((this.i6 < this.i8) ? this.i1 : this.i5);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i7, (public::mstate.esp + 8));
                    state = 47;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_auxsort.start();
                    return;
                case 47:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i2 = ((this.i6 < this.i8) ? this.i2 : this.i4);
                    this.i1 = ((this.i6 < this.i8) ? this.i5 : this.i1);
                    if (this.i1 >= this.i2) goto _label_2;
                    goto _label_1;
                    
                _label_15: 
                    this.i4 = 1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 48;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 48:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i5, (public::mstate.esp + 8));
                    state = 49;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_rawseti.start();
                    return;
                case 49:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = this.i5;
                    goto _label_10;
                    
                _label_16: 
                    this.i4 = this.i1;
                    this.i5 = this.i8;
                    goto _label_11;
                    
                _label_17: 
                    goto _label_14;
                default:
                    throw ("Invalid state in _auxsort");
            };
        }


    }
}

