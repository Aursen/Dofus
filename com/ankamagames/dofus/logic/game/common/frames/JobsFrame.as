package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.internalDatacenter.jobs.KnownJobWrapper;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectorySettings;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobDescriptionMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectorySettingsMessage;
    import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryDefineSettingsAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryDefineSettingsMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobExperienceOtherPlayerUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobExperienceUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobExperienceMultiUpdateMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobLevelUpMessage;
    import com.ankamagames.dofus.logic.game.common.actions.craft.JobBookSubscribeRequestAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.JobBookSubscribeRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobBookSubscriptionMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobBookSubscription;
    import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryListRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryListRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterContactLookRequestAction;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkJobIndexMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobDescription;
    import com.ankamagames.dofus.datacenter.jobs.Job;
    import com.ankamagames.dofus.network.messages.game.social.ContactLookRequestByIdMessage;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.misc.lists.CraftHookList;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.misc.EntityLookAdapter;
    import com.ankamagames.dofus.network.enums.SocialContactCategoryEnum;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.messages.Message;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.misc.utils.LuaScriptManager;
    import com.ankamagames.dofus.misc.utils.enums.LuaFormulasEnum;

    public class JobsFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(JobsFrame));

        private var _jobCrafterDirectoryListDialogFrame:JobCrafterDirectoryListDialogFrame;
        private var _settings:Array = new Array();


        private static function updateJobExperience(je:JobExperience):void
        {
            var kj:KnownJobWrapper = PlayedCharacterManager.getInstance().jobs[je.jobId];
            if (!kj)
            {
                kj = KnownJobWrapper.create(je.jobId);
                PlayedCharacterManager.getInstance().jobs[je.jobId] = kj;
            };
            kj.jobLevel = je.jobLevel;
            kj.jobXP = je.jobXP;
            kj.jobXpLevelFloor = je.jobXpLevelFloor;
            kj.jobXpNextLevelFloor = je.jobXpNextLevelFloor;
        }

        private static function createCrafterDirectorySettings(settings:JobCrafterDirectorySettings):Object
        {
            var obj:Object = new Object();
            obj.jobId = settings.jobId;
            obj.minLevel = settings.minLevel;
            obj.free = settings.free;
            return (obj);
        }


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get settings():Array
        {
            return (this._settings);
        }

        public function pushed():Boolean
        {
            this._jobCrafterDirectoryListDialogFrame = new JobCrafterDirectoryListDialogFrame();
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var jdmsg:JobDescriptionMessage;
            var jcdsmsg:JobCrafterDirectorySettingsMessage;
            var jcddsa:JobCrafterDirectoryDefineSettingsAction;
            var jcddsmsg:JobCrafterDirectoryDefineSettingsMessage;
            var jeopumsg:JobExperienceOtherPlayerUpdateMessage;
            var jeumsg:JobExperienceUpdateMessage;
            var jemumsg:JobExperienceMultiUpdateMessage;
            var jlumsg:JobLevelUpMessage;
            var jobsNumber:uint;
            var lastJobLevel:uint;
            var jobName:String;
            var kj:KnownJobWrapper;
            var newJobLevel:uint;
            var podsBonus:uint;
            var levelUpTextMessage:String;
            var jbsra:JobBookSubscribeRequestAction;
            var exmsg:JobBookSubscribeRequestMessage;
            var jbsmsg:JobBookSubscriptionMessage;
            var jobSub:JobBookSubscription;
            var allTheSame:Boolean;
            var subscriptionState:Boolean;
            var text:String;
            var jcdlra:JobCrafterDirectoryListRequestAction;
            var jcdlrmsg:JobCrafterDirectoryListRequestMessage;
            var jcclra:JobCrafterContactLookRequestAction;
            var esokimsg:ExchangeStartOkJobIndexMessage;
            var array:Array;
            var jd:JobDescription;
            var kj2:KnownJobWrapper;
            var setting:JobCrafterDirectorySettings;
            var je:JobExperience;
            var kjw:KnownJobWrapper;
            var job:Job;
            var clrbimsg:ContactLookRequestByIdMessage;
            var esojijob:uint;
            switch (true)
            {
                case (msg is JobDescriptionMessage):
                    jdmsg = (msg as JobDescriptionMessage);
                    PlayedCharacterManager.getInstance().jobs = new Array();
                    for each (jd in jdmsg.jobsDescription)
                    {
                        if (!jd)
                        {
                        }
                        else
                        {
                            kj2 = KnownJobWrapper.create(jd.jobId);
                            kj2.jobDescription = jd;
                            PlayedCharacterManager.getInstance().jobs[jd.jobId] = kj2;
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.JobsListUpdated);
                    return (true);
                case (msg is JobCrafterDirectorySettingsMessage):
                    jcdsmsg = (msg as JobCrafterDirectorySettingsMessage);
                    for each (setting in jcdsmsg.craftersSettings)
                    {
                        this._settings[setting.jobId] = createCrafterDirectorySettings(setting);
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectorySettings, this._settings);
                    return (true);
                case (msg is JobCrafterDirectoryDefineSettingsAction):
                    jcddsa = (msg as JobCrafterDirectoryDefineSettingsAction);
                    jcddsmsg = new JobCrafterDirectoryDefineSettingsMessage();
                    jcddsmsg.initJobCrafterDirectoryDefineSettingsMessage(jcddsa.settings);
                    ConnectionsHandler.getConnection().send(jcddsmsg);
                    return (true);
                case (msg is JobExperienceOtherPlayerUpdateMessage):
                    jeopumsg = (msg as JobExperienceOtherPlayerUpdateMessage);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobsExpOtherPlayerUpdated, jeopumsg.playerId, jeopumsg.experiencesUpdate);
                    return (true);
                case (msg is JobExperienceUpdateMessage):
                    jeumsg = (msg as JobExperienceUpdateMessage);
                    updateJobExperience(jeumsg.experiencesUpdate);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobsExpUpdated, jeumsg.experiencesUpdate.jobId);
                    return (true);
                case (msg is JobExperienceMultiUpdateMessage):
                    jemumsg = (msg as JobExperienceMultiUpdateMessage);
                    for each (je in jemumsg.experiencesUpdate)
                    {
                        updateJobExperience(je);
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobsExpUpdated, 0);
                    return (true);
                case (msg is JobLevelUpMessage):
                    jlumsg = (msg as JobLevelUpMessage);
                    jobsNumber = PlayedCharacterManager.getInstance().jobsNumber();
                    lastJobLevel = PlayedCharacterManager.getInstance().jobsLevel();
                    lastJobLevel = (lastJobLevel - jobsNumber);
                    jobName = Job.getJobById(jlumsg.jobsDescription.jobId).name;
                    kj = PlayedCharacterManager.getInstance().jobs[jlumsg.jobsDescription.jobId];
                    kj.jobDescription = jlumsg.jobsDescription;
                    kj.jobLevel = jlumsg.newLevel;
                    newJobLevel = PlayedCharacterManager.getInstance().jobsLevel();
                    newJobLevel = (newJobLevel - jobsNumber);
                    podsBonus = this.jobLevelupPodsBonus(newJobLevel, lastJobLevel);
                    levelUpTextMessage = I18n.getUiText("ui.craft.newJobLevel", [jobName, jlumsg.newLevel, podsBonus]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, levelUpTextMessage, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(CraftHookList.JobLevelUp, jlumsg.jobsDescription.jobId, jobName, jlumsg.newLevel, podsBonus);
                    return (true);
                case (msg is JobBookSubscribeRequestAction):
                    jbsra = (msg as JobBookSubscribeRequestAction);
                    exmsg = new JobBookSubscribeRequestMessage();
                    exmsg.initJobBookSubscribeRequestMessage(jbsra.jobIds);
                    ConnectionsHandler.getConnection().send(exmsg);
                    return (true);
                case (msg is JobBookSubscriptionMessage):
                    jbsmsg = (msg as JobBookSubscriptionMessage);
                    for each (jobSub in jbsmsg.subscriptions)
                    {
                        PlayedCharacterManager.getInstance().jobs[jobSub.jobId].jobBookSubscriber = jobSub.subscribed;
                        KernelEventsManager.getInstance().processCallback(CraftHookList.JobBookSubscription, jobSub.jobId, jobSub.subscribed);
                    };
                    allTheSame = true;
                    subscriptionState = jbsmsg.subscriptions[0].subscribed;
                    for each (kjw in PlayedCharacterManager.getInstance().jobs)
                    {
                        if (kjw.jobBookSubscriber != subscriptionState)
                        {
                            allTheSame = false;
                            break;
                        };
                    };
                    if (!allTheSame)
                    {
                        for each (jobSub in jbsmsg.subscriptions)
                        {
                            job = Job.getJobById(jobSub.jobId);
                            if (jobSub.subscribed)
                            {
                                text = I18n.getUiText("ui.craft.referenceAdd", [job.name]);
                            }
                            else
                            {
                                text = I18n.getUiText("ui.craft.referenceRemove", [job.name]);
                            };
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, text, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                        };
                    }
                    else
                    {
                        if (subscriptionState)
                        {
                            text = I18n.getUiText("ui.craft.referenceAddAll");
                        }
                        else
                        {
                            text = I18n.getUiText("ui.craft.referenceRemoveAll");
                        };
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, text, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    };
                    return (true);
                case (msg is JobCrafterDirectoryListRequestAction):
                    jcdlra = (msg as JobCrafterDirectoryListRequestAction);
                    jcdlrmsg = new JobCrafterDirectoryListRequestMessage();
                    jcdlrmsg.initJobCrafterDirectoryListRequestMessage(jcdlra.jobId);
                    ConnectionsHandler.getConnection().send(jcdlrmsg);
                    return (true);
                case (msg is JobCrafterContactLookRequestAction):
                    jcclra = (msg as JobCrafterContactLookRequestAction);
                    if (jcclra.crafterId == PlayedCharacterManager.getInstance().id)
                    {
                        KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook, jcclra.crafterId, PlayedCharacterManager.getInstance().infos.name, EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
                    }
                    else
                    {
                        clrbimsg = new ContactLookRequestByIdMessage();
                        clrbimsg.initContactLookRequestByIdMessage(0, SocialContactCategoryEnum.SOCIAL_CONTACT_CRAFTER, jcclra.crafterId);
                        ConnectionsHandler.getConnection().send(clrbimsg);
                    };
                    return (true);
                case (msg is ExchangeStartOkJobIndexMessage):
                    esokimsg = (msg as ExchangeStartOkJobIndexMessage);
                    array = new Array();
                    for each (esojijob in esokimsg.jobs)
                    {
                        array.push(esojijob);
                    };
                    Kernel.getWorker().addFrame(this._jobCrafterDirectoryListDialogFrame);
                    KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkJobIndex, array);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        public function jobLevelupPodsBonus(newJobsLevel:uint, lastJobsLevel:uint):uint
        {
            var paramsNewJob:Dictionary = new Dictionary();
            var paramsLastJob:Dictionary = new Dictionary();
            paramsNewJob["sum_of_jobs_earned_levels"] = newJobsLevel;
            paramsLastJob["sum_of_jobs_earned_levels"] = lastJobsLevel;
            return ((LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.JOBLEVELUP_PODSBONUS, paramsNewJob) as uint) - (LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.JOBLEVELUP_PODSBONUS, paramsLastJob) as uint));
        }


    }
}

