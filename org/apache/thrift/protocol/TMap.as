package org.apache.thrift.protocol
{
    public class TMap 
    {

        public var keyType:int;
        public var valueType:int;
        public var size:int;

        public function TMap(_arg_1:int=0, _arg_2:int=0, _arg_3:int=0)
        {
            this.keyType = _arg_1;
            this.valueType = _arg_2;
            this.size = _arg_3;
        }

    }
}

