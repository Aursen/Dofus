package cmodule.lua_wrapper
{
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal class CAllocedValueTypemap extends CTypemap 
    {

        private var allocator:ICAllocator;

        public function CAllocedValueTypemap(_arg_1:ICAllocator)
        {
            this.allocator = _arg_1;
        }

        override public function fromC(_arg_1:Array):*
        {
            return (readValue(_arg_1[0]));
        }

        protected function alloc(_arg_1:*):int
        {
            return (this.allocator.alloc(getValueSize(_arg_1)));
        }

        override public function createC(_arg_1:*, _arg_2:int=0):Array
        {
            if (!_arg_2)
            {
                _arg_2 = this.alloc(_arg_1);
            };
            writeValue(_arg_2, _arg_1);
            return ([_arg_2]);
        }

        override public function destroyC(_arg_1:Array):void
        {
            this.free(_arg_1[0]);
        }

        protected function free(_arg_1:int):void
        {
            return (this.allocator.free(_arg_1));
        }


    }
}

