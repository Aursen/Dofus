package org.apache.thrift
{
    import flash.utils.Dictionary;

    public class Set 
    {

        private var _elements:Dictionary = new Dictionary();
        private var _size:int = 0;

        public function Set(... _args)
        {
            var _local_2:*;
            super();
            for each (_local_2 in _args)
            {
                this.add(_local_2);
            };
        }

        public function add(_arg_1:*):Boolean
        {
            var _local_2:Boolean = this._elements.hasOwnProperty(_arg_1);
            if (!_local_2)
            {
                this._size++;
                this._elements[_arg_1] = true;
            };
            return (!(_local_2));
        }

        public function clear():void
        {
            var _local_1:*;
            for (_local_1 in this._elements)
            {
                this.remove(_local_1);
            };
        }

        public function contains(_arg_1:Object):Boolean
        {
            return (this._elements.hasOwnProperty(_arg_1));
        }

        public function isEmpty():Boolean
        {
            return (this._size == 0);
        }

        public function remove(_arg_1:*):Boolean
        {
            if (this.contains(_arg_1))
            {
                delete this._elements[_arg_1];
                this._size--;
                return (true);
            };
            return (false);
        }

        public function toArray():Array
        {
            var _local_2:*;
            var _local_1:Array = new Array();
            for (_local_2 in this._elements)
            {
                _local_1.push(_local_2);
            };
            return (_local_1);
        }

        public function get size():int
        {
            return (this._size);
        }


    }
} org.apache.thrift

