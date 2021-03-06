package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.dofus.kernel.Kernel;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class FrameInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var fl:Array;
            var priority:int;
            var f:Frame;
            var className:String;
            var split:Array;
            switch (cmd)
            {
                case "framelist":
                    fl = [];
                    for each (f in Kernel.getWorker().framesList)
                    {
                        className = getQualifiedClassName(f);
                        split = className.split("::");
                        fl.push([split[(split.length - 1)], Priority.toString(f.priority)]);
                    };
                    console.output(StringUtils.formatArray(fl, ["Class", "Priority"]));
                    break;
                case "framepriority":
                    if (args.length != 2)
                    {
                        console.output("You must specify a frame and a priority to set.");
                        return;
                    };
                    priority = Priority.fromString(args[1]);
                    if (priority == 666)
                    {
                        console.output((args[1] + " : invalid priority (available priority are LOG, ULTIMATE_HIGHEST_DEPTH_OF_DOOM, HIGHEST, HIGH, NORMAL, LOW and LOWEST"));
                        return;
                    };
                    for each (f in Kernel.getWorker().framesList)
                    {
                        className = getQualifiedClassName(f);
                        split = className.split("::");
                        if (split[(split.length - 1)] == args[0])
                        {
                            try
                            {
                                f["priority"] = priority;
                            }
                            catch(e:Error)
                            {
                                console.output(("Priority set not available for frame " + args[0]));
                            };
                            return;
                        };
                    };
                    console.output((args[0] + " : frame not found"));
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "framelist":
                    return ("list all enabled frame");
                case "framepriority":
                    return ("overwrite a frame priority");
            };
            return (("Unknown command '" + cmd) + "'.");
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}

