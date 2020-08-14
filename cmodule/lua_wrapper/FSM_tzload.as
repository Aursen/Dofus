package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_tzload extends Machine 
    {

        public static const intRegCount:int = 9;
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


        public static function start():void
        {
            var _local_1:FSM_tzload;
            _local_1 = new (FSM_tzload)();
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
                    public::mstate.esp = (public::mstate.esp - 5136);
                    this.i2 = (public::mstate.ebp + -5136);
                    this.i3 = li32(public::mstate.ebp + 8);
                    if (!(this.i3 == 0))
                    {
                        this.i0 = __2E_str876;
                        this.i1 = 4;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    };
                    this.i0 = __2E_str2348;
                    this.i0 = ((this.i3 == 0) ? this.i0 : this.i3);
                    this.i1 = li8(this.i0);
                    if ((this.i1 == 58))
                    {
                        this.i0 = (this.i0 + 1);
                    };
                    this.i1 = li8(this.i0);
                    this.i3 = ((this.i1 == 47) ? 1 : 0);
                    this.i3 = (this.i3 & 0x01);
                    this.i4 = this.i0;
                    if (!(this.i1 == 47)) goto _label_4;
                    this.i1 = this.i3;
                    
                _label_1: 
                    this.i2 = this.i0;
                    if (this.i1 == 0) goto _label_2;
                    this.i1 = 4;
                    this.i0 = this.i2;
                    state = 1;
                case 1:
                    this.i0 = public::mstate.system.access(this.i0, this.i1);
                    if (!(this.i0 == 0)) goto _label_8;
                    
                _label_2: 
                    this.i0 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i2, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_open.start();
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i2 == -1) goto _label_8;
                    if (this.i2 < 2) goto _label_3;
                    this.i0 = this.i2;
                    state = 3;
                case 3:
                    this.i0 = public::mstate.system.fsize(this.i0);
                    if (this.i0 > -1) goto _label_3;
                    this.i0 = __2E_str96;
                    public::mstate.esp = (public::mstate.esp - 20);
                    this.i1 = __2E_str251;
                    this.i3 = 59;
                    this.i4 = 2;
                    this.i5 = (public::mstate.ebp + -4096);
                    si32(this.i5, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    si32(this.i1, (public::mstate.esp + 12));
                    si32(this.i3, (public::mstate.esp + 16));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_sprintf.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 20);
                    this.i1 = 3;
                    this.i0 = this.i5;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    si32(this.i4, _val_2E_1440);
                    
                _label_3: 
                    this.i1 = -1;
                    this.i0 = this.i2;
                    state = 5;
                case 5:
                    this.i0 = public::mstate.system.close(this.i0);
                    public::mstate.eax = this.i1;
                    goto _label_9;
                    
                _label_4: 
                    this.i1 = (this.i1 & 0xFF);
                    if (!(this.i1 == 0))
                    {
                        this.i1 = this.i4;
                        do 
                        {
                            this.i5 = li8(this.i1 + 1);
                            this.i1 = (this.i1 + 1);
                            this.i6 = this.i1;
                            if (this.i5 == 0) goto _label_10;
                            this.i1 = this.i6;
                        } while (true);
                        
                    _label_5: 
                        this.i1 = this.i6;
                        
                    _label_6: 
                        this.i5 = (public::mstate.ebp + -5136);
                        this.i1 = (this.i1 - this.i2);
                        this.i7 = 47;
                        this.i8 = 0;
                        this.i1 = (this.i5 + this.i1);
                        si8(this.i7, this.i1);
                        si8(this.i8, (this.i1 + 1));
                        this.i1 = li8(this.i6);
                        if (this.i1 == 0) goto _label_11;
                        this.i1 = this.i2;
                        do 
                        {
                            this.i2 = li8(this.i1 + 1);
                            this.i1 = (this.i1 + 1);
                            this.i5 = this.i1;
                            if (this.i2 == 0) goto _label_12;
                            this.i1 = this.i5;
                        } while (true);
                        
                    _label_7: 
                        this.i1 = li8(this.i0);
                        if (this.i1 == 46) goto _label_13;
                        this.i0 = this.i4;
                        do 
                        {
                            this.i1 = li8(this.i0);
                            if (!(!(this.i1 == 0)))
                            {
                                this.i0 = 0;
                                goto _label_13;
                            };
                            this.i1 = li8(this.i0 + 1);
                            this.i0 = (this.i0 + 1);
                            this.i2 = this.i0;
                            if (this.i1 == 46) goto _label_13;
                            this.i0 = this.i2;
                        } while (true);
                        
                    _label_8: 
                        this.i0 = -1;
                        public::mstate.eax = this.i0;
                        
                    _label_9: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i1 = this.i0;
                    
                _label_10: 
                    this.i1 = (this.i1 - this.i4);
                    this.i1 = (this.i1 + 21);
                    if (uint(this.i1) > uint(0x0400)) goto _label_8;
                    this.i1 = (public::mstate.ebp + -5136);
                    this.i5 = __2E_str13349;
                    this.i6 = 20;
                    memcpy(this.i1, this.i5, this.i6);
                    this.i5 = li8(public::mstate.ebp + -5136);
                    this.i6 = this.i1;
                    if (this.i5 == 0) goto _label_5;
                    this.i1 = this.i2;
                    do 
                    {
                        this.i5 = li8(this.i1 + 1);
                        this.i1 = (this.i1 + 1);
                        this.i7 = this.i1;
                        if (this.i5 == 0) goto _label_6;
                        this.i1 = this.i7;
                    } while (true);
                    
                _label_11: 
                    this.i1 = this.i6;
                    
                _label_12: 
                    this.i2 = 0;
                    do 
                    {
                        this.i5 = (this.i4 + this.i2);
                        this.i5 = li8(this.i5);
                        this.i7 = (this.i1 + this.i2);
                        si8(this.i5, this.i7);
                        this.i2 = (this.i2 + 1);
                        if (this.i5 == 0) goto _label_7;
                    } while (true);
                    
                _label_13: 
                    this.i0 = ((this.i0 == 0) ? this.i3 : 1);
                    this.i1 = this.i0;
                    this.i0 = this.i6;
                    goto _label_1;
                default:
                    throw ("Invalid state in _tzload");
            };
        }


    }
} cmodule.lua_wrapper

