package com.ankamagames.dofus.logic.game.common.actions.breach
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class BreachTeleportRequestAction implements Action 
    {


        public static function create():BreachTeleportRequestAction
        {
            var a:BreachTeleportRequestAction = new (BreachTeleportRequestAction)();
            return (a);
        }


    }
}

