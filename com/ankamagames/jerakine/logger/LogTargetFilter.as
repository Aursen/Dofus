package com.ankamagames.jerakine.logger
{
    public class LogTargetFilter 
    {

        public var allow:Boolean = true;
        public var target:String;

        public function LogTargetFilter(pTarget:String, pAllow:Boolean=true)
        {
            this.target = pTarget;
            this.allow = pAllow;
        }

    }
} com.ankamagames.jerakine.logger

