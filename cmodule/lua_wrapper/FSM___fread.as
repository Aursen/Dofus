package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___fread extends Machine 
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
            var _local_1:FSM___fread;
            _local_1 = new (FSM___fread)();
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
                    this.i0 = li32(public::mstate.ebp + 12);
                    this.i1 = li32(public::mstate.ebp + 16);
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i3 = li32(public::mstate.ebp + 20);
                    this.i4 = (this.i1 * this.i0);
                    if (this.i4 == 0) goto _label_4;
                    this.i5 = li32(this.i3 + 56);
                    this.i6 = li32(this.i5 + 16);
                    this.i5 = (this.i5 + 16);
                    if (!(!(this.i6 == 0)))
                    {
                        this.i6 = -1;
                        si32(this.i6, this.i5);
                    };
                    this.i5 = li32(this.i3 + 4);
                    this.i6 = (this.i3 + 4);
                    if (!(this.i5 < 0))
                    {
                        this.i5 = this.i4;
                        goto _label_2;
                    };
                    this.i5 = 0;
                    si32(this.i5, this.i6);
                    this.i5 = li32(this.i3);
                    if (this.i4 == 0) goto _label_3;
                    this.i7 = 0;
                    this.i8 = this.i4;
                    
                _label_1: 
                    this.i9 = this.i2;
                    this.i10 = this.i7;
                    memcpy(this.i9, this.i5, this.i10);
                    this.i5 = li32(this.i3);
                    this.i5 = (this.i5 + this.i7);
                    si32(this.i5, this.i3);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i3, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___srefill.start();
                    return;
                case 1:
                    this.i5 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i8 = (this.i8 - this.i7);
                    this.i2 = (this.i2 + this.i7);
                    if (!(!(this.i5 == 0)))
                    {
                        this.i5 = this.i8;
                        
                    _label_2: 
                        this.i7 = li32(this.i6);
                        this.i9 = li32(this.i3);
                        if (!(uint(this.i7) < uint(this.i5)))
                        {
                            this.i0 = this.i5;
                            this.i5 = this.i9;
                        }
                        else
                        {
                            this.i8 = this.i5;
                            this.i5 = this.i9;
                            goto _label_1;
                            
                        _label_3: 
                            this.i0 = this.i4;
                        };
                        this.i4 = this.i5;
                        this.i5 = this.i0;
                        memcpy(this.i2, this.i4, this.i5);
                        this.i2 = li32(this.i6);
                        this.i2 = (this.i2 - this.i0);
                        si32(this.i2, this.i6);
                        this.i2 = li32(this.i3);
                        this.i0 = (this.i2 + this.i0);
                        si32(this.i0, this.i3);
                        public::mstate.eax = this.i1;
                        goto _label_5;
                        
                    _label_4: 
                        this.i0 = 0;
                        public::mstate.eax = this.i0;
                        
                    _label_5: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i2 = (this.i4 - this.i8);
                    this.i2 = (uint(this.i2) / uint(this.i0));
                    public::mstate.eax = this.i2;
                    goto _label_5;
                default:
                    throw ("Invalid state in ___fread");
            };
        }


    }
} cmodule.lua_wrapper

