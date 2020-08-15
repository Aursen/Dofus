package Ankama_Tooltips.makers.world
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import Ankama_Tooltips.Api;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import Ankama_Tooltips.blocks.FightTooltipBlock;

    public class WorldRpFightTooltipMaker implements ITooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var totalLevel:uint;
            var fighter:*;
            var teamMembers:* = data.fighters;
            var tooltip:Object = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt", "chunks/base/container.txt", "chunks/base/empty.txt");
            var infos:Object = new Object();
            var textList:String = "";
            for each (fighter in teamMembers)
            {
                if (((fighter.id > 0) && (fighter.level > ProtocolConstantsEnum.MAX_LEVEL)))
                {
                    totalLevel = (totalLevel + ProtocolConstantsEnum.MAX_LEVEL);
                }
                else
                {
                    totalLevel = (totalLevel + fighter.level);
                };
            };
            infos.level = ((Api.ui.getText("ui.common.level") + " ") + totalLevel);
            tooltip.addBlock(new FightTooltipBlock(infos).block);
            return (tooltip);
        }


    }
}

