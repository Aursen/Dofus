package Ankama_Fight.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.components.Texture;
    import d2hooks.ChallengeInfoUpdate;
    import d2hooks.FoldAll;
    import d2actions.ChallengeTargetsListRequest;
    import d2hooks.*;
    import d2actions.*;

    public class ChallengeDisplay 
    {

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        public var ctr_challenges:GraphicContainer;
        public var btn_minimize:ButtonContainer;
        public var tx_background_grid:TextureBitmap;
        public var tx_button_minimize:Texture;
        private var _challenges:Array;
        private var _challengeIconOffset:int;
        private var _ctrChallengeHeightModifier:int;
        private var _ctrChallengeHeight:int;


        public function main(oParam:Object=null):void
        {
            if (!oParam)
            {
                oParam = {"challenges":[this.dataApi.getChallengeWrapper(1), this.dataApi.getChallengeWrapper(2)]};
            };
            this.sysApi.addHook(ChallengeInfoUpdate, this.onChallengeInfoUpdate);
            this.sysApi.addHook(FoldAll, this.onFoldAll);
            this._challengeIconOffset = this.uiApi.me().getConstant("challengeIconOffset");
            this._ctrChallengeHeightModifier = this.uiApi.me().getConstant("ctrChallengeHeightModifier");
            this._ctrChallengeHeight = this.uiApi.me().getConstant("ctrChallengeHeight");
            this._challenges = new Array();
            this.updateChallengeList(oParam.challenges);
        }

        public function unload():void
        {
        }

        private function updateChallengeList(challenges:Object):void
        {
            var data:Object;
            var challenge:Object;
            var y:uint = this._challengeIconOffset;
            var i:uint;
            for each (data in challenges)
            {
                if (this._challenges.length <= i)
                {
                    challenge = new ChallengeEntry(this.uiApi.me(), this.ctr_challenges, data, 3, y);
                    this.uiApi.addComponentHook(challenge.ctr_challenge, "onRollOver");
                    this.uiApi.addComponentHook(challenge.ctr_challenge, "onRollOut");
                    this._challenges.push(challenge);
                }
                else
                {
                    this._challenges[i].data = data;
                };
                y = (y + this._ctrChallengeHeightModifier);
                i++;
            };
            this.tx_background_grid.height = (y + this._ctrChallengeHeight);
        }

        private function _showChallengeList(forceHide:int=-1):void
        {
            var mustShow:Boolean;
            if (forceHide == 1)
            {
                mustShow = false;
            }
            else
            {
                if (forceHide == 0)
                {
                    mustShow = true;
                }
                else
                {
                    mustShow = (!(this.ctr_challenges.visible));
                };
            };
            this.ctr_challenges.visible = mustShow;
            if (this.ctr_challenges.visible)
            {
                this.tx_button_minimize.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "hud/icon_minus_floating_menu.png"));
            }
            else
            {
                this.tx_button_minimize.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "hud/icon_plus_floating_menu.png"));
            };
        }

        private function getChallengeByButton(button:Object):ChallengeEntry
        {
            var challenge:ChallengeEntry;
            for each (challenge in this._challenges)
            {
                if (challenge.ctr_challenge == button)
                {
                    return (challenge);
                };
            };
            return (null);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_minimize:
                    this._showChallengeList();
                    break;
            };
        }

        private function onFoldAll(fold:Boolean):void
        {
            if (fold)
            {
                this._showChallengeList(1);
            }
            else
            {
                this._showChallengeList(0);
            };
        }

        public function onRollOver(target:Object):void
        {
            var challenge:ChallengeEntry = this.getChallengeByButton(target);
            if (((challenge) && (challenge.data)))
            {
                this.uiApi.showTooltip(challenge.data, target, false, "standard", 0, 2, 3, null, null, null);
                this.sysApi.sendAction(new ChallengeTargetsListRequest(challenge.data.id));
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onChallengeInfoUpdate(challenges:Object):void
        {
            this.updateChallengeList(challenges);
        }


    }
}

