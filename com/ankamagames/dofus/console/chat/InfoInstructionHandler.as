package com.ankamagames.dofus.console.chat
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.messages.game.basic.BasicWhoAmIRequestMessage;
    import com.ankamagames.dofus.network.messages.game.basic.BasicWhoIsRequestMessage;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.logic.game.common.managers.CharacterDisplacementManager;
    import com.ankamagames.jerakine.console.ConsoleHandler;
    import com.ankamagames.dofus.BuildInfos;
    import flash.system.Capabilities;

    public class InfoInstructionHandler implements ConsoleInstructionHandler 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InfoInstructionHandler));


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var search:String;
            var bwai:BasicWhoAmIRequestMessage;
            var currentMap:String;
            var mapGenericId:Number;
            var mapId:Number;
            var formattedMapId:String;
            var currentCell:String;
            var date:Date;
            var coord1:String;
            var coord2:String;
            var mapX:int;
            var mapY:int;
            var bwrm:BasicWhoIsRequestMessage;
            switch (cmd)
            {
                case "whois":
                    if (args.length == 0)
                    {
                        return;
                    };
                    search = args.shift();
                    if (((search.length >= 1) && (search.length <= ProtocolConstantsEnum.MAX_PLAYER_OR_ACCOUNT_NAME_LEN)))
                    {
                        bwrm = new BasicWhoIsRequestMessage();
                        bwrm.initBasicWhoIsRequestMessage(true, search);
                        ConnectionsHandler.getConnection().send(bwrm);
                    };
                    break;
                case "version":
                    console.output(this.getVersion());
                    break;
                case "about":
                    console.output(this.getVersion());
                    break;
                case "whoami":
                    bwai = new BasicWhoAmIRequestMessage();
                    bwai.initBasicWhoAmIRequestMessage(true);
                    ConnectionsHandler.getConnection().send(bwai);
                    break;
                case "mapid":
                    currentMap = ((MapDisplayManager.getInstance().currentMapPoint.x + "/") + MapDisplayManager.getInstance().currentMapPoint.y);
                    mapGenericId = MapDisplayManager.getInstance().currentMapPoint.mapId;
                    mapId = MapDisplayManager.getInstance().mapInstanceId;
                    if (mapId > 0)
                    {
                        formattedMapId = (((mapId + " (model ") + mapGenericId) + ")");
                    }
                    else
                    {
                        formattedMapId = mapGenericId.toString();
                    };
                    console.output(I18n.getUiText("ui.chat.console.currentMap", [((((PlayedCharacterManager.getInstance().currentMap.outdoorX + "/") + PlayedCharacterManager.getInstance().currentMap.outdoorY) + ", ") + currentMap), formattedMapId]));
                    break;
                case "cellid":
                    currentCell = EntitiesManager.getInstance().getEntity(PlayedCharacterManager.getInstance().id).position.cellId.toString();
                    console.output(I18n.getUiText("ui.console.chat.currentCell", [currentCell]));
                    break;
                case "time":
                    date = new Date();
                    console.output(((TimeManager.getInstance().formatDateIG(0) + " - ") + TimeManager.getInstance().formatClock(0, false)));
                    break;
                case "travel":
                    if (((args.length > 2) || (args.length < 1)))
                    {
                        return;
                    };
                    coord1 = (args[0] as String);
                    if (args[1])
                    {
                        coord2 = (args[1] as String);
                    }
                    else
                    {
                        args = coord1.split(",");
                        coord1 = args[0];
                        coord2 = args[1];
                    };
                    mapX = int(coord1);
                    mapY = int(coord2);
                    CharacterDisplacementManager.getInstance().autoTravel(mapX, mapY);
                    break;
            };
        }

        private function getVersion():String
        {
            return ((((((((("----------------------------------------------\n" + "DOFUS CLIENT v ") + BuildInfos.VERSION) + "\n") + "(c) ANKAMA GAMES (") + BuildInfos.BUILD_DATE) + ") \n") + "Flash player ") + Capabilities.version) + "\n----------------------------------------------");
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "version":
                    return (I18n.getUiText("ui.chat.console.help.version"));
                case "about":
                    return (I18n.getUiText("ui.chat.console.help.version"));
                case "whois":
                    return (I18n.getUiText("ui.chat.console.help.whois"));
                case "whoami":
                    return (I18n.getUiText("ui.chat.console.help.whoami"));
                case "cellid":
                    return (I18n.getUiText("ui.chat.console.help.cellid"));
                case "mapid":
                    return (I18n.getUiText("ui.chat.console.help.mapid"));
                case "time":
                    return (I18n.getUiText("ui.chat.console.help.time"));
            };
            return (I18n.getUiText("ui.chat.console.noHelp", [cmd]));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
} com.ankamagames.dofus.console.chat

