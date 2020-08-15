package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;

    public class ChallengeTooltipBlock 
    {

        private var _challenge:Object;
        private var _content:String;
        private var _block:Object;

        public function ChallengeTooltipBlock(challenge:Object)
        {
            this._challenge = challenge;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("header", "chunks/challenge/header.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            var state:String;
            var cssClass:String;
            var uiApi:Object = Api.ui;
            var dataApi:Object = Api.data;
            var fightApi:Object = Api.fight;
            switch (this._challenge.result)
            {
                case 0:
                    state = uiApi.getText("ui.fight.challenge.inProgress");
                    cssClass = "p";
                    break;
                case 1:
                    state = uiApi.getText("ui.fight.challenge.complete");
                    cssClass = "bonus";
                    break;
                case 2:
                    state = uiApi.getText("ui.fight.challenge.failed");
                    cssClass = "malus";
                    break;
            };
            this._content = this._block.getChunk("header").processContent({
                "loot":(((uiApi.getText("ui.common.loot") + " +") + this._challenge.dropBonus) + "%"),
                "experience":(((uiApi.getText("ui.common.xp") + " +") + this._challenge.xpBonus) + "%"),
                "state":state,
                "cssClass":cssClass
            });
        }

        public function getContent():String
        {
            return (this._content);
        }

        public function get block():Object
        {
            return (this._block);
        }


    }
}

