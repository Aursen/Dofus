package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.tiphon.types.ISkinModifier;
    import com.ankamagames.tiphon.types.Skin;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;

    public class BreedSkinModifier implements ISkinModifier 
    {


        public function getModifiedSkin(skin:Skin, requestedPart:String, look:TiphonEntityLook):String
        {
            var name:String;
            var id:String;
            var newPart:String;
            var i:int;
            if (((((!(look)) || (!(look.skins))) || (!(requestedPart))) || (!(skin))))
            {
                return (requestedPart);
            };
            var separatorIndex:int = requestedPart.indexOf("_");
            if (separatorIndex != -1)
            {
                name = requestedPart.substring(0, (separatorIndex + 1));
                id = requestedPart.substring(separatorIndex);
                i = (look.skins.length - 1);
                while (i >= 0)
                {
                    newPart = ((name + look.skins[i]) + id);
                    if (skin.getPart(newPart) != null)
                    {
                        return (newPart);
                    };
                    i--;
                };
            };
            return (requestedPart);
        }


    }
} com.ankamagames.dofus.types.entities

