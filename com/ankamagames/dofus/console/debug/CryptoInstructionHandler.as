package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.utils.crypto.CRC32;
    import flash.utils.ByteArray;
    import by.blooddy.crypto.MD5;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class CryptoInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var crc32:CRC32;
            var buffer:ByteArray;
            switch (cmd)
            {
                case "crc32":
                    crc32 = new CRC32();
                    buffer = new ByteArray();
                    buffer.writeUTFBytes(args.join(" "));
                    crc32.update(buffer);
                    console.output(("CRC32 checksum : " + crc32.getValue().toString(16)));
                    break;
                case "md5":
                    console.output(("MD5 hash : " + MD5.hash(args.join(" "))));
                    break;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "crc32":
                    return ("Calculate the CRC32 checksum of a given string.");
                case "md5":
                    return ("Calculate the MD5 hash of a given string.");
            };
            return (("No help for command '" + cmd) + "'");
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}

