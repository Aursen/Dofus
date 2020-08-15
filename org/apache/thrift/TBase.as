package org.apache.thrift
{
    import org.apache.thrift.protocol.TProtocol;

    public interface TBase 
    {

        function read(_arg_1:TProtocol):void;
        function write(_arg_1:TProtocol):void;
        function isSet(_arg_1:int):Boolean;
        function getFieldValue(_arg_1:int):*;
        function setFieldValue(_arg_1:int, _arg_2:*):void;

    }
}

