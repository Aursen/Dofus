package com.hurlant.util.der
{
    public dynamic class Set extends Sequence implements IAsn1Type 
    {

        public function Set(_arg_1:uint=49, length:uint=0)
        {
            super(_arg_1, length);
        }

        override public function toString():String
        {
            var s:String;
            s = DER.indent;
            DER.indent = (DER.indent + "    ");
            var t:String = join("\n");
            DER.indent = s;
            return (((((((((DER.indent + "Set[") + type) + "][") + len) + "][\n") + t) + "\n") + s) + "]");
        }


    }
} com.hurlant.util.der

