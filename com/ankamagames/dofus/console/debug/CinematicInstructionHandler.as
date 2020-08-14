package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class CinematicInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var cinematicId:int;
            switch (cmd)
            {
                case "cinematic":
                    if (args.length == 1)
                    {
                        cinematicId = args[0];
                        KernelEventsManager.getInstance().processCallback(HookList.Cinematic, cinematicId, false);
                    };
                    break;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "cinematic":
                    return ("Play cinematic for given id");
            };
            return ("Unknown command");
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
} com.ankamagames.dofus.console.debug

