package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaO_str2d extends Machine 
    {

        public static const intRegCount:int = 5;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var f0:Number;
        public var i4:int;
        public var i3:int;


        public static function start():void
        {
            var _local_1:FSM_luaO_str2d;
            _local_1 = new (FSM_luaO_str2d)();
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
                    public::mstate.esp = (public::mstate.esp - 4);
                    this.i0 = (public::mstate.ebp + -4);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = li32(public::mstate.ebp + 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i0, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtod.start();
                    return;
                case 1:
                    this.f0 = public::mstate.st0;
                    this.i0 = li32(public::mstate.ebp + 12);
                    public::mstate.esp = (public::mstate.esp + 8);
                    sf64(this.f0, this.i0);
                    this.i2 = li32(public::mstate.ebp + -4);
                    if (!(!(this.i2 == this.i1)))
                    {
                        this.i0 = 0;
                        goto _label_4;
                    };
                    this.i3 = li8(this.i2);
                    if (!(this.i3 == 120))
                    {
                        this.i4 = (this.i3 & 0xFF);
                        if (!(this.i4 == 88))
                        {
                            this.i0 = (this.i3 & 0xFF);
                            if (!(!(this.i0 == 0)))
                            {
                                
                            _label_1: 
                                this.i0 = 1;
                                goto _label_4;
                            };
                            this.i0 = this.i2;
                            goto _label_2;
                        };
                    };
                    this.i2 = 16;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (public::mstate.ebp + -4);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_strtoul.start();
                case 2:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.f0 = Number(uint(this.i1));
                    sf64(this.f0, this.i0);
                    this.i0 = li32(public::mstate.ebp + -4);
                    this.i1 = li8(this.i0);
                    if (this.i1 == 0) goto _label_1;
                    
                _label_2: 
                    this.i1 = li8(this.i0);
                    this.i2 = li32(__CurrentRuneLocale);
                    this.i1 = (this.i1 << 2);
                    this.i1 = (this.i2 + this.i1);
                    this.i1 = li32(this.i1 + 52);
                    this.i1 = (this.i1 & 0x4000);
                    if (!(this.i1 == 0))
                    {
                        do 
                        {
                            this.i1 = (this.i0 + 1);
                            si32(this.i1, (public::mstate.ebp + -4));
                            this.i0 = li8(this.i0 + 1);
                            this.i0 = (this.i0 << 2);
                            this.i0 = (this.i2 + this.i0);
                            this.i0 = li32(this.i0 + 52);
                            this.i0 = (this.i0 & 0x4000);
                            if ((this.i0 == 0)) break;
                            this.i0 = this.i1;
                        } while (true);
                        this.i0 = this.i1;
                    }
                    else
                    {
                    };
                    
                _label_3: 
                    this.i0 = li8(this.i0);
                    this.i0 = ((this.i0 == 0) ? 1 : 0);
                    this.i0 = (this.i0 & 0x01);
                    
                _label_4: 
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    goto _label_3;
                default:
                    throw ("Invalid state in _luaO_str2d");
            };
        }


    }
}

