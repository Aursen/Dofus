package Ankama_Tooltips.blocks
{
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import Ankama_Tooltips.Api;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import com.ankama.dofus.enums.ActionIds;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.dofus.datacenter.items.Item;

    public class ItemDetailsBlock 
    {

        private var _content:String;
        private var _contextual:Boolean = false;
        private var _item:ItemWrapper;
        private var _weapon:WeaponWrapper;
        private var _dropResult:Object;
        private var _block:Object;
        private var _params:Object;
        private var sysApi:SystemApi;
        private var playerApi:PlayedCharacterApi;
        private var uiApi:UiApi;
        private var dataApi:DataApi;

        public function ItemDetailsBlock(item:Object, param:Object, chunkType:String="chunks")
        {
            this.addApis();
            if (((item.hasOwnProperty("dropResult")) && (item.dropResult)))
            {
                this._item = (item.itemWrapper as ItemWrapper);
                this._weapon = (item.itemWrapper as WeaponWrapper);
                this._dropResult = item.dropResult;
            }
            else
            {
                this._item = (item as ItemWrapper);
                this._weapon = (item as WeaponWrapper);
                this._dropResult = null;
            };
            if ((param is Boolean))
            {
                this._params = null;
            }
            else
            {
                this._params = param;
            };
            if (param.hasOwnProperty("contextual"))
            {
                this._contextual = param.contextual;
            };
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            var chunkData:Array = [Api.tooltip.createChunkData("details", (chunkType + "/item/details.txt")), Api.tooltip.createChunkData("dropPercentage", (chunkType + "/item/dropPercentage.txt")), Api.tooltip.createChunkData("p", (chunkType + "/text/p.txt"))];
            if (this._item.importantNotice)
            {
                chunkData.push(Api.tooltip.createChunkData("importantNotice", (chunkType + "/item/importantNotice.txt")));
            };
            if (this._item.itemSetId != -1)
            {
                chunkData.push(Api.tooltip.createChunkData("itemSet", (chunkType + "/item/itemSet.txt")));
            };
            this._block.initChunk(chunkData);
        }

        public function onAllChunkLoaded():void
        {
            var chunkParams:Object;
            var itemwrapper:ItemWrapper;
            var leftUseDescription:String;
            var effect:Object;
            this._content = "";
            if (this._item.itemSetId != -1)
            {
                chunkParams = {"itemSet":this._item.itemSet.name};
                this._content = (this._content + this._block.getChunk("itemSet").processContent(chunkParams));
            };
            chunkParams = this.getItemDetailsChunkParams(this._item);
            this._content = (this._content + this._block.getChunk("details").processContent(chunkParams));
            if (((this._item.type) && ((this._item.type.id == DataEnum.ITEM_TYPE_BREEDING_ITEM) || (this._item.type.id == DataEnum.ITEM_TYPE_COMPANION))))
            {
                leftUseDescription = "";
                for each (effect in this._item.effects)
                {
                    if (effect.effectId == ActionIds.ACTION_ITEM_CHANGE_DURABILITY)
                    {
                        leftUseDescription = effect.description;
                        break;
                    };
                };
                if (leftUseDescription)
                {
                    this._content = (this._content + this._block.getChunk("p").processContent({"text":leftUseDescription}));
                };
            };
            if (this._item.isObjectWrapped)
            {
                itemwrapper = this.dataApi.getItemWrapper(this._item.objectGID);
            }
            else
            {
                itemwrapper = this._item;
            };
            if ((((this.sysApi.isInGame()) && (this._params.averagePrice)) && (itemwrapper.exchangeable)))
            {
                this._content = (this._content + this._block.getChunk("p").processContent({"text":Api.averagePrices.getItemAveragePriceString(itemwrapper, false, " <span class='value'>", "</span>")}));
            };
            if ((((this.sysApi.isInGame()) && (this._params.showDropPercentage)) && (this._dropResult)))
            {
                this._content = (this._content + this._block.getChunk("dropPercentage").processContent({"text":this.uiApi.processText(this.uiApi.getText("ui.monster.obtaining.base", (("<span class='value'>" + this.getStringFromValues(this._dropResult.baseDropMinGrade, this._dropResult.baseDropMaxGrade)) + "</span>")), "n")}));
                this._content = (this._content + this._block.getChunk("dropPercentage").processContent({"text":this.uiApi.processText(this.uiApi.getText("ui.monster.obtaining.withBonuses", (("<span class='value'>" + this.getStringFromValues(this._dropResult.dropMinGrade, this._dropResult.dropMaxGrade)) + "</span>")), "n")}));
            };
            if (this._item.importantNotice)
            {
                this._content = (this._content + this._block.getChunk("importantNotice").processContent({"text":this._item.processedImportantNotice}));
            };
            this.removeApis();
        }

        public function getContent():String
        {
            return (this._content);
        }

        public function get block():Object
        {
            return (this._block);
        }

        private function getItemDetailsChunkParams(item:Item):Object
        {
            var chunkParams:Object = new Object();
            chunkParams.category = item.type.name;
            if (((this.sysApi.getBuildType() >= BuildTypeEnum.INTERNAL) && (item.type.id)))
            {
                chunkParams.category = (chunkParams.category + ((" (" + item.type.id) + ")"));
            };
            if (item.twoHanded)
            {
                chunkParams.category = (chunkParams.category + " ( [ui.common.twoHandsWeapon] )");
            };
            if (item.weight > 1)
            {
                chunkParams.weight = this.uiApi.processText(this.uiApi.getText("ui.common.short.weight", this._item.weight), "m", false);
            }
            else
            {
                chunkParams.weight = this.uiApi.processText(this.uiApi.getText("ui.common.short.weight", this._item.weight), "m", true);
            };
            return (chunkParams);
        }

        private function getStringFromValues(valueA:Number, valueB:Number):String
        {
            if (valueA == valueB)
            {
                return ("" + valueA);
            };
            return ((((("" + valueA) + " ") + this.uiApi.getText("ui.chat.to")) + " ") + valueB);
        }

        private function addApis():void
        {
            this.sysApi = Api.system;
            this.playerApi = Api.player;
            this.uiApi = Api.ui;
            this.dataApi = Api.data;
        }

        private function removeApis():void
        {
            this.sysApi = null;
            this.playerApi = null;
            this.uiApi = null;
            this.dataApi = null;
        }


    }
} Ankama_Tooltips.blocks

