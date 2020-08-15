package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;

    public class StatFloorTooltipBlock 
    {

        private var _content:String;
        private var _block:Object;
        private var _floor:uint;
        private var _statInterval:String;
        private var _statCost:String;

        public function StatFloorTooltipBlock(pFloor:uint, pStatInterval:String, pStatCost:String)
        {
            this._floor = pFloor;
            this._statInterval = pStatInterval;
            this._statCost = pStatCost;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("content", "chunks/stats/statFloor.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("content").processContent({
                "floor":this._floor,
                "statInterval":this._statInterval,
                "statCost":this._statCost
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

