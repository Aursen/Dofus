package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.SocialHookList;
    import flash.geom.Rectangle;
    import com.ankamagames.berilia.types.data.TextTooltipInfo;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.enums.StrataEnum;

    public class HyperlinkSocialManager 
    {


        public static function openSocial(tab:int, subTab:int, ... args):void
        {
            KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial, tab, subTab, args);
        }

        public static function rollOver(pX:int, pY:int, tab:int, subTab:int, ... args):void
        {
            var target:Rectangle;
            var info:TextTooltipInfo;
            if (((tab == 1) && (subTab == 2)))
            {
                target = new Rectangle(pX, pY, 10, 10);
                info = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.taxCollectorUnderAttack"));
                TooltipManager.show(info, target, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "HyperLink", 6, 2, 3, true, null, null, null, null, false, StrataEnum.STRATA_TOOLTIP, 1);
            };
        }


    }
} com.ankamagames.dofus.logic.common.managers

