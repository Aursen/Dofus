package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import __AS3__.vec.Vector;

    public class FinishMoveSetRequestAction implements Action 
    {

        public var enabledFinishedMoves:Vector.<int>;
        public var disabledFinishedMoves:Vector.<int>;


        public static function create(enabledFinishedMoves:Vector.<int>, disabledFinishedMoves:Vector.<int>):FinishMoveSetRequestAction
        {
            var action:FinishMoveSetRequestAction = new (FinishMoveSetRequestAction)();
            action.enabledFinishedMoves = enabledFinishedMoves;
            action.disabledFinishedMoves = disabledFinishedMoves;
            return (action);
        }


    }
} com.ankamagames.dofus.logic.game.roleplay.actions

