package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.tiphon.types.IAnimationModifier;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.tiphon.types.AnimationModifierPriority;
    import com.ankamagames.jerakine.types.Swl;
    import com.ankamagames.tiphon.engine.Tiphon;
    import com.ankamagames.dofus.types.enums.AnimationEnum;

    public class CustomBreedAnimationModifier implements IAnimationModifier 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(CustomBreedAnimationModifier));
        private static var _ignoreNextStaticForLook:TiphonEntityLook = null;

        public var randomStatique:Boolean = false;


        public function get priority():int
        {
            return (AnimationModifierPriority.NORMAL);
        }

        public function getModifiedAnimation(pAnimation:String, pLook:TiphonEntityLook):String
        {
            var lib:Swl;
            var customAnimationName:String;
            var statics:Array;
            var anim:String;
            var animName:String;
            var random:int;
            var skinId:int;
            if (pLook.getBone() != 1)
            {
                return (pAnimation);
            };
            switch (pAnimation)
            {
                case AnimationEnum.ANIM_STATIQUE:
                    if (_ignoreNextStaticForLook == pLook)
                    {
                        _ignoreNextStaticForLook = null;
                        return ("AnimStatiqueOugarou");
                    };
                    if (this.randomStatique)
                    {
                        lib = Tiphon.skullLibrary.getResourceById(pLook.getBone(), AnimationEnum.ANIM_STATIQUE);
                        statics = new Array();
                        if (lib)
                        {
                            for each (anim in lib.getDefinitions())
                            {
                                if (anim.indexOf((AnimationEnum.ANIM_STATIQUE + pLook.firstSkin.toString())) == 0)
                                {
                                    animName = anim.split("_")[0];
                                    if (statics.indexOf(animName) == -1)
                                    {
                                        statics.push(animName);
                                    };
                                };
                            };
                        }
                        else
                        {
                            statics.push((AnimationEnum.ANIM_STATIQUE + pLook.firstSkin.toString()));
                        };
                        if (statics.length > 1)
                        {
                            random = int(Math.floor((Math.random() * statics.length)));
                            return (statics[random]);
                        };
                        return (statics[0]);
                    }
                    else
                    {
                        skinId = pLook.firstSkin;
                        if ((((((skinId == 1114) || (skinId == 1115)) || (skinId == 1402)) || (skinId == 1463)) || (skinId == pLook.defaultSkin)))
                        {
                            return (AnimationEnum.ANIM_STATIQUE);
                        };
                        return (AnimationEnum.ANIM_STATIQUE + pLook.firstSkin.toString());
                    };
                case AnimationEnum.ANIM_MARCHE:
                case AnimationEnum.ANIM_COURSE:
                    customAnimationName = ((pAnimation + "_") + pLook.firstSkin.toString());
                    if (Tiphon.skullLibrary.hasAnim(pLook.getBone(), customAnimationName))
                    {
                        return (customAnimationName);
                    };
                    break;
                case "AnimAttaque349812":
                    _ignoreNextStaticForLook = pLook;
                    break;
                default:
                    return (pAnimation);
            };
            return (pAnimation);
        }


    }
}

