package Ankama_Tooltips.blocks
{
    import __AS3__.vec.Vector;
    import Ankama_Tooltips.Api;
    import com.ankamagames.dofus.network.enums.BreachRewardLockEnum;

    public class BreachRewardBlock 
    {

        private var _content:String;
        private var _block:Object;
        private var _data:Vector.<uint>;
        private var _isBudget:Boolean;
        private var _withConditionBlock:Boolean;

        public function BreachRewardBlock(data:Vector.<uint>, isBudget:Boolean, withConditionBlock:Boolean)
        {
            this._content = "";
            this._data = data;
            this._isBudget = isBudget;
            this._withConditionBlock = withConditionBlock;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            var chunkData:Array = [Api.tooltip.createChunkData("content", "htmlChunks/breach/conditions.txt")];
            if (!this._withConditionBlock)
            {
                chunkData.push(Api.tooltip.createChunkData("subtitle", "htmlChunks/base/subTitle.txt"));
            };
            this._block.initChunk(chunkData);
        }

        public function onAllChunkLoaded():void
        {
            var finalStr:String;
            if (this.checkForSubtitle())
            {
                this._content = this._block.getChunk("subtitle").processContent({"text":Api.ui.getText("ui.common.conditions")});
            };
            if (this._isBudget)
            {
                this._content = (this._content + this._block.getChunk("content").processContent({"content":Api.ui.getText("ui.breach.isBreachOwner")}));
            };
            var i:int;
            while (i < this._data.length)
            {
                finalStr = "";
                switch (this._data[i])
                {
                    case BreachRewardLockEnum.BREACH_REWARD_LOCK_FIGHTER:
                        finalStr = (finalStr + Api.ui.getText("ui.breach.notInLastFight"));
                        break;
                    case BreachRewardLockEnum.BREACH_REWARD_LOCK_RESOURCES:
                        finalStr = (finalStr + Api.ui.getText("ui.breach.notEnoughMoney", ((this._isBudget) ? Api.ui.getText("ui.breach.dreamPoints") : Api.ui.getText("ui.breach.fragments").toLowerCase())));
                        break;
                    case BreachRewardLockEnum.BREACH_REWARD_LOCK_USELESS:
                        finalStr = (finalStr + Api.ui.getText("ui.breach.purchaseDeactivated"));
                        break;
                };
                if (finalStr != "")
                {
                    this._content = (this._content + this._block.getChunk("content").processContent({"content":finalStr}));
                };
                i++;
            };
        }

        public function checkForSubtitle():Boolean
        {
            return ((!(this._withConditionBlock)) && ((this._isBudget) || (this._data.length > 0)));
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

