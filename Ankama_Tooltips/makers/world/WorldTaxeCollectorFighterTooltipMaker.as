package Ankama_Tooltips.makers.world
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blocks.TextTooltipBlock;

    public class WorldTaxeCollectorFighterTooltipMaker implements ITooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt", "chunks/base/container.txt", "chunks/base/separator.txt");
            param = {
                "css":"[local.css]tooltip_title.css",
                "classCss":"center"
            };
            if (Api.fight.preFightIsActive())
            {
                tooltip.addBlock(new TextTooltipBlock((((Api.fight.getFighterName(data.contextualId) + " (") + Api.fight.getFighterLevel(data.contextualId)) + ")"), param).block);
            }
            else
            {
                tooltip.addBlock(new TextTooltipBlock((((Api.fight.getFighterName(data.contextualId) + " (") + data.stats.lifePoints) + ")"), param).block);
            };
            return (tooltip);
        }


    }
}

