package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;

    public class BreachRoomTooltipBlock 
    {

        private var _content:String;
        private var _block:Object;
        private var _data:*;

        public function BreachRoomTooltipBlock(data:*)
        {
            this._data = data;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("breachRoom", "chunks/breach/breachRoom.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("breachRoom").processContent(this._data);
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

