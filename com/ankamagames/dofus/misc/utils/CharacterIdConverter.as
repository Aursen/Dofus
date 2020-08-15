package com.ankamagames.dofus.misc.utils
{
    public class CharacterIdConverter 
    {


        public static function extractServerCharacterIdFromInterserverCharacterId(interserverCharacterId:Number):int
        {
            if (interserverCharacterId)
            {
                return (Math.floor((interserverCharacterId / 0x10000)));
            };
            return (0);
        }


    }
}

