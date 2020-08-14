package com.ankamagames.dofus.logic.game.roleplay.types
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
    import com.ankamagames.berilia.managers.CssManager;
    import com.ankamagames.berilia.types.data.ExtendedStyleSheet;

    public class MutantTooltipInformation 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MutantTooltipInformation));

        private var _cssUri:String = (XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_title.css");
        public var infos:GameRolePlayMutantInformations;
        public var wingsEffect:int;
        public var titleName:String;
        public var titleColor:String;

        public function MutantTooltipInformation(pInfos:GameRolePlayMutantInformations)
        {
            this.infos = pInfos;
        }

        private function onCssLoaded():void
        {
            var styleObj:Object;
            var _ssSheet:ExtendedStyleSheet = CssManager.getInstance().getCss(this._cssUri);
            styleObj = _ssSheet.getStyle("itemset");
            this.titleColor = styleObj["color"];
        }


    }
} com.ankamagames.dofus.logic.game.roleplay.types

