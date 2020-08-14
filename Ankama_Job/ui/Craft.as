package Ankama_Job.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.JobsApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.ContextMenuApi;
    import com.ankamagames.dofus.uiApi.InventoryApi;
    import com.ankamagames.dofus.uiApi.SoundApi;
    import com.ankamagames.dofus.uiApi.StorageApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Slot;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.ProgressBar;
    import com.ankamagames.berilia.components.EntityDisplayer;
    import com.ankamagames.dofus.datacenter.jobs.Skill;
    import com.ankamagames.dofus.internalDatacenter.jobs.KnownJobWrapper;
    import flash.utils.Timer;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import d2hooks.JobLevelUp;
    import d2hooks.PlayerListUpdate;
    import d2hooks.ExchangeCraftResult;
    import d2hooks.ExchangeItemAutoCraftStoped;
    import d2hooks.DropStart;
    import d2hooks.DropEnd;
    import d2hooks.ExchangeReplayCountModified;
    import d2hooks.ExchangeLeave;
    import d2hooks.RecipeSelected;
    import d2hooks.MouseAltDoubleClick;
    import d2hooks.MouseCtrlDoubleClick;
    import d2hooks.ExchangeObjectAdded;
    import d2hooks.JobsExpUpdated;
    import d2enums.ComponentHookList;
    import flash.events.TimerEvent;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import d2actions.LeaveDialogRequest;
    import d2actions.CloseInventory;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import d2actions.ExchangeReplay;
    import d2actions.ExchangeObjectMove;
    import com.ankamagames.dofus.datacenter.jobs.Recipe;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import d2actions.ExchangeReady;
    import com.ankamagames.dofus.network.enums.CraftResultEnum;
    import com.ankamagames.dofus.network.enums.ExchangeReplayStopReasonEnum;
    import d2actions.ExchangeSetCraftRecipe;
    import d2actions.DisplayContextualMenu;
    import d2hooks.*;
    import d2actions.*;

    public class Craft 
    {

        public static const STEP_READY_TO_CRAFT:int = 0;
        public static const STEP_RECIPE_KNOWN:int = 1;
        public static const STEP_RECIPE_UNKNOWN:int = 2;
        public static const STEP_CRAFTING:int = 3;
        public static const STEP_CRAFT_ENDED:int = 4;
        public static const STEP_CRAFT_STOPPED:int = 5;

        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="JobsApi")]
        public var jobsApi:JobsApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="ContextMenuApi")]
        public var menuApi:ContextMenuApi;
        [Api(name="InventoryApi")]
        public var inventoryApi:InventoryApi;
        [Api(name="SoundApi")]
        public var soundApi:SoundApi;
        [Api(name="StorageApi")]
        public var storageApi:StorageApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        public var ctr_recipes:GraphicContainer;
        public var ctr_itemResult:GraphicContainer;
        public var slot_item_result:Slot;
        public var lbl_item_result:Label;
        public var ctr_signature:GraphicContainer;
        public var tx_quantity_selected:Texture;
        public var slot_ingredient_1:Slot;
        public var slot_ingredient_2:Slot;
        public var slot_ingredient_3:Slot;
        public var slot_ingredient_4:Slot;
        public var slot_ingredient_5:Slot;
        public var slot_ingredient_6:Slot;
        public var slot_ingredient_7:Slot;
        public var slot_ingredient_8:Slot;
        public var slot_signature:Slot;
        public var slot_item_crafting:Slot;
        public var lbl_title:Label;
        public var lbl_name:Label;
        public var lbl_job:Label;
        public var lbl_item:Label;
        public var lbl_quantity:Label;
        public var btn_quantity_up:ButtonContainer;
        public var btn_quantity_down:ButtonContainer;
        public var pb_progressBar:ProgressBar;
        public var pb_progressBar_other:ProgressBar;
        public var btn_ok:ButtonContainer;
        public var btn_lbl_btn_ok:Label;
        public var ed_player:EntityDisplayer;
        protected var _step:uint;
        protected var _skill:Skill;
        protected var _jobLevel:int;
        protected var _jobXP:int;
        protected var _jobXpLevelFloor:int;
        protected var _jobXpNextLevelFloor:int;
        protected var _jobId:uint;
        protected var _updatedJob:KnownJobWrapper;
        protected var _recipesUi:Object;
        protected var _recipes:Array = new Array();
        protected var _itemToCraft:Object = null;
        protected var _textItemToCraft:String;
        protected var _slotsIngredients:Array;
        protected var _waitingData:Object;
        protected var _waitingSlot:Object;
        protected var _isRecipeKnown:Boolean;
        private var _updateTimer:Timer;
        private var _disableRecipiesTimer:Timer;
        private var _timerBuffer_componentList:Object;
        private var _timerBuffer_slotsIngredients:Object;
        private var _timerBuffer_slotSignature:Object;
        protected var showRecipes:Boolean = true;
        protected var _lvlText:String;
        private var _lastItemQuantity:int = 1;


        public function get skill():Object
        {
            return (this._skill);
        }

        public function get jobLevel():uint
        {
            return (this._jobLevel);
        }

        public function main(params:Object):void
        {
            var slot:*;
            this.sysApi.disableWorldInteraction();
            this.btn_ok.soundId = SoundEnum.OK_BUTTON;
            this.btn_quantity_down.soundId = SoundEnum.SCROLL_DOWN;
            this.btn_quantity_up.soundId = SoundEnum.SCROLL_UP;
            this.sysApi.addHook(JobLevelUp, this.onJobLevelUp);
            this.sysApi.addHook(PlayerListUpdate, this.onPlayerListUpdate);
            this.sysApi.addHook(ExchangeCraftResult, this.onExchangeCraftResult);
            this.sysApi.addHook(ExchangeItemAutoCraftStoped, this.onExchangeItemAutoCraftStoped);
            this.sysApi.addHook(DropStart, this.onDropStart);
            this.sysApi.addHook(DropEnd, this.onDropEnd);
            this.sysApi.addHook(ExchangeReplayCountModified, this.onExchangeReplayCountModified);
            this.sysApi.addHook(ExchangeLeave, this.onExchangeLeave);
            this.sysApi.addHook(RecipeSelected, this.onRecipeSelected);
            this.sysApi.addHook(MouseAltDoubleClick, this.onMouseAltDoubleClick);
            this.sysApi.addHook(MouseCtrlDoubleClick, this.onMouseCtrlDoubleClick);
            this.sysApi.addHook(ExchangeObjectAdded, this.onExchangeObjectAdded);
            this.sysApi.addHook(JobsExpUpdated, this.onJobsExpUpdated);
            this.uiApi.addComponentHook(this.lbl_quantity, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_quantity_up, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_quantity_down, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_ok, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.slot_item_crafting, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.slot_item_crafting, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.slot_item_crafting, ComponentHookList.ON_RIGHT_CLICK);
            this.uiApi.addComponentHook(this.slot_item_result, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.slot_item_result, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.slot_item_result, ComponentHookList.ON_RIGHT_CLICK);
            this.uiApi.addComponentHook(this.pb_progressBar, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.pb_progressBar, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.ed_player, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.ed_player, ComponentHookList.ON_RIGHT_CLICK);
            this._updateTimer = new Timer(150, 1);
            this._updateTimer.addEventListener(TimerEvent.TIMER, this.onTimerEvent);
            this._disableRecipiesTimer = new Timer(300, 1);
            this._disableRecipiesTimer.addEventListener(TimerEvent.TIMER, this.onDisableRecipiesTimer);
            this._lvlText = ((" " + this.uiApi.getText("ui.common.level").toLocaleLowerCase()) + " ");
            this._skill = this.jobsApi.getSkillFromId(params.skillId);
            this._updatedJob = this.jobsApi.getKnownJob(this._skill.parentJobId);
            this._jobLevel = this._updatedJob.jobLevel;
            this._jobId = this._updatedJob.id;
            this._jobXP = this._updatedJob.jobXP;
            this._jobXpLevelFloor = this._updatedJob.jobXpLevelFloor;
            this._jobXpNextLevelFloor = this._updatedJob.jobXpNextLevelFloor;
            if (params.hasOwnProperty("jobLevel"))
            {
                this._jobLevel = params.jobLevel;
            };
            if (this._skill.parentJobId != DataEnum.JOB_ID_BASE)
            {
                this.lbl_title.text = this.uiApi.getText("ui.craft.crafter");
                if (this.lbl_job)
                {
                    this.lbl_job.text = ((this._updatedJob.name + this._lvlText) + this._jobLevel);
                };
            }
            else
            {
                this.lbl_title.text = this._skill.name;
                if (this.lbl_job)
                {
                    this.lbl_job.text = "";
                };
                this.pb_progressBar.visible = false;
            };
            this.lbl_name.text = this.playerApi.getEntityInfos().name;
            var percentLvl:Number = ((this._jobXP - this._jobXpLevelFloor) / (this._jobXpNextLevelFloor - this._jobXpLevelFloor));
            if (((percentLvl > 1) || (this._jobXpNextLevelFloor == 0)))
            {
                percentLvl = 1;
            };
            this.pb_progressBar.value = percentLvl;
            this._slotsIngredients = new Array(this.slot_ingredient_1, this.slot_ingredient_2, this.slot_ingredient_3, this.slot_ingredient_4, this.slot_ingredient_5, this.slot_ingredient_6, this.slot_ingredient_7, this.slot_ingredient_8);
            for each (slot in this._slotsIngredients)
            {
                slot.dropValidator = (this.dropValidatorFunction as Function);
                slot.processDrop = (this.processDropFunction as Function);
                this.uiApi.addComponentHook(slot, ComponentHookList.ON_ROLL_OVER);
                this.uiApi.addComponentHook(slot, ComponentHookList.ON_ROLL_OUT);
                this.uiApi.addComponentHook(slot, ComponentHookList.ON_DOUBLE_CLICK);
                this.uiApi.addComponentHook(slot, ComponentHookList.ON_RIGHT_CLICK);
                this.uiApi.addComponentHook(slot, ComponentHookList.ON_RELEASE);
                slot.emptyTexture = this.uiApi.createUri(this.uiApi.me().getConstant("emptySlot"));
            };
            this.slot_signature.dropValidator = (this.dropValidatorFunction as Function);
            this.slot_signature.processDrop = (this.processDropFunction as Function);
            this.uiApi.addComponentHook(this.slot_signature, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.slot_signature, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.slot_signature, ComponentHookList.ON_DOUBLE_CLICK);
            this.uiApi.addComponentHook(this.slot_signature, ComponentHookList.ON_RIGHT_CLICK);
            this.uiApi.addComponentHook(this.slot_signature, ComponentHookList.ON_RELEASE);
            if (this.showRecipes)
            {
                this._recipesUi = this.modCommon.createRecipesObject("recipesCraft", this.ctr_recipes, this.ctr_recipes, this._skill.parentJobId, this._skill.id, true, "", this._jobLevel);
            };
            if (this._jobLevel < ProtocolConstantsEnum.MAX_JOB_LEVEL)
            {
                this.ctr_signature.visible = false;
            }
            else
            {
                this.ctr_signature.visible = true;
            };
            this.switchUI(STEP_READY_TO_CRAFT, true);
            this.ed_player.yOffset = 30;
            this.ed_player.entityScale = 1.5;
            this.ed_player.direction = 1;
            this.ed_player.look = this.playerApi.getPlayedCharacterInfo().entityLook;
        }

        public function unload():void
        {
            this._updateTimer.removeEventListener(TimerEvent.TIMER, this.onTimerEvent);
            this._disableRecipiesTimer.removeEventListener(TimerEvent.TIMER, this.onDisableRecipiesTimer);
            this.uiApi.unloadUi("recipesCraft");
            this.uiApi.unloadUi("itemBoxCraft");
            this.storageApi.removeAllItemMasks("craft");
            this.storageApi.releaseHooks();
            this.sysApi.sendAction(new LeaveDialogRequest());
            this.sysApi.sendAction(new CloseInventory());
            this.sysApi.enableWorldInteraction();
        }

        public function get itemQuantity():int
        {
            return (parseInt(this.lbl_quantity.text));
        }

        public function containAtLeastOneIngredient():Boolean
        {
            if (this.slot_ingredient_1.data)
            {
                return (true);
            };
            return (false);
        }

        protected function setQuantity(quantity:int, updateProgressMax:Boolean=false):void
        {
            var slot:Slot;
            if (quantity == this.itemQuantity)
            {
                return;
            };
            this.storageApi.removeAllItemMasks("craft");
            for each (slot in this._slotsIngredients)
            {
                if (slot.data)
                {
                    this.storageApi.addItemMask(slot.data.objectUID, "craft", (slot.data.quantity * quantity));
                };
            };
            this.storageApi.releaseHooks();
            this.lbl_quantity.text = quantity.toString();
            this._lastItemQuantity = this.itemQuantity;
        }

        protected function displayPreviewItem(item:Object):void
        {
            if (item)
            {
                this.tx_quantity_selected.visible = true;
                this.lbl_item.text = item.name;
                this.slot_item_crafting.data = item;
            }
            else
            {
                this.tx_quantity_selected.visible = false;
                this.lbl_item.text = "";
                this.slot_item_crafting.data = null;
            };
        }

        protected function displayResultItem(item:Object):void
        {
            if (item)
            {
                this.ctr_itemResult.visible = true;
                this.slot_item_result.data = item;
                this.slot_item_result.visible = true;
                this.lbl_item_result.text = (item.name + ((this.itemQuantity > 1) ? (" x " + this.itemQuantity) : ""));
            }
            else
            {
                this.ctr_itemResult.visible = false;
                this.slot_item_result.visible = false;
                this.slot_item_result.data = null;
                this.lbl_item_result.text = null;
            };
        }

        protected function disableQuantity(disabled:Boolean):void
        {
            this.lbl_quantity.disabled = disabled;
            this.btn_quantity_up.disabled = disabled;
            this.btn_quantity_down.disabled = disabled;
        }

        public function processDropToInventory(target:Object, d:Object, source:Object):void
        {
            if (d.info1 > 1)
            {
                this.modCommon.openQuantityPopup(1, d.quantity, d.quantity, this.onValidQtyDropToInventory);
            }
            else
            {
                this.unfillSlot(this._waitingSlot, -1);
            };
        }

        protected function onValidQtyDropToInventory(qty:Number):void
        {
            this.unfillSlot(this._waitingSlot, qty);
        }

        public function fillAutoSlot(item:Object, quantity:int, force:Boolean=false):void
        {
            var slot:Object;
            if (item.id == DataEnum.ITEM_GID_SIGNATURE_RUNE)
            {
                if (this.dropValidatorFunction(this.slot_signature, item, null))
                {
                    if (this._jobLevel < ProtocolConstantsEnum.MAX_JOB_LEVEL)
                    {
                        this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.craft.jobLevelLowForSignature"), [this.uiApi.getText("ui.common.ok")]);
                        return;
                    };
                    this.fillSlot(this.slot_signature, item, 1);
                };
            }
            else
            {
                slot = null;
                for each (slot in this._slotsIngredients)
                {
                    if (((slot.data) && (slot.data.objectGID == item.objectGID)))
                    {
                        this.fillSlot(null, item, quantity);
                        return;
                    };
                    if (slot.data == null)
                    {
                        this.fillSlot(slot, item, quantity);
                        return;
                    };
                };
                if (force)
                {
                    this.fillSlot(null, item, quantity);
                };
            };
        }

        protected function switchUI(step:uint, force:Boolean=false):void
        {
            if (((this._step == step) && (!(force))))
            {
                return;
            };
            this._step = step;
            switch (step)
            {
                case STEP_READY_TO_CRAFT:
                    this.sysApi.log(2, "STEP_READY_TO_CRAFT");
                    this.displayPreviewItem(null);
                    this.disableQuantity(true);
                    this.setQuantity(1);
                    this.displayResultItem(null);
                    this.btn_ok.disabled = true;
                    break;
                case STEP_RECIPE_KNOWN:
                    this.sysApi.log(2, "STEP_RECIPE_KNOWN");
                    this.soundApi.playSound(SoundTypeEnum.RECIPE_MATCH);
                    this.displayPreviewItem(this._itemToCraft);
                    this.disableQuantity(false);
                    this.setQuantity(this._lastItemQuantity);
                    this.displayResultItem(null);
                    this.btn_ok.disabled = false;
                    break;
                case STEP_RECIPE_UNKNOWN:
                    this.sysApi.log(2, "STEP_RECIPE_UNKNOWN");
                    this.displayPreviewItem(null);
                    this.disableQuantity(false);
                    if (!this.containAtLeastOneIngredient())
                    {
                        this.btn_ok.disabled = true;
                    }
                    else
                    {
                        this.btn_ok.disabled = false;
                    };
                    break;
                case STEP_CRAFTING:
                    this.sysApi.log(2, "STEP_CRAFTING");
                    this.disableQuantity(true);
                    this.btn_ok.disabled = true;
                    break;
                case STEP_CRAFT_ENDED:
                    this.sysApi.log(2, "STEP_CRAFT_ENDED");
                    if (this._skill.id != 209)
                    {
                        this.cleanAllItems();
                    };
                    this.displayPreviewItem(null);
                    this.disableQuantity(false);
                    this.displayResultItem(this._itemToCraft);
                    this.btn_ok.disabled = true;
                    break;
                case STEP_CRAFT_STOPPED:
                    this.sysApi.log(2, "STEP_CRAFT_STOPPED");
                    this.disableQuantity(false);
                    this.displayResultItem(this._itemToCraft);
                    if (!this.containAtLeastOneIngredient())
                    {
                        this.btn_ok.disabled = true;
                    }
                    else
                    {
                        this.btn_ok.disabled = false;
                    };
                    break;
            };
        }

        protected function isValidContent(slot:Object, item:Object):Boolean
        {
            switch (slot)
            {
                case this.slot_signature:
                    if (item.id == DataEnum.ITEM_GID_SIGNATURE_RUNE)
                    {
                        return (true);
                    };
                    return (false);
                case this.slot_ingredient_1:
                case this.slot_ingredient_2:
                case this.slot_ingredient_3:
                case this.slot_ingredient_4:
                case this.slot_ingredient_5:
                case this.slot_ingredient_6:
                case this.slot_ingredient_7:
                case this.slot_ingredient_8:
                    if (item.id == DataEnum.ITEM_GID_SIGNATURE_RUNE)
                    {
                        return (false);
                    };
                    return (true);
            };
            return (false);
        }

        protected function dropValidatorFunction(target:Object, data:Object, source:Object):Boolean
        {
            return (this.isValidContent(target, data));
        }

        protected function processDropFunction(target:Object, d:Object, source:Object):void
        {
            if (this.dropValidatorFunction(target, d, source))
            {
                switch (target)
                {
                    case this.slot_signature:
                        this.fillAutoSlot(d, 1);
                        break;
                    default:
                        if (d.quantity > 1)
                        {
                            this._waitingData = d;
                            this.modCommon.openQuantityPopup(1, d.quantity, d.quantity, this.onValidQtyDrop);
                        }
                        else
                        {
                            this.fillAutoSlot(d, 1);
                        };
                };
            };
        }

        private function onValidQtyDrop(qty:Number):void
        {
            this.fillAutoSlot(this._waitingData, qty);
        }

        private function onValidCraftItemQty(qty:Number):void
        {
            this.sysApi.sendAction(new ExchangeReplay(qty));
        }

        private function fillSlot(slot:Object, item:Object, quantity:int):void
        {
            if (((!(slot == null)) && (!(slot.data == null))))
            {
                this.unfillSlot(slot, -1);
            };
            this.sysApi.sendAction(new ExchangeObjectMove(item.objectUID, quantity));
        }

        private function unfillSlot(slot:Object, quantity:int):void
        {
            if (((slot == null) || (slot.data == null)))
            {
                return;
            };
            if (quantity == -1)
            {
                quantity = slot.data.quantity;
            };
            this.sysApi.sendAction(new ExchangeObjectMove(slot.data.objectUID, -(quantity)));
        }

        protected function cleanAllItems():void
        {
            var slot:Object;
            for each (slot in this._slotsIngredients)
            {
                slot.data = null;
            };
            this.slot_signature.data = null;
        }

        protected function removeAllItems():void
        {
            var slot:Object;
            for each (slot in this._slotsIngredients)
            {
                if (slot.data)
                {
                    this.sysApi.sendAction(new ExchangeObjectMove(slot.data.objectUID, -(slot.data.quantity)));
                };
            };
            if (this.slot_signature.data)
            {
                this.sysApi.sendAction(new ExchangeObjectMove(this.slot_signature.data.objectUID, -(this.slot_signature.data.quantity)));
            };
        }

        private function getFirstEmptySlot(slotsIngredients:Object):Object
        {
            var slot:Object;
            for each (slot in slotsIngredients)
            {
                if (slot.data == null)
                {
                    return (slot);
                };
            };
            return (null);
        }

        protected function getSlotsContent():Array
        {
            var slot:Object;
            var filledSlots:Array = new Array();
            for each (slot in this._slotsIngredients)
            {
                if (slot.data != null)
                {
                    filledSlots.push({
                        "objectUID":slot.data.objectUID,
                        "objectGID":slot.data.objectGID,
                        "quantity":slot.data.quantity
                    });
                };
            };
            return (filledSlots);
        }

        protected function checkRecipe():Boolean
        {
            this._isRecipeKnown = false;
            if (this._skill.id == DataEnum.SKILL_WRAP_GIFT)
            {
                this._isRecipeKnown = true;
                return (this._isRecipeKnown);
            };
            var slotsIngredients:Array = this.getSlotsContent();
            var matchingRecipe:Recipe = this.getRecipeWithItems(slotsIngredients);
            if (matchingRecipe)
            {
                this._itemToCraft = matchingRecipe.result;
                this._isRecipeKnown = true;
            }
            else
            {
                this._itemToCraft = null;
            };
            return (this._isRecipeKnown);
        }

        private function getRecipeWithItems(pComponents:Array):Recipe
        {
            var re:Recipe;
            var pass:Boolean;
            var component:Object;
            var componentPass:Boolean;
            var recipeComponent:ItemWrapper;
            if (pComponents.length == 0)
            {
                return (null);
            };
            var recipesWithFirstObject:Object = this.jobsApi.getRecipesList(pComponents[0].objectGID);
            for each (re in recipesWithFirstObject)
            {
                if (re.skillId != this._skill.id)
                {
                }
                else
                {
                    if (re.ingredientIds.length != pComponents.length)
                    {
                    }
                    else
                    {
                        pass = true;
                        for each (component in pComponents)
                        {
                            componentPass = true;
                            for each (recipeComponent in re.ingredients)
                            {
                                if (((component.objectGID == recipeComponent.objectGID) && (component.quantity == recipeComponent.quantity)))
                                {
                                    componentPass = true;
                                    break;
                                };
                                componentPass = false;
                            };
                            if (!componentPass)
                            {
                                pass = false;
                                break;
                            };
                        };
                        if (pass)
                        {
                            if (this.jobsApi.checkCraftFeasible(re.resultId))
                            {
                                return (re);
                            };
                            break;
                        };
                    };
                };
            };
            return (null);
        }

        private function getMaxQuantity():uint
        {
            var item:ItemWrapper;
            var ingredient:Object;
            var quantities:Array = new Array();
            var ingredients:Array = this.getSlotsContent();
            var storage:Object = this.storageApi.getViewContent("storage");
            for each (item in storage)
            {
                for each (ingredient in ingredients)
                {
                    if (item.objectUID == ingredient.objectUID)
                    {
                        quantities.push(Math.floor(((item.quantity + this.storageApi.getItemMaskCount(item.objectUID, "craft")) / ingredient.quantity)));
                    };
                };
            };
            if (quantities.length < ingredients.length)
            {
                return (1);
            };
            quantities.sort((Array.DESCENDING | Array.NUMERIC));
            return (quantities[(quantities.length - 1)]);
        }

        protected function onConfirmCraftRecipe():void
        {
            this.switchUI(STEP_CRAFTING);
            this.sysApi.sendAction(new ExchangeReady(true));
        }

        protected function onCancelCraftRecipe():void
        {
        }

        private function onPlayerListUpdate(playerList:Object):void
        {
            var componentList:Object = playerList.componentList;
            this.fillComponents(componentList, this._slotsIngredients, this.slot_signature, true);
        }

        protected function fillComponents(componentList:Object, slotsIngredients:Object, slotSignature:Object, delay:Boolean=false):void
        {
            this._updateTimer.reset();
            this._timerBuffer_componentList = componentList;
            this._timerBuffer_slotsIngredients = slotsIngredients;
            this._timerBuffer_slotSignature = slotSignature;
            this.onTimerEvent(null);
        }

        protected function onTimerEvent(e:TimerEvent):void
        {
            var hasItem:Boolean;
            var slot:Object;
            var item:Object;
            for each (slot in this._timerBuffer_slotsIngredients)
            {
                if (slot.data)
                {
                    hasItem = false;
                    for each (item in this._timerBuffer_componentList)
                    {
                        if (slot.data.objectUID == item.objectUID)
                        {
                            hasItem = true;
                            break;
                        };
                    };
                    if (!hasItem)
                    {
                        this.storageApi.removeItemMask(slot.data.objectUID, "craft");
                    };
                    slot.data = null;
                };
            };
            if (this._timerBuffer_slotSignature.data)
            {
                hasItem = false;
                for each (item in this._timerBuffer_componentList)
                {
                    if (this._timerBuffer_slotSignature.data.objectUID == item.objectUID)
                    {
                        hasItem = true;
                        break;
                    };
                };
                if (!hasItem)
                {
                    this.storageApi.removeItemMask(this._timerBuffer_slotSignature.data.objectUID, "craft");
                    this._timerBuffer_slotSignature.data = null;
                };
            };
            for each (item in this._timerBuffer_componentList)
            {
                this.storageApi.addItemMask(item.objectUID, "craft", item.quantity);
                if (this.isValidContent(this._timerBuffer_slotSignature, item))
                {
                    this._timerBuffer_slotSignature.data = item;
                }
                else
                {
                    this.getFirstEmptySlot(this._timerBuffer_slotsIngredients).data = item;
                };
            };
            this.storageApi.releaseHooks();
            if (this.checkRecipe())
            {
                this.switchUI(STEP_RECIPE_KNOWN, true);
            }
            else
            {
                this.switchUI(STEP_RECIPE_UNKNOWN, true);
            };
        }

        protected function onExchangeCraftResult(result:uint, item:Object):void
        {
            switch (result)
            {
                case CraftResultEnum.CRAFT_IMPOSSIBLE:
                    if (!item)
                    {
                        this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.craft.noResult"), [this.uiApi.getText("ui.common.ok")]);
                    }
                    else
                    {
                        if (item.level > this._jobLevel)
                        {
                            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.skill.levelLow", this._jobLevel), [this.uiApi.getText("ui.common.ok")]);
                            this._itemToCraft = null;
                        }
                        else
                        {
                            this._itemToCraft = null;
                        };
                    };
                    this.switchUI(STEP_CRAFT_STOPPED);
                    break;
                case CraftResultEnum.CRAFT_FORBIDDEN:
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.craft.forbidden"), [this.uiApi.getText("ui.common.ok")]);
                    break;
                case CraftResultEnum.CRAFT_SUCCESS:
                    this._itemToCraft = item;
                    this.switchUI(STEP_CRAFT_ENDED, true);
                    break;
            };
        }

        protected function onExchangeItemAutoCraftStoped(reason:uint):void
        {
            switch (reason)
            {
                case ExchangeReplayStopReasonEnum.STOPPED_REASON_OK:
                    this.switchUI(STEP_CRAFT_ENDED);
                    break;
                case ExchangeReplayStopReasonEnum.STOPPED_REASON_MISSING_RESSOURCE:
                    this.switchUI(STEP_CRAFT_ENDED);
                    break;
                case ExchangeReplayStopReasonEnum.STOPPED_REASON_IMPOSSIBLE_MODIFICATION:
                    this.switchUI(STEP_CRAFT_STOPPED);
                    break;
            };
        }

        protected function onExchangeReplayCountModified(pCount:int):void
        {
            this.setQuantity(pCount, true);
        }

        private function onExchangeLeave(success:Boolean):void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        protected function onRecipeSelected(pRecipe:Recipe, jobId:int):void
        {
            if (jobId == this._jobId)
            {
                this.fillRecipeIngredients(pRecipe);
            };
        }

        protected function fillRecipeIngredients(recipe:Recipe):void
        {
            var genericObj:Object;
            var obj:Object;
            var recipesComponents:Array = new Array();
            var recipeFull:Boolean = this.isRecipeFull(recipe, recipesComponents);
            this._recipesUi.uiClass.disabled = true;
            this._disableRecipiesTimer.delay = (300 * recipesComponents.length);
            this._disableRecipiesTimer.start();
            this.removeAllItems();
            if (!recipeFull)
            {
                for each (genericObj in recipesComponents)
                {
                    for each (obj in genericObj)
                    {
                        this.sysApi.sendAction(new ExchangeObjectMove(obj.objectUID, obj.quantity));
                    };
                };
            }
            else
            {
                this.sysApi.sendAction(new ExchangeSetCraftRecipe(recipe.resultId));
            };
        }

        protected function isRecipeFull(recipe:Object, recipesComponents:Array):Boolean
        {
            var component:Object;
            var storageItems:Object;
            var recipeFull:Boolean = true;
            for each (component in recipe.ingredients)
            {
                storageItems = this.inventoryApi.getStorageObjectGID(component.objectGID, component.quantity);
                if (storageItems == null)
                {
                    recipeFull = false;
                }
                else
                {
                    recipesComponents.push(storageItems);
                };
            };
            if (!recipeFull)
            {
                this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.craft.dontHaveAllIngredient"), [this.uiApi.getText("ui.common.ok")]);
            };
            return (recipeFull);
        }

        private function onDisableRecipiesTimer(e:TimerEvent):void
        {
            this._recipesUi.uiClass.disabled = false;
        }

        private function onExchangeObjectAdded(item:Object, remote:Object):void
        {
            if (this.checkRecipe())
            {
                this.switchUI(STEP_RECIPE_KNOWN, true);
                if (this._lastItemQuantity > 1)
                {
                    this.sysApi.sendAction(new ExchangeReplay(this._lastItemQuantity));
                };
            }
            else
            {
                this.switchUI(STEP_RECIPE_UNKNOWN, true);
            };
        }

        private function onJobLevelUp(jobId:uint, jobName:String, newLevel:uint, podsBonus:uint):void
        {
            if (jobId == this._jobId)
            {
                this.lbl_job.text = ((jobName + this._lvlText) + newLevel);
                if (newLevel == ProtocolConstantsEnum.MAX_JOB_LEVEL)
                {
                    this.ctr_signature.visible = true;
                };
                this._jobLevel = newLevel;
                if (this.storageApi.getIsCraftFilterEnabled())
                {
                    this.storageApi.enableCraftFilter(this._skill, this._jobLevel);
                };
            };
        }

        protected function onJobsExpUpdated(jobId:uint):void
        {
            var percentLvl:Number;
            if (jobId == this._jobId)
            {
                this._updatedJob = this.jobsApi.getKnownJob(this._jobId);
                this._jobXP = this._updatedJob.jobXP;
                this._jobXpLevelFloor = this._updatedJob.jobXpLevelFloor;
                this._jobXpNextLevelFloor = this._updatedJob.jobXpNextLevelFloor;
                percentLvl = ((this._jobXP - this._jobXpLevelFloor) / (this._jobXpNextLevelFloor - this._jobXpLevelFloor));
                if (((percentLvl > 1) || (this._jobXpNextLevelFloor == 0)))
                {
                    percentLvl = 1;
                };
                this.pb_progressBar.value = percentLvl;
            };
        }

        private function onValidQty(qty:Number):void
        {
            this.unfillSlot(this._waitingSlot, qty);
        }

        public function onRelease(target:Object):void
        {
            var quantity:int;
            var maxQuantity:int;
            switch (target)
            {
                case this.lbl_quantity:
                    maxQuantity = this.getMaxQuantity();
                    this.modCommon.openQuantityPopup(1, maxQuantity, maxQuantity, this.onValidCraftItemQty);
                    break;
                case this.btn_quantity_up:
                    maxQuantity = this.getMaxQuantity();
                    quantity = this.itemQuantity;
                    if (((quantity < maxQuantity) || (maxQuantity == 0)))
                    {
                        this.sysApi.sendAction(new ExchangeReplay((quantity + 1)));
                    };
                    break;
                case this.btn_quantity_down:
                    quantity = this.itemQuantity;
                    if (quantity > 1)
                    {
                        this.sysApi.sendAction(new ExchangeReplay((quantity - 1)));
                    };
                    break;
                case this.btn_ok:
                    if (this.getSlotsContent().length > 0)
                    {
                        this.onConfirmCraftRecipe();
                    };
                    break;
                case this.ed_player:
                    this.sysApi.sendAction(new DisplayContextualMenu(this.playerApi.id()));
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var ttData:String;
            if (((target == this.pb_progressBar) || (target == this.pb_progressBar_other)))
            {
                if (this._jobXpNextLevelFloor == 0)
                {
                    ttData = ((this.uiApi.getText("ui.craft.crafterExperience") + this.uiApi.getText("ui.common.colon")) + this.utilApi.kamasToString(this._jobXP, ""));
                }
                else
                {
                    ttData = ((((this.uiApi.getText("ui.craft.crafterExperience") + this.uiApi.getText("ui.common.colon")) + this.utilApi.kamasToString(this._jobXP, "")) + " / ") + this.utilApi.kamasToString(this._jobXpNextLevelFloor, ""));
                };
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(ttData), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            }
            else
            {
                if (target.data)
                {
                    this.uiApi.showTooltip(target.data, target, false, "standard", 8, 0, 0, "itemName", null, {
                        "showEffects":true,
                        "header":true
                    }, "ItemInfo");
                };
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onDoubleClick(target:Object):void
        {
            if (target.data)
            {
                this.unfillSlot(target, 1);
            };
        }

        private function onMouseCtrlDoubleClick(target:Object):void
        {
            var slotClicked:Boolean;
            var slot:Object;
            if (target.data)
            {
                slotClicked = false;
                for each (slot in this._slotsIngredients)
                {
                    if (slot == target)
                    {
                        slotClicked = true;
                    };
                };
                if (!slotClicked)
                {
                    return;
                };
                this.unfillSlot(target, -1);
            };
        }

        private function onMouseAltDoubleClick(target:Object):void
        {
            var slotClicked:Boolean;
            var slot:Object;
            if (target.data)
            {
                slotClicked = false;
                for each (slot in this._slotsIngredients)
                {
                    if (slot == target)
                    {
                        slotClicked = true;
                    };
                };
                if (!slotClicked)
                {
                    return;
                };
                this._waitingSlot = target;
                this.modCommon.openQuantityPopup(1, target.data.quantity, target.data.quantity, this.onValidQty);
            };
        }

        public function onRightClick(target:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (target == this.ed_player)
            {
                this.sysApi.sendAction(new DisplayContextualMenu(this.playerApi.id()));
            }
            else
            {
                if (target.data)
                {
                    data = target.data;
                    contextMenu = this.menuApi.create(data);
                    if (contextMenu.content.length > 0)
                    {
                        this.modContextMenu.createContextMenu(contextMenu);
                    };
                };
            };
        }

        private function onDropStart(src:Object):void
        {
            var slot:Object;
            this._waitingSlot = src;
            if (this.dropValidatorFunction(this.slot_signature, src.data, null))
            {
                this.slot_signature.selected = true;
            }
            else
            {
                for each (slot in this._slotsIngredients)
                {
                    if (this.dropValidatorFunction(slot, src.data, null))
                    {
                        slot.selected = true;
                    };
                };
            };
        }

        private function onDropEnd(src:Object, target:Object):void
        {
            var slot:Object;
            for each (slot in this._slotsIngredients)
            {
                slot.selected = false;
            };
            this.slot_signature.selected = false;
        }

        public function set slotsIngredients(value:Array):void
        {
            this._slotsIngredients = value;
        }

        public function getPositionFromRecipes(id:uint):int
        {
            var recipe:Recipe;
            var i:int;
            while (i < this._recipesUi.uiClass.gd_recipes.dataProvider.length)
            {
                recipe = this._recipesUi.uiClass.gd_recipes.dataProvider[i];
                if (recipe.resultId == id)
                {
                    return (i);
                };
                i++;
            };
            return (0);
        }

        public function getRecipeLineHeight():int
        {
            return (this._recipesUi.uiClass.gd_recipes.slotHeight);
        }


    }
} Ankama_Job.ui

