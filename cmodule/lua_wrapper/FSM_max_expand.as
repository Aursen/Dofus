package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_max_expand extends Machine 
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
            var _local_1:FSM_max_expand;
            _local_1 = new (FSM_max_expand)();
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
                    this.i1 = li32(this.i0 + 4);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(public::mstate.ebp + 16);
                    this.i4 = li32(public::mstate.ebp + 20);
                    if (!(uint(this.i1) > uint(this.i2)))
                    {
                        this.i1 = 0;
                        
                    _label_1: 
                        this.i4 = (this.i4 + 1);
                        goto _label_8;
                    };
                    this.i5 = 0;
                    this.i6 = li8(this.i3);
                    this.i7 = (this.i6 << 24);
                    this.i7 = (this.i7 >> 24);
                    this.i8 = (this.i4 + -1);
                    this.i9 = (this.i3 + 1);
                    do 
                    {
                        this.i10 = (this.i2 + this.i5);
                        this.i10 = li8(this.i10);
                        this.i11 = this.i10;
                        if (this.i7 == 37) goto _label_3;
                        if (this.i7 == 91) goto _label_4;
                        if (!(this.i7 == 46)) goto _label_5;
                        this.i10 = 1;
                        goto _label_6;
                        
                    _label_2: 
                        this.i5 = (this.i5 + 1);
                        this.i10 = (this.i2 + this.i5);
                    } while ((uint(this.i10) < uint(this.i1)));
                    this.i1 = this.i5;
                    goto _label_1;
                    
                _label_3: 
                    this.i10 = li8(this.i9);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i10, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match_class.start();
                case 1:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_6;
                    
                _label_4: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i11, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i8, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_matchbracketclass.start();
                case 2:
                    this.i10 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    goto _label_6;
                    
                _label_5: 
                    this.i10 = (this.i10 & 0xFF);
                    this.i11 = (this.i6 & 0xFF);
                    this.i10 = ((this.i11 == this.i10) ? 1 : 0);
                    this.i10 = (this.i10 & 0x01);
                    
                _label_6: 
                    if (!(this.i10 == 0)) goto _label_2;
                    this.i1 = this.i5;
                    goto _label_1;
                    
                _label_7: 
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i2 + this.i1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i4, (public::mstate.esp + 8));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_match384.start();
                    return;
                case 3:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (!(this.i3 == 0))
                    {
                        this.i1 = this.i3;
                    }
                    else
                    {
                        this.i1 = (this.i1 + -1);
                        
                    _label_8: 
                        if (this.i1 > -1) goto _label_7;
                        this.i1 = 0;
                    };
                    this.i0 = this.i1;
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _max_expand");
            };
        }


    }
} cmodule.lua_wrapper

