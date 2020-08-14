package Ankama_Party.ui
{
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.dofus.datacenter.arena.ArenaLeague;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.berilia.enums.StrataEnum;

    public class LeagueChangeRewardPopup 
    {

        private const TOOLTIP_PREV:String = "tooltipPreview";

        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        private var _params:Object;
        private var _ornamentId:int;
        public var leagueChangeRewards:GraphicContainer;
        public var btn_close_main:ButtonContainer;
        public var lbl_endSeasonRank:Label;
        public var lbl_title:Label;
        public var lbl_content:Label;


        public function main(pParam:Object):void
        {
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this._params = pParam;
            if (!this._params)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
            var league:ArenaLeague = this.dataApi.getArenaLeagueById(this._params.leagueId);
            if (!league)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
            this._ornamentId = league.ornamentId;
            this.lbl_endSeasonRank.text = league.name;
            this.lbl_title.text = this.uiApi.getText("ui.common.congratulations");
            this.lbl_content.text = this.utilApi.applyTextParams(this.uiApi.getText("ui.party.leagueChangeReward"), [this._ornamentId]);
            this.displayTooltip();
        }

        public function unload():void
        {
            this.uiApi.hideTooltip(this.TOOLTIP_PREV);
        }

        private function displayTooltip():void
        {
            var tooltipInfos:Object;
            var infos:Object = this.playerApi.getEntityTooltipInfos();
            if (!infos)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                return;
            };
            tooltipInfos = {
                "titleName":infos.titleName,
                "titleColor":infos.titleColor,
                "omegaLevel":infos.omegaLevel,
                "leagueId":this._params.leagueId,
                "ladderPosition":this._params.ladderPosition,
                "wingsEffect":infos.wingsEffect,
                "infos":infos.infos,
                "hideGuild":true,
                "hideAlliance":true
            };
            tooltipInfos.ornamentAssetId = this.dataApi.getOrnament(this._ornamentId).assetId;
            var tmp:* = this.leagueChangeRewards.getBounds(this.uiApi.me());
            this.uiApi.hideTooltip(this.TOOLTIP_PREV);
            this.uiApi.showTooltip(tooltipInfos, tmp, false, this.TOOLTIP_PREV, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 20, "player", null, null, null, false, StrataEnum.STRATA_MEDIUM, 1.5);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close_main:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    break;
                case "closeUi":
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }


    }
} Ankama_Party.ui

