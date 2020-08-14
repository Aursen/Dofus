package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class RemoveEntityAction implements Action 
    {

        public var actorId:Number;


        public static function create(actorId:Number):RemoveEntityAction
        {
            var o:RemoveEntityAction = new (RemoveEntityAction)();
            o.actorId = actorId;
            return (o);
        }


    }
} com.ankamagames.dofus.logic.game.fight.actions

