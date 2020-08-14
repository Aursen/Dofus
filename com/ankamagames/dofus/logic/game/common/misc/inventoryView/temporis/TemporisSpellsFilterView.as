package com.ankamagames.dofus.logic.game.common.misc.inventoryView.temporis
{
    import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageGenericView;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.common.misc.IStorageView;
    import com.ankamagames.dofus.logic.game.common.misc.HookLock;
    import com.ankamagames.dofus.datacenter.items.Item;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
    import com.ankamagames.dofus.misc.lists.InventoryHookList;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.datacenter.temporis.ForgettableSpell;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;

    public class TemporisSpellsFilterView extends StorageGenericView 
    {

        private var _allowedTypes:Vector.<uint>;
        private var _parent:IStorageView;
        private var _isHideLearnedSpells:Boolean = false;

        public function TemporisSpellsFilterView(hookLock:HookLock, parentView:IStorageView, allowedTypes:Vector.<uint>, isHideLearnedSpells:Boolean)
        {
            super(hookLock);
            this._allowedTypes = allowedTypes;
            this._parent = parentView;
            this._isHideLearnedSpells = isHideLearnedSpells;
        }

        override public function get name():String
        {
            return ("temporisSpellsFilter");
        }

        override public function isListening(item:ItemWrapper):Boolean
        {
            if (this._parent === null)
            {
                return (false);
            };
            var data:Item = Item.getItemById(item.objectGID);
            var isItemRelevant:Boolean = (((this._parent.isListening(item)) && (super.isListening(item))) && (!(this._allowedTypes.indexOf(data.typeId) === -1)));
            return (isItemRelevant);
        }

        override public function addItem(item:ItemWrapper, invisible:int, needUpdateView:Boolean=true):void
        {
            if (((!(item === null)) && (this.isItemFiltered(item.id))))
            {
                return;
            };
            super.addItem(item, invisible, needUpdateView);
        }

        override public function modifyItem(item:ItemWrapper, oldItem:ItemWrapper, invisible:int):void
        {
            if (((!(item === null)) && (this.isItemFiltered(item.id))))
            {
                return;
            };
            super.modifyItem(item, oldItem, invisible);
        }

        override public function updateView():void
        {
            super.updateView();
            if (StorageOptionManager.getInstance().currentStorageView === this)
            {
                _hookLock.addHook(InventoryHookList.StorageViewContent, [content, InventoryManager.getInstance().inventory.localKamas]);
            };
        }

        public function set parent(view:IStorageView):void
        {
            this._parent = view;
        }

        public function get parent():IStorageView
        {
            return (this._parent);
        }

        private function isItemFiltered(scrollId:int):Boolean
        {
            var playerForgettableSpells:Dictionary;
            if (!this._isHideLearnedSpells)
            {
                return (false);
            };
            var forgettableSpell:ForgettableSpell = ForgettableSpell.getForgettableSpellByScrollId(scrollId);
            if (forgettableSpell !== null)
            {
                playerForgettableSpells = PlayedCharacterManager.getInstance().playerTemporisSpellDictionary;
                if ((forgettableSpell.id in playerForgettableSpells))
                {
                    return (true);
                };
            };
            return (false);
        }


    }
} com.ankamagames.dofus.logic.game.common.misc.inventoryView.temporis

