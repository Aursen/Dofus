package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;

    public class TextWithTwoColumnsBlock 
    {

        private var _content:String;
        private var _param:Object;
        private var _block:Object;

        public function TextWithTwoColumnsBlock(param:Object, chunkType:String="htmlChunks")
        {
            this._param = param;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent, chunkType);
            this._block.initChunk([Api.tooltip.createChunkData("twoColumns", (chunkType + "/text/twoColumns.txt"))]);
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("twoColumns").processContent(this._param);
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

