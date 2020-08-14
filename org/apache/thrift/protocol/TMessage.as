package org.apache.thrift.protocol
{
    public class TMessage 
    {

        public var name:String;
        public var type:int;
        public var seqid:int;

        public function TMessage(_arg_1:String="", _arg_2:int=0, _arg_3:int=0)
        {
            this.name = _arg_1;
            this.type = _arg_2;
            this.seqid = _arg_3;
        }

        public function toString():String
        {
            return (((((("<TMessage name:'" + this.name) + "' type: ") + this.type) + " seqid:") + this.seqid) + ">");
        }

        public function equals(_arg_1:TMessage):Boolean
        {
            return (((this.name == _arg_1.name) && (this.type == _arg_1.type)) && (this.seqid == _arg_1.seqid));
        }


    }
} org.apache.thrift.protocol

