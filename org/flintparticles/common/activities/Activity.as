package org.flintparticles.common.activities
{
    import org.flintparticles.common.emitters.Emitter;

    public interface Activity 
    {

        function getDefaultPriority():Number;
        function addedToEmitter(_arg_1:Emitter):void;
        function removedFromEmitter(_arg_1:Emitter):void;
        function initialize(_arg_1:Emitter):void;
        function update(_arg_1:Emitter, _arg_2:Number):void;

    }
} org.flintparticles.common.activities

