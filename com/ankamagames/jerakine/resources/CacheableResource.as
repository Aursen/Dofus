package com.ankamagames.jerakine.resources
{
    public class CacheableResource 
    {

        public var resource:*;
        public var resourceType:uint;

        public function CacheableResource(_arg_1:uint, resource:*)
        {
            this.resourceType = _arg_1;
            this.resource = resource;
        }

    }
}

