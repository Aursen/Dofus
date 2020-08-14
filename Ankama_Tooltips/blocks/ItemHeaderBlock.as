package Ankama_Tooltips.blocks
{
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.berilia.api.UiApi;
    import Ankama_Tooltips.Api;
    import com.ankamagames.dofus.datacenter.items.Item;
    import com.ankama.dofus.enums.ActionIds;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;

    public class ItemHeaderBlock 
    {

        private var _content:String;
        private var _block:Object;
        private var _item:ItemWrapper;
        private var _weapon:WeaponWrapper;
        private var _contextual:Boolean = false;
        private var _showTitleAndIcon:Boolean = true;
        private var sysApi:SystemApi;
        private var playerApi:PlayedCharacterApi;
        private var uiApi:UiApi;

        public function ItemHeaderBlock(item:Item, param:Object, chunkType:String="chunks")
        {
            this.addApis();
            this._item = (item as ItemWrapper);
            this._weapon = (item as WeaponWrapper);
            if (param.hasOwnProperty("contextual"))
            {
                this._contextual = param.contextual;
            };
            if (param.hasOwnProperty("header"))
            {
                this._showTitleAndIcon = param.header;
            };
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            var chunkData:Array = [Api.tooltip.createChunkData("separator", (chunkType + "/base/separator.txt"))];
            if (this._showTitleAndIcon)
            {
                chunkData.push(Api.tooltip.createChunkData("header", (chunkType + "/item/header.txt")));
            };
            if (this._weapon)
            {
                chunkData.push(Api.tooltip.createChunkData("weaponDetails", (chunkType + "/item/weaponDetails.txt")));
            };
            if (this._item.etheral)
            {
                chunkData.push(Api.tooltip.createChunkData("p", (chunkType + "/text/p.txt")));
            };
            this._block.initChunk(chunkData);
        }

        public function onAllChunkLoaded():void
        {
            var effect:Object;
            var chunkParams:Object = this.getItemHeaderChunkParams(this._item);
            this._content = "";
            if (this._showTitleAndIcon)
            {
                this._content = (this._content + this._block.getChunk("header").processContent(chunkParams));
            };
            if (this._weapon)
            {
                if (this._content)
                {
                    this._content = (this._content + this._block.getChunk("separator").processContent({}));
                };
                chunkParams = this.getWeaponDetailsChunkParams(this._weapon);
                this._content = (this._content + this._block.getChunk("weaponDetails").processContent(chunkParams));
            };
            if (this._item.etheral)
            {
                for each (effect in this._item.effects)
                {
                    if (effect.effectId == ActionIds.ACTION_ITEM_CHANGE_DURABILITY)
                    {
                        this._content = (this._content + this._block.getChunk("p").processContent({"text":("[ui.common.ethereal], " + effect.description)}));
                        break;
                    };
                };
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

        private function getItemHeaderChunkParams(item:Item):Object
        {
            var chunkParams:Object = new Object();
            chunkParams.name = this._item.name;
            if (this.sysApi.getPlayerManager().hasRights)
            {
                chunkParams.name = (chunkParams.name + ((" (" + this._item.objectGID) + ")"));
            };
            var uidForDebug:String = "";
            if (((this.sysApi.getPlayerManager().hasRights) && (this.sysApi.getBuildType() > BuildTypeEnum.TESTING)))
            {
                uidForDebug = (uidForDebug + ((" (uid : " + this._item.objectUID) + ")"));
            };
            chunkParams.level = (this._item.level + uidForDebug);
            var characterInfo:* = this.playerApi.getPlayedCharacterInfo();
            var cssLvlClassName:String = "headerp";
            var itemIsResource:* = (this._item.category == 2);
            var itemIsConsumable:* = (this._item.category == 1);
            if (((((!(itemIsResource)) && (!(itemIsConsumable))) && (characterInfo)) && (characterInfo.level < this._item.level)))
            {
                cssLvlClassName = "headermalus";
            };
            chunkParams.cssLvl = cssLvlClassName;
            return (chunkParams);
        }

        private function getWeaponDetailsChunkParams(weapon:WeaponWrapper):Object
        {
            var sign:String;
            var playerCharacteristics:CharacterCharacteristicsInformations;
            var criticalHit:Object;
            var totalCriticalHit:int;
            var criticalRate:int;
            var criticalPercent:int;
            var chunkParams:Object = new Object();
            chunkParams.apCost = weapon.apCost;
            var weaponRange:String = ((weapon.minRange == weapon.range) ? weapon.range.toString() : ((weapon.minRange + " - ") + weapon.range));
            chunkParams.range = weaponRange;
            chunkParams.critical = "";
            if (((weapon.criticalFailureProbability) || (weapon.criticalHitProbability)))
            {
                if (weapon.criticalHitProbability)
                {
                    if (weapon.criticalHitBonus > 0)
                    {
                        sign = "+";
                    }
                    else
                    {
                        if (weapon.criticalHitBonus < 0)
                        {
                            sign = "-";
                        };
                    };
                    playerCharacteristics = this.playerApi.characteristics();
                    if (((!(this._contextual)) || (!(playerCharacteristics))))
                    {
                        chunkParams.critical = (chunkParams.critical + (weapon.criticalHitProbability + "%"));
                    }
                    else
                    {
                        criticalHit = playerCharacteristics.criticalHit;
                        totalCriticalHit = (((criticalHit.alignGiftBonus + criticalHit.base) + criticalHit.contextModif) + criticalHit.objectsAndMountBonus);
                        criticalRate = ((55 - weapon.criticalHitProbability) - totalCriticalHit);
                        if (criticalRate > 55)
                        {
                            criticalRate = 55;
                        };
                        criticalPercent = int((55 - (1 / (1 / criticalRate))));
                        if (criticalPercent > 100)
                        {
                            criticalPercent = 100;
                        };
                        chunkParams.critical = (chunkParams.critical + (criticalPercent + "%"));
                    };
                    if (sign)
                    {
                        chunkParams.critical = (chunkParams.critical + (((((" ( " + sign) + weapon.criticalHitBonus) + " ") + this.uiApi.getText("ui.stats.damagesBonus")) + " )"));
                    };
                };
            }
            else
            {
                chunkParams.critical = (chunkParams.critical + "-");
            };
            if (((weapon.castInLine) && (weapon.range > 1)))
            {
                chunkParams.specialRange = (("<p>" + this.uiApi.getText("ui.spellInfo.castInLine")) + "</p>");
            }
            else
            {
                if (((weapon.castInDiagonal) && (weapon.range > 1)))
                {
                    chunkParams.specialRange = (("<p>" + this.uiApi.getText("ui.spellInfo.castInDiagonal")) + "</p>");
                }
                else
                {
                    chunkParams.specialRange = "";
                };
            };
            if (weapon.maxCastPerTurn)
            {
                chunkParams.useLimits = this.uiApi.processText(this.uiApi.getText("ui.item.usePerTurn", (("<span class='value'>" + weapon.maxCastPerTurn) + "</span>")), "n", (weapon.maxCastPerTurn <= 1), (weapon.maxCastPerTurn == 0));
            };
            return (chunkParams);
        }

        private function addApis():void
        {
            this.sysApi = Api.system;
            this.playerApi = Api.player;
            this.uiApi = Api.ui;
        }

        private function removeApis():void
        {
            this.sysApi = null;
            this.playerApi = null;
            this.uiApi = null;
        }


    }
} Ankama_Tooltips.blocks

