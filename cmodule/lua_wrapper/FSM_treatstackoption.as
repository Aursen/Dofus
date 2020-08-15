package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_treatstackoption extends Machine 
    {

        public static const intRegCount:int = 10;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i8:int;
        public var f0:Number;
        public var i7:int;
        public var i9:int;


        public static function start():void
        {
            var _local_1:FSM_treatstackoption;
            _local_1 = new (FSM_treatstackoption)();
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
                    public::mstate.esp = (public::mstate.esp - 32);
                    this.i0 = li32(public::mstate.ebp + 8);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 16);
                    this.i3 = this.i2;
                    if (!(this.i0 == this.i1)) goto _label_2;
                    this.i1 = -2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i0 + 8);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, this.i4);
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i4 + 8));
                    this.i1 = li32(this.i0 + 8);
                    this.i1 = (this.i1 + 12);
                    si32(this.i1, (this.i0 + 8));
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = -3;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li32(this.i0 + 8);
                    this.i5 = (this.i0 + 8);
                    this.i6 = this.i1;
                    this.i7 = (this.i1 + 12);
                    if (!(uint(this.i7) < uint(this.i4)))
                    {
                        this.i1 = this.i4;
                    }
                    else
                    {
                        this.i1 = (this.i1 + 12);
                        this.i4 = this.i6;
                        
                    _label_1: 
                        this.f0 = lf64(this.i4 + 12);
                        sf64(this.f0, this.i4);
                        this.i6 = li32(this.i4 + 20);
                        si32(this.i6, (this.i4 + 8));
                        this.i4 = li32(this.i5);
                        this.i6 = (this.i1 + 12);
                        this.i7 = this.i1;
                        if (uint(this.i6) < uint(this.i4)) goto _label_3;
                        this.i1 = this.i4;
                    };
                    this.i4 = -2;
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li8(this.i2);
                    if (this.i4 == 0) goto _label_4;
                    do 
                    {
                        this.i4 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i6 = this.i3;
                        if (this.i4 == 0) goto _label_5;
                        this.i3 = this.i6;
                    } while (true);
                    
                _label_2: 
                    if (!(this.i1 == this.i0))
                    {
                        this.i4 = 0;
                        this.i5 = li32(this.i1 + 8);
                        this.i5 = (this.i5 + -12);
                        si32(this.i5, (this.i1 + 8));
                        this.i5 = (this.i0 + 8);
                        this.i1 = (this.i1 + 8);
                        this.i6 = this.i4;
                        do 
                        {
                            this.i7 = li32(this.i5);
                            this.i8 = li32(this.i1);
                            this.i9 = (this.i7 + 12);
                            si32(this.i9, this.i5);
                            this.i8 = (this.i8 + this.i6);
                            this.f0 = lf64(this.i8);
                            sf64(this.f0, this.i7);
                            this.i8 = li32(this.i8 + 8);
                            si32(this.i8, (this.i7 + 8));
                            this.i6 = (this.i6 + 12);
                            this.i7 = (this.i4 + 1);
                            if ((this.i4 == 0)) break;
                            this.i4 = this.i7;
                        } while (true);
                    };
                    this.i1 = -2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_index2adr.start();
                case 4:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = li8(this.i2);
                    if (this.i4 == 0) goto _label_7;
                    this.i4 = this.i3;
                    do 
                    {
                        this.i5 = li8(this.i4 + 1);
                        this.i4 = (this.i4 + 1);
                        this.i6 = this.i4;
                        if (this.i5 == 0) goto _label_8;
                        this.i4 = this.i6;
                    } while (true);
                    
                _label_3: 
                    this.i1 = this.i6;
                    this.i4 = this.i7;
                    goto _label_1;
                    
                _label_4: 
                    this.i3 = this.i2;
                    
                _label_5: 
                    this.i4 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 - this.i2);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 5:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -16));
                    si32(this.i4, (public::mstate.ebp + -8));
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i3 = (public::mstate.ebp + -16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 6:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i0 = li32(this.i5);
                    this.i0 = (this.i0 + -12);
                    si32(this.i0, this.i5);
                    
                _label_6: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_7: 
                    this.i4 = this.i2;
                    
                _label_8: 
                    this.i5 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i4 - this.i3);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 7:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, (public::mstate.ebp + -32));
                    si32(this.i5, (public::mstate.ebp + -24));
                    this.i2 = li32(this.i0 + 8);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i2 = (this.i2 + -12);
                    this.i3 = (public::mstate.ebp + -32);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_settable.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i1 = li32(this.i0 + 8);
                    this.i1 = (this.i1 + -12);
                    si32(this.i1, (this.i0 + 8));
                    goto _label_6;
                default:
                    throw ("Invalid state in _treatstackoption");
            };
        }


    }
}

