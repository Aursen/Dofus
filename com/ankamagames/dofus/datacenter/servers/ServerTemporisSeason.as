package com.ankamagames.dofus.datacenter.servers
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.IdAccessors;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.network.enums.GameServerTypeEnum;

    public class ServerTemporisSeason implements IDataCenter 
    {

        public static const MODULE:String = "ServerTemporisSeasons";
        private static var _isTemporisSpellsUi:Boolean = false;
        public static var idAccessors:IdAccessors = new IdAccessors(getSeasonById, getAllSeason);

        public var uid:int;
        public var seasonNumber:uint;
        public var information:String;
        public var beginning:Number;
        public var closure:Number;


        public static function getSeasonById(id:int):ServerTemporisSeason
        {
            return (GameData.getObject(MODULE, id) as ServerTemporisSeason);
        }

        public static function getAllSeason():Array
        {
            return (GameData.getObjects(MODULE));
        }

        public static function getCurrentSeason():ServerTemporisSeason
        {
            var season:ServerTemporisSeason;
            var allSeason:Array = ServerTemporisSeason.getAllSeason();
            var timeManager:TimeManager = TimeManager.getInstance();
            if (((allSeason === null) || (timeManager === null)))
            {
                return (null);
            };
            var currentDate:Number = timeManager.getTimestamp();
            for each (season in allSeason)
            {
                if (((currentDate >= season.beginning) && (currentDate <= season.closure)))
                {
                    return (season);
                };
            };
            return (null);
        }

        public static function initCurrentSeason():void
        {
            var playerManager:PlayerManager = PlayerManager.getInstance();
            var currentTemporisSeason:ServerTemporisSeason = ServerTemporisSeason.getCurrentSeason();
            _isTemporisSpellsUi = (((((!(playerManager === null)) && (!(playerManager.server === null))) && (!(currentTemporisSeason === null))) && (playerManager.server.gameTypeId === GameServerTypeEnum.SERVER_TYPE_TEMPORIS)) && (currentTemporisSeason.seasonNumber === 4));
        }

        public static function get isTemporisSpellsUi():Boolean
        {
            return (_isTemporisSpellsUi);
        }


    }
} com.ankamagames.dofus.datacenter.servers

