package com.ankamagames.jerakine.pathfinding
{
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class FastIntArray 
    {

        public var data:Vector.<int>;
        public var length:int = 0;

        public function FastIntArray(size:int=0)
        {
            this.data = new Vector.<int>(size);
        }

        public function at(i:uint):int
        {
            return (this.data[i]);
        }

        public function push(val:int):void
        {
            if (this.length == this.data.length)
            {
                this.data.push(val);
            }
            else
            {
                this.data[this.length] = val;
            };
            this.length++;
        }

        public function removeAt(index:int):int
        {
            var previous:int = this.data[index];
            this.data[index] = this.data[(this.length - 1)];
            this.length--;
            return (previous);
        }

        public function indexOf(val:int):int
        {
            var i:int;
            while (i < this.length)
            {
                if (this.data[i] == val)
                {
                    return (i);
                };
                i++;
            };
            return (-1);
        }

        public function clear():void
        {
            this.length = 0;
        }


    }
}

