package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;

    public class TextTooltipBlock 
    {

        private var _content:String;
        private var _param:Object;
        private var _block:Object;

        public function TextTooltipBlock(txt:String, param:Object=null, chunkType:String="chunks")
        {
            var css:*;
            var cssNameIndex:Number;
            var cssUri:*;
            var tmp:Array;
            super();
            if (param == null)
            {
                this._param = {"css":"[local.css]tooltip_default.css"};
            }
            else
            {
                this._param = param;
            };
            if (!this._param.classCss)
            {
                this._param.classCss = "left";
            };
            if (!this._param.css)
            {
                this._param.css = "[local.css]tooltip_default.css";
            };
            this._param.content = txt;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            if (this._param.width)
            {
                this._block.initChunk([Api.tooltip.createChunkData("content", (chunkType + "/text/fixedContent.txt"))]);
            }
            else
            {
                if (this._param.nameless)
                {
                    this._block.initChunk([Api.tooltip.createChunkData("content", (chunkType + "/text/namelessContent.txt"))]);
                }
                else
                {
                    css = null;
                    cssNameIndex = this._param.css.indexOf("]");
                    cssUri = null;
                    if (cssNameIndex !== -1)
                    {
                        tmp = this._param.css.split("]");
                        if (tmp.length > 1)
                        {
                            css = ((Api.system.getConfigEntry("config.ui.skin") + "css/") + tmp[1]);
                        };
                        if (css)
                        {
                            cssUri = Api.ui.createUri(css);
                        };
                    };
                    this._param.width = (Api.ui.getTextSize(this._param.content, cssUri, this._param.classCss).width + 50);
                    this._block.initChunk([Api.tooltip.createChunkData("content", (chunkType + "/text/content.txt"))]);
                };
            };
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("content").processContent(this._param);
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

