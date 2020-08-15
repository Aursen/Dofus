package org.apache.thrift.protocol
{
    import org.apache.thrift.TError;

    public class TProtocolUtil 
    {

        private static var maxSkipDepth:int = int.MAX_VALUE;//2147483647


        public static function skip(_arg_1:TProtocol, _arg_2:int):void
        {
            skipMaxDepth(_arg_1, _arg_2, maxSkipDepth);
        }

        public static function skipMaxDepth(_arg_1:TProtocol, _arg_2:int, _arg_3:int):void
        {
            var _local_4:TField;
            var _local_5:TMap;
            var _local_6:int;
            var _local_7:TSet;
            var _local_8:int;
            var _local_9:TList;
            var _local_10:int;
            if (_arg_3 <= 0)
            {
                throw (new TError("Maximum skip depth exceeded"));
            };
            switch (_arg_2)
            {
                case TType.BOOL:
                    _arg_1.readBool();
                    return;
                case TType.BYTE:
                    _arg_1.readByte();
                    return;
                case TType.I16:
                    _arg_1.readI16();
                    return;
                case TType.I32:
                    _arg_1.readI32();
                    return;
                case TType.DOUBLE:
                    _arg_1.readDouble();
                    return;
                case TType.STRING:
                    _arg_1.readBinary();
                    return;
                case TType.STRUCT:
                    _arg_1.readStructBegin();
                    while (true)
                    {
                        _local_4 = _arg_1.readFieldBegin();
                        if (_local_4.type == TType.STOP) break;
                        skipMaxDepth(_arg_1, _local_4.type, (_arg_3 - 1));
                        _arg_1.readFieldEnd();
                    };
                    _arg_1.readStructEnd();
                    return;
                case TType.MAP:
                    _local_5 = _arg_1.readMapBegin();
                    _local_6 = 0;
                    while (_local_6 < _local_5.size)
                    {
                        skipMaxDepth(_arg_1, _local_5.keyType, (_arg_3 - 1));
                        skipMaxDepth(_arg_1, _local_5.valueType, (_arg_3 - 1));
                        _local_6++;
                    };
                    _arg_1.readMapEnd();
                    return;
                case TType.SET:
                    _local_7 = _arg_1.readSetBegin();
                    _local_8 = 0;
                    while (_local_8 < _local_7.size)
                    {
                        skipMaxDepth(_arg_1, _local_7.elemType, (_arg_3 - 1));
                        _local_8++;
                    };
                    _arg_1.readSetEnd();
                    return;
                case TType.LIST:
                    _local_9 = _arg_1.readListBegin();
                    _local_10 = 0;
                    while (_local_10 < _local_9.size)
                    {
                        skipMaxDepth(_arg_1, _local_9.elemType, (_arg_3 - 1));
                        _local_10++;
                    };
                    _arg_1.readListEnd();
                    return;
            };
        }


        public function setMaxSkipDepth(_arg_1:int):void
        {
            maxSkipDepth = _arg_1;
        }


    }
}

