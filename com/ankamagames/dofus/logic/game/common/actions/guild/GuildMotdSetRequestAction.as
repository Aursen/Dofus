package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildMotdSetRequestAction implements Action 
    {

        public var content:String;


        public static function create(content:String):GuildMotdSetRequestAction
        {
            var action:GuildMotdSetRequestAction = new (GuildMotdSetRequestAction)();
            action.content = content;
            return (action);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.guild

