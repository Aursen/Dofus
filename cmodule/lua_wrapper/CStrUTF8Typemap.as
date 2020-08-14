package cmodule.lua_wrapper
{
    import flash.utils.ByteArray;

    internal class CStrUTF8Typemap extends CAllocedValueTypemap 
    {

        public function CStrUTF8Typemap(_arg_1:ICAllocator=null)
        {
            if (!_arg_1)
            {
                _arg_1 = new CHeapAllocator();
            };
            super(_arg_1);
        }

        protected function ByteArrayForString(_arg_1:String):ByteArray
        {
            var _local_2:ByteArray;
            _local_2 = new ByteArray();
            _local_2.writeUTFBytes(_arg_1);
            _local_2.writeByte(0);
            _local_2.position = 0;
            return (_local_2);
        }

        override public function readValue(_arg_1:int):*
        {
            var _local_2:int;
            mstate.ds.position = _arg_1;
            _local_2 = 0;
            while (mstate.ds.readByte() != 0)
            {
                _local_2++;
            };
            mstate.ds.position = _arg_1;
            return (mstate.ds.readUTFBytes(_local_2));
        }

        override public function getValueSize(_arg_1:*):int
        {
            return (this.ByteArrayForString(String(_arg_1)).length);
        }

        override public function get ptrLevel():int
        {
            return (1);
        }

        override public function writeValue(_arg_1:int, _arg_2:*):void
        {
            this.ByteArrayForString(String(_arg_2)).readBytes(mstate.ds, _arg_1);
        }


    }
} cmodule.lua_wrapper

