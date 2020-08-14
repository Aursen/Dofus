package haxe.ds._IntMap
{
    import flash.utils.Dictionary;
    import avm2.intrinsics.iteration.*; // ASC2.0, AIR3.6 SDK and above

    public class IntMapValuesIterator 
    {

        public var nextIndex:int;
        public var index:int;
        public var h:Dictionary;

        public function IntMapValuesIterator(_arg_1:Dictionary):void
        {
            h = _arg_1;
            index = 0;
            var _local_2:Dictionary = h;
            var _local_3:int = index;
            var _local_4:Boolean = 
            // unexpected hasnext2 action
            // Either this script was not decompiled correctly, or, it was produced by an unsupported compiler
            // and has no high level AS3 representation. If original source was in Haxe, this line could be:
            //   untyped __has_next__(_local_2,_local_3);
;
            nextIndex = _local_3;
        }

        public function next():Object
        {
            var _local_1:Object = nextvalue(h, nextIndex);
            index = nextIndex;
            return (_local_1);
        }

        public function hasNext():Boolean
        {
            var _local_1:Dictionary = h;
            var _local_2:int = index;
            var _local_3:Boolean = 
            // unexpected hasnext2 action
            // Either this script was not decompiled correctly, or, it was produced by an unsupported compiler
            // and has no high level AS3 representation. If original source was in Haxe, this line could be:
            //   untyped __has_next__(_local_1,_local_2);
;
            nextIndex = _local_2;
            return (_local_3);
        }


    }
} haxe.ds._IntMap

