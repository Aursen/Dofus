package org.flintparticles.twoD.actions
{
    import org.flintparticles.common.actions.ActionBase;
    import org.flintparticles.twoD.particles.Particle2D;
    import org.flintparticles.common.emitters.Emitter;
    import org.flintparticles.common.particles.Particle;

    public class Move extends ActionBase 
    {

        private var p:Particle2D;


        override public function getDefaultPriority():Number
        {
            return (-10);
        }

        override public function update(emitter:Emitter, particle:Particle, time:Number):void
        {
            this.p = Particle2D(particle);
            this.p.x = (this.p.x + (this.p.velX * time));
            this.p.y = (this.p.y + (this.p.velY * time));
        }


    }
} org.flintparticles.twoD.actions

