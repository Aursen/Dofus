package com.ankamagames.dofus.datacenter.items
{
    import com.ankamagames.jerakine.data.IPostInit;
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.internalDatacenter.DataEnum;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.types.IdAccessors;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.GameDataFileAccessor;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkMapPosition;
    import com.ankamagames.dofus.datacenter.appearance.Appearance;
    import com.ankamagames.dofus.datacenter.jobs.Recipe;
    import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
    import com.ankamagames.jerakine.data.CensoredContentManager;
    import __AS3__.vec.*;

    public class Item implements IPostInit, IDataCenter 
    {

        public static const MODULE:String = "Items";
        private static const SUPERTYPE_NOT_EQUIPABLE:Array = [DataEnum.ITEM_SUPERTYPE_RESOURCES, DataEnum.ITEM_SUPERTYPE_QUEST_ITEMS, DataEnum.ITEM_SUPERTYPE_MUTATIONS, DataEnum.ITEM_SUPERTYPE_FOODS, DataEnum.ITEM_SUPERTYPE_BLESSINGS, DataEnum.ITEM_SUPERTYPE_CURSES, DataEnum.ITEM_SUPERTYPE_CONSUMABLE, DataEnum.ITEM_SUPERTYPE_ROLEPLAY_BUFFS, DataEnum.ITEM_SUPERTYPE_FOLLOWERS, DataEnum.ITEM_SUPERTYPE_MOUNTS, DataEnum.ITEM_SUPERTYPE_CATCHING_ITEMS, DataEnum.ITEM_SUPERTYPE_LIVING_ITEMS];
        public static const MAX_JOB_LEVEL_GAP:int = 100;
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Item));
        private static var _censoredIcons:Dictionary;
        public static var idAccessors:IdAccessors = new IdAccessors(getItemById, getItems);

        public var id:int;
        public var nameId:uint;
        public var typeId:uint;
        public var descriptionId:uint;
        public var iconId:uint;
        public var level:uint;
        public var realWeight:uint;
        public var cursed:Boolean;
        public var useAnimationId:int;
        public var usable:Boolean;
        public var targetable:Boolean;
        public var exchangeable:Boolean;
        public var price:Number;
        public var twoHanded:Boolean;
        public var etheral:Boolean;
        public var itemSetId:int;
        public var criteria:String;
        public var criteriaTarget:String;
        public var hideEffects:Boolean;
        public var enhanceable:Boolean;
        public var nonUsableOnAnother:Boolean;
        public var appearanceId:uint;
        public var secretRecipe:Boolean;
        public var dropMonsterIds:Vector.<uint>;
        public var dropTemporisMonsterIds:Vector.<uint>;
        public var recipeSlots:uint;
        public var recipeIds:Vector.<uint>;
        public var objectIsDisplayOnWeb:Boolean;
        public var bonusIsSecret:Boolean;
        public var possibleEffects:Vector.<EffectInstance>;
        public var evolutiveEffectIds:Vector.<uint>;
        public var favoriteSubAreas:Vector.<uint>;
        public var favoriteSubAreasBonus:uint;
        public var craftXpRatio:int;
        public var craftVisible:String;
        public var craftFeasible:String;
        public var needUseConfirm:Boolean;
        public var isDestructible:Boolean;
        public var isSaleable:Boolean;
        public var nuggetsBySubarea:Vector.<Vector.<Number>>;
        public var containerIds:Vector.<uint>;
        public var resourcesBySubarea:Vector.<Vector.<int>>;
        public var visibility:String;
        public var importantNoticeId:uint;
        public var changeVersion:String;
        public var tooltipExpirationDate:Number = NaN;
        private var _name:String;
        private var _undiatricalName:String;
        private var _description:String;
        private var _type:ItemType;
        private var _weight:uint;
        private var _itemSet:ItemSet;
        private var _appearance:TiphonEntityLook;
        private var _conditions:GroupItemCriterion;
        private var _conditionsTarget:GroupItemCriterion;
        private var _craftVisibleConditions:GroupItemCriterion;
        private var _craftFeasibleConditions:GroupItemCriterion;
        private var _recipes:Array;
        private var _craftXpByJobLevel:Dictionary;
        private var _nuggetsQuantity:Number = 0;
        private var _basicExperienceAsFood:Number = 0;
        private var _importantNotice:String = null;
        private var _processedImportantNotice:String = null;


        public static function getItemById(id:uint, returnDefaultItemIfNull:Boolean=true):Item
        {
            var item:Item = (GameData.getObject(MODULE, id) as Item);
            if (((item) || (!(returnDefaultItemIfNull))))
            {
                return (item);
            };
            _log.error((("Impossible de trouver l'objet " + id) + ", remplacement par l'objet 666"));
            return (GameData.getObject(MODULE, 666) as Item);
        }

        public static function getItems():Array
        {
            return (GameData.getObjects(MODULE));
        }

        public static function getItemsByIds(ids:Vector.<uint>):Vector.<Item>
        {
            var id:*;
            var item:*;
            var items:Vector.<Item> = new Vector.<Item>();
            for each (id in ids)
            {
                item = GameDataFileAccessor.getInstance().getObject(MODULE, id);
                if (item)
                {
                    items.push(item);
                };
            };
            return (items);
        }


        public function get name():String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            };
            return (this._name);
        }

        public function get undiatricalName():String
        {
            if (!this._undiatricalName)
            {
                this._undiatricalName = I18n.getUnDiacriticalText(this.nameId);
            };
            return (this._undiatricalName);
        }

        public function get description():String
        {
            if (!this._description)
            {
                if (this.etheral)
                {
                    this._description = I18n.getUiText("ui.common.etherealWeaponDescription");
                }
                else
                {
                    this._description = I18n.getText(this.descriptionId);
                };
            };
            return (this._description);
        }

        public function get importantNotice():String
        {
            if (!this._importantNotice)
            {
                this._importantNotice = I18n.getText(this.importantNoticeId);
            };
            return (this._importantNotice);
        }

        public function get processedImportantNotice():String
        {
            if (this._processedImportantNotice !== null)
            {
                return (this._processedImportantNotice);
            };
            if (!this.importantNotice)
            {
                return (null);
            };
            this._processedImportantNotice = HyperlinkMapPosition.parseMapLinks(this.importantNotice);
            return (this._processedImportantNotice);
        }

        public function get weight():uint
        {
            return (this._weight);
        }

        public function set weight(n:uint):void
        {
            this._weight = n;
        }

        public function get type():Object
        {
            if (!this._type)
            {
                this._type = ItemType.getItemTypeById(this.typeId);
            };
            return (this._type);
        }

        public function get isWeapon():Boolean
        {
            return (false);
        }

        public function get itemSet():ItemSet
        {
            if (!this._itemSet)
            {
                this._itemSet = ItemSet.getItemSetById(this.itemSetId);
            };
            return (this._itemSet);
        }

        public function get appearance():TiphonEntityLook
        {
            var appearance:Appearance;
            if (!this._appearance)
            {
                appearance = Appearance.getAppearanceById(this.appearanceId);
                if (appearance)
                {
                    this._appearance = TiphonEntityLook.fromString(appearance.data);
                };
            };
            return (this._appearance);
        }

        public function get recipes():Array
        {
            var numRecipes:int;
            var i:int;
            var recipe:Recipe;
            if (!this._recipes)
            {
                numRecipes = this.recipeIds.length;
                this._recipes = new Array();
                i = 0;
                while (i < numRecipes)
                {
                    recipe = Recipe.getRecipeByResultId(this.recipeIds[i]);
                    if (recipe)
                    {
                        this._recipes.push(recipe);
                    };
                    i++;
                };
            };
            return (this._recipes);
        }

        public function get category():uint
        {
            if (((this.typeId == 0) || (!(this.type))))
            {
                return (ItemCategoryEnum.OTHER_CATEGORY);
            };
            return (this.type.categoryId);
        }

        public function get conditions():GroupItemCriterion
        {
            if (!this.criteria)
            {
                return (null);
            };
            if (!this._conditions)
            {
                this._conditions = new GroupItemCriterion(this.criteria);
            };
            return (this._conditions);
        }

        public function get targetConditions():GroupItemCriterion
        {
            if (!this.criteriaTarget)
            {
                return (null);
            };
            if (!this._conditionsTarget)
            {
                this._conditionsTarget = new GroupItemCriterion(this.criteriaTarget);
            };
            return (this._conditionsTarget);
        }

        public function get craftVisibleConditions():GroupItemCriterion
        {
            if (!this.craftVisible)
            {
                return (null);
            };
            if (!this._craftVisibleConditions)
            {
                this._craftVisibleConditions = new GroupItemCriterion(this.craftVisible);
            };
            return (this._craftVisibleConditions);
        }

        public function get craftFeasibleConditions():GroupItemCriterion
        {
            if (!this.craftFeasible)
            {
                return (null);
            };
            if (!this._craftFeasibleConditions)
            {
                this._craftFeasibleConditions = new GroupItemCriterion(this.craftFeasible);
            };
            return (this._craftFeasibleConditions);
        }

        public function getCraftXpByJobLevel(jobLevel:int):int
        {
            var xp:int;
            var xpWithRatio:Number;
            var basicXp:Number;
            if (!this._craftXpByJobLevel)
            {
                this._craftXpByJobLevel = new Dictionary();
            };
            if (!this._craftXpByJobLevel[jobLevel])
            {
                if ((jobLevel - MAX_JOB_LEVEL_GAP) > this.level)
                {
                    this._craftXpByJobLevel[jobLevel] = 0;
                    return (this._craftXpByJobLevel[jobLevel]);
                };
                basicXp = ((20 * this.level) / ((Math.pow((jobLevel - this.level), 1.1) / 10) + 1));
                if (this.craftXpRatio > -1)
                {
                    xpWithRatio = (basicXp * (this.craftXpRatio / 100));
                }
                else
                {
                    if (this.type.craftXpRatio > -1)
                    {
                        xpWithRatio = (basicXp * (this.type.craftXpRatio / 100));
                    }
                    else
                    {
                        xpWithRatio = basicXp;
                    };
                };
                this._craftXpByJobLevel[jobLevel] = Math.floor(xpWithRatio);
            };
            return (this._craftXpByJobLevel[jobLevel]);
        }

        public function get nuggetsQuantity():Number
        {
            var nuggets:Vector.<Number>;
            if (this._nuggetsQuantity == 0)
            {
                for each (nuggets in this.nuggetsBySubarea)
                {
                    this._nuggetsQuantity = (this._nuggetsQuantity + nuggets[1]);
                };
            };
            return (this._nuggetsQuantity);
        }

        public function get basicExperienceAsFood():Number
        {
            var experienceInt:int;
            if (this._basicExperienceAsFood == 0)
            {
                this._basicExperienceAsFood = (this.nuggetsQuantity / this.nuggetsBySubarea.length);
                experienceInt = Math.floor((this._basicExperienceAsFood * 100000));
                this._basicExperienceAsFood = (experienceInt / 100000);
            };
            return (this._basicExperienceAsFood);
        }

        public function copy(from:Item, _arg_2:Item):void
        {
            _arg_2.id = from.id;
            _arg_2.nameId = from.nameId;
            _arg_2.typeId = from.typeId;
            _arg_2.descriptionId = from.descriptionId;
            _arg_2.iconId = from.iconId;
            _arg_2.level = from.level;
            _arg_2.realWeight = from.realWeight;
            _arg_2.weight = from.weight;
            _arg_2.cursed = from.cursed;
            _arg_2.useAnimationId = from.useAnimationId;
            _arg_2.usable = from.usable;
            _arg_2.targetable = from.targetable;
            _arg_2.price = from.price;
            _arg_2.twoHanded = from.twoHanded;
            _arg_2.etheral = from.etheral;
            _arg_2.enhanceable = from.enhanceable;
            _arg_2.nonUsableOnAnother = from.nonUsableOnAnother;
            _arg_2.itemSetId = from.itemSetId;
            _arg_2.criteria = from.criteria;
            _arg_2.criteriaTarget = from.criteriaTarget;
            _arg_2.hideEffects = from.hideEffects;
            _arg_2.appearanceId = from.appearanceId;
            _arg_2.recipeIds = from.recipeIds;
            _arg_2.recipeSlots = from.recipeSlots;
            _arg_2.secretRecipe = from.secretRecipe;
            _arg_2.bonusIsSecret = from.bonusIsSecret;
            _arg_2.objectIsDisplayOnWeb = from.objectIsDisplayOnWeb;
            _arg_2.possibleEffects = from.possibleEffects;
            _arg_2.evolutiveEffectIds = from.evolutiveEffectIds;
            _arg_2.favoriteSubAreas = from.favoriteSubAreas;
            _arg_2.favoriteSubAreasBonus = from.favoriteSubAreasBonus;
            _arg_2.dropMonsterIds = from.dropMonsterIds;
            _arg_2.dropTemporisMonsterIds = from.dropTemporisMonsterIds;
            _arg_2.resourcesBySubarea = from.resourcesBySubarea;
            _arg_2.exchangeable = from.exchangeable;
            _arg_2.craftXpRatio = from.craftXpRatio;
            _arg_2.needUseConfirm = from.needUseConfirm;
            _arg_2.isDestructible = from.isDestructible;
            _arg_2.isSaleable = from.isSaleable;
            _arg_2.craftVisible = from.craftVisible;
            _arg_2.craftFeasible = from.craftFeasible;
            _arg_2.nuggetsBySubarea = from.nuggetsBySubarea;
            _arg_2.containerIds = from.containerIds;
            _arg_2.visibility = from.visibility;
            _arg_2.importantNoticeId = from.importantNoticeId;
            _arg_2.changeVersion = from.changeVersion;
            _arg_2.tooltipExpirationDate = from.tooltipExpirationDate;
        }

        public function postInit():void
        {
            if (!_censoredIcons)
            {
                _censoredIcons = CensoredContentManager.getInstance().getCensoredIndex(1);
            };
            if (_censoredIcons[this.iconId])
            {
                this.iconId = _censoredIcons[this.iconId];
            };
            this.name;
            this.undiatricalName;
        }

        public function isEvolutive():Boolean
        {
            return ((this.evolutiveEffectIds) && (this.evolutiveEffectIds.length > 0));
        }

        public function get visible():Boolean
        {
            if (!this.visibility)
            {
                return (true);
            };
            var gic:GroupItemCriterion = new GroupItemCriterion(this.visibility);
            return (gic.isRespected);
        }


    }
}

