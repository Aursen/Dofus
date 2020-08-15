package com.ankamagames.dofus.misc.utils.mapeditor
{
    import flash.events.Event;

    public class MapEditorDataEvent extends Event 
    {

        public static const NEW_DATA:String = "MapEditorDataEvent_NEW_DATA";

        public var data:MapEditorMessage;

        public function MapEditorDataEvent(_arg_1:String, data:MapEditorMessage)
        {
            super(_arg_1, false, false);
            this.data = data;
        }

    }
}

