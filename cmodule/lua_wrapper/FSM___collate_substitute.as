package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___collate_substitute extends Machine 
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
            var _local_1:FSM___collate_substitute;
            _local_1 = new (FSM___collate_substitute)();
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
                    this.i1 = li8(this.i0);
                    this.i2 = this.i0;
                    if (this.i1 == 0) goto _label_11;
                    this.i3 = this.i2;
                    do 
                    {
                        this.i4 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i5 = this.i3;
                        if (this.i4 == 0) goto _label_12;
                        this.i3 = this.i5;
                    } while (true);
                    
                _label_1: 
                    this.i3 = li8(__2E_str45);
                    si8(this.i3, this.i2);
                    
                _label_2: 
                    if (!(!(this.i2 == 0)))
                    {
                        state = 1;
                        public::mstate.esp = (public::mstate.esp - 4);
                        FSM___collate_err.start();
                        return;
                    };
                case 1:
                    public::mstate.eax = this.i2;
                    
                _label_3: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_4: 
                    this.i0 = 0;
                    this.i1 = (this.i3 >> 31);
                    this.i1 = (this.i1 >>> 29);
                    this.i1 = (this.i3 + this.i1);
                    this.i1 = (this.i1 >> 3);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (this.i1 + this.i3);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i0 == 0))
                    {
                        this.i3 = 0;
                        this.i4 = this.i1;
                        goto _label_10;
                    };
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___collate_err.start();
                    return;
                case 3:
                    
                _label_5: 
                    this.i7 = (this.i0 & 0xFF);
                    this.i8 = li32(___collate_substitute_table_ptr);
                    this.i7 = (this.i7 * 10);
                    this.i7 = (this.i8 + this.i7);
                    this.i9 = li8(this.i7);
                    if (!(!(this.i9 == 0)))
                    {
                        this.i0 = this.i7;
                        
                    _label_6: 
                        this.i0 = (this.i0 - this.i7);
                        this.i0 = (this.i0 + this.i5);
                        if (this.i4 <= this.i0) goto _label_7;
                        goto _label_9;
                    };
                    this.i0 = (this.i0 & 0xFF);
                    this.i0 = (this.i0 * 10);
                    this.i0 = (this.i8 + this.i0);
                    do 
                    {
                        this.i8 = li8(this.i0 + 1);
                        this.i0 = (this.i0 + 1);
                        this.i9 = this.i0;
                        if (this.i8 == 0) goto _label_6;
                        this.i0 = this.i9;
                    } while (true);
                    
                _label_7: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = (this.i0 + this.i1);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 4:
                    this.i7 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i7 == 0)) goto _label_8;
                    if (this.i3 == 0) goto _label_8;
                    this.i8 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i8, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 5:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_8: 
                    if (this.i7 == 0) goto _label_13;
                    this.i3 = this.i7;
                    
                _label_9: 
                    this.i7 = this.i3;
                    this.i2 = li8(this.i2);
                    this.i3 = li32(___collate_substitute_table_ptr);
                    this.i8 = (this.i2 * 10);
                    this.i8 = (this.i3 + this.i8);
                    this.i8 = li8(this.i8);
                    this.i9 = (this.i7 + this.i5);
                    si8(this.i8, this.i9);
                    this.i9 = this.i7;
                    if (!(this.i8 == 0))
                    {
                        this.i8 = 1;
                        this.i2 = (this.i2 & 0xFF);
                        this.i2 = (this.i2 * 10);
                        this.i5 = (this.i5 + this.i9);
                        this.i2 = (this.i3 + this.i2);
                        this.i3 = this.i8;
                        do 
                        {
                            this.i8 = (this.i2 + this.i3);
                            this.i8 = li8(this.i8);
                            this.i9 = (this.i5 + this.i3);
                            si8(this.i8, this.i9);
                            this.i3 = (this.i3 + 1);
                        } while (!(this.i8 == 0));
                    };
                    this.i2 = (this.i6 + 1);
                    this.i3 = this.i0;
                    this.i0 = this.i7;
                    
                _label_10: 
                    this.i6 = this.i2;
                    this.i5 = this.i3;
                    this.i3 = this.i0;
                    this.i0 = li8(this.i6);
                    this.i2 = this.i6;
                    if (!(this.i0 == 0)) goto _label_5;
                    public::mstate.eax = this.i3;
                    goto _label_3;
                    
                _label_11: 
                    this.i3 = this.i0;
                    
                _label_12: 
                    this.i3 = (this.i3 - this.i2);
                    if (!(this.i0 == 0))
                    {
                        this.i0 = (this.i1 & 0xFF);
                        if (!(this.i0 == 0)) goto _label_4;
                    };
                    this.i2 = 1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 0;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 6:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i2 == 0)) goto _label_1;
                    this.i2 = 0;
                    goto _label_2;
                    
                _label_13: 
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___collate_err.start();
                    return;
                default:
                    throw ("Invalid state in ___collate_substitute");
            };
        }


    }
} cmodule.lua_wrapper

