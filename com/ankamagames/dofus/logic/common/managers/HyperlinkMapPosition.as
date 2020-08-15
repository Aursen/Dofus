package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.jerakine.data.I18n;
    import flash.geom.Rectangle;
    import com.ankamagames.berilia.types.data.TextTooltipInfo;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.enums.StrataEnum;

    public class HyperlinkMapPosition 
    {

        public static const LEFT_SEPARATOR:String = "[";
        public static const RIGHT_SEPARATOR:String = "]";
        public static const COORDINATES_SEPARATOR:String = ",";
        public static const MAX_ITERATION_COUNT:uint = 1000;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(HyperlinkMapPosition));


        public static function showPosition(posX:int, posY:int, worldMapId:int, elementName:String=""):void
        {
            KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag, ((((("flag_chat_" + posX) + "_") + posY) + "_") + elementName), (((((((elementName != "") ? unescape(elementName) : (I18n.getUiText("ui.cartography.chatFlag") + " ")) + "(") + posX) + ",") + posY) + ")"), worldMapId, posX, posY, 0xFF6600, true);
        }

        public static function getText(posX:int, posY:int, worldMapId:int, elementName:String=""):String
        {
            return (((((unescape(elementName) + LEFT_SEPARATOR) + posX) + COORDINATES_SEPARATOR) + posY) + RIGHT_SEPARATOR);
        }

        public static function rollOver(pX:int, pY:int, posX:int, posY:int, worldMapId:int, elementName:String=""):void
        {
            var target:Rectangle = new Rectangle(pX, pY, 10, 10);
            var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.position"));
            TooltipManager.show(info, target, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "HyperLink", 6, 2, 3, true, null, null, null, null, false, StrataEnum.STRATA_TOOLTIP, 1);
        }

        public static function parseMapLinks(text:String):String
        {
            var currentLeftSeparatorPos:Number;
            var currentRightSeparatorPos:Number;
            var currentPositionX:Number;
            var currentPositionY:Number;
            if (!text)
            {
                return (null);
            };
            var rawText:String = text;
            var processedText:String = "";
            var tmpText:String;
            var tmpArray:Array;
            var iterationCount:uint;
            for (;((rawText) && (iterationCount <= MAX_ITERATION_COUNT));)
            {
                currentLeftSeparatorPos = rawText.indexOf(LEFT_SEPARATOR);
                currentRightSeparatorPos = getRightSeparatorPos(currentLeftSeparatorPos, rawText);
                if (currentLeftSeparatorPos === -1)
                {
                    processedText = (processedText + rawText);
                    iterationCount++;
                    break;
                };
                if (currentRightSeparatorPos === -1)
                {
                    processedText = (processedText + rawText.substr(0, currentLeftSeparatorPos));
                    rawText = rawText.substr((currentLeftSeparatorPos + 1));
                    iterationCount++;
                }
                else
                {
                    processedText = (processedText + rawText.substr(0, currentLeftSeparatorPos));
                    tmpText = rawText.substr((currentLeftSeparatorPos + 1), ((currentRightSeparatorPos - currentLeftSeparatorPos) - 1));
                    if (tmpText)
                    {
                        if (tmpText.indexOf(LEFT_SEPARATOR) !== -1)
                        {
                            processedText = (processedText + LEFT_SEPARATOR);
                            rawText = rawText.substr((currentLeftSeparatorPos + 1));
                            iterationCount++;
                            continue;
                        };
                        tmpArray = tmpText.split(COORDINATES_SEPARATOR);
                        if (((!(tmpArray === null)) && (tmpArray.length === 2)))
                        {
                            currentPositionX = Number(tmpArray[0]);
                            currentPositionY = Number(tmpArray[1]);
                        }
                        else
                        {
                            currentPositionX = (currentPositionY = Number.NaN);
                        };
                        if (((isNaN(currentPositionX)) || (isNaN(currentPositionY))))
                        {
                            processedText = (processedText + rawText.substr(currentLeftSeparatorPos, ((currentRightSeparatorPos - currentLeftSeparatorPos) + 1)));
                        }
                        else
                        {
                            processedText = (processedText + (((((((("{map," + currentPositionX) + ",") + currentPositionY) + ",") + 1) + "::") + rawText.substr(currentLeftSeparatorPos, ((currentRightSeparatorPos - currentLeftSeparatorPos) + 1))) + "}"));
                        };
                    };
                    if (currentRightSeparatorPos < (rawText.length - 1))
                    {
                        rawText = rawText.substr((currentRightSeparatorPos + 1));
                    }
                    else
                    {
                        break;
                    };
                    iterationCount++;
                };
            };
            if (iterationCount > MAX_ITERATION_COUNT)
            {
                _log.error((((("Max iteration count (" + MAX_ITERATION_COUNT.toString()) + ") reached while parsing '") + text) + "'"));
            };
            return (processedText);
        }

        private static function getRightSeparatorPos(startPos:Number, text:String):Number
        {
            if ((((isNaN(startPos)) || (startPos < 0)) || ((!(text)) && ((startPos + 1) > text.length))))
            {
                return (-1);
            };
            var index:Number = (startPos + 1);
            var maxLength:int = text.length;
            var leftSeparatorFoundNumber:int;
            var character:String;
            var indexFound:Number = -1;
            while (index < maxLength)
            {
                character = text.charAt(index);
                if (character === LEFT_SEPARATOR)
                {
                    leftSeparatorFoundNumber++;
                }
                else
                {
                    if (character === RIGHT_SEPARATOR)
                    {
                        if (leftSeparatorFoundNumber > 0)
                        {
                            leftSeparatorFoundNumber--;
                        }
                        else
                        {
                            indexFound = index;
                            break;
                        };
                    };
                };
                index++;
            };
            return (indexFound);
        }


    }
}

