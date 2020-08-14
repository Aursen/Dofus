package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;

    public class SignTooltipBlock 
    {

        private var _content:String;
        private var _block:Object;
        private var _blocks:Array;
        private var _data:*;

        public function SignTooltipBlock(data:*)
        {
            this._data = data;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._blocks = [];
            this._blocks.push(Api.tooltip.createChunkData("content", "chunks/world/worldRpSign.txt"));
            this._blocks.push(Api.tooltip.createChunkData("labelContent", "chunks/world/worldRpSignLabel.txt"));
            var dir:int = parseInt(data.params.split(",")[1]);
            if (((dir > 0) && (dir < 9)))
            {
                this._blocks.push(Api.tooltip.createChunkData("textureContent", "chunks/world/worldRpSignTexture.txt"));
            };
            this._block.initChunk(this._blocks);
        }

        public function onAllChunkLoaded():void
        {
            var dataContent:Object = new Object();
            dataContent.labelContent = this._block.getChunk("labelContent").processContent(null);
            var dir:int = parseInt(this._data.params.split(",")[1]);
            if (((dir > 0) && (dir < 9)))
            {
                dataContent.textureContent = this._block.getChunk("textureContent").processContent(null);
            };
            this._content = this._block.getChunk("content").processContent(dataContent);
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

