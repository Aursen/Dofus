package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;
    import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
    import com.ankamagames.dofus.network.enums.BreedEnum;

    public class SpellHeaderBlock 
    {

        private static var _shortcutColor:String;

        public var playerApi:Object;
        public var sysApi:Object;
        public var uiApi:Object;
        public var dataApi:Object;
        private var _spellItem:Object;
        private var _content:String = "";
        private var _block:Object;
        private var _param:paramClass;
        private var _shortcutKey:String;

        public function SpellHeaderBlock(spellItem:Object, param:Object=null, chunkType:String="chunk")
        {
            this.addApis();
            this._spellItem = spellItem;
            this._param = new paramClass();
            if (param)
            {
                if (param.hasOwnProperty("smallSpell"))
                {
                    this._param.smallSpell = param.smallSpell;
                };
                if (param.hasOwnProperty("CC_EC"))
                {
                    this._param.CC_EC = param.CC_EC;
                };
                if (param.hasOwnProperty("name"))
                {
                    this._param.name = param.name;
                };
                if (param.hasOwnProperty("contextual"))
                {
                    this._param.contextual = param.contextual;
                };
                if (param.hasOwnProperty("shortcutKey"))
                {
                    this._param.shortcutKey = param.shortcutKey;
                };
                if (param.hasOwnProperty("effects"))
                {
                    this._param.effects = param.effects;
                };
            };
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("header", (chunkType + "/spell/header.txt")), Api.tooltip.createChunkData("details", (chunkType + "/spell/details.txt")), Api.tooltip.createChunkData("detailsCritical", (chunkType + "/spell/detailsCritical.txt")), Api.tooltip.createChunkData("detailsSpellZone", (chunkType + "/spell/detailsSpellZone.txt")), Api.tooltip.createChunkData("detailsEffect", (chunkType + "/spell/detailsEffect.txt")), Api.tooltip.createChunkData("p", (chunkType + "/text/p.txt")), Api.tooltip.createChunkData("separator", (chunkType + "/base/separator.txt"))]);
        }

        private function getSpellHeaderChunkParams(_spellItem:*):Object
        {
            var chunkParams:Object = new Object();
            chunkParams.name = _spellItem.name;
            if (((this._param.shortcutKey) && (!(this._param.shortcutKey == ""))))
            {
                if (!_shortcutColor)
                {
                    _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut").replace("0x", "#");
                };
                chunkParams.name = (chunkParams.name + ((((" <font color='" + _shortcutColor) + "'>(") + this._param.shortcutKey) + ")</font>"));
            };
            chunkParams.rank = "";
            if (this.sysApi.getPlayerManager().hasRights)
            {
                chunkParams.name = (chunkParams.name + ((" (" + _spellItem.id) + ")"));
                chunkParams.rank = (chunkParams.rank + (((this.uiApi.getText("ui.common.rank", (("<span class='value'>" + _spellItem.spellLevelInfos.grade) + "</span>")) + " (") + _spellItem.spellLevelInfos.id) + ")"));
            };
            return (chunkParams);
        }

        private function getSpellDetailsChunkParams(spellItem:*):Object
        {
            var maxRange:int;
            var range:String;
            var chunkParams:Object = new Object();
            chunkParams.apCost = spellItem.apCost;
            if (this._param.contextual)
            {
                maxRange = spellItem.maximalRangeWithBoosts;
            }
            else
            {
                maxRange = spellItem.maximalRange;
            };
            if (spellItem.minimalRange == maxRange)
            {
                range = maxRange.toString();
            }
            else
            {
                range = ((spellItem.minimalRange + " - ") + maxRange);
            };
            chunkParams.range = range;
            if (spellItem.rangeCanBeBoosted)
            {
                chunkParams.range = (chunkParams.range + ((" (" + this.uiApi.getText("ui.spell.rangeBoost")) + ")"));
            };
            return (chunkParams);
        }

        private function getSpellZoneChunkParams(_spellItem:*):Object
        {
            var i:Object;
            var areaText:String;
            var chunkParams:Object = new Object();
            var zoneEffect:Object = _spellItem.spellZoneEffects[0];
            var ray:uint = zoneEffect.zoneSize;
            for each (i in _spellItem.spellZoneEffects)
            {
                if (((((_spellItem.spellLevelInfos.effects[_spellItem.spellZoneEffects.indexOf(i)].visibleInTooltip) && (!(i.zoneShape == 0))) && (i.zoneSize < 63)) && (((i.zoneSize > ray) || ((i.zoneSize == ray) && (zoneEffect.zoneShape == SpellShapeEnum.P))) || (!(_spellItem.spellLevelInfos.effects[_spellItem.spellZoneEffects.indexOf(zoneEffect)].visibleInTooltip)))))
                {
                    ray = i.zoneSize;
                    zoneEffect = i;
                };
            };
            switch (zoneEffect.zoneShape)
            {
                case SpellShapeEnum.minus:
                    areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.diagonal", zoneEffect.zoneSize), "m", (zoneEffect.zoneSize <= 1));
                    break;
                case SpellShapeEnum.A:
                case SpellShapeEnum.a:
                    areaText = this.uiApi.getText("ui.spellarea.everyone");
                    break;
                case SpellShapeEnum.C:
                    if (zoneEffect.zoneSize == 63)
                    {
                        areaText = this.uiApi.getText("ui.spellarea.everyone");
                    }
                    else
                    {
                        areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.circle", zoneEffect.zoneSize), "m", (zoneEffect.zoneSize <= 1));
                    };
                    break;
                case SpellShapeEnum.D:
                    areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.chessboard", zoneEffect.zoneSize), "m", (zoneEffect.zoneSize <= 1));
                    break;
                case SpellShapeEnum.L:
                    areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.line", (zoneEffect.zoneSize + 1)), "m", (zoneEffect.zoneSize <= 1));
                    break;
                case SpellShapeEnum.O:
                    areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.ring", zoneEffect.zoneSize), "m", (zoneEffect.zoneSize <= 1));
                    break;
                case SpellShapeEnum.Q:
                    areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.crossVoid", zoneEffect.zoneSize), "m", (zoneEffect.zoneSize <= 1));
                    break;
                case SpellShapeEnum.T:
                    areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.tarea", zoneEffect.zoneSize), "m", (zoneEffect.zoneSize <= 1));
                    break;
                case SpellShapeEnum.U:
                    areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.halfcircle", zoneEffect.zoneSize), "m", (zoneEffect.zoneSize <= 1));
                    break;
                case SpellShapeEnum.V:
                    areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.cone", zoneEffect.zoneSize), "m", (zoneEffect.zoneSize <= 1));
                    break;
                case SpellShapeEnum.X:
                    areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.cross", zoneEffect.zoneSize), "m", (zoneEffect.zoneSize <= 1));
                    break;
                case SpellShapeEnum.G:
                    areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.square", zoneEffect.zoneSize), "m", (zoneEffect.zoneSize <= 1));
                    break;
                case SpellShapeEnum.plus:
                    areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.plus", zoneEffect.zoneSize), "m", (zoneEffect.zoneSize <= 1));
                    break;
                case SpellShapeEnum.star:
                    areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.star", zoneEffect.zoneSize), "m", (zoneEffect.zoneSize <= 1));
                    break;
                case SpellShapeEnum.P:
            };
            chunkParams.spellZone = areaText;
            return (chunkParams);
        }

        public function onAllChunkLoaded():void
        {
            var chunkParams:Object;
            var criticalRate:int;
            var showCriticalRate:Boolean;
            var criticalPercent:int;
            var state:int;
            var spellState:Object;
            this._content = "";
            if (this._param.name)
            {
                chunkParams = this.getSpellHeaderChunkParams(this._spellItem);
                this._content = (this._content + this._block.getChunk("header").processContent(chunkParams));
                this._content = (this._content + this._block.getChunk("separator").processContent({}));
            };
            chunkParams = this.getSpellDetailsChunkParams(this._spellItem);
            this._content = (this._content + this._block.getChunk("details").processContent(chunkParams));
            if (this._param.CC_EC)
            {
                if (this._param.contextual)
                {
                    criticalRate = this._spellItem.playerCriticalRate;
                }
                else
                {
                    criticalRate = this._spellItem.criticalHitProbability;
                };
                showCriticalRate = (!(this._spellItem.spellLevelInfos.criticalHitProbability == 0));
                if (criticalRate > 55)
                {
                    criticalRate = 55;
                };
                criticalPercent = int((55 - (1 / (1 / criticalRate))));
                if (criticalPercent > 100)
                {
                    criticalPercent = 100;
                };
                if (showCriticalRate)
                {
                    this._content = (this._content + this._block.getChunk("detailsCritical").processContent({"critical":(criticalPercent + "%")}));
                };
            };
            chunkParams = this.getSpellZoneChunkParams(this._spellItem);
            if (chunkParams.spellZone)
            {
                this._content = (this._content + this._block.getChunk("detailsSpellZone").processContent(chunkParams));
            };
            if (this._param.effects)
            {
                if ((((this._spellItem.spellBreed) && (this._spellItem.spellBreed <= BreedEnum.Ouginak)) && (!(this._param.smallSpell))))
                {
                    this._content = (this._content + this._block.getChunk("detailsEffect").processContent({
                        "text":(Api.ui.getText("ui.common.breedSpell") + Api.ui.getText("ui.common.colon")),
                        "value":this.dataApi.getBreed(this._spellItem.spellBreed).shortName
                    }));
                };
                if (((this._spellItem.castInLine) && (this._spellItem.range)))
                {
                    this._content = (this._content + this._block.getChunk("p").processContent({"text":this.uiApi.getText("ui.spellInfo.castInLine")}));
                };
                if (((this._spellItem.castInDiagonal) && (this._spellItem.range)))
                {
                    this._content = (this._content + this._block.getChunk("p").processContent({"text":this.uiApi.getText("ui.spellInfo.castInDiagonal")}));
                };
                if ((((this._spellItem.maximalRange > 1) && (!(this._spellItem.castTestLos))) && (this._spellItem.range)))
                {
                    this._content = (this._content + this._block.getChunk("p").processContent({"text":this.uiApi.getText("ui.spellInfo.castWithoutLos")}));
                };
                if (this._spellItem.needTakenCell)
                {
                    this._content = (this._content + this._block.getChunk("p").processContent({"text":this.uiApi.getText("ui.spellInfo.castNeedTakenCell")}));
                };
                if (this._spellItem.maxCastPerTarget)
                {
                    this._content = (this._content + this._block.getChunk("detailsEffect").processContent({
                        "text":(this.uiApi.getText("ui.spellInfo.maxCastPerTarget") + Api.ui.getText("ui.common.colon")),
                        "value":this._spellItem.maxCastPerTarget
                    }));
                };
                if (this._spellItem.maxStack > 0)
                {
                    this._content = (this._content + this._block.getChunk("detailsEffect").processContent({
                        "text":(this.uiApi.getText("ui.spellInfo.maxStack") + Api.ui.getText("ui.common.colon")),
                        "value":this._spellItem.maxStack
                    }));
                };
                if (this._spellItem.maxCastPerTurn)
                {
                    this._content = (this._content + this._block.getChunk("p").processContent({"text":this.uiApi.processText(this.uiApi.getText("ui.item.usePerTurn", (("<span class='value'>" + this._spellItem.maxCastPerTurn) + "</span>")), "n", (this._spellItem.maxCastPerTurn <= 1))}));
                };
                if (this._spellItem.minCastInterval)
                {
                    this._content = (this._content + this._block.getChunk("detailsEffect").processContent({
                        "text":(this.uiApi.getText("ui.spellInfo.minCastInterval") + Api.ui.getText("ui.common.colon")),
                        "value":this._spellItem.minCastInterval
                    }));
                };
                if (this._spellItem.globalCooldown)
                {
                    if (this._spellItem.globalCooldown == -1)
                    {
                        this._content = (this._content + this._block.getChunk("p").processContent({"text":this.uiApi.getText("ui.spellInfo.globalCastInterval")}));
                    }
                    else
                    {
                        this._content = (this._content + this._block.getChunk("detailsEffect").processContent({
                            "text":(this.uiApi.getText("ui.spellInfo.globalCastInterval") + Api.ui.getText("ui.common.colon")),
                            "value":this._spellItem.globalCooldown
                        }));
                    };
                };
                if (this._spellItem.statesRequired.length > 0)
                {
                    for each (state in this._spellItem.statesRequired)
                    {
                        spellState = this.dataApi.getSpellState(state);
                        if (!spellState.isSilent)
                        {
                            this._content = (this._content + this._block.getChunk("detailsEffect").processContent({
                                "text":(this.uiApi.getText("ui.spellInfo.stateRequired") + Api.ui.getText("ui.common.colon")),
                                "value":spellState.name
                            }));
                        };
                    };
                };
                if (this._spellItem.statesForbidden.length > 0)
                {
                    for each (state in this._spellItem.statesForbidden)
                    {
                        spellState = this.dataApi.getSpellState(state);
                        if (!spellState.isSilent)
                        {
                            this._content = (this._content + this._block.getChunk("detailsEffect").processContent({
                                "text":(this.uiApi.getText("ui.spellInfo.stateForbidden") + Api.ui.getText("ui.common.colon")),
                                "value":spellState.name
                            }));
                        };
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

        private function addApis():void
        {
            this.sysApi = Api.system;
            this.uiApi = Api.ui;
            this.dataApi = Api.data;
            this.playerApi = Api.player;
        }

        private function removeApis():void
        {
            this.sysApi = null;
            this.uiApi = null;
            this.playerApi = null;
            this.dataApi = null;
        }


    }
} Ankama_Tooltips.blocks

class paramClass 
{

    public var contextual:Boolean = false;
    public var smallSpell:Boolean = false;
    public var CC_EC:Boolean = true;
    public var name:Boolean = true;
    public var effects:Boolean = true;
    public var shortcutKey:String;


}


