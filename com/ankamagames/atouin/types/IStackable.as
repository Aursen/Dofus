package com.ankamagames.atouin.types
{
    public interface IStackable 
    {

        function get layerId():int;
        function get elementHeight():uint;
        function updateContentY(_arg_1:Number=0, _arg_2:int=-1):void;

    }
}

