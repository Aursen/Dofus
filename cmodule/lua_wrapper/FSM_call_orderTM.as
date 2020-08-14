package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_call_orderTM extends Machine 
    {

        public static const intRegCount:int = 7;
        public static const NumberRegCount:int = 1;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var f0:Number;


        public static function start():void
        {
            var _local_1:FSM_call_orderTM;
            _local_1 = new (FSM_call_orderTM)();
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
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i1 = li32(public::mstate.ebp + 12);
                    this.i2 = li32(public::mstate.ebp + 20);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettmbyobj.start();
                case 1:
                    this.i3 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = li32(this.i3 + 8);
                    this.i5 = (this.i3 + 8);
                    this.i6 = li32(public::mstate.ebp + 16);
                    if (!(!(this.i4 == 0)))
                    {
                        
                    _label_1: 
                        this.i0 = -1;
                        goto _label_3;
                    };
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaT_gettmbyobj.start();
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i3, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaO_rawequalObj.start();
                case 3:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (this.i2 == 0) goto _label_1;
                    this.i2 = li32(this.i0 + 8);
                    this.i4 = li32(this.i0 + 32);
                    this.f0 = lf64(this.i3);
                    sf64(this.f0, this.i2);
                    this.i3 = li32(this.i5);
                    si32(this.i3, (this.i2 + 8));
                    this.i3 = li32(this.i0 + 8);
                    this.f0 = lf64(this.i1);
                    sf64(this.f0, (this.i3 + 12));
                    this.i1 = li32(this.i1 + 8);
                    si32(this.i1, (this.i3 + 20));
                    this.i1 = li32(this.i0 + 8);
                    this.f0 = lf64(this.i6);
                    sf64(this.f0, (this.i1 + 24));
                    this.i3 = li32(this.i6 + 8);
                    si32(this.i3, (this.i1 + 32));
                    this.i1 = li32(this.i0 + 28);
                    this.i3 = li32(this.i0 + 8);
                    this.i2 = (this.i2 - this.i4);
                    this.i4 = (this.i0 + 32);
                    this.i5 = (this.i0 + 8);
                    this.i1 = (this.i1 - this.i3);
                    if (this.i1 > 36) goto _label_2;
                    this.i1 = 3;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 4;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_growstack.start();
                    return;
                case 4:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i1 = 1;
                    this.i3 = li32(this.i5);
                    this.i6 = (this.i3 + 36);
                    si32(this.i6, this.i5);
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i1, (public::mstate.esp + 8));
                    state = 5;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_call.start();
                    return;
                case 5:
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i0 = li32(this.i5);
                    this.i1 = li32(this.i4);
                    this.i3 = (this.i0 + -12);
                    si32(this.i3, this.i5);
                    this.f0 = lf64(this.i0 + -12);
                    this.i1 = (this.i1 + this.i2);
                    sf64(this.f0, this.i1);
                    this.i0 = li32(this.i0 + -4);
                    si32(this.i0, (this.i1 + 8));
                    this.i0 = li32(this.i5);
                    this.i1 = li32(this.i0 + 8);
                    if (!(this.i1 == 0))
                    {
                        if (!(this.i1 == 1))
                        {
                            this.i0 = 1;
                        }
                        else
                        {
                            this.i0 = li32(this.i0);
                            this.i0 = ((this.i0 != 0) ? 1 : 0);
                            this.i0 = (this.i0 & 0x01);
                        };
                        
                    _label_3: 
                        public::mstate.eax = this.i0;
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    };
                    this.i0 = 0;
                    goto _label_3;
                default:
                    throw ("Invalid state in _call_orderTM");
            };
        }


    }
} cmodule.lua_wrapper

