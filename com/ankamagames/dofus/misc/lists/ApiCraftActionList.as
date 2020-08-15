package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.dofus.misc.utils.DofusApiAction;
    import com.ankamagames.dofus.logic.game.common.actions.craft.JobBookSubscribeRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryDefineSettingsAction;
    import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryListRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterContactLookRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeSetCraftRecipeAction;

    public class ApiCraftActionList 
    {

        public static const JobBookSubscribeRequest:DofusApiAction = new DofusApiAction("JobBookSubscribeRequest", JobBookSubscribeRequestAction);
        public static const JobCrafterDirectoryDefineSettings:DofusApiAction = new DofusApiAction("JobCrafterDirectoryDefineSettings", JobCrafterDirectoryDefineSettingsAction);
        public static const JobCrafterDirectoryListRequest:DofusApiAction = new DofusApiAction("JobCrafterDirectoryListRequest", JobCrafterDirectoryListRequestAction);
        public static const JobCrafterContactLookRequest:DofusApiAction = new DofusApiAction("JobCrafterContactLookRequest", JobCrafterContactLookRequestAction);
        public static const ExchangeSetCraftRecipe:DofusApiAction = new DofusApiAction("ExchangeSetCraftRecipe", ExchangeSetCraftRecipeAction);


    }
}

