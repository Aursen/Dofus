package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class DisplayContextualMenuAction implements Action 
    {

        public var playerId:Number;


        public static function create(playerId:Number):DisplayContextualMenuAction
        {
            var o:DisplayContextualMenuAction = new (DisplayContextualMenuAction)();
            o.playerId = playerId;
            return (o);
        }


    }
} com.ankamagames.dofus.logic.game.roleplay.actions

