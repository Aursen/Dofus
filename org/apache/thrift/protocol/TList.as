package org.apache.thrift.protocol
{
    public class TList 
    {

        public var elemType:int;
        public var size:int;

        public function TList(_arg_1:int=0, _arg_2:int=0)
        {
            this.elemType = _arg_1;
            this.size = _arg_2;
        }

    }
}

