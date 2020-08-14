package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ForgettableSpellClientActionAction implements Action 
    {

        public var spellId:uint;
        public var action:uint;


        public static function create(spellId:uint, action:uint):ForgettableSpellClientActionAction
        {
            var forgettableSpellClientActionAction:ForgettableSpellClientActionAction = new (ForgettableSpellClientActionAction)();
            forgettableSpellClientActionAction.spellId = spellId;
            forgettableSpellClientActionAction.action = action;
            return (forgettableSpellClientActionAction);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions

