package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_loadlocale extends Machine 
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
            var _local_1:FSM_loadlocale;
            _local_1 = new (FSM_loadlocale)();
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
                    this.i0 = _new_categories;
                    this.i2 = li32(public::mstate.ebp + 8);
                    this.i1 = (this.i2 << 5);
                    this.i3 = _current_categories;
                    this.i4 = (this.i0 + this.i1);
                    this.i0 = li8(this.i4);
                    this.i3 = (this.i3 + this.i1);
                    if (!(this.i0 == 46))
                    {
                        this.i0 = (this.i0 & 0xFF);
                        if (!(this.i0 == 47)) goto _label_4;
                        
                    _label_1: 
                        this.i0 = this.i4;
                        
                    _label_2: 
                        if (this.i0 == 0) goto _label_5;
                        
                    _label_3: 
                        this.i2 = 22;
                        si32(this.i2, _val_2E_1440);
                        this.i2 = 0;
                        public::mstate.eax = this.i2;
                        goto _label_22;
                    };
                    this.i1 = _new_categories;
                    this.i5 = (this.i2 << 5);
                    this.i1 = (this.i1 + this.i5);
                    this.i1 = li8(this.i1 + 1);
                    if (this.i1 == 0) goto _label_3;
                    this.i1 = (this.i1 & 0xFF);
                    if (!(!(this.i1 == 46)))
                    {
                        this.i1 = _new_categories;
                        this.i5 = (this.i2 << 5);
                        this.i1 = (this.i1 + this.i5);
                        this.i1 = li8(this.i1 + 2);
                        if (this.i1 == 0) goto _label_3;
                    };
                    this.i0 = (this.i0 & 0xFF);
                    if (this.i0 == 47) goto _label_1;
                    
                _label_4: 
                    this.i0 = _new_categories;
                    this.i1 = (this.i2 << 5);
                    this.i0 = (this.i0 + this.i1);
                    do 
                    {
                        this.i1 = li8(this.i0);
                        if (!(!(this.i1 == 0)))
                        {
                            this.i0 = 0;
                            goto _label_2;
                        };
                        this.i1 = li8(this.i0 + 1);
                        this.i0 = (this.i0 + 1);
                        this.i5 = this.i0;
                        if (this.i1 == 47) goto _label_2;
                        this.i0 = this.i5;
                    } while (true);
                    
                _label_5: 
                    this.i5 = li32(_val_2E_1440);
                    this.i0 = li32(__PathLocale);
                    if (!(this.i0 == 0))
                    {
                        
                    _label_6: 
                        this.i0 = 0;
                        goto _label_11;
                    };
                    this.i0 = __2E_str940;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getenv.start();
                case 1:
                    this.i6 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i7 = this.i6;
                    if (!(this.i6 == 0))
                    {
                        this.i0 = __2E_str876;
                        this.i1 = 4;
                        log(this.i1, public::mstate.gworker.stringFromPtr(this.i0));
                        this.i0 = li8(this.i6);
                        if (this.i0 == 0) goto _label_23;
                        this.i1 = this.i7;
                        do 
                        {
                            this.i8 = li8(this.i1 + 1);
                            this.i1 = (this.i1 + 1);
                            this.i9 = this.i1;
                            if (this.i8 == 0) goto _label_24;
                            this.i1 = this.i9;
                        } while (true);
                        
                    _label_7: 
                        this.i0 = (this.i0 & 0xFF);
                        if (this.i0 == 0) goto _label_25;
                        this.i0 = this.i7;
                        do 
                        {
                            this.i1 = li8(this.i0 + 1);
                            this.i0 = (this.i0 + 1);
                            this.i8 = this.i0;
                            if (this.i1 == 0) goto _label_26;
                            this.i0 = this.i8;
                        } while (true);
                        
                    _label_8: 
                        this.i7 = this.i1;
                        memcpy(this.i7, this.i6, this.i0);
                        this.i0 = this.i1;
                        
                    _label_9: 
                        si32(this.i0, __PathLocale);
                        if (!(this.i0 == 0)) goto _label_6;
                        this.i0 = li32(_val_2E_1440);
                        if (this.i0 == 0) goto _label_10;
                        goto _label_11;
                    };
                    this.i0 = __2E_str1041;
                    si32(this.i0, __PathLocale);
                    this.i0 = 0;
                    goto _label_11;
                    
                _label_10: 
                    this.i0 = 12;
                    
                _label_11: 
                    si32(this.i0, _val_2E_1440);
                    if (!(this.i0 == 0))
                    {
                        
                    _label_12: 
                        this.i2 = 0;
                        
                    _label_13: 
                        this.i0 = this.i2;
                        public::mstate.eax = this.i0;
                        goto _label_22;
                    };
                    si32(this.i5, _val_2E_1440);
                    if (!(this.i2 > 3))
                    {
                        if (this.i2 == 1) goto _label_14;
                        if (this.i2 == 2) goto _label_20;
                        if (!(this.i2 == 3)) goto _label_19;
                        this.i0 = li8(this.i4);
                        this.i1 = li8(this.i3);
                        if (this.i0 == this.i1) goto _label_15;
                        this.i1 = this.i3;
                        goto _label_16;
                    };
                    if (!(this.i2 == 4))
                    {
                        if (!(this.i2 == 5))
                        {
                            if (!(this.i2 == 6)) goto _label_19;
                            this.i0 = li8(this.i4);
                            this.i1 = li8(this.i3);
                            if (this.i0 == this.i1) goto _label_17;
                            this.i1 = this.i3;
                            goto _label_18;
                            
                        _label_14: 
                            this.i0 = li8(this.i4);
                            this.i1 = li8(this.i3);
                            if (!(this.i0 == this.i1))
                            {
                                this.i1 = this.i3;
                            }
                            else
                            {
                                this.i1 = _current_categories;
                                this.i5 = _new_categories;
                                this.i6 = (this.i2 << 5);
                                do 
                                {
                                    this.i7 = (this.i1 + this.i6);
                                    this.i7 = (this.i7 + 1);
                                    this.i0 = (this.i0 & 0xFF);
                                    if ((!(this.i0 == 0))) continue;
                                } while ((this.i2 = this.i3), goto _label_13, (this.i0 = (this.i5 + this.i6)), (this.i0 = li8(this.i0 + 1)), (this.i7 = li8(this.i7)), (this.i6 = (this.i6 + 1)), !(!(this.i0 == this.i7)));
                                this.i1 = _current_categories;
                                this.i1 = (this.i1 + this.i6);
                            };
                            this.i1 = li8(this.i1);
                            this.i0 = (this.i0 & 0xFF);
                            //unresolved if
                            this.i0 = ___collate_load_tables;
                            goto _label_21;
                        };
                        this.i0 = li8(this.i4);
                        this.i1 = li8(this.i3);
                        if (!(this.i0 == this.i1))
                        {
                            this.i1 = this.i3;
                        }
                        else
                        {
                            this.i1 = _current_categories;
                            this.i5 = _new_categories;
                            this.i6 = (this.i2 << 5);
                            do 
                            {
                                this.i7 = (this.i1 + this.i6);
                                this.i7 = (this.i7 + 1);
                                this.i0 = (this.i0 & 0xFF);
                                //unresolved if
                                this.i0 = (this.i5 + this.i6);
                                this.i0 = li8(this.i0 + 1);
                                this.i7 = li8(this.i7);
                                this.i6 = (this.i6 + 1);
                            } while (!(!(this.i0 == this.i7)));
                            this.i1 = _current_categories;
                            this.i1 = (this.i1 + this.i6);
                        };
                        this.i1 = li8(this.i1);
                        this.i0 = (this.i0 & 0xFF);
                        //unresolved if
                        this.i0 = ___time_load_locale;
                        goto _label_21;
                    };
                    this.i0 = li8(this.i4);
                    this.i1 = li8(this.i3);
                    if (!(this.i0 == this.i1))
                    {
                        this.i1 = this.i3;
                    }
                    else
                    {
                        this.i1 = _current_categories;
                        this.i5 = _new_categories;
                        this.i6 = (this.i2 << 5);
                        do 
                        {
                            this.i7 = (this.i1 + this.i6);
                            this.i7 = (this.i7 + 1);
                            this.i0 = (this.i0 & 0xFF);
                            //unresolved if
                            this.i0 = (this.i5 + this.i6);
                            this.i0 = li8(this.i0 + 1);
                            this.i7 = li8(this.i7);
                            this.i6 = (this.i6 + 1);
                        } while (!(!(this.i0 == this.i7)));
                        this.i1 = _current_categories;
                        this.i1 = (this.i1 + this.i6);
                    };
                    this.i1 = li8(this.i1);
                    this.i0 = (this.i0 & 0xFF);
                    //unresolved if
                    this.i0 = ___numeric_load_locale;
                    goto _label_21;
                    
                _label_15: 
                    this.i1 = _current_categories;
                    this.i5 = _new_categories;
                    this.i6 = (this.i2 << 5);
                    do 
                    {
                        this.i7 = (this.i1 + this.i6);
                        this.i7 = (this.i7 + 1);
                        this.i0 = (this.i0 & 0xFF);
                        //unresolved if
                        this.i0 = (this.i5 + this.i6);
                        this.i0 = li8(this.i0 + 1);
                        this.i7 = li8(this.i7);
                        this.i6 = (this.i6 + 1);
                    } while (!(!(this.i0 == this.i7)));
                    this.i1 = _current_categories;
                    this.i1 = (this.i1 + this.i6);
                    
                _label_16: 
                    this.i1 = li8(this.i1);
                    this.i0 = (this.i0 & 0xFF);
                    //unresolved if
                    this.i0 = ___monetary_load_locale;
                    goto _label_21;
                    
                _label_17: 
                    this.i1 = _current_categories;
                    this.i5 = _new_categories;
                    this.i6 = (this.i2 << 5);
                    do 
                    {
                        this.i7 = (this.i1 + this.i6);
                        this.i7 = (this.i7 + 1);
                        this.i0 = (this.i0 & 0xFF);
                        //unresolved if
                        this.i0 = (this.i5 + this.i6);
                        this.i0 = li8(this.i0 + 1);
                        this.i7 = li8(this.i7);
                        this.i6 = (this.i6 + 1);
                    } while (!(!(this.i0 == this.i7)));
                    this.i1 = _current_categories;
                    this.i1 = (this.i1 + this.i6);
                    
                _label_18: 
                    this.i1 = li8(this.i1);
                    this.i0 = (this.i0 & 0xFF);
                    //unresolved if
                    this.i0 = ___messages_load_locale;
                    goto _label_21;
                    
                _label_19: 
                    goto _label_3;
                    
                _label_20: 
                    this.i0 = li8(this.i4);
                    this.i1 = li8(this.i3);
                    if (!(this.i0 == this.i1))
                    {
                        this.i1 = this.i3;
                    }
                    else
                    {
                        this.i1 = _current_categories;
                        this.i5 = _new_categories;
                        this.i6 = (this.i2 << 5);
                        do 
                        {
                            this.i7 = (this.i1 + this.i6);
                            this.i7 = (this.i7 + 1);
                            this.i0 = (this.i0 & 0xFF);
                            //unresolved if
                            this.i0 = (this.i5 + this.i6);
                            this.i0 = li8(this.i0 + 1);
                            this.i7 = li8(this.i7);
                            this.i6 = (this.i6 + 1);
                        } while (!(!(this.i0 == this.i7)));
                        this.i1 = _current_categories;
                        this.i1 = (this.i1 + this.i6);
                    };
                    this.i1 = li8(this.i1);
                    this.i0 = (this.i0 & 0xFF);
                    //unresolved if
                    this.i0 = ___wrap_setrunelocale;
                    
                _label_21: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i4, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    (public::mstate.funcs[this.i0]());
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    if (this.i0 == -1) goto _label_12;
                    this.i0 = li8(this.i4);
                    si8(this.i0, this.i3);
                    if (!(this.i0 == 0))
                    {
                        this.i0 = _new_categories;
                        this.i2 = (this.i2 << 5);
                        this.i1 = _current_categories;
                        this.i2 = (this.i2 | 0x01);
                        do 
                        {
                            this.i4 = (this.i0 + this.i2);
                            this.i4 = li8(this.i4);
                            this.i5 = (this.i1 + this.i2);
                            si8(this.i4, this.i5);
                            this.i2 = (this.i2 + 1);
                        } while (!(this.i4 == 0));
                    };
                    public::mstate.eax = this.i3;
                    
                _label_22: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_23: 
                    this.i1 = this.i6;
                    
                _label_24: 
                    this.i1 = (this.i1 - this.i7);
                    this.i1 = (this.i1 + 44);
                    if (uint(this.i1) < uint(0x0400)) goto _label_7;
                    this.i0 = 63;
                    goto _label_11;
                    
                _label_25: 
                    this.i0 = this.i6;
                    
                _label_26: 
                    this.i1 = 0;
                    this.i0 = (this.i0 - this.i7);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = (this.i0 + 1);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 3:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i1 == 0)) goto _label_8;
                    this.i0 = 0;
                    goto _label_9;
                default:
                    throw ("Invalid state in _loadlocale");
            };
        }


    }
}

