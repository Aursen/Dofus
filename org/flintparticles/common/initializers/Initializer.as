package org.flintparticles.common.initializers
{
    import org.flintparticles.common.emitters.Emitter;
    import org.flintparticles.common.particles.Particle;

    public interface Initializer 
    {

        function getDefaultPriority():Number;
        function addedToEmitter(_arg_1:Emitter):void;
        function removedFromEmitter(_arg_1:Emitter):void;
        function initialize(_arg_1:Emitter, _arg_2:Particle):void;

    }
} org.flintparticles.common.initializers

