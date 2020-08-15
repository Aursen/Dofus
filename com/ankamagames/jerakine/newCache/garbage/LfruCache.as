package com.ankamagames.jerakine.newCache.garbage
{
    import com.ankamagames.jerakine.newCache.ICache;
    import flash.utils.Dictionary;
    import mx.utils.LinkedList;
    import mx.utils.LinkedListNode;

    public class LfruCache implements ICache 
    {

        private var _unprivileged:Dictionary = new Dictionary();
        private var _unprivilegedSize:uint = 0;
        private var _privileged:Dictionary = new Dictionary();
        private var _privilegedSize:uint = 0;
        private var _privilegedList:LinkedList = new LinkedList();
        private var _frequency:Dictionary = new Dictionary();
        public var minRequiredFrequency:uint;
        public var unprivilegedBounds:uint;
        public var privilegedBounds:uint;

        public function LfruCache(privilegedBounds:uint, unprivilegedBounds:uint, minRequiredFrequency:uint)
        {
            this.privilegedBounds = privilegedBounds;
            this.unprivilegedBounds = unprivilegedBounds;
            this.minRequiredFrequency = minRequiredFrequency;
        }

        public function store(ref:*, object:*):Boolean
        {
            this.purge();
            if (this._unprivileged[ref])
            {
                return (false);
            };
            if (!this._frequency[1])
            {
                this._frequency[1] = new LinkedList();
            };
            var cacheObject:CacheObject = new CacheObject(object, 1, ref);
            var cacheObjectNode:LinkedListNode = (this._frequency[1] as LinkedList).unshift(cacheObject);
            this._unprivileged[ref] = cacheObjectNode;
            this._unprivilegedSize++;
            return (true);
        }

        private function removeNodeFromList(node:LinkedListNode):void
        {
            if (node.next != null)
            {
                node.next.prev = node.prev;
            };
            if (node.prev != null)
            {
                node.prev.next = node.next;
            };
            node.next = null;
            node.prev = null;
        }

        public function get size():uint
        {
            return (this._unprivilegedSize + this._privilegedSize);
        }

        public function destroy():void
        {
            this._unprivileged = new Dictionary();
            this._unprivilegedSize = 0;
            this._privileged = new Dictionary();
            this._privilegedSize = 0;
            this._privilegedList = new LinkedList();
            this._frequency = new Dictionary();
        }

        public function contains(ref:*):Boolean
        {
            return ((this._unprivileged[ref]) || (this._privileged[ref]));
        }

        public function extract(ref:*):*
        {
            var value:* = null;
            if (this._privileged[ref])
            {
                value = this._privileged[ref].value;
                delete this._privileged[ref];
            }
            else
            {
                if (this._unprivileged[ref])
                {
                    value = this._unprivileged[ref].value;
                    delete this._unprivileged[ref];
                };
            };
            return (value);
        }

        public function peek(ref:*):*
        {
            var tmpFrequecyList:LinkedList;
            var cacheObj:CacheObject;
            var node:LinkedListNode;
            if (this._privileged[ref])
            {
                node = this._privileged[ref];
                node.value.parameter++;
                if (this._privilegedList.find(this._privileged[ref].value))
                {
                    this._privilegedList.remove(this._privileged[ref]);
                };
                this._privilegedList.unshift(this._privileged[ref]);
            }
            else
            {
                if (this._unprivileged[ref])
                {
                    node = this._unprivileged[ref];
                    tmpFrequecyList = this._frequency[(this._unprivileged[ref] as LinkedListNode).value.parameter];
                    if (((tmpFrequecyList) && (tmpFrequecyList.find(this._unprivileged[ref].value))))
                    {
                        tmpFrequecyList.remove(this._unprivileged[ref]);
                    };
                    cacheObj = (this._unprivileged[ref] as LinkedListNode).value;
                    cacheObj.parameter++;
                    if (cacheObj.parameter > this.minRequiredFrequency)
                    {
                        this._privileged[ref] = this._unprivileged[ref];
                        this._unprivilegedSize--;
                        this._privilegedList.push(node);
                        this._privilegedSize++;
                        this._unprivileged[ref] = null;
                        delete this._unprivileged[ref];
                    }
                    else
                    {
                        if (!this._frequency[cacheObj.parameter])
                        {
                            this._frequency[cacheObj.parameter] = new LinkedList();
                        };
                        (this._frequency[cacheObj.parameter] as LinkedList).unshift(this._unprivileged[ref]);
                    };
                }
                else
                {
                    return (null);
                };
            };
            return (node.value.data);
        }

        public function purge():void
        {
            var delta:int;
            var i:int;
            var nodeToDelete:LinkedListNode;
            var tmpDelta:int;
            var j:int;
            if (this._privilegedSize > this.privilegedBounds)
            {
                delta = (this._privilegedSize - (this.privilegedBounds * 0.7));
                i = 0;
                while (i < delta)
                {
                    nodeToDelete = this._privilegedList.pop();
                    this._privileged[nodeToDelete.value.ref] = null;
                    delete this._privileged[nodeToDelete.value.ref];
                    this._privilegedSize--;
                    i++;
                };
            };
            if (this._unprivilegedSize > this.unprivilegedBounds)
            {
                i = 1;
                delta = (this._unprivilegedSize - (this.unprivilegedBounds * 0.7));
                while (this._unprivilegedSize > (this.unprivilegedBounds - delta))
                {
                    if (this._frequency[i])
                    {
                        tmpDelta = ((this._frequency[i].length < delta) ? this._frequency[i].length : delta);
                        j = 0;
                        while (j < tmpDelta)
                        {
                            nodeToDelete = this._frequency[i].pop();
                            this._unprivileged[nodeToDelete.value.ref] = null;
                            delete this._unprivileged[nodeToDelete.value.ref];
                            delta--;
                            this._unprivilegedSize--;
                            j++;
                        };
                        if (this._frequency[i].length == 0)
                        {
                            this._frequency[i] = null;
                            delete this._frequency[i];
                        };
                    };
                    i++;
                };
            };
        }


    }
}

class CacheObject 
{

    public var data:*;
    public var parameter:uint;
    public var ref:*;

    public function CacheObject(data:*, parameter:uint, ref:*):void
    {
        this.data = data;
        this.parameter = parameter;
        this.ref = ref;
    }

}


