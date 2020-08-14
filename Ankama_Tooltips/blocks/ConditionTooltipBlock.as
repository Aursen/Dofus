package Ankama_Tooltips.blocks
{
    import Ankama_Tooltips.Api;
    import flash.xml.XMLNode;
    import flash.xml.XMLNodeType;

    public class ConditionTooltipBlock 
    {

        private var _conditions:Object;
        private var _content:String;
        private var _titleText:String;
        private var _onTarget:Boolean;
        private var _block:Object;
        private var _customli:String;
        private var _effectCssClass:String;

        public function ConditionTooltipBlock(conditions:Object, titleText:String=null, onTarget:Boolean=false, chunkType:String="chunks", customli:String="customlirightmargin", effectCssClass:String="requirement")
        {
            this._conditions = conditions;
            this._onTarget = onTarget;
            this._customli = customli;
            this._effectCssClass = effectCssClass;
            if (titleText)
            {
                this._titleText = titleText;
            }
            else
            {
                this._titleText = Api.ui.getText("ui.common.conditions");
            };
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("subTitle", (chunkType + "/base/subTitle.txt")), Api.tooltip.createChunkData("effect", (chunkType + "/effect/effect.txt"))]);
        }

        public function onAllChunkLoaded():void
        {
            var criterion:Object;
            var index:uint;
            var criteriaText:String;
            var criteriaRespected:Boolean;
            var ORindex:int;
            var i:int;
            var firstParenthesisIndex:int;
            var logicOperatorIndex:int;
            var newLineOperator:String;
            var inlineCriteria:Object;
            if ((((this._conditions == null) || (this._conditions.criteria == null)) || (this._conditions.criteria.length == 0)))
            {
                return;
            };
            this._content = this._block.getChunk("subTitle").processContent({"text":this._titleText});
            var tempContent:String = "";
            for each (criterion in this._conditions.criteria)
            {
                index = 0;
                criteriaText = "";
                criteriaRespected = criterion.isRespected;
                ORindex = criterion.text.indexOf("|");
                firstParenthesisIndex = 0;
                logicOperatorIndex = 0;
                i = 0;
                while (i < criterion.inlineCriteria.length)
                {
                    inlineCriteria = criterion.inlineCriteria[i];
                    if (inlineCriteria.text != "")
                    {
                        criteriaText = "";
                        if (index > 0)
                        {
                            if (ORindex > 0)
                            {
                                criteriaText = (Api.ui.getText("ui.common.or") + " ");
                            };
                        };
                        if (this._onTarget)
                        {
                            criteriaText = (("(" + Api.ui.getText("ui.item.target")) + ") ");
                        };
                        if ((((!(criteriaRespected)) && (!(inlineCriteria.isRespected))) && (this._effectCssClass == "requirement")))
                        {
                            this._effectCssClass = "malus";
                            criteriaText = (criteriaText + inlineCriteria.text);
                        }
                        else
                        {
                            criteriaText = (criteriaText + inlineCriteria.text);
                        };
                        if ((((criterion.inlineCriteria.length > 1) && (i == firstParenthesisIndex)) && (this._conditions.operators)))
                        {
                            criteriaText = ("(" + criteriaText);
                        };
                        if (newLineOperator == "|")
                        {
                            criteriaText = ((Api.ui.getText("ui.common.or") + " ") + criteriaText);
                            newLineOperator = "null";
                        }
                        else
                        {
                            if (newLineOperator == "&")
                            {
                                criteriaText = ((Api.ui.getText("ui.common.and") + " ") + criteriaText);
                                newLineOperator = "null";
                            };
                        };
                        if (criterion.inlineCriteria.length > 1)
                        {
                            if ((((!(i == firstParenthesisIndex)) && (i == (criterion.inlineCriteria.length - 1))) && (this._conditions.operators)))
                            {
                                criteriaText = (criteriaText + ")");
                                if (((this._conditions.operators) && (this._conditions.operators.length > logicOperatorIndex)))
                                {
                                    newLineOperator = this._conditions.operators[logicOperatorIndex];
                                };
                                logicOperatorIndex++;
                            };
                        }
                        else
                        {
                            if (((this._conditions.criteria.length > 1) && (this._conditions.operators)))
                            {
                                if (this._conditions.operators[logicOperatorIndex] == "|")
                                {
                                    newLineOperator = this._conditions.operators[logicOperatorIndex];
                                    logicOperatorIndex++;
                                };
                            };
                        };
                        index++;
                    }
                    else
                    {
                        if (i == 0)
                        {
                            firstParenthesisIndex++;
                        };
                    };
                    if (criteriaText)
                    {
                        criteriaText = XML(new XMLNode(XMLNodeType.TEXT_NODE, criteriaText)).toXMLString();
                        tempContent = (tempContent + this._block.getChunk("effect").processContent({
                            "text":criteriaText,
                            "cssClass":this._effectCssClass,
                            "li":"",
                            "customli":this._customli
                        }, {"valueCssClass":"value"}));
                    };
                    i++;
                };
            };
            if (tempContent == "")
            {
                this._content = "";
            }
            else
            {
                this._content = (this._content + tempContent);
            };
        }

        public function getContent():String
        {
            return (this._content);
        }

        public function get block():Object
        {
            return (this._block);
        }


    }
} Ankama_Tooltips.blocks

