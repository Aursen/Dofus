package org.flintparticles.common.displayObjects
{
    import flash.display.Shape;

    public class Dot extends Shape 
    {

        public function Dot(radius:Number, color:uint=0xFFFFFF, bm:String="normal")
        {
            graphics.beginFill(color);
            graphics.drawCircle(0, 0, radius);
            graphics.endFill();
            blendMode = bm;
        }

    }
} org.flintparticles.common.displayObjects

