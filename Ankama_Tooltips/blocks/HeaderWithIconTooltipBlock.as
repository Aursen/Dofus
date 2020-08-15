package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;

    public class HeaderWithIconTooltipBlock 
    {

        private var _block:Object;
        private var _content:String;
        private var _params:Object;
        private var _length:uint;

        public function HeaderWithIconTooltipBlock(params:Object)
        {
            this._params = params;
            this._length = 400;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded2, this.getContent);
            var chunkList:Array = new Array(Api.tooltip.createChunkData("headerIcon", "chunks/item/headerWithIcon.txt"));
            this._block.initChunk(chunkList);
        }

        public function onAllChunkLoaded2():void
        {
            this._content = "";
            this._content = (this._content + this._block.getChunk("headerIcon").processContent({
                "length":this._length,
                "name":this._params.name,
                "iconUri":this._params.iconUri
            }));
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

