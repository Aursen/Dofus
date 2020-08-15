package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import __AS3__.vec.Vector;

    public class LivingObjectFeedAction implements Action 
    {

        public var objectUID:uint;
        public var meal:Vector.<Object>;


        public static function create(objectUID:uint, meal:Vector.<Object>):LivingObjectFeedAction
        {
            var action:LivingObjectFeedAction = new (LivingObjectFeedAction)();
            action.objectUID = objectUID;
            action.meal = meal;
            return (action);
        }


    }
}

