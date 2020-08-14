package com.ankamagames.jerakine.eval
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;

    public class Evaluator 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Evaluator));
        private static var operatorPriority:Array = [divide, multiply, minus, plus, sup, inf, supOrEquals, infOrEquals, equals, diff, and, or, ternary];
        private static const NUMBER:uint = 0;
        private static const STRING:uint = 1;


        public static function eval(expr:String):*
        {
            return (complexEval(expr));
        }

        private static function generateOp(expr:String):Array
        {
            var operator:Function;
            var currentChar:String;
            var startIndex:int;
            var ok:Boolean;
            var inQuote:Boolean;
            var currentParam:String = "";
            var currentType:uint = STRING;
            var op:Array = [];
            startIndex = -1;
            var stopIndex:int = -1;
            var incr:Function = function (index:int=-1):void
            {
                if (startIndex == -1)
                {
                    startIndex = index;
                    stopIndex = (index + 1);
                }
                else
                {
                    stopIndex++;
                };
            };
            var i:uint;
            while (i < expr.length)
            {
                currentChar = expr.charAt(i);
                if (currentChar == "'")
                {
                    currentType = STRING;
                    inQuote = (!(inQuote));
                }
                else
                {
                    if (currentChar == "\\")
                    {
                        i++;
                    }
                    else
                    {
                        if (!inQuote)
                        {
                            switch (currentChar)
                            {
                                case "(":
                                case ")":
                                case " ":
                                case "\t":
                                case "\n":
                                    break;
                                case "0":
                                case "1":
                                case "2":
                                case "3":
                                case "4":
                                case "5":
                                case "6":
                                case "7":
                                case "8":
                                case "9":
                                    currentType = NUMBER;
                                    operator = null;
                                    (incr(i));
                                    break;
                                case ".":
                                    (incr(i));
                                    break;
                                default:
                                    if ((((currentChar == "-") || (currentChar == "+")) && (startIndex == -1)))
                                    {
                                        (incr(i));
                                        break;
                                    };
                                    ok = true;
                                    switch (currentChar)
                                    {
                                        case "-":
                                            operator = minus;
                                            break;
                                        case "+":
                                            operator = plus;
                                            break;
                                        case "*":
                                            operator = multiply;
                                            break;
                                        case "/":
                                            operator = divide;
                                            break;
                                        case "?":
                                            operator = ternary;
                                            break;
                                        case ":":
                                            operator = opElse;
                                            break;
                                        case ">":
                                            if (expr.charAt((i + 1)) != "=")
                                            {
                                                operator = sup;
                                            }
                                            else
                                            {
                                                operator = supOrEquals;
                                                i++;
                                            };
                                            break;
                                        case "<":
                                            if (expr.charAt((i + 1)) != "=")
                                            {
                                                operator = inf;
                                            }
                                            else
                                            {
                                                operator = infOrEquals;
                                                i++;
                                            };
                                            break;
                                        case "|":
                                            if (expr.charAt((i + 1)) == "|")
                                            {
                                                operator = or;
                                                i++;
                                            }
                                            else
                                            {
                                                ok = false;
                                            };
                                            break;
                                        case "=":
                                            if (expr.charAt((i + 1)) == "=")
                                            {
                                                operator = equals;
                                                i++;
                                            }
                                            else
                                            {
                                                ok = false;
                                            };
                                            break;
                                        case "&":
                                            if (expr.charAt((i + 1)) == "&")
                                            {
                                                operator = and;
                                                i++;
                                            }
                                            else
                                            {
                                                ok = false;
                                            };
                                            break;
                                        case "!":
                                            if (expr.charAt((i + 1)) == "=")
                                            {
                                                operator = diff;
                                                i++;
                                            }
                                            else
                                            {
                                                ok = false;
                                            };
                                            break;
                                        default:
                                            ok = false;
                                    };
                                    if (ok)
                                    {
                                        if (startIndex != -1)
                                        {
                                            currentParam = expr.substring(startIndex, stopIndex);
                                            if (currentType == STRING)
                                            {
                                                op.push(currentParam);
                                            }
                                            else
                                            {
                                                op.push(parseFloat(currentParam));
                                            };
                                            op.push(operator);
                                        }
                                        else
                                        {
                                            if (currentType == STRING)
                                            {
                                                op.push("");
                                                op.push(operator);
                                            }
                                            else
                                            {
                                                _log.warn(showPosInExpr(i, expr));
                                                _log.warn(((("Expecting Number at char " + i) + ", but found operator ") + currentChar));
                                            };
                                        };
                                        startIndex = -1;
                                    }
                                    else
                                    {
                                        _log.warn(showPosInExpr(i, expr));
                                        _log.warn(("Bad character at " + i));
                                    };
                            };
                        }
                        else
                        {
                            operator = null;
                            (incr(i));
                        };
                    };
                };
                i++;
            };
            if (startIndex != -1)
            {
                currentParam = expr.substring(startIndex, stopIndex);
                if (currentType == STRING)
                {
                    op.push(currentParam);
                }
                else
                {
                    op.push(parseFloat(currentParam));
                };
            };
            return (op);
        }

        private static function simpleEval(expr:String):*
        {
            var partialOp:Array;
            var lastOp:*;
            var k:uint;
            var op:Array = generateOp(expr);
            var j:uint;
            while (j < operatorPriority.length)
            {
                if (op.length == 1)
                {
                    break;
                };
                partialOp = null;
                k = 0;
                while (k < op.length)
                {
                    if (((op[k] is Function) && (op[k] == operatorPriority[j])))
                    {
                        if (partialOp == null)
                        {
                            lastOp = op[(k - 1)];
                            if (k > 1)
                            {
                                partialOp = op.slice(0, (k - 1));
                            }
                            else
                            {
                                partialOp = [];
                            };
                        }
                        else
                        {
                            if (partialOp.length > 0)
                            {
                                lastOp = partialOp[(partialOp.length - 1)];
                            }
                            else
                            {
                                lastOp = op[(k - 1)];
                            };
                        };
                        if ((((lastOp is Number) || ((lastOp is String) && ((((op[k] == plus) || (op[k] == ternary)) || (op[k] == equals)) || (op[k] == diff)))) && ((op[(k + 1)] is Number) || ((op[(k + 1)] is String) && ((((op[k] == plus) || (op[k] == ternary)) || (op[k] == equals)) || (op[k] == diff))))))
                        {
                            if (op[k] === ternary)
                            {
                                if (op[(k + 2)] == opElse)
                                {
                                    partialOp.push(ternary(lastOp, op[(k + 1)], op[(k + 3)]));
                                    k = (k + 2);
                                }
                                else
                                {
                                    _log.warn("operator ':' not found");
                                };
                            }
                            else
                            {
                                partialOp.push(op[k](lastOp, op[(k + 1)]));
                            };
                        }
                        else
                        {
                            _log.warn((("Expect Number,  but find [" + op[(k + 1)]) + "]"));
                        };
                        k++;
                    }
                    else
                    {
                        if (partialOp != null)
                        {
                            partialOp.push(op[k]);
                        };
                    };
                    k++;
                };
                if (partialOp != null)
                {
                    op = partialOp;
                };
                j++;
            };
            return (op[0]);
        }

        private static function complexEval(expr:String):*
        {
            var start:int;
            var res:*;
            var i:uint;
            var modif:Boolean = true;
            var parenthCount:int;
            while (modif)
            {
                modif = false;
                i = 0;
                while (i < expr.length)
                {
                    if (expr.charAt(i) == "(")
                    {
                        if (!parenthCount)
                        {
                            start = i;
                        };
                        parenthCount++;
                    };
                    if (expr.charAt(i) == ")")
                    {
                        parenthCount--;
                        if (!parenthCount)
                        {
                            res = complexEval(expr.substr((start + 1), ((i - start) - 1)));
                            expr = ((expr.substr(0, start) + ((res is Number) ? res : (("'" + res) + "'"))) + expr.substr((i + 1)));
                            modif = true;
                            break;
                        };
                    };
                    i++;
                };
            };
            if (parenthCount)
            {
                _log.warn(("Missing right parenthesis in " + expr));
            };
            return (simpleEval(expr));
        }

        private static function plus(a:*, b:*):*
        {
            return (a + b);
        }

        private static function minus(a:Number, b:Number):Number
        {
            return (a - b);
        }

        private static function multiply(a:Number, b:Number):Number
        {
            return (a * b);
        }

        private static function divide(a:Number, b:Number):Number
        {
            return (a / b);
        }

        private static function sup(a:Number, b:Number):Number
        {
            return ((a > b) ? 1 : 0);
        }

        private static function supOrEquals(a:Number, b:Number):Number
        {
            return ((a >= b) ? 1 : 0);
        }

        private static function inf(a:Number, b:Number):Number
        {
            return ((a < b) ? 1 : 0);
        }

        private static function infOrEquals(a:Number, b:Number):Number
        {
            return ((a <= b) ? 1 : 0);
        }

        private static function and(a:Number, b:Number):Number
        {
            return (((a) && (b)) ? 1 : 0);
        }

        private static function or(a:Number, b:Number):Number
        {
            return (((a) || (b)) ? 1 : 0);
        }

        private static function equals(a:*, b:*):Number
        {
            if ((((a == "") && (b == "null")) || ((a == "null") && (b == ""))))
            {
                return (1);
            };
            return ((a == b) ? 1 : 0);
        }

        private static function diff(a:*, b:*):Number
        {
            return ((a != b) ? 1 : 0);
        }

        private static function ternary(cond:Number, a:*, b:*):*
        {
            return ((cond) ? a : b);
        }

        private static function opElse():void
        {
        }

        private static function showPosInExpr(pos:uint, expr:String):String
        {
            var res:* = (expr + "\n");
            var i:uint;
            while (i < pos)
            {
                res = (res + " ");
                i++;
            };
            return (res + "^");
        }


    }
} com.ankamagames.jerakine.eval

