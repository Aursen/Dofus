package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.dofus.misc.stats.IHookStats;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.berilia.types.data.Hook;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.messages.VideoBufferChangeMessage;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
    import flash.utils.getTimer;
    import com.ankamagames.jerakine.messages.Message;

    public class UpdateInformationStats implements IHookStats, IUiStats 
    {

        private var _action:StatsAction;
        private var _newsIds:Array = new Array();
        private var _ui:UiRootContainer;
        private var _playStartTime:uint;
        private var _vidTime:Number = 0;
        private var _numPlays:uint;

        public function UpdateInformationStats(pUi:UiRootContainer)
        {
            this._ui = pUi;
            this._action = StatsAction.get(669, false, false, true);
            this._action.setParam("account_id", PlayerManager.getInstance().accountId);
            this._action.setParam("maj_id", ((BuildInfos.VERSION.major.toString() + "-") + BuildInfos.VERSION.minor.toString()));
            this._action.setParam("read_news_id", this._newsIds);
            this._action.setParam("vid_full_screen", false);
            this._action.setParam("vid_time", 0);
            this._action.start();
        }

        public function onHook(pHook:Hook, pArgs:Array):void
        {
        }

        public function process(pMessage:Message, pArgs:Array=null):void
        {
            var target:GraphicContainer;
            var newsId:uint;
            var vbcmsg:VideoBufferChangeMessage;
            if ((pMessage is MouseClickMessage))
            {
                target = ((pArgs) ? pArgs[1] : null);
                if (target)
                {
                    switch (target.name)
                    {
                        case "ctrTopLeftSlot":
                            newsId = 1;
                            break;
                        case "ctrMainSlot":
                            newsId = 2;
                            break;
                        case "ctrTopRightSlot":
                            newsId = 3;
                            break;
                        case "ctrBottomLeftSlot":
                        case "ctrBottomRightSlot":
                            newsId = 4;
                            break;
                        case "tx_videoPlayerSmallExpand":
                            if (!this._ui.childUiRoot.uiClass.fullScreenMode)
                            {
                                this._action.setParam("vid_full_screen", true);
                            };
                            break;
                        case "videoPlayerSmall":
                            if (this._numPlays == 0)
                            {
                                if (!this._ui.childUiRoot.uiClass.videoSmallIsPlaying)
                                {
                                    this._playStartTime = getTimer();
                                }
                                else
                                {
                                    this._vidTime = (this._vidTime + ((getTimer() - this._playStartTime) / 1000));
                                };
                            };
                            break;
                        case "btn_play":
                            this.onVideoEnd();
                            break;
                    };
                    if (((newsId) && (this._newsIds.indexOf(newsId) == -1)))
                    {
                        this._newsIds.push(newsId);
                    };
                };
            }
            else
            {
                if ((pMessage is VideoBufferChangeMessage))
                {
                    vbcmsg = (pMessage as VideoBufferChangeMessage);
                    if (vbcmsg.state == 2)
                    {
                        this.onVideoEnd();
                        this._numPlays++;
                    };
                };
            };
        }

        public function remove():void
        {
            this._action.send();
        }

        private function onVideoEnd():void
        {
            if (this._numPlays == 0)
            {
                if (this._playStartTime)
                {
                    this._vidTime = (this._vidTime + int(((getTimer() - this._playStartTime) / 1000)));
                };
                this._action.setParam("vid_time", this._vidTime);
            };
        }


    }
}

