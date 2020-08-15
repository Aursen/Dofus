package damageCalculation.tools
{
    public class LinkedList 
    {

        public var tail:LinkedListNode = null;
        public var head:LinkedListNode = null;

        public function LinkedList():void
        {
        }

        public function remove(_arg_1:LinkedListNode):void
        {
            if (_arg_1.previous != null)
            {
                _arg_1.previous.next = _arg_1.next;
            };
            if (_arg_1.next != null)
            {
                _arg_1.next.previous = _arg_1.previous;
            };
            if (_arg_1 == head)
            {
                head = _arg_1.next;
            };
            if (_arg_1 == tail)
            {
                tail = _arg_1.previous;
            };
        }

        public function iterator():LinkedListIterator
        {
            return (new LinkedListIterator(head));
        }

        public function copy():LinkedList
        {
            var _local_3:* = (null as LinkedListNode);
            var _local_4:* = (null as LinkedListNode);
            var _local_1:LinkedList = new LinkedList();
            var _local_2:LinkedListNode = head;
            while (_local_2 != null)
            {
                _local_3 = _local_2;
                _local_2 = _local_2.next;
                _local_4 = _local_3;
                _local_1.add(_local_4.item);
            };
            return (_local_1);
        }

        public function clear():void
        {
            head = null;
            tail = null;
        }

        public function append(_arg_1:LinkedList):LinkedList
        {
            var _local_3:* = (null as LinkedListNode);
            var _local_4:* = (null as LinkedListNode);
            var _local_2:LinkedListNode = _arg_1.head;
            while (_local_2 != null)
            {
                _local_3 = _local_2;
                _local_2 = _local_2.next;
                _local_4 = _local_3;
                add(_local_4.item);
            };
            return (this);
        }

        public function add(_arg_1:Object):LinkedListNode
        {
            var _local_2:LinkedListNode = new LinkedListNode(_arg_1);
            if (head == null)
            {
                head = _local_2;
            };
            if (tail == null)
            {
                tail = _local_2;
            }
            else
            {
                _local_2.previous = tail;
                tail.next = _local_2;
                tail = _local_2;
            };
            return (_local_2);
        }


    }
}

