package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___sfp extends Machine 
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
            var _local_1:FSM___sfp;
            _local_1 = new (FSM___sfp)();
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
                    this.i0 = li8(___sdidinit_2E_b);
                    if (!(this.i0 == 0)) goto _label_4;
                    this.i0 = _usual;
                    this.i1 = _usual_extra;
                    this.i2 = 0;
                    this.i0 = (this.i0 + 56);
                    do 
                    {
                        si32(this.i1, this.i0);
                        this.i1 = (this.i1 + 148);
                        this.i0 = (this.i0 + 88);
                        this.i2 = (this.i2 + 1);
                    } while (!(this.i2 == 17));
                    this.i0 = 1;
                    si8(this.i0, ___cleanup_2E_b);
                    si8(this.i0, ___sdidinit_2E_b);
                    this.i0 = ___sglue;
                    while ((!(this.i0 == 0)))
                    {
                        this.i1 = li32(this.i0 + 4);
                        this.i2 = li32(this.i0 + 8);
                        this.i3 = this.i2;
                        this.i4 = (this.i1 + -1);
                        if (!(this.i4 < 0))
                        {
                            this.i4 = 0;
                            this.i2 = (this.i2 + 12);
                            this.i1 = (this.i1 + -1);
                            do 
                            {
                                this.i5 = li16(this.i2);
                                if (this.i5 == 0) goto _label_2;
                                this.i2 = (this.i2 + 88);
                                this.i1 = (this.i1 + -1);
                                this.i4 = (this.i4 + 1);
                            } while (!(this.i1 < 0));
                        };
                        this.i0 = li32(this.i0);
                        continue;
                    };
                    this.i3 = 2375;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i4 = 0;
                    si32(this.i4, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    this.i4 = this.i3;
                    if (!(!(this.i3 == 0)))
                    {
                        this.i3 = 0;
                    }
                    else
                    {
                        this.i0 = 0;
                        this.i1 = (this.i3 + 15);
                        si32(this.i0, this.i3);
                        this.i3 = 10;
                        this.i0 = (this.i1 & 0xFFFFFFFC);
                        si32(this.i3, (this.i4 + 4));
                        si32(this.i0, (this.i4 + 8));
                        this.i3 = 9;
                        this.i1 = (this.i0 + 880);
                        
                    _label_1: 
                        this.i2 = _empty_2E_3904;
                        this.i5 = this.i0;
                        this.i6 = 88;
                        memcpy(this.i5, this.i2, this.i6);
                        si32(this.i1, (this.i0 + 56));
                        this.i2 = this.i1;
                        this.i5 = _emptyx_2E_3905;
                        this.i6 = 148;
                        memcpy(this.i2, this.i5, this.i6);
                        this.i1 = (this.i1 + 148);
                        this.i0 = (this.i0 + 88);
                        this.i3 = (this.i3 + -1);
                        if (this.i3 > -1) goto _label_5;
                        this.i3 = this.i4;
                    };
                    if (!(this.i3 == 0))
                    {
                        this.i4 = li32(_lastglue);
                        si32(this.i3, this.i4);
                        si32(this.i3, _lastglue);
                        this.i3 = li32(this.i3 + 8);
                        goto _label_3;
                        
                    _label_2: 
                        this.i0 = (this.i4 * 88);
                        this.i3 = (this.i3 + this.i0);
                        
                    _label_3: 
                        this.i0 = this.i3;
                        this.i1 = 1;
                        si16(this.i1, (this.i0 + 12));
                        this.i1 = 0;
                        si32(this.i1, this.i0);
                        si32(this.i1, (this.i0 + 8));
                        si32(this.i1, (this.i0 + 4));
                        si32(this.i1, (this.i0 + 16));
                        si32(this.i1, (this.i0 + 20));
                        si32(this.i1, (this.i0 + 24));
                        this.i2 = -1;
                        si16(this.i2, (this.i0 + 14));
                        si32(this.i1, (this.i0 + 48));
                        si32(this.i1, (this.i0 + 52));
                        si32(this.i1, (this.i0 + 68));
                        si32(this.i1, (this.i0 + 72));
                        this.i2 = li32(this.i0 + 56);
                        si32(this.i1, (this.i2 + 16));
                        this.i2 = li32(this.i0 + 56);
                        this.i2 = (this.i2 + 20);
                        this.i3 = 128;
                        memset(this.i2, this.i1, this.i3);
                    }
                    else
                    {
                        this.i0 = 0;
                    };
                    public::mstate.eax = this.i0;
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_4: 
                    this.i0 = ___sglue;
                    //unresolved jump
                    
                _label_5: 
                    goto _label_1;
                default:
                    throw ("Invalid state in ___sfp");
            };
        }


    }
} cmodule.lua_wrapper

