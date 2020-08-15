package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_resume_error extends Machine 
    {

        public static const intRegCount:int = 8;
        public static const NumberRegCount:int = 0;

        public var i0:int;
        public var i1:int;
        public var i2:int;
        public var i3:int;
        public var i4:int;
        public var i5:int;
        public var i6:int;
        public var i7:int;


        public static function start():void
        {
            var _local_1:FSM_resume_error;
            _local_1 = new (FSM_resume_error)();
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
                    this.i1 = li32(this.i0 + 20);
                    this.i1 = li32(this.i1);
                    this.i2 = li32(public::mstate.ebp + 12);
                    si32(this.i1, (this.i0 + 8));
                    this.i3 = li8(this.i2);
                    this.i4 = (this.i0 + 8);
                    this.i5 = this.i2;
                    if (this.i3 == 0) goto _label_5;
                    this.i3 = this.i5;
                    do 
                    {
                        this.i6 = li8(this.i3 + 1);
                        this.i3 = (this.i3 + 1);
                        this.i7 = this.i3;
                        if (this.i6 == 0) goto _label_6;
                        this.i3 = this.i7;
                    } while (true);
                    
                _label_1: 
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 + 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 8);
                    
                _label_2: 
                    this.i2 = li32(this.i4);
                    this.i2 = (this.i2 + 12);
                    si32(this.i2, this.i4);
                    goto _label_4;
                    
                _label_3: 
                    this.i0 = (this.i2 + 12);
                    si32(this.i0, this.i4);
                    
                _label_4: 
                    public::mstate.esp = public::mstate.ebp;
                    public::mstate.ebp = li32(public::mstate.esp);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.esp = (public::mstate.esp + 4);
                    public::mstate.gworker = caller;
                    return;
                    
                _label_5: 
                    this.i3 = this.i2;
                    
                _label_6: 
                    this.i6 = 4;
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i3 - this.i5);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i3, (public::mstate.esp + 8));
                    state = 2;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaS_newlstr.start();
                    return;
                case 2:
                    this.i2 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    si32(this.i2, this.i1);
                    si32(this.i6, (this.i1 + 8));
                    this.i1 = li32(this.i0 + 28);
                    this.i2 = li32(this.i4);
                    this.i1 = (this.i1 - this.i2);
                    if (this.i1 > 12) goto _label_3;
                    this.i2 = li32(this.i0 + 44);
                    if (this.i2 < 1) goto _label_1;
                    public::mstate.esp = (public::mstate.esp - 8);
                    this.i2 = (this.i2 << 1);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaD_reallocstack.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 8);
                    goto _label_2;
                default:
                    throw ("Invalid state in _resume_error");
            };
        }


    }
}

