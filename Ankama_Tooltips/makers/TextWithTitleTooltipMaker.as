package Ankama_Tooltips.makers
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blocks.TitleTooltipBlock;
    import Ankama_Tooltips.blocks.TextTooltipBlock;

    public class TextWithTitleTooltipMaker implements ITooltipMaker 
    {

        private const chunkType:String = "htmlChunks";


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip((this.chunkType + "/base/baseWithBackground.txt"), (this.chunkType + "/base/container.txt"));
            tooltip.chunkType = this.chunkType;
            tooltip.addBlock(new TitleTooltipBlock(data.title).block);
            tooltip.addBlock(new TextTooltipBlock(data.text, null, this.chunkType).block);
            return (tooltip);
        }


    }
} Ankama_Tooltips.makers

