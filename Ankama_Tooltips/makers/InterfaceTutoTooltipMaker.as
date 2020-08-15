package Ankama_Tooltips.makers
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blocks.InterfaceTutoTooltipBlock;

    public class InterfaceTutoTooltipMaker implements ITooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithButton.txt", "chunks/base/container.txt", "chunks/base/empty.txt");
            tooltip.addBlock(new InterfaceTutoTooltipBlock(data).block);
            return (tooltip);
        }


    }
}

