package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ConsumeMultipleKardAction implements Action 
    {

        public var id:uint;


        public static function create(id:uint):ConsumeMultipleKardAction
        {
            var a:ConsumeMultipleKardAction = new (ConsumeMultipleKardAction)();
            a.id = id;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.externalGame

