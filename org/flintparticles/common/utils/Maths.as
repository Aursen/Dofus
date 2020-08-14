package org.flintparticles.common.utils
{
    public class Maths 
    {

        private static const RADTODEG:Number = (180 / Math.PI);//57.2957795130823
        private static const DEGTORAD:Number = (Math.PI / 180);//0.0174532925199433


        public static function asDegrees(radians:Number):Number
        {
            return (radians * RADTODEG);
        }

        public static function asRadians(degrees:Number):Number
        {
            return (degrees * DEGTORAD);
        }


    }
} org.flintparticles.common.utils

