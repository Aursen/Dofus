package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.dofus.misc.stats.IHookStats;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.dofus.misc.stats.StatisticsManager;
    import com.ankamagames.dofus.network.messages.connection.register.NicknameAcceptedMessage;
    import com.ankamagames.dofus.network.messages.connection.register.NicknameRefusedMessage;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.types.data.Hook;

    public class NicknameRegistrationStats implements IUiStats, IHookStats 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(NicknameRegistrationStats));
        private static const EVENT_ID:uint = 3;

        private var _action:StatsAction;
        private var _numAttempts:uint = 1;

        public function NicknameRegistrationStats(pUi:UiRootContainer)
        {
            var screenQuality:String;
            super();
            this._action = StatsAction.get(EVENT_ID, false, false, true);
            switch (OptionManager.getOptionManager("dofus").getOption("dofusQuality"))
            {
                case 0:
                    screenQuality = "LOW";
                    break;
                case 1:
                    screenQuality = "MEDIUM";
                    break;
                case 2:
                    screenQuality = "HIGH";
                    break;
            };
            this._action.setParam("screen_quality", screenQuality);
            this._action.setParam("screen_size", ((OptionManager.getOptionManager("dofus").getOption("smallScreenFont") == false) ? 17 : 15));
            this._action.setParam("step_id", 0);
            this._action.setParam("account_id", 0);
            this._action.setParam("step_attempts", this._numAttempts);
            this._action.start();
        }

        public function process(pMessage:Message, pArgs:Array=null):void
        {
            switch (true)
            {
                case (pMessage is NicknameAcceptedMessage):
                    this._action.setParam("step_success", true);
                    this._action.send();
                    StatisticsManager.getInstance().startFirstTimeUserExperience(this._action.user);
                    break;
                case (pMessage is NicknameRefusedMessage):
                    this._action.setParam("step_attempts", this._numAttempts);
                    this._action.setParam("step_success", false);
                    this._action.send();
                    this._numAttempts++;
                    break;
            };
        }

        public function onHook(pHook:Hook, pArgs:Array):void
        {
        }

        public function remove():void
        {
        }


    }
}

