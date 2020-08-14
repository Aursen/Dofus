package mapTools
{
    public class MapToolsConfig 
    {

        public static var DOFUS2_CONFIG:MapToolsConfig = new MapToolsConfig(14, 20, 0, 33, -19, 13);

        public var minYCoord:int;
        public var minXCoord:int;
        public var maxYCoord:int;
        public var maxXCoord:int;
        public var mapGridWidth:int;
        public var mapGridHeight:int;

        public function MapToolsConfig(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int):void
        {
            mapGridWidth = _arg_1;
            mapGridHeight = _arg_2;
            minXCoord = _arg_3;
            maxXCoord = _arg_4;
            minYCoord = _arg_5;
            maxYCoord = _arg_6;
        }

    }
} mapTools

