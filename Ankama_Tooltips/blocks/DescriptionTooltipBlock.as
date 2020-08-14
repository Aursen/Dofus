package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;
    import flash.xml.XMLDocument;

    public class DescriptionTooltipBlock 
    {

        private var _description:String;
        private var _content:String;
        private var _cssClass:String;
        private var _block:Object;
        private var _length:int;

        public function DescriptionTooltipBlock(description:String, cssClass:String="description", chunkType:String="chunks", length:int=412)
        {
            this._description = description;
            this._cssClass = cssClass;
            this._length = length;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("description", (chunkType + "/description/description.txt"))]);
        }

        public function onAllChunkLoaded():void
        {
            var sanitizedText:String;
            if (((this._description.indexOf("<") >= 0) || (this._description.indexOf(">") >= 0)))
            {
                try
                {
                    sanitizedText = Api.util.escapeHTMLDOM(new XMLDocument(this._description).firstChild);
                }
                catch(error:Error)
                {
                    sanitizedText = Api.util.sanitizeText(_description);
                };
            }
            else
            {
                sanitizedText = Api.util.sanitizeText(this._description);
            };
            this._content = this._block.getChunk("description").processContent({
                "description":sanitizedText,
                "cssClass":this._cssClass,
                "length":this._length
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

