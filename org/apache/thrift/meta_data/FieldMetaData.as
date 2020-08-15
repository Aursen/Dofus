package org.apache.thrift.meta_data
{
    import flash.utils.Dictionary;

    public class FieldMetaData 
    {

        private static var structMap:Dictionary = new Dictionary();

        public var fieldName:String;
        public var requirementType:int;
        public var valueMetaData:FieldValueMetaData;

        public function FieldMetaData(_arg_1:String, _arg_2:int, _arg_3:FieldValueMetaData)
        {
            this.fieldName = _arg_1;
            this.requirementType = _arg_2;
            this.valueMetaData = _arg_3;
        }

        public static function addStructMetaDataMap(_arg_1:Class, _arg_2:Dictionary):void
        {
            structMap[_arg_1] = _arg_2;
        }

        public static function getStructMetaDataMap(_arg_1:Class):Dictionary
        {
            return (structMap[_arg_1]);
        }


    }
}

