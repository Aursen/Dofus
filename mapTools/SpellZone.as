package mapTools
{
    import tools.FpUtils;

    public class SpellZone 
    {

        public static var DEFAULT_RADIUS:int = 1;
        public static var DEFAULT_MIN_RADIUS:int = 0;
        public static var DEFAULT_DEGRESSION:int = 10;
        public static var DEFAULT_MAX_DEGRESSION_TICKS:int = 4;
        public static var GLOBAL_RADIUS:int = 63;
        public static var MAX_RADIUS_DEGRESSION:int = 50;

        public var isCellInZone:Function;
        public var getCells:Function;

        public var shape:String = "P";
        public var maxDegressionTicks:int = SpellZone.DEFAULT_MAX_DEGRESSION_TICKS;
        public var degression:int = SpellZone.DEFAULT_DEGRESSION;
        public var minRadius:int = SpellZone.DEFAULT_MIN_RADIUS;
        public var radius:int = SpellZone.DEFAULT_RADIUS;

        public function SpellZone():void
        {
        }

        public static function fromRawZone(_arg_1:String):SpellZone
        {
            var _local_5:int;
            var _local_6:* = (null as String);
            var _local_7:* = (null as Object);
            if (_arg_1 == null)
            {
                _arg_1 = "P";
            };
            var _local_2:SpellZone = new SpellZone();
            _local_2.shape = _arg_1.charAt(0);
            var _local_3:Array = FpUtils.arrayFilter_String(_arg_1.substr(1).split(","), function (_arg_1:String):Boolean
            {
                return (_arg_1.length > 0);
            });
            var _local_4:Boolean;
            if (_local_2.shape == ";")
            {
                var cells:Array = [];
                _local_5 = 0;
                while (_local_5 < _local_3.length)
                {
                    _local_6 = _local_3[_local_5];
                    _local_5++;
                    if (_local_6.length > 0)
                    {
                        _local_7 = Std.parseInt(_local_6);
                        cells.push(_local_7);
                    };
                };
                _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                {
                    return (cells);
                };
                _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                {
                    return (!(cells.indexOf(_arg_1) == -1));
                };
                return (_local_2);
            };
            if (_local_2.shape == "l")
            {
                _local_6 = _local_3[0];
                _local_3[0] = _local_3[1];
                _local_3[1] = _local_6;
            };
            if (_local_3.length > 0)
            {
                _local_2.radius = Std.parseInt(_local_3[0]);
            };
            if (SpellZone.hasMinSize(_local_2.shape))
            {
                if (_local_3.length > 1)
                {
                    _local_2.minRadius = Std.parseInt(_local_3[1]);
                };
                if (_local_3.length > 2)
                {
                    _local_2.degression = Std.parseInt(_local_3[2]);
                };
            }
            else
            {
                if (_local_3.length > 1)
                {
                    _local_2.degression = Std.parseInt(_local_3[1]);
                };
                if (_local_3.length > 2)
                {
                    _local_2.maxDegressionTicks = Std.parseInt(_local_3[2]);
                };
            };
            if (_local_3.length > 3)
            {
                _local_2.maxDegressionTicks = Std.parseInt(_local_3[3]);
            };
            if (_local_3.length > 4)
            {
                _local_4 = (!(Std.parseInt(_local_3[4]) == 0));
            };
            _local_6 = _local_2.shape;
                
            outer_block:
            {

                if (_local_6 == " ")
                {
                    _local_2.getCells = SpellZone.fillEmptyCells;
                    _local_2.isCellInZone = SpellZone.isCellInEmptyZone;
                }
                else
                {
                    if (_local_6 == "#")
                    {
                        var zone1:SpellZone = _local_2;
                        var directions:Array = MapDirection.MAP_CARDINAL_DIRECTIONS;
                        _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                        {
                            return (SpellZone.fillCrossCells(zone1, directions, true, _arg_1, _arg_2));
                        };
                        var zone2:SpellZone = _local_2;
                        var directions1:Array = MapDirection.MAP_CARDINAL_DIRECTIONS;
                        _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                        {
                            return (SpellZone.isCellInCrossZone(zone2, directions1, true, _arg_1, _arg_2, _arg_3));
                        };
                    }
                    else
                    {
                        if (_local_6 == "*")
                        {
                            var zone3:SpellZone = _local_2;
                            var directions2:Array = MapDirection.MAP_DIRECTIONS;
                            _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                            {
                                return (SpellZone.fillCrossCells(zone3, directions2, false, _arg_1, _arg_2));
                            };
                            var zone4:SpellZone = _local_2;
                            var directions3:Array = MapDirection.MAP_DIRECTIONS;
                            _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                            {
                                return (SpellZone.isCellInCrossZone(zone4, directions3, false, _arg_1, _arg_2, _arg_3));
                            };
                        }
                        else
                        {
                            if (_local_6 == "+")
                            {
                                var zone5:SpellZone = _local_2;
                                var directions4:Array = MapDirection.MAP_CARDINAL_DIRECTIONS;
                                _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                {
                                    return (SpellZone.fillCrossCells(zone5, directions4, false, _arg_1, _arg_2));
                                };
                                var zone6:SpellZone = _local_2;
                                var directions5:Array = MapDirection.MAP_CARDINAL_DIRECTIONS;
                                _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                {
                                    return (SpellZone.isCellInCrossZone(zone6, directions5, false, _arg_1, _arg_2, _arg_3));
                                };
                            }
                            else
                            {
                                if (_local_6 == "-")
                                {
                                    var zone7:SpellZone = _local_2;
                                    _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                    {
                                        return (SpellZone.fillPerpLineCells(zone7, _arg_1, _arg_2));
                                    };
                                    var zone8:SpellZone = _local_2;
                                    _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                    {
                                        return (SpellZone.isCellInPerpLineZone(zone8, _arg_1, _arg_2, _arg_3));
                                    };
                                }
                                else
                                {
                                    if (_local_6 == "/")
                                    {
                                        var zone9:SpellZone = _local_2;
                                        var stopAtTarget1:Boolean = _local_4;
                                        _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                        {
                                            return (SpellZone.fillLineCells(zone9, stopAtTarget1, false, _arg_1, _arg_2));
                                        };
                                        var zone10:SpellZone = _local_2;
                                        var stopAtTarget2:Boolean = _local_4;
                                        _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                        {
                                            return (SpellZone.isCellInLineZone(zone10, stopAtTarget2, false, _arg_1, _arg_2, _arg_3));
                                        };
                                    }
                                    else
                                    {
                                        if( (_local_6 == "A") || (_local_6 == "a") )
                                        {
                                            _local_2.getCells = SpellZone.fillWholeMap;
                                            _local_2.isCellInZone = SpellZone.isCellInWholeMapZone;
                                            return (_local_2); //break outer_block;
                                        };
                                        if (_local_6 == "B")
                                        {
                                            var zone11:SpellZone = _local_2;
                                            _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                            {
                                                return (SpellZone.fillBoomerang(zone11, _arg_1, _arg_2));
                                            };
                                            var zone12:SpellZone = _local_2;
                                            _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                            {
                                                return (SpellZone.isCellInBoomerangZone(zone12, _arg_1, _arg_2, _arg_3));
                                            };
                                        }
                                        else
                                        {
                                            if (_local_6 == "C")
                                            {
                                                var zone13:SpellZone = _local_2;
                                                _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                {
                                                    return (SpellZone.fillCircleCells(zone13, _arg_1, _arg_2));
                                                };
                                                var zone14:SpellZone = _local_2;
                                                _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                {
                                                    return (SpellZone.isCellInCircleZone(zone14, _arg_1, _arg_2, _arg_3));
                                                };
                                            }
                                            else
                                            {
                                                if (_local_6 == "D")
                                                {
                                                    var zone15:SpellZone = _local_2;
                                                    _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                    {
                                                        return (SpellZone.fillCheckerboard(zone15, _arg_1, _arg_2));
                                                    };
                                                    var zone16:SpellZone = _local_2;
                                                    _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                    {
                                                        return (SpellZone.isCellInCheckerboardZone(zone16, _arg_1, _arg_2, _arg_3));
                                                    };
                                                }
                                                else
                                                {
                                                    if (_local_6 == "G")
                                                    {
                                                        var zone17:SpellZone = _local_2;
                                                        _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                        {
                                                            return (SpellZone.fillSquareCells(zone17, false, _arg_1, _arg_2));
                                                        };
                                                        var zone18:SpellZone = _local_2;
                                                        _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                        {
                                                            return (SpellZone.isCellInSquareZone(zone18, false, _arg_1, _arg_2, _arg_3));
                                                        };
                                                    }
                                                    else
                                                    {
                                                        if (_local_6 == "I")
                                                        {
                                                            _local_2.minRadius = _local_2.radius;
                                                            _local_2.radius = SpellZone.GLOBAL_RADIUS;
                                                            var zone19:SpellZone = _local_2;
                                                            _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                            {
                                                                return (SpellZone.fillCircleCells(zone19, _arg_1, _arg_2));
                                                            };
                                                            var zone20:SpellZone = _local_2;
                                                            _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                            {
                                                                return (SpellZone.isCellInCircleZone(zone20, _arg_1, _arg_2, _arg_3));
                                                            };
                                                        }
                                                        else
                                                        {
                                                            if (_local_6 == "L")
                                                            {
                                                                var zone21:SpellZone = _local_2;
                                                                var stopAtTarget3:Boolean = _local_4;
                                                                _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                                {
                                                                    return (SpellZone.fillLineCells(zone21, stopAtTarget3, false, _arg_1, _arg_2));
                                                                };
                                                                var zone22:SpellZone = _local_2;
                                                                var stopAtTarget4:Boolean = _local_4;
                                                                _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                                {
                                                                    return (SpellZone.isCellInLineZone(zone22, stopAtTarget4, false, _arg_1, _arg_2, _arg_3));
                                                                };
                                                            }
                                                            else
                                                            {
                                                                if (_local_6 == "O")
                                                                {
                                                                    _local_2.minRadius = _local_2.radius;
                                                                    var zone23:SpellZone = _local_2;
                                                                    _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                                    {
                                                                        return (SpellZone.fillCircleCells(zone23, _arg_1, _arg_2));
                                                                    };
                                                                    var zone24:SpellZone = _local_2;
                                                                    _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                                    {
                                                                        return (SpellZone.isCellInCircleZone(zone24, _arg_1, _arg_2, _arg_3));
                                                                    };
                                                                }
                                                                else
                                                                {
                                                                    if (_local_6 == "P")
                                                                    {
                                                                        _local_2.radius = 0;
                                                                        _local_2.getCells = SpellZone.fillPointCells;
                                                                        _local_2.isCellInZone = SpellZone.isCellInPointZone;
                                                                    }
                                                                    else
                                                                    {
                                                                        if (_local_6 == "Q")
                                                                        {
                                                                            var zone25:SpellZone = _local_2;
                                                                            var directions6:Array = MapDirection.MAP_ORTHOGONAL_DIRECTIONS;
                                                                            _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                                            {
                                                                                return (SpellZone.fillCrossCells(zone25, directions6, true, _arg_1, _arg_2));
                                                                            };
                                                                            var zone26:SpellZone = _local_2;
                                                                            var directions7:Array = MapDirection.MAP_ORTHOGONAL_DIRECTIONS;
                                                                            _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                                            {
                                                                                return (SpellZone.isCellInCrossZone(zone26, directions7, true, _arg_1, _arg_2, _arg_3));
                                                                            };
                                                                        }
                                                                        else
                                                                        {
                                                                            if (_local_6 == "T")
                                                                            {
                                                                                var zone27:SpellZone = _local_2;
                                                                                _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                                                {
                                                                                    return (SpellZone.fillPerpLineCells(zone27, _arg_1, _arg_2));
                                                                                };
                                                                                var zone28:SpellZone = _local_2;
                                                                                _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                                                {
                                                                                    return (SpellZone.isCellInPerpLineZone(zone28, _arg_1, _arg_2, _arg_3));
                                                                                };
                                                                            }
                                                                            else
                                                                            {
                                                                                if (_local_6 == "U")
                                                                                {
                                                                                    var zone29:SpellZone = _local_2;
                                                                                    _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                                                    {
                                                                                        return (SpellZone.fillHalfCircle(zone29, _arg_1, _arg_2));
                                                                                    };
                                                                                    var zone30:SpellZone = _local_2;
                                                                                    _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                                                    {
                                                                                        return (SpellZone.isCellInHalfCircleZone(zone30, _arg_1, _arg_2, _arg_3));
                                                                                    };
                                                                                }
                                                                                else
                                                                                {
                                                                                    if (_local_6 == "V")
                                                                                    {
                                                                                        var zone31:SpellZone = _local_2;
                                                                                        _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                                                        {
                                                                                            return (SpellZone.fillConeCells(zone31, _arg_1, _arg_2));
                                                                                        };
                                                                                        var zone32:SpellZone = _local_2;
                                                                                        _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                                                        {
                                                                                            return (SpellZone.isCellInConeZone(zone32, _arg_1, _arg_2, _arg_3));
                                                                                        };
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        if (_local_6 == "W")
                                                                                        {
                                                                                            var zone33:SpellZone = _local_2;
                                                                                            _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                                                            {
                                                                                                return (SpellZone.fillSquareCells(zone33, true, _arg_1, _arg_2));
                                                                                            };
                                                                                            var zone34:SpellZone = _local_2;
                                                                                            _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                                                            {
                                                                                                return (SpellZone.isCellInSquareZone(zone34, true, _arg_1, _arg_2, _arg_3));
                                                                                            };
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            if (_local_6 == "X")
                                                                                            {
                                                                                                var zone35:SpellZone = _local_2;
                                                                                                var directions8:Array = MapDirection.MAP_ORTHOGONAL_DIRECTIONS;
                                                                                                _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                                                                {
                                                                                                    return (SpellZone.fillCrossCells(zone35, directions8, false, _arg_1, _arg_2));
                                                                                                };
                                                                                                var zone36:SpellZone = _local_2;
                                                                                                var directions9:Array = MapDirection.MAP_ORTHOGONAL_DIRECTIONS;
                                                                                                _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                                                                {
                                                                                                    return (SpellZone.isCellInCrossZone(zone36, directions9, false, _arg_1, _arg_2, _arg_3));
                                                                                                };
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                if (_local_6 == "Z")
                                                                                                {
                                                                                                    var zone37:SpellZone = _local_2;
                                                                                                    _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                                                                    {
                                                                                                        return (SpellZone.fillReversedTrueCircleCells(zone37, _arg_1, _arg_2));
                                                                                                    };
                                                                                                    var zone38:SpellZone = _local_2;
                                                                                                    _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                                                                    {
                                                                                                        return (SpellZone.isCellInReversedTrueCircleZone(zone38, _arg_1, _arg_2, _arg_3));
                                                                                                    };
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    if (_local_6 == "l")
                                                                                                    {
                                                                                                        var zone39:SpellZone = _local_2;
                                                                                                        var stopAtTarget5:Boolean = _local_4;
                                                                                                        _local_2.getCells = function (_arg_1:int, _arg_2:int):Array
                                                                                                        {
                                                                                                            return (SpellZone.fillLineCells(zone39, stopAtTarget5, true, _arg_1, _arg_2));
                                                                                                        };
                                                                                                        var zone40:SpellZone = _local_2;
                                                                                                        var stopAtTarget6:Boolean = _local_4;
                                                                                                        _local_2.isCellInZone = function (_arg_1:int, _arg_2:int, _arg_3:int):Boolean
                                                                                                        {
                                                                                                            return (SpellZone.isCellInLineZone(zone40, stopAtTarget6, true, _arg_1, _arg_2, _arg_3));
                                                                                                        };
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        _local_2.shape = "P";
                                                                                                        _local_2.radius = 0;
                                                                                                        _local_2.getCells = SpellZone.fillPointCells;
                                                                                                        _local_2.isCellInZone = SpellZone.isCellInPointZone;
                                                                                                    };
                                                                                                };
                                                                                            };
                                                                                        };
                                                                                    };
                                                                                };
                                                                            };
                                                                        };
                                                                    };
                                                                };
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            
            }//outer_block
            return (_local_2);
        }

        public static function fillPointCells(_arg_1:int, _arg_2:int):Array
        {
            if (!MapTools.isValidCellId(_arg_1))
            {
                return ([]);
            };
            return ([_arg_1]);
        }

        public static function isCellInPointZone(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            return (_arg_1 == _arg_2);
        }

        public static function fillEmptyCells(_arg_1:int, _arg_2:int):Array
        {
            return ([]);
        }

        public static function isCellInEmptyZone(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            return (false);
        }

        public static function fillCircleCells(_arg_1:SpellZone, _arg_2:int, _arg_3:int):Array
        {
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_4:Array = [];
            var _local_5:Point = MapTools.getCellCoordById(_arg_2);
            var _local_6:int = -(_arg_1.radius);
            var _local_7:* = (_arg_1.radius + 1);
            while (_local_6 < _local_7)
            {
                _local_8 = _local_6++;
                _local_9 = -(_arg_1.radius);
                _local_10 = (_arg_1.radius + 1);
                while (_local_9 < _local_10)
                {
                    _local_11 = _local_9++;
                    if ((((MapTools.isValidCoord((_local_5.x + _local_8), (_local_5.y + _local_11))) && ((Math.abs(_local_8) + Math.abs(_local_11)) <= _arg_1.radius)) && ((Math.abs(_local_8) + Math.abs(_local_11)) >= _arg_1.minRadius)))
                    {
                        _local_4.push(MapTools.getCellIdByCoord((_local_5.x + _local_8), (_local_5.y + _local_11)));
                    };
                };
            };
            return (_local_4);
        }

        public static function isCellInCircleZone(_arg_1:SpellZone, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            var _local_5:int = MapTools.getDistance(_arg_2, _arg_3);
            if (_local_5 <= _arg_1.radius)
            {
                return (_local_5 >= _arg_1.minRadius);
            };
            return (false);
        }

        public static function fillCheckerboard(_arg_1:SpellZone, _arg_2:int, _arg_3:int):Array
        {
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_4:Array = [];
            var _local_5:Point = MapTools.getCellCoordById(_arg_2);
            var _local_6:* = ((_arg_1.radius % 2) == 0);
            var _local_7:int = -(_arg_1.radius);
            var _local_8:* = (_arg_1.radius + 1);
            while (_local_7 < _local_8)
            {
                _local_9 = _local_7++;
                _local_10 = -(_arg_1.radius);
                _local_11 = (_arg_1.radius + 1);
                while (_local_10 < _local_11)
                {
                    _local_12 = _local_10++;
                    if (((((MapTools.isValidCoord((_local_5.x + _local_9), (_local_5.y + _local_12))) && ((Math.abs(_local_9) + Math.abs(_local_12)) <= _arg_1.radius)) && ((Math.abs(_local_9) + Math.abs(_local_12)) >= _arg_1.minRadius)) && (((_local_6) && (((_local_9 + (_local_12 % 2)) % 2) == 0)) || ((_local_6) && ((((_local_9 + 1) + (_local_12 % 2)) % 2) == 0)))))
                    {
                        _local_4.push(MapTools.getCellIdByCoord((_local_5.x + _local_9), (_local_5.y + _local_12)));
                    };
                };
            };
            return (_local_4);
        }

        public static function isCellInCheckerboardZone(_arg_1:SpellZone, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            var _local_5:int = MapTools.getDistance(_arg_2, _arg_3);
            var _local_6:* = ((_arg_1.radius % 2) == 0);
            var _local_7:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_8:int = int(Math.floor(((_local_7 + 1) / 2)));
            var _local_9:* = (_arg_2 - (_local_7 * MapTools.MAP_GRID_WIDTH));
            var _local_10:* = (_local_8 + _local_9);
            var _local_11:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_12:int = int(Math.floor(((_local_11 + 1) / 2)));
            var _local_13:* = (_local_11 - _local_12);
            var _local_14:* = (_arg_2 - (_local_11 * MapTools.MAP_GRID_WIDTH));
            var _local_15:* = (_local_14 - _local_13);
            if (_local_5 >= _arg_1.minRadius)
            {
                if (!((_local_6) && (((_local_10 + (_local_15 % 2)) % 2) == 0)))
                {
                    if (!_local_6)
                    {
                        return ((((_local_10 + 1) + (_local_15 % 2)) % 2) == 0);
                    };
                    return (false);
                };
                return (true);
            };
            return (false);
        }

        public static function fillLineCells(_arg_1:SpellZone, _arg_2:Boolean, _arg_3:Boolean, _arg_4:int, _arg_5:int):Array
        {
            var _local_24:int;
            var _local_26:int;
            var _local_6:Array = [];
            var _local_7:int = ((_arg_3) ? _arg_5 : _arg_4);
            var _local_8:int = ((_arg_3) ? ((_arg_1.radius + _arg_1.minRadius) - 1) : _arg_1.radius);
            var _local_9:int = int(Math.floor((_arg_5 / MapTools.MAP_GRID_WIDTH)));
            var _local_10:int = int(Math.floor(((_local_9 + 1) / 2)));
            var _local_11:* = (_arg_5 - (_local_9 * MapTools.MAP_GRID_WIDTH));
            var _local_12:int = int(Math.floor((_arg_5 / MapTools.MAP_GRID_WIDTH)));
            var _local_13:int = int(Math.floor(((_local_12 + 1) / 2)));
            var _local_14:* = (_local_12 - _local_13);
            var _local_15:* = (_arg_5 - (_local_12 * MapTools.MAP_GRID_WIDTH));
            var _local_16:int = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
            var _local_17:int = int(Math.floor(((_local_16 + 1) / 2)));
            var _local_18:* = (_arg_4 - (_local_16 * MapTools.MAP_GRID_WIDTH));
            var _local_19:int = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
            var _local_20:int = int(Math.floor(((_local_19 + 1) / 2)));
            var _local_21:* = (_local_19 - _local_20);
            var _local_22:* = (_arg_4 - (_local_19 * MapTools.MAP_GRID_WIDTH));
            var _local_23:int = MapTools.getLookDirection8ExactByCoord((_local_10 + _local_11), (_local_15 - _local_14), (_local_17 + _local_18), (_local_22 - _local_21));
            if (((_arg_3) && (_arg_2)))
            {
                _local_24 = MapTools.getDistance(_arg_5, _arg_4);
                if (_local_24 < _local_8)
                {
                    _local_8 = _local_24;
                };
            };
            _local_24 = 0;
            var _local_25:int = _arg_1.minRadius;
            while (_local_24 < _local_25)
            {
                _local_26 = _local_24++;
                _local_7 = MapTools.getNextCellByDirection(_local_7, _local_23);
            };
            _local_24 = _arg_1.minRadius;
            _local_25 = (_local_8 + 1);
            while (_local_24 < _local_25)
            {
                _local_26 = _local_24++;
                if (MapTools.isValidCellId(_local_7))
                {
                    _local_6.push(_local_7);
                };
                _local_7 = MapTools.getNextCellByDirection(_local_7, _local_23);
            };
            return (_local_6);
        }

        public static function isCellInLineZone(_arg_1:SpellZone, _arg_2:Boolean, _arg_3:Boolean, _arg_4:int, _arg_5:int, _arg_6:int):Boolean
        {
            var _local_23:int;
            var _local_24:int;
            var _local_25:int;
            var _local_26:int;
            var _local_27:int;
            var _local_28:int;
            var _local_29:int;
            var _local_30:int;
            var _local_31:int;
            var _local_32:int;
            var _local_33:int;
            var _local_34:int;
            var _local_35:int;
            var _local_36:int;
            var _local_37:int;
            var _local_38:int;
            var _local_39:int;
            if (_arg_6 == _arg_4)
            {
                return (false);
            };
            var _local_7:int = int(Math.floor((_arg_6 / MapTools.MAP_GRID_WIDTH)));
            var _local_8:int = int(Math.floor(((_local_7 + 1) / 2)));
            var _local_9:* = (_arg_6 - (_local_7 * MapTools.MAP_GRID_WIDTH));
            var _local_10:int = int(Math.floor((_arg_6 / MapTools.MAP_GRID_WIDTH)));
            var _local_11:int = int(Math.floor(((_local_10 + 1) / 2)));
            var _local_12:* = (_local_10 - _local_11);
            var _local_13:* = (_arg_6 - (_local_10 * MapTools.MAP_GRID_WIDTH));
            var _local_14:int = int(Math.floor((_arg_5 / MapTools.MAP_GRID_WIDTH)));
            var _local_15:int = int(Math.floor(((_local_14 + 1) / 2)));
            var _local_16:* = (_arg_5 - (_local_14 * MapTools.MAP_GRID_WIDTH));
            var _local_17:int = int(Math.floor((_arg_5 / MapTools.MAP_GRID_WIDTH)));
            var _local_18:int = int(Math.floor(((_local_17 + 1) / 2)));
            var _local_19:* = (_local_17 - _local_18);
            var _local_20:* = (_arg_5 - (_local_17 * MapTools.MAP_GRID_WIDTH));
            var _local_21:int = MapTools.getLookDirection8ExactByCoord((_local_8 + _local_9), (_local_13 - _local_12), (_local_15 + _local_16), (_local_20 - _local_19));
            var _local_22:int = _arg_1.radius;
            if (_arg_3)
            {
                _local_25 = int(Math.floor((_arg_6 / MapTools.MAP_GRID_WIDTH)));
                _local_26 = int(Math.floor(((_local_25 + 1) / 2)));
                _local_27 = (_arg_6 - (_local_25 * MapTools.MAP_GRID_WIDTH));
                _local_28 = int(Math.floor((_arg_6 / MapTools.MAP_GRID_WIDTH)));
                _local_29 = int(Math.floor(((_local_28 + 1) / 2)));
                _local_30 = (_local_28 - _local_29);
                _local_31 = (_arg_6 - (_local_28 * MapTools.MAP_GRID_WIDTH));
                _local_32 = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
                _local_33 = int(Math.floor(((_local_32 + 1) / 2)));
                _local_34 = (_arg_4 - (_local_32 * MapTools.MAP_GRID_WIDTH));
                _local_35 = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
                _local_36 = int(Math.floor(((_local_35 + 1) / 2)));
                _local_37 = (_local_35 - _local_36);
                _local_38 = (_arg_4 - (_local_35 * MapTools.MAP_GRID_WIDTH));
                _local_23 = MapTools.getLookDirection8ExactByCoord((_local_26 + _local_27), (_local_31 - _local_30), (_local_33 + _local_34), (_local_38 - _local_37));
                _local_24 = MapTools.getDistance(_arg_6, _arg_4);
                if (_arg_2)
                {
                    _local_39 = MapTools.getDistance(_arg_6, _arg_5);
                    if (_local_39 < _local_22)
                    {
                        _local_22 = _local_39;
                    };
                };
            }
            else
            {
                _local_25 = int(Math.floor((_arg_5 / MapTools.MAP_GRID_WIDTH)));
                _local_26 = int(Math.floor(((_local_25 + 1) / 2)));
                _local_27 = (_arg_5 - (_local_25 * MapTools.MAP_GRID_WIDTH));
                _local_28 = int(Math.floor((_arg_5 / MapTools.MAP_GRID_WIDTH)));
                _local_29 = int(Math.floor(((_local_28 + 1) / 2)));
                _local_30 = (_local_28 - _local_29);
                _local_31 = (_arg_5 - (_local_28 * MapTools.MAP_GRID_WIDTH));
                _local_32 = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
                _local_33 = int(Math.floor(((_local_32 + 1) / 2)));
                _local_34 = (_arg_4 - (_local_32 * MapTools.MAP_GRID_WIDTH));
                _local_35 = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
                _local_36 = int(Math.floor(((_local_35 + 1) / 2)));
                _local_37 = (_local_35 - _local_36);
                _local_38 = (_arg_4 - (_local_35 * MapTools.MAP_GRID_WIDTH));
                _local_23 = MapTools.getLookDirection8ExactByCoord((_local_26 + _local_27), (_local_31 - _local_30), (_local_33 + _local_34), (_local_38 - _local_37));
                _local_24 = MapTools.getDistance(_arg_5, _arg_4);
            };
            if (((MapDirection.isCardinal(_local_23)) && (_local_24 > 1)))
            {
                _local_24 = (_local_24 >> 1);
            };
            if ((((_local_21 == (_local_23)) || (_local_24 == 0)) && (_local_24 >= _arg_1.minRadius)))
            {
                return (_local_24 <= _local_22);
            };
            return (false);
        }

        public static function fillCrossCells(_arg_1:SpellZone, _arg_2:Array, _arg_3:Boolean, _arg_4:int, _arg_5:int):Array
        {
            var _local_11:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_6:Array = [];
            var _local_7:int = _arg_1.minRadius;
            if (_arg_1.minRadius == 0)
            {
                _local_7 = 1;
                if (!_arg_3)
                {
                    _local_6.push(_arg_4);
                };
            };
            var _local_8:Array = [];
            var _local_9:int;
            var _local_10:int = _arg_2.length;
            while (_local_9 < _local_10)
            {
                _local_11 = _local_9++;
                _local_8.push(_arg_4);
            };
            var _local_12:Array = _local_8;
            _local_9 = 1;
            _local_10 = (_arg_1.radius + 1);
            while (_local_9 < _local_10)
            {
                _local_11 = _local_9++;
                _local_13 = 0;
                _local_14 = _arg_2.length;
                while (_local_13 < _local_14)
                {
                    _local_15 = _local_13++;
                    _local_12[_local_15] = MapTools.getNextCellByDirection(_local_12[_local_15], _arg_2[_local_15]);
                    if (((_local_11 >= (_local_7)) && (MapTools.isValidCellId(_local_12[_local_15]))))
                    {
                        _local_6.push(_local_12[_local_15]);
                    };
                };
            };
            return (_local_6);
        }

        public static function isCellInCrossZone(_arg_1:SpellZone, _arg_2:Array, _arg_3:Boolean, _arg_4:int, _arg_5:int, _arg_6:int):Boolean
        {
            var _local_7:int = int(Math.floor((_arg_5 / MapTools.MAP_GRID_WIDTH)));
            var _local_8:int = int(Math.floor(((_local_7 + 1) / 2)));
            var _local_9:* = (_arg_5 - (_local_7 * MapTools.MAP_GRID_WIDTH));
            var _local_10:int = int(Math.floor((_arg_5 / MapTools.MAP_GRID_WIDTH)));
            var _local_11:int = int(Math.floor(((_local_10 + 1) / 2)));
            var _local_12:* = (_local_10 - _local_11);
            var _local_13:* = (_arg_5 - (_local_10 * MapTools.MAP_GRID_WIDTH));
            var _local_14:int = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
            var _local_15:int = int(Math.floor(((_local_14 + 1) / 2)));
            var _local_16:* = (_arg_4 - (_local_14 * MapTools.MAP_GRID_WIDTH));
            var _local_17:int = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
            var _local_18:int = int(Math.floor(((_local_17 + 1) / 2)));
            var _local_19:* = (_local_17 - _local_18);
            var _local_20:* = (_arg_4 - (_local_17 * MapTools.MAP_GRID_WIDTH));
            var _local_21:int = MapTools.getLookDirection8ExactByCoord((_local_8 + _local_9), (_local_13 - _local_12), (_local_15 + _local_16), (_local_20 - _local_19));
            var _local_22:int = MapTools.getDistance(_arg_5, _arg_4);
            if (((MapDirection.isCardinal(_local_21)) && (_local_22 > 1)))
            {
                _local_22 = (_local_22 >> 1);
            };
            if ((((_arg_2.indexOf(_local_21) != (-1)) || (_local_22 == 0)) && (_local_22 >= (_arg_1.minRadius + (((_arg_3) && (_arg_1.minRadius == 0)) ? 1 : 0)))))
            {
                return (_local_22 <= _arg_1.radius);
            };
            return (false);
        }

        public static function fillPerpLineCells(_arg_1:SpellZone, _arg_2:int, _arg_3:int):Array
        {
            var _local_27:int;
            var _local_4:Array = [];
            var _local_5:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_6:int = int(Math.floor(((_local_5 + 1) / 2)));
            var _local_7:* = (_arg_3 - (_local_5 * MapTools.MAP_GRID_WIDTH));
            var _local_8:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_9:int = int(Math.floor(((_local_8 + 1) / 2)));
            var _local_10:* = (_local_8 - _local_9);
            var _local_11:* = (_arg_3 - (_local_8 * MapTools.MAP_GRID_WIDTH));
            var _local_12:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_13:int = int(Math.floor(((_local_12 + 1) / 2)));
            var _local_14:* = (_arg_2 - (_local_12 * MapTools.MAP_GRID_WIDTH));
            var _local_15:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_16:int = int(Math.floor(((_local_15 + 1) / 2)));
            var _local_17:* = (_local_15 - _local_16);
            var _local_18:* = (_arg_2 - (_local_15 * MapTools.MAP_GRID_WIDTH));
            var _local_19:int = MapTools.getLookDirection8ExactByCoord((_local_6 + _local_7), (_local_11 - _local_10), (_local_13 + _local_14), (_local_18 - _local_17));
            var _local_20:int = ((_local_19 + 2) % 8);
            var _local_21:int = (((_local_19 - 2) + 8) % 8);
            var _local_22:int = _arg_1.minRadius;
            if (_arg_1.minRadius == 0)
            {
                _local_22 = 1;
                if (MapTools.isValidCellId(_arg_2))
                {
                    _local_4.push(_arg_2);
                };
            };
            var _local_23:int = _arg_2;
            var _local_24:int = _arg_2;
            var _local_25:int = _local_22;
            var _local_26:* = (_arg_1.radius + 1);
            while (_local_25 < _local_26)
            {
                _local_27 = _local_25++;
                _local_23 = MapTools.getNextCellByDirection(_local_23, _local_20);
                _local_24 = MapTools.getNextCellByDirection(_local_24, _local_21);
                if (MapTools.isValidCellId(_local_23))
                {
                    _local_4.push(_local_23);
                };
                if (MapTools.isValidCellId(_local_24))
                {
                    _local_4.push(_local_24);
                };
            };
            return (_local_4);
        }

        public static function isCellInPerpLineZone(_arg_1:SpellZone, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            var _local_5:int = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
            var _local_6:int = int(Math.floor(((_local_5 + 1) / 2)));
            var _local_7:* = (_arg_4 - (_local_5 * MapTools.MAP_GRID_WIDTH));
            var _local_8:int = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
            var _local_9:int = int(Math.floor(((_local_8 + 1) / 2)));
            var _local_10:* = (_local_8 - _local_9);
            var _local_11:* = (_arg_4 - (_local_8 * MapTools.MAP_GRID_WIDTH));
            var _local_12:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_13:int = int(Math.floor(((_local_12 + 1) / 2)));
            var _local_14:* = (_arg_3 - (_local_12 * MapTools.MAP_GRID_WIDTH));
            var _local_15:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_16:int = int(Math.floor(((_local_15 + 1) / 2)));
            var _local_17:* = (_local_15 - _local_16);
            var _local_18:* = (_arg_3 - (_local_15 * MapTools.MAP_GRID_WIDTH));
            var _local_19:int = MapTools.getLookDirection8ExactByCoord((_local_6 + _local_7), (_local_11 - _local_10), (_local_13 + _local_14), (_local_18 - _local_17));
            var _local_20:int = ((_local_19 + 2) % 8);
            var _local_21:int = (((_local_19 - 2) + 8) % 8);
            var _local_22:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_23:int = int(Math.floor(((_local_22 + 1) / 2)));
            var _local_24:* = (_arg_3 - (_local_22 * MapTools.MAP_GRID_WIDTH));
            var _local_25:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_26:int = int(Math.floor(((_local_25 + 1) / 2)));
            var _local_27:* = (_local_25 - _local_26);
            var _local_28:* = (_arg_3 - (_local_25 * MapTools.MAP_GRID_WIDTH));
            var _local_29:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_30:int = int(Math.floor(((_local_29 + 1) / 2)));
            var _local_31:* = (_arg_2 - (_local_29 * MapTools.MAP_GRID_WIDTH));
            var _local_32:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_33:int = int(Math.floor(((_local_32 + 1) / 2)));
            var _local_34:* = (_local_32 - _local_33);
            var _local_35:* = (_arg_2 - (_local_32 * MapTools.MAP_GRID_WIDTH));
            var _local_36:int = MapTools.getLookDirection8ExactByCoord((_local_23 + _local_24), (_local_28 - _local_27), (_local_30 + _local_31), (_local_35 - _local_34));
            var _local_37:int = MapTools.getDistance(_arg_3, _arg_2);
            if (((MapDirection.isCardinal(_local_36)) && (_local_37 > 1)))
            {
                _local_37 = (_local_37 >> 1);
            };
            if (((((_local_36 == (_local_20)) || (_local_36 == _local_21)) || (_local_37 == 0)) && (_local_37 >= _arg_1.minRadius)))
            {
                return (_local_37 <= _arg_1.radius);
            };
            return (false);
        }

        public static function fillConeCells(_arg_1:SpellZone, _arg_2:int, _arg_3:int):Array
        {
            var _local_25:int;
            var _local_26:int;
            var _local_27:int;
            var _local_28:int;
            var _local_29:int;
            var _local_30:int;
            var _local_4:Array = [];
            var _local_5:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_6:int = int(Math.floor(((_local_5 + 1) / 2)));
            var _local_7:* = (_arg_3 - (_local_5 * MapTools.MAP_GRID_WIDTH));
            var _local_8:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_9:int = int(Math.floor(((_local_8 + 1) / 2)));
            var _local_10:* = (_local_8 - _local_9);
            var _local_11:* = (_arg_3 - (_local_8 * MapTools.MAP_GRID_WIDTH));
            var _local_12:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_13:int = int(Math.floor(((_local_12 + 1) / 2)));
            var _local_14:* = (_arg_2 - (_local_12 * MapTools.MAP_GRID_WIDTH));
            var _local_15:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_16:int = int(Math.floor(((_local_15 + 1) / 2)));
            var _local_17:* = (_local_15 - _local_16);
            var _local_18:* = (_arg_2 - (_local_15 * MapTools.MAP_GRID_WIDTH));
            var _local_19:int = MapTools.getLookDirection8ExactByCoord((_local_6 + _local_7), (_local_11 - _local_10), (_local_13 + _local_14), (_local_18 - _local_17));
            var _local_20:int = ((_local_19 + 2) % 8);
            var _local_21:int = (((_local_19 - 2) + 8) % 8);
            var _local_22:int = _arg_2;
            var _local_23:int;
            var _local_24:* = (_arg_1.radius + 1);
            while (_local_23 < _local_24)
            {
                _local_25 = _local_23++;
                _local_4.push(_local_22);
                _local_26 = _local_22;
                _local_27 = _local_22;
                _local_28 = 0;
                _local_29 = _local_25;
                while (_local_28 < _local_29)
                {
                    _local_30 = _local_28++;
                    _local_26 = MapTools.getNextCellByDirection(_local_26, _local_20);
                    _local_27 = MapTools.getNextCellByDirection(_local_27, _local_21);
                    if (MapTools.isValidCellId(_local_26))
                    {
                        _local_4.push(_local_26);
                    };
                    if (MapTools.isValidCellId(_local_27))
                    {
                        _local_4.push(_local_27);
                    };
                };
                _local_22 = MapTools.getNextCellByDirection(_local_22, _local_19);
            };
            return (_local_4);
        }

        public static function isCellInConeZone(_arg_1:SpellZone, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            var _local_5:int = MapTools.getLookDirection4(_arg_4, _arg_3);
            var _local_6:Point = MapTools.getCellCoordById(_arg_3);
            var _local_7:Point = MapTools.getCellCoordById(_arg_2);
            var _local_8:* = (_local_7.x - _local_6.x);
            var _local_9:* = (_local_7.y - _local_6.y);
            var _local_10:Function = function (_arg_1:int):int
            {
                if (_arg_1 < 0)
                {
                    return (-(_arg_1));
                };
                return (_arg_1);
            };
            switch (_local_5)
            {
                default:
                    return (false);
                case 1:
                    if (((_local_8 >= (0)) && (_local_8 <= _arg_1.radius)))
                    {
                        return (_local_10(_local_9) <= _local_8);
                    };
                    return (false);
                case 3:
                    if (((_local_9 <= (0)) && (_local_9 >= -(_arg_1.radius))))
                    {
                        return (_local_10(_local_8) <= -(_local_9));
                    };
                    return (false);
                case 5:
                    if (((_local_8 <= (0)) && (_local_8 >= -(_arg_1.radius))))
                    {
                        return (_local_10(_local_9) <= -(_local_8));
                    };
                    return (false);
                case 7:
                    if (((_local_9 >= (0)) && (_local_9 <= _arg_1.radius)))
                    {
                        return (_local_10(_local_8) <= _local_9);
                    };
                    return (false);
                    return; //dead code
            };
        }

        public static function fillSquareCells(_arg_1:SpellZone, _arg_2:Boolean, _arg_3:int, _arg_4:int):Array
        {
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_5:Array = [];
            var _local_6:Point = MapTools.getCellCoordById(_arg_3);
            var _local_7:int = -(_arg_1.radius);
            var _local_8:* = (_arg_1.radius + 1);
            while (_local_7 < _local_8)
            {
                _local_9 = _local_7++;
                _local_10 = -(_arg_1.radius);
                _local_11 = (_arg_1.radius + 1);
                while (_local_10 < _local_11)
                {
                    _local_12 = _local_10++;
                    if (((MapTools.isValidCoord((_local_6.x + _local_9), (_local_6.y + _local_12))) && ((!(_arg_2)) || (!(Math.abs(_local_9) == Math.abs(_local_12))))))
                    {
                        _local_5.push(MapTools.getCellIdByCoord((_local_6.x + _local_9), (_local_6.y + _local_12)));
                    };
                };
            };
            return (_local_5);
        }

        public static function isCellInSquareZone(_arg_1:SpellZone, _arg_2:Boolean, _arg_3:int, _arg_4:int, _arg_5:int):Boolean
        {
            var _local_6:Point = MapTools.getCellCoordById(_arg_4);
            var _local_7:Point = MapTools.getCellCoordById(_arg_3);
            var _local_8:Function = function (_arg_1:int):int
            {
                if (_arg_1 < 0)
                {
                    return (-(_arg_1));
                };
                return (_arg_1);
            };
            var _local_9:int = _local_8((_local_7.x - _local_6.x));
            var _local_10:int = _local_8((_local_7.y - _local_6.y));
            if ((((((!(_arg_2)) || (!(_local_9 == _local_10))) && (_local_9 <= _arg_1.radius)) && (_local_10 <= _arg_1.radius)) && (_local_9 >= _arg_1.minRadius)))
            {
                return (_local_10 >= _arg_1.minRadius);
            };
            return (false);
        }

        public static function fillHalfCircle(_arg_1:SpellZone, _arg_2:int, _arg_3:int):Array
        {
            var _local_27:int;
            var _local_4:Array = [];
            var _local_5:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_6:int = int(Math.floor(((_local_5 + 1) / 2)));
            var _local_7:* = (_arg_3 - (_local_5 * MapTools.MAP_GRID_WIDTH));
            var _local_8:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_9:int = int(Math.floor(((_local_8 + 1) / 2)));
            var _local_10:* = (_local_8 - _local_9);
            var _local_11:* = (_arg_3 - (_local_8 * MapTools.MAP_GRID_WIDTH));
            var _local_12:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_13:int = int(Math.floor(((_local_12 + 1) / 2)));
            var _local_14:* = (_arg_2 - (_local_12 * MapTools.MAP_GRID_WIDTH));
            var _local_15:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_16:int = int(Math.floor(((_local_15 + 1) / 2)));
            var _local_17:* = (_local_15 - _local_16);
            var _local_18:* = (_arg_2 - (_local_15 * MapTools.MAP_GRID_WIDTH));
            var _local_19:int = MapTools.getLookDirection8ExactByCoord((_local_6 + _local_7), (_local_11 - _local_10), (_local_13 + _local_14), (_local_18 - _local_17));
            var _local_20:int = ((_local_19 + 3) % 8);
            var _local_21:int = (((_local_19 - 3) + 8) % 8);
            var _local_22:int = _arg_1.minRadius;
            if (_arg_1.minRadius == 0)
            {
                _local_22 = 1;
                _local_4.push(_arg_2);
            };
            var _local_23:int = _arg_2;
            var _local_24:int = _arg_2;
            var _local_25:int = _local_22;
            var _local_26:* = (_arg_1.radius + 1);
            while (_local_25 < _local_26)
            {
                _local_27 = _local_25++;
                _local_23 = MapTools.getNextCellByDirection(_local_23, _local_20);
                _local_24 = MapTools.getNextCellByDirection(_local_24, _local_21);
                if (MapTools.isValidCellId(_local_23))
                {
                    _local_4.push(_local_23);
                };
                if (MapTools.isValidCellId(_local_24))
                {
                    _local_4.push(_local_24);
                };
            };
            return (_local_4);
        }

        public static function isCellInHalfCircleZone(_arg_1:SpellZone, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            var _local_5:int = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
            var _local_6:int = int(Math.floor(((_local_5 + 1) / 2)));
            var _local_7:* = (_arg_4 - (_local_5 * MapTools.MAP_GRID_WIDTH));
            var _local_8:int = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
            var _local_9:int = int(Math.floor(((_local_8 + 1) / 2)));
            var _local_10:* = (_local_8 - _local_9);
            var _local_11:* = (_arg_4 - (_local_8 * MapTools.MAP_GRID_WIDTH));
            var _local_12:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_13:int = int(Math.floor(((_local_12 + 1) / 2)));
            var _local_14:* = (_arg_3 - (_local_12 * MapTools.MAP_GRID_WIDTH));
            var _local_15:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_16:int = int(Math.floor(((_local_15 + 1) / 2)));
            var _local_17:* = (_local_15 - _local_16);
            var _local_18:* = (_arg_3 - (_local_15 * MapTools.MAP_GRID_WIDTH));
            var _local_19:int = MapTools.getLookDirection8ExactByCoord((_local_6 + _local_7), (_local_11 - _local_10), (_local_13 + _local_14), (_local_18 - _local_17));
            var _local_20:int = (((_local_19 - 3) + 8) % 8);
            var _local_21:int = ((_local_19 + 3) % 8);
            var _local_22:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_23:int = int(Math.floor(((_local_22 + 1) / 2)));
            var _local_24:* = (_arg_3 - (_local_22 * MapTools.MAP_GRID_WIDTH));
            var _local_25:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_26:int = int(Math.floor(((_local_25 + 1) / 2)));
            var _local_27:* = (_local_25 - _local_26);
            var _local_28:* = (_arg_3 - (_local_25 * MapTools.MAP_GRID_WIDTH));
            var _local_29:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_30:int = int(Math.floor(((_local_29 + 1) / 2)));
            var _local_31:* = (_arg_2 - (_local_29 * MapTools.MAP_GRID_WIDTH));
            var _local_32:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_33:int = int(Math.floor(((_local_32 + 1) / 2)));
            var _local_34:* = (_local_32 - _local_33);
            var _local_35:* = (_arg_2 - (_local_32 * MapTools.MAP_GRID_WIDTH));
            var _local_36:int = MapTools.getLookDirection8ExactByCoord((_local_23 + _local_24), (_local_28 - _local_27), (_local_30 + _local_31), (_local_35 - _local_34));
            var _local_37:int = MapTools.getDistance(_arg_3, _arg_2);
            if (((MapDirection.isCardinal(_local_36)) && (_local_37 > 1)))
            {
                _local_37 = (_local_37 >> 1);
            };
            if (((((_local_20 == (_local_36)) || (_local_21 == _local_36)) || (_local_37 == 0)) && (_local_37 <= _arg_1.radius)))
            {
                return (_local_37 >= _arg_1.minRadius);
            };
            return (false);
        }

        public static function fillBoomerang(_arg_1:SpellZone, _arg_2:int, _arg_3:int):Array
        {
            var _local_29:int;
            var _local_4:Array = [];
            var _local_5:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_6:int = int(Math.floor(((_local_5 + 1) / 2)));
            var _local_7:* = (_arg_3 - (_local_5 * MapTools.MAP_GRID_WIDTH));
            var _local_8:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_9:int = int(Math.floor(((_local_8 + 1) / 2)));
            var _local_10:* = (_local_8 - _local_9);
            var _local_11:* = (_arg_3 - (_local_8 * MapTools.MAP_GRID_WIDTH));
            var _local_12:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_13:int = int(Math.floor(((_local_12 + 1) / 2)));
            var _local_14:* = (_arg_2 - (_local_12 * MapTools.MAP_GRID_WIDTH));
            var _local_15:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_16:int = int(Math.floor(((_local_15 + 1) / 2)));
            var _local_17:* = (_local_15 - _local_16);
            var _local_18:* = (_arg_2 - (_local_15 * MapTools.MAP_GRID_WIDTH));
            var _local_19:int = MapTools.getLookDirection8ExactByCoord((_local_6 + _local_7), (_local_11 - _local_10), (_local_13 + _local_14), (_local_18 - _local_17));
            var _local_20:int = ((_local_19 + 2) % 8);
            var _local_21:int = ((_local_19 + 3) % 8);
            var _local_22:int = (((_local_19 - 2) + 8) % 8);
            var _local_23:int = (((_local_19 - 3) + 8) % 8);
            var _local_24:int = _arg_1.minRadius;
            if (_arg_1.minRadius == 0)
            {
                _local_24 = 1;
                _local_4.push(_arg_2);
            };
            var _local_25:int = _arg_2;
            var _local_26:int = _arg_2;
            var _local_27:int = _local_24;
            var _local_28:int = _arg_1.radius;
            while (_local_27 < _local_28)
            {
                _local_29 = _local_27++;
                _local_25 = MapTools.getNextCellByDirection(_local_25, _local_20);
                _local_26 = MapTools.getNextCellByDirection(_local_26, _local_22);
                if (MapTools.isValidCellId(_local_25))
                {
                    _local_4.push(_local_25);
                };
                if (MapTools.isValidCellId(_local_26))
                {
                    _local_4.push(_local_26);
                };
            };
            if (_arg_1.radius != 0)
            {
                _local_25 = MapTools.getNextCellByDirection(_local_25, _local_21);
                _local_26 = MapTools.getNextCellByDirection(_local_26, _local_23);
                if (MapTools.isValidCellId(_local_25))
                {
                    _local_4.push(_local_25);
                };
                if (MapTools.isValidCellId(_local_26))
                {
                    _local_4.push(_local_26);
                };
            };
            return (_local_4);
        }

        public static function isCellInBoomerangZone(_arg_1:SpellZone, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            var _local_5:int = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
            var _local_6:int = int(Math.floor(((_local_5 + 1) / 2)));
            var _local_7:* = (_arg_4 - (_local_5 * MapTools.MAP_GRID_WIDTH));
            var _local_8:int = int(Math.floor((_arg_4 / MapTools.MAP_GRID_WIDTH)));
            var _local_9:int = int(Math.floor(((_local_8 + 1) / 2)));
            var _local_10:* = (_local_8 - _local_9);
            var _local_11:* = (_arg_4 - (_local_8 * MapTools.MAP_GRID_WIDTH));
            var _local_12:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_13:int = int(Math.floor(((_local_12 + 1) / 2)));
            var _local_14:* = (_arg_3 - (_local_12 * MapTools.MAP_GRID_WIDTH));
            var _local_15:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_16:int = int(Math.floor(((_local_15 + 1) / 2)));
            var _local_17:* = (_local_15 - _local_16);
            var _local_18:* = (_arg_3 - (_local_15 * MapTools.MAP_GRID_WIDTH));
            var _local_19:int = MapTools.getLookDirection8ExactByCoord((_local_6 + _local_7), (_local_11 - _local_10), (_local_13 + _local_14), (_local_18 - _local_17));
            var _local_20:int = ((_local_19 + 2) % 8);
            var _local_21:int = (((_local_19 - 2) + 8) % 8);
            var _local_22:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_23:int = int(Math.floor(((_local_22 + 1) / 2)));
            var _local_24:* = (_arg_3 - (_local_22 * MapTools.MAP_GRID_WIDTH));
            var _local_25:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_26:int = int(Math.floor(((_local_25 + 1) / 2)));
            var _local_27:* = (_local_25 - _local_26);
            var _local_28:* = (_arg_3 - (_local_25 * MapTools.MAP_GRID_WIDTH));
            var _local_29:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_30:int = int(Math.floor(((_local_29 + 1) / 2)));
            var _local_31:* = (_arg_2 - (_local_29 * MapTools.MAP_GRID_WIDTH));
            var _local_32:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_33:int = int(Math.floor(((_local_32 + 1) / 2)));
            var _local_34:* = (_local_32 - _local_33);
            var _local_35:* = (_arg_2 - (_local_32 * MapTools.MAP_GRID_WIDTH));
            var _local_36:int = MapTools.getLookDirection8ExactByCoord((_local_23 + _local_24), (_local_28 - _local_27), (_local_30 + _local_31), (_local_35 - _local_34));
            var _local_37:int = MapTools.getDistance(_arg_3, _arg_2);
            if (((MapDirection.isCardinal(_local_36)) && (_local_37 > 1)))
            {
                _local_37 = (_local_37 >> 1);
            };
            if ((((((_local_36 == (_local_20)) || (_local_36 == _local_21)) || (_local_37 == 0)) && (_local_37 >= _arg_1.minRadius)) && (_local_37 < _arg_1.radius)))
            {
                return (true);
            };
            _arg_2 = MapTools.getNextCellByDirection(_arg_2, _local_19);
            var _local_38:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_39:int = int(Math.floor(((_local_38 + 1) / 2)));
            var _local_40:* = (_arg_3 - (_local_38 * MapTools.MAP_GRID_WIDTH));
            var _local_41:int = int(Math.floor((_arg_3 / MapTools.MAP_GRID_WIDTH)));
            var _local_42:int = int(Math.floor(((_local_41 + 1) / 2)));
            var _local_43:* = (_local_41 - _local_42);
            var _local_44:* = (_arg_3 - (_local_41 * MapTools.MAP_GRID_WIDTH));
            var _local_45:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_46:int = int(Math.floor(((_local_45 + 1) / 2)));
            var _local_47:* = (_arg_2 - (_local_45 * MapTools.MAP_GRID_WIDTH));
            var _local_48:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_49:int = int(Math.floor(((_local_48 + 1) / 2)));
            var _local_50:* = (_local_48 - _local_49);
            var _local_51:* = (_arg_2 - (_local_48 * MapTools.MAP_GRID_WIDTH));
            _local_36 = MapTools.getLookDirection8ExactByCoord((_local_39 + _local_40), (_local_44 - _local_43), (_local_46 + _local_47), (_local_51 - _local_50));
            _local_37 = MapTools.getDistance(_arg_3, _arg_2);
            if (((MapDirection.isCardinal(_local_36)) && (_local_37 > 1)))
            {
                _local_37 = (_local_37 >> 1);
            };
            if (((((_local_36 == (_local_20)) || (_local_36 == _local_21)) && (!(_local_37 == 0))) && (_local_37 >= _arg_1.minRadius)))
            {
                return (_local_37 == _arg_1.radius);
            };
            return (false);
        }

        public static function fillWholeMap(_arg_1:int, _arg_2:int):Array
        {
            return (MapTools.EVERY_CELL_ID);
        }

        public static function isCellInWholeMapZone(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            return (true);
        }

        public static function fillReversedTrueCircleCells(_arg_1:SpellZone, _arg_2:int, _arg_3:int):Array
        {
            var _local_9:int;
            var _local_10:* = (null as Point);
            var _local_11:* = (null as Point);
            var _local_4:Array = [];
            var _local_5:Point = MapTools.getCellCoordById(_arg_2);
            if (!(_arg_1.radius is Number))
            {
                throw ("Class cast error");
            };
            var _local_6:Number = _arg_1.radius;
            var _local_7:int;
            var _local_8:int = MapTools.mapCountCell;
            while (_local_7 < _local_8)
            {
                _local_9 = _local_7++;
                _local_10 = MapTools.getCellCoordById(_local_9);
                _local_11 = new Point((_local_10.x - _local_5.x), (_local_10.y - _local_5.y));
                if (Math.sqrt(((_local_11.x * _local_11.x) + (_local_11.y * _local_11.y))) >= _local_6)
                {
                    _local_4.push(_local_9);
                };
            };
            return (_local_4);
        }

        public static function isCellInReversedTrueCircleZone(_arg_1:SpellZone, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            var _local_5:Point = MapTools.getCellCoordById(_arg_3);
            var _local_6:Point = MapTools.getCellCoordById(_arg_2);
            var _local_7:Point = new Point((_local_6.x - _local_5.x), (_local_6.y - _local_5.y));
            return (Math.sqrt(((_local_7.x * _local_7.x) + (_local_7.y * _local_7.y))) >= _arg_1.radius);
        }

        public static function hasMinSize(_arg_1:String):Boolean
        {
            var _local_2:String = _arg_1;
                
            outer_block:
            {

                if (_local_2 != "#")
                {
                    if (_local_2 != "+")
                    {
                        if (_local_2 != "C")
                        {
                            if (_local_2 != "Q")
                            {
                                if (_local_2 != "X")
                                {
                                    if (_local_2 != "l") return (false); //break outer_block;
                                };
                            };
                        };
                    };
                };
                return (true);
            
            }//outer_block
            return (false);
        }


        public function getAOEMalus(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:int;
            var _local_6:* = (null as Point);
            var _local_7:* = (null as Point);
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:int;
            var _local_19:int;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            if (radius > SpellZone.MAX_RADIUS_DEGRESSION)
            {
                return (0);
            };
            var _local_5:String = shape;
            if (_local_5 != ";")
            {
                if (_local_5 != "A")
                {
                    if (_local_5 != "I")
                    {
                        if (_local_5 != "a") goto _label_1;
                    };
                };
            };
            _local_4 = 0;
            goto _label_3;
            
        _label_1: 
            if( (_local_5 == "G") || (_local_5 == "W") )
            {
                _local_6 = MapTools.getCellCoordById(_arg_1);
                _local_7 = MapTools.getCellCoordById(_arg_3);
                if (!(Math.abs((_local_6.x - _local_7.x)) is Number))
                {
                    throw ("Class cast error");
                };
                _local_8 = Math.abs((_local_6.x - _local_7.x));
                if (!(Math.abs((_local_6.y - _local_7.y)) is Number))
                {
                    throw ("Class cast error");
                };
                _local_9 = Math.abs((_local_6.y - _local_7.y));
                _local_4 = ((_local_8 > _local_9) ? _local_8 : _local_9);
                goto _label_3;
            };
            if (_local_5 != "#")
            {
                if (_local_5 != "+")
                {
                    if (_local_5 != "-")
                    {
                        if (_local_5 != "/")
                        {
                            if (_local_5 != "U") goto _label_2;
                        };
                    };
                };
            };
            _local_4 = (MapTools.getDistance(_arg_1, _arg_3) >> 1);
            goto _label_3;
            
        _label_2: 
            if (_local_5 == "V")
            {
                _local_8 = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
                _local_9 = int(Math.floor(((_local_8 + 1) / 2)));
                _local_10 = (_arg_2 - (_local_8 * MapTools.MAP_GRID_WIDTH));
                _local_11 = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
                _local_12 = int(Math.floor(((_local_11 + 1) / 2)));
                _local_13 = (_local_11 - _local_12);
                _local_14 = (_arg_2 - (_local_11 * MapTools.MAP_GRID_WIDTH));
                _local_15 = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
                _local_16 = int(Math.floor(((_local_15 + 1) / 2)));
                _local_17 = (_arg_1 - (_local_15 * MapTools.MAP_GRID_WIDTH));
                _local_18 = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
                _local_19 = int(Math.floor(((_local_18 + 1) / 2)));
                _local_20 = (_local_18 - _local_19);
                _local_21 = (_arg_1 - (_local_18 * MapTools.MAP_GRID_WIDTH));
                _local_22 = MapTools.getLookDirection8ExactByCoord((_local_9 + _local_10), (_local_14 - _local_13), (_local_16 + _local_17), (_local_21 - _local_20));
                _local_6 = MapTools.getCellCoordById(_arg_1);
                _local_7 = MapTools.getCellCoordById(_arg_3);
                switch (_local_22)
                {
                    default:
                        _local_4 = 0;
                        break;
                    case 1:
                    case 5:
                        if (!(Math.abs((_local_6.x - _local_7.x)) is Number))
                        {
                            throw ("Class cast error");
                        };
                        _local_4 = Math.abs((_local_6.x - _local_7.x));
                        break;
                    case 2:
                    case 6:
                        if (!(Math.abs((Math.abs((_local_6.x - _local_6.y)) - Math.abs((_local_7.x - _local_7.y)))) is Number))
                        {
                            throw ("Class cast error");
                        };
                        _local_4 = Math.abs((Math.abs((_local_6.x - _local_6.y)) - Math.abs((_local_7.x - _local_7.y))));
                        break;
                    case 3:
                    case 7:
                        if (!(Math.abs((_local_6.y - _local_7.y)) is Number))
                        {
                            throw ("Class cast error");
                        };
                        _local_4 = Math.abs((_local_6.y - _local_7.y));
                        break;
                    case 0:
                    case 4:
                        if (!(Math.abs((Math.abs((_local_6.x - _local_6.y)) + Math.abs((_local_7.x - _local_7.y)))) is Number))
                        {
                            throw ("Class cast error");
                        };
                        _local_4 = Math.abs((Math.abs((_local_6.x - _local_6.y)) + Math.abs((_local_7.x - _local_7.y))));
                };
            }
            else
            {
                _local_4 = MapTools.getDistance(_arg_1, _arg_3);
            };
            
        _label_3: 
            if (_local_4 < 0)
            {
                _local_4 = 0;
            };
            if (!(Math.min((Math.min((_local_4 - minRadius), maxDegressionTicks) * degression), 100) is Number))
            {
                throw ("Class cast error");
            };
            return (Math.min((Math.min((_local_4 - minRadius), maxDegressionTicks) * degression), 100));
        }


    }
}

