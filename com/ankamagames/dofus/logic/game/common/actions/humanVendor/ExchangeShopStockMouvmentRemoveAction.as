package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeShopStockMouvmentRemoveAction implements Action 
    {

        public var objectUID:uint;
        public var quantity:int;


        public static function create(pObjectUID:uint, pQuantity:int):ExchangeShopStockMouvmentRemoveAction
        {
            var a:ExchangeShopStockMouvmentRemoveAction = new (ExchangeShopStockMouvmentRemoveAction)();
            a.objectUID = pObjectUID;
            a.quantity = -(Math.abs(pQuantity));
            return (a);
        }


    }
}

