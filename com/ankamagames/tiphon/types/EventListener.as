package com.ankamagames.tiphon.types
{
    import com.ankamagames.jerakine.interfaces.IFLAEventHandler;

    public class EventListener 
    {

        public var listener:IFLAEventHandler;
        public var typesEvents:String;

        public function EventListener(pListener:IFLAEventHandler, pTypesEvents:String)
        {
            this.listener = pListener;
            this.typesEvents = pTypesEvents;
        }

    }
} com.ankamagames.tiphon.types

