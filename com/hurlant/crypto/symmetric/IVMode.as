package com.hurlant.crypto.symmetric
{
    import com.hurlant.crypto.prng.Random;
    import flash.utils.ByteArray;
    import com.hurlant.util.Memory;

    public class IVMode 
    {

        protected var key:ISymmetricKey;
        protected var padding:IPad;
        protected var prng:Random;
        protected var iv:ByteArray;
        protected var lastIV:ByteArray;
        protected var blockSize:uint;

        public function IVMode(key:ISymmetricKey, padding:IPad=null)
        {
            this.key = key;
            this.blockSize = key.getBlockSize();
            if (padding == null)
            {
                padding = new PKCS5(this.blockSize);
            }
            else
            {
                padding.setBlockSize(this.blockSize);
            };
            this.padding = padding;
            this.prng = new Random();
            this.iv = null;
            this.lastIV = new ByteArray();
        }

        public function getBlockSize():uint
        {
            return (this.key.getBlockSize());
        }

        public function dispose():void
        {
            var i:uint;
            if (this.iv != null)
            {
                i = 0;
                while (i < this.iv.length)
                {
                    this.iv[i] = this.prng.nextByte();
                    i++;
                };
                this.iv.length = 0;
                this.iv = null;
            };
            if (this.lastIV != null)
            {
                i = 0;
                while (i < this.iv.length)
                {
                    this.lastIV[i] = this.prng.nextByte();
                    i++;
                };
                this.lastIV.length = 0;
                this.lastIV = null;
            };
            this.key.dispose();
            this.key = null;
            this.padding = null;
            this.prng.dispose();
            this.prng = null;
            Memory.gc();
        }

        public function set IV(value:ByteArray):void
        {
            this.iv = value;
            this.lastIV.length = 0;
            this.lastIV.writeBytes(this.iv);
        }

        public function get IV():ByteArray
        {
            return (this.lastIV);
        }

        protected function getIV4e():ByteArray
        {
            var vec:ByteArray = new ByteArray();
            if (this.iv)
            {
                vec.writeBytes(this.iv);
            }
            else
            {
                this.prng.nextBytes(vec, this.blockSize);
            };
            this.lastIV.length = 0;
            this.lastIV.writeBytes(vec);
            return (vec);
        }

        protected function getIV4d():ByteArray
        {
            var vec:ByteArray = new ByteArray();
            if (this.iv)
            {
                vec.writeBytes(this.iv);
            }
            else
            {
                throw (new Error("an IV must be set before calling decrypt()"));
            };
            return (vec);
        }


    }
}

