package org.apache.thrift.protocol
{
    import org.apache.thrift.transport.TTransport;
    import flash.utils.ByteArray;

    public interface TProtocol 
    {

        function getTransport():TTransport;
        function writeMessageBegin(_arg_1:TMessage):void;
        function writeMessageEnd():void;
        function writeStructBegin(_arg_1:TStruct):void;
        function writeStructEnd():void;
        function writeFieldBegin(_arg_1:TField):void;
        function writeFieldEnd():void;
        function writeFieldStop():void;
        function writeMapBegin(_arg_1:TMap):void;
        function writeMapEnd():void;
        function writeListBegin(_arg_1:TList):void;
        function writeListEnd():void;
        function writeSetBegin(_arg_1:TSet):void;
        function writeSetEnd():void;
        function writeBool(_arg_1:Boolean):void;
        function writeByte(_arg_1:int):void;
        function writeI16(_arg_1:int):void;
        function writeI32(_arg_1:int):void;
        function writeDouble(_arg_1:Number):void;
        function writeString(_arg_1:String):void;
        function writeBinary(_arg_1:ByteArray):void;
        function readMessageBegin():TMessage;
        function readMessageEnd():void;
        function readStructBegin():TStruct;
        function readStructEnd():void;
        function readFieldBegin():TField;
        function readFieldEnd():void;
        function readMapBegin():TMap;
        function readMapEnd():void;
        function readListBegin():TList;
        function readListEnd():void;
        function readSetBegin():TSet;
        function readSetEnd():void;
        function readBool():Boolean;
        function readByte():int;
        function readI16():int;
        function readI32():int;
        function readDouble():Number;
        function readString():String;
        function readBinary():ByteArray;

    }
}

