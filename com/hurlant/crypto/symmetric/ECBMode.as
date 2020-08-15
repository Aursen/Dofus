package com.hurlant.crypto.symmetric
{
    import flash.utils.ByteArray;
    import com.hurlant.util.Memory;

    public class ECBMode implements IMode, ICipher 
    {

        private var key:ISymmetricKey;
        private var padding:IPad;

        public function ECBMode(key:ISymmetricKey, padding:IPad=null)
        {
            this.key = key;
            if (padding == null)
            {
                padding = new PKCS5(key.getBlockSize());
            }
            else
            {
                padding.setBlockSize(key.getBlockSize());
            };
            this.padding = padding;
        }

        public function getBlockSize():uint
        {
            return (this.key.getBlockSize());
        }

        public function encrypt(src:ByteArray):void
        {
            this.padding.pad(src);
            src.position = 0;
            var blockSize:uint = this.key.getBlockSize();
            var tmp:ByteArray = new ByteArray();
            var dst:ByteArray = new ByteArray();
            var i:uint;
            while (i < src.length)
            {
                tmp.length = 0;
                src.readBytes(tmp, 0, blockSize);
                this.key.encrypt(tmp);
                dst.writeBytes(tmp);
                i = (i + blockSize);
            };
            src.length = 0;
            src.writeBytes(dst);
        }

        public function decrypt(src:ByteArray):void
        {
            src.position = 0;
            var blockSize:uint = this.key.getBlockSize();
            if ((src.length % blockSize) != 0)
            {
                throw (new Error(("ECB mode cipher length must be a multiple of blocksize " + blockSize)));
            };
            var tmp:ByteArray = new ByteArray();
            var dst:ByteArray = new ByteArray();
            var i:uint;
            while (i < src.length)
            {
                tmp.length = 0;
                src.readBytes(tmp, 0, blockSize);
                this.key.decrypt(tmp);
                dst.writeBytes(tmp);
                i = (i + blockSize);
            };
            this.padding.unpad(dst);
            src.length = 0;
            src.writeBytes(dst);
        }

        public function dispose():void
        {
            this.key.dispose();
            this.key = null;
            this.padding = null;
            Memory.gc();
        }

        public function toString():String
        {
            return (this.key.toString() + "-ecb");
        }


    }
}

