package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShopOneClickValidateOrderRequestAction implements Action 
    {

        public var orderId:Number;
        public var code:String;


        public static function create(orderId:Number, code:String):ShopOneClickValidateOrderRequestAction
        {
            var action:ShopOneClickValidateOrderRequestAction = new (ShopOneClickValidateOrderRequestAction)();
            action.orderId = orderId;
            action.code = code;
            return (action);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.externalGame

