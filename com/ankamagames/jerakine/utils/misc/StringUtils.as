package com.ankamagames.jerakine.utils.misc
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.I18n;
    import flash.xml.XMLNode;
    import flash.xml.XMLNodeType;
    import __AS3__.vec.*;

    public class StringUtils 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StringUtils));
        private static var pattern:Dictionary;
        private static var accents:String = "ŠŒŽšœžÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜŸÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýÿþ";


        public static function cleanString(s:String):String
        {
            s = s.split("&").join("&amp;");
            s = s.split("<").join("&lt;");
            s = s.split(">").join("&gt;");
            return (s);
        }

        public static function convertLatinToUtf(str:String):String
        {
            var b:ByteArray = new ByteArray();
            b.writeMultiByte(decodeURI(str), "iso-8859-1");
            b.position = 0;
            return (b.readUTFBytes(b.length));
        }

        public static function fill(str:String, len:uint, _arg_3:String, before:Boolean=true):String
        {
            if (((!(_arg_3)) || (!(_arg_3.length))))
            {
                return (str);
            };
            while (str.length != len)
            {
                if (before)
                {
                    str = (_arg_3 + str);
                }
                else
                {
                    str = (str + _arg_3);
                };
            };
            return (str);
        }

        public static function formatArray(data:Array, header:Array=null):String
        {
            var row:*;
            var i:*;
            var lenIndex:*;
            var headerLine:Array;
            var headerSubLine:Array;
            var line:Array;
            var str:String;
            var colSep:String = " | ";
            var headerColSep:String = "-+-";
            var spaces:String = "                                                                                                               ";
            var headerSep:String = "---------------------------------------------------------------------------------------------------------------";
            var length:Array = [];
            var result:Array = [];
            for each (row in data)
            {
                for (i in row)
                {
                    lenIndex = ((header) ? header[i] : i);
                    length[lenIndex] = ((isNaN(length[lenIndex])) ? String(row[i]).length : Math.max(length[lenIndex], String(row[i]).length));
                };
            };
            if (((i is String) || (header)))
            {
                headerLine = [];
                headerSubLine = [];
                row = ((header) ? header : row);
                for (i in row)
                {
                    lenIndex = ((header) ? header[i] : i);
                    length[lenIndex] = ((isNaN(length[lenIndex])) ? lenIndex.length : Math.max(length[lenIndex], lenIndex.length));
                    headerLine.push((lenIndex + spaces.substr(0, (length[lenIndex] - lenIndex.length))));
                    headerSubLine.push(headerSep.substr(0, length[lenIndex]));
                };
                result.push(headerLine.join(colSep));
                result.push(headerSubLine.join(headerColSep));
            };
            for each (row in data)
            {
                line = [];
                for (i in row)
                {
                    str = row[i];
                    lenIndex = ((header) ? header[i] : i);
                    line.push((str + spaces.substr(0, (length[lenIndex] - String(str).length))));
                };
                result.push(line.join(colSep));
            };
            return (result.join("\n"));
        }

        public static function replace(src:String, pattern:*=null, replacement:*=null):String
        {
            var i:uint;
            var r:String;
            if (!pattern)
            {
                return (src);
            };
            if (!replacement)
            {
                if ((pattern is Array))
                {
                    replacement = new Array(pattern.length);
                }
                else
                {
                    return (src.split(pattern).join(""));
                };
            };
            if (!(pattern is Array))
            {
                return (src.split(pattern).join(replacement));
            };
            var patternLength:Number = pattern.length;
            var result:String = src;
            if ((replacement is Array))
            {
                i = 0;
                while (i < patternLength)
                {
                    r = "";
                    if (replacement.length > i)
                    {
                        r = replacement[i];
                    };
                    result = result.split(pattern[i]).join(r);
                    i++;
                };
            }
            else
            {
                i = 0;
                while (i < patternLength)
                {
                    result = result.split(pattern[i]).join(replacement);
                    i++;
                };
            };
            return (result);
        }

        public static function concatSameString(pString:String, pStringToConcat:String):String
        {
            var firstIndex:int = pString.indexOf(pStringToConcat);
            var previousIndex:int;
            var currentIndex:int = firstIndex;
            while (currentIndex != -1)
            {
                previousIndex = currentIndex;
                currentIndex = pString.indexOf(pStringToConcat, (previousIndex + 1));
                if (currentIndex == firstIndex)
                {
                    break;
                };
                if (currentIndex == (previousIndex + pStringToConcat.length))
                {
                    pString = (pString.substring(0, currentIndex) + pString.substring((currentIndex + pStringToConcat.length)));
                    currentIndex = (currentIndex - pStringToConcat.length);
                };
            };
            return (pString);
        }

        public static function getDelimitedText(pText:String, pFirstDelimiter:String, pSecondDelimiter:String, pIncludeDelimiter:Boolean=false):Vector.<String>
        {
            var delimitedText:String;
            var firstPart:String;
            var secondPart:String;
            var returnedArray:Vector.<String> = new Vector.<String>();
            var exit:Boolean;
            var text:String = pText;
            while ((!(exit)))
            {
                delimitedText = getSingleDelimitedText(text, pFirstDelimiter, pSecondDelimiter, pIncludeDelimiter);
                if (delimitedText == "")
                {
                    exit = true;
                }
                else
                {
                    returnedArray.push(delimitedText);
                    if (!pIncludeDelimiter)
                    {
                        delimitedText = ((pFirstDelimiter + delimitedText) + pSecondDelimiter);
                    };
                    firstPart = text.slice(0, text.indexOf(delimitedText));
                    while (firstPart.indexOf(pFirstDelimiter) != -1)
                    {
                        firstPart = firstPart.replace(pFirstDelimiter, "");
                    };
                    secondPart = text.slice((text.indexOf(delimitedText) + delimitedText.length));
                    text = (firstPart + secondPart);
                };
            };
            return (returnedArray);
        }

        public static function getAllIndexOf(pStringLookFor:String, pWholeString:String):Array
        {
            var nextIndex:int;
            var returnedArray:Array = new Array();
            var usage:uint;
            var exit:Boolean;
            var currentIndex:uint;
            while ((!(exit)))
            {
                nextIndex = pWholeString.indexOf(pStringLookFor, currentIndex);
                if (nextIndex < currentIndex)
                {
                    exit = true;
                }
                else
                {
                    returnedArray.push(nextIndex);
                    currentIndex = (nextIndex + pStringLookFor.length);
                };
            };
            return (returnedArray);
        }

        public static function noAccent(source:String):String
        {
            if (pattern == null)
            {
                initPattern();
            };
            return (decomposeUnicode(source));
        }

        private static function initPattern():void
        {
            pattern = new Dictionary(true);
            pattern["Š"] = "S";
            pattern["Œ"] = "Oe";
            pattern["Ž"] = "Z";
            pattern["š"] = "s";
            pattern["œ"] = "oe";
            pattern["ž"] = "z";
            pattern["À"] = "A";
            pattern["Á"] = "A";
            pattern["Â"] = "A";
            pattern["Ã"] = "A";
            pattern["Ä"] = "A";
            pattern["Å"] = "A";
            pattern["Æ"] = "Ae";
            pattern["Ç"] = "C";
            pattern["È"] = "E";
            pattern["É"] = "E";
            pattern["Ê"] = "E";
            pattern["Ë"] = "E";
            pattern["Ì"] = "I";
            pattern["Í"] = "I";
            pattern["Î"] = "I";
            pattern["Ï"] = "I";
            pattern["Ð"] = "D";
            pattern["Ñ"] = "N";
            pattern["Ò"] = "O";
            pattern["Ó"] = "O";
            pattern["Ô"] = "O";
            pattern["Õ"] = "O";
            pattern["Ö"] = "O";
            pattern["Ø"] = "O";
            pattern["Ù"] = "U";
            pattern["Ú"] = "U";
            pattern["Û"] = "U";
            pattern["Ü"] = "U";
            pattern["Ÿ"] = "Y";
            pattern["Ý"] = "Y";
            pattern["Þ"] = "Th";
            pattern["ß"] = "ss";
            pattern["à"] = "a";
            pattern["á"] = "a";
            pattern["â"] = "a";
            pattern["ã"] = "a";
            pattern["ä"] = "a";
            pattern["å"] = "a";
            pattern["æ"] = "ae";
            pattern["ç"] = "c";
            pattern["è"] = "e";
            pattern["é"] = "e";
            pattern["ê"] = "e";
            pattern["ë"] = "e";
            pattern["ì"] = "i";
            pattern["í"] = "i";
            pattern["î"] = "i";
            pattern["ï"] = "i";
            pattern["ð"] = "d";
            pattern["ñ"] = "n";
            pattern["ò"] = "o";
            pattern["ó"] = "o";
            pattern["ô"] = "o";
            pattern["õ"] = "o";
            pattern["ö"] = "o";
            pattern["ø"] = "o";
            pattern["ù"] = "u";
            pattern["ú"] = "u";
            pattern["û"] = "u";
            pattern["ü"] = "u";
            pattern["ý"] = "y";
            pattern["ÿ"] = "y";
            pattern["þ"] = "th";
        }

        private static function decomposeUnicode(str:String):String
        {
            var i:int;
            var _local_6:String;
            var len:int = ((str.length > accents.length) ? accents.length : str.length);
            var left:String = ((len == accents.length) ? str : accents);
            var right:String = ((len == accents.length) ? accents : str);
            i = 0;
            while (i < len)
            {
                _local_6 = right.charAt(i);
                if (left.indexOf(_local_6) != -1)
                {
                    str = str.replace(_local_6, pattern[_local_6]);
                };
                i++;
            };
            return (str);
        }

        private static function getSingleDelimitedText(pStringEntry:String, pFirstDelimiter:String, pSecondDelimiter:String, pIncludeDelimiter:Boolean=false):String
        {
            var firstDelimiterIndex:int;
            var nextFirstDelimiterIndex:int;
            var nextSecondDelimiterIndex:int;
            var numFirstDelimiter:uint;
            var numSecondDelimiter:uint;
            var diff:int;
            var delimitedContent:String = "";
            var currentIndex:uint;
            var secondDelimiterToSkip:uint;
            var exit:Boolean;
            firstDelimiterIndex = pStringEntry.indexOf(pFirstDelimiter, currentIndex);
            if (firstDelimiterIndex == -1)
            {
                return ("");
            };
            currentIndex = (firstDelimiterIndex + pFirstDelimiter.length);
            while ((!(exit)))
            {
                nextFirstDelimiterIndex = pStringEntry.indexOf(pFirstDelimiter, currentIndex);
                nextSecondDelimiterIndex = pStringEntry.indexOf(pSecondDelimiter, currentIndex);
                if (nextSecondDelimiterIndex == -1)
                {
                    exit = true;
                };
                if (((nextFirstDelimiterIndex < nextSecondDelimiterIndex) && (!(nextFirstDelimiterIndex == -1))))
                {
                    secondDelimiterToSkip = (secondDelimiterToSkip + getAllIndexOf(pFirstDelimiter, pStringEntry.slice((nextFirstDelimiterIndex + pFirstDelimiter.length), nextSecondDelimiterIndex)).length);
                    currentIndex = (nextSecondDelimiterIndex + pFirstDelimiter.length);
                }
                else
                {
                    if (secondDelimiterToSkip > 1)
                    {
                        currentIndex = (nextSecondDelimiterIndex + pSecondDelimiter.length);
                        secondDelimiterToSkip--;
                    }
                    else
                    {
                        delimitedContent = pStringEntry.slice(firstDelimiterIndex, (nextSecondDelimiterIndex + pSecondDelimiter.length));
                        exit = true;
                    };
                };
            };
            if (delimitedContent != "")
            {
                if (!pIncludeDelimiter)
                {
                    delimitedContent = delimitedContent.slice(pFirstDelimiter.length);
                    delimitedContent = delimitedContent.slice(0, (delimitedContent.length - pSecondDelimiter.length));
                }
                else
                {
                    numFirstDelimiter = getAllIndexOf(pFirstDelimiter, delimitedContent).length;
                    numSecondDelimiter = getAllIndexOf(pSecondDelimiter, delimitedContent).length;
                    diff = (numFirstDelimiter - numSecondDelimiter);
                    if (diff > 0)
                    {
                        while (diff > 0)
                        {
                            firstDelimiterIndex = delimitedContent.indexOf(pFirstDelimiter);
                            nextFirstDelimiterIndex = delimitedContent.indexOf(pFirstDelimiter, (firstDelimiterIndex + pFirstDelimiter.length));
                            delimitedContent = delimitedContent.slice(nextFirstDelimiterIndex);
                            diff--;
                        };
                    }
                    else
                    {
                        if (diff < 0)
                        {
                            while (diff < 0)
                            {
                                delimitedContent = delimitedContent.slice(0, delimitedContent.lastIndexOf(pSecondDelimiter));
                                diff++;
                            };
                        };
                    };
                };
            };
            return (delimitedContent);
        }

        public static function kamasToString(kamas:Number, unit:String="-"):String
        {
            if (unit == "-")
            {
                unit = I18n.getUiText("ui.common.short.kama", []);
            };
            var kamaString:String = formateIntToString(kamas);
            if (unit == "")
            {
                return (kamaString);
            };
            return ((kamaString + " ") + unit);
        }

        public static function stringToKamas(string:String, unit:String="-"):Number
        {
            var str2:String;
            var tmp:String = string;
            do 
            {
                str2 = tmp;
                tmp = str2.replace(I18n.getUiText("ui.common.numberSeparator"), "");
            } while (str2 != tmp);
            do 
            {
                str2 = tmp;
                tmp = str2.replace(" ", "");
            } while (str2 != tmp);
            if (unit == "-")
            {
                unit = I18n.getUiText("ui.common.short.kama", []);
            };
            if (str2.substr((str2.length - unit.length)) == unit)
            {
                str2 = str2.substr(0, (str2.length - unit.length));
            };
            var numberResult:Number = Number(str2);
            if (((!(numberResult)) || (isNaN(numberResult))))
            {
                numberResult = 0;
            };
            return (numberResult);
        }

        public static function formateIntToString(val:Number, precision:int=2):String
        {
            var resultStrWithoutDecimal:String;
            var decimal:Number;
            var decimalStr:String;
            var numx3:int;
            var str:String = "";
            var modulo:Number = 1000;
            var numberSeparator:String = I18n.getUiText("ui.common.numberSeparator");
            var decimalNumber:Boolean;
            var valWithoutDecimal:Number = Math.floor(val);
            if (val != valWithoutDecimal)
            {
                decimalNumber = true;
                decimal = (val - valWithoutDecimal);
                decimalStr = decimal.toFixed(precision);
            };
            while (true)
            {
                if ((valWithoutDecimal / modulo) < 1)
                {
                    str = ((int(((valWithoutDecimal % modulo) / (modulo / 1000))) + numberSeparator) + str);
                    break;
                };
                numx3 = int(int(((valWithoutDecimal % modulo) / (modulo / 1000))));
                if (numx3 < 10)
                {
                    str = ((("00" + numx3) + numberSeparator) + str);
                }
                else
                {
                    if (numx3 < 100)
                    {
                        str = ((("0" + numx3) + numberSeparator) + str);
                    }
                    else
                    {
                        str = ((numx3 + numberSeparator) + str);
                    };
                };
                modulo = (modulo * 1000);
            };
            var f:* = str.charAt((str.length - 1));
            if (str.charAt((str.length - 1)) == numberSeparator)
            {
                resultStrWithoutDecimal = str.substr(0, (str.length - 1));
            }
            else
            {
                resultStrWithoutDecimal = str;
            };
            if (decimalNumber)
            {
                str = (resultStrWithoutDecimal + decimalStr.slice(1));
                return (str);
            };
            return (resultStrWithoutDecimal);
        }

        public static function unescapeAllowedChar(original:String):String
        {
            var unescapedString:String = unescape(original);
            unescapedString = unescapedString.split(">").join("&gt;");
            unescapedString = unescapedString.split("<").join("&lt;");
            unescapedString = unescapedString.split("&").join("&amp;");
            unescapedString = unescapedString.split('"').join("&#34;");
            return (unescapedString);
        }

        public static function sanitizeText(text:String):String
        {
            return (XML(new XMLNode(XMLNodeType.TEXT_NODE, text)).toXMLString());
        }

        public static function escapeHTMLDOM(currentNode:XMLNode):String
        {
            var attributes:String;
            var attribute:String;
            var toReturn:String = "";
            var currentNodeValue:String;
            var currentNodeName:String = currentNode.nodeName;
            if (currentNode.nodeValue !== null)
            {
                currentNodeValue = escapeHTMLText(currentNode.nodeValue);
            }
            else
            {
                currentNodeValue = "";
            };
            if (currentNodeName)
            {
                attributes = "";
                for (attribute in currentNode.attributes)
                {
                    if (currentNode.attributes.hasOwnProperty(attribute))
                    {
                        attributes = (attributes + " ".concat(attribute, '="', currentNode.attributes[attribute], '"'));
                    };
                };
                toReturn = toReturn.concat("<", currentNodeName, attributes, ">", currentNodeValue);
            }
            else
            {
                toReturn = currentNodeValue;
            };
            if (currentNode.childNodes.length > 0)
            {
                toReturn = (toReturn + escapeHTMLDOM(currentNode.childNodes[0]));
            };
            if (((!(currentNodeValue === null)) && (currentNodeName)))
            {
                toReturn = toReturn.concat("</", currentNodeName, ">");
            };
            if (currentNode.nextSibling)
            {
                return (toReturn + escapeHTMLDOM(currentNode.nextSibling));
            };
            return (toReturn);
        }

        public static function escapeHTMLText(HTMLText:String):String
        {
            HTMLText = replaceAll(HTMLText, "&", "&amp;");
            HTMLText = replaceAll(HTMLText, "<", "&lt;");
            HTMLText = replaceAll(HTMLText, ">", "&gt;");
            HTMLText = replaceAll(HTMLText, '"', "&quot;");
            return (replaceAll(HTMLText, "'", "&#39;"));
        }

        public static function replaceAll(text:String, pattern:String, toReplace:String):String
        {
            return (text.split(pattern).join(toReplace));
        }

        public static function trim(string:String):String
        {
            if (string === null)
            {
                return ("");
            };
            return (string.replace(/^\s+|\s+$/g, ""));
        }

        public static function padNumber(number:Number, zerosNumber:uint):String
        {
            var toReturn:String = number.toString();
            while (toReturn.length < zerosNumber)
            {
                toReturn = ("0" + toReturn);
            };
            return (toReturn);
        }


    }
} com.ankamagames.jerakine.utils.misc

