package com.ankamagames.dofus.misc.stats.ui
{
    import com.ankamagames.dofus.misc.stats.IHookStats;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.berilia.types.data.Hook;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.dofus.misc.stats.StatsAction;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
    import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.jerakine.messages.Message;

    public class PayZoneUiStats implements IHookStats, IUiStats 
    {

        private static const EVENT_ID:uint = 668;

        public function PayZoneUiStats(pUi:UiRootContainer)
        {
        }

        public function onHook(pHook:Hook, pArgs:Array):void
        {
        }

        public function process(pMessage:Message, pArgs:Array=null):void
        {
            var target:GraphicContainer;
            var _local_4:String;
            var action:StatsAction;
            if ((pMessage is MouseClickMessage))
            {
                target = ((pArgs) ? pArgs[1] : null);
                if (target)
                {
                    switch (target.name)
                    {
                        case "btn_topLeft":
                            _local_4 = "POPUP";
                            break;
                        case "btn_link":
                            _local_4 = "CLIC";
                            break;
                    };
                    if (_local_4)
                    {
                        action = new StatsAction(EVENT_ID);
                        action.user = StatsAction.getUserId();
                        action.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
                        action.setParam("account_id", PlayerManager.getInstance().accountId);
                        action.setParam("server_id", PlayerManager.getInstance().server.id);
                        action.setParam("character_id", PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
                        action.setParam("character_level", PlayedCharacterManager.getInstance().infos.level);
                        action.setParam("map_id", PlayedCharacterManager.getInstance().currentMap.mapId);
                        action.setParam("type", _local_4);
                        action.send();
                    };
                };
            };
        }

        public function remove():void
        {
        }


    }
} com.ankamagames.dofus.misc.stats.ui

