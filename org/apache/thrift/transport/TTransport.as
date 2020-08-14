package org.apache.thrift.transport
{
    import org.apache.thrift.AbstractMethodError;
    import flash.utils.ByteArray;

    public class TTransport 
    {


        public function isOpen():Boolean
        {
            throw (new AbstractMethodError());
        }

        public function peek():Boolean
        {
            return (this.isOpen());
        }

        public function open():void
        {
            throw (new AbstractMethodError());
        }

        public function close():void
        {
            throw (new AbstractMethodError());
        }

        public function read(_arg_1:ByteArray, _arg_2:int, _arg_3:int):int
        {
            throw (new AbstractMethodError());
        }

        public function readAll(_arg_1:ByteArray, _arg_2:int, _arg_3:int):int
        {
            var _local_4:int;
            var _local_5:int;
            while (_local_4 < _arg_3)
            {
                _local_5 = this.read(_arg_1, (_arg_2 + _local_4), (_arg_3 - _local_4));
                if (_local_5 <= 0)
                {
                    throw (new TTransportError(TTransportError.UNKNOWN, (((("Cannot read. Remote side has closed. Tried to read " + _arg_3) + " bytes, but only got ") + _local_4) + " bytes.")));
                };
                _local_4 = (_local_4 + _local_5);
            };
            return (_local_4);
        }

        public function writeAll(_arg_1:ByteArray):void
        {
            this.write(_arg_1, 0, _arg_1.length);
        }

        public function write(_arg_1:ByteArray, _arg_2:int, _arg_3:int):void
        {
            throw (new AbstractMethodError());
        }

        public function flush(_arg_1:Function=null):void
        {
            throw (new AbstractMethodError());
        }


    }
} org.apache.thrift.transport

