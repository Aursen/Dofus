package Ankama_Tooltips.makers
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blocks.TextWithTextureTooltipBlock;

    public class TextWithTextureTooltipMaker implements ITooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt", "chunks/base/container.txt", "chunks/base/empty.txt");
            tooltip.addBlock(new TextWithTextureTooltipBlock(data).block);
            return (tooltip);
        }


    }
}

