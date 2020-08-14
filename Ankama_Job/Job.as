package Ankama_Job
{
    import flash.display.Sprite;
    import Ankama_Job.ui.Craft;
    import Ankama_Job.ui.Decraft;
    import Ankama_Job.ui.CrafterForm;
    import Ankama_Job.ui.CrafterList;
    import Ankama_Job.ui.CraftCoop;
    import Ankama_Job.ui.SmithMagic;
    import Ankama_Job.ui.SmithMagicCoop;
    import Ankama_Job.ui.CheckCraft;
    import Ankama_Job.ui.RuneMaker;
    import Ankama_Job.ui.Recycle;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.NotificationApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.JobsApi;
    import com.ankamagames.dofus.uiApi.SocialApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.StorageApi;
    import flash.utils.Dictionary;
    import d2hooks.ExchangeStartOkCraft;
    import d2hooks.ExchangeStartOkMultiCraft;
    import d2hooks.ExchangeMultiCraftRequest;
    import d2hooks.ExchangeStartOkJobIndex;
    import d2hooks.ExchangeStartOkRunesTrade;
    import d2hooks.ExchangeStartOkRecycleTrade;
    import d2hooks.JobsExpOtherPlayerUpdated;
    import d2hooks.JobLevelUp;
    import d2hooks.ExchangeLeave;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import d2hooks.OpenInventory;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
    import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
    import d2actions.ExchangeAccept;
    import d2actions.ExchangeRefuse;
    import d2actions.AddIgnored;

    public class Job extends Sprite 
    {

        private static var _self:Job;

        protected var craft:Craft;
        protected var decraft:Decraft;
        protected var crafterForm:CrafterForm;
        protected var crafterList:CrafterList;
        protected var craftCoop:CraftCoop;
        protected var smithMagic:SmithMagic;
        protected var smithMagicCoop:SmithMagicCoop;
        protected var checkCraft:CheckCraft;
        protected var runeMaker:RuneMaker;
        protected var recycle:Recycle;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="NotificationApi")]
        public var notificationApi:NotificationApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="JobsApi")]
        public var jobsApi:JobsApi;
        [Api(name="SocialApi")]
        public var socialApi:SocialApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="StorageApi")]
        public var storageApi:StorageApi;
        private var _popupName:String;
        private var _ignoreName:String;
        private var _mageLog:Array = new Array();
        private var _jobExpByPlayerId:Dictionary = new Dictionary();


        public static function getInstance():Job
        {
            return (_self);
        }


        public function main():void
        {
            _self = this;
            this.sysApi.addHook(ExchangeStartOkCraft, this.onExchangeStartOkCraft);
            this.sysApi.addHook(ExchangeStartOkMultiCraft, this.onExchangeStartOkMultiCraft);
            this.sysApi.addHook(ExchangeMultiCraftRequest, this.onExchangeMultiCraftRequest);
            this.sysApi.addHook(ExchangeStartOkJobIndex, this.onExchangeStartOkJobIndex);
            this.sysApi.addHook(ExchangeStartOkRunesTrade, this.onExchangeStartOkRunesTrade);
            this.sysApi.addHook(ExchangeStartOkRecycleTrade, this.onExchangeStartOkRecycleTrade);
            this.sysApi.addHook(JobsExpOtherPlayerUpdated, this.onJobsExpOtherPlayerUpdated);
            this.sysApi.addHook(JobLevelUp, this.onJobLevelUp);
            this.sysApi.addHook(ExchangeLeave, this.onExchangeLeave);
        }

        public function get mageLog():Array
        {
            return (this._mageLog);
        }

        public function addToMageLog(line:Object):void
        {
            this._mageLog.push(line);
        }

        public function removeMageLogFirstLine():void
        {
            this._mageLog.splice(0, 1);
        }

        private function onExchangeStartOkCraft(skillId:uint):void
        {
            this.sysApi.disableWorldInteraction();
            var skill:Object = this.jobsApi.getSkillFromId(skillId);
            if (((skill.isForgemagus) || (skill.modifiableItemTypeIds.length > 0)))
            {
                if (!this.uiApi.getUi(UIEnum.SMITH_MAGIC))
                {
                    this.uiApi.loadUi(UIEnum.SMITH_MAGIC, UIEnum.SMITH_MAGIC, {"skillId":skillId});
                };
                this.sysApi.dispatchHook(OpenInventory, "smithMagic", UIEnum.STORAGE_UI);
            }
            else
            {
                if (skillId == DataEnum.SKILL_SHATTER_ITEM)
                {
                    this.uiApi.loadUi(UIEnum.RUNE_MAKER, UIEnum.RUNE_MAKER);
                    this.sysApi.dispatchHook(OpenInventory, "decraft", UIEnum.STORAGE_UI);
                }
                else
                {
                    if (!this.uiApi.getUi(UIEnum.CRAFT))
                    {
                        this.uiApi.loadUi(UIEnum.CRAFT, UIEnum.CRAFT, {"skillId":skillId});
                    };
                    this.sysApi.dispatchHook(OpenInventory, "craft", UIEnum.STORAGE_UI);
                };
            };
        }

        private function onExchangeStartOkMultiCraft(skillId:int, crafterInfos:Object, customerInfos:Object):void
        {
            var characterInfos:Object;
            this.sysApi.disableWorldInteraction();
            var skill:Object = this.jobsApi.getSkillFromId(skillId);
            if (this.uiApi.getUi(this._popupName))
            {
                this.uiApi.unloadUi(this._popupName);
            };
            if (skill.isForgemagus)
            {
                if (!this.uiApi.getUi(UIEnum.SMITH_MAGIC_COOP))
                {
                    this.uiApi.loadUi(UIEnum.SMITH_MAGIC_COOP, UIEnum.SMITH_MAGIC, {
                        "skillId":skillId,
                        "crafterInfos":crafterInfos,
                        "customerInfos":customerInfos
                    });
                };
                characterInfos = this.playerApi.getPlayedCharacterInfo();
                this.sysApi.dispatchHook(OpenInventory, "smithMagicCoop", UIEnum.STORAGE_UI);
            }
            else
            {
                if (!this.uiApi.getUi(UIEnum.CRAFT_COOP))
                {
                    this.uiApi.loadUi(UIEnum.CRAFT_COOP, UIEnum.CRAFT, {
                        "skillId":skillId,
                        "crafterInfos":crafterInfos,
                        "customerInfos":customerInfos,
                        "jobExperience":this._jobExpByPlayerId[crafterInfos.id]
                    });
                };
                this.sysApi.dispatchHook(OpenInventory, "craft", UIEnum.STORAGE_UI);
            };
        }

        private function onExchangeMultiCraftRequest(role:int, otherName:String, askerId:Number):void
        {
            var playedCharacterInfo:Object = this.playerApi.getPlayedCharacterInfo();
            if (askerId == playedCharacterInfo.id)
            {
                this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.exchange"), this.uiApi.getText("ui.craft.waitForCraftClient", otherName), [this.uiApi.getText("ui.common.cancel")], [this.sendActionCraftRefuse], null, this.sendActionCraftRefuse);
            }
            else
            {
                this._ignoreName = otherName;
                if (role == ExchangeTypeEnum.MULTICRAFT_CUSTOMER)
                {
                    this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.exchange"), this.uiApi.getText("ui.craft.CrafterAskCustomer", otherName), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no"), this.uiApi.getText("ui.common.ignore")], [this.sendActionCraftAccept, this.sendActionCraftRefuse, this.sendActionIgnore], this.sendActionCraftAccept, this.sendActionCraftRefuse);
                }
                else
                {
                    if (role == ExchangeTypeEnum.MULTICRAFT_CRAFTER)
                    {
                        this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.exchange"), this.uiApi.getText("ui.craft.CustomerAskCrafter", otherName), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no"), this.uiApi.getText("ui.common.ignore")], [this.sendActionCraftAccept, this.sendActionCraftRefuse, this.sendActionIgnore], this.sendActionCraftAccept, this.sendActionCraftRefuse);
                    };
                };
            };
        }

        private function onJobLevelUp(jobId:uint, jobName:String, newLevel:uint, podsBonus:uint):void
        {
            this.notificationApi.showNotification(this.uiApi.getText("ui.craft.jobLevelUp"), this.uiApi.getText("ui.craft.newJobLevel", jobName, newLevel, podsBonus), NotificationTypeEnum.INFORMATION);
        }

        private function onExchangeLeave(success:Boolean):void
        {
            if (this.uiApi.getUi(this._popupName))
            {
                this.uiApi.unloadUi(this._popupName);
            };
        }

        private function sendActionCraftAccept():void
        {
            this.sysApi.sendAction(new ExchangeAccept());
        }

        private function sendActionCraftRefuse():void
        {
            this.sysApi.sendAction(new ExchangeRefuse());
        }

        private function sendActionIgnore():void
        {
            this.sysApi.sendAction(new ExchangeRefuse());
            this.sysApi.sendAction(new AddIgnored(this._ignoreName));
        }

        public function onExchangeStartOkJobIndex(list:*):void
        {
            var jobItem:*;
            var jobIds:Array = new Array();
            for each (jobItem in list)
            {
                jobIds.push(jobItem);
            };
            this.uiApi.loadUi("crafterList", "crafterList", jobIds);
        }

        public function onExchangeStartOkRunesTrade():void
        {
            this.uiApi.loadUi(UIEnum.RUNE_MAKER, UIEnum.RUNE_MAKER);
            this.sysApi.dispatchHook(OpenInventory, "decraft", UIEnum.STORAGE_UI);
        }

        public function onExchangeStartOkRecycleTrade(percentToPlayer:uint, percentToPrism:uint):void
        {
            this.uiApi.loadUi(UIEnum.RECYCLE, UIEnum.RECYCLE, [percentToPlayer, percentToPrism]);
            this.sysApi.dispatchHook(OpenInventory, "decraft", UIEnum.STORAGE_UI);
        }

        protected function onJobsExpOtherPlayerUpdated(playerId:Number, jobExperience:Object):void
        {
            this._jobExpByPlayerId[playerId] = jobExperience;
        }


    }
} Ankama_Job

