package com.ankamagames.dofus.logic.game.common.actions.breach
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class BreachSaveBuyAction implements Action 
    {


        public static function create():BreachSaveBuyAction
        {
            return (new (BreachSaveBuyAction)());
        }


    }
}

