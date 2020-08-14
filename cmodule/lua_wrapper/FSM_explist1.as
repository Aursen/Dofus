package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_explist1 extends Machine 
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
            var _local_1:FSM_explist1;
            _local_1 = new (FSM_explist1)();
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
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = li32(public::mstate.ebp + 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i0, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_subexpr.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i1 + 12);
                    this.i3 = (this.i1 + 12);
                    if (!(this.i0 == 44)) goto _label_4;
                    this.i0 = li32(this.i1 + 4);
                    si32(this.i0, (this.i1 + 8));
                    this.i0 = li32(this.i1 + 24);
                    this.i4 = (this.i1 + 24);
                    if (!(this.i0 == 287))
                    {
                        this.i5 = 287;
                        si32(this.i0, this.i3);
                        this.f0 = lf64(this.i1 + 28);
                        sf64(this.f0, (this.i1 + 16));
                        si32(this.i5, this.i4);
                        goto _label_1;
                    };
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (this.i1 + 16);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i0, this.i3);
                    
                _label_1: 
                    this.i0 = -1;
                    this.i4 = (this.i1 + 16);
                    this.i5 = (this.i1 + 28);
                    this.i6 = (this.i1 + 24);
                    this.i7 = (this.i1 + 8);
                    this.i8 = (this.i1 + 4);
                    this.i9 = (this.i1 + 36);
                    this.i10 = this.i4;
                    
                _label_2: 
                    this.i11 = 0;
                    this.i12 = li32(this.i9);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i12, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_exp2nextreg.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i11, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_subexpr.start();
                    return;
                case 4:
                    this.i11 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i11 = li32(this.i3);
                    if (!(this.i11 == 44))
                    {
                        this.i11 = 1;
                        goto _label_3;
                    };
                    this.i11 = li32(this.i8);
                    si32(this.i11, this.i7);
                    this.i11 = li32(this.i6);
                    if (!(this.i11 == 287))
                    {
                        this.i12 = 287;
                        si32(this.i11, this.i3);
                        this.f0 = lf64(this.i5);
                        sf64(this.f0, this.i4);
                        si32(this.i12, this.i6);
                        this.i11 = 0;
                        goto _label_3;
                    };
                    this.i11 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_llex.start();
                    return;
                case 5:
                    this.i12 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i12, this.i3);
                    
                _label_3: 
                    this.i0 = (this.i0 + 1);
                    this.i11 = (this.i11 & 0x01);
                    if (!(!(this.i11 == 0))) goto _label_2;
                    this.i0 = (this.i0 + 2);
                    do 
                    {
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_4: 
                        this.i0 = 1;
                    } while (true);
                default:
                    throw ("Invalid state in _explist1");
            };
        }


    }
} cmodule.lua_wrapper

