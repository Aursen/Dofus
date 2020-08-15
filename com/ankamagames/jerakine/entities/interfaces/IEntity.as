package com.ankamagames.jerakine.entities.interfaces
{
    import com.ankamagames.jerakine.types.positions.MapPoint;

    public interface IEntity 
    {

        function get id():Number;
        function set id(_arg_1:Number):void;
        function get position():MapPoint;
        function set position(_arg_1:MapPoint):void;

    }
}

