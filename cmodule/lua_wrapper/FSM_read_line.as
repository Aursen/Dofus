package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_read_line extends Machine 
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
            var _local_1:FSM_read_line;
            _local_1 = new (FSM_read_line)();
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
                    public::mstate.esp = (public::mstate.esp - 1040);
                    this.i0 = (public::mstate.ebp + -1040);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, (public::mstate.ebp + -1032));
                    this.i2 = (this.i0 + 12);
                    si32(this.i2, (public::mstate.ebp + -1040));
                    this.i3 = 0;
                    si32(this.i3, (public::mstate.ebp + -1036));
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i4 = (this.i0 + 4);
                    this.i5 = (this.i0 + 8);
                    this.i6 = li32(public::mstate.ebp + 12);
                    this.i7 = this.i0;
                    if (this.i3 == 0) goto _label_1;
                    this.i3 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i3, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_1: 
                    this.i3 = 0x0400;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fgets.start();
                    return;
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i3 == 0)) goto _label_3;
                    
                _label_2: 
                    this.i0 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i4);
                    this.i2 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 1;
                    si32(this.i0, this.i4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = -1;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_objlen.start();
                    return;
                case 6:
                    this.i0 = public::mstate.eax;
                    this.i0 = ((this.i0 != 0) ? 1 : 0);
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = (this.i0 & 0x01);
                    goto _label_7;
                    
                _label_3: 
                    this.i3 = li8(this.i2);
                    if (this.i3 == 0) goto _label_8;
                    this.i3 = this.i0;
                    do 
                    {
                        this.i8 = li8(this.i3 + 13);
                        this.i3 = (this.i3 + 1);
                    } while (!(this.i8 == 0));
                    this.i3 = (this.i3 + 12);
                    
                _label_4: 
                    this.i8 = (this.i3 - this.i2);
                    if (!(this.i3 == this.i2))
                    {
                        this.i3 = (public::mstate.ebp + -1040);
                        this.i9 = (this.i8 + -1);
                        this.i3 = (this.i3 + this.i9);
                        this.i3 = li8(this.i3 + 12);
                        if (this.i3 == 10) goto _label_6;
                    };
                    this.i9 = (public::mstate.ebp + -1040);
                    this.i3 = li32(this.i7);
                    this.i3 = (this.i3 + this.i8);
                    si32(this.i3, this.i7);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i9, public::mstate.esp);
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 7:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i9 == 0) goto _label_5;
                    this.i9 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i9, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 8:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i9 = 0x0400;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fgets.start();
                    return;
                case 9:
                    this.i9 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i9 == 0) goto _label_2;
                    goto _label_3;
                    
                _label_6: 
                    this.i0 = (public::mstate.ebp + -1040);
                    this.i1 = li32(this.i7);
                    this.i1 = (this.i1 + this.i9);
                    si32(this.i1, this.i7);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 10:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i0 = li32(this.i4);
                    this.i1 = li32(this.i5);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_lua_concat.start();
                    return;
                case 11:
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i0 = 1;
                    
                _label_7: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_8: 
                    this.i3 = this.i2;
                    goto _label_4;
                default:
                    throw ("Invalid state in _read_line");
            };
        }


    }
}

