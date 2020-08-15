package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper._free;
    import cmodule.lua_wrapper._malloc;

    internal class CHeapAllocator implements ICAllocator 
    {

        private var pmalloc:Function;
        private var pfree:Function;


        public function free(_arg_1:int):void
        {
            if (this.pfree == null)
            {
                this.pfree = new CProcTypemap(CTypemap.VoidType, [CTypemap.PtrType]).fromC([_free]);
            };
            this.pfree(_arg_1);
        }

        public function alloc(_arg_1:int):int
        {
            var _local_2:int;
            if (this.pmalloc == null)
            {
                this.pmalloc = new CProcTypemap(CTypemap.PtrType, [CTypemap.IntType]).fromC([_malloc]);
            };
            return (this.pmalloc(_arg_1));
        }


    }
}

