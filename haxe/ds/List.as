package haxe.ds
{
    import haxe.ds._List.ListNode;

    public class List 
    {

        public var q:ListNode;
        public var length:int = 0;
        public var h:ListNode;

        public function List():void
        {
        }

        public function remove(_arg_1:Object):Boolean
        {
            var _local_2:ListNode;
            var _local_3:ListNode = h;
            while (_local_3 != null)
            {
                if (_local_3.item == _arg_1)
                {
                    if (_local_2 == null)
                    {
                        h = _local_3.next;
                    }
                    else
                    {
                        _local_2.next = _local_3.next;
                    };
                    if (q == _local_3)
                    {
                        q = _local_2;
                    };
                    length = (length - 1);
                    return (true);
                };
                _local_2 = _local_3;
                _local_3 = _local_3.next;
            };
            return (false);
        }

        public function map(_arg_1:Function):List
        {
            var _local_4:* = (null as Object);
            var _local_2:List = new List();
            var _local_3:ListNode = h;
            while (_local_3 != null)
            {
                _local_4 = _local_3.item;
                _local_3 = _local_3.next;
                _local_2.add(_arg_1(_local_4));
            };
            return (_local_2);
        }

        public function isEmpty():Boolean
        {
            return (h == null);
        }

        public function filter(_arg_1:Function):List
        {
            var _local_4:* = (null as Object);
            var _local_2:List = new List();
            var _local_3:ListNode = h;
            while (_local_3 != null)
            {
                _local_4 = _local_3.item;
                _local_3 = _local_3.next;
                if (_arg_1(_local_4))
                {
                    _local_2.add(_local_4);
                };
            };
            return (_local_2);
        }

        public function add(_arg_1:Object):void
        {
            var _local_2:ListNode = new ListNode(_arg_1, null);
            if (h == null)
            {
                h = _local_2;
            }
            else
            {
                q.next = _local_2;
            };
            q = _local_2;
            length = (length + 1);
        }


    }
}

