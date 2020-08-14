package mx.rpc.xml
{
    import mx.rpc.xml.SimpleXMLDecoder;

    [ExcludeClass]
    internal dynamic class ComplexString 
    {

        public var value:String;

        public function ComplexString(val:String)
        {
            this.value = val;
        }

        public function toString():String
        {
            return (this.value);
        }

        public function valueOf():Object
        {
            return (SimpleXMLDecoder.simpleType(this.value));
        }


    }
} mx.rpc.xml

