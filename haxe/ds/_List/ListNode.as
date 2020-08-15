package haxe.ds._List
{
    public class ListNode 
    {

        public var next:ListNode;
        public var item:Object;

        public function ListNode(_arg_1:Object, _arg_2:ListNode):void
        {
            item = _arg_1;
            next = _arg_2;
        }

    }
}

