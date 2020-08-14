package com.ankamagames.atouin.messages
{
    public class CellClickMessage extends CellInteractionMessage 
    {

        public var fromStack:Boolean;
        public var fromAutotrip:Boolean;

        public function CellClickMessage(cellId:uint=0, mapId:Number=0)
        {
            this.cellId = cellId;
            this.id = mapId;
        }

    }
} com.ankamagames.atouin.messages

