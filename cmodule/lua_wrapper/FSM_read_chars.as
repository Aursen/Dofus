package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_read_chars extends Machine 
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
            var _local_1:FSM_read_chars;
            _local_1 = new (FSM_read_chars)();
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
                    this.i3 = 0x0400;
                    this.i4 = (this.i0 + 4);
                    this.i5 = (this.i0 + 8);
                    this.i6 = li32(public::mstate.ebp + 12);
                    this.i7 = li32(public::mstate.ebp + 16);
                    
                _label_1: 
                    this.i8 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i8, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_emptybuffer.start();
                    return;
                case 1:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i8 == 0) goto _label_2;
                    this.i8 = (public::mstate.ebp + -1040);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i8, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_adjuststack.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_2: 
                    this.i8 = 1;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i3 = ((uint(this.i3) > uint(this.i7)) ? this.i7 : this.i3);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i6, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fread.start();
                    return;
                case 3:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    this.i9 = li32(this.i0);
                    this.i9 = (this.i9 + this.i8);
                    si32(this.i9, this.i0);
                    this.i9 = (this.i7 - this.i8);
                    if (!(this.i7 == this.i8))
                    {
                        if (!(!(this.i8 == this.i3)))
                        {
                            this.i7 = this.i9;
                            goto _label_1;
                        };
                    };
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
                    if (this.i7 == this.i8) goto _label_3;
                    this.i0 = -1;
                    public::mstate.esp = (public::mstate.esp - 8);
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
                    goto _label_4;
                    
                _label_3: 
                    this.i0 = 1;
                    
                _label_4: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _read_chars");
            };
        }


    }
} cmodule.lua_wrapper

