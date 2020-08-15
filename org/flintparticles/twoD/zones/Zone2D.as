package org.flintparticles.twoD.zones
{
    import flash.geom.Point;

    public interface Zone2D 
    {

        function contains(_arg_1:Number, _arg_2:Number):Boolean;
        function getLocation():Point;
        function getArea():Number;

    }
}

