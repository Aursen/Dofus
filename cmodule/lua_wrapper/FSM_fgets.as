package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_fgets extends Machine 
    {

        public static const intRegCount:int = 15;
        public static const NumberRegCount:int = 0;

        public var i10:int;
        public var i11:int;
        public var i12:int;
        public var i13:int;
        public var i14:int;
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
            var _local_1:FSM_fgets;
            _local_1 = new (FSM_fgets)();
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
                    if (this.i1 < 1) goto _label_9;
                    this.i3 = li32(this.i2 + 56);
                    this.i4 = li32(this.i3 + 16);
                    this.i1 = (this.i1 + -1);
                    this.i3 = (this.i3 + 16);
                    if (!(!(this.i4 == 0)))
                    {
                        this.i4 = -1;
                        si32(this.i4, this.i3);
                        if (!(this.i1 == 0)) goto _label_2;
                        
                    _label_1: 
                        this.i1 = this.i0;
                        goto _label_8;
                    };
                    if (this.i1 == 0) goto _label_1;
                    
                _label_2: 
                    this.i3 = 0;
                    this.i4 = (this.i2 + 4);
                    this.i5 = this.i2;
                    
                _label_3: 
                    this.i6 = li32(this.i4);
                    this.i7 = (this.i0 + this.i3);
                    if (!(this.i6 == 0))
                    {
                        this.i8 = this.i6;
                        goto _label_4;
                    };
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___srefill.start();
                    return;
                case 1:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (!(this.i6 == 0))
                    {
                        if (this.i3 == 0) goto _label_9;
                        this.i1 = this.i7;
                    }
                    else
                    {
                        this.i6 = li32(this.i4);
                        this.i8 = this.i6;
                        
                    _label_4: 
                        this.i9 = li32(this.i5);
                        this.i6 = ((uint(this.i1) < uint(this.i6)) ? this.i1 : this.i6);
                        this.i10 = this.i9;
                        if (!(!(this.i6 == 0)))
                        {
                            
                        _label_5: 
                            this.i11 = 0;
                            
                        _label_6: 
                            if (this.i11 == 0) goto _label_7;
                            this.i1 = 0;
                            this.i2 = (this.i11 + 1);
                            this.i6 = (this.i2 - this.i10);
                            this.i8 = (this.i8 - this.i6);
                            si32(this.i8, this.i4);
                            si32(this.i2, this.i5);
                            this.i2 = this.i7;
                            this.i4 = this.i9;
                            this.i3 = (this.i3 + this.i6);
                            memcpy(this.i2, this.i4, this.i6);
                            this.i3 = (this.i0 + this.i3);
                            si8(this.i1, this.i3);
                            goto _label_10;
                        };
                        this.i11 = (this.i6 + 1);
                        this.i12 = this.i10;
                        do 
                        {
                            this.i13 = li8(this.i12);
                            this.i14 = this.i12;
                            if (!(!(this.i13 == 10)))
                            {
                                this.i11 = this.i14;
                                goto _label_6;
                            };
                            this.i11 = (this.i11 + -1);
                            this.i12 = (this.i12 + 1);
                            if (this.i11 == 1) goto _label_5;
                        } while (true);
                        
                    _label_7: 
                        this.i8 = (this.i8 - this.i6);
                        si32(this.i8, this.i4);
                        this.i8 = (this.i9 + this.i6);
                        si32(this.i8, this.i5);
                        this.i8 = this.i9;
                        this.i9 = this.i6;
                        memcpy(this.i7, this.i8, this.i9);
                        this.i7 = (this.i1 - this.i6);
                        this.i3 = (this.i3 + this.i6);
                        if (!(this.i1 == this.i6))
                        {
                            this.i1 = this.i7;
                            goto _label_3;
                        };
                        this.i1 = (this.i0 + this.i3);
                    };
                    
                _label_8: 
                    this.i2 = 0;
                    si8(this.i2, this.i1);
                    goto _label_10;
                    
                _label_9: 
                    this.i0 = 0;
                    
                _label_10: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _fgets");
            };
        }


    }
} cmodule.lua_wrapper

