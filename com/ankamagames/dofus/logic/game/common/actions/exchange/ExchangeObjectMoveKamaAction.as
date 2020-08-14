package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeObjectMoveKamaAction implements Action 
    {

        public var kamas:Number = 0;


        public static function create(pKamas:Number):ExchangeObjectMoveKamaAction
        {
            var a:ExchangeObjectMoveKamaAction = new (ExchangeObjectMoveKamaAction)();
            a.kamas = pKamas;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.exchange

