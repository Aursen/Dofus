package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;

    public class HouseTooltipBlock 
    {

        private var _content:String;
        private var _infos:Object;
        private var _block:Object;

        public function HouseTooltipBlock()
        {
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("content", "chunks/world/house/houseWithInstances.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("content").processContent(null);
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
} Ankama_Tooltips.blocks

