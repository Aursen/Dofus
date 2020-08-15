package com.ankamagames.dofus.logic.game.common.actions.breach
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class BreachRoomUnlockAction implements Action 
    {

        public var roomId:uint;


        public static function create(room:uint):BreachRoomUnlockAction
        {
            var a:BreachRoomUnlockAction = new (BreachRoomUnlockAction)();
            a.roomId = room;
            return (a);
        }


    }
}

