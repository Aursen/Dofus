package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class StatusShareSetAction implements Action 
    {

        public var enable:Boolean;


        public static function create(enable:Boolean):StatusShareSetAction
        {
            var a:StatusShareSetAction = new (StatusShareSetAction)();
            a.enable = enable;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.social

