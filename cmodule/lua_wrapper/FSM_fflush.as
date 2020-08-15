package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_fflush extends Machine 
    {

        public static const intRegCount:int = 6;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;


        public static function start():void
        {
            var _local_1:FSM_fflush;
            _local_1 = new (FSM_fflush)();
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
                    if (!(this.i0 == 0)) goto _label_5;
                    this.i0 = ___sglue;
                    this.i1 = 0;
                    
                _label_1: 
                    this.i2 = li32(this.i0 + 4);
                    this.i3 = li32(this.i0 + 8);
                    this.i4 = (this.i2 + -1);
                    if (!(this.i4 > -1)) goto _label_4;
                    this.i2 = (this.i2 + -1);
                    
                _label_2: 
                    this.i4 = li16(this.i3 + 12);
                    this.i4 = (this.i4 << 16);
                    this.i4 = (this.i4 >> 16);
                    this.i5 = this.i3;
                    if (!(this.i4 > 0)) goto _label_3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i5, public::mstate.esp);
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sflush.start();
                    return;
                case 1:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    this.i1 = (this.i4 | this.i1);
                    
                _label_3: 
                    this.i3 = (this.i3 + 88);
                    this.i2 = (this.i2 + -1);
                    if (this.i2 > -1) goto _label_7;
                    
                _label_4: 
                    this.i0 = li32(this.i0);
                    if (!(this.i0 == 0)) goto _label_1;
                    public::mstate.eax = this.i1;
                    do 
                    {
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                        
                    _label_5: 
                        this.i1 = li16(this.i0 + 12);
                        this.i1 = (this.i1 & 0x18);
                        if ((!(this.i1 == 0))) break;
                        this.i0 = 9;
                        si32(this.i0, _val_2E_1440);
                        this.i0 = -1;
                        
                    _label_6: 
                        public::mstate.eax = this.i0;
                    } while (true);
                    public::mstate.esp = (public::mstate.esp - 4);
                    si32(this.i0, public::mstate.esp);
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM___sflush.start();
                    return;
                case 2:
                    this.i0 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 4);
                    goto _label_6;
                    
                _label_7: 
                    goto _label_2;
                default:
                    throw ("Invalid state in _fflush");
            };
        }


    }
}

