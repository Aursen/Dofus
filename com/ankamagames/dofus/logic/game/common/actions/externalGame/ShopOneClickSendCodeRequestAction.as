package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShopOneClickSendCodeRequestAction implements Action 
    {

        public var orderId:Number;


        public static function create(orderId:Number):ShopOneClickSendCodeRequestAction
        {
            var action:ShopOneClickSendCodeRequestAction = new (ShopOneClickSendCodeRequestAction)();
            action.orderId = orderId;
            return (action);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.externalGame

