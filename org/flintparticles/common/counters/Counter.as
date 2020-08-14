package org.flintparticles.common.counters
{
    import org.flintparticles.common.emitters.Emitter;

    public interface Counter 
    {

        function startEmitter(_arg_1:Emitter):uint;
        function updateEmitter(_arg_1:Emitter, _arg_2:Number):uint;
        function stop():void;
        function resume():void;

    }
} org.flintparticles.common.counters

