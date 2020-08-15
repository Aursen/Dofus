package Ankama_Fight.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.FightApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.berilia.components.TextureBitmap;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import Ankama_Fight.ui.items.BuffItem;
    import d2hooks.GameFightTurnStart;
    import d2hooks.BuffUpdate;
    import d2hooks.BuffRemove;
    import d2hooks.BuffAdd;
    import d2hooks.UiLoaded;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.dofus.internalDatacenter.spells.EffectsWrapper;
    import d2actions.TimelineEntityOver;
    import com.ankamagames.berilia.types.LocationEnum;
    import flash.ui.Keyboard;
    import d2actions.ChatTextOutput;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import d2actions.TimelineEntityOut;
    import d2hooks.*;

    public class Buffs 
    {

        public static const ORIENTATION_HORIZONTAL:uint = 0;
        public static const ORIENTATION_VERTICAL:uint = 1;
        public static const TIMELINE_ORIENTATION:String = "timelineOrientation";

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="FightApi")]
        public var fightApi:FightApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        private var _buffItems:Dictionary;
        private var _durationSort:Array;
        private var _nPlayerId:Number;
        private var _casterId:Number;
        private var _lastWasPlayer:Boolean = false;
        private var _rollOverTarget:Object = null;
        private var _backgroundWidthModifier:int;
        private var _buffsWithDelay:Array = [];
        private var _currentOrientation:uint = 0;
        private var _timelineUi:UiRootContainer;
        public var tx_background:TextureBitmap;
        public var btn_decoRight:ButtonContainer;
        public var tx_button_minimize:Texture;
        public var tx_button_minimize_bgLeft:TextureBitmap;
        public var buffsCtr:GraphicContainer;
        public var buffListCtr:GraphicContainer;
        public var anchorCtr:GraphicContainer;
        public var expandedCtr:GraphicContainer;


        private static function sortCastingSpellGroup(a:BuffItem, b:BuffItem):int
        {
            return (a.maxCooldown - b.maxCooldown);
        }


        public function main(targetId:Number):void
        {
            this.sysApi.addHook(GameFightTurnStart, this.onGameFightTurnStart);
            this.sysApi.addHook(BuffUpdate, this.onBuffUpdate);
            this.sysApi.addHook(BuffRemove, this.onBuffRemove);
            this.sysApi.addHook(BuffAdd, this.onBuffAdd);
            this.sysApi.addHook(UiLoaded, this.onUiLoaded);
            this.uiApi.addComponentHook(this.btn_decoRight, "onRollOver");
            this.uiApi.addComponentHook(this.btn_decoRight, "onRollOut");
            this.uiApi.addComponentHook(this.tx_button_minimize_bgLeft, "onRollOver");
            this.uiApi.addComponentHook(this.tx_button_minimize_bgLeft, "onRollOut");
            this._backgroundWidthModifier = this.uiApi.me().getConstant("backgroundWidthModifier");
            this._currentOrientation = this.sysApi.getData(TIMELINE_ORIENTATION, DataStoreEnum.BIND_ACCOUNT);
            this._nPlayerId = targetId;
            this._timelineUi = this.uiApi.getUi("timeline");
            this.makeItemBuffs(targetId);
            this.updateUi();
        }

        public function unload():void
        {
        }

        public function set folded(fold:Boolean):void
        {
            if (fold)
            {
                this.buffListCtr.visible = false;
                this.tx_background.visible = false;
                this.tx_button_minimize.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "hud/icon_plus_floating_menu.png"));
            }
            else
            {
                this.buffListCtr.visible = true;
                this.tx_background.visible = true;
                this.tx_button_minimize.uri = this.uiApi.createUri((this.uiApi.me().getConstant("texture") + "hud/icon_minus_floating_menu.png"));
            };
        }

        private function makeItemBuffs(playerId:Number):void
        {
            var buff:Object;
            this._buffItems = new Dictionary();
            this._durationSort = [];
            var buffList:Object = this.fightApi.getBuffList(playerId);
            for each (buff in buffList)
            {
                if (((!(buff.effect)) || (buff.effect.visibleInBuffUi)))
                {
                    this.internalAddBuff(buff);
                };
            };
        }

        private function newBuffItem(buff:Object):BuffItem
        {
            var delay:int = -1;
            if (buff.effect.delay > 0)
            {
                delay = BuffItem.getEndDelayTurn(buff);
            };
            var buffItem:BuffItem = new BuffItem(buff.castingSpell.spell.id, buff.castingSpell.casterId, buff.parentBoostUid, delay, this.uiApi.me().getConstant("spell_size"), this.uiApi.me().getConstant("css_uri"), this.buffListCtr);
            this.uiApi.addComponentHook(buffItem.btn_buff, "onRelease");
            this.uiApi.addComponentHook(buffItem.btn_buff, "onRollOver");
            this.uiApi.addComponentHook(buffItem.btn_buff, "onRollOut");
            buffItem.addBuff(buff);
            return (buffItem);
        }

        private function updateUi():void
        {
            var buffItem:BuffItem;
            var boost:BuffItem;
            var totalWidth:int;
            var posX:int;
            var posY:int;
            var hasBuff:Boolean;
            var cooldownPos:int;
            var i:int;
            var tmpSorted:Array = [];
            var boosts:Array = [];
            for each (buffItem in this._buffItems)
            {
                if (buffItem.parentBoostUid != 0)
                {
                    boosts.push(buffItem);
                }
                else
                {
                    tmpSorted.push(buffItem);
                };
            };
            tmpSorted.sort(sortCastingSpellGroup);
            for each (boost in boosts)
            {
                hasBuff = false;
                cooldownPos = 0;
                i = 0;
                while (i < tmpSorted.length)
                {
                    if (tmpSorted[i].maxCooldown < boost.cooldown)
                    {
                        cooldownPos = i;
                    };
                    if (tmpSorted[i].hasUid(boost.parentBoostUid))
                    {
                        tmpSorted.splice((i + 1), 0, boost);
                        hasBuff = true;
                        break;
                    };
                    i++;
                };
                if (!hasBuff)
                {
                    tmpSorted.splice(cooldownPos, 0, boost);
                };
            };
            totalWidth = ((tmpSorted.length * this.uiApi.me().getConstant("spell_size")) + ((tmpSorted.length - 1) * this.uiApi.me().getConstant("spell_offset_horizontal")));
            if (this._currentOrientation == ORIENTATION_VERTICAL)
            {
                if (totalWidth < 0)
                {
                    totalWidth = 0;
                };
                posX = 0;
                posY = totalWidth;
                for each (buffItem in tmpSorted)
                {
                    posY = (posY - this.uiApi.me().getConstant("spell_size"));
                    buffItem.x = posX;
                    buffItem.y = posY;
                    posY = (posY - this.uiApi.me().getConstant("spell_offset_horizontal"));
                };
                this.tx_background.width = (((totalWidth + (2 * this.uiApi.me().getConstant("spell_offset_horizontal"))) + this.btn_decoRight.height) + this._backgroundWidthModifier);
                this.tx_background.x = this.tx_background.height;
                this.expandedCtr.width = 0;
            }
            else
            {
                if (totalWidth < 0)
                {
                    totalWidth = 0;
                };
                posX = totalWidth;
                posY = 0;
                for each (buffItem in tmpSorted)
                {
                    posX = (posX - this.uiApi.me().getConstant("spell_size"));
                    buffItem.x = posX;
                    buffItem.y = posY;
                    posX = (posX - this.uiApi.me().getConstant("spell_offset_horizontal"));
                };
                this.tx_background.width = (((totalWidth + (2 * this.uiApi.me().getConstant("spell_offset_horizontal"))) + this.btn_decoRight.width) + this._backgroundWidthModifier);
                this.expandedCtr.width = 0;
            };
            this.btn_decoRight.reset();
            this.refreshBuffTooltips();
            if (this._currentOrientation == ORIENTATION_VERTICAL)
            {
                if (((((this._timelineUi) && (this._timelineUi.uiClass)) && (this._timelineUi.uiClass.timelineCtr)) && (this._timelineUi.uiClass.timelineCtr.x < (this.uiApi.getStageWidth() / 2))))
                {
                    this.buffsCtr.x = (this.anchorCtr.x + 140);
                }
                else
                {
                    this.buffsCtr.x = this.anchorCtr.x;
                };
                this.buffsCtr.y = ((this.anchorCtr.y - this.tx_background.width) + 6);
                this.btn_decoRight.y = (this.tx_background.width - 20);
            }
            else
            {
                if (((((this._timelineUi) && (this._timelineUi.uiClass)) && (this._timelineUi.uiClass.timelineCtr)) && (this._timelineUi.uiClass.timelineCtr.y < (this.uiApi.getStageHeight() / 2))))
                {
                    this.buffsCtr.y = 110;
                }
                else
                {
                    this.buffsCtr.y = (this.anchorCtr.y + 6);
                };
                this.buffsCtr.x = ((this.anchorCtr.x - this.tx_background.width) + 6);
                this.btn_decoRight.x = (this.tx_background.width - 20);
            };
            this.uiApi.me().render();
        }

        private function updateBuff(buffId:uint):void
        {
            var key:String;
            var buffItem:BuffItem;
            var delayKey:String;
            var buff:Object = this.fightApi.getBuffById(buffId, this._nPlayerId);
            if (buff)
            {
                if (((buff.hasOwnProperty("isSilent")) && (buff.isSilent)))
                {
                    return;
                };
                if (((buff.effect) && (!(buff.effect.visibleInBuffUi))))
                {
                    return;
                };
                key = BuffItem.getKey(buff);
                buffItem = this._buffItems[key];
                if (!buffItem)
                {
                    delayKey = BuffItem.getKey(buff, true);
                    buffItem = this._buffItems[delayKey];
                    if (!buffItem)
                    {
                        this.sysApi.log(16, ("Failed to update unknown buff with key " + key));
                        return;
                    };
                    delete this._buffItems[delayKey];
                    this._buffItems[key] = buffItem;
                    buffItem.btn_buff.name = ("buff_" + key);
                }
                else
                {
                    buffItem.update(buff);
                    this.updateUi();
                };
            };
        }

        private function internalAddBuff(buff:Object):void
        {
            var buffItem:BuffItem;
            var b:Object;
            if ((((buff) && (buff.hasOwnProperty("isSilent"))) && (buff.isSilent)))
            {
                return;
            };
            var key:String = BuffItem.getKey(buff);
            if (this._buffItems.hasOwnProperty(key))
            {
                this._buffItems[key].addBuff(buff);
            }
            else
            {
                buffItem = this.newBuffItem(buff);
                this._buffItems[key] = buffItem;
            };
            var i:int;
            while (i < this._durationSort.length)
            {
                b = this._durationSort[i];
                if (b.duration < buff.effect.duration)
                {
                    break;
                };
                i++;
            };
            this._durationSort.splice(i, 0, buff.effect);
            if (((buff.effect) && (buff.effect.delay)))
            {
                this.saveBuffWithDelay(buff);
            };
        }

        private function addBuff(buffId:uint):void
        {
            var buff:Object = this.fightApi.getBuffById(buffId, this._nPlayerId);
            if ((((buff) && (buff.effect)) && (!(buff.effect.visibleInBuffUi))))
            {
                return;
            };
            this.internalAddBuff(buff);
            this.updateUi();
        }

        private function removeBuff(buffObj:*):void
        {
            var buffEffect:Object;
            var key:String;
            var buff:Object = ((buffObj is uint) ? this.fightApi.getBuffById(buffObj, this._nPlayerId) : buffObj);
            if ((((!(buff)) || ((buff.hasOwnProperty("isSilent")) && (buff.isSilent))) || ((buff.effect) && (!(buff.effect.visibleInBuffUi)))))
            {
                return;
            };
            this.removeBuffItem(buff);
            var i:int;
            while (i < this._durationSort.length)
            {
                buffEffect = this._durationSort[i];
                if (buffEffect == buff.effect)
                {
                    this._durationSort.splice(i, 1);
                    break;
                };
                i++;
            };
            if (this._rollOverTarget)
            {
                key = this._rollOverTarget.name.substr(5, this._rollOverTarget.name.length);
                if (BuffItem.getKey(buff) == key)
                {
                    this.uiApi.hideTooltip();
                };
            };
            this.updateUi();
        }

        private function saveBuffWithDelay(buff:Object):void
        {
            if (this._buffsWithDelay.indexOf(buff) === -1)
            {
                this._buffsWithDelay.push(buff);
            };
        }

        private function isBuffWithDelay(buff:Object):Boolean
        {
            return (!(this._buffsWithDelay.indexOf(buff) === -1));
        }

        private function removeBuffWithDelay(buff:Object):void
        {
            var indexToRemove:Number = this._buffsWithDelay.indexOf(buff);
            if (indexToRemove !== -1)
            {
                this._buffsWithDelay.removeAt(indexToRemove);
            };
        }

        private function removeBuffItem(buff:Object):void
        {
            var buffHasDelay:Boolean = this.isBuffWithDelay(buff);
            var key:String = BuffItem.getKey(buff, buffHasDelay);
            var buffItem:BuffItem = this._buffItems[key];
            if (((!(buffHasDelay)) && (!(buffItem))))
            {
                key = BuffItem.getKey(buff, true);
                buffItem = this._buffItems[key];
            };
            if (!buffItem)
            {
                key = BuffItem.getKey(buff, true, -1);
                buffItem = this._buffItems[key];
                if (!buffItem)
                {
                    key = BuffItem.getKey(buff, true, 1);
                    buffItem = this._buffItems[key];
                    if (!buffItem)
                    {
                        key = BuffItem.getKey(buff);
                        buffItem = this._buffItems[key];
                    };
                };
            };
            if (buffItem)
            {
                this.removeBuffWithDelay(buff);
                buffItem.removeBuff(buff);
                if (buffItem.buffs.length == 0)
                {
                    buffItem.btn_buff.visible = false;
                    delete this._buffItems[key];
                };
            }
            else
            {
                this.sysApi.log(16, (("removeBuffItem() failed to remove buff with key " + key) + " as no matching buffItem has been found."));
            };
        }

        private function refreshBuffTooltips():void
        {
            var key:String;
            var buffItem:BuffItem;
            var effects:Array;
            var buff:Object;
            var name:String;
            var ew:EffectsWrapper;
            if (this._rollOverTarget)
            {
                key = this._rollOverTarget.name.substr(5, this._rollOverTarget.name.length);
                buffItem = this._buffItems[key];
                if (buffItem)
                {
                    effects = [];
                    this._casterId = -1;
                    for each (buff in buffItem.buffs)
                    {
                        effects.push(buff.effect.clone());
                        this._casterId = buff.source;
                    };
                    if (this.fightApi)
                    {
                        name = this.fightApi.getFighterName(this._casterId);
                        ew = this.fightApi.createEffectsWrapper(buffItem.spell, effects, name, true);
                        if (this._casterId != -1)
                        {
                            this.sysApi.sendAction(new TimelineEntityOver(this._casterId, false));
                        };
                        this.uiApi.showTooltip(ew, this._rollOverTarget, false, "standard", LocationEnum.POINT_BOTTOMRIGHT, LocationEnum.POINT_TOPRIGHT, 10, null, null, null, null, false, 5);
                    };
                };
            };
        }

        public function onRelease(target:Object):void
        {
            var buffId:String;
            var buffItem:BuffItem;
            var spellName:String;
            var text:String;
            var delay:int;
            var name:String;
            if (target == this.btn_decoRight)
            {
                this.folded = this.buffListCtr.visible;
                return;
            };
            if ((((this.uiApi.keyIsDown(Keyboard.ALTERNATE)) && (target)) && (target.name.indexOf("buff_") == 0)))
            {
                buffId = (target.name as String).slice(5);
                buffItem = this._buffItems[buffId];
                spellName = buffItem.spell.name;
                text = "";
                delay = buffItem.delay;
                if (this._nPlayerId == this.playerApi.id())
                {
                    if (buffItem.cooldown == -1000)
                    {
                        text = this.uiApi.getText("ui.fightAutomsg.buff.endless.me", spellName);
                    }
                    else
                    {
                        if (delay > 0)
                        {
                            text = this.uiApi.getText("ui.fightAutomsg.buff.trigger.me", spellName, delay);
                        }
                        else
                        {
                            text = this.uiApi.getText("ui.fightAutomsg.buff.me", spellName, buffItem.cooldown);
                        };
                    };
                }
                else
                {
                    name = (((("{entity," + this._nPlayerId) + ",") + 1) + "}");
                    if (buffItem.cooldown == -1000)
                    {
                        text = this.uiApi.getText("ui.fightAutomsg.buff.endless.target", name, spellName);
                    }
                    else
                    {
                        if (delay > 0)
                        {
                            text = this.uiApi.getText("ui.fightAutomsg.buff.trigger.target", name, spellName, delay);
                        }
                        else
                        {
                            text = this.uiApi.getText("ui.fightAutomsg.buff.target", name, spellName, buffItem.cooldown);
                        };
                    };
                };
                if (text != "")
                {
                    this.sysApi.sendAction(new ChatTextOutput(text, ChatActivableChannelsEnum.CHANNEL_TEAM, null, null));
                };
            };
        }

        public function onUiLoaded(name:String):void
        {
            var tooltipUi:*;
            if (name == "tooltip_effectsDuration")
            {
                tooltipUi = this.uiApi.getUi(name);
                tooltipUi.x = 0;
                tooltipUi.y = 0;
                this.expandedCtr.width = tooltipUi.width;
                if (tooltipUi.height > 500)
                {
                    this.expandedCtr.height = 500;
                }
                else
                {
                    this.expandedCtr.height = tooltipUi.height;
                };
                this.expandedCtr.addContent(tooltipUi);
                tooltipUi.x = (-(tooltipUi.width) + 5);
                tooltipUi.y = (-(tooltipUi.height) + 45);
            };
        }

        public function onRollOver(target:Object):void
        {
            var effectsList:Object;
            if (target.name.substr(0, 4) == "buff")
            {
                this._rollOverTarget = target;
                this.refreshBuffTooltips();
            }
            else
            {
                if (((target == this.btn_decoRight) || (target == this.tx_button_minimize_bgLeft)))
                {
                    effectsList = this.fightApi.getAllBuffEffects(this._nPlayerId);
                    if (((!(effectsList == null)) && (effectsList.categories.length > 0)))
                    {
                        this.uiApi.showTooltip(effectsList, target, false, "standard", LocationEnum.POINT_BOTTOMRIGHT);
                    };
                };
            };
        }

        public function onRollOut(target:Object):void
        {
            if (this._casterId != -1)
            {
                if (this.sysApi)
                {
                    this.sysApi.sendAction(new TimelineEntityOut(this._casterId));
                };
            };
            this._rollOverTarget = null;
            if (this.uiApi)
            {
                this.uiApi.hideTooltip();
            };
        }

        public function onBuffUpdate(buffID:uint, targetId:Number):void
        {
            if (targetId == this._nPlayerId)
            {
                this.updateBuff(buffID);
            };
        }

        public function onBuffAdd(buffID:uint, targetId:Number):void
        {
            if (targetId == this._nPlayerId)
            {
                this.addBuff(buffID);
            };
        }

        public function onBuffRemove(buff:*, targetId:Number, reason:String):void
        {
            if (targetId == this._nPlayerId)
            {
                this.removeBuff(buff);
            };
        }

        public function onGameFightTurnStart(id:Number, waitTime:int, remainingTime:uint, turnPicture:Object):void
        {
            var buffItem:BuffItem;
            if (id == this.playerApi.id())
            {
                this._lastWasPlayer = true;
            }
            else
            {
                if (this._lastWasPlayer)
                {
                    for each (buffItem in this._buffItems)
                    {
                        buffItem.updateCooldown();
                    };
                    this._lastWasPlayer = false;
                };
            };
        }


    }
}

