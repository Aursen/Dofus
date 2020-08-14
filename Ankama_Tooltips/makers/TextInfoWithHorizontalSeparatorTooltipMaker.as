package Ankama_Tooltips.makers
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blocks.TextInfoWithHorizontalSeparatorTooltipBlock;

    public class TextInfoWithHorizontalSeparatorTooltipMaker implements ITooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt", "chunks/base/container.txt", "chunks/base/empty.txt");
            tooltip.addBlock(new TextInfoWithHorizontalSeparatorTooltipBlock(data).block);
            return (tooltip);
        }


    }
} Ankama_Tooltips.makers

