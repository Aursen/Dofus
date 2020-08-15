package Ankama_Tooltips.makers
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blocks.ConditionTooltipBlock;

    public class SellCriterionTooltipMaker implements ITooltipMaker 
    {

        private static const chunkType:String = "htmlChunks";


        public function createTooltip(data:*, param:Object):Object
        {
            var bg:* = (chunkType + "/base/baseWithBackground.txt");
            var tooltip:Object = Api.tooltip.createTooltip(bg, (chunkType + "/base/container.txt"), (chunkType + "/base/separator.txt"));
            tooltip.chunkType = chunkType;
            tooltip.addBlock(new ConditionTooltipBlock({"criteria":[data]}, Api.ui.getText("ui.sell.condition"), false, chunkType).block);
            return (tooltip);
        }


    }
}

