package damageCalculation
{
    import damageCalculation.fighterManagement.HaxeFighter;
    import haxe.ds.List;

    public interface IMapInfo 
    {

        function isCellWalkable(_arg_1:int):Boolean;
        function getOutputPortalCell(_arg_1:int):int;
        function getMarks(_arg_1:int=undefined, _arg_2:int=undefined):Array;
        function getMarkInteractingWithCell(_arg_1:int, _arg_2:int=undefined):Array;
        function getLastKilledAlly(_arg_1:int):HaxeFighter;
        function getFightersInitialPositions():List;
        function getFighterById(_arg_1:Number):HaxeFighter;
        function getEveryFighterId():Array;
        function getCarriedFighterIdBy(_arg_1:HaxeFighter):Number;
        function dispellIllusionOnCell(_arg_1:int):void;

    }
} damageCalculation

