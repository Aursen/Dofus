package org.flintparticles.common.actions
{
    import org.flintparticles.common.emitters.Emitter;
    import org.flintparticles.common.particles.Particle;

    public interface Action 
    {

        function getDefaultPriority():Number;
        function addedToEmitter(_arg_1:Emitter):void;
        function removedFromEmitter(_arg_1:Emitter):void;
        function update(_arg_1:Emitter, _arg_2:Particle, _arg_3:Number):void;

    }
}

