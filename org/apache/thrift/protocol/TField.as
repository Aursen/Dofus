package org.apache.thrift.protocol
{
    public class TField 
    {

        public var name:String;
        public var type:int;
        public var id:int;

        public function TField(_arg_1:String="", _arg_2:int=0, _arg_3:int=0)
        {
            this.name = _arg_1;
            this.type = _arg_2;
            this.id = _arg_3;
        }

        public function toString():String
        {
            return (((((("<TField name:'" + this.name) + "' type:") + this.type) + " field-id:") + this.id) + ">");
        }

        public function equals(_arg_1:TField):Boolean
        {
            return ((this.type == _arg_1.type) && (this.id == _arg_1.id));
        }


    }
}

