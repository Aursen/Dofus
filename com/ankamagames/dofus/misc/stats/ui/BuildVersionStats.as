package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.dofus.misc.stats.IHookStats;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.jerakine.utils.system.SystemManager;
    import flash.system.Capabilities;
    import com.ankamagames.dofus.misc.stats.StatisticsManager;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.types.data.Hook;

    public class BuildVersionStats implements IUiStats, IHookStats 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(BuildVersionStats));
        private static var _action:StatsAction;
        private static const BUILD_VERSION_ID:uint = 713;


        public static function createAndSendStat():void
        {
            _log.debug("Try sending build version stat");
            if (_action)
            {
                _log.debug("Build version stat was already created and sent. Not sending anymore for this session.");
                return;
            };
            _action = new StatsAction(BUILD_VERSION_ID);
            _action.user = StatsAction.getUserId();
            _action.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
            _action.setParam("account_id", PlayerManager.getInstance().accountId);
            _action.setParam("os", SystemManager.getSingleton().os);
            _action.setParam("os_version", SystemManager.getSingleton().version);
            _action.setParam("os_arch_is64", Capabilities.supports64BitProcesses);
            _action.setParam("adobe_air_version", Capabilities.version);
            _log.debug(("Build version stat created, ready to be sent : " + _action.toString()));
            StatisticsManager.getInstance().sendAction(_action);
        }


        public function process(pMessage:Message, pArgs:Array=null):void
        {
        }

        public function onHook(pHook:Hook, pArgs:Array):void
        {
        }

        public function remove():void
        {
        }


    }
} com.ankamagames.dofus.misc.stats.ui

