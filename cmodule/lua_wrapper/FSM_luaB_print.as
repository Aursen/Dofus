package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaB_print extends Machine 
    {

        public static const intRegCount:int = 13;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
        public var i12:int;
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
            var _local_1:FSM_luaB_print;
            _local_1 = new (FSM_luaB_print)();
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
                    public::mstate.esp = (public::mstate.esp - 48);
                    this.i0 = -10002;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(this.i1 + 8);
                    this.i3 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    this.i2 = (this.i2 - this.i3);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = __2E_str29229;
                    this.i4 = (this.i2 / 12);
                    this.i5 = (this.i1 + 8);
                    do 
                    {
                        this.i6 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i7 = this.i3;
                        if ((this.i6 == 0)) break;
                        this.i3 = this.i7;
                    } while (true);
                    this.i6 = __2E_str29229;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 - this.i6);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 2:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i3, (public::mstate.ebp + -16));
                    this.i3 = 4;
                    si32(this.i3, (public::mstate.ebp + -8));
                    this.i3 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i6 = (public::mstate.ebp + -16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_gettable.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + 12);
                    si32(this.i0, this.i5);
                    if (this.i2 < 12) goto _label_6;
                    this.i0 = (public::mstate.ebp + -48);
                    this.i2 = (public::mstate.ebp + -24);
                    this.i3 = 1;
                    this.i6 = (this.i0 + 4);
                    this.i7 = (this.i2 + 4);
                    this.i8 = (this.i0 + 8);
                    
                _label_1: 
                    this.i9 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i11 = li32(this.i5);
                    this.f0 = lf64(this.i10);
                    sf64(this.f0, this.i11);
                    this.i10 = li32(this.i10 + 8);
                    si32(this.i10, (this.i11 + 8));
                    this.i10 = li32(this.i5);
                    this.i10 = (this.i10 + 12);
                    si32(this.i10, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 5:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i11 = li32(this.i5);
                    this.f0 = lf64(this.i10);
                    sf64(this.f0, this.i11);
                    this.i10 = li32(this.i10 + 8);
                    si32(this.i10, (this.i11 + 8));
                    this.i10 = li32(this.i5);
                    this.i11 = (this.i10 + 12);
                    si32(this.i11, this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i11 = 1;
                    this.i10 = (this.i10 + -12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i10 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i10, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_tolstring.start();
                    return;
                case 7:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i10 = this.i9;
                    if (!(this.i9 == 0)) goto _label_2;
                    this.i3 = __2E_str33233;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaL_error.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = 0;
                    public::mstate.eax = this.i3;
                    goto _label_9;
                    
                _label_2: 
                    if (this.i3 < 2) goto _label_5;
                    this.i11 = li32(___sF + 96);
                    this.i11 = (this.i11 + -1);
                    si32(this.i11, (___sF + 96));
                    if (this.i11 > -1) goto _label_4;
                    this.i12 = li32(___sF + 112);
                    if (this.i11 < this.i12) goto _label_3;
                    this.i11 = 9;
                    this.i12 = li32(___sF + 88);
                    si8(this.i11, this.i12);
                    this.i11 = li32(___sF + 88);
                    this.i12 = li8(this.i11);
                    if (!(this.i12 == 10))
                    {
                        this.i11 = (this.i11 + 1);
                        si32(this.i11, (___sF + 88));
                        goto _label_5;
                    };
                    this.i11 = ___sF;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i11 = (this.i11 + 88);
                    this.i12 = 10;
                    si32(this.i12, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___swbuf.start();
                    return;
                case 9:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_5;
                    
                _label_3: 
                    this.i11 = ___sF;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i11 = (this.i11 + 88);
                    this.i12 = 9;
                    si32(this.i12, public::mstate.esp);
                    si32(this.i11, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___swbuf.start();
                    return;
                case 10:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_5;
                    
                _label_4: 
                    this.i11 = 9;
                    this.i12 = li32(___sF + 88);
                    si8(this.i11, this.i12);
                    this.i11 = li32(___sF + 88);
                    this.i11 = (this.i11 + 1);
                    si32(this.i11, (___sF + 88));
                    
                _label_5: 
                    si32(this.i9, this.i2);
                    this.i11 = li8(this.i9);
                    if (this.i11 == 0) goto _label_10;
                    this.i9 = this.i10;
                    do 
                    {
                        this.i11 = li8(this.i9 + 1);
                        this.i9 = (this.i9 + 1);
                        this.i12 = this.i9;
                        if (this.i11 == 0) goto _label_10;
                        this.i9 = this.i12;
                    } while (true);
                    
                _label_6: 
                    this.i0 = li32(___sF + 96);
                    this.i0 = (this.i0 + -1);
                    si32(this.i0, (___sF + 96));
                    if (this.i0 > -1) goto _label_7;
                    this.i1 = li32(___sF + 112);
                    if (!(this.i0 < this.i1))
                    {
                        this.i0 = 10;
                        this.i1 = li32(___sF + 88);
                        si8(this.i0, this.i1);
                        this.i0 = li32(___sF + 88);
                        this.i1 = li8(this.i0);
                        if (!(this.i1 == 10))
                        {
                            this.i1 = 0;
                            this.i0 = (this.i0 + 1);
                            si32(this.i0, (___sF + 88));
                            public::mstate.eax = this.i1;
                            goto _label_9;
                        };
                    };
                    this.i0 = ___sF;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (this.i0 + 88);
                    this.i1 = 10;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___swbuf.start();
                    return;
                case 11:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_8;
                    
                _label_7: 
                    this.i0 = 10;
                    this.i1 = li32(___sF + 88);
                    si8(this.i0, this.i1);
                    this.i0 = li32(___sF + 88);
                    this.i0 = (this.i0 + 1);
                    si32(this.i0, (___sF + 88));
                    
                _label_8: 
                    this.i0 = 0;
                    public::mstate.eax = this.i0;
                    
                _label_9: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_10: 
                    this.i11 = (public::mstate.ebp + -24);
                    this.i9 = (this.i9 - this.i10);
                    si32(this.i9, this.i8);
                    si32(this.i9, this.i7);
                    si32(this.i11, this.i0);
                    this.i9 = 1;
                    si32(this.i9, this.i6);
                    this.i9 = li32(___sF + 144);
                    this.i10 = li32(this.i9 + 16);
                    this.i9 = (this.i9 + 16);
                    if (!(!(this.i10 == 0)))
                    {
                        this.i10 = -1;
                        si32(this.i10, this.i9);
                    };
                    this.i9 = ___sF;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i10 = (public::mstate.ebp + -48);
                    this.i9 = (this.i9 + 88);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sfvwrite.start();
                    return;
                case 12:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = li32(this.i5);
                    this.i9 = (this.i9 + -12);
                    si32(this.i9, this.i5);
                    this.i3 = (this.i3 + 1);
                    if (this.i3 > this.i4) goto _label_6;
                    goto _label_1;
                default:
                    throw ("Invalid state in _luaB_print");
            };
        }


    }
}

