package Ankama_Tooltips.makers
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blocks.CraftSmileyTooltipBlock;

    public class CraftSmileyTooltipMaker implements ITooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/base.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            tooltip.addBlock(new CraftSmileyTooltipBlock(data).block);
            tooltip.strata = -1;
            return (tooltip);
        }


    }
} Ankama_Tooltips.makers

