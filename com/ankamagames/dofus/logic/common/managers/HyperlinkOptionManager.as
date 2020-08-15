package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.berilia.managers.UiModuleManager;

    public class HyperlinkOptionManager 
    {


        public static function openOption(tab:String):void
        {
            var mod:UiModule;
            if (tab)
            {
                mod = UiModuleManager.getInstance().getModule("Ankama_Common");
                mod.mainClass.openOptionMenu(false, tab);
            };
        }


    }
}

