package com.ankamagames.atouin.types
{
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.jerakine.interfaces.IObstacle;
    import com.ankamagames.jerakine.interfaces.IDestroyable;
    import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
    import com.ankamagames.jerakine.types.Uri;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.positions.MapPoint;

    public interface IFurniture extends IDisplayable, IEntity, IObstacle, IStackable, IDestroyable 
    {

        function addEventListeners():void;
        function removeEventListeners():void;
        function get element():NormalGraphicalElementData;
        function get uri():Uri;
        function get strata():uint;
        function get typeId():int;
        function get isStackable():Boolean;
        function get orientation():uint;
        function displayHighlight(_arg_1:Boolean):void;
        function get cells():Vector.<MapPoint>;
        function get cellsWidth():uint;
        function get cellsHeight():uint;
        function set offsetPosition(_arg_1:MapPoint):void;
        function get offsetPosition():MapPoint;

    }
}

