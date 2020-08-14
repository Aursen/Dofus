package com.ankamagames.atouin.utils.map
{
    import com.ankamagames.jerakine.types.positions.WorldPoint;

    public function getWorldPointFromMapId(nMapId:Number):WorldPoint
    {
        var worldId:uint = ((nMapId & 0x3FFC0000) >> 18);
        var x:* = ((nMapId >> 9) & 0x01FF);
        var y:* = (nMapId & 0x01FF);
        if ((x & 0x0100) == 0x0100)
        {
            x = -(x & 0xFF);
        };
        if ((y & 0x0100) == 0x0100)
        {
            y = -(y & 0xFF);
        };
        return (WorldPoint.fromCoords(worldId, x, y));
    }

} com.ankamagames.atouin.utils.map

