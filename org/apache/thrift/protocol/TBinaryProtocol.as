package org.apache.thrift.protocol
{
    import org.apache.thrift.transport.TTransport;
    import flash.utils.ByteArray;

    public class TBinaryProtocol implements TProtocol 
    {

        private static var ANONYMOUS_STRUCT:TStruct = new TStruct();
        protected static const VERSION_MASK:int = int(0xFFFF0000);
        protected static const VERSION_1:int = int(0x80010000);

        protected var strictRead_:Boolean = false;
        protected var strictWrite_:Boolean = true;
        private var trans_:TTransport;
        private var out:ByteArray = new ByteArray();
        private var stringOut:ByteArray = new ByteArray();
        private var bytes:ByteArray = new ByteArray();

        public function TBinaryProtocol(_arg_1:TTransport, _arg_2:Boolean=false, _arg_3:Boolean=true)
        {
            this.trans_ = _arg_1;
            this.strictRead_ = _arg_2;
            this.strictWrite_ = _arg_3;
        }

        private static function reset(_arg_1:ByteArray):void
        {
            _arg_1.length = 0;
            _arg_1.position = 0;
        }


        public function getTransport():TTransport
        {
            return (this.trans_);
        }

        public function writeMessageBegin(_arg_1:TMessage):void
        {
            var _local_2:int;
            if (this.strictWrite_)
            {
                _local_2 = (VERSION_1 | _arg_1.type);
                this.writeI32(_local_2);
                this.writeString(_arg_1.name);
                this.writeI32(_arg_1.seqid);
            }
            else
            {
                this.writeString(_arg_1.name);
                this.writeByte(_arg_1.type);
                this.writeI32(_arg_1.seqid);
            };
        }

        public function writeMessageEnd():void
        {
        }

        public function writeStructBegin(_arg_1:TStruct):void
        {
        }

        public function writeStructEnd():void
        {
        }

        public function writeFieldBegin(_arg_1:TField):void
        {
            this.writeByte(_arg_1.type);
            this.writeI16(_arg_1.id);
        }

        public function writeFieldEnd():void
        {
        }

        public function writeFieldStop():void
        {
            this.writeByte(TType.STOP);
        }

        public function writeMapBegin(_arg_1:TMap):void
        {
            this.writeByte(_arg_1.keyType);
            this.writeByte(_arg_1.valueType);
            this.writeI32(_arg_1.size);
        }

        public function writeMapEnd():void
        {
        }

        public function writeListBegin(_arg_1:TList):void
        {
            this.writeByte(_arg_1.elemType);
            this.writeI32(_arg_1.size);
        }

        public function writeListEnd():void
        {
        }

        public function writeSetBegin(_arg_1:TSet):void
        {
            this.writeByte(_arg_1.elemType);
            this.writeI32(_arg_1.size);
        }

        public function writeSetEnd():void
        {
        }

        public function writeBool(_arg_1:Boolean):void
        {
            this.writeByte(((_arg_1) ? 1 : 0));
        }

        public function writeByte(_arg_1:int):void
        {
            reset(this.out);
            this.out.writeByte(_arg_1);
            this.trans_.write(this.out, 0, 1);
        }

        public function writeI16(_arg_1:int):void
        {
            reset(this.out);
            this.out.writeShort(_arg_1);
            this.trans_.write(this.out, 0, 2);
        }

        public function writeI32(_arg_1:int):void
        {
            reset(this.out);
            this.out.writeInt(_arg_1);
            this.trans_.write(this.out, 0, 4);
        }

        public function writeDouble(_arg_1:Number):void
        {
            reset(this.out);
            this.out.writeDouble(_arg_1);
            this.trans_.write(this.out, 0, 8);
        }

        public function writeString(_arg_1:String):void
        {
            reset(this.stringOut);
            this.stringOut.writeUTFBytes(_arg_1);
            this.writeI32(this.stringOut.length);
            this.trans_.write(this.stringOut, 0, this.stringOut.length);
        }

        public function writeBinary(_arg_1:ByteArray):void
        {
            this.writeI32(_arg_1.length);
            this.trans_.write(_arg_1, 0, _arg_1.length);
        }

        public function readMessageBegin():TMessage
        {
            var _local_2:int;
            var _local_1:int = this.readI32();
            if (_local_1 < 0)
            {
                _local_2 = (_local_1 & VERSION_MASK);
                if (_local_2 != VERSION_1)
                {
                    throw (new TProtocolError(TProtocolError.BAD_VERSION, "Bad version in readMessageBegin"));
                };
                return (new TMessage(this.readString(), (_local_1 & 0xFF), this.readI32()));
            };
            if (this.strictRead_)
            {
                throw (new TProtocolError(TProtocolError.BAD_VERSION, "Missing version in readMessageBegin, old client?"));
            };
            return (new TMessage(this.readStringBody(_local_1), this.readByte(), this.readI32()));
        }

        public function readMessageEnd():void
        {
        }

        public function readStructBegin():TStruct
        {
            return (ANONYMOUS_STRUCT);
        }

        public function readStructEnd():void
        {
        }

        public function readFieldBegin():TField
        {
            var _local_1:int = this.readByte();
            var _local_2:int = ((_local_1 == TType.STOP) ? 0 : this.readI16());
            return (new TField("", _local_1, _local_2));
        }

        public function readFieldEnd():void
        {
        }

        public function readMapBegin():TMap
        {
            return (new TMap(this.readByte(), this.readByte(), this.readI32()));
        }

        public function readMapEnd():void
        {
        }

        public function readListBegin():TList
        {
            return (new TList(this.readByte(), this.readI32()));
        }

        public function readListEnd():void
        {
        }

        public function readSetBegin():TSet
        {
            return (new TSet(this.readByte(), this.readI32()));
        }

        public function readSetEnd():void
        {
        }

        public function readBool():Boolean
        {
            return (this.readByte() == 1);
        }

        public function readByte():int
        {
            this.readAll(1);
            return (this.bytes.readByte());
        }

        public function readI16():int
        {
            this.readAll(2);
            return (this.bytes.readShort());
        }

        public function readI32():int
        {
            this.readAll(4);
            return (this.bytes.readInt());
        }

        public function readDouble():Number
        {
            this.readAll(8);
            return (this.bytes.readDouble());
        }

        public function readString():String
        {
            var _local_1:int = this.readI32();
            this.readAll(_local_1);
            return (this.bytes.readUTFBytes(_local_1));
        }

        public function readStringBody(_arg_1:int):String
        {
            this.readAll(_arg_1);
            return (this.bytes.readUTFBytes(_arg_1));
        }

        public function readBinary():ByteArray
        {
            var _local_1:int = this.readI32();
            var _local_2:ByteArray = new ByteArray();
            this.trans_.readAll(_local_2, 0, _local_1);
            return (_local_2);
        }

        private function readAll(_arg_1:int):void
        {
            reset(this.bytes);
            this.trans_.readAll(this.bytes, 0, _arg_1);
            this.bytes.position = 0;
        }


    }
}

