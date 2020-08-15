package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OpenIdolsAction implements Action 
    {


        public static function create():OpenIdolsAction
        {
            return (new (OpenIdolsAction)());
        }


    }
}

