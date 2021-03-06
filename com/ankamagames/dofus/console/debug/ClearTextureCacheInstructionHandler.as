package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class ClearTextureCacheInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            switch (cmd)
            {
                case "cleartexturecache":
                    if (args.length > 0)
                    {
                        console.output("No arguments needed.");
                    };
                    console.output("Texture cache cleared.");
                    break;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "cleartexturecache":
                    return ("Empty the textures cache.");
            };
            return (("No help for command '" + cmd) + "'");
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}

