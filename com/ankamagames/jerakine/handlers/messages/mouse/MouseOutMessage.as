package com.ankamagames.jerakine.handlers.messages.mouse
{
    import com.ankamagames.jerakine.handlers.messages.HumanInputMessage;
    import flash.display.InteractiveObject;
    import flash.events.MouseEvent;

    public class MouseOutMessage extends MouseMessage 
    {


        public static function create(target:InteractiveObject, mouseEvent:MouseEvent, instance:MouseMessage=null):MouseOutMessage
        {
            if (!instance)
            {
                instance = new (MouseOutMessage)();
            };
            return (HumanInputMessage.create(target, mouseEvent, instance) as MouseOutMessage);
        }


    }
} com.ankamagames.jerakine.handlers.messages.mouse

