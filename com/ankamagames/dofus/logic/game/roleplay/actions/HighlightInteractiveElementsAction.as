package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class HighlightInteractiveElementsAction implements Action 
    {

        public var fromShortcut:Boolean;


        public static function create(pFromShortcut:Boolean=true):HighlightInteractiveElementsAction
        {
            var a:HighlightInteractiveElementsAction = new (HighlightInteractiveElementsAction)();
            a.fromShortcut = pFromShortcut;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.roleplay.actions

