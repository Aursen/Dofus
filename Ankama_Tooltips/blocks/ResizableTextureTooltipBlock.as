package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;

    public class ResizableTextureTooltipBlock 
    {

        private var _content:String;
        private var _block:Object;
        private var _uri:String;
        private var _width:Number;
        private var _height:Number;

        public function ResizableTextureTooltipBlock(uri:String, width:Number, height:Number)
        {
            this._uri = uri;
            this._width = width;
            this._height = height;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("simpleTextureContent", "chunks/texture/simpleTextureContent.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("simpleTextureContent").processContent({
                "uri":this._uri,
                "width":this._width,
                "height":this._height
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
} Ankama_Tooltips.blocks

