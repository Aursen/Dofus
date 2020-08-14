package com.ankamagames.atouin.utils.map
{
    public function getMapIdFromCoord(worldId:int, x:int, y:int):Number
    {
        var worldIdMax:* = (2 << 12);
        var mapCoordMax:* = (2 << 8);
        if ((((x > mapCoordMax) || (y > mapCoordMax)) || (worldId > worldIdMax)))
        {
            return (-1);
        };
        var newWorldId:* = (worldId & 0x0FFF);
        var newX:* = (Math.abs(x) & 0xFF);
        if (x < 0)
        {
            newX = (newX | 0x0100);
        };
        var newY:* = (Math.abs(y) & 0xFF);
        if (y < 0)
        {
            newY = (newY | 0x0100);
        };
        return ((newWorldId << 18) | ((newX << 9) | newY));
    }

} com.ankamagames.atouin.utils.map

