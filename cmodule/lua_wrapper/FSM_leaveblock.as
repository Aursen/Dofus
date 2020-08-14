package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_leaveblock extends Machine 
    {

        public static const intRegCount:int = 12;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
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
            var _local_1:FSM_leaveblock;
            _local_1 = new (FSM_leaveblock)();
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
                    this.i1 = li32(this.i0 + 20);
                    this.i2 = li32(this.i1);
                    si32(this.i2, (this.i0 + 20));
                    this.i2 = li32(this.i0 + 12);
                    this.i2 = li32(this.i2 + 36);
                    this.i3 = li8(this.i1 + 8);
                    this.i4 = li8(this.i2 + 50);
                    this.i5 = (this.i2 + 50);
                    this.i6 = (this.i0 + 12);
                    this.i7 = (this.i1 + 8);
                    if (!(this.i4 <= this.i3))
                    {
                        this.i8 = (this.i2 + 24);
                        this.i9 = this.i2;
                        do 
                        {
                            this.i4 = (this.i4 + -1);
                            this.i10 = li32(this.i9);
                            this.i10 = li32(this.i10 + 24);
                            this.i11 = (this.i4 & 0xFF);
                            this.i11 = (this.i11 << 1);
                            si8(this.i4, this.i5);
                            this.i4 = (this.i2 + this.i11);
                            this.i4 = li16(this.i4 + 172);
                            this.i11 = li32(this.i8);
                            this.i4 = (this.i4 * 12);
                            this.i4 = (this.i10 + this.i4);
                            si32(this.i11, (this.i4 + 8));
                            this.i4 = li8(this.i5);
                        } while (!(this.i4 <= this.i3));
                    };
                    this.i2 = li8(this.i1 + 9);
                    if (this.i2 == 0) goto _label_1;
                    this.i2 = li32(this.i6);
                    this.i3 = li8(this.i7);
                    this.i2 = li32(this.i2 + 8);
                    this.i3 = (this.i3 << 6);
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 | 0x23);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_code.start();
                    return;
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    this.i2 = li8(this.i0 + 50);
                    si32(this.i2, (this.i0 + 36));
                    this.i1 = li32(this.i1 + 4);
                    this.i2 = li32(this.i0 + 24);
                    si32(this.i2, (this.i0 + 28));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i0 + 32);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _leaveblock");
            };
        }


    }
} cmodule.lua_wrapper

