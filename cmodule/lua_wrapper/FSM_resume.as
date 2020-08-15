package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_resume extends Machine 
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
            var _local_1:FSM_resume;
            _local_1 = new (FSM_resume)();
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
                    this.i1 = li8(this.i0 + 6);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = (this.i0 + 6);
                    if (!(this.i1 == 0)) goto _label_1;
                    this.i3 = -1;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i2 = (this.i2 + -12);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_precall.start();
                    return;
                case 1:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    if (this.i2 == 0) goto _label_3;
                    goto _label_4;
                    
                _label_1: 
                    this.i1 = 0;
                    this.i4 = li32(this.i0 + 20);
                    si8(this.i1, this.i3);
                    this.i1 = li32(this.i4 + 4);
                    this.i1 = li32(this.i1);
                    this.i1 = li8(this.i1 + 6);
                    this.i3 = (this.i0 + 20);
                    if (this.i1 == 0) goto _label_2;
                    public::mstate.esp = (public::mstate.esp - 8);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_poscall.start();
                    return;
                case 2:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 8);
                    if (!(this.i4 == 0))
                    {
                        this.i4 = li32(this.i3);
                        this.i4 = li32(this.i4 + 8);
                        si32(this.i4, (this.i0 + 8));
                        goto _label_3;
                        
                    _label_2: 
                        this.i1 = li32(this.i4);
                        si32(this.i1, (this.i0 + 12));
                    };
                    
                _label_3: 
                    this.i1 = li32(this.i0 + 20);
                    this.i2 = li32(this.i0 + 40);
                    this.i1 = (this.i1 - this.i2);
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i1 = (this.i1 / 24);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i1, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaV_execute.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_4: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                default:
                    throw ("Invalid state in _resume");
            };
        }


    }
}

