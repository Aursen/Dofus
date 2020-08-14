package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.dofus.logic.common.managers.AuctionHouseItemFilterManager;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;

    [InstanciedApi]
    public class AuctionHouseItemFilterApi extends AbstractItemFilterApi implements IApi 
    {


        [ApiData(name="currentUi")]
        override public function set currentUi(value:UiRootContainer):void
        {
            if (!_currentUi)
            {
                _currentUi = value;
            };
            _currentItemFilter = AuctionHouseItemFilterManager.getInstance();
        }


    }
} com.ankamagames.dofus.uiApi

