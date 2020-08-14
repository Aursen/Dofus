package haxe.ds
{
    import flash.utils.Dictionary;
    import haxe.IMap;
    import haxe.ds._ObjectMap.NativePropertyIterator;

    public dynamic class ObjectMap extends Dictionary implements IMap 
    {

        public function ObjectMap():void
        {
            super(false);
        }

        public function keys():Object
        {
            var _local_1:NativePropertyIterator = new NativePropertyIterator();
            _local_1.collection = this;
            return (_local_1);
        }


    }
} haxe.ds

