package cmodule.lua_wrapper
{
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public final class FSM___collate_err extends Machine 
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
            var _local_1:FSM___collate_err;
            _local_1 = new (FSM___collate_err)();
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
                    this.i0 = li32(___progname);
                    this.i1 = li8(this.i0);
                    this.i2 = this.i0;
                        
                    outer_block:
                    {

                        if (!(this.i1 == 0))
                        {
                            this.i1 = this.i0;
                            do 
                            {
                                this.i3 = li8(this.i1 + 1);
                                this.i1 = (this.i1 + 1);
                                this.i4 = this.i1;
                                if (this.i3 == 0) break outer_block;
                                this.i1 = this.i4;
                            } while (true);
                        };
                        this.i1 = this.i2;
                    
                    }//outer_block
                    this.i3 = 2;
                    this.i4 = (this.i1 - this.i0);
                    this.i5 = __2E_str159130;
                    this.i0 = this.i3;
                    this.i1 = this.i2;
                    this.i2 = this.i4;
                    state = 1;
                case 1:
                    this.i0 = public::mstate.system.write(this.i0, this.i1, this.i2);
                    this.i0 = this.i3;
                    this.i1 = this.i5;
                    this.i2 = this.i3;
                    state = 2;
                case 2:
                    this.i0 = public::mstate.system.write(this.i0, this.i1, this.i2);
                default:
                    throw ("Invalid state in ___collate_err");
            };
        }


    }
}

