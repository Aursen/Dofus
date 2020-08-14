package org.flintparticles.common.counters
{
    import org.flintparticles.common.emitters.Emitter;

    public class ZeroCounter implements Counter 
    {


        public function startEmitter(emitter:Emitter):uint
        {
            return (0);
        }

        public function updateEmitter(emitter:Emitter, time:Number):uint
        {
            return (0);
        }

        public function stop():void
        {
        }

        public function resume():void
        {
        }


    }
} org.flintparticles.common.counters

