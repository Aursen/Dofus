package org.apache.thrift.meta_data
{
    public class StructMetaData extends FieldValueMetaData 
    {

        public var structClass:Class;

        public function StructMetaData(_arg_1:int, _arg_2:Class)
        {
            super(_arg_1);
            this.structClass = _arg_2;
        }

    }
}

