package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___monetary_load_locale extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;


        public static function start():void
        {
            var _local_1:FSM___monetary_load_locale;
            _local_1 = new (FSM___monetary_load_locale)();
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
                    this.i0 = __monetary_using_locale;
                    public::mstate.esp = (public::mstate.esp - 28);
                    this.i1 = li32(public::mstate.ebp + 8);
                    this.i2 = __monetary_locale_buf;
                    this.i3 = __2E_str19158;
                    this.i4 = __monetary_locale;
                    this.i5 = 15;
                    this.i6 = 21;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    si32(this.i6, (public::mstate.esp + 16));
                    si32(this.i5, (public::mstate.esp + 20));
                    si32(this.i4, (public::mstate.esp + 24));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___part_load_locale.start();
                    return;
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 28);
                    if (this.i0 == -1) goto _label_11;
                    this.i1 = 0;
                    si8(this.i1, ___mlocale_changed_2E_b);
                    if (!(this.i0 == 0)) goto _label_11;
                    this.i1 = li32(__monetary_locale + 16);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___fix_locale_grouping_str.start();
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    si32(this.i1, (__monetary_locale + 16));
                    this.i1 = li32(__monetary_locale + 28);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    this.i1 = li32(__monetary_locale + 32);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 4:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    this.i1 = li32(__monetary_locale + 36);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 5:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    this.i1 = li32(__monetary_locale + 40);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 6:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    this.i1 = li32(__monetary_locale + 44);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 7:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    this.i1 = li32(__monetary_locale + 48);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 8:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    this.i1 = li32(__monetary_locale + 52);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 9:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    this.i1 = li32(__monetary_locale + 56);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 10:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    this.i1 = li32(__monetary_locale + 60);
                    if (!(this.i1 == 0)) goto _label_2;
                    this.i1 = li32(__monetary_locale + 36);
                    si32(this.i1, (__monetary_locale + 60));
                    this.i1 = li32(__monetary_locale + 64);
                    if (this.i1 == 0) goto _label_3;
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 11:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    this.i1 = li32(__monetary_locale + 68);
                    if (this.i1 == 0) goto _label_5;
                    goto _label_4;
                    
                _label_2: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 12:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    this.i1 = li32(__monetary_locale + 64);
                    if (!(this.i1 == 0)) goto _label_1;
                    
                _label_3: 
                    this.i1 = li32(__monetary_locale + 44);
                    si32(this.i1, (__monetary_locale + 64));
                    this.i1 = li32(__monetary_locale + 68);
                    if (this.i1 == 0) goto _label_5;
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 13:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    this.i1 = li32(__monetary_locale + 72);
                    if (this.i1 == 0) goto _label_7;
                    goto _label_6;
                    
                _label_5: 
                    this.i1 = li32(__monetary_locale + 40);
                    si32(this.i1, (__monetary_locale + 68));
                    this.i1 = li32(__monetary_locale + 72);
                    if (this.i1 == 0) goto _label_7;
                    
                _label_6: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 14:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    this.i1 = li32(__monetary_locale + 76);
                    if (this.i1 == 0) goto _label_9;
                    goto _label_8;
                    
                _label_7: 
                    this.i1 = li32(__monetary_locale + 48);
                    si32(this.i1, (__monetary_locale + 72));
                    this.i1 = li32(__monetary_locale + 76);
                    if (this.i1 == 0) goto _label_9;
                    
                _label_8: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 15:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    this.i1 = li32(__monetary_locale + 80);
                    if (this.i1 == 0) goto _label_12;
                    goto _label_10;
                    
                _label_9: 
                    this.i1 = li32(__monetary_locale + 52);
                    si32(this.i1, (__monetary_locale + 76));
                    this.i1 = li32(__monetary_locale + 80);
                    if (this.i1 == 0) goto _label_12;
                    
                _label_10: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i1, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtol.start();
                case 16:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i2 = ((this.i2 == -1) ? 127 : this.i2);
                    si8(this.i2, this.i1);
                    do 
                    {
                        
                    _label_11: 
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_12: 
                        this.i1 = li32(__monetary_locale + 56);
                        si32(this.i1, (__monetary_locale + 80));
                    } while (true);
                default:
                    throw ("Invalid state in ___monetary_load_locale");
            };
        }


    }
} cmodule.lua_wrapper

