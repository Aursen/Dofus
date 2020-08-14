package com.ankamagames.jerakine.types
{
    import flash.utils.IExternalizable;
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;

    public class ARGBColor extends DefaultableColor implements IExternalizable 
    {

        private var _alpha:uint;

        public function ARGBColor(color:Number=0)
        {
            super(color);
        }

        public function get alpha():Number
        {
            return (this._alpha / 0xFF);
        }

        override public function readExternal(input:IDataInput):void
        {
            this._alpha = input.readUnsignedByte();
            super.readExternal(input);
        }

        override public function writeExternal(output:IDataOutput):void
        {
            output.writeByte(this._alpha);
            super.writeExternal(output);
        }

        override public function release():void
        {
            this._alpha = 0;
            super.release();
        }

        override protected function parseColor(color:Number):void
        {
            this._alpha = ((color >> 24) & 0xFF);
            super.parseColor(color);
        }


    }
} com.ankamagames.jerakine.types

