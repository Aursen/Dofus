package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___collate_load_tables extends Machine 
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
            var _local_1:FSM___collate_load_tables;
            _local_1 = new (FSM___collate_load_tables)();
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
                    public::mstate.esp = (public::mstate.esp - 1044);
                    this.i0 = (public::mstate.ebp + -1040);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = li8(this.i1);
                    this.i3 = (public::mstate.ebp + -1024);
                    this.i4 = this.i1;
                    if (!(this.i2 == 67))
                    {
                        this.i5 = __2E_str3149;
                        this.i6 = this.i2;
                    }
                    else
                    {
                        this.i5 = __2E_str3149;
                        this.i6 = 0;
                        this.i7 = this.i2;
                        do 
                        {
                            this.i8 = (this.i5 + this.i6);
                            this.i8 = (this.i8 + 1);
                            this.i7 = (this.i7 & 0xFF);
                            if (this.i7 == 0) goto _label_1;
                            this.i7 = (this.i4 + this.i6);
                            this.i7 = li8(this.i7 + 1);
                            this.i8 = li8(this.i8);
                            this.i6 = (this.i6 + 1);
                        } while (!(!(this.i7 == this.i8)));
                        this.i5 = __2E_str3149;
                        this.i5 = (this.i5 + this.i6);
                        this.i6 = this.i7;
                    };
                    this.i5 = li8(this.i5);
                    this.i6 = (this.i6 & 0xFF);
                    if (!(this.i6 == this.i5))
                    {
                        this.i5 = (this.i2 & 0xFF);
                        if (!(this.i5 == 80))
                        {
                            this.i5 = __2E_str4150;
                            this.i6 = this.i2;
                        }
                        else
                        {
                            this.i5 = __2E_str4150;
                            this.i6 = 0;
                            this.i7 = this.i2;
                            do 
                            {
                                this.i8 = (this.i5 + this.i6);
                                this.i8 = (this.i8 + 1);
                                this.i7 = (this.i7 & 0xFF);
                                if (this.i7 == 0) goto _label_1;
                                this.i7 = (this.i4 + this.i6);
                                this.i7 = li8(this.i7 + 1);
                                this.i8 = li8(this.i8);
                                this.i6 = (this.i6 + 1);
                            } while (!(!(this.i7 == this.i8)));
                            this.i5 = __2E_str4150;
                            this.i5 = (this.i5 + this.i6);
                            this.i6 = this.i7;
                        };
                        this.i5 = li8(this.i5);
                        this.i6 = (this.i6 & 0xFF);
                        if (!(this.i6 == this.i5)) goto _label_2;
                    };
                    
                _label_1: 
                    this.i0 = 0;
                    si8(this.i0, ___collate_load_error_2E_b);
                    this.i0 = 1;
                    goto _label_25;
                    
                _label_2: 
                    this.i5 = li8(_collate_encoding_2E_2976);
                    this.i6 = (this.i2 & 0xFF);
                    if (!(this.i6 == this.i5))
                    {
                        this.i5 = _collate_encoding_2E_2976;
                    }
                    else
                    {
                        this.i5 = _collate_encoding_2E_2976;
                        this.i6 = 0;
                        do 
                        {
                            this.i7 = (this.i5 + this.i6);
                            this.i7 = (this.i7 + 1);
                            this.i2 = (this.i2 & 0xFF);
                            if (this.i2 == 0) goto _label_3;
                            this.i2 = (this.i4 + this.i6);
                            this.i2 = li8(this.i2 + 1);
                            this.i7 = li8(this.i7);
                            this.i6 = (this.i6 + 1);
                        } while (!(!(this.i2 == this.i7)));
                        this.i5 = _collate_encoding_2E_2976;
                        this.i5 = (this.i5 + this.i6);
                    };
                    this.i5 = li8(this.i5);
                    this.i2 = (this.i2 & 0xFF);
                    if (!(!(this.i2 == this.i5)))
                    {
                        
                    _label_3: 
                        this.i0 = 1;
                        si8(this.i0, ___collate_load_error_2E_b);
                        goto _label_25;
                    };
                    this.i2 = (public::mstate.ebp + -1024);
                    this.i5 = li32(__PathLocale);
                    this.i6 = li8(this.i5);
                    si8(this.i6, (public::mstate.ebp + -1024));
                    if (!(this.i6 == 0))
                    {
                        this.i6 = 1;
                        do 
                        {
                            this.i7 = (this.i5 + this.i6);
                            this.i7 = li8(this.i7);
                            this.i8 = (this.i3 + this.i6);
                            si8(this.i7, this.i8);
                            this.i6 = (this.i6 + 1);
                        } while (!(this.i7 == 0));
                    };
                    this.i5 = li8(this.i2);
                    if (this.i5 == 0) goto _label_27;
                    this.i5 = this.i3;
                    do 
                    {
                        this.i6 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i7 = this.i5;
                        if (this.i6 == 0) goto _label_28;
                        this.i5 = this.i7;
                    } while (true);
                    
                _label_4: 
                    this.i5 = this.i2;
                    
                _label_5: 
                    this.i6 = 0;
                    do 
                    {
                        this.i7 = (this.i4 + this.i6);
                        this.i7 = li8(this.i7);
                        this.i8 = (this.i5 + this.i6);
                        si8(this.i7, this.i8);
                        this.i6 = (this.i6 + 1);
                    } while (!(this.i7 == 0));
                    this.i5 = li8(this.i2);
                    if (this.i5 == 0) goto _label_29;
                    this.i5 = this.i3;
                    do 
                    {
                        this.i6 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i7 = this.i5;
                        if (this.i6 == 0) goto _label_30;
                        this.i5 = this.i7;
                    } while (true);
                    
                _label_6: 
                    this.i3 = li8(this.i6);
                    if (!(this.i3 == 49))
                    {
                        this.i5 = __2E_str8154;
                        this.i6 = this.i3;
                    }
                    else
                    {
                        this.i5 = __2E_str8154;
                        this.i6 = 0;
                        this.i7 = this.i3;
                        do 
                        {
                            this.i8 = (this.i5 + this.i6);
                            this.i8 = (this.i8 + 1);
                            this.i7 = (this.i7 & 0xFF);
                            if ((!(this.i7 == 0))) continue;
                        } while ((this.i6 = 0), goto _label_8, (this.i7 = (this.i0 + this.i6)), (this.i7 = li8(this.i7 + 1)), (this.i8 = li8(this.i8)), (this.i6 = (this.i6 + 1)), !(!(this.i7 == this.i8)));
                        this.i5 = __2E_str8154;
                        this.i6 = (this.i5 + this.i6);
                        this.i5 = this.i6;
                        this.i6 = this.i7;
                    };
                    this.i5 = li8(this.i5);
                    this.i6 = (this.i6 & 0xFF);
                    //unresolved if
                    this.i6 = (this.i3 & 0xFF);
                    if (!(this.i6 == 49))
                    {
                        this.i0 = __2E_str9155;
                    }
                    else
                    {
                        this.i6 = __2E_str9155;
                        this.i5 = 0;
                        do 
                        {
                            this.i7 = (this.i6 + this.i5);
                            this.i7 = (this.i7 + 1);
                            this.i3 = (this.i3 & 0xFF);
                            if (this.i3 == 0) goto _label_7;
                            this.i3 = (this.i0 + this.i5);
                            this.i3 = li8(this.i3 + 1);
                            this.i7 = li8(this.i7);
                            this.i5 = (this.i5 + 1);
                        } while (!(!(this.i3 == this.i7)));
                        this.i0 = __2E_str9155;
                        this.i0 = (this.i0 + this.i5);
                    };
                    this.i6 = this.i0;
                    this.i0 = this.i3;
                    this.i6 = li8(this.i6);
                    this.i0 = (this.i0 & 0xFF);
                    if (!(this.i0 == this.i6))
                    {
                        this.i6 = -1;
                    }
                    else
                    {
                        
                    _label_7: 
                        this.i6 = 1;
                    };
                    
                _label_8: 
                    this.i0 = this.i6;
                    if (this.i0 > -1) goto _label_9;
                    this.i0 = 79;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fclose.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i0, _val_2E_1440);
                    goto _label_13;
                    
                _label_9: 
                    if (this.i0 == 0) goto _label_12;
                    this.i1 = 1;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i4 = 4;
                    this.i0 = (public::mstate.ebp + -1044);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fread.start();
                    return;
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i1 == 1) goto _label_11;
                    this.i1 = -1;
                    this.i4 = li32(_val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fclose.start();
                    return;
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i4, _val_2E_1440);
                    
                _label_10: 
                    public::mstate.eax = this.i1;
                    goto _label_26;
                    
                _label_11: 
                    this.i1 = __2E_str16;
                    this.i4 = 4;
                    this.i0 = this.i1;
                    this.i1 = this.i4;
                    log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fclose.start();
                    return;
                case 4:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = 79;
                    si32(this.i1, _val_2E_1440);
                    this.i1 = -1;
                    goto _label_10;
                    
                _label_12: 
                    this.i0 = 0x0A00;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i3 = 0;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 5:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(!(this.i0 == 0))) goto _label_31;
                    this.i3 = 0x0800;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i5 = 0;
                    si32(this.i5, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 6:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i5 = this.i3;
                    if (!(this.i3 == 0)) goto _label_14;
                    this.i1 = 0;
                    this.i3 = li32(_val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fclose.start();
                    return;
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i3, _val_2E_1440);
                    
                _label_13: 
                    this.i0 = -1;
                    goto _label_25;
                    
                _label_14: 
                    this.i6 = 2000;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i7 = 0;
                    si32(this.i7, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 9:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i7 = this.i6;
                    if (!(this.i6 == 0)) goto _label_16;
                    this.i1 = 0;
                    this.i4 = li32(_val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 10;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 10:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    
                _label_15: 
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 11;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 11:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 12;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fclose.start();
                    return;
                case 12:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i4, _val_2E_1440);
                    goto _label_13;
                    
                _label_16: 
                    this.i8 = 1;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = 0x0A00;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 13;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fread.start();
                    return;
                case 13:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i8 == 1) goto _label_18;
                    
                _label_17: 
                    this.i1 = 0;
                    this.i4 = li32(_val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 14;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 14:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 15;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 15:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i6, public::mstate.esp);
                    goto _label_15;
                    
                _label_18: 
                    this.i8 = 1;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = 0x0800;
                    si32(this.i3, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 16;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fread.start();
                    return;
                case 16:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i8 == 1))
                    {
                        
                    _label_19: 
                        goto _label_17;
                    };
                    this.i8 = 100;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i9 = 20;
                    si32(this.i6, public::mstate.esp);
                    si32(this.i9, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 17;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fread.start();
                    return;
                case 17:
                    this.i8 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (!(this.i8 == 100)) goto _label_19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 18;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fclose.start();
                    return;
                case 18:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = li8(this.i1);
                    si8(this.i1, _collate_encoding_2E_2976);
                    if (!(this.i1 == 0))
                    {
                        this.i1 = _collate_encoding_2E_2976;
                        this.i2 = 1;
                        do 
                        {
                            this.i3 = (this.i4 + this.i2);
                            this.i3 = li8(this.i3);
                            this.i6 = (this.i1 + this.i2);
                            si8(this.i3, this.i6);
                            this.i2 = (this.i2 + 1);
                        } while (!(this.i3 == 0));
                    };
                    this.i1 = li32(___collate_substitute_table_ptr);
                    if (this.i1 == 0) goto _label_20;
                    this.i2 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 19;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 19:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_20: 
                    si32(this.i0, ___collate_substitute_table_ptr);
                    this.i0 = li32(___collate_char_pri_table_ptr);
                    if (this.i0 == 0) goto _label_21;
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 20;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 20:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_21: 
                    this.i0 = 0;
                    si32(this.i5, ___collate_char_pri_table_ptr);
                    this.i1 = this.i0;
                    do 
                    {
                        this.i2 = this.i1;
                        this.i3 = this.i0;
                        this.i4 = __2E_str16;
                        this.i5 = li32(___collate_char_pri_table_ptr);
                        this.i6 = 4;
                        this.i8 = 0;
                        this.i0 = this.i4;
                        this.i1 = this.i6;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        this.i0 = (this.i5 + this.i2);
                        si32(this.i8, this.i0);
                        this.i5 = li32(___collate_char_pri_table_ptr);
                        this.i0 = this.i4;
                        this.i1 = this.i6;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        this.i0 = (this.i5 + this.i2);
                        si32(this.i8, (this.i0 + 4));
                        this.i0 = (this.i2 + 8);
                        this.i2 = (this.i3 + 1);
                        if ((this.i2 == 0x0100)) break;
                        this.i1 = this.i0;
                        this.i0 = this.i2;
                    } while (true);
                    this.i0 = li32(___collate_chain_pri_table);
                    if (this.i0 == 0) goto _label_22;
                    this.i1 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 21;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 21:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    si32(this.i7, ___collate_chain_pri_table);
                    this.i7 = this.i1;
                    this.i0 = this.i1;
                    goto _label_23;
                    
                _label_22: 
                    this.i0 = 0;
                    si32(this.i7, ___collate_chain_pri_table);
                    this.i7 = this.i0;
                    do 
                    {
                        
                    _label_23: 
                        this.i2 = this.i0;
                        this.i3 = __2E_str16;
                        this.i4 = li32(___collate_chain_pri_table);
                        this.i5 = 4;
                        this.i6 = 0;
                        this.i0 = this.i3;
                        this.i1 = this.i5;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        this.i0 = (this.i4 + this.i7);
                        si32(this.i6, (this.i0 + 12));
                        this.i4 = li32(___collate_chain_pri_table);
                        this.i0 = this.i3;
                        this.i1 = this.i5;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        this.i0 = (this.i4 + this.i7);
                        si32(this.i6, (this.i0 + 16));
                        this.i0 = (this.i7 + 20);
                        this.i1 = (this.i2 + 1);
                        if ((this.i1 > 99)) break;
                        this.i7 = this.i0;
                        this.i0 = this.i1;
                    } while (true);
                    this.i0 = 0;
                    si8(this.i0, ___collate_substitute_nontrivial_2E_b);
                    this.i1 = li32(___collate_substitute_table_ptr);
                    do 
                    {
                        this.i2 = li8(this.i1);
                        if (!(!(this.i2 == this.i0)))
                        {
                            this.i2 = li8(this.i1 + 1);
                            if ((this.i2 == 0)) continue;
                        };
                        this.i0 = 1;
                        si8(this.i0, ___collate_substitute_nontrivial_2E_b);
                        goto _label_24;
                    } while ((this.i1 = (this.i1 + 10)), (this.i0 = (this.i0 + 1)), !(this.i0 > 0xFF));
                    this.i0 = 1;
                    
                _label_24: 
                    si8(this.i0, ___collate_load_error_2E_b);
                    this.i0 = 0;
                    
                _label_25: 
                    public::mstate.eax = this.i0;
                    
                _label_26: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_27: 
                    this.i5 = this.i2;
                    
                _label_28: 
                    this.i6 = (public::mstate.ebp + -1024);
                    this.i5 = (this.i5 - this.i3);
                    this.i7 = 47;
                    this.i8 = 0;
                    this.i5 = (this.i6 + this.i5);
                    si8(this.i7, this.i5);
                    si8(this.i8, (this.i5 + 1));
                    this.i5 = li8(this.i2);
                    if (this.i5 == 0) goto _label_4;
                    this.i5 = this.i3;
                    do 
                    {
                        this.i6 = li8(this.i5 + 1);
                        this.i5 = (this.i5 + 1);
                        this.i7 = this.i5;
                        if (this.i6 == 0) goto _label_5;
                        this.i5 = this.i7;
                    } while (true);
                    
                _label_29: 
                    this.i5 = this.i2;
                    
                _label_30: 
                    this.i6 = (public::mstate.ebp + -1024);
                    this.i3 = (this.i5 - this.i3);
                    this.i3 = (this.i6 + this.i3);
                    this.i5 = __2E_str6152;
                    this.i6 = 12;
                    memcpy(this.i3, this.i5, this.i6);
                    this.i3 = li8(__2E_str19170 + 2);
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = 114;
                    this.i6 = 0;
                    si32(this.i2, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 22;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fopen387.start();
                    return;
                case 22:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i2 == 0) goto _label_13;
                    this.i3 = 1;
                    public::mstate.esp = (public::mstate.esp - 16);
                    this.i5 = 10;
                    this.i6 = (public::mstate.ebp + -1040);
                    si32(this.i6, public::mstate.esp);
                    si32(this.i5, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    si32(this.i2, (public::mstate.esp + 12));
                    state = 23;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fread.start();
                    return;
                case 23:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i3 == 1) goto _label_6;
                    
                _label_31: 
                    this.i0 = -1;
                    this.i1 = li32(_val_2E_1440);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i2, public::mstate.esp);
                    state = 24;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fclose.start();
                    return;
                case 24:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i1, _val_2E_1440);
                    goto _label_25;
                default:
                    throw ("Invalid state in ___collate_load_tables");
            };
        }


    }
} cmodule.lua_wrapper

