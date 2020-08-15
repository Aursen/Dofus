package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeBidHouseListAction implements Action 
    {

        public var id:uint;
        public var follow:Boolean;


        public static function create(pId:uint, pFollow:Boolean=false):ExchangeBidHouseListAction
        {
            var a:ExchangeBidHouseListAction = new (ExchangeBidHouseListAction)();
            a.id = pId;
            a.follow = pFollow;
            return (a);
        }


    }
}

