package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaV_gettable extends Machine 
    {

        public static const intRegCount:int = 12;
        public static const NumberRegCount:int = 1;

        public var i10:int;
        public var i11:int;
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
            var _local_1:FSM_luaV_gettable;
            _local_1 = new (FSM_luaV_gettable)();
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
                    this.i0 = 0;
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(public::mstate.ebp + 16);
                    this.i4 = li32(public::mstate.ebp + 20);
                    this.i5 = (this.i1 + 16);
                    
                _label_1: 
                    this.i6 = li32(this.i2 + 8);
                    this.i7 = (this.i2 + 8);
                    if (!(this.i6 == 5)) goto _label_5;
                    this.i6 = li32(this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaH_get.start();
                case 1:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i9 = li32(this.i8 + 8);
                    this.i10 = (this.i8 + 8);
                    if (!(this.i9 == 0)) goto _label_4;
                    this.i6 = li32(this.i6 + 8);
                    if (!(!(this.i6 == 0)))
                    {
                        
                    _label_2: 
                        this.i6 = 0;
                        goto _label_3;
                    };
                    this.i9 = li8(this.i6 + 6);
                    this.i9 = (this.i9 & 0x01);
                    if (!(this.i9 == 0)) goto _label_2;
                    this.i9 = 0;
                    this.i11 = li32(this.i5);
                    this.i11 = li32(this.i11 + 168);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettm.start();
                case 2:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_3: 
                    if (!(this.i6 == 0))
                    {
                        this.i8 = this.i6;
                        goto _label_6;
                    };
                    
                _label_4: 
                    this.f0 = lf64(this.i8);
                    sf64(this.f0, this.i4);
                    this.i0 = li32(this.i10);
                    si32(this.i0, (this.i4 + 8));
                    goto _label_9;
                    
                _label_5: 
                    this.i8 = 0;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettmbyobj.start();
                case 3:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i6 = li32(this.i8 + 8);
                    if (!(this.i6 == 0)) goto _label_6;
                    this.i6 = __2E_str2167;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_typeerror.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_6: 
                    this.i6 = this.i8;
                    this.i8 = li32(this.i6 + 8);
                    this.i9 = (this.i6 + 8);
                    if (!(this.i8 == 6)) goto _label_8;
                    this.i0 = li32(this.i1 + 32);
                    this.i5 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i6);
                    sf64(this.f0, this.i5);
                    this.i6 = li32(this.i9);
                    si32(this.i6, (this.i5 + 8));
                    this.i5 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i2);
                    sf64(this.f0, (this.i5 + 12));
                    this.i2 = li32(this.i7);
                    si32(this.i2, (this.i5 + 20));
                    this.i2 = li32(this.i1 + 8);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, (this.i2 + 24));
                    this.i3 = li32(this.i3 + 8);
                    si32(this.i3, (this.i2 + 32));
                    this.i2 = li32(this.i1 + 28);
                    this.i3 = li32(this.i1 + 8);
                    this.i5 = (this.i1 + 8);
                    this.i0 = (this.i4 - this.i0);
                    this.i4 = (this.i1 + 32);
                    this.i2 = (this.i2 - this.i3);
                    if (this.i2 > 36) goto _label_7;
                    this.i2 = 3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_growstack.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_7: 
                    this.i2 = 1;
                    this.i3 = li32(this.i5);
                    this.i6 = (this.i3 + 36);
                    si32(this.i6, this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i1 = li32(this.i5);
                    this.i2 = li32(this.i4);
                    this.i3 = (this.i1 + -12);
                    si32(this.i3, this.i5);
                    this.f0 = lf64(this.i1 + -12);
                    this.i0 = (this.i2 + this.i0);
                    sf64(this.f0, this.i0);
                    this.i1 = li32(this.i1 + -4);
                    si32(this.i1, (this.i0 + 8));
                    goto _label_9;
                    
                _label_8: 
                    this.i0 = (this.i0 + 1);
                    if (!(this.i0 > 99))
                    {
                        this.i2 = this.i6;
                        goto _label_1;
                    };
                    this.i0 = __2E_str3168;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaG_runerror.start();
                    return;
                case 7:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_9: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _luaV_gettable");
            };
        }


    }
} cmodule.lua_wrapper

