package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___swsetup extends Machine 
    {

        public static const intRegCount:int = 5;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;


        public static function start():void
        {
            var _local_1:FSM___swsetup;
            _local_1 = new (FSM___swsetup)();
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
                    this.i1 = li8(___sdidinit_2E_b);
                    if (!(!(this.i1 == 0)))
                    {
                        this.i1 = _usual;
                        this.i2 = _usual_extra;
                        this.i3 = 0;
                        this.i1 = (this.i1 + 56);
                        do 
                        {
                            si32(this.i2, this.i1);
                            this.i2 = (this.i2 + 148);
                            this.i1 = (this.i1 + 88);
                            this.i3 = (this.i3 + 1);
                        } while (!(this.i3 == 17));
                        this.i1 = 1;
                        si8(this.i1, ___cleanup_2E_b);
                        si8(this.i1, ___sdidinit_2E_b);
                    };
                    this.i1 = li16(this.i0 + 12);
                    this.i2 = (this.i0 + 12);
                    this.i3 = this.i1;
                    this.i4 = (this.i1 & 0x08);
                    if (!(this.i4 == 0)) goto _label_4;
                    this.i4 = (this.i3 & 0x10);
                    if (!(!(this.i4 == 0)))
                    {
                        this.i0 = 9;
                        si32(this.i0, _val_2E_1440);
                        this.i0 = -1;
                        goto _label_7;
                    };
                    this.i3 = (this.i3 & 0x04);
                    if (!(!(this.i3 == 0))) goto _label_3;
                    this.i1 = li32(this.i0 + 48);
                    this.i3 = (this.i0 + 48);
                    if (this.i1 == 0) goto _label_2;
                    this.i4 = (this.i0 + 64);
                    if (this.i1 == this.i4) goto _label_1;
                    this.i4 = 0;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i1, public::mstate.esp);
                    si32(this.i4, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_pubrealloc.start();
                    return;
                case 1:
                    this.i1 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_1: 
                    this.i1 = 0;
                    si32(this.i1, this.i3);
                    
                _label_2: 
                    this.i1 = 0;
                    this.i3 = li16(this.i2);
                    this.i3 = (this.i3 & 0xFFFFFFDB);
                    si16(this.i3, this.i2);
                    si32(this.i1, (this.i0 + 4));
                    this.i1 = li32(this.i0 + 16);
                    si32(this.i1, this.i0);
                    this.i1 = this.i3;
                    
                _label_3: 
                    this.i1 = (this.i1 | 0x08);
                    si16(this.i1, this.i2);
                    
                _label_4: 
                    this.i1 = li32(this.i0 + 16);
                    if (!(this.i1 == 0)) goto _label_5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___smakebuf.start();
                    return;
                case 2:
                    public::mstate.esp = (public::mstate.esp + 4);
                    
                _label_5: 
                    this.i1 = li16(this.i2);
                    this.i2 = (this.i1 & 0x01);
                    if (!(this.i2 == 0))
                    {
                        this.i1 = 0;
                        si32(this.i1, (this.i0 + 8));
                        this.i2 = li32(this.i0 + 20);
                        this.i2 = (0 - this.i2);
                        si32(this.i2, (this.i0 + 24));
                    }
                    else
                    {
                        this.i2 = (this.i0 + 8);
                        this.i1 = (this.i1 & 0x02);
                        if (!(this.i1 == 0)) goto _label_6;
                        this.i1 = 0;
                        this.i0 = li32(this.i0 + 20);
                        si32(this.i0, this.i2);
                    };
                    public::mstate.eax = this.i1;
                    goto _label_8;
                    
                _label_6: 
                    this.i0 = 0;
                    si32(this.i0, this.i2);
                    
                _label_7: 
                    public::mstate.eax = this.i0;
                    
                _label_8: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in ___swsetup");
            };
        }


    }
} cmodule.lua_wrapper

