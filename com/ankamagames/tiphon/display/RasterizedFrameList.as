package com.ankamagames.tiphon.display
{
    public class RasterizedFrameList 
    {

        public var life:int;
        public var maxLife:int;
        public var death:int = 0;
        public var key:String;
        public var frameList:Array = new Array();

        public function RasterizedFrameList(key:String, life:int, maxLife:int=40)
        {
            this.key = key;
            this.life = life;
            this.maxLife = maxLife;
        }

    }
} com.ankamagames.tiphon.display

