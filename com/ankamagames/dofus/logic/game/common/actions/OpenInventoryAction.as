package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OpenInventoryAction implements Action 
    {

        public var behavior:String;
        public var uiName:String = "storage";


        public static function create(behavior:String="bag", uiName:String="storage"):OpenInventoryAction
        {
            var a:OpenInventoryAction = new (OpenInventoryAction)();
            a.behavior = behavior;
            a.uiName = uiName;
            return (a);
        }


    }
}

