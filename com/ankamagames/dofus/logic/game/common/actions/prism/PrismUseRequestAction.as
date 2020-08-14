package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PrismUseRequestAction implements Action 
    {

        public var moduleType:int;


        public static function create(moduleType:int):PrismUseRequestAction
        {
            var action:PrismUseRequestAction = new (PrismUseRequestAction)();
            action.moduleType = moduleType;
            return (action);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.prism

