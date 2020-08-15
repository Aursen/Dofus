package com.ankamagames.jerakine.pools
{
    import mx.utils.LinkedList;
    import mx.utils.LinkedListNode;

    public class PoolLinkedList extends LinkedList 
    {


        override protected function makeNode(value:*):LinkedListNode
        {
            var node:LinkedListNode;
            node = (PoolsManager.getInstance().getLinkedListNodePool().checkOut() as PoolableLinkedListNode);
            node.value = value;
            return (node);
        }


    }
}

