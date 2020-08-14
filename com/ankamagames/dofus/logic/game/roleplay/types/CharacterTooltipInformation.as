package com.ankamagames.dofus.logic.game.roleplay.types
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
    import com.ankamagames.dofus.datacenter.appearance.Title;
    import com.ankamagames.dofus.datacenter.appearance.Ornament;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
    import com.ankamagames.berilia.managers.CssManager;
    import com.ankamagames.jerakine.types.Callback;
    import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionTitle;
    import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionOrnament;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import com.ankamagames.berilia.types.data.ExtendedStyleSheet;

    public class CharacterTooltipInformation 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CharacterTooltipInformation));

        private var _cssUri:String = (XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_title.css");
        public var infos:GameRolePlayHumanoidInformations;
        public var wingsEffect:int;
        public var titleName:String;
        public var titleColor:String;
        public var ornamentAssetId:int;
        public var omegaLevel:int;
        public var leagueId:int;
        public var ladderPosition:int;

        public function CharacterTooltipInformation(pInfos:GameRolePlayHumanoidInformations, pWingsEffect:int)
        {
            var titleId:int;
            var titleParam:String;
            var ornamentId:int;
            var playerLevel:uint;
            var league:uint;
            var ladderPos:uint;
            var option:*;
            var title:Title;
            var ornament:Ornament;
            super();
            this.infos = pInfos;
            this.wingsEffect = pWingsEffect;
            if ((pInfos is GameRolePlayCharacterInformations))
            {
                CssManager.getInstance().askCss(this._cssUri, new Callback(this.onCssLoaded));
                for each (option in pInfos.humanoidInfo.options)
                {
                    if ((option is HumanOptionTitle))
                    {
                        titleId = option.titleId;
                        titleParam = option.titleParam;
                    };
                    if ((option is HumanOptionOrnament))
                    {
                        ornamentId = option.ornamentId;
                        playerLevel = option.level;
                        league = option.leagueId;
                        ladderPos = option.ladderPosition;
                    };
                };
                if (titleId)
                {
                    title = Title.getTitleById(titleId);
                    if (title)
                    {
                        if (pInfos.humanoidInfo.sex == 0)
                        {
                            this.titleName = (("« " + title.nameMale) + " »");
                        }
                        else
                        {
                            this.titleName = (("« " + title.nameFemale) + " »");
                        };
                        if (titleParam)
                        {
                            this.titleName = this.titleName.split("%1").join(titleParam);
                        };
                    };
                };
                if (ornamentId)
                {
                    ornament = Ornament.getOrnamentById(ornamentId);
                    this.ornamentAssetId = ornament.assetId;
                    this.omegaLevel = (playerLevel - ProtocolConstantsEnum.MAX_LEVEL);
                    this.leagueId = league;
                    this.ladderPosition = ladderPos;
                };
            };
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

