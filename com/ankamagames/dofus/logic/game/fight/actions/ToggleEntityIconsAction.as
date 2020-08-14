package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ToggleEntityIconsAction implements Action 
    {

        public var isVisible:Boolean;


        public static function create(isVisible:Boolean):ToggleEntityIconsAction
        {
            var a:ToggleEntityIconsAction = new (ToggleEntityIconsAction)();
            a.isVisible = isVisible;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.fight.actions

