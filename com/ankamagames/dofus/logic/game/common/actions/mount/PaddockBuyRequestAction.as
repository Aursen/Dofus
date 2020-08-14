package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PaddockBuyRequestAction implements Action 
    {

        public var proposedPrice:Number = 0;


        public static function create(proposedPrice:Number):PaddockBuyRequestAction
        {
            var action:PaddockBuyRequestAction = new (PaddockBuyRequestAction)();
            action.proposedPrice = proposedPrice;
            return (action);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.mount

