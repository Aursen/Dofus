package mapTools
{
    import damageCalculation.FightContext;
    import tools.FpUtils;
    import flash.geom.Point;

    public class MapTools 
    {

        public static var MAP_GRID_WIDTH:int;
        public static var MAP_GRID_HEIGHT:int;
        public static var MIN_X_COORD:int;
        public static var MAX_X_COORD:int;
        public static var MIN_Y_COORD:int;
        public static var MAX_Y_COORD:int;
        public static var EVERY_CELL_ID:Array;
        public static var mapCountCell:int;
        public static var isInit:Boolean = false;
        public static var INVALID_CELL_ID:int = -1;
        public static var COEFF_FOR_REBASE_ON_CLOSEST_8_DIRECTION:Number = Math.tan((Math.PI / 8));
        public static var COORDINATES_DIRECTION:Array = _local_1;

        public function MapTools():void
        {
        }

        public static function init(_arg_1:MapToolsConfig):void
        {
            var _local_5:int;
            MapTools.MAP_GRID_WIDTH = _arg_1.mapGridWidth;
            MapTools.MAP_GRID_HEIGHT = _arg_1.mapGridHeight;
            MapTools.MIN_X_COORD = _arg_1.minXCoord;
            MapTools.MAX_X_COORD = _arg_1.maxXCoord;
            MapTools.MIN_Y_COORD = _arg_1.minYCoord;
            MapTools.MAX_Y_COORD = _arg_1.maxYCoord;
            MapTools.mapCountCell = ((MapTools.MAP_GRID_WIDTH * MapTools.MAP_GRID_HEIGHT) * 2);
            var _local_2:Array = [];
            var _local_3:int;
            var _local_4:int = MapTools.mapCountCell;
            while (_local_3 < _local_4)
            {
                _local_5 = _local_3++;
                _local_2.push(_local_5);
            };
            MapTools.EVERY_CELL_ID = _local_2;
            MapTools.isInit = true;
        }

        public static function getCellCoordById(_arg_1:int):mapTools.Point
        {
            if (!MapTools.isValidCellId(_arg_1))
            {
                return (null);
            };
            var _local_2:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_3:int = int(Math.floor(((_local_2 + 1) / 2)));
            var _local_4:* = (_local_2 - _local_3);
            var _local_5:* = (_arg_1 - (_local_2 * MapTools.MAP_GRID_WIDTH));
            return (new mapTools.Point((_local_3 + _local_5), (_local_5 - _local_4)));
        }

        public static function getCellIdXCoord(_arg_1:int):int
        {
            var _local_2:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_3:int = int(Math.floor(((_local_2 + 1) / 2)));
            var _local_4:* = (_arg_1 - (_local_2 * MapTools.MAP_GRID_WIDTH));
            return (_local_3 + _local_4);
        }

        public static function getCellIdYCoord(_arg_1:int):int
        {
            var _local_2:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_3:int = int(Math.floor(((_local_2 + 1) / 2)));
            var _local_4:* = (_local_2 - _local_3);
            var _local_5:* = (_arg_1 - (_local_2 * MapTools.MAP_GRID_WIDTH));
            return (_local_5 - _local_4);
        }

        public static function getCellIdByCoord(_arg_1:int, _arg_2:int):int
        {
            if (!MapTools.isValidCoord(_arg_1, _arg_2))
            {
                return (-1);
            };
            return (int(Math.floor(((((_arg_1 - _arg_2) * MapTools.MAP_GRID_WIDTH) + _arg_2) + ((_arg_1 - _arg_2) / 2)))));
        }

        public static function floatAlmostEquals(_arg_1:Number, _arg_2:Number):Boolean
        {
            if (_arg_1 != _arg_2)
            {
                return (Math.abs((_arg_1 - _arg_2)) < 0.0001);
            };
            return (true);
        }

        public static function getCellsIdBetween(_arg_1:int, _arg_2:int):Array
        {
            if (_arg_1 == _arg_2)
            {
                return ([]);
            };
            if (((!(MapTools.isValidCellId(_arg_1))) || (!(MapTools.isValidCellId(_arg_2)))))
            {
                return ([]);
            };
            var _local_3:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_4:int = int(Math.floor(((_local_3 + 1) / 2)));
            var _local_5:* = (_arg_1 - (_local_3 * MapTools.MAP_GRID_WIDTH));
            var _local_6:* = (_local_4 + _local_5);
            var _local_7:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_8:int = int(Math.floor(((_local_7 + 1) / 2)));
            var _local_9:* = (_local_7 - _local_8);
            var _local_10:* = (_arg_1 - (_local_7 * MapTools.MAP_GRID_WIDTH));
            var _local_11:* = (_local_10 - _local_9);
            var _local_12:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_13:int = int(Math.floor(((_local_12 + 1) / 2)));
            var _local_14:* = (_arg_2 - (_local_12 * MapTools.MAP_GRID_WIDTH));
            var _local_15:* = (_local_13 + _local_14);
            var _local_16:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_17:int = int(Math.floor(((_local_16 + 1) / 2)));
            var _local_18:* = (_local_16 - _local_17);
            var _local_19:* = (_arg_2 - (_local_16 * MapTools.MAP_GRID_WIDTH));
            var _local_20:* = (_local_19 - _local_18);
            var _local_21:* = (_local_15 - _local_6);
            var _local_22:* = (_local_20 - _local_11);
            var _local_23:Number = Math.sqrt(((_local_21 * _local_21) + (_local_22 * _local_22)));
            var _local_24:Number = (_local_21 / _local_23);
            var _local_25:Number = (_local_22 / _local_23);
            var _local_26:Number = Math.abs((1 / _local_24));
            var _local_27:Number = Math.abs((1 / _local_25));
            var _local_28:int = ((_local_24 < 0) ? -1 : 1);
            var _local_29:int = ((_local_25 < 0) ? -1 : 1);
            var _local_30:Number = (0.5 * _local_26);
            var _local_31:Number = (0.5 * _local_27);
            var _local_32:Array = [];
            while (((_local_6 != (_local_15)) || (!(_local_11 == _local_20))))
            {
                if (MapTools.floatAlmostEquals(_local_30, _local_31))
                {
                    _local_30 = (_local_30 + _local_26);
                    _local_31 = (_local_31 + _local_27);
                    _local_6 = (_local_6 + _local_28);
                    _local_11 = (_local_11 + _local_29);
                }
                else
                {
                    if (_local_30 < _local_31)
                    {
                        _local_30 = (_local_30 + _local_26);
                        _local_6 = (_local_6 + _local_28);
                    }
                    else
                    {
                        _local_31 = (_local_31 + _local_27);
                        _local_11 = (_local_11 + _local_29);
                    };
                };
                _local_32.push(MapTools.getCellIdByCoord(_local_6, _local_11));
            };
            return (_local_32);
        }

        public static function getCellsIdOnLargeWay(_arg_1:int, _arg_2:int):Array
        {
            var _local_21:int;
            var _local_3:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_4:int = int(Math.floor(((_local_3 + 1) / 2)));
            var _local_5:* = (_arg_1 - (_local_3 * MapTools.MAP_GRID_WIDTH));
            var _local_6:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_7:int = int(Math.floor(((_local_6 + 1) / 2)));
            var _local_8:* = (_local_6 - _local_7);
            var _local_9:* = (_arg_1 - (_local_6 * MapTools.MAP_GRID_WIDTH));
            var _local_10:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_11:int = int(Math.floor(((_local_10 + 1) / 2)));
            var _local_12:* = (_arg_2 - (_local_10 * MapTools.MAP_GRID_WIDTH));
            var _local_13:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_14:int = int(Math.floor(((_local_13 + 1) / 2)));
            var _local_15:* = (_local_13 - _local_14);
            var _local_16:* = (_arg_2 - (_local_13 * MapTools.MAP_GRID_WIDTH));
            var _local_17:int = MapTools.getLookDirection8ExactByCoord((_local_4 + _local_5), (_local_9 - _local_8), (_local_11 + _local_12), (_local_16 - _local_15));
            if (!MapDirection.isValidDirection(_local_17))
            {
                return ([]);
            };
            var _local_18:Array = [_arg_1];
            var _local_19:int = _arg_1;
            var _local_20:int = 8;
            while (_local_19 != _arg_2)
            {
                if (MapDirection.isCardinal(_local_17))
                {
                    _local_21 = MapTools.getNextCellByDirection(_local_19, ((_local_17 + 1) % _local_20));
                    if (MapTools.isValidCellId(_local_21))
                    {
                        _local_18.push(_local_21);
                    };
                    _local_21 = MapTools.getNextCellByDirection(_local_19, (((_local_17 + _local_20) - 1) % _local_20));
                    if (MapTools.isValidCellId(_local_21))
                    {
                        _local_18.push(_local_21);
                    };
                };
                _local_19 = MapTools.getNextCellByDirection(_local_19, _local_17);
                _local_18.push(_local_19);
            };
            return (_local_18);
        }

        public static function isValidCellId(_arg_1:int):Boolean
        {
            if (!MapTools.isInit)
            {
                throw ("MapTools must be initiliazed with method .initForDofus2 or .initForDofus3");
            };
            if (_arg_1 >= 0)
            {
                return (_arg_1 < MapTools.mapCountCell);
            };
            return (false);
        }

        public static function isValidCoord(_arg_1:int, _arg_2:int):Boolean
        {
            if (!MapTools.isInit)
            {
                throw ("MapTools must be initiliazed with method .initForDofus2 or .initForDofus3");
            };
            if ((((_arg_2 >= (-(_arg_1))) && (_arg_2 <= _arg_1)) && (_arg_2 <= ((MapTools.MAP_GRID_WIDTH + MapTools.MAX_Y_COORD) - _arg_1))))
            {
                return (_arg_2 >= (_arg_1 - (MapTools.MAP_GRID_HEIGHT - MapTools.MIN_Y_COORD)));
            };
            return (false);
        }

        public static function isInDiag(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_4:int = int(Math.floor(((_local_3 + 1) / 2)));
            var _local_5:* = (_arg_1 - (_local_3 * MapTools.MAP_GRID_WIDTH));
            var _local_6:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_7:int = int(Math.floor(((_local_6 + 1) / 2)));
            var _local_8:* = (_local_6 - _local_7);
            var _local_9:* = (_arg_1 - (_local_6 * MapTools.MAP_GRID_WIDTH));
            var _local_10:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_11:int = int(Math.floor(((_local_10 + 1) / 2)));
            var _local_12:* = (_arg_2 - (_local_10 * MapTools.MAP_GRID_WIDTH));
            var _local_13:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_14:int = int(Math.floor(((_local_13 + 1) / 2)));
            var _local_15:* = (_local_13 - _local_14);
            var _local_16:* = (_arg_2 - (_local_13 * MapTools.MAP_GRID_WIDTH));
            return (MapTools.isInDiagByCoord((_local_4 + _local_5), (_local_9 - _local_8), (_local_11 + _local_12), (_local_16 - _local_15)));
        }

        public static function isInDiagByCoord(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            if (((!(MapTools.isValidCoord(_arg_1, _arg_2))) || (!(MapTools.isValidCoord(_arg_3, _arg_4)))))
            {
                return (false);
            };
            return (Math.floor(Math.abs((_arg_1 - _arg_3))) == Math.floor(Math.abs((_arg_2 - _arg_4))));
        }

        public static function getLookDirection4(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_4:int = int(Math.floor(((_local_3 + 1) / 2)));
            var _local_5:* = (_arg_1 - (_local_3 * MapTools.MAP_GRID_WIDTH));
            var _local_6:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_7:int = int(Math.floor(((_local_6 + 1) / 2)));
            var _local_8:* = (_local_6 - _local_7);
            var _local_9:* = (_arg_1 - (_local_6 * MapTools.MAP_GRID_WIDTH));
            var _local_10:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_11:int = int(Math.floor(((_local_10 + 1) / 2)));
            var _local_12:* = (_arg_2 - (_local_10 * MapTools.MAP_GRID_WIDTH));
            var _local_13:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_14:int = int(Math.floor(((_local_13 + 1) / 2)));
            var _local_15:* = (_local_13 - _local_14);
            var _local_16:* = (_arg_2 - (_local_13 * MapTools.MAP_GRID_WIDTH));
            return (MapTools.getLookDirection4ByCoord((_local_4 + _local_5), (_local_9 - _local_8), (_local_11 + _local_12), (_local_16 - _local_15)));
        }

        public static function getLookDirection4ByCoord(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):int
        {
            if (((!(MapTools.isValidCoord(_arg_1, _arg_2))) || (!(MapTools.isValidCoord(_arg_3, _arg_4)))))
            {
                return (-1);
            };
            var _local_5:* = (_arg_1 - _arg_3);
            var _local_6:* = (_arg_2 - _arg_4);
            if (Math.floor(Math.abs(_local_5)) > Math.floor(Math.abs(_local_6)))
            {
                if (_local_5 < 0)
                {
                    return (1);
                };
                return (5);
            };
            if (_local_6 < 0)
            {
                return (7);
            };
            return (3);
        }

        public static function getLookDirection4Exact(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_4:int = int(Math.floor(((_local_3 + 1) / 2)));
            var _local_5:* = (_arg_1 - (_local_3 * MapTools.MAP_GRID_WIDTH));
            var _local_6:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_7:int = int(Math.floor(((_local_6 + 1) / 2)));
            var _local_8:* = (_local_6 - _local_7);
            var _local_9:* = (_arg_1 - (_local_6 * MapTools.MAP_GRID_WIDTH));
            var _local_10:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_11:int = int(Math.floor(((_local_10 + 1) / 2)));
            var _local_12:* = (_arg_2 - (_local_10 * MapTools.MAP_GRID_WIDTH));
            var _local_13:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_14:int = int(Math.floor(((_local_13 + 1) / 2)));
            var _local_15:* = (_local_13 - _local_14);
            var _local_16:* = (_arg_2 - (_local_13 * MapTools.MAP_GRID_WIDTH));
            return (MapTools.getLookDirection4ExactByCoord((_local_4 + _local_5), (_local_9 - _local_8), (_local_11 + _local_12), (_local_16 - _local_15)));
        }

        public static function getLookDirection4ExactByCoord(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):int
        {
            if (((!(MapTools.isValidCoord(_arg_1, _arg_2))) || (!(MapTools.isValidCoord(_arg_3, _arg_4)))))
            {
                return (-1);
            };
            var _local_5:* = (_arg_3 - _arg_1);
            var _local_6:* = (_arg_4 - _arg_2);
            if (_local_6 == 0)
            {
                if (_local_5 < 0)
                {
                    return (5);
                };
                return (1);
            };
            if (_local_5 == 0)
            {
                if (_local_6 < 0)
                {
                    return (3);
                };
                return (7);
            };
            return (-1);
        }

        public static function getLookDirection4Diag(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_4:int = int(Math.floor(((_local_3 + 1) / 2)));
            var _local_5:* = (_arg_1 - (_local_3 * MapTools.MAP_GRID_WIDTH));
            var _local_6:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_7:int = int(Math.floor(((_local_6 + 1) / 2)));
            var _local_8:* = (_local_6 - _local_7);
            var _local_9:* = (_arg_1 - (_local_6 * MapTools.MAP_GRID_WIDTH));
            var _local_10:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_11:int = int(Math.floor(((_local_10 + 1) / 2)));
            var _local_12:* = (_arg_2 - (_local_10 * MapTools.MAP_GRID_WIDTH));
            var _local_13:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_14:int = int(Math.floor(((_local_13 + 1) / 2)));
            var _local_15:* = (_local_13 - _local_14);
            var _local_16:* = (_arg_2 - (_local_13 * MapTools.MAP_GRID_WIDTH));
            return (MapTools.getLookDirection4DiagByCoord((_local_4 + _local_5), (_local_9 - _local_8), (_local_11 + _local_12), (_local_16 - _local_15)));
        }

        public static function getLookDirection4DiagByCoord(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):int
        {
            if (((!(MapTools.isValidCoord(_arg_1, _arg_2))) || (!(MapTools.isValidCoord(_arg_3, _arg_4)))))
            {
                return (-1);
            };
            var _local_5:* = (_arg_3 - _arg_1);
            var _local_6:* = (_arg_4 - _arg_2);
            if ((((_local_5 >= (0)) && (_local_6 <= 0)) || ((_local_5 <= (0)) && (_local_6 >= 0))))
            {
                if (_local_5 < 0)
                {
                    return (6);
                };
                return (2);
            };
            if (_local_5 < 0)
            {
                return (4);
            };
            return (0);
        }

        public static function getLookDirection4DiagExact(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_4:int = int(Math.floor(((_local_3 + 1) / 2)));
            var _local_5:* = (_arg_1 - (_local_3 * MapTools.MAP_GRID_WIDTH));
            var _local_6:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_7:int = int(Math.floor(((_local_6 + 1) / 2)));
            var _local_8:* = (_local_6 - _local_7);
            var _local_9:* = (_arg_1 - (_local_6 * MapTools.MAP_GRID_WIDTH));
            var _local_10:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_11:int = int(Math.floor(((_local_10 + 1) / 2)));
            var _local_12:* = (_arg_2 - (_local_10 * MapTools.MAP_GRID_WIDTH));
            var _local_13:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_14:int = int(Math.floor(((_local_13 + 1) / 2)));
            var _local_15:* = (_local_13 - _local_14);
            var _local_16:* = (_arg_2 - (_local_13 * MapTools.MAP_GRID_WIDTH));
            return (MapTools.getLookDirection4DiagExactByCoord((_local_4 + _local_5), (_local_9 - _local_8), (_local_11 + _local_12), (_local_16 - _local_15)));
        }

        public static function getLookDirection4DiagExactByCoord(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):int
        {
            if (((!(MapTools.isValidCoord(_arg_1, _arg_2))) || (!(MapTools.isValidCoord(_arg_3, _arg_4)))))
            {
                return (-1);
            };
            var _local_5:* = (_arg_3 - _arg_1);
            var _local_6:* = (_arg_4 - _arg_2);
            if (_local_5 == -(_local_6))
            {
                if (_local_5 < 0)
                {
                    return (6);
                };
                return (2);
            };
            if (_local_5 == _local_6)
            {
                if (_local_5 < 0)
                {
                    return (4);
                };
                return (0);
            };
            return (-1);
        }

        public static function getLookDirection8(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_4:int = int(Math.floor(((_local_3 + 1) / 2)));
            var _local_5:* = (_arg_1 - (_local_3 * MapTools.MAP_GRID_WIDTH));
            var _local_6:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_7:int = int(Math.floor(((_local_6 + 1) / 2)));
            var _local_8:* = (_local_6 - _local_7);
            var _local_9:* = (_arg_1 - (_local_6 * MapTools.MAP_GRID_WIDTH));
            var _local_10:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_11:int = int(Math.floor(((_local_10 + 1) / 2)));
            var _local_12:* = (_arg_2 - (_local_10 * MapTools.MAP_GRID_WIDTH));
            var _local_13:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_14:int = int(Math.floor(((_local_13 + 1) / 2)));
            var _local_15:* = (_local_13 - _local_14);
            var _local_16:* = (_arg_2 - (_local_13 * MapTools.MAP_GRID_WIDTH));
            return (MapTools.getLookDirection8ByCoord((_local_4 + _local_5), (_local_9 - _local_8), (_local_11 + _local_12), (_local_16 - _local_15)));
        }

        public static function getLookDirection8ByCoord(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):int
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_5:int = MapTools.getLookDirection8ExactByCoord(_arg_1, _arg_2, _arg_3, _arg_4);
            if (!MapDirection.isValidDirection(_local_5))
            {
                _local_6 = (_arg_3 - _arg_1);
                _local_7 = (_arg_4 - _arg_2);
                _local_8 = Math.floor(Math.abs(_local_6));
                _local_9 = Math.floor(Math.abs(_local_7));
                if (_local_8 < (_local_9 * MapTools.COEFF_FOR_REBASE_ON_CLOSEST_8_DIRECTION))
                {
                    if (_local_7 > 0)
                    {
                        _local_5 = 7;
                    }
                    else
                    {
                        _local_5 = 3;
                    };
                }
                else
                {
                    if (_local_9 < (_local_8 * MapTools.COEFF_FOR_REBASE_ON_CLOSEST_8_DIRECTION))
                    {
                        if (_local_6 > 0)
                        {
                            _local_5 = 1;
                        }
                        else
                        {
                            _local_5 = 5;
                        };
                    }
                    else
                    {
                        _local_5 = MapTools.getLookDirection4DiagByCoord(_arg_1, _arg_2, _arg_3, _arg_4);
                    };
                };
            };
            return (_local_5);
        }

        public static function getLookDirection8Exact(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_4:int = int(Math.floor(((_local_3 + 1) / 2)));
            var _local_5:* = (_arg_1 - (_local_3 * MapTools.MAP_GRID_WIDTH));
            var _local_6:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_7:int = int(Math.floor(((_local_6 + 1) / 2)));
            var _local_8:* = (_local_6 - _local_7);
            var _local_9:* = (_arg_1 - (_local_6 * MapTools.MAP_GRID_WIDTH));
            var _local_10:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_11:int = int(Math.floor(((_local_10 + 1) / 2)));
            var _local_12:* = (_arg_2 - (_local_10 * MapTools.MAP_GRID_WIDTH));
            var _local_13:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_14:int = int(Math.floor(((_local_13 + 1) / 2)));
            var _local_15:* = (_local_13 - _local_14);
            var _local_16:* = (_arg_2 - (_local_13 * MapTools.MAP_GRID_WIDTH));
            return (MapTools.getLookDirection8ExactByCoord((_local_4 + _local_5), (_local_9 - _local_8), (_local_11 + _local_12), (_local_16 - _local_15)));
        }

        public static function getLookDirection8ExactByCoord(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):int
        {
            var _local_5:int = MapTools.getLookDirection4ExactByCoord(_arg_1, _arg_2, _arg_3, _arg_4);
            if (!MapDirection.isValidDirection(_local_5))
            {
                _local_5 = MapTools.getLookDirection4DiagExactByCoord(_arg_1, _arg_2, _arg_3, _arg_4);
            };
            return (_local_5);
        }

        public static function getNextCellByDirection(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_4:int = int(Math.floor(((_local_3 + 1) / 2)));
            var _local_5:* = (_arg_1 - (_local_3 * MapTools.MAP_GRID_WIDTH));
            var _local_6:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_7:int = int(Math.floor(((_local_6 + 1) / 2)));
            var _local_8:* = (_local_6 - _local_7);
            var _local_9:* = (_arg_1 - (_local_6 * MapTools.MAP_GRID_WIDTH));
            return (MapTools.getNextCellByDirectionAndCoord((_local_4 + _local_5), (_local_9 - _local_8), _arg_2));
        }

        public static function getNextCellByDirectionAndCoord(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (((!(MapTools.isValidCoord(_arg_1, _arg_2))) || (!(MapDirection.isValidDirection(_arg_3)))))
            {
                return (-1);
            };
            return (MapTools.getCellIdByCoord((_arg_1 + MapTools.COORDINATES_DIRECTION[_arg_3].x), (_arg_2 + MapTools.COORDINATES_DIRECTION[_arg_3].y)));
        }

        public static function adjacentCellsAllowAccess(_arg_1:FightContext, _arg_2:int, _arg_3:int):Boolean
        {
            var _local_4:int = 8;
            var _local_5:int = MapTools.getNextCellByDirection(_arg_2, ((_arg_3 + 1) % _local_4));
            var _local_6:int = MapTools.getNextCellByDirection(_arg_2, (((_arg_3 + _local_4) - 1) % _local_4));
            if (((MapDirection.isOrthogonal(_arg_3)) || ((_arg_1.isCellEmptyForMovement(_local_5)) && (_arg_1.isCellEmptyForMovement(_local_6)))))
            {
                return (true);
            };
            return (false);
        }

        public static function getDistance(_arg_1:int, _arg_2:int):int
        {
            if (((!(MapTools.isValidCellId(_arg_1))) || (!(MapTools.isValidCellId(_arg_2)))))
            {
                return (-1);
            };
            var _local_3:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_4:int = int(Math.floor(((_local_3 + 1) / 2)));
            var _local_5:* = (_arg_1 - (_local_3 * MapTools.MAP_GRID_WIDTH));
            var _local_6:* = (_local_4 + _local_5);
            var _local_7:int = int(Math.floor((_arg_1 / MapTools.MAP_GRID_WIDTH)));
            var _local_8:int = int(Math.floor(((_local_7 + 1) / 2)));
            var _local_9:* = (_local_7 - _local_8);
            var _local_10:* = (_arg_1 - (_local_7 * MapTools.MAP_GRID_WIDTH));
            var _local_11:* = (_local_10 - _local_9);
            var _local_12:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_13:int = int(Math.floor(((_local_12 + 1) / 2)));
            var _local_14:* = (_arg_2 - (_local_12 * MapTools.MAP_GRID_WIDTH));
            var _local_15:* = (_local_13 + _local_14);
            var _local_16:int = int(Math.floor((_arg_2 / MapTools.MAP_GRID_WIDTH)));
            var _local_17:int = int(Math.floor(((_local_16 + 1) / 2)));
            var _local_18:* = (_local_16 - _local_17);
            var _local_19:* = (_arg_2 - (_local_16 * MapTools.MAP_GRID_WIDTH));
            var _local_20:* = (_local_19 - _local_18);
            return (Math.floor((Math.abs((_local_15 - _local_6)) + Math.abs((_local_20 - _local_11)))));
        }

        public static function areCellsAdjacent(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:int = MapTools.getDistance(_arg_1, _arg_2);
            if (_local_3 >= 0)
            {
                return (_local_3 <= 1);
            };
            return (false);
        }

        public static function getCellsCoordBetween(_arg_1:int, _arg_2:int):Array
        {
            return (FpUtils.arrayMap_Int_flash_geom_Point(MapTools.getCellsIdBetween(_arg_1, _arg_2), function (_arg_1:int):flash.geom.Point
            {
                return (MapTools.getCellCoordById(_arg_1).toFlashPoint());
            }));
        }


    }
} mapTools
import mapTools.Point;

var _local_1:Array = [];
_local_1[0] = new Point(1, 1);
_local_1[1] = new Point(1, 0);
_local_1[2] = new Point(1, -1);
_local_1[3] = new Point(0, -1);
_local_1[4] = new Point(-1, -1);
_local_1[5] = new Point(-1, 0);
_local_1[6] = new Point(-1, 1);
_local_1[7] = new Point(0, 1);

