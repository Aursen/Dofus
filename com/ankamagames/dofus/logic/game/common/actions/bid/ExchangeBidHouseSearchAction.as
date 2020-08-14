package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeBidHouseSearchAction implements Action 
    {

        public var type:uint;
        public var follow:Boolean = false;
        public var genId:uint;


        public static function create(pType:uint, pGenId:uint, follow:Boolean=false):ExchangeBidHouseSearchAction
        {
            var a:ExchangeBidHouseSearchAction = new (ExchangeBidHouseSearchAction)();
            a.type = pType;
            a.follow = follow;
            a.genId = pGenId;
            return (a);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.bid

