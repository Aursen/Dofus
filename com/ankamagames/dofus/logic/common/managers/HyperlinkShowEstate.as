package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.dofus.logic.game.roleplay.types.Estate;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.EstateFrame;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.managers.UiModuleManager;

    public class HyperlinkShowEstate 
    {


        public static function click(estateIndex:int):void
        {
            var estate:Estate;
            var mod:UiModule;
            var estateFrame:EstateFrame = (Kernel.getWorker().getFrame(EstateFrame) as EstateFrame);
            if (estateFrame)
            {
                estate = estateFrame.estateList[estateIndex];
                if (estate)
                {
                    Berilia.getInstance().unloadUi("estateForm");
                    mod = UiModuleManager.getInstance().getModule("Ankama_TradeCenter");
                    Berilia.getInstance().loadUi(mod, mod.uis["estateForm"], "estateForm", [estateFrame.estateType, estate.infos]);
                };
            };
        }


    }
} com.ankamagames.dofus.logic.common.managers

