package com.hurlant.util.der
{
    import flash.utils.ByteArray;
    import com.hurlant.util.Hex;

    public class ByteString extends ByteArray implements IAsn1Type 
    {

        private var type:uint;
        private var len:uint;

        public function ByteString(_arg_1:uint=4, length:uint=0)
        {
            this.type = _arg_1;
            this.len = length;
        }

        public function getLength():uint
        {
            return (this.len);
        }

        public function getType():uint
        {
            return (this.type);
        }

        public function toDER():ByteArray
        {
            return (DER.wrapDER(this.type, this));
        }

        override public function toString():String
        {
            return (((((((DER.indent + "ByteString[") + this.type) + "][") + this.len) + "][") + Hex.fromArray(this)) + "]");
        }


    }
} com.hurlant.util.der

