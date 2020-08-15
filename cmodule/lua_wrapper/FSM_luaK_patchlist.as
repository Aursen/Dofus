package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM_luaK_patchlist extends Machine 
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
            var _local_1:FSM_luaK_patchlist;
            _local_1 = new (FSM_luaK_patchlist)();
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
                    this.i1 = li32(this.i0 + 24);
                    this.i2 = li32(public::mstate.ebp + 12);
                    this.i3 = li32(public::mstate.ebp + 16);
                    //unresolved if
                    si32(this.i1, (this.i0 + 28));
                    public::mstate.esp = (public::mstate.esp - 12);
                    this.i3 = (this.i0 + 32);
                    si32(this.i0, public::mstate.esp);
                    si32(this.i3, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    state = 1;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_luaK_concat.start();
                    return;
                case 1:
                    public::mstate.esp = (public::mstate.esp + 12);
                    do 
                    {
                        
                    _label_1: 
                        public::mstate.esp = public::mstate.ebp;
                        public::mstate.ebp = li32(public::mstate.esp);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.esp = (public::mstate.esp + 4);
                        public::mstate.gworker = caller;
                        return;
                    } while ((this.i2 == -1));
                    this.i1 = (this.i0 + 12);
                    
                _label_2: 
                    this.i4 = li32(this.i0);
                    this.i4 = li32(this.i4 + 12);
                    this.i5 = (this.i2 << 2);
                    this.i5 = (this.i4 + this.i5);
                    this.i5 = li32(this.i5);
                    this.i5 = (this.i5 >>> 14);
                    this.i5 = (this.i5 + -131071);
                    if (!(!(this.i5 == -1)))
                    {
                        this.i5 = -1;
                    }
                    else
                    {
                        this.i5 = (this.i2 + this.i5);
                        this.i5 = (this.i5 + 1);
                    };
                    this.i6 = 0xFF;
                    public::mstate.esp = (public::mstate.esp - 12);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i2, (public::mstate.esp + 4));
                    si32(this.i6, (public::mstate.esp + 8));
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_patchtestreg395396.start();
                case 2:
                    this.i4 = public::mstate.eax;
                    public::mstate.esp = (public::mstate.esp + 12);
                    this.i4 = li32(this.i0);
                    this.i6 = li32(this.i1);
                    this.i4 = li32(this.i4 + 12);
                    public::mstate.esp = (public::mstate.esp - 16);
                    si32(this.i4, public::mstate.esp);
                    si32(this.i6, (public::mstate.esp + 4));
                    si32(this.i2, (public::mstate.esp + 8));
                    si32(this.i3, (public::mstate.esp + 12));
                    state = 3;
                    public::mstate.esp = (public::mstate.esp - 4);
                    FSM_fixjump393394.start();
                    return;
                case 3:
                    public::mstate.esp = (public::mstate.esp + 16);
                    if (this.i5 == -1) goto _label_1;
                    this.i2 = this.i5;
                    goto _label_2;
                default:
                    throw ("Invalid state in _luaK_patchlist");
            };
        }


    }
}

