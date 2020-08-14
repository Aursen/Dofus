package org.flintparticles.twoD.initializers
{
    import org.flintparticles.common.initializers.InitializerBase;
    import org.flintparticles.twoD.zones.Zone2D;
    import org.flintparticles.twoD.particles.Particle2D;
    import flash.geom.Point;
    import org.flintparticles.common.emitters.Emitter;
    import org.flintparticles.common.particles.Particle;

    public class Position extends InitializerBase 
    {

        private var _zone:Zone2D;

        public function Position(zone:Zone2D)
        {
            this._zone = zone;
        }

        public function get zone():Zone2D
        {
            return (this._zone);
        }

        public function set zone(value:Zone2D):void
        {
            this._zone = value;
        }

        override public function initialize(emitter:Emitter, particle:Particle):void
        {
            var sin:Number;
            var cos:Number;
            var p:Particle2D = Particle2D(particle);
            var loc:Point = this._zone.getLocation();
            if (p.rotation == 0)
            {
                p.x = (p.x + loc.x);
                p.y = (p.y + loc.y);
            }
            else
            {
                sin = Math.sin(p.rotation);
                cos = Math.cos(p.rotation);
                p.x = (p.x + ((cos * loc.x) - (sin * loc.y)));
                p.y = (p.y + ((cos * loc.y) + (sin * loc.x)));
            };
        }


    }
} org.flintparticles.twoD.initializers

