package cmodule.lua_wrapper
{
    import flash.utils.ByteArray;

    internal class CStrUTF8Buffer extends CBuffer 
    {

        private var nullTerm:Boolean;

        public function CStrUTF8Buffer(_arg_1:int, _arg_2:Boolean=true, _arg_3:ICAllocator=null)
        {
            super(_arg_1, _arg_3);
            this.nullTerm = _arg_2;
        }

        override protected function computeValue():*
        {
            var _local_1:int;
            _local_1 = 0;
            var _local_2:int = this.size;
            mstate.ds.position = this.ptr;
            while (((_local_2--) && (!(mstate.ds.readByte() == 0))))
            {
                _local_1++;
            };
            mstate.ds.position = this.ptr;
            return (mstate.ds.readUTFBytes(_local_1));
        }

        override protected function setValue(_arg_1:*):void
        {
            var _local_2:ByteArray;
            var _local_3:int;
            _local_2 = new ByteArray();
            _local_3 = ((this.nullTerm) ? (this.size - 1) : this.size);
            _local_2.writeUTFBytes(_arg_1);
            if (_local_2.length > _local_3)
            {
                _local_2.length = _local_3;
            };
            if (_local_2.length < this.size)
            {
                _local_2.writeByte(0);
            };
            _local_2.position = 0;
            _local_2.readBytes(mstate.ds, this.ptr);
        }


    }
}

