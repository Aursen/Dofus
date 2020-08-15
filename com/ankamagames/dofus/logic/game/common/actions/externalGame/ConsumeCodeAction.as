package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ConsumeCodeAction implements Action 
    {

        public var code:String;


        public static function create(code:String):ConsumeCodeAction
        {
            var a:ConsumeCodeAction = new (ConsumeCodeAction)();
            a.code = code;
            return (a);
        }


    }
}

