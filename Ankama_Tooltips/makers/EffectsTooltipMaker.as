package Ankama_Tooltips.makers
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blocks.TextTooltipBlock;
    import Ankama_Tooltips.blockParams.EffectsTooltipBlockParameters;
    import Ankama_Tooltips.blocks.EffectsTooltipBlock;

    public class EffectsTooltipMaker implements ITooltipMaker 
    {


        public function createTooltip(data:*, param:Object):Object
        {
            var bg:String;
            if (((param) && (param.noBg)))
            {
                bg = "chunks/base/base.txt";
            }
            else
            {
                bg = "chunks/base/baseWithBackground.txt";
            };
            var tooltip:Object = Api.tooltip.createTooltip(bg, "chunks/base/container.txt", "chunks/base/separator.txt");
            var effects:Object = data;
            tooltip.addBlock(new TextTooltipBlock(effects.spellName, {"css":"[local.css]tooltip_title.css"}).block);
            tooltip.addBlock(new TextTooltipBlock(((Api.ui.getText("ui.fight.caster") + Api.ui.getText("ui.common.colon")) + data.casterName), {"css":"[local.css]tooltip_default.css"}).block);
            var effectsTooltipBlockParams:EffectsTooltipBlockParameters = EffectsTooltipBlockParameters.create(effects.effects);
            effectsTooltipBlockParams.showTheoreticalEffects = false;
            effectsTooltipBlockParams.fromBuff = ((data.hasOwnProperty("fromBuff")) ? data.fromBuff : false);
            tooltip.addBlock(new EffectsTooltipBlock(effectsTooltipBlockParams).block);
            return (tooltip);
        }


    }
} Ankama_Tooltips.makers

