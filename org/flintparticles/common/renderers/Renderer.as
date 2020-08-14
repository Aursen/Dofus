package org.flintparticles.common.renderers
{
    import org.flintparticles.common.emitters.Emitter;

    public interface Renderer 
    {

        function addEmitter(_arg_1:Emitter):void;
        function removeEmitter(_arg_1:Emitter):void;
        function get emitters():Array;

    }
} org.flintparticles.common.renderers

