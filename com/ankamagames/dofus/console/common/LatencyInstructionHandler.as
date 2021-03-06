package com.ankamagames.dofus.console.common
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.dofus.logic.common.frames.LatencyFrame;
    import com.ankamagames.dofus.network.messages.common.basic.BasicPingMessage;
    import com.ankamagames.jerakine.network.IServerConnection;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import flash.utils.getTimer;
    import com.ankamagames.jerakine.console.ConsoleHandler;
    import com.ankamagames.jerakine.data.I18n;

    public class LatencyInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var latencyFrame:LatencyFrame;
            var ping:BasicPingMessage;
            var connection:IServerConnection;
            switch (cmd)
            {
                case "ping":
                    latencyFrame = (Kernel.getWorker().getFrame(LatencyFrame) as LatencyFrame);
                    if (latencyFrame.pingRequested != 0)
                    {
                        break;
                    };
                    ping = new BasicPingMessage().initBasicPingMessage();
                    ConnectionsHandler.getConnection().send(ping);
                    latencyFrame.pingRequested = getTimer();
                    console.output("Ping...");
                    break;
                case "aping":
                    connection = ConnectionsHandler.getConnection().mainConnection;
                    console.output((((((("Avg ping : " + connection.latencyAvg) + "ms for the last ") + connection.latencySamplesCount) + " packets (max : ") + connection.latencySamplesMax) + ")"));
                    break;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "ping":
                    return (I18n.getUiText("ui.chat.console.help.ping"));
                case "aping":
                    return (I18n.getUiText("ui.chat.console.help.aping"));
            };
            return (I18n.getUiText("ui.chat.console.noHelp", [cmd]));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}

