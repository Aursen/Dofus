package Ankama_Tooltips.makers
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blocks.TextureTooltipBlock;

    public class TexturesListTooltipMaker implements ITooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var uri:*;
            var bg:String = "chunks/base/base.txt";
            var tooltip:Object = Api.tooltip.createTooltip(bg, "chunks/base/linearContainer.txt");
            var texturesList:Object = data;
            for each (uri in texturesList)
            {
                tooltip.addBlock(new TextureTooltipBlock(uri).block);
            };
            tooltip.strata = -1;
            return (tooltip);
        }


    }
}

