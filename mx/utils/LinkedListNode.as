package mx.utils
{
    public class LinkedListNode 
    {

        public var next:LinkedListNode;
        public var prev:LinkedListNode;
        public var value:*;

        public function LinkedListNode(value:*=null):void
        {
            this.value = value;
        }

    }
} mx.utils

