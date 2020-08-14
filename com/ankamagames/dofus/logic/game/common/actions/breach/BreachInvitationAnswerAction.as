package com.ankamagames.dofus.logic.game.common.actions.breach
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class BreachInvitationAnswerAction implements Action 
    {

        public var answer:Boolean;


        public static function create(answer:Boolean):BreachInvitationAnswerAction
        {
            var a:BreachInvitationAnswerAction = new (BreachInvitationAnswerAction)();
            a.answer = answer;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.breach

