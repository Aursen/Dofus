package com.ankamagames.atouin.types
{
    import flash.geom.Rectangle;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.jerakine.utils.display.StageShareManager;

    public class Frustum extends Rectangle 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Frustum));
        public static const MAX_WIDTH:Number = ((AtouinConstants.MAP_WIDTH * AtouinConstants.CELL_WIDTH) + AtouinConstants.CELL_HALF_WIDTH);//1247
        public static const MAX_HEIGHT:Number = ((AtouinConstants.MAP_HEIGHT * AtouinConstants.CELL_HEIGHT) + AtouinConstants.CELL_HALF_HEIGHT);//881.5
        public static const RATIO:Number = (MAX_WIDTH / MAX_HEIGHT);//1.41463414634146

        private var _marginLeft:int;
        private var _marginRight:int;
        private var _marginTop:int;
        private var _marginBottom:int;
        public var scale:Number;

        public function Frustum(marginRight:int=0, marginTop:int=0, marginLeft:int=0, marginBottom:int=0)
        {
            this._marginTop = marginTop;
            this._marginRight = marginRight;
            this._marginBottom = marginBottom;
            this._marginLeft = marginLeft;
            this.refresh();
        }

        public function get marginLeft():int
        {
            return (this._marginLeft);
        }

        public function get marginRight():int
        {
            return (this._marginRight);
        }

        public function get marginTop():int
        {
            return (this._marginTop);
        }

        public function get marginBottom():int
        {
            return (this._marginBottom);
        }

        public function refresh():void
        {
            var divX:Number;
            var divY:Number;
            this.scale = (StageShareManager.startHeight / ((MAX_HEIGHT + this._marginTop) + this._marginBottom));
            width = (MAX_WIDTH * this.scale);
            height = (MAX_HEIGHT * this.scale);
            var currentRatio:Number = (width / height);
            if (currentRatio < RATIO)
            {
                height = (width / RATIO);
            }
            else
            {
                if (currentRatio > RATIO)
                {
                    width = (height * RATIO);
                };
            };
            var xSpace:Number = (((StageShareManager.startWidth - (MAX_WIDTH * this.scale)) + this._marginLeft) - this._marginRight);
            var ySpace:Number = (((StageShareManager.startHeight - (MAX_HEIGHT * this.scale)) + this._marginTop) - this._marginBottom);
            var divisor:uint = 2;
            if (((this._marginLeft) && (this._marginRight)))
            {
                divX = ((this._marginLeft + this._marginRight) / this._marginLeft);
            }
            else
            {
                if (this._marginLeft)
                {
                    divX = (divisor + (xSpace / this._marginLeft));
                }
                else
                {
                    if (this._marginRight)
                    {
                        divX = (divisor - (xSpace / this._marginRight));
                    }
                    else
                    {
                        divX = divisor;
                    };
                };
            };
            if (((this._marginTop) && (this._marginBottom)))
            {
                divY = ((this._marginTop + this._marginBottom) / this._marginTop);
            }
            else
            {
                if (this._marginTop)
                {
                    divY = (divisor + (ySpace / this._marginTop));
                }
                else
                {
                    if (this._marginBottom)
                    {
                        divY = ((ySpace / this._marginBottom) - divisor);
                    }
                    else
                    {
                        divY = divisor;
                    };
                };
            };
            x = (xSpace / divX);
            y = (ySpace / divY);
        }

        override public function toString():String
        {
            return ((super.toString() + " scale=") + this.scale);
        }


    }
}

