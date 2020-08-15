package Ankama_Tooltips.makers
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blocks.ResizableTextureTooltipBlock;

    public class SlotTextureTooltipMaker implements ITooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var bg:String = "chunks/base/baseWithSlotBackground.txt";
            var tooltip:Object = Api.tooltip.createTooltip(bg, "chunks/base/container.txt");
            tooltip.addBlock(new ResizableTextureTooltipBlock(data.uri, data.width, data.height).block);
            tooltip.strata = -1;
            return (tooltip);
        }


    }
}

