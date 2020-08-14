package com.ankamagames.dofus.logic.game.common.actions.breach
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import __AS3__.vec.Vector;

    public class BreachInvitationRequestAction implements Action 
    {

        public var guests:Vector.<Number>;


        public static function create(guests:Vector.<Number>):BreachInvitationRequestAction
        {
            var a:BreachInvitationRequestAction = new (BreachInvitationRequestAction)();
            a.guests = guests;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.breach

