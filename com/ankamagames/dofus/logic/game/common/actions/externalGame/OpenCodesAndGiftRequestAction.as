package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OpenCodesAndGiftRequestAction implements Action 
    {


        public static function create():OpenCodesAndGiftRequestAction
        {
            return (new (OpenCodesAndGiftRequestAction)());
        }


    }
}

