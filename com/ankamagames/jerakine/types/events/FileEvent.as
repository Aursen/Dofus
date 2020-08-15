package com.ankamagames.jerakine.types.events
{
    import flash.events.Event;

    public class FileEvent extends Event 
    {

        public static const ERROR:String = "FILE_ERROR_EVENT";

        private var _sFile:String;
        private var _bSuccess:Boolean;

        public function FileEvent(_arg_1:String, sFile:String, bSuccess:Boolean)
        {
            super(_arg_1, bubbles, cancelable);
            this._sFile = sFile;
            this._bSuccess = bSuccess;
        }

        public function get file():String
        {
            return (this._sFile);
        }

        public function get success():Boolean
        {
            return (this._bSuccess);
        }


    }
}

