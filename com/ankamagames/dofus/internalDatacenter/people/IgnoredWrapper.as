package com.ankamagames.dofus.internalDatacenter.people
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.enum.SocialCharacterCategoryEnum;

    public class IgnoredWrapper extends SocialCharacterWrapper implements IDataCenter 
    {

        public function IgnoredWrapper(name:String, accountId:uint)
        {
            super(name, accountId);
            this.e_category = SocialCharacterCategoryEnum.CATEGORY_IGNORED;
        }

    }
} com.ankamagames.dofus.internalDatacenter.people

