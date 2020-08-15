package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_tzset_basic extends Machine 
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
            var _local_1:FSM_tzset_basic;
            _local_1 = new (FSM_tzset_basic)();
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
                    this.i0 = __2E_str5353;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_getenv.start();
                case 1:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = li32(_lcl_is_set);
                    this.i2 = this.i0;
                    if (!(this.i0 == 0)) goto _label_3;
                    if (this.i1 < 0) goto _label_2;
                    this.i0 = -1;
                    si32(this.i0, _lcl_is_set);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i0 = _lclmem;
                    this.i1 = 0;
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tzload.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i0 == 0) goto _label_9;
                    this.i0 = _gmt;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = _lclmem;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tzload.start();
                    return;
                case 3:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i0 == 0) goto _label_1;
                    this.i0 = _gmt;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = _lclmem;
                    this.i2 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tzparse.start();
                    return;
                case 4:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_settzname.start();
                case 5:
                    do 
                    {
                        
                    _label_2: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_3: 
                        if (this.i1 < 1) goto _label_5;
                        this.i1 = li8(_lcl_TZname);
                        this.i3 = li8(this.i0);
                        if (!(this.i1 == this.i3))
                        {
                            this.i3 = this.i0;
                            goto _label_4;
                        };
                        this.i3 = _lcl_TZname;
                        this.i4 = 0;
                        continue;
                    } while ((this.i5 = (this.i2 + this.i4)), (this.i5 = (this.i5 + 1)), (this.i1 = (this.i1 & 0xFF)), (this.i1 == 0));
                    this.i1 = (this.i3 + this.i4);
                    this.i1 = li8(this.i1 + 1);
                    this.i5 = li8(this.i5);
                    this.i4 = (this.i4 + 1);
                    //unresolved if
                    this.i3 = (this.i2 + this.i4);
                    
                _label_4: 
                    this.i3 = li8(this.i3);
                    this.i1 = (this.i1 & 0xFF);
                    if (this.i1 == this.i3) goto _label_2;
                    
                _label_5: 
                    this.i1 = li8(this.i0);
                    if (this.i1 == 0) goto _label_10;
                    this.i3 = this.i2;
                    do 
                    {
                        this.i4 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i5 = this.i3;
                        if (this.i4 == 0) goto _label_11;
                        this.i3 = this.i5;
                    } while (true);
                    
                _label_6: 
                    this.i1 = (this.i1 & 0xFF);
                    if (!(!(this.i1 == 0)))
                    {
                        
                    _label_7: 
                        this.i0 = 0;
                        si32(this.i0, _lclmem);
                        si32(this.i0, (_lclmem + 4));
                        si32(this.i0, (_lclmem + 8));
                        si32(this.i0, (_lclmem + 1872));
                        si32(this.i0, (_lclmem + 1868));
                        si32(this.i0, (_lclmem + 1876));
                        this.i1 = 85;
                        this.i2 = 84;
                        this.i3 = 67;
                        si8(this.i1, (_lclmem + 6988));
                        si8(this.i2, (_lclmem + 6989));
                        si8(this.i3, (_lclmem + 6990));
                        si8(this.i0, (_lclmem + 6991));
                        goto _label_9;
                    };
                    this.i1 = _lclmem;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 6;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tzload.start();
                    return;
                case 6:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    //unresolved if
                    this.i1 = li8(this.i0);
                    if (this.i1 == 58) goto _label_8;
                    this.i1 = _lclmem;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = 0;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 7;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tzparse.start();
                    return;
                case 7:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    //unresolved if
                    
                _label_8: 
                    this.i0 = _gmt;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = _lclmem;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 8;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tzload.start();
                    return;
                case 8:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i0 == 0) goto _label_9;
                    this.i0 = _gmt;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = _lclmem;
                    this.i2 = 1;
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 9;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_tzparse.start();
                    return;
                case 9:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    do 
                    {
                        
                    _label_9: 
                        goto _label_1;
                    } while (true);
                    
                _label_10: 
                    this.i3 = this.i0;
                    
                _label_11: 
                    this.i3 = (this.i3 - this.i2);
                    this.i4 = ((uint(this.i3) < uint(0x0100)) ? 1 : 0);
                    this.i4 = (this.i4 & 0x01);
                    si32(this.i4, _lcl_is_set);
                    if (uint(this.i3) > uint(0xFF)) goto _label_6;
                    si8(this.i1, _lcl_TZname);
                    this.i3 = (this.i1 & 0xFF);
                    if (this.i3 == 0) goto _label_7;
                    this.i3 = _lcl_TZname;
                    this.i4 = 1;
                    do 
                    {
                        this.i5 = (this.i2 + this.i4);
                        this.i5 = li8(this.i5);
                        this.i6 = (this.i3 + this.i4);
                        si8(this.i5, this.i6);
                        this.i4 = (this.i4 + 1);
                        if (this.i5 == 0) goto _label_6;
                    } while (true);
                default:
                    throw ("Invalid state in _tzset_basic");
            };
        }


    }
}

