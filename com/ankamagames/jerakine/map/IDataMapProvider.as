package com.ankamagames.jerakine.map
{
    import __AS3__.vec.Vector;

    public interface IDataMapProvider 
    {

        function get width():int;
        function get height():int;
        function pointLos(_arg_1:int, _arg_2:int, _arg_3:Boolean=true):Boolean;
        function pointMov(_arg_1:int, _arg_2:int, _arg_3:Boolean=true, _arg_4:int=-1, _arg_5:int=-1, _arg_6:Boolean=true):Boolean;
        function farmCell(_arg_1:int, _arg_2:int):Boolean;
        function pointSpecialEffects(_arg_1:int, _arg_2:int):uint;
        function pointWeight(_arg_1:int, _arg_2:int, _arg_3:Boolean=true):Number;
        function hasEntity(_arg_1:int, _arg_2:int, _arg_3:Boolean=false):Boolean;
        function updateCellMovLov(_arg_1:uint, _arg_2:Boolean):void;
        function isChangeZone(_arg_1:uint, _arg_2:uint):Boolean;
        function getCellSpeed(_arg_1:uint):int;
        function fillEntityOnCellArray(_arg_1:Vector.<Boolean>, _arg_2:Boolean):Vector.<Boolean>;

    }
}

