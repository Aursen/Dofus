package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal class CBuffer 
    {

        private static var ptr2Buffer:Object = {};

        private var sizeVal:int;
        private var valCache:*;
        private var allocator:ICAllocator;
        private var ptrVal:int;

        public function CBuffer(_arg_1:int, _arg_2:ICAllocator=null)
        {
            if (!_arg_2)
            {
                _arg_2 = new CHeapAllocator();
            };
            this.allocator = _arg_2;
            this.sizeVal = _arg_1;
            this.alloc();
        }

        public static function free(_arg_1:int):void
        {
            ptr2Buffer[_arg_1].free();
        }


        public function get size():int
        {
            return (this.sizeVal);
        }

        public function set value(_arg_1:*):void
        {
            if (this.ptrVal)
            {
                this.setValue(_arg_1);
            }
            else
            {
                this.valCache = _arg_1;
            };
        }

        public function free():void
        {
            if (this.ptrVal)
            {
                this.valCache = this.computeValue();
                this.allocator.free(this.ptrVal);
                delete ptr2Buffer[this.ptrVal];
                this.ptrVal = 0;
            };
        }

        public function get ptr():int
        {
            return (this.ptrVal);
        }

        protected function setValue(_arg_1:*):void
        {
        }

        public function get value():*
        {
            return ((this.ptrVal) ? this.computeValue() : this.valCache);
        }

        protected function computeValue():*
        {
            return (undefined);
        }

        private function alloc():void
        {
            if (!this.ptrVal)
            {
                this.ptrVal = this.allocator.alloc(this.sizeVal);
                ptr2Buffer[this.ptrVal] = this;
            };
        }

        public function reset():void
        {
            if (!this.ptrVal)
            {
                this.alloc();
                this.setValue(this.valCache);
            };
        }


    }
}

