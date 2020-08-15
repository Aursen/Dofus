package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;

    public class TitleTooltipBlock 
    {

        private var _content:String;
        private var _text:String;
        private var _block:Object;

        public function TitleTooltipBlock(txt:String)
        {
            this._text = txt;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("content", "htmlChunks/base/subTitle.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("content").processContent({"text":this._text});
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

