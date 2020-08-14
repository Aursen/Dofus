package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;

    public class InterfaceTutoTooltipBlock 
    {

        private var _data:*;
        private var _content:String;
        private var _block:Object;
        private var _blocks:Array;

        public function InterfaceTutoTooltipBlock(data:*)
        {
            this._data = data;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._blocks = new Array();
            this._blocks.push(Api.tooltip.createChunkData("content", "chunks/tutorial/interfaceTuto.txt"));
            this._blocks.push(Api.tooltip.createChunkData("labelContent", "chunks/tutorial/interfaceTutoLabel.txt"));
            if ((((this._data.hasOwnProperty("hint_tooltip_url")) && (!(this._data.hint_tooltip_url == null))) && (!(this._data.hint_tooltip_url == ""))))
            {
                this._blocks.push(Api.tooltip.createChunkData("textureContent", "chunks/tutorial/interfaceTutoTexture.txt"));
            };
            if (((this._data.hasOwnProperty("hint_tooltip_guided")) && (this._data.hint_tooltip_guided)))
            {
                this._blocks.push(Api.tooltip.createChunkData("buttonContent", "chunks/tutorial/interfaceTutoButton.txt"));
            }
            else
            {
                if (!this._data.hasOwnProperty("hint_tooltip_guided"))
                {
                    this._blocks.push(Api.tooltip.createChunkData("buttonContent", "chunks/tutorial/interfaceTutoDisplayHelp.txt"));
                };
            };
            this._block.initChunk(this._blocks);
        }

        public function onAllChunkLoaded():void
        {
            var dataContent:Object = new Object();
            dataContent.labelContent = this._block.getChunk("labelContent").processContent(null);
            if ((((this._data.hasOwnProperty("hint_tooltip_url")) && (!(this._data.hint_tooltip_url == null))) && (!(this._data.hint_tooltip_url == ""))))
            {
                dataContent.textureContent = this._block.getChunk("textureContent").processContent(null);
            };
            if (((!(this._data.hasOwnProperty("hint_tooltip_guided"))) || (this._data.hint_tooltip_guided)))
            {
                dataContent.buttonContent = this._block.getChunk("buttonContent").processContent(null);
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

