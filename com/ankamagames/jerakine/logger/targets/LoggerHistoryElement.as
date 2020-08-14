package com.ankamagames.jerakine.logger.targets
{
    import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;

    internal class LoggerHistoryElement 
    {

        private var m_level:int;
        private var m_message:String;
        private var m_subMessage:String;

        public function LoggerHistoryElement(level:int, message:String, subMessage:String="")
        {
            this.m_level = level;
            this.m_message = message;
            this.m_subMessage = subMessage;
            FpsManager.getInstance().watchObject(this);
        }

        public function get level():int
        {
            return (this.m_level);
        }

        public function get message():String
        {
            return (this.m_message);
        }

        public function get subMessage():String
        {
            return (this.m_subMessage);
        }


    }
} com.ankamagames.jerakine.logger.targets

