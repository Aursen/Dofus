package 
{
    public class MemoryRange 
    {

        public var offset:int;
        public var end:int;

        public function MemoryRange(_arg_1:int, _arg_2:int):void
        {
            offset = _arg_1;
            end = _arg_2;
        }

        public function len():int
        {
            return (end - offset);
        }


    }
} 

