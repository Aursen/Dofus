package org.apache.thrift
{
    import org.apache.thrift.protocol.TStruct;
    import org.apache.thrift.protocol.TField;
    import org.apache.thrift.protocol.TType;
    import org.apache.thrift.protocol.TProtocolUtil;
    import org.apache.thrift.protocol.TProtocol;

    public class TApplicationError extends TError 
    {

        private static const TAPPLICATION_EXCEPTION_STRUCT:TStruct = new TStruct("TApplicationException");
        private static const MESSAGE_FIELD:TField = new TField("message", TType.STRING, 1);
        private static const TYPE_FIELD:TField = new TField("type", TType.I32, 2);
        public static const UNKNOWN:int = 0;
        public static const UNKNOWN_METHOD:int = 1;
        public static const INVALID_MESSAGE_TYPE:int = 2;
        public static const WRONG_METHOD_NAME:int = 3;
        public static const BAD_SEQUENCE_ID:int = 4;
        public static const MISSING_RESULT:int = 5;
        public static const INTERNAL_ERROR:int = 6;
        public static const PROTOCOL_ERROR:int = 7;
        public static const INVALID_TRANSFORM:int = 8;
        public static const INVALID_PROTOCOL:int = 9;
        public static const UNSUPPORTED_CLIENT_TYPE:int = 10;

        public function TApplicationError(_arg_1:int=0, _arg_2:String="")
        {
            super(_arg_2, _arg_1);
        }

        public static function read(_arg_1:TProtocol):TApplicationError
        {
            var _local_2:TField;
            _arg_1.readStructBegin();
            var _local_3:String;
            var _local_4:int = UNKNOWN;
            while (true)
            {
                _local_2 = _arg_1.readFieldBegin();
                if (_local_2.type == TType.STOP) break;
                switch (_local_2.id)
                {
                    case 1:
                        if (_local_2.type == TType.STRING)
                        {
                            _local_3 = _arg_1.readString();
                        }
                        else
                        {
                            TProtocolUtil.skip(_arg_1, _local_2.type);
                        };
                        break;
                    case 2:
                        if (_local_2.type == TType.I32)
                        {
                            _local_4 = _arg_1.readI32();
                        }
                        else
                        {
                            TProtocolUtil.skip(_arg_1, _local_2.type);
                        };
                        break;
                    default:
                        TProtocolUtil.skip(_arg_1, _local_2.type);
                };
                _arg_1.readFieldEnd();
            };
            _arg_1.readStructEnd();
            return (new TApplicationError(_local_4, _local_3));
        }


        public function write(_arg_1:TProtocol):void
        {
            _arg_1.writeStructBegin(TAPPLICATION_EXCEPTION_STRUCT);
            if (message != null)
            {
                _arg_1.writeFieldBegin(MESSAGE_FIELD);
                _arg_1.writeString(message);
                _arg_1.writeFieldEnd();
            };
            _arg_1.writeFieldBegin(TYPE_FIELD);
            _arg_1.writeI32(errorID);
            _arg_1.writeFieldEnd();
            _arg_1.writeFieldStop();
            _arg_1.writeStructEnd();
        }


    }
}

