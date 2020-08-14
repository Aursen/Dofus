package damageCalculation.tools
{
    public class LinkedListIterator 
    {

        public var cursor:LinkedListNode;

        public function LinkedListIterator(_arg_1:LinkedListNode):void
        {
            cursor = _arg_1;
        }

        public function next():LinkedListNode
        {
            var _local_1:LinkedListNode = cursor;
            cursor = cursor.next;
            return (_local_1);
        }

        public function hasNext():Boolean
        {
            return (!(cursor == null));
        }


    }
} damageCalculation.tools

