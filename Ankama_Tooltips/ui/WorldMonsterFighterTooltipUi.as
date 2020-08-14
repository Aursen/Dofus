package Ankama_Tooltips.ui
{
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import Ankama_Tooltips.Api;

    public class WorldMonsterFighterTooltipUi extends AbstractWorldFighterTooltipUi 
    {


        override public function updateContent(oParam:Object):void
        {
            var m:Monster;
            var firstInit:* = (lbl_name.textHeight == 0);
            beforeLevelText = "";
            var monsterId:int = Api.fight.getMonsterId(oParam.data.contextualId);
            if (monsterId > -1)
            {
                m = Api.data.getMonsterFromId(monsterId);
                if (m.isBoss)
                {
                    beforeLevelText = Api.ui.getText("ui.item.boss");
                }
                else
                {
                    if (m.isMiniBoss)
                    {
                        beforeLevelText = Api.ui.getText("ui.item.miniboss");
                    };
                };
            };
            if (beforeLevelText != "")
            {
                beforeLevelText = (beforeLevelText + (" " + Api.ui.getText("ui.common.short.level")));
            }
            else
            {
                beforeLevelText = (beforeLevelText + Api.ui.getText("ui.common.level"));
            };
            super.updateContent(oParam);
            if (firstInit)
            {
                backgroundCtr.height = (backgroundCtr.height - Y_PADDING);
                mainCtr.height = (mainCtr.height - Y_PADDING);
            };
        }


    }
} Ankama_Tooltips.ui

