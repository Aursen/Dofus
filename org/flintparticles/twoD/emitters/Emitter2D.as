package org.flintparticles.twoD.emitters
{
    import org.flintparticles.common.emitters.Emitter;
    import org.flintparticles.twoD.particles.ParticleCreator2D;
    import org.flintparticles.common.particles.ParticleFactory;
    import org.flintparticles.common.utils.Maths;
    import org.flintparticles.twoD.particles.Particle2D;
    import org.flintparticles.common.particles.Particle;

    public class Emitter2D extends Emitter 
    {

        protected static var _creator:ParticleCreator2D = new ParticleCreator2D();

        protected var _x:Number = 0;
        protected var _y:Number = 0;
        protected var _rotation:Number = 0;
        public var spaceSortedX:Array;
        public var spaceSort:Boolean = false;

        public function Emitter2D()
        {
            _particleFactory = _creator;
        }

        public static function get defaultParticleFactory():ParticleFactory
        {
            return (_creator);
        }


        public function get x():Number
        {
            return (this._x);
        }

        public function set x(value:Number):void
        {
            this._x = value;
        }

        public function get y():Number
        {
            return (this._y);
        }

        public function set y(value:Number):void
        {
            this._y = value;
        }

        public function get rotation():Number
        {
            return (Maths.asDegrees(this._rotation));
        }

        public function set rotation(value:Number):void
        {
            this._rotation = Maths.asRadians(value);
        }

        public function get rotRadians():Number
        {
            return (this._rotation);
        }

        public function set rotRadians(value:Number):void
        {
            this._rotation = value;
        }

        override protected function initParticle(particle:Particle):void
        {
            var p:Particle2D;
            p = Particle2D(particle);
            p.x = this._x;
            p.y = this._y;
            p.rotation = this._rotation;
        }

        override protected function sortParticles():void
        {
            var len:int;
            var i:int;
            if (this.spaceSort)
            {
                this.spaceSortedX = _particles.sortOn("x", (Array.NUMERIC | Array.RETURNINDEXEDARRAY));
                len = _particles.length;
                i = 0;
                while (i < len)
                {
                    _particles[this.spaceSortedX[i]].sortID = i;
                    i++;
                };
            };
        }


    }
} org.flintparticles.twoD.emitters

