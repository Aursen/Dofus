package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.misc.utils.DofusApiAction;
    import com.ankamagames.berilia.types.data.Hook;
    import com.ankamagames.jerakine.handlers.messages.Action;
    import com.ankamagames.jerakine.utils.misc.CallWithParameters;
    import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.berilia.utils.errors.ApiError;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.jerakine.console.ConsoleHandler;

    public class ActionsInstructionHandler implements ConsoleInstructionHandler 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ActionsInstructionHandler));


        private static function getParams(data:Array):Array
        {
            var params:Array = [];
            var i:uint;
            while (i < data.length)
            {
                params[i] = getParam(data[i]);
                i++;
            };
            return (params);
        }

        private static function getParam(value:String):*
        {
            var intParam:Number = parseInt(value);
            if (!isNaN(intParam))
            {
                return (intParam);
            };
            if (((value == "true") || (value == "false")))
            {
                return (value == "true");
            };
            return (value);
        }


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var actionName:String;
            var apiAction:DofusApiAction;
            var params:Array;
            var accessors:Array;
            var longestAccessor:uint;
            var hookName:String;
            var hparams:Array;
            var targetedHook:Hook;
            var lookFor:String;
            var actionsList:Array;
            var foundCount:uint;
            var action:Action;
            var acc:String;
            var prop:String;
            var padding:String;
            var i:uint;
            var a:String;
            switch (cmd)
            {
                case "sendaction":
                    if (args.length == 0)
                    {
                        console.output("You must specify an action to send.");
                        return;
                    };
                    actionName = args[0];
                    apiAction = DofusApiAction.getApiActionByName(actionName);
                    if (!apiAction)
                    {
                        console.output((("The action '<i>" + actionName) + "</i>' does not exists."));
                        return;
                    };
                    args.shift();
                    params = getParams(args);
                    try
                    {
                        action = CallWithParameters.callR(apiAction.actionClass["create"], params);
                        if (!action)
                        {
                            throw (new Error());
                        };
                    }
                    catch(e:Error)
                    {
                        console.output("Unable to instanciate the action. Maybe some parameters were invalid ?");
                        return;
                    };
                    accessors = [];
                    longestAccessor = 0;
                    for each (acc in DescribeTypeCache.getAccessors(apiAction.actionClass))
                    {
                        if (acc == "prototype")
                        {
                        }
                        else
                        {
                            if (acc.length > longestAccessor)
                            {
                                longestAccessor = acc.length;
                            };
                            accessors.push(acc);
                        };
                    };
                    accessors.sort();
                    console.output((("Sending action <b>" + apiAction.name) + "</b>:"));
                    for each (prop in accessors)
                    {
                        padding = "";
                        i = prop.length;
                        while (i < longestAccessor)
                        {
                            padding = (padding + " ");
                            i++;
                        };
                        console.output((((("    <b>" + padding) + prop) + "</b> : ") + action[prop]));
                    };
                    Kernel.getWorker().process(action);
                    break;
                case "sendhook":
                    if (args.length == 0)
                    {
                        console.output("You must specify an hook to send.");
                        return;
                    };
                    hookName = args[0];
                    hparams = args.slice(1);
                    targetedHook = Hook.getHookByName(hookName);
                    if (!targetedHook)
                    {
                        throw (new ApiError((("Hook [" + hookName) + "] does not exist")));
                    };
                    CallWithParameters.call(KernelEventsManager.getInstance().processCallback, new Array(targetedHook).concat(hparams));
                    break;
                case "listactions":
                    lookFor = "";
                    if (args.length > 0)
                    {
                        lookFor = args.join(" ").toLowerCase();
                        console.output((("Registered actions matching '" + lookFor) + "':"));
                    }
                    else
                    {
                        console.output("Registered actions:");
                    };
                    actionsList = DofusApiAction.getApiActionsList();
                    foundCount = 0;
                    for (a in actionsList)
                    {
                        if (((lookFor.length > 0) && (a.toLowerCase().indexOf(lookFor) == -1)))
                        {
                        }
                        else
                        {
                            console.output((("    <b>" + a) + "</b>"));
                            foundCount++;
                        };
                    };
                    if (foundCount == 0)
                    {
                        console.output("   No match.");
                    };
                    break;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "sendaction":
                    return ("Send an actions to the worker.");
                case "sendhook":
                    return ("Send a hook to the worker.");
                case "listactions":
                    return ("List all valid actions.");
            };
            return (("Unknown command '" + cmd) + "'.");
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            var actionsList:Array;
            var a:String;
            var possibilities:Array = [];
            switch (cmd)
            {
                case "sendaction":
                    if (paramIndex == 0)
                    {
                        actionsList = DofusApiAction.getApiActionsList();
                        for (a in actionsList)
                        {
                            possibilities.push(a);
                        };
                    };
                    break;
            };
            return (possibilities);
        }


    }
} com.ankamagames.dofus.console.debug

