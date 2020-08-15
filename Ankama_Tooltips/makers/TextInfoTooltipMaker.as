package Ankama_Tooltips.makers
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blocks.TextInfoTooltipBlock;

    public class TextInfoTooltipMaker implements ITooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/simpleBaseWithBackground.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            tooltip.addBlock(new TextInfoTooltipBlock().block);
            return (tooltip);
        }


    }
}

