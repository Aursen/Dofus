package com.ankamagames.dofus.logic.game.common.actions.exchange
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import __AS3__.vec.Vector;

    public class ExchangeObjectTransfertListToInvAction implements Action 
    {

        public var ids:Vector.<uint>;


        public static function create(pIds:Vector.<uint>):ExchangeObjectTransfertListToInvAction
        {
            var a:ExchangeObjectTransfertListToInvAction = new (ExchangeObjectTransfertListToInvAction)();
            a.ids = pIds;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.exchange

