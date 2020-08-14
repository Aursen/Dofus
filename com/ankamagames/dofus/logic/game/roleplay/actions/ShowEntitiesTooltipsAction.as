package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShowEntitiesTooltipsAction implements Action 
    {

        public var fromShortcut:Boolean;


        public static function create(pFromShortcut:Boolean=true):ShowEntitiesTooltipsAction
        {
            var a:ShowEntitiesTooltipsAction = new (ShowEntitiesTooltipsAction)();
            a.fromShortcut = pFromShortcut;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.roleplay.actions

