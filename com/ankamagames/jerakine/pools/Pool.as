package com.ankamagames.jerakine.pools
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import mx.utils.LinkedList;
    import mx.utils.LinkedListNode;

    public class Pool 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Pool));

        private var _pooledClass:Class;
        private var _pool:LinkedList;
        private var _growSize:int;
        private var _warnLimit:int;
        private var _totalSize:int;

        public function Pool(pooledClass:Class, initialSize:int, growSize:int, warnLimit:int=0)
        {
            this._pooledClass = pooledClass;
            if (this._pooledClass == PoolableLinkedListNode)
            {
                this._pool = new LinkedList();
            }
            else
            {
                this._pool = new PoolLinkedList();
            };
            this._growSize = growSize;
            this._warnLimit = warnLimit;
            var i:uint;
            while (i < initialSize)
            {
                this._pool.unshift(new this._pooledClass());
                i++;
            };
            this._totalSize = initialSize;
        }

        public function get pooledClass():Class
        {
            return (this._pooledClass);
        }

        public function get poolList():LinkedList
        {
            return (this._pool);
        }

        public function get growSize():int
        {
            return (this._growSize);
        }

        public function get warnLimit():int
        {
            return (this._warnLimit);
        }

        public function checkOut():Poolable
        {
            var o:Poolable;
            var i:uint;
            if (this._pool.length == 0)
            {
                i = 0;
                while (i < this._growSize)
                {
                    this._pool.push(new this._pooledClass());
                    i++;
                };
                this._totalSize = (this._totalSize + this._growSize);
                if (((this._warnLimit > 0) && (this._totalSize > this._warnLimit)))
                {
                    _log.warn((((((("Pool of " + this._pooledClass) + " size beyond the warning limit. Size: ") + this._totalSize) + ", limit: ") + this._warnLimit) + "."));
                };
            };
            var node:LinkedListNode = this._pool.shift();
            if (this._pooledClass == PoolableLinkedListNode)
            {
                o = (node as PoolableLinkedListNode);
            }
            else
            {
                o = node.value;
                PoolsManager.getInstance().getLinkedListNodePool().checkIn((node as PoolableLinkedListNode));
            };
            return (o);
        }

        public function checkIn(freedObject:Poolable):void
        {
            if (!freedObject)
            {
                return;
            };
            freedObject.free();
            this._pool.push(freedObject);
        }


    }
} com.ankamagames.jerakine.pools

