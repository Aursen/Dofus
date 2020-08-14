package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OpenTemporisSpellsUiAction implements Action 
    {

        public var isSpellSetsUi:Boolean = false;


        public static function create(isSpellSetsUi:Boolean=false):OpenTemporisSpellsUiAction
        {
            var newOpenTemporisSpellsUiAction:OpenTemporisSpellsUiAction = new (OpenTemporisSpellsUiAction)();
            newOpenTemporisSpellsUiAction.isSpellSetsUi = isSpellSetsUi;
            return (newOpenTemporisSpellsUiAction);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions

