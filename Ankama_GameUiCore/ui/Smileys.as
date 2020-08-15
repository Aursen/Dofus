package Ankama_GameUiCore.ui
{
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.dofus.uiApi.RoleplayApi;
    import com.ankamagames.dofus.uiApi.ChatApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.TimeApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.dofus.datacenter.communication.SmileyCategory;
    import d2hooks.EmoteListUpdated;
    import d2hooks.MoodResult;
    import d2hooks.SmileysStart;
    import d2hooks.SmileyListUpdated;
    import d2hooks.EmoteEnabledListUpdated;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
    import flash.events.TimerEvent;
    import com.ankamagames.dofusModuleLibrary.enum.UIEnum;
    import d2hooks.ShortcutsMovementAllowed;
    import Ankama_GameUiCore.ui.enums.ContextEnum;
    import flash.geom.Rectangle;
    import com.ankamagames.dofus.internalDatacenter.communication.SmileyWrapper;
    import d2hooks.OpenSmileys;
    import com.ankamagames.berilia.components.Slot;
    import d2actions.ChatSmileyRequest;
    import d2actions.EmotePlayRequest;
    import d2actions.MoodSmileyRequest;
    import d2hooks.TextInformation;
    import d2hooks.*;
    import d2actions.*;

    public class Smileys extends ContextAwareUi 
    {

        public var output:Object;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Api(name="RoleplayApi")]
        public var rpApi:RoleplayApi;
        [Api(name="ChatApi")]
        public var chatApi:ChatApi;
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="TimeApi")]
        public var timeApi:TimeApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        private var _currentMood:int = 0;
        private var _currentSmileyCategory:int = 0;
        private var _selectedTxList:Array = new Array();
        private var _completeSmileyList:Array = new Array();
        private var _slotByEmoteId:Dictionary = new Dictionary();
        private var _usableEmotes:Object = new Object();
        private var _playSmileAllowed:Boolean = true;
        private var _playSmileAllowedTimer:Timer;
        private var _shortcutColor:String;
        private var _gridComponentsList:Dictionary = new Dictionary(true);
        private var _btnHappy:ButtonContainer;
        private var _bgLastWidth:Number;
        private var _bgLastHeight:Number;
        public var mainCtr:GraphicContainer;
        public var ctr_bg:GraphicContainer;
        public var ctr_category:GraphicContainer;
        public var ctr_grid:GraphicContainer;
        public var gd_smileys:Grid;
        public var gd_smileyCategories:Grid;
        public var gd_emotes:Grid;
        public var btn_close:ButtonContainer;
        public var tx_title:TextureBitmap;
        public var lbl_title:Label;
        public var tx_catbg:TextureBitmap;


        override public function main(args:Array):void
        {
            var lastOpenedCategory:int;
            var smileyCats:Object;
            var smileyCatsOrdered:Array;
            var smileyCat:SmileyCategory;
            super.main(args);
            sysApi.addHook(EmoteListUpdated, this.onEmoteListUpdated);
            sysApi.addHook(MoodResult, this.onMoodResult);
            sysApi.addHook(SmileysStart, this.onSmileysStart);
            sysApi.addHook(SmileyListUpdated, this.onSmileyListUpdated);
            sysApi.addHook(EmoteEnabledListUpdated, this.onEmoteEnabledListUpdated);
            this.uiApi.addComponentHook(this.gd_smileyCategories, ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addComponentHook(this.gd_smileyCategories, ComponentHookList.ON_ITEM_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_close, ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortcut);
            this._playSmileAllowed = true;
            this._playSmileAllowedTimer = new Timer(1000, 1);
            this._playSmileAllowedTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onPlaySmileAllowedTimer);
            if (!this.uiApi.getUi(UIEnum.STORAGE_UI))
            {
                sysApi.dispatchHook(ShortcutsMovementAllowed, true);
            };
            if ((((args) && (args.length > 0)) && (args[0] >= 0)))
            {
                this._currentSmileyCategory = args[0];
                lastOpenedCategory = sysApi.getData("smileyLastCategoryOpened");
                if (this._currentSmileyCategory != lastOpenedCategory)
                {
                    sysApi.setData("smileyLastCategoryOpened", this._currentSmileyCategory);
                };
            }
            else
            {
                this._currentSmileyCategory = sysApi.getData("smileyLastCategoryOpened");
            };
            if (this.gd_smileyCategories.dataProvider.length == 0)
            {
                smileyCats = this.dataApi.getAllSmileyCategory();
                smileyCatsOrdered = new Array();
                for each (smileyCat in smileyCats)
                {
                    smileyCatsOrdered.push(smileyCat);
                };
                smileyCatsOrdered.sortOn("order", Array.NUMERIC);
                this.gd_smileyCategories.dataProvider = smileyCatsOrdered;
            };
            var i:int;
            while (i < this.gd_smileyCategories.dataProvider.length)
            {
                if (this._currentSmileyCategory == this.gd_smileyCategories.dataProvider[i].id)
                {
                    this.gd_smileyCategories.selectedIndex = i;
                    break;
                };
                i++;
            };
            this.createSmileyListWithPacks();
            this.displayCurrentType();
            var initialContext:String = ((this.playerApi.isInFight()) ? ContextEnum.FIGHT : ContextEnum.ROLEPLAY);
            changeContext(initialContext);
            this._bgLastWidth = this.ctr_bg.width;
            this._bgLastHeight = this.ctr_bg.height;
            this.ctr_bg.getResizeController().topResize = false;
            this.tx_title.getResizeController().bottomResize = false;
        }

        public function unload():void
        {
            if (((!(this.uiApi.getUi(UIEnum.STORAGE_UI))) && (!(this.uiApi.isResetting()))))
            {
                sysApi.dispatchHook(ShortcutsMovementAllowed, false);
            };
            this._playSmileAllowedTimer.stop();
            this._playSmileAllowedTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onPlaySmileAllowedTimer);
            this.uiApi.hideTooltip();
        }

        override protected function onContextChanged(context:String, previousContext:String="", contextChanged:Boolean=false):void
        {
            if (context != ContextEnum.ROLEPLAY)
            {
                if (this._currentSmileyCategory == 0)
                {
                    if (this._btnHappy)
                    {
                        this.onRelease(this._btnHappy);
                    };
                    this.gd_smileyCategories.selectedIndex = 1;
                };
            };
            this.gd_smileyCategories.updateItem(0);
        }

        public function updateSmiley(data:*, componentsRef:*, selected:Boolean):void
        {
            componentsRef.slot_smiley.dropValidator = this.dropValidatorFunction;
            if (data)
            {
                this._selectedTxList[data.id] = componentsRef.tx_bgSmiley;
                componentsRef.slot_smiley.data = data;
                if (data.id == this._currentMood)
                {
                    componentsRef.tx_bgSmiley.visible = true;
                }
                else
                {
                    componentsRef.tx_bgSmiley.visible = false;
                };
                componentsRef.slot_smiley.allowDrag = true;
            }
            else
            {
                componentsRef.slot_smiley.data = null;
                componentsRef.tx_bgSmiley.visible = false;
            };
        }

        public function updateSmileyCategory(data:*, componentsRef:*, selected:Boolean):void
        {
            if (data)
            {
                this._gridComponentsList[componentsRef.btn_cat.name] = data;
                componentsRef.iconTexturebtn_cat.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("icon") + data.gfxId) + ".png"));
                componentsRef.btn_cat.selected = selected;
                if (data.order == 2)
                {
                    this._btnHappy = componentsRef.btn_cat;
                }
                else
                {
                    if (data.order == 1)
                    {
                        componentsRef.btn_cat.softDisabled = (!(currentContext == ContextEnum.ROLEPLAY));
                    };
                };
                componentsRef.btn_cat.visible = true;
            }
            else
            {
                componentsRef.btn_cat.visible = false;
            };
        }

        public function updateEmote(data:*, componentsRef:*, selected:Boolean):void
        {
            componentsRef.slot_emote.dropValidator = this.dropValidatorFunction;
            if (data)
            {
                componentsRef.slot_emote.data = data;
                this._slotByEmoteId[data.id] = componentsRef.slot_emote;
                componentsRef.slot_emote.allowDrag = true;
                if (this._usableEmotes.indexOf(data.id) == -1)
                {
                    componentsRef.btn_emote.softDisabled = true;
                }
                else
                {
                    componentsRef.btn_emote.softDisabled = false;
                };
            }
            else
            {
                componentsRef.slot_emote.data = null;
            };
        }

        private function resizeText(lbl:Label, width:Number):void
        {
            lbl.removeTooltipExtension();
            lbl.finalized = false;
            lbl.width = width;
            if (lbl.textfield.textWidth > (lbl.width + 1))
            {
                lbl.addTooltipExtension();
            };
            lbl.finalized = true;
        }

        public function renderUpdate():void
        {
            this.tx_title.x = this.ctr_bg.x;
            this.tx_title.y = (this.ctr_bg.y - 29);
            this.tx_title.width = (this.ctr_bg.width + 1);
            this.lbl_title.x = (this.tx_title.x + 6);
            this.lbl_title.y = (this.tx_title.y + 6);
            this.resizeText(this.lbl_title, (this.ctr_bg.width - 28));
            this.btn_close.x = (this.lbl_title.x + this.lbl_title.width);
            this.btn_close.y = (this.tx_title.y + 7);
            this.ctr_category.x = this.tx_title.x;
            this.ctr_category.y = (this.tx_title.y + 31);
            this.ctr_category.height = (this.ctr_bg.height - 6);
            this.tx_catbg.height = this.ctr_category.height;
            this.ctr_grid.x = (this.ctr_category.x + 39);
            this.ctr_grid.y = this.ctr_category.y;
        }

        public function restrictPosition():void
        {
            var visibleBounds:Rectangle = this.uiApi.getVisibleStageBounds();
            var x:Number = (this.mainCtr.x + this.ctr_bg.x);
            if ((x + this.ctr_bg.width) > visibleBounds.right)
            {
                this.mainCtr.x = (visibleBounds.right - (this.ctr_bg.x + this.ctr_bg.width));
            };
            if (x < visibleBounds.left)
            {
                this.mainCtr.x = (visibleBounds.left - this.ctr_bg.x);
            };
            var y:Number = ((this.mainCtr.y + this.ctr_bg.y) - 29);
            if (y < visibleBounds.top)
            {
                this.mainCtr.y = -(this.ctr_bg.y - 29);
            };
            if (((y + this.ctr_bg.height) + 29) > visibleBounds.bottom)
            {
                this.mainCtr.y = (visibleBounds.bottom - Math.min((this.ctr_bg.height + this.ctr_bg.y), visibleBounds.bottom));
            };
        }

        private function createSmileyListWithPacks():void
        {
            var oldSw:SmileyWrapper;
            var sw:SmileyWrapper;
            var indexInTheLine:int;
            var i:int;
            this._completeSmileyList = new Array();
            var allSmileys:Object = this.dataApi.getSmileyWrappers();
            var cols:int = int(Math.floor(((this.gd_smileys.width - 20) / this.gd_smileys.slotWidth)));
            var counter:int;
            var rest:int;
            for each (sw in allSmileys)
            {
                counter++;
                if (((oldSw) && (!(sw.packId == oldSw.packId))))
                {
                    indexInTheLine = ((counter - 1) % cols);
                    if (indexInTheLine > 0)
                    {
                        rest = (cols - indexInTheLine);
                        i = 0;
                        while (i < rest)
                        {
                            this._completeSmileyList.push(0);
                            counter++;
                            i++;
                        };
                    };
                };
                this._completeSmileyList.push(sw);
                oldSw = sw;
            };
        }

        private function displayCurrentType():void
        {
            var sw:Object;
            var favSmileyIds:*;
            var favSmileyWrappers:Array;
            var id:int;
            var categorySmileyList:Array;
            sysApi.dispatchHook(OpenSmileys);
            if (this._currentSmileyCategory == 0)
            {
                this._usableEmotes = this.rpApi.getUsableEmotesList();
                this.gd_emotes.dataProvider = this.rpApi.getEmotesList();
                this.updateGridSize(this.gd_emotes);
                this.gd_emotes.visible = true;
                this.gd_smileys.visible = false;
            }
            else
            {
                this._selectedTxList = new Array();
                if (this._currentSmileyCategory == -1)
                {
                    favSmileyIds = sysApi.getOption("favoriteSmileys", "chat");
                    favSmileyWrappers = new Array();
                    for each (id in favSmileyIds)
                    {
                        for each (sw in this._completeSmileyList)
                        {
                            if (((sw) && (sw.id == id)))
                            {
                                favSmileyWrappers.push(sw);
                            };
                        };
                    };
                    this.gd_smileys.dataProvider = favSmileyWrappers;
                }
                else
                {
                    categorySmileyList = new Array();
                    for each (sw in this._completeSmileyList)
                    {
                        if (((sw) && (sw.categoryId == this._currentSmileyCategory)))
                        {
                            categorySmileyList.push(sw);
                        };
                    };
                    this.gd_smileys.dataProvider = categorySmileyList;
                };
                this.updateGridSize(this.gd_smileys);
                this.gd_smileys.visible = true;
                this.gd_emotes.visible = false;
                this._currentMood = this.chatApi.getSmileyMood();
                if (((!(this._currentMood == 0)) && (this._selectedTxList[this._currentMood])))
                {
                    this._selectedTxList[this._currentMood].visible = true;
                };
            };
        }

        private function updateGridSize(pGrid:Grid):void
        {
            var gridWidth:Number = (this.ctr_bg.width - 47);
            var gridHeight:Number = (this.ctr_bg.height - 11);
            pGrid.finalized = false;
            pGrid.width = gridWidth;
            pGrid.height = gridHeight;
            pGrid.dataProvider = pGrid.dataProvider;
        }

        public function onPress(target:Object):void
        {
            sysApi.addEventListener(this.onEnterFrame, "smileysOnEnterFrame");
        }

        private function onEnterFrame():void
        {
            var resized:Boolean;
            var currentGrid:Grid = ((this._currentSmileyCategory == 0) ? this.gd_emotes : this.gd_smileys);
            currentGrid.visible = ((this.ctr_bg.width == this._bgLastWidth) && (this.ctr_bg.height == this._bgLastHeight));
            if (!this.uiApi.getMouseDown())
            {
                resized = ((!(this.ctr_bg.width == this._bgLastWidth)) || (!(this.ctr_bg.height == this._bgLastHeight)));
                if (resized)
                {
                    this.updateGridSize(currentGrid);
                };
                currentGrid.visible = true;
                this._bgLastWidth = this.ctr_bg.width;
                this._bgLastHeight = this.ctr_bg.height;
                sysApi.removeEventListener(this.onEnterFrame);
            };
        }

        public function onShortcut(shortcut:String):Boolean
        {
            if (shortcut == ShortcutHookListEnum.CLOSE_UI)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                return (true);
            };
            return (false);
        }

        public function onRelease(target:Object):void
        {
            var smileyCat:SmileyCategory;
            if (target.name.indexOf("btn_cat") != -1)
            {
                smileyCat = this._gridComponentsList[target.name];
                this._currentSmileyCategory = smileyCat.id;
                sysApi.setData("smileyLastCategoryOpened", this._currentSmileyCategory);
                this.displayCurrentType();
            }
            else
            {
                if (target == this.btn_close)
                {
                    this.uiApi.unloadUi(this.uiApi.me().name);
                };
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var smileyItem:Object;
            var emoteItem:Object;
            var slot:Slot;
            switch (target)
            {
                case this.gd_smileys:
                    if (selectMethod != 7)
                    {
                        smileyItem = target.selectedItem;
                        if (((smileyItem) && (this._playSmileAllowed)))
                        {
                            sysApi.sendAction(new ChatSmileyRequest(smileyItem.id));
                            this._playSmileAllowed = false;
                            this._playSmileAllowedTimer.start();
                        };
                        if (sysApi.getOption("smileysAutoclosed", "chat"))
                        {
                            this.uiApi.unloadUi(this.uiApi.me().name);
                        };
                    };
                    break;
                case this.gd_emotes:
                    if (selectMethod != 7)
                    {
                        emoteItem = target.selectedItem;
                        if (((emoteItem) && (this._playSmileAllowed)))
                        {
                            slot = (this._slotByEmoteId[emoteItem.id] as Slot);
                            if (slot != null)
                            {
                                sysApi.sendAction(new EmotePlayRequest(emoteItem.id));
                                this._playSmileAllowed = false;
                                this._playSmileAllowedTimer.start();
                            };
                        };
                        if (sysApi.getOption("smileysAutoclosed", "chat"))
                        {
                            this.uiApi.unloadUi(this.uiApi.me().name);
                        };
                    };
                    break;
            };
        }

        public function onPlaySmileAllowedTimer(e:TimerEvent):void
        {
            this._playSmileAllowed = true;
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var data:Object;
            var ref:Object;
            var txt:String;
            if (target == this.gd_emotes)
            {
                ref = item.container;
                if (item.data)
                {
                    if (!this._shortcutColor)
                    {
                        this._shortcutColor = sysApi.getConfigEntry("colors.shortcut");
                        this._shortcutColor = this._shortcutColor.replace("0x", "#");
                    };
                    txt = (((((item.data.name + " <font color='") + this._shortcutColor) + "'>(/") + item.data.shortcut) + ")</font>");
                    if (this._usableEmotes.indexOf(item.data.id) == -1)
                    {
                        txt = (txt + ("\n" + ((item.data.id == 102) ? this.uiApi.getText("ui.smiley.emoteGhostOnly") : this.uiApi.getText("ui.smiley.emoteDisabled"))));
                    };
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt), ref, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
                };
            }
            else
            {
                if (target == this.gd_smileys)
                {
                    ref = item.container;
                    if (((item.data) && (item.data.id == this._currentMood)))
                    {
                        txt = this.uiApi.getText("ui.smiley.mood");
                        this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt), ref, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
                    };
                }
                else
                {
                    if (target == this.gd_smileyCategories)
                    {
                        ref = item.container;
                        if (((item.data) && (item.data.gfxId)))
                        {
                            txt = this.uiApi.getText(("ui.smiley.tooltip." + item.data.gfxId));
                            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt), ref, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
                        };
                    };
                };
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            if (item.data == null)
            {
                return;
            };
            var data:Object = item.data;
            if (this._currentMood == data.id)
            {
                sysApi.sendAction(new MoodSmileyRequest(0));
            }
            else
            {
                sysApi.sendAction(new MoodSmileyRequest(data.id));
            };
        }

        public function onEmoteListUpdated():void
        {
            this._usableEmotes = this.rpApi.getUsableEmotesList();
            this.gd_emotes.dataProvider = this.rpApi.getEmotesList();
        }

        public function onEmoteEnabledListUpdated(emotesOk:Object):void
        {
            this._usableEmotes = this.rpApi.getUsableEmotesList();
            var vsv:int = this.gd_emotes.verticalScrollValue;
            this.gd_emotes.dataProvider = this.rpApi.getEmotesList();
            this.gd_emotes.verticalScrollValue = vsv;
        }

        public function onMoodResult(resultCode:uint, smileyId:int):void
        {
            if (resultCode == 0)
            {
                if (((!(this._currentMood == 0)) && (this._selectedTxList[this._currentMood])))
                {
                    this._selectedTxList[this._currentMood].visible = false;
                };
                this._currentMood = smileyId;
                if (((!(this._currentMood == 0)) && (this._selectedTxList[this._currentMood])))
                {
                    this._selectedTxList[this._currentMood].visible = true;
                };
            }
            else
            {
                if (resultCode == 1)
                {
                    sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.smiley.errorMood"), 666, this.timeApi.getTimestamp());
                }
                else
                {
                    if (resultCode == 2)
                    {
                        sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.smiley.errorFloodMood"), 666, this.timeApi.getTimestamp());
                    };
                };
            };
        }

        private function onSmileysStart(_arg_1:int, forceOpen:String=""):void
        {
            if (forceOpen == "true")
            {
                if (_arg_1 == 1)
                {
                    this._currentSmileyCategory = 0;
                };
                this.displayCurrentType();
            }
            else
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }

        private function onSmileyListUpdated():void
        {
            this.createSmileyListWithPacks();
            this.displayCurrentType();
        }

        public function dropValidatorFunction(target:Object, iSlotData:Object, source:Object):Boolean
        {
            return (false);
        }

        public function removeDropSourceFunction(target:Object):void
        {
        }

        public function processDropFunction(iSlotDataHolder:Object, data:Object, source:Object):void
        {
            iSlotDataHolder.data = data;
        }

        public function onDoubleClick(target:Object):void
        {
            if (target == this.tx_title)
            {
                this.updateGridSize(((this._currentSmileyCategory == 0) ? this.gd_emotes : this.gd_smileys));
            };
        }


    }
}

