package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShopBuyRequestAction implements Action 
    {

        public var articleId:int;
        public var quantity:int;
        public var currency:String;
        public var amount:Number;


        public static function create(articleId:int, quantity:int, currency:String, amount:Number):ShopBuyRequestAction
        {
            var action:ShopBuyRequestAction = new (ShopBuyRequestAction)();
            action.articleId = articleId;
            action.quantity = quantity;
            action.currency = currency;
            action.amount = amount;
            return (action);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.externalGame

