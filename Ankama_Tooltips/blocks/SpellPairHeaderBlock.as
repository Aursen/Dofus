package Ankama_Tooltips.blocks
{
    import com.ankamagames.dofus.datacenter.spells.SpellPair;
    import Ankama_Tooltips.Api;

    public class SpellPairHeaderBlock 
    {

        private var _content:String = "";
        private var _block:Object;
        private var _spellPair:SpellPair;
        private var _subtitle:String = null;

        public function SpellPairHeaderBlock(spellPair:SpellPair, subtitle:String=null)
        {
            this._spellPair = spellPair;
            this._subtitle = subtitle;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            if (!this._subtitle)
            {
                this._block.initChunk([Api.tooltip.createChunkData("header", "htmlChunks/text/content.txt")]);
            }
            else
            {
                this._block.initChunk([Api.tooltip.createChunkData("header", "htmlChunks/text/titleWithSubtitle.txt")]);
            };
        }

        public function onAllChunkLoaded():void
        {
            var content:String = this._spellPair.name;
            if (Api.system.getPlayerManager().hasRights)
            {
                content = (content + ((" (" + this._spellPair.id) + ")"));
            };
            if (!this._subtitle)
            {
                this._content = (this._content + this._block.getChunk("header").processContent({
                    "classCss":"spellpair",
                    "content":content
                }));
            }
            else
            {
                this._content = (this._content + this._block.getChunk("header").processContent({
                    "classCss1":"spellpair",
                    "content1":content,
                    "classCss2":"subtitleheader",
                    "content2":this._subtitle
                }));
            };
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

