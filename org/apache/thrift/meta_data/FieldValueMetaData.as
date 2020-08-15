package org.apache.thrift.meta_data
{
    import org.apache.thrift.protocol.TType;

    public class FieldValueMetaData 
    {

        public var type:int;

        public function FieldValueMetaData(_arg_1:int)
        {
            this.type = _arg_1;
        }

        public function isStruct():Boolean
        {
            return (this.type == TType.STRUCT);
        }

        public function isContainer():Boolean
        {
            return (((this.type == TType.LIST) || (this.type == TType.MAP)) || (this.type == TType.SET));
        }


    }
}

