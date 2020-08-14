package com.ankama.zaap
{
    import org.apache.thrift.TBase;
    import org.apache.thrift.protocol.TStruct;
    import org.apache.thrift.protocol.TField;
    import org.apache.thrift.protocol.TType;
    import flash.utils.Dictionary;
    import org.apache.thrift.meta_data.FieldMetaData;
    import org.apache.thrift.TFieldRequirementType;
    import org.apache.thrift.meta_data.FieldValueMetaData;
    import org.apache.thrift.protocol.TProtocolUtil;
    import org.apache.thrift.protocol.TProtocolError;
    import org.apache.thrift.protocol.TProtocol;
    import org.apache.thrift.protocol.*;
    import org.apache.thrift.meta_data.*;
    import org.apache.thrift.*;

    public class ZaapError extends Error implements TBase 
    {

        private static const STRUCT_DESC:TStruct = new TStruct("ZaapError");
        private static const CODE_FIELD_DESC:TField = new TField("code", TType.I32, 1);
        private static const DETAILS_FIELD_DESC:TField = new TField("details", TType.STRING, 2);
        public static const CODE:int = 1;
        public static const DETAILS:int = 2;
        public static const metaDataMap:Dictionary = new Dictionary();

        private var _code:int;
        private var _details:String;
        private var __isset_code:Boolean = false;

        {
            metaDataMap[CODE] = new FieldMetaData("code", TFieldRequirementType.REQUIRED, new FieldValueMetaData(TType.I32));
            metaDataMap[DETAILS] = new FieldMetaData("details", TFieldRequirementType.OPTIONAL, new FieldValueMetaData(TType.STRING));
            FieldMetaData.addStructMetaDataMap(ZaapError, metaDataMap);
        }


        public function get code():int
        {
            return (this._code);
        }

        public function set code(_arg_1:int):void
        {
            this._code = _arg_1;
            this.__isset_code = true;
        }

        public function unsetCode():void
        {
            this.__isset_code = false;
        }

        public function isSetCode():Boolean
        {
            return (this.__isset_code);
        }

        public function get details():String
        {
            return (this._details);
        }

        public function set details(_arg_1:String):void
        {
            this._details = _arg_1;
        }

        public function unsetDetails():void
        {
            this.details = null;
        }

        public function isSetDetails():Boolean
        {
            return (!(this.details == null));
        }

        public function setFieldValue(_arg_1:int, _arg_2:*):void
        {
            switch (_arg_1)
            {
                case CODE:
                    if (_arg_2 == null)
                    {
                        this.unsetCode();
                    }
                    else
                    {
                        this.code = _arg_2;
                    };
                    return;
                case DETAILS:
                    if (_arg_2 == null)
                    {
                        this.unsetDetails();
                    }
                    else
                    {
                        this.details = _arg_2;
                    };
                    return;
                default:
                    throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
            };
        }

        public function getFieldValue(_arg_1:int):*
        {
            switch (_arg_1)
            {
                case CODE:
                    return (this.code);
                case DETAILS:
                    return (this.details);
                default:
                    throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
            };
        }

        public function isSet(_arg_1:int):Boolean
        {
            switch (_arg_1)
            {
                case CODE:
                    return (this.isSetCode());
                case DETAILS:
                    return (this.isSetDetails());
                default:
                    throw (new ArgumentError((("Field " + _arg_1) + " doesn't exist!")));
            };
        }

        public function read(_arg_1:TProtocol):void
        {
            var _local_2:TField;
            _arg_1.readStructBegin();
            while (true)
            {
                _local_2 = _arg_1.readFieldBegin();
                if (_local_2.type == TType.STOP) break;
                switch (_local_2.id)
                {
                    case CODE:
                        if (_local_2.type == TType.I32)
                        {
                            this.code = _arg_1.readI32();
                            this.__isset_code = true;
                        }
                        else
                        {
                            TProtocolUtil.skip(_arg_1, _local_2.type);
                        };
                        break;
                    case DETAILS:
                        if (_local_2.type == TType.STRING)
                        {
                            this.details = _arg_1.readString();
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
            if (!this.__isset_code)
            {
                throw (new TProtocolError(TProtocolError.UNKNOWN, ("Required field 'code' was not found in serialized data! Struct: " + this.toString())));
            };
            this.validate();
        }

        public function write(_arg_1:TProtocol):void
        {
            this.validate();
            _arg_1.writeStructBegin(STRUCT_DESC);
            _arg_1.writeFieldBegin(CODE_FIELD_DESC);
            _arg_1.writeI32(this.code);
            _arg_1.writeFieldEnd();
            if (this.isSetDetails())
            {
                if (this.details != null)
                {
                    _arg_1.writeFieldBegin(DETAILS_FIELD_DESC);
                    _arg_1.writeString(this.details);
                    _arg_1.writeFieldEnd();
                };
            };
            _arg_1.writeFieldStop();
            _arg_1.writeStructEnd();
        }

        public function toString():String
        {
            var _local_1:String = new String("ZaapError(");
            var _local_2:Boolean = true;
            _local_1 = (_local_1 + "code:");
            var _local_3:String = ErrorCode.VALUES_TO_NAMES[this.code];
            if (_local_3 != null)
            {
                _local_1 = (_local_1 + _local_3);
                _local_1 = (_local_1 + " (");
            };
            _local_1 = (_local_1 + this.code);
            if (_local_3 != null)
            {
                _local_1 = (_local_1 + ")");
            };
            _local_2 = false;
            if (this.isSetDetails())
            {
                if (!_local_2)
                {
                    _local_1 = (_local_1 + ", ");
                };
                _local_1 = (_local_1 + "details:");
                if (this.details == null)
                {
                    _local_1 = (_local_1 + "null");
                }
                else
                {
                    _local_1 = (_local_1 + this.details);
                };
                _local_2 = false;
            };
            return (_local_1 + ")");
        }

        public function validate():void
        {
            if (((this.isSetCode()) && (!(ErrorCode.VALID_VALUES.contains(this.code)))))
            {
                throw (new TProtocolError(TProtocolError.UNKNOWN, ("The field 'code' has been assigned the invalid value " + this.code)));
            };
        }


    }
} com.ankama.zaap

