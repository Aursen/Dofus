package cmodule.lua_wrapper
{
    public class StaticInitter 
    {

        internal var ptr:int = 0;


        private function ST16int(_arg_1:int, _arg_2:int):void
        {
            gstate.gworker.mstate._mw16(_arg_1, _arg_2);
        }

        public function set ascii(_arg_1:String):void
        {
            var _local_2:int;
            var _local_3:int;
            _local_2 = _arg_1.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                this.i8 = _arg_1.charCodeAt(_local_3);
                _local_3++;
            };
        }

        public function set asciz(_arg_1:String):void
        {
            this.ascii = _arg_1;
            this.i8 = 0;
        }

        public function start(_arg_1:int):void
        {
            this.ptr = _arg_1;
        }

        private function ST32int(_arg_1:int, _arg_2:int):void
        {
            gstate.gworker.mstate._mw32(_arg_1, _arg_2);
        }

        public function set i32(_arg_1:uint):void
        {
            this.ST32int(this.ptr, _arg_1);
            this.ptr = (this.ptr + 4);
        }

        public function alloc(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int;
            if (!_arg_2)
            {
                _arg_2 = 1;
            };
            this.ptr = ((this.ptr) ? this.ptr : ((gstate.ds.length) ? gstate.ds.length : 0x0400));
            this.ptr = (((this.ptr + _arg_2) - 1) & (~(_arg_2 - 1)));
            _local_3 = this.ptr;
            this.ptr = (this.ptr + _arg_1);
            gstate.ds.length = this.ptr;
            return (_local_3);
        }

        public function set zero(_arg_1:int):void
        {
            while (_arg_1--)
            {
                this.i8 = 0;
            };
        }

        private function ST8int(_arg_1:int, _arg_2:int):void
        {
            gstate.gworker.mstate._mw8(_arg_1, _arg_2);
        }

        public function set i16(_arg_1:uint):void
        {
            this.ST16int(this.ptr, _arg_1);
            this.ptr = (this.ptr + 2);
        }

        public function set i8(_arg_1:uint):void
        {
            this.ST8int(this.ptr, _arg_1);
            this.ptr = (this.ptr + 1);
        }


    }
} cmodule.lua_wrapper

