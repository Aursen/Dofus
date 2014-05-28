package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.jerakine.network.ServerConnection;
   
   public class ConnectionInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function ConnectionInstructionHandler() {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         switch(cmd)
         {
            case "connectionstatus":
               console.output("" + (ConnectionsHandler.getConnection()?ConnectionsHandler.getConnection():"There is currently no connection."));
               break;
            case "inspecttraffic":
               ServerConnection.DEBUG_VERBOSE = !ServerConnection.DEBUG_VERBOSE;
               console.output("Inspect traffic is " + (ServerConnection.DEBUG_VERBOSE?"ON":"OFF"));
               break;
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "connectionstatus":
               return "Print the status of the current connection (if any).";
            case "inspecttraffic":
               return "Show detailled informations about network activities.";
            default:
               return "No help for command \'" + cmd + "\'";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array {
         return [];
      }
   }
}
