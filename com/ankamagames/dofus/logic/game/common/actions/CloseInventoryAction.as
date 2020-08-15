package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class CloseInventoryAction implements Action 
    {

        public var uiName:String = "storage";


        public static function create(uiName:String="storage"):CloseInventoryAction
        {
            var a:CloseInventoryAction = new (CloseInventoryAction)();
            a.uiName = uiName;
            return (a);
        }


    }
}

