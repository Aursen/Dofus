package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;

    public class HyperlinkShowOfflineSales 
    {


        public static function showOfflineSales(pTab:uint, pLinkId:uint):void
        {
            var chatFrame:ChatFrame = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame);
            KernelEventsManager.getInstance().processCallback(HookList.OpenOfflineSales, pTab, chatFrame.offlineSales, chatFrame.getUnsoldItems(pLinkId));
        }


    }
} com.ankamagames.dofus.logic.common.managers

