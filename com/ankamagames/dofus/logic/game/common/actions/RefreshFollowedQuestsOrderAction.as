package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import __AS3__.vec.Vector;

    public class RefreshFollowedQuestsOrderAction implements Action 
    {

        public var questsIds:Vector.<uint>;


        public static function create(questsIds:Vector.<uint>):RefreshFollowedQuestsOrderAction
        {
            var action:RefreshFollowedQuestsOrderAction = new (RefreshFollowedQuestsOrderAction)();
            action.questsIds = questsIds;
            return (action);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions

