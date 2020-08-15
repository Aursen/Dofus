package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_l_strcmp extends Machine 
    {

        public static const intRegCount:int = 11;
        public static const NumberRegCount:int = 0;

        public var i10:int;
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
            var _local_1:FSM_l_strcmp;
            _local_1 = new (FSM_l_strcmp)();
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
                    this.i2 = li32(this.i0 + 12);
                    this.i3 = li32(this.i1 + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (this.i0 + 16);
                    this.i1 = (this.i1 + 16);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strcoll.start();
                    return;
                case 1:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = this.i0;
                    if (!(this.i4 == 0))
                    {
                        this.i0 = this.i4;
                        goto _label_4;
                    };
                    this.i4 = 0;
                    this.i6 = this.i4;
                    
                _label_1: 
                    this.i7 = (this.i0 + this.i4);
                    this.i8 = li8(this.i7);
                    if (!(!(this.i8 == 0)))
                    {
                        this.i8 = this.i7;
                        
                    _label_2: 
                        this.i7 = (this.i8 - this.i7);
                        if (!(this.i7 == this.i3)) goto _label_3;
                        this.i0 = ((this.i7 != this.i2) ? 1 : 0);
                        this.i0 = (this.i0 & 0x01);
                        goto _label_4;
                    };
                    this.i8 = (this.i4 + this.i5);
                    do 
                    {
                        this.i9 = li8(this.i8 + 1);
                        this.i8 = (this.i8 + 1);
                        this.i10 = this.i8;
                        if (this.i9 == 0) goto _label_2;
                        this.i8 = this.i10;
                    } while (true);
                    
                _label_3: 
                    if (!(!(this.i7 == this.i2)))
                    {
                        this.i0 = -1;
                        goto _label_4;
                    };
                    this.i7 = (this.i7 + 1);
                    this.i6 = (this.i6 + this.i7);
                    this.i4 = (this.i4 + this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i8 = (this.i1 + this.i6);
                    this.i9 = (this.i0 + this.i4);
                    si32(this.i9, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strcoll.start();
                    return;
                case 2:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i3 = (this.i3 - this.i7);
                    this.i2 = (this.i2 - this.i7);
                    if (!(this.i8 == 0))
                    {
                        this.i0 = this.i8;
                        
                    _label_4: 
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    goto _label_1;
                default:
                    throw ("Invalid state in _l_strcmp");
            };
        }


    }
}

