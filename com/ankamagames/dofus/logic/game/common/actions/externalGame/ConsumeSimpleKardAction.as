package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ConsumeSimpleKardAction implements Action 
    {

        public var id:uint;


        public static function create(id:uint):ConsumeSimpleKardAction
        {
            var a:ConsumeSimpleKardAction = new (ConsumeSimpleKardAction)();
            a.id = id;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.externalGame

