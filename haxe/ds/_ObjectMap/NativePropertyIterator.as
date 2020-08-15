package haxe.ds._ObjectMap
{
    import avm2.intrinsics.iteration.*; // ASC2.0, AIR3.6 SDK and above

    public class NativePropertyIterator 
    {

        public var index:int = 0;
        public var collection:*;

        public function NativePropertyIterator():void
        {
        }

        public function next():*
        {
            var _local_1:int = index;
            var _local_2:* = nextname(collection, _local_1);
            index = _local_1;
            return (_local_2);
        }

        public function hasNext():Boolean
        {
            var _local_1:* = collection;
            var _local_2:int = index;
            var _local_3:Boolean = 
            // unexpected hasnext2 action
            // Either this script was not decompiled correctly, or, it was produced by an unsupported compiler
            // and has no high level AS3 representation. If original source was in Haxe, this line could be:
            //   untyped __has_next__(_local_1,_local_2);
;
            collection = _local_1;
            index = _local_2;
            return (_local_3);
        }


    }
}

