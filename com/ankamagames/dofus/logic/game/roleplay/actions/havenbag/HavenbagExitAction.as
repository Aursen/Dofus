package com.ankamagames.dofus.logic.game.roleplay.actions.havenbag
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class HavenbagExitAction implements Action 
    {


        public static function create():HavenbagExitAction
        {
            var a:HavenbagExitAction = new (HavenbagExitAction)();
            return (a);
        }


    }
}

