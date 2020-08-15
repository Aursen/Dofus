package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.types.data.UiModule;
    import flash.globalization.Collator;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.JobsFrame;
    import com.ankamagames.dofus.logic.game.common.frames.AveragePricesFrame;
    import com.ankamagames.dofus.logic.game.common.frames.CraftFrame;
    import com.ankamagames.dofus.network.types.game.interactive.skill.SkillActionDescription;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobDescription;
    import com.ankamagames.dofus.datacenter.jobs.Skill;
    import com.ankamagames.dofus.network.types.game.interactive.skill.SkillActionDescriptionCollect;
    import com.ankamagames.dofus.network.types.game.interactive.skill.SkillActionDescriptionCraft;
    import com.ankamagames.dofus.datacenter.items.Item;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.internalDatacenter.jobs.KnownJobWrapper;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.datacenter.jobs.Recipe;
    import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
    import com.ankamagames.dofus.datacenter.jobs.Job;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementSkill;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.ProtocolConstantsEnum;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.jerakine.data.XmlConfig;
    import __AS3__.vec.*;

    [InstanciedApi]
    public class JobsApi implements IApi 
    {

        protected var _log:Logger = Log.getLogger(getQualifiedClassName(JobsApi));
        private var _module:UiModule;
        private var _stringSorter:Collator;


        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        private function get jobsFrame():JobsFrame
        {
            return (Kernel.getWorker().getFrame(JobsFrame) as JobsFrame);
        }

        private function get averagePricesFrame():AveragePricesFrame
        {
            return (Kernel.getWorker().getFrame(AveragePricesFrame) as AveragePricesFrame);
        }

        public function destroy():void
        {
            this._module = null;
        }

        public function getCurrentCraftSkillId():int
        {
            var craftFrame:CraftFrame = (Kernel.getWorker().getFrame(CraftFrame) as CraftFrame);
            return (craftFrame.skillId);
        }

        public function getJobSkills(jobId:int):Array
        {
            var sd:SkillActionDescription;
            var jd:JobDescription = this.getJobDescription(jobId);
            if (!jd)
            {
                return (null);
            };
            var jobSkills:Array = new Array(jd.skills.length);
            var index:uint;
            for each (sd in jd.skills)
            {
                var _local_8:* = index++;
                jobSkills[_local_8] = Skill.getSkillById(sd.skillId);
            };
            return (jobSkills);
        }

        public function getJobSkillType(jobId:int, skill:Skill):String
        {
            var jd:JobDescription = this.getJobDescription(jobId);
            if (!jd)
            {
                return ("unknown");
            };
            var sd:SkillActionDescription = this.getSkillActionDescription(jd, skill.id);
            if (!sd)
            {
                return ("unknown");
            };
            switch (true)
            {
                case (sd is SkillActionDescriptionCollect):
                    return ("collect");
                case (sd is SkillActionDescriptionCraft):
                    return ("craft");
            };
            this._log.warn(("Unknown SkillActionDescription type : " + sd));
            return ("unknown");
        }

        public function getJobCollectSkillInfos(jobId:int, skill:Skill):Object
        {
            var jd:JobDescription = this.getJobDescription(jobId);
            if (!jd)
            {
                return (null);
            };
            var sd:SkillActionDescription = this.getSkillActionDescription(jd, skill.id);
            if (!sd)
            {
                return (null);
            };
            if (!(sd is SkillActionDescriptionCollect))
            {
                return (null);
            };
            var sdc:SkillActionDescriptionCollect = (sd as SkillActionDescriptionCollect);
            var infos:Object = new Object();
            infos.time = (sdc.time / 10);
            infos.minResources = sdc.min;
            infos.maxResources = sdc.max;
            infos.resourceItem = Item.getItemById(skill.gatheredRessourceItem);
            return (infos);
        }

        public function getMaxSlotsByJobId(jobId:int):int
        {
            return (8);
        }

        public function getJobExperience(jobId:int):Object
        {
            if (jobId == DataEnum.JOB_ID_BASE)
            {
                return (null);
            };
            var kj:KnownJobWrapper = PlayedCharacterManager.getInstance().jobs[jobId];
            if (!kj)
            {
                return (null);
            };
            var xp:Object = new Object();
            xp.currentLevel = kj.jobLevel;
            xp.currentExperience = kj.jobXP;
            xp.levelExperienceFloor = kj.jobXpLevelFloor;
            xp.levelExperienceCeil = kj.jobXpNextLevelFloor;
            return (xp);
        }

        public function getCraftXp(item:ItemWrapper, jobLevel:uint):int
        {
            return (item.getCraftXpByJobLevel(jobLevel));
        }

        public function getSkillFromId(skillId:int):Skill
        {
            return (Skill.getSkillById(skillId));
        }

        public function getRecipe(objectId:uint):Recipe
        {
            return (Recipe.getRecipeByResultId(objectId));
        }

        public function craftHasCriteria(objectId:uint):Boolean
        {
            var it:Item = Item.getItemById(objectId);
            var visibleCriterion:GroupItemCriterion = ((it) ? it.craftVisibleConditions : null);
            var feasibleCriterion:GroupItemCriterion = ((it) ? it.craftFeasibleConditions : null);
            return ((visibleCriterion) || (feasibleCriterion));
        }

        public function checkCraftVisible(objectId:uint):Boolean
        {
            var it:Item = Item.getItemById(objectId);
            var gic:GroupItemCriterion = ((it) ? it.craftVisibleConditions : null);
            return ((gic) ? gic.isRespected : true);
        }

        public function checkCraftFeasible(objectId:uint):Boolean
        {
            var it:Item = Item.getItemById(objectId);
            var gic:GroupItemCriterion = ((it) ? it.craftFeasibleConditions : null);
            return ((gic) ? gic.isRespected : true);
        }

        public function getRecipesList(objectId:uint):Array
        {
            var recipeList:Array = Item.getItemById(objectId).recipes;
            if (recipeList)
            {
                return (recipeList);
            };
            return (new Array());
        }

        public function getJobName(pJobId:uint):String
        {
            var job:Job = Job.getJobById(pJobId);
            if (job)
            {
                return (job.name);
            };
            this._log.error((("We want the name of a non-existing job (id : " + pJobId) + ")"));
            return ("");
        }

        public function getJob(pJobId:uint):Object
        {
            return (Job.getJobById(pJobId));
        }

        public function getJobCrafterDirectorySettingsById(jobId:uint):Object
        {
            if (((!(this.jobsFrame)) || (!(this.jobsFrame.settings))))
            {
                return (null);
            };
            return (this.jobsFrame.settings[jobId]);
        }

        public function getUsableSkillsInMap(playerId:Number):Array
        {
            var hasSkill:Boolean;
            var skillId:uint;
            var ie:InteractiveElement;
            var interactiveSkill:InteractiveElementSkill;
            var interactiveSkill2:InteractiveElementSkill;
            var usableSkills:Array = new Array();
            var rpContextFrame:RoleplayContextFrame = (Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame);
            var ies:Vector.<InteractiveElement> = rpContextFrame.entitiesFrame.interactiveElements;
            var skills:Vector.<uint> = rpContextFrame.getMultiCraftSkills(playerId);
            for each (skillId in skills)
            {
                hasSkill = false;
                for each (ie in ies)
                {
                    for each (interactiveSkill in ie.enabledSkills)
                    {
                        if (((skillId == interactiveSkill.skillId) && (usableSkills.indexOf(interactiveSkill.skillId) == -1)))
                        {
                            hasSkill = true;
                            break;
                        };
                    };
                    for each (interactiveSkill2 in ie.disabledSkills)
                    {
                        if (((skillId == interactiveSkill2.skillId) && (usableSkills.indexOf(interactiveSkill2.skillId) == -1)))
                        {
                            hasSkill = true;
                            break;
                        };
                    };
                    if (hasSkill)
                    {
                        break;
                    };
                };
                if (hasSkill)
                {
                    usableSkills.push(Skill.getSkillById(skillId));
                };
            };
            return (usableSkills);
        }

        public function getKnownJobs():Array
        {
            var kj:KnownJobWrapper;
            var knownJobs:Array = new Array();
            for each (kj in PlayedCharacterManager.getInstance().jobs)
            {
                if (kj == null)
                {
                }
                else
                {
                    knownJobs.push(kj);
                };
            };
            return (knownJobs);
        }

        public function getKnownJob(jobId:uint):KnownJobWrapper
        {
            var kj:KnownJobWrapper;
            if (!PlayedCharacterManager.getInstance().jobs)
            {
                return (null);
            };
            if (jobId == DataEnum.JOB_ID_BASE)
            {
                kj = new KnownJobWrapper();
                kj.id = 1;
                kj.jobLevel = ProtocolConstantsEnum.MAX_JOB_LEVEL;
            }
            else
            {
                kj = (PlayedCharacterManager.getInstance().jobs[jobId] as KnownJobWrapper);
            };
            if (!kj)
            {
                return (null);
            };
            return (kj);
        }

        public function getRecipesByJob(details:Dictionary, skillId:int=0, jobId:int=0, fromBank:Boolean=false, missingIngredientsTolerance:int=8):Vector.<Recipe>
        {
            var allRecipes:Array;
            var i:int;
            var recipe:Recipe;
            var totalIngredients:int;
            var requiredQty:int;
            var totalQty:int;
            var foundIngredients:int;
            var foundIngredientsQty:int;
            var occurences:Array;
            var missingIngredients:int;
            var j:int;
            var potentialMaxOccurence:uint;
            var val:uint;
            var recipes:Vector.<Recipe> = new Vector.<Recipe>();
            if (skillId > 0)
            {
                allRecipes = Recipe.getAllRecipesForSkillId(skillId, ProtocolConstantsEnum.MAX_JOB_LEVEL);
            }
            else
            {
                if (jobId > 0)
                {
                    allRecipes = Recipe.getRecipesByJobId(jobId);
                }
                else
                {
                    allRecipes = Recipe.getAllRecipes();
                };
            };
            var l:int = allRecipes.length;
            i = 0;
            while (i < l)
            {
                recipe = allRecipes[i];
                totalIngredients = recipe.ingredientIds.length;
                if (((!(recipe.job)) || ((jobId == 0) && (recipe.jobId == DataEnum.JOB_ID_BASE))))
                {
                }
                else
                {
                    requiredQty = 0;
                    totalQty = 0;
                    foundIngredients = 0;
                    foundIngredientsQty = 0;
                    occurences = new Array();
                    missingIngredients = missingIngredientsTolerance;
                    j = 0;
                    while (j < totalIngredients)
                    {
                        requiredQty = (requiredQty + recipe.quantities[j]);
                        if (details[recipe.ingredientIds[j]])
                        {
                            totalQty = details[recipe.ingredientIds[j]].totalQuantity;
                        }
                        else
                        {
                            totalQty = 0;
                        };
                        if (totalQty)
                        {
                            if (totalQty >= recipe.quantities[j])
                            {
                                occurences.push(int((totalQty / recipe.quantities[j])));
                                foundIngredientsQty = (foundIngredientsQty + recipe.quantities[j]);
                                foundIngredients++;
                            }
                            else
                            {
                                occurences.push(0);
                                missingIngredients--;
                            };
                        }
                        else
                        {
                            if (missingIngredients > 0)
                            {
                                occurences.push(0);
                                missingIngredients--;
                            };
                        };
                        j++;
                    };
                    if (((((foundIngredients == recipe.ingredientIds.length) && (foundIngredientsQty >= requiredQty)) || (missingIngredientsTolerance == 8)) || (((missingIngredientsTolerance > 0) && (foundIngredients > 0)) && ((foundIngredients + missingIngredientsTolerance) >= recipe.ingredientIds.length))))
                    {
                        recipes.push(recipe);
                        occurences.sort(Array.NUMERIC);
                        if (!details[recipe.resultId])
                        {
                            details[recipe.resultId] = {"actualMaxOccurence":occurences[0]};
                        }
                        else
                        {
                            details[recipe.resultId].actualMaxOccurence = occurences[0];
                        };
                        if (fromBank)
                        {
                            potentialMaxOccurence = 0;
                            for each (val in occurences)
                            {
                                if (val != 0)
                                {
                                    potentialMaxOccurence = val;
                                    break;
                                };
                            };
                            details[recipe.resultId].potentialMaxOccurence = potentialMaxOccurence;
                        };
                    };
                };
                i++;
            };
            recipes.fixed = true;
            return (recipes);
        }

        public function getJobFilteredRecipes(recipes:Object, resultTypes:Array, minLevel:int=1, maxLevel:int=1, search:String=null, typeId:int=0):Array
        {
            var recipe:Recipe;
            var okForLevel:Boolean;
            var okForType:Boolean;
            var okForSearch:Boolean;
            var recipesResult:Array = new Array();
            if (search)
            {
                search = StringUtils.noAccent(search).toLowerCase();
            };
            for each (recipe in recipes)
            {
                if (recipe)
                {
                    okForLevel = false;
                    okForType = false;
                    okForSearch = false;
                    if (((minLevel > 1) || (maxLevel < ProtocolConstantsEnum.MAX_JOB_LEVEL)))
                    {
                        if (((recipe.resultLevel >= minLevel) && (recipe.resultLevel <= maxLevel)))
                        {
                            okForLevel = true;
                        }
                        else
                        {
                            okForLevel = false;
                        };
                    }
                    else
                    {
                        okForLevel = true;
                    };
                    if (typeId > 0)
                    {
                        if (recipe.resultTypeId == typeId)
                        {
                            okForType = true;
                        }
                        else
                        {
                            okForType = false;
                        };
                    }
                    else
                    {
                        okForType = true;
                    };
                    if ((((okForLevel) && (okForType)) && (search)))
                    {
                        if (recipe.words.indexOf(search) != -1)
                        {
                            okForSearch = true;
                        }
                        else
                        {
                            okForSearch = false;
                        };
                    }
                    else
                    {
                        okForSearch = true;
                    };
                    if (((okForLevel) && (okForSearch)))
                    {
                        if (resultTypes.indexOf(recipe.result.type) == -1)
                        {
                            resultTypes.push(recipe.result.type);
                        };
                        if (okForType)
                        {
                            recipesResult.push(recipe);
                        };
                    };
                };
            };
            return (recipesResult);
        }

        public function getInventoryData(fromBank:Boolean=false):Array
        {
            var allRecipes:Array;
            var resourceItems:Vector.<ItemWrapper>;
            var ingredient:ItemWrapper;
            var bagItems:Vector.<ItemWrapper>;
            var details:Array = new Array();
            var recipes:Vector.<Recipe> = new Vector.<Recipe>();
            if (fromBank)
            {
                resourceItems = InventoryManager.getInstance().bankInventory.getView("bank").content;
            }
            else
            {
                resourceItems = InventoryManager.getInstance().inventory.getView("storage").content;
            };
            var l:int = resourceItems.length;
            var i:int;
            while (i < l)
            {
                ingredient = resourceItems[i];
                if (!ingredient.linked)
                {
                    if (!details[ingredient.objectGID])
                    {
                        details[ingredient.objectGID] = {
                            "totalQuantity":ingredient.quantity,
                            "stackUidList":[ingredient.objectUID],
                            "stackQtyList":[ingredient.quantity],
                            "fromBag":[false],
                            "storageTotalQuantity":ingredient.quantity
                        };
                    }
                    else
                    {
                        details[ingredient.objectGID].totalQuantity = (details[ingredient.objectGID].totalQuantity + ingredient.quantity);
                        details[ingredient.objectGID].stackUidList.push(ingredient.objectUID);
                        details[ingredient.objectGID].stackQtyList.push(ingredient.quantity);
                        details[ingredient.objectGID].fromBag.push(false);
                        details[ingredient.objectGID].storageTotalQuantity = (details[ingredient.objectGID].storageTotalQuantity + ingredient.quantity);
                    };
                };
                i++;
            };
            if (fromBank)
            {
                bagItems = InventoryManager.getInstance().inventory.getView("storage").content;
                l = bagItems.length;
                i = 0;
                while (i < l)
                {
                    ingredient = bagItems[i];
                    if (!ingredient.linked)
                    {
                        if (!details[ingredient.objectGID])
                        {
                            details[ingredient.objectGID] = {
                                "totalQuantity":ingredient.quantity,
                                "stackUidList":[ingredient.objectUID],
                                "stackQtyList":[ingredient.quantity],
                                "fromBag":[true]
                            };
                        }
                        else
                        {
                            details[ingredient.objectGID].totalQuantity = (details[ingredient.objectGID].totalQuantity + ingredient.quantity);
                            details[ingredient.objectGID].stackUidList.push(ingredient.objectUID);
                            details[ingredient.objectGID].stackQtyList.push(ingredient.quantity);
                            details[ingredient.objectGID].fromBag.push(true);
                        };
                    };
                    i++;
                };
            };
            return (details);
        }

        public function sortRecipesByCriteria(recipes:Object, sortCriteria:String, sortDescending:Boolean):Object
        {
            this.sortRecipes(recipes, sortCriteria, ((sortDescending) ? 1 : -1));
            return (recipes);
        }

        private function sortRecipes(recipes:Object, criteria:String, way:int=1):void
        {
            if (!this._stringSorter)
            {
                this._stringSorter = new Collator(XmlConfig.getInstance().getEntry("config.lang.current"));
            };
            switch (criteria)
            {
                case "level":
                    recipes.sort(this.compareLevel(way));
                    break;
                case "price":
                    recipes.sort(this.comparePrice(way));
                    break;
            };
        }

        private function compareLevel(way:int=1):Function
        {
            return (function (a:*, b:*):Number
            {
                if (a.resultLevel < b.resultLevel)
                {
                    return (-(way));
                };
                if (a.resultLevel > b.resultLevel)
                {
                    return (way);
                };
                return (_stringSorter.compare(a.resultName, b.resultName));
            });
        }

        private function comparePrice(way:int=1):Function
        {
            return (function (a:*, b:*):Number
            {
                var aL:* = averagePricesFrame.pricesData.items[a.resultId];
                var bL:* = averagePricesFrame.pricesData.items[b.resultId];
                if (!aL)
                {
                    aL = ((way == 1) ? ProtocolConstantsEnum.MAX_KAMA : 0);
                };
                if (!bL)
                {
                    bL = ((way == 1) ? ProtocolConstantsEnum.MAX_KAMA : 0);
                };
                if (aL < bL)
                {
                    return (-(way));
                };
                if (aL > bL)
                {
                    return (way);
                };
                return (_stringSorter.compare(a.resultName, b.resultName));
            });
        }

        private function getJobDescription(jobId:uint):JobDescription
        {
            var kj:KnownJobWrapper = this.getKnownJob(jobId);
            if (!kj)
            {
                return (null);
            };
            return (kj.jobDescription);
        }

        private function getSkillActionDescription(jd:JobDescription, skillId:uint):SkillActionDescription
        {
            var sd:SkillActionDescription;
            for each (sd in jd.skills)
            {
                if (sd.skillId == skillId)
                {
                    return (sd);
                };
            };
            return (null);
        }


    }
}

