package Ankama_Tooltips.makers
{
    import com.ankamagames.berilia.interfaces.ITooltipMaker;
    import flash.utils.Dictionary;
    import Ankama_Tooltips.Api;
    import Ankama_Tooltips.blocks.HeaderWithIconTooltipBlock;
    import Ankama_Tooltips.blocks.TextTooltipBlock;
    import Ankama_Tooltips.blocks.ProbaTooltipBlock;
    import Ankama_Tooltips.blocks.DescriptionTooltipBlock;

    public class MysteryBoxTooltipMaker implements ITooltipMaker 
    {

        private static const chunkType:String = "chunks";
        private static const probaRaritiesDescendant:Array = ["LEGENDARY", "EPIC", "RARE", "UNCOMMON", "COMMON", ""];
        private static const probaRaritiesAscendant:Array = ["", "COMMON", "UNCOMMON", "RARE", "EPIC", "LEGENDARY"];

        private var _itemData:*;
        private var _param:Object;
        private var _blockSort:Dictionary = new Dictionary();
        private var _sortingArray:Array;


        public function createTooltip(data:*, param:Object):Object
        {
            var rarity:String;
            this._itemData = data;
            var tooltip:Object = Api.tooltip.createTooltip((chunkType + "/base/pinableWithBackground.txt"), (chunkType + "/base/container.txt"), (chunkType + "/base/separator.txt"));
            tooltip.addBlock(new HeaderWithIconTooltipBlock({
                "name":data.name,
                "iconUri":data.icon
            }).block);
            if (data.probas)
            {
                tooltip.addBlock(new TextTooltipBlock(Api.ui.getText("ui.codesAndGift.mb.possibleContent"), {
                    "css":"[local.css]tooltip_mysterybox.css",
                    "classCss":"subtitle"
                }).block);
                if (!param.sortInBlocks)
                {
                    tooltip.addBlock(new ProbaTooltipBlock(data.probas, param.showProba).block);
                }
                else
                {
                    this.sortInBlocks(data.probas);
                    this._sortingArray = (((param.sorting) && (param.sorting == Array.DESCENDING)) ? probaRaritiesDescendant : probaRaritiesAscendant);
                    for each (rarity in this._sortingArray)
                    {
                        tooltip.addBlock(new ProbaTooltipBlock(this._blockSort[rarity], param.showProba).block);
                    };
                };
            };
            if (param.description != "")
            {
                tooltip.addBlock(new DescriptionTooltipBlock(param.description, "quote", "chunks", 390).block);
            };
            return (tooltip);
        }

        private function sortInBlocks(probas:Array):void
        {
            var proba:Object;
            for each (proba in probas)
            {
                if (!this._blockSort[proba.rarity])
                {
                    this._blockSort[proba.rarity] = [];
                };
                this._blockSort[proba.rarity].push(proba);
            };
        }


    }
} Ankama_Tooltips.makers

