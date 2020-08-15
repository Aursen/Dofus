package Ankama_Tooltips.makers.world
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blocks.SignTooltipBlock;

    public class WorldRpSignTooltipMaker implements ITooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt", "chunks/base/container.txt", "chunks/base/empty.txt");
            tooltip.addBlock(new SignTooltipBlock(data).block);
            return (tooltip);
        }


    }
}

