package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ChatTextOutputAction implements Action 
    {

        public var content:String;
        public var channel:uint;
        public var receiverName:String;
        public var objects:Array;


        public static function create(msg:String, channel:uint=0, receiverName:String="", objects:Array=null):ChatTextOutputAction
        {
            var a:ChatTextOutputAction = new (ChatTextOutputAction)();
            a.content = msg;
            a.channel = channel;
            a.receiverName = receiverName;
            a.objects = objects;
            return (a);
        }


    }
}

