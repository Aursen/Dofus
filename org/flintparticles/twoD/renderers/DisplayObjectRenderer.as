package org.flintparticles.twoD.renderers
{
    import org.flintparticles.common.renderers.SpriteRendererBase;
    import org.flintparticles.twoD.particles.Particle2D;
    import flash.display.DisplayObject;
    import org.flintparticles.common.particles.Particle;

    public class DisplayObjectRenderer extends SpriteRendererBase 
    {


        override protected function renderParticles(particles:Array):void
        {
            var particle:Particle2D;
            var img:DisplayObject;
            var len:int = particles.length;
            var i:int;
            while (i < len)
            {
                particle = particles[i];
                img = particle.image;
                img.transform.colorTransform = particle.colorTransform;
                img.transform.matrix = particle.matrixTransform;
                i++;
            };
        }

        override protected function addParticle(particle:Particle):void
        {
            addChildAt(particle.image, 0);
        }

        override protected function removeParticle(particle:Particle):void
        {
            if (contains(particle.image))
            {
                removeChild(particle.image);
            };
        }


    }
}

