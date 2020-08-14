package com.hurlant.util.der
{
    import flash.net.registerClassAlias;
    import flash.utils.ByteArray;

    public class ObjectIdentifier implements IAsn1Type 
    {

        private var type:uint;
        private var len:uint;
        private var oid:Array;

        {
            registerClassAlias("com.hurlant.util.der.ObjectIdentifier", ObjectIdentifier);
        }

        public function ObjectIdentifier(_arg_1:uint=0, length:uint=0, b:*=null)
        {
            this.type = _arg_1;
            this.len = length;
            if ((b is ByteArray))
            {
                this.parse((b as ByteArray));
            }
            else
            {
                if ((b is String))
                {
                    this.generate((b as String));
                }
                else
                {
                    throw (new Error("Invalid call to new ObjectIdentifier"));
                };
            };
        }

        private function generate(s:String):void
        {
            this.oid = s.split(".");
        }

        private function parse(b:ByteArray):void
        {
            var last:Boolean;
            var o:uint = b.readUnsignedByte();
            var a:Array = [];
            a.push(uint((o / 40)));
            a.push(uint((o % 40)));
            var v:uint;
            while (b.bytesAvailable > 0)
            {
                o = b.readUnsignedByte();
                last = ((o & 0x80) == 0);
                o = (o & 0x7F);
                v = ((v * 128) + o);
                if (last)
                {
                    a.push(v);
                    v = 0;
                };
            };
            this.oid = a;
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
            var v:int;
            var tmp:Array = [];
            tmp[0] = ((this.oid[0] * 40) + this.oid[1]);
            var i:int = 2;
            while (i < this.oid.length)
            {
                v = parseInt(this.oid[i]);
                if (v < 128)
                {
                    tmp.push(v);
                }
                else
                {
                    if (v < (128 * 128))
                    {
                        tmp.push(((v >> 7) | 0x80));
                        tmp.push((v & 0x7F));
                    }
                    else
                    {
                        if (v < ((128 * 128) * 128))
                        {
                            tmp.push(((v >> 14) | 0x80));
                            tmp.push((((v >> 7) & 0x7F) | 0x80));
                            tmp.push((v & 0x7F));
                        }
                        else
                        {
                            if (v < (((128 * 128) * 128) * 128))
                            {
                                tmp.push(((v >> 21) | 0x80));
                                tmp.push((((v >> 14) & 0x7F) | 0x80));
                                tmp.push((((v >> 7) & 0x7F) | 0x80));
                                tmp.push((v & 0x7F));
                            }
                            else
                            {
                                throw (new Error("OID element bigger than we thought. :("));
                            };
                        };
                    };
                };
                i++;
            };
            this.len = tmp.length;
            if (this.type == 0)
            {
                this.type = 6;
            };
            tmp.unshift(this.len);
            tmp.unshift(this.type);
            var b:ByteArray = new ByteArray();
            i = 0;
            while (i < tmp.length)
            {
                b[i] = tmp[i];
                i++;
            };
            return (b);
        }

        public function toString():String
        {
            return (DER.indent + this.oid.join("."));
        }

        public function dump():String
        {
            return (((((("OID[" + this.type) + "][") + this.len) + "][") + this.toString()) + "]");
        }


    }
} com.hurlant.util.der

