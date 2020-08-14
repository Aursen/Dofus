package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GameFightPlacementSwapPositionsAcceptAction implements Action 
    {

        public var requestId:uint;


        public static function create(pRequestId:uint):GameFightPlacementSwapPositionsAcceptAction
        {
            var action:GameFightPlacementSwapPositionsAcceptAction = new (GameFightPlacementSwapPositionsAcceptAction)();
            action.requestId = pRequestId;
            return (action);
        }


    }
} com.ankamagames.dofus.logic.game.fight.actions

