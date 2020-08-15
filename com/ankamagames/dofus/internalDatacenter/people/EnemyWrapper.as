package com.ankamagames.dofus.internalDatacenter.people
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.network.types.game.friend.IgnoredInformations;
    import com.ankamagames.jerakine.enum.SocialCharacterCategoryEnum;
    import com.ankamagames.dofus.network.types.game.friend.IgnoredOnlineInformations;

    public class EnemyWrapper extends SocialCharacterWrapper implements IDataCenter 
    {

        private var _item:IgnoredInformations;

        public function EnemyWrapper(o:IgnoredInformations)
        {
            super(o.accountName, o.accountId);
            e_category = SocialCharacterCategoryEnum.CATEGORY_ENEMY;
            this._item = o;
            name = o.accountName;
            accountId = o.accountId;
            if ((o is IgnoredOnlineInformations))
            {
                playerName = IgnoredOnlineInformations(o).playerName;
                playerId = IgnoredOnlineInformations(o).playerId;
                breed = IgnoredOnlineInformations(o).breed;
                sex = ((IgnoredOnlineInformations(o).sex) ? 1 : 0);
                online = true;
            };
        }

    }
}

