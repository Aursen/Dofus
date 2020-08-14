package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;

    public class TextWithTextureTooltipBlock 
    {

        private var _content:String;
        private var _block:Object;
        private var _blocks:Array;
        private var _data:*;

        public function TextWithTextureTooltipBlock(data:*)
        {
            this._data = data;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._blocks = [];
            this._blocks.push(Api.tooltip.createChunkData("content", "chunks/text/textWithTexture.txt"));
            this._block.initChunk(this._blocks);
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("content").processContent(this._data);
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

