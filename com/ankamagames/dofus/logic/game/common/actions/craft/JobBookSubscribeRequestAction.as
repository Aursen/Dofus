package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import __AS3__.vec.Vector;

    public class JobBookSubscribeRequestAction implements Action 
    {

        public var jobIds:Vector.<uint>;


        public static function create(jobIds:Vector.<uint>):JobBookSubscribeRequestAction
        {
            var action:JobBookSubscribeRequestAction = new (JobBookSubscribeRequestAction)();
            action.jobIds = jobIds;
            return (action);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.craft

