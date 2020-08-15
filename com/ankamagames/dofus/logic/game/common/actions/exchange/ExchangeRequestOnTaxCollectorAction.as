package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeRequestOnTaxCollectorAction implements Action 
    {


        public static function create():ExchangeRequestOnTaxCollectorAction
        {
            var a:ExchangeRequestOnTaxCollectorAction = new (ExchangeRequestOnTaxCollectorAction)();
            return (a);
        }


    }
}

