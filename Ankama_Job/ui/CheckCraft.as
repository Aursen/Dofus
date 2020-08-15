package Ankama_Job.ui
{
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.internalDatacenter.jobs.KnownJobWrapper;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.JobsApi;
    import com.ankamagames.dofus.uiApi.UtilApi;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.ComboBox;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.dofus.datacenter.jobs.Skill;
    import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
    import d2enums.ComponentHookList;
    import d2hooks.RecipesListRefreshed;
    import d2hooks.JobSelected;
    import __AS3__.vec.*;

    public class CheckCraft 
    {

        public static const SORT_CRITERIA_LEVEL:String = "level";
        public static const SORT_CRITERIA_PRICE:String = "price";
        private static const MISSING_INGREDIENTS_TOLERANCE:Array = ["0", "1", "2", "3", "4", "5", "6", "7"];
        private static var _jobs:Vector.<KnownJobWrapper>;
        private static var _jobNames:Array;

        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="JobsApi")]
        public var jobsApi:JobsApi;
        [Api(name="UtilApi")]
        public var utilApi:UtilApi;
        public var btn_close:ButtonContainer;
        public var combo_job:ComboBox;
        public var btn_sortByLvl:ButtonContainer;
        public var btn_sortByPrice:ButtonContainer;
        public var combo_ingredientsTolerance:ComboBox;
        public var ctr_recipes:GraphicContainer;
        public var lbl_totalRecipes:Label;
        public var lbl_tolerance:Label;
        private var _currentJob:KnownJobWrapper;
        private var _sortCriteria:String;
        private var _storage:String;
        private var _recipeUi:Object;


        public function main(oParam:Object=null):void
        {
            var allSkills:Object;
            var alreadySavedJobId:Array;
            var kj:KnownJobWrapper;
            var skill:Skill;
            this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
            this.uiApi.addComponentHook(this.btn_close, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.combo_job, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.combo_ingredientsTolerance, ComponentHookList.ON_SELECT_ITEM);
            this.sysApi.addHook(RecipesListRefreshed, this.onRecipesListRefreshed);
            this._sortCriteria = SORT_CRITERIA_LEVEL;
            this._storage = oParam.storage;
            this._recipeUi = this.modCommon.createRecipesObject("recipesCheckcraft", this.ctr_recipes, this.ctr_recipes, 0, 0, true, this._storage, 0, int(this.combo_ingredientsTolerance.selectedItem));
            if (!_jobs)
            {
                _jobs = new Vector.<KnownJobWrapper>();
                _jobNames = new Array();
                allSkills = this.dataApi.getSkills();
                alreadySavedJobId = new Array();
                for each (skill in allSkills)
                {
                    if ((((skill.parentJobId > 1) && (skill.craftableItemIds)) && (skill.craftableItemIds.length > 0)))
                    {
                        if (alreadySavedJobId.indexOf(skill.parentJobId) == -1)
                        {
                            alreadySavedJobId.push(skill.parentJobId);
                            kj = this.jobsApi.getKnownJob(skill.parentJobId);
                            if (kj)
                            {
                                _jobs.push(kj);
                                _jobNames.push(kj.name);
                            };
                        };
                    };
                };
                _jobs.fixed = true;
                this.utilApi.sortOnString(_jobNames);
                _jobNames.unshift(this.uiApi.getText("ui.craft.allJobs"));
            };
            this.combo_job.dataProvider = _jobNames;
            this.combo_job.value = this.combo_job.dataProvider[0];
            this.combo_ingredientsTolerance.dataProvider = MISSING_INGREDIENTS_TOLERANCE;
            this.combo_ingredientsTolerance.value = MISSING_INGREDIENTS_TOLERANCE[0];
        }

        public function unload():void
        {
            this._currentJob = null;
            this._storage = null;
            this.uiApi.unloadUi("recipesCheckcraft");
            this.uiApi.hideTooltip();
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            if (target == this.lbl_tolerance)
            {
                text = this.uiApi.getText("ui.craft.missingIngredientsTolerance.tooltip");
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_sortByLvl:
                    this._sortCriteria = SORT_CRITERIA_LEVEL;
                    this.btn_sortByLvl.selected = true;
                    this.btn_sortByPrice.selected = false;
                    this._recipeUi.uiClass.switchSort(this._sortCriteria);
                    break;
                case this.btn_sortByPrice:
                    this._sortCriteria = SORT_CRITERIA_PRICE;
                    this.btn_sortByLvl.selected = false;
                    this.btn_sortByPrice.selected = true;
                    this._recipeUi.uiClass.switchSort(this._sortCriteria);
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var oldJob:KnownJobWrapper;
            var i:int;
            var jName:String;
            var sItem:*;
            if (!isNewSelection)
            {
                return;
            };
            switch (target)
            {
                case this.combo_job:
                    oldJob = this._currentJob;
                    if (this.combo_job.selectedIndex > 0)
                    {
                        this._currentJob = null;
                        i = 0;
                        while (i < _jobs.length)
                        {
                            jName = _jobs[i].name;
                            sItem = this.combo_job.selectedItem;
                            if (jName == sItem)
                            {
                                this._currentJob = _jobs[i];
                                break;
                            };
                            i++;
                        };
                    }
                    else
                    {
                        this._currentJob = null;
                    };
                    if (oldJob != this._currentJob)
                    {
                        if (this._currentJob)
                        {
                            this.sysApi.dispatchHook(JobSelected, this._currentJob.id, 0, "recipesCheckcraft");
                        }
                        else
                        {
                            this.sysApi.dispatchHook(JobSelected, 0, 0, "recipesCheckcraft");
                        };
                    };
                    break;
                case this.combo_ingredientsTolerance:
                    this._recipeUi.uiClass.ingredientsToleranceFilter = int(this.combo_ingredientsTolerance.selectedItem);
                    break;
            };
        }

        public function get storage():String
        {
            return (this._storage);
        }

        private function onRecipesListRefreshed(recipesCount:int):void
        {
            if (recipesCount < 2)
            {
                this.lbl_totalRecipes.text = this.uiApi.getText("ui.craft.oneRecipeFound", recipesCount);
            }
            else
            {
                this.lbl_totalRecipes.text = this.uiApi.getText("ui.craft.recipesFound", recipesCount);
            };
        }


    }
}

