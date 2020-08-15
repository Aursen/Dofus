package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShopOneClickBuyRequestAction implements Action 
    {

        public var data:String;
        public var currency:String;
        public var token:Number;


        public static function create(data:String, currency:String, token:Number):ShopOneClickBuyRequestAction
        {
            var action:ShopOneClickBuyRequestAction = new (ShopOneClickBuyRequestAction)();
            action.data = data;
            action.currency = currency;
            action.token = token;
            return (action);
        }


    }
}

