package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;
    import com.ankamagames.dofus.datacenter.communication.Smiley;

    public class SmileyTooltipBlock 
    {

        private var _content:String;
        private var _smileyId:uint;
        private var _block:Object;

        public function SmileyTooltipBlock(smileyId:uint)
        {
            this._smileyId = smileyId;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("content", "chunks/smiley/content.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            var smiley:Smiley = Api.data.getSmiley(this._smileyId);
            var uri:String = "";
            if (smiley)
            {
                uri = ("[config.gfx.path]smilies/assets.swf|" + smiley.gfxId);
            };
            this._content = this._block.getChunk("content").processContent({
                "id":this._smileyId,
                "uri":uri
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

