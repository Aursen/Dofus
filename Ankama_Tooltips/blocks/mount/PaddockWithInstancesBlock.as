package Ankama_Tooltips.blocks.mount
{
    import Ankama_Tooltips.Api;

    public class PaddockWithInstancesBlock 
    {

        private var _content:String;
        private var _block:Object;

        public function PaddockWithInstancesBlock()
        {
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("content", "chunks/mount/paddockWithInstances.txt")]);
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
}

