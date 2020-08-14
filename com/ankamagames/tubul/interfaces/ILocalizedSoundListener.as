package com.ankamagames.tubul.interfaces
{
    import flash.utils.Dictionary;

    public interface ILocalizedSoundListener 
    {

        function get entitySounds():Array;
        function get reverseEntitySounds():Dictionary;
        function addSoundEntity(_arg_1:ISound, _arg_2:Number):void;
        function removeSoundEntity(_arg_1:ISound):void;

    }
} com.ankamagames.tubul.interfaces

