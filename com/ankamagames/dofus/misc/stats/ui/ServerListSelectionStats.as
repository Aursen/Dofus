package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.dofus.misc.stats.IHookStats;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.dofus.logic.connection.actions.ServerSelectionAction;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
    import com.ankamagames.dofus.logic.connection.actions.AcquaintanceSearchAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.types.data.Hook;

    public class ServerListSelectionStats implements IUiStats, IHookStats 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerListSelectionStats));
        private static const EVENT_ID:uint = 4;

        private var _action:StatsAction;

        public function ServerListSelectionStats(pUi:UiRootContainer)
        {
            this._action = StatsAction.get(EVENT_ID, false, false, true);
            this._action.setParam("account_id", PlayerManager.getInstance().accountId);
            this._action.setParam("step_id", 100);
            this._action.setParam("automatic_choice", true);
        }

        public function process(pMessage:Message, pArgs:Array=null):void
        {
            var ssaction:ServerSelectionAction;
            var mcmsg:MouseClickMessage;
            switch (true)
            {
                case (pMessage is AcquaintanceSearchAction):
                    this._action.setParam("seek_a_friend", true);
                    break;
                case (pMessage is ServerSelectionAction):
                    ssaction = (pMessage as ServerSelectionAction);
                    this._action.setParam("server_id", ssaction.serverId);
                    this._action.setParam("automatic_choice", false);
                    break;
                case (pMessage is MouseClickMessage):
                    mcmsg = (pMessage as MouseClickMessage);
                    if (mcmsg.target.name == "btn_closeSearch")
                    {
                        this._action.setParam("seek_a_friend", false);
                    };
            };
        }

        public function onHook(pHook:Hook, pArgs:Array):void
        {
        }

        public function remove():void
        {
        }


    }
} com.ankamagames.dofus.misc.stats.ui

