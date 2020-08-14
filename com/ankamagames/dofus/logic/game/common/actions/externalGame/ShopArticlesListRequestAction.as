package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShopArticlesListRequestAction implements Action 
    {

        public var categoryId:int;


        public static function create(categoryId:int):ShopArticlesListRequestAction
        {
            var action:ShopArticlesListRequestAction = new (ShopArticlesListRequestAction)();
            action.categoryId = categoryId;
            return (action);
        }


    }
} com.ankamagames.dofus.logic.game.common.actions.externalGame

