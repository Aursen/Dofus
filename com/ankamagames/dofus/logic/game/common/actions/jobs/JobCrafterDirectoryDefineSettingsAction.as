package com.ankamagames.dofus.logic.game.common.actions.jobs
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectorySettings;
    import com.ankamagames.dofus.internalDatacenter.jobs.KnownJobWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;

    public class JobCrafterDirectoryDefineSettingsAction implements Action 
    {

        public var jobId:uint;
        public var minLevel:uint;
        public var free:Boolean;
        public var settings:JobCrafterDirectorySettings;


        public static function create(jobId:uint, minLevel:uint, free:Boolean):JobCrafterDirectoryDefineSettingsAction
        {
            var job:KnownJobWrapper;
            var act:JobCrafterDirectoryDefineSettingsAction = new (JobCrafterDirectoryDefineSettingsAction)();
            act.jobId = jobId;
            act.minLevel = minLevel;
            act.free = free;
            act.settings = new JobCrafterDirectorySettings();
            var jobs:Array = PlayedCharacterManager.getInstance().jobs;
            var i:uint;
            while (i < jobs.length)
            {
                job = jobs[i];
                if (((job) && (job.id == jobId)))
                {
                    act.settings.initJobCrafterDirectorySettings(i, minLevel, free);
                };
                i++;
            };
            return (act);
        }


    }
}

