package Ankama_Fight.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.FightApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.TooltipApi;
    import com.ankamagames.dofus.uiApi.PartyApi;
    import Ankama_Fight.ui.timeline.Fighter;
    import flash.display.Sprite;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Label;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.Texture;
    import d2hooks.GameFightTurnEnd;
    import d2hooks.FightersListUpdated;
    import d2hooks.UpdatePreFightersList;
    import d2hooks.UpdateFightersLook;
    import d2hooks.GameFightTurnStart;
    import d2hooks.FightEvent;
    import d2hooks.FoldAll;
    import d2hooks.FighterSelected;
    import d2hooks.BuffAdd;
    import d2hooks.BuffDispell;
    import d2hooks.BuffRemove;
    import d2hooks.BuffUpdate;
    import d2hooks.TurnCountUpdated;
    import d2hooks.OrderFightersSwitched;
    import d2hooks.HideDeadFighters;
    import d2hooks.HideSummonedFighters;
    import d2hooks.WaveUpdated;
    import d2hooks.GameFightPause;
    import d2hooks.FighterInfoUpdate;
    import d2enums.ComponentHookList;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import flash.filters.GlowFilter;
    import Ankama_Fight.Api;
    import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
    import flash.utils.Dictionary;
    import d2hooks.PartyMemberLifeThresholdUpdate;
    import flash.utils.getTimer;
    import com.ankamagames.berilia.enums.StrataEnum;
    import d2actions.TimelineEntityClick;
    import com.ankamagames.dofus.network.enums.TeamEnum;
    import flash.geom.Point;
    import com.ankamagames.berilia.types.tooltip.TooltipRectangle;
    import d2actions.TimelineEntityOver;
    import d2actions.TimelineEntityOut;
    import d2actions.*;

    public class Timeline 
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
        [Api(name="TooltipApi")]
        public var tooltipApi:TooltipApi;
        [Api(name="PartyApi")]
        public var partyApi:PartyApi;
        private var _fighters:Array;
        private var _hiddenFighters:Array;
        private var _fightersId:Object;
        private var _unsortedFightersId:Object;
        private var _hideDeadGuys:Boolean = false;
        private var _hideSummonedStuff:Boolean = false;
        private var _currentFighterWaitTime:int;
        private var _currentFighterRemainingTime:uint;
        private var _currentFighterParams:FighterParameters = null;
        private var _selectedFighter:Fighter = null;
        private var _currentFighter:Fighter = null;
        private var _timelineMask:Sprite;
        private var _screenWidth:int;
        private var _screenHeight:int;
        private var _charCtrOffset:int;
        private var _marginRight:int;
        private var _marginLeft:int;
        private var _turnCount:uint = 1;
        private var _waveCountAttackers:uint = 0;
        private var _turnCountBeforeNextWaveAttackers:int = -1;
        private var _waveCountDefenders:uint = 0;
        private var _turnCountBeforeNextWaveDefenders:int = -1;
        private var _rollOverMe:Boolean = false;
        private var _prefightPhase:Boolean = true;
        private var _currentOrientation:uint = 0;
        private var _risenDirection:int = 1;
        private var _lastX:Number;
        private var _lastY:Number;
        public var timelineCtr:GraphicContainer;
        public var charCtr:GraphicContainer;
        public var charFrames:GraphicContainer;
        public var ctr_timeline:GraphicContainer;
        public var ctr_buffs:GraphicContainer;
        public var lbl_turnCount:Label;
        public var btn_minimArrow:ButtonContainer;
        public var btn_rightArrow:ButtonContainer;
        public var btn_leftArrow:ButtonContainer;
        public var btn_upArrow:ButtonContainer;
        public var btn_downArrow:ButtonContainer;
        public var tx_options:Texture;
        public var tx_currentArrow:Texture;
        public var ctr_background:GraphicContainer;
        public var ctr_dragTimeline:GraphicContainer;
        public var tx_wave:Texture;


        public function main(params:Object):void
        {
            this.sysApi.addHook(GameFightTurnEnd, this.onGameFightTurnEnd);
            this.sysApi.addHook(FightersListUpdated, this.onGameFightTurnListUpdated);
            this.sysApi.addHook(UpdatePreFightersList, this.onUpdatePreFightersList);
            this.sysApi.addHook(UpdateFightersLook, this.onUpdateFightersLook);
            this.sysApi.addHook(GameFightTurnStart, this.onGameFightTurnStart);
            this.sysApi.addHook(FightEvent, this.onFightEvent);
            this.sysApi.addHook(FoldAll, this.onFoldAll);
            this.sysApi.addHook(FighterSelected, this.onFighterSelected);
            this.sysApi.addHook(BuffAdd, this.onBuffAdd);
            this.sysApi.addHook(BuffDispell, this.onBuffDispell);
            this.sysApi.addHook(BuffRemove, this.onBuffRemove);
            this.sysApi.addHook(BuffUpdate, this.onBuffUpdate);
            this.sysApi.addHook(TurnCountUpdated, this.onTurnCountUpdated);
            this.sysApi.addHook(OrderFightersSwitched, this.onOrderFightersSwitched);
            this.sysApi.addHook(HideDeadFighters, this.onHideDeadFighters);
            this.sysApi.addHook(HideSummonedFighters, this.onHideSummonedFighters);
            this.sysApi.addHook(WaveUpdated, this.onWaveUpdated);
            this.sysApi.addHook(GameFightPause, this.onGameFightPause);
            this.sysApi.addHook(FighterInfoUpdate, this.onFighterMouseAction);
            this.uiApi.addComponentHook(this.lbl_turnCount, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_turnCount, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_wave, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_wave, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_wave, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_options, ComponentHookList.ON_RELEASE);
            this._fighters = [];
            this._hiddenFighters = [];
            if (params)
            {
                if (params.hasOwnProperty("orientation"))
                {
                    this._currentOrientation = params.orientation;
                    this._currentFighterParams = params.fighterParams;
                    this._turnCount = params.turnCount;
                    this.onTurnCountUpdated(this._turnCount);
                    this._waveCountAttackers = params.waveCountAttackers;
                    this._turnCountBeforeNextWaveAttackers = params.turnCountBeforeNextWaveAttackers;
                    this._waveCountDefenders = params.waveCountDefenders;
                    this._turnCountBeforeNextWaveDefenders = params.turnCountBeforeNextWaveDefenders;
                    this.tx_wave.visible = ((!(this._waveCountAttackers == 0)) || (!(this._waveCountDefenders == 0)));
                    this.sysApi.setData(TIMELINE_ORIENTATION, this._currentOrientation, DataStoreEnum.BIND_ACCOUNT);
                };
            }
            else
            {
                this._currentOrientation = this.sysApi.getSetData(TIMELINE_ORIENTATION, this._currentOrientation, DataStoreEnum.BIND_ACCOUNT);
            };
            this.tx_currentArrow.visible = false;
            var glow:GlowFilter = new GlowFilter(Api.sysApi.getConfigEntry("colors.text.glow.dark"), 0.8, 2, 2, 6, 3);
            this.lbl_turnCount.filters = [glow];
            this._screenWidth = this.uiApi.getStageWidth();
            this._screenHeight = this.uiApi.getStageHeight();
            this._charCtrOffset = int(this.uiApi.me().getConstant("char_ctr_offset"));
            this._marginRight = this.uiApi.me().getConstant("bg_margin_right");
            this._marginLeft = this.uiApi.me().getConstant("bg_margin_left");
            this._hideDeadGuys = this.sysApi.getOption("hideDeadFighters", "dofus");
            this._hideSummonedStuff = this.sysApi.getOption("hideSummonedFighters", "dofus");
            this._timelineMask = new Sprite();
            this._timelineMask.graphics.beginFill(0xFF5500);
            if (this._currentOrientation == ORIENTATION_VERTICAL)
            {
                this._timelineMask.graphics.drawRect(-10, (-(this._screenHeight) + 150), (this.timelineCtr.width + 20), (this._screenHeight - 110));
            }
            else
            {
                this._timelineMask.graphics.drawRect((-(this._screenWidth) + 170), 0, (this._screenWidth - 110), this.timelineCtr.height);
            };
            this._timelineMask.graphics.endFill();
            this.timelineCtr.addChild(this._timelineMask);
            this._timelineMask.visible = false;
            this.refreshTimeline();
        }

        public function unload():void
        {
            var fighter:Fighter;
            Fighter.cleanFramesPool();
            var i:int;
            while (i < this._fighters.length)
            {
                fighter = this._fighters[i];
                fighter.destroy();
                i++;
            };
            this._fighters = null;
            this._hiddenFighters = null;
        }

        public function set folded(value:Boolean):void
        {
            var te:Boolean = this.isTimelineExtended();
            if (this._currentOrientation == ORIENTATION_HORIZONTAL)
            {
                this.btn_leftArrow.visible = ((!(value)) && (te));
                this.btn_rightArrow.visible = ((!(value)) && (te));
            }
            else
            {
                this.btn_upArrow.visible = ((!(value)) && (te));
                this.btn_downArrow.visible = ((!(value)) && (te));
            };
            this.charFrames.visible = (!(value));
            if (!this._prefightPhase)
            {
                this.tx_currentArrow.visible = (!(value));
            };
            this.ctr_background.visible = (!(value));
            this.lbl_turnCount.visible = (!(value));
            this.tx_wave.visible = ((!(value)) && ((this._waveCountAttackers > 0) || (this._waveCountDefenders > 0)));
            this.fightApi.setSwapPositionRequestsIconsVisibility((!(value)));
        }

        public function get folded():Boolean
        {
            return (!(this.charFrames.visible));
        }

        public function moveLeft():void
        {
            var offset:int = ((this.charCtr.contentWidth - this._timelineMask.width) - this._charCtrOffset);
            if (((this.charFrames.x + this._charCtrOffset) + 300) < (this._timelineMask.x + offset))
            {
                this.charFrames.x = (this.charFrames.x + 300);
            }
            else
            {
                this.charFrames.x = (this._timelineMask.x + offset);
            };
            this.updateTurnOfArrow();
        }

        public function moveRight():void
        {
            if ((this.charFrames.x + this._charCtrOffset) > (this._timelineMask.x + 300))
            {
                this.charFrames.x = (this.charFrames.x - 300);
            }
            else
            {
                this.charFrames.x = this._timelineMask.x;
            };
            this.updateTurnOfArrow();
        }

        public function moveDown():void
        {
            var offset:int = ((this.charCtr.contentHeight - this._timelineMask.height) + this._charCtrOffset);
            if ((this.charFrames.y + 300) < offset)
            {
                this.charFrames.y = (this.charFrames.y + 300);
            }
            else
            {
                this.charFrames.y = (this._timelineMask.y + offset);
            };
            this.updateTurnOfArrow();
        }

        public function moveUp():void
        {
            if ((this.charFrames.y - 300) < ((this._charCtrOffset - this._marginRight) - this._marginLeft))
            {
                this.charFrames.y = ((this._charCtrOffset - this._marginRight) - this._marginLeft);
            }
            else
            {
                this.charFrames.y = (this.charFrames.y - 300);
            };
            this.updateTurnOfArrow();
        }

        public function refreshMoveOffset():void
        {
            if (this._currentOrientation == ORIENTATION_VERTICAL)
            {
                if (this.charCtr.contentHeight <= this._timelineMask.height)
                {
                    this.charFrames.y = (-(this.charFrames.height) - this._charCtrOffset);
                }
                else
                {
                    if ((this.charFrames.y + this._charCtrOffset) < this._timelineMask.y)
                    {
                        this.charFrames.y = (-(this.charFrames.height) - this._charCtrOffset);
                    }
                    else
                    {
                        if (((this.charFrames.y + this._charCtrOffset) + this.charCtr.contentHeight) > (this._timelineMask.y + this._timelineMask.height))
                        {
                            this.charFrames.y = (-(this.charFrames.height) - this._charCtrOffset);
                        };
                    };
                };
            }
            else
            {
                if (this.charCtr.contentWidth <= this._timelineMask.width)
                {
                    this.charFrames.x = (-(this.charFrames.width) + this._charCtrOffset);
                }
                else
                {
                    if ((this.charFrames.x + this._charCtrOffset) < this._timelineMask.x)
                    {
                        this.charFrames.x = this._timelineMask.x;
                    }
                    else
                    {
                        if (((this.charFrames.x + this._charCtrOffset) - this.charCtr.contentWidth) > (this._timelineMask.x - this._timelineMask.width))
                        {
                            this.charFrames.x = ((this._timelineMask.x - this._timelineMask.width) + this.charCtr.contentWidth);
                        };
                    };
                };
            };
        }

        private function createFighter(id:Number, num:uint):Fighter
        {
            var f:Fighter = new Fighter(id, this.uiApi.me(), num);
            this.uiApi.addComponentHook(f.frame, "onRelease");
            this.uiApi.addComponentHook(f.frame, "onRollOver");
            this.uiApi.addComponentHook(f.frame, "onRollOut");
            return (f);
        }

        private function refreshTimeline():void
        {
            var fighter:Fighter;
            var oldfighter:Fighter;
            var id:Number;
            var pos:int;
            var infos:FighterInformations;
            var alive:Boolean;
            var deadId:Number;
            var isInPreFight:Boolean = this.playerApi.isInPreFight();
            var oldFighters:Dictionary = new Dictionary();
            for each (oldfighter in this._fighters)
            {
                oldFighters[oldfighter.id] = oldfighter;
            };
            this._fightersId = this.fightApi.getFighters();
            if (!this._fightersId)
            {
                this._fightersId = [];
            };
            var deadFightersId:Object = this.fightApi.getDeadFighters();
            if (!deadFightersId)
            {
                deadFightersId = [];
            };
            this._fighters = [];
            this._hiddenFighters = [];
            var numFighter:uint = (this._fightersId.length - deadFightersId.length);
            if (isInPreFight)
            {
                pos = (this._fightersId.length - 1);
                while (pos >= 0)
                {
                    id = this._fightersId[pos];
                    infos = Api.fightApi.getFighterInformations(id);
                    if (infos.hiddenInPrefight)
                    {
                        numFighter--;
                    };
                    pos--;
                };
            };
            pos = (this._fightersId.length - 1);
            while (pos >= 0)
            {
                id = this._fightersId[pos];
                infos = Api.fightApi.getFighterInformations(id);
                alive = true;
                for each (deadId in deadFightersId)
                {
                    if (deadId == id)
                    {
                        alive = false;
                        break;
                    };
                };
                if (oldFighters[id])
                {
                    if ((((!(this._hideDeadGuys)) || (alive)) && ((!(this._hideSummonedStuff)) || (!(oldFighters[id].summoned)))))
                    {
                        fighter = oldFighters[id];
                        fighter.alive = alive;
                        fighter.hiddenInPrefight = infos.hiddenInPrefight;
                        fighter.updateNumber(numFighter);
                        if (((!(fighter.alive)) || ((fighter.hiddenInPrefight) && (isInPreFight))))
                        {
                            numFighter++;
                        };
                        oldFighters[id] = null;
                        this._fighters.push(fighter);
                    }
                    else
                    {
                        this._hiddenFighters[id] = {
                            "id":id,
                            "alive":alive,
                            "summoned":oldFighters[id].summoned
                        };
                        this.charCtr.removeChild(oldFighters[id].frame);
                        if (((!(alive)) || ((oldFighters[id].hiddenInPrefight) && (isInPreFight))))
                        {
                            numFighter++;
                        };
                        oldFighters[id].destroy(true);
                        fighter = null;
                    };
                }
                else
                {
                    infos = Api.fightApi.getFighterInformations(id);
                    if ((((infos) && ((!(this._hideDeadGuys)) || (alive))) && ((!(this._hideSummonedStuff)) || (!(infos.summoned)))))
                    {
                        fighter = this.createFighter(id, numFighter);
                        fighter.alive = alive;
                        fighter.hiddenInPrefight = infos.hiddenInPrefight;
                        if (((!(fighter.alive)) || ((fighter.hiddenInPrefight) && (isInPreFight))))
                        {
                            numFighter++;
                        };
                        this.charCtr.addChild(fighter.frame);
                        this._fighters.push(fighter);
                    }
                    else
                    {
                        if (((!(alive)) || (((infos) && (infos.hiddenInPrefight)) && (isInPreFight))))
                        {
                            numFighter++;
                        };
                        if (infos)
                        {
                            this._hiddenFighters[id] = {
                                "id":id,
                                "alive":alive,
                                "summoned":infos.summoned
                            };
                        };
                    };
                };
                numFighter--;
                if ((((fighter) && (fighter.hiddenInPrefight)) && (isInPreFight)))
                {
                    fighter.updateNumber(numFighter);
                };
                if (fighter)
                {
                    fighter.updateUnsortedIcon();
                };
                pos--;
            };
            for each (fighter in oldFighters)
            {
                if (fighter)
                {
                    fighter.frame.removeFromParent();
                    if (deadFightersId.length > 0)
                    {
                        fighter.destroy();
                    }
                    else
                    {
                        fighter.destroy(true);
                    };
                };
            };
            this.resizeTimeline();
            this.fightApi.updateSwapPositionRequestsIcons();
        }

        private function selectFighter(fighter:Fighter):void
        {
            if (this._selectedFighter)
            {
                this._selectedFighter.selected = false;
            };
            if (this._selectedFighter != fighter)
            {
                this._selectedFighter = fighter;
                fighter.selected = true;
            }
            else
            {
                this._selectedFighter = null;
            };
        }

        private function placeBuffs():void
        {
            if (this._currentOrientation == ORIENTATION_VERTICAL)
            {
                if (this.timelineCtr.x < (this._screenWidth / 2))
                {
                    this.ctr_buffs.x = 75;
                }
                else
                {
                    this.ctr_buffs.x = -65;
                };
            }
            else
            {
                if (this.timelineCtr.y < (this._screenHeight / 2))
                {
                    this.ctr_buffs.y = 150;
                }
                else
                {
                    this.ctr_buffs.y = 0;
                };
            };
        }

        private function setTurnOf(fighter:Fighter, waitTime:int, remainingTime:uint):void
        {
            this._currentFighter = fighter;
            if (!fighter.risen)
            {
                fighter.setRisen(true, (this._currentOrientation == ORIENTATION_VERTICAL), this._risenDirection);
            };
            fighter.startCountDown(waitTime, remainingTime);
            this.updateTurnOfArrow();
        }

        private function updateTurnOfArrow():void
        {
            if (this._currentFighter)
            {
                if (!this.tx_currentArrow.visible)
                {
                    this.tx_currentArrow.visible = true;
                    this._prefightPhase = false;
                };
                if (this._currentOrientation == ORIENTATION_VERTICAL)
                {
                    if (this.timelineCtr.x < (this._screenWidth / 2))
                    {
                        this.tx_currentArrow.x = 70;
                        this.tx_currentArrow.rotation = 180;
                        this.tx_currentArrow.y = ((this._currentFighter.frame.y + int((this._currentFighter.frame.height / 2))) + (this.tx_currentArrow.height / 2));
                        this._risenDirection = -1;
                    }
                    else
                    {
                        this.tx_currentArrow.x = -10;
                        this.tx_currentArrow.rotation = 0;
                        this.tx_currentArrow.y = ((this._currentFighter.frame.y + int((this._currentFighter.frame.height / 2))) - (this.tx_currentArrow.height / 2));
                        this._risenDirection = 1;
                    };
                    this._currentFighter.setRisen(true, (this._currentOrientation == ORIENTATION_VERTICAL), this._risenDirection);
                }
                else
                {
                    this.tx_currentArrow.x = ((this._currentFighter.frame.x + int((this._currentFighter.frame.width / 2))) - (this.tx_currentArrow.height / 2));
                };
            };
        }

        private function unsetTurnOf(fighter:Fighter):void
        {
            if (this._currentFighter == fighter)
            {
                this._currentFighter = null;
            };
            fighter.setRisen(false, (this._currentOrientation == ORIENTATION_VERTICAL), this._risenDirection);
            fighter.stopCountDown();
        }

        private function getFighterByFrame(frame:Object):Fighter
        {
            var fighter:Fighter;
            for each (fighter in this._fighters)
            {
                if (fighter.frame == frame)
                {
                    return (fighter);
                };
            };
            return (null);
        }

        public function getFighterById(id:Number):Fighter
        {
            var fighter:Fighter;
            for each (fighter in this._fighters)
            {
                if (fighter.id == id)
                {
                    return (fighter);
                };
            };
            return (null);
        }

        private function resizeTimeline():void
        {
            var fighter:Fighter;
            var pos:int;
            var frameOffsetHorizontal:int = this.uiApi.me().getConstant("frame_offset_horizontal");
            var frameOffsetVertical:int = this.uiApi.me().getConstant("frame_offset_vertical");
            var currentX:int;
            var currentY:int;
            var timelineSize:int;
            if (this._currentOrientation == ORIENTATION_VERTICAL)
            {
                pos = 0;
                while (pos < this._fighters.length)
                {
                    fighter = this._fighters[pos];
                    if (fighter)
                    {
                        if (pos != 0)
                        {
                            currentY = (currentY + (fighter.frame.height + frameOffsetVertical));
                        };
                        timelineSize = (timelineSize + (fighter.frame.height + frameOffsetVertical));
                        fighter.frame.y = -(currentY);
                    };
                    pos++;
                };
                this.ctr_background.height = (timelineSize + this.charFrames.height);
                if (this.ctr_background.height > (this._screenHeight - 20))
                {
                    this.ctr_background.height = (this._screenHeight - 20);
                };
            }
            else
            {
                pos = 0;
                while (pos < this._fighters.length)
                {
                    fighter = this._fighters[pos];
                    if (fighter)
                    {
                        if (pos != 0)
                        {
                            currentX = (currentX + (fighter.frame.width + frameOffsetHorizontal));
                        };
                        timelineSize = (timelineSize + (fighter.frame.width + frameOffsetHorizontal));
                        fighter.frame.x = -(currentX);
                    };
                    pos++;
                };
                this.ctr_background.width = ((timelineSize + this._marginRight) + this._marginLeft);
                if (this.ctr_background.width > (this._screenWidth - 20))
                {
                    this.ctr_background.width = (this._screenWidth - 20);
                };
            };
            this.refreshMoveOffset();
            if (this.isTimelineExtended())
            {
                this.btn_leftArrow.x = (-(this.ctr_background.width) + int(this.uiApi.me().getConstant("bg_margin_left_to_arrow")));
                if (this._currentOrientation == ORIENTATION_HORIZONTAL)
                {
                    this.btn_leftArrow.visible = true;
                    this.btn_rightArrow.visible = true;
                }
                else
                {
                    this.btn_upArrow.visible = true;
                    this.btn_downArrow.visible = true;
                };
                this._timelineMask.visible = true;
                this.charFrames.mask = this._timelineMask;
            }
            else
            {
                if (this._currentOrientation == ORIENTATION_HORIZONTAL)
                {
                    this.btn_leftArrow.visible = false;
                    this.btn_rightArrow.visible = false;
                }
                else
                {
                    this.btn_upArrow.visible = false;
                    this.btn_downArrow.visible = false;
                };
                this._timelineMask.visible = false;
                this.charFrames.mask = null;
            };
            if (this._currentFighterParams)
            {
                this.initTurnOf(this._currentFighterParams.id, this._currentFighterParams.waitingTime, this._currentFighterParams.remainingTime);
            };
            this.uiApi.me().render();
            this.updateTurnOfArrow();
        }

        private function isTimelineExtended():Boolean
        {
            var fighter:Fighter;
            var extended:Boolean;
            var timelineSize:int;
            var frameOffsetHorizontal:int = this.uiApi.me().getConstant("frame_offset_horizontal");
            var frameOffsetVertical:int = this.uiApi.me().getConstant("frame_offset_vertical");
            var marginRight:int = this.uiApi.me().getConstant("bg_margin_right");
            var marginLeft:int = this.uiApi.me().getConstant("bg_margin_left");
            if (this._currentOrientation == ORIENTATION_VERTICAL)
            {
                for each (fighter in this._fighters)
                {
                    timelineSize = (timelineSize + (fighter.frame.height + frameOffsetVertical));
                };
                extended = (timelineSize > (((this._screenHeight - marginRight) - this.btn_minimArrow.width) - marginLeft));
                return (extended);
            };
            for each (fighter in this._fighters)
            {
                timelineSize = (timelineSize + (fighter.frame.width + frameOffsetHorizontal));
            };
            extended = (timelineSize > (((this._screenWidth - marginRight) - this.btn_minimArrow.width) - marginLeft));
            return (extended);
        }

        private function updateBuff(buff:*, targetId:Number):void
        {
            var buffObj:Object;
            var buffList:Array;
            var maxDuration:Number;
            var index:uint;
            var fighter:Fighter = this.getFighterById(targetId);
            if ((buff is Number))
            {
                buffObj = this.fightApi.getBuffById(buff, targetId);
            }
            else
            {
                buffObj = buff;
            };
            if ((((buffObj) && (buffObj.hasOwnProperty("isDisplayTurnRemaining"))) && (buffObj.isDisplayTurnRemaining)))
            {
                buffList = this.fightApi.getBuffList(targetId);
                maxDuration = -1;
                index = 0;
                while (index < buffList.length)
                {
                    if (((buffList[index].hasOwnProperty("stateId")) && (buffList[index].stateId == buffObj.stateId)))
                    {
                        maxDuration = Math.max(maxDuration, buffList[index].duration);
                    };
                    index++;
                };
                if (maxDuration <= buffObj.duration)
                {
                    buffObj.updateTurnRemaining();
                };
            };
            if (fighter)
            {
                fighter.refreshPdv();
                fighter.refreshShield();
                if (((buffObj) && (buffObj.actionId === 2872)))
                {
                    this.refreshLifeThreshold(fighter);
                };
            };
        }

        private function refreshLifeThreshold(fighter:Fighter):void
        {
            var lifeThreshold:uint = this.sysApi.getBuffManager().getLifeThreshold(fighter.id);
            if (this.partyApi.isInParty(fighter.id))
            {
                this.sysApi.dispatchHook(PartyMemberLifeThresholdUpdate, this.partyApi.getPartyId(), fighter.id, lifeThreshold);
            };
            fighter.refreshPdvThreshold(lifeThreshold);
        }

        private function updateFightersSprite(id:Number):void
        {
            var fighter:Fighter;
            for each (fighter in this._fighters)
            {
                if (fighter.id == id)
                {
                    fighter.updateSprite();
                    fighter.refreshPdv();
                    this.refreshLifeThreshold(fighter);
                };
            };
        }

        private function updateAllFightersSprite():void
        {
            var fighter:Fighter;
            for each (fighter in this._fighters)
            {
                fighter.updateSprite();
            };
        }

        private function changeOrientation():void
        {
            var newOrientation:uint;
            var uiName:String;
            var remainingTime:int;
            if (this._currentOrientation == ORIENTATION_HORIZONTAL)
            {
                newOrientation = ORIENTATION_VERTICAL;
                uiName = "timelineVertical";
            }
            else
            {
                newOrientation = ORIENTATION_HORIZONTAL;
                uiName = "timeline";
            };
            var fighterParams:FighterParameters;
            if (((!(this._prefightPhase)) && (this._currentFighter)))
            {
                if (this._currentFighterParams)
                {
                    remainingTime = (this._currentFighterParams.remainingTime - (getTimer() - this._currentFighter.clockStart));
                }
                else
                {
                    remainingTime = (this._currentFighter.turnDuration - (getTimer() - this._currentFighter.clockStart));
                };
                fighterParams = new FighterParameters(this._currentFighter.id, this._currentFighter.turnDuration, remainingTime);
            };
            this.uiApi.loadUi(uiName, "timeline", new TimelineParameters(newOrientation, fighterParams, this._turnCount, this._waveCountAttackers, this._turnCountBeforeNextWaveAttackers, this._waveCountDefenders, this._turnCountBeforeNextWaveDefenders), StrataEnum.STRATA_TOP, null, true);
        }

        private function initTurnOf(id:Number, waitTime:int, remainingTime:uint):void
        {
            var pos:int;
            this._currentFighterWaitTime = id;
            this._currentFighterRemainingTime = id;
            var fighter:Fighter = this.getFighterById(id);
            if (fighter)
            {
                if (fighter.alive)
                {
                    this.setTurnOf(fighter, waitTime, remainingTime);
                };
            }
            else
            {
                pos = (this._fightersId.indexOf(id) - 1);
                while (pos > 0)
                {
                    fighter = this.getFighterById(this._fightersId[pos]);
                    if (fighter)
                    {
                        this.setTurnOf(fighter, waitTime, remainingTime);
                        break;
                    };
                    pos--;
                };
            };
        }

        private function onGameFightTurnListUpdated():void
        {
            this.refreshTimeline();
        }

        private function onUpdatePreFightersList(id:Number=0):void
        {
            this.refreshTimeline();
            this.updateFightersSprite(id);
        }

        private function onUpdateFightersLook():void
        {
            this.updateAllFightersSprite();
        }

        private function onGameFightTurnStart(id:Number, waitTime:int, remainingTime:uint, picture:Boolean):void
        {
            this.initTurnOf(id, waitTime, remainingTime);
        }

        private function onGameFightTurnEnd(id:Number):void
        {
            var fighter:Fighter = this.getFighterById(id);
            if (((fighter) && (fighter.alive)))
            {
                this.unsetTurnOf(fighter);
            };
        }

        private function onGameFightPause(paused:Boolean):void
        {
            if (paused)
            {
                this._currentFighter.pauseCountDown();
            };
        }

        private function onFightEvent(eventName:String, params:Object, targetList:Object=null):void
        {
            var targetId:Number;
            var fighter:Fighter;
            var iSplice:int;
            var iS:String;
            if (targetList == null)
            {
                targetList = [];
                if (params.length)
                {
                    targetList[0] = params[0];
                };
            };
            var num:int = targetList.length;
            var i:int;
            while (i < num)
            {
                targetId = targetList[i];
                fighter = this.getFighterById(targetId);
                switch (eventName)
                {
                    case "fighterLifeGain":
                    case "fighterLifeLoss":
                        if (fighter)
                        {
                            fighter.refreshPdv();
                        };
                        break;
                    case "fighterShieldLoss":
                        if (fighter)
                        {
                            fighter.refreshShield();
                        };
                        break;
                    case "fighterGotDispelled":
                    case "fighterTemporaryBoosted":
                        if (fighter)
                        {
                            fighter.refreshShield();
                            fighter.refreshPdv();
                            this.refreshLifeThreshold(fighter);
                        };
                        break;
                    case "fighterDeath":
                    case "fighterLeave":
                        if (fighter)
                        {
                            if (this._hideDeadGuys)
                            {
                                for (iS in this._fighters)
                                {
                                    if (this._fighters[iS].id == fighter.id)
                                    {
                                        iSplice = int(iS);
                                        break;
                                    };
                                };
                                this._fighters.splice(iSplice, 1);
                                this._hiddenFighters[fighter.id] = {
                                    "id":fighter.id,
                                    "alive":false,
                                    "summoned":fighter.summoned
                                };
                                fighter.destroy(true);
                                this.charCtr.removeChild(fighter.frame);
                                this.resizeTimeline();
                                this.onOrderFightersSwitched(true);
                            }
                            else
                            {
                                fighter.alive = false;
                                this.onOrderFightersSwitched(true);
                                this.unsetTurnOf(fighter);
                            };
                        };
                        break;
                    case "fighterChangeLook":
                        if (fighter)
                        {
                            fighter.look = params[1];
                        };
                        break;
                    case "fighterSummoned":
                        break;
                };
                i++;
            };
        }

        private function onFoldAll(fold:Boolean):void
        {
            this.folded = fold;
            this.btn_minimArrow.selected = fold;
        }

        public function onRelease(target:Object):void
        {
            var fighter:Fighter;
            switch (target)
            {
                case this.btn_minimArrow:
                    this.folded = (!(this.folded));
                    break;
                case this.btn_leftArrow:
                    this.moveLeft();
                    break;
                case this.btn_rightArrow:
                    this.moveRight();
                    break;
                case this.btn_upArrow:
                    this.moveUp();
                    break;
                case this.btn_downArrow:
                    this.moveDown();
                    break;
                case this.tx_options:
                    this.changeOrientation();
                    break;
                default:
                    fighter = this.getFighterByFrame(target);
                    if (!fighter)
                    {
                        break;
                    };
                    if (this.fightApi.isCastingSpell())
                    {
                        if (fighter.alive)
                        {
                            Api.sysApi.sendAction(new TimelineEntityClick(fighter.id));
                        };
                    }
                    else
                    {
                        this.sysApi.dispatchHook(FighterSelected, fighter.id);
                    };
            };
        }

        public function onFighterSelected(id:Number):void
        {
            var fighter:Fighter = this.getFighterById(id);
            this.selectFighter(fighter);
        }

        public function onBuffAdd(buffId:uint, targetId:Number):void
        {
            this.updateBuff(buffId, targetId);
        }

        public function onBuffRemove(buff:*, targetId:Number, reason:String):void
        {
            this.updateBuff(buff, targetId);
        }

        public function onBuffUpdate(buffId:uint, targetId:Number):void
        {
            this.updateBuff(buffId, targetId);
        }

        public function onBuffDispell(targetId:Number):void
        {
            var fighter:Fighter = this.getFighterById(targetId);
            if (fighter)
            {
                fighter.refreshPdv();
                fighter.refreshShield();
                this.refreshLifeThreshold(fighter);
            };
        }

        public function onOrderFightersSwitched(selected:Boolean):void
        {
            var fighter:Fighter;
            var id:Number;
            var hiddenf:Object;
            var fightersId:Object = this.fightApi.getFighters();
            var isInPreFight:Boolean = Api.playerApi.isInPreFight();
            var num:uint;
            var fighterExists:Boolean;
            var pos:int;
            while (pos < fightersId.length)
            {
                id = fightersId[pos];
                num = (num + 1);
                fighterExists = false;
                for each (fighter in this._fighters)
                {
                    if (id == fighter.id)
                    {
                        if (((!(fighter.alive)) || ((isInPreFight) && (fighter.hiddenInPrefight))))
                        {
                            num--;
                        };
                        fighter.updateNumber(num);
                        fighterExists = true;
                    };
                };
                if (!fighterExists)
                {
                    hiddenf = this._hiddenFighters[id];
                    if ((((hiddenf) && (!(hiddenf.alive))) && (!(hiddenf.summoned))))
                    {
                        num--;
                    };
                };
                pos++;
            };
        }

        public function onHideDeadFighters(selected:Boolean):void
        {
            if (this._hideDeadGuys != selected)
            {
                this._hideDeadGuys = selected;
                this.refreshTimeline();
            };
        }

        public function onHideSummonedFighters(selected:Boolean):void
        {
            if (this._hideSummonedStuff != selected)
            {
                this._hideSummonedStuff = selected;
                this.refreshTimeline();
                this.onOrderFightersSwitched(true);
            };
        }

        public function onTurnCountUpdated(turnCount:uint):void
        {
            this._turnCount = turnCount;
            this.lbl_turnCount.text = this._turnCount.toString();
            if (this._turnCountBeforeNextWaveAttackers > -1)
            {
                this._turnCountBeforeNextWaveAttackers--;
            };
            if (this._turnCountBeforeNextWaveDefenders > -1)
            {
                this._turnCountBeforeNextWaveDefenders--;
            };
        }

        public function onWaveUpdated(teamId:int, wave:int, nbTurnBeforeNext:int):void
        {
            if (wave == 1)
            {
                nbTurnBeforeNext--;
            };
            if (teamId == TeamEnum.TEAM_CHALLENGER)
            {
                this._waveCountAttackers = wave;
                this._turnCountBeforeNextWaveAttackers = nbTurnBeforeNext;
            }
            else
            {
                if (teamId == TeamEnum.TEAM_DEFENDER)
                {
                    this._waveCountDefenders = wave;
                    this._turnCountBeforeNextWaveDefenders = nbTurnBeforeNext;
                };
            };
            this.tx_wave.visible = true;
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            var text2:String;
            var fighter:Fighter;
            var frameGlobalPos:Point;
            var frameRectangle:TooltipRectangle;
            this._rollOverMe = true;
            if (target == this.lbl_turnCount)
            {
                text = this.uiApi.getText("ui.fight.turnNumber", this._turnCount);
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", 7, 1, 0, null, null, null, "TextInfo");
            }
            else
            {
                if (((target == this.tx_wave) && ((this._waveCountAttackers > 0) || (this._waveCountDefenders > 0))))
                {
                    text2 = "";
                    if (this._waveCountAttackers > 0)
                    {
                        text2 = (text2 + ((((this.uiApi.getText("ui.common.attackers") + "\n   ") + this.uiApi.getText("ui.common.wave")) + " ") + this._waveCountAttackers));
                        if (this._turnCountBeforeNextWaveAttackers == 0)
                        {
                            text2 = (text2 + ("\n   " + this.uiApi.getText("ui.fight.newWaveIncoming")));
                        }
                        else
                        {
                            if (this._turnCountBeforeNextWaveAttackers > 0)
                            {
                                text2 = (text2 + ("\n   " + this.uiApi.processText(this.uiApi.getText("ui.fight.turnsBeforeNextWave", this._turnCountBeforeNextWaveAttackers), "", (this._turnCountBeforeNextWaveAttackers == 1), (this._turnCountBeforeNextWaveAttackers == 0))));
                            };
                        };
                    };
                    if (this._waveCountDefenders > 0)
                    {
                        text2 = (text2 + ((((this.uiApi.getText("ui.common.defenders") + "\n   ") + this.uiApi.getText("ui.common.wave")) + " ") + this._waveCountDefenders));
                        if (this._turnCountBeforeNextWaveDefenders == 0)
                        {
                            text2 = (text2 + ("\n   " + this.uiApi.getText("ui.fight.newWaveIncoming")));
                        }
                        else
                        {
                            if (this._turnCountBeforeNextWaveDefenders > 0)
                            {
                                text2 = (text2 + ("\n   " + this.uiApi.processText(this.uiApi.getText("ui.fight.turnsBeforeNextWave", this._turnCountBeforeNextWaveDefenders), "", (this._turnCountBeforeNextWaveDefenders == 1), (this._turnCountBeforeNextWaveDefenders == 0))));
                            };
                        };
                    };
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text2), target, false, "standard", 7, 1, 0, null, null, null, "TextInfo");
                }
                else
                {
                    fighter = this.getFighterByFrame(target);
                    if (!fighter)
                    {
                        return;
                    };
                    if (((fighter.hiddenInPrefight) && (this.playerApi.isInPreFight())))
                    {
                        frameGlobalPos = target.parent.localToGlobal(new Point(target.x, target.y));
                        frameRectangle = this.tooltipApi.createTooltipRectangle(frameGlobalPos.x, frameGlobalPos.y, target.width, target.height);
                        this.sysApi.sendAction(new TimelineEntityOver(fighter.id, true, true, frameRectangle));
                    }
                    else
                    {
                        this.sysApi.sendAction(new TimelineEntityOver(fighter.id, true));
                    };
                };
            };
        }

        public function onRollOut(target:Object):void
        {
            var fighter:Fighter;
            this._rollOverMe = false;
            if (((target == this.lbl_turnCount) || (target == this.tx_wave)))
            {
                this.uiApi.hideTooltip();
            }
            else
            {
                fighter = this.getFighterByFrame(target);
                if (fighter)
                {
                    this.sysApi.sendAction(new TimelineEntityOut(fighter.id));
                };
            };
        }

        private function onFighterMouseAction(infos:Object=null):void
        {
            var fighter:Fighter;
            if (infos)
            {
                fighter = this.getFighterById(infos.contextualId);
                if (((!(fighter == null)) && (fighter.alive)))
                {
                    fighter.highlight = true;
                    if (!this._rollOverMe)
                    {
                        fighter.setRisen(true, (this._currentOrientation == ORIENTATION_VERTICAL), this._risenDirection);
                    };
                };
            }
            else
            {
                for each (fighter in this._fighters)
                {
                    if (!fighter.isCurrentPlayer)
                    {
                        fighter.setRisen(false, (this._currentOrientation == ORIENTATION_VERTICAL), this._risenDirection);
                    };
                    fighter.highlight = false;
                };
            };
            this.fightApi.updateSwapPositionRequestsIcons();
        }

        public function onPress(target:Object):void
        {
            if (target == this.ctr_dragTimeline)
            {
                this._lastX = Math.round(this.timelineCtr.x);
                this._lastY = Math.round(this.timelineCtr.y);
            };
        }

        public function onMouseUp(target:Object):void
        {
            var wasDragging:Boolean;
            if (target == this.ctr_dragTimeline)
            {
                wasDragging = ((!(Math.round(this.timelineCtr.x) == this._lastX)) || (!(Math.round(this.timelineCtr.y) == this._lastY)));
                if (wasDragging)
                {
                    this.updateTurnOfArrow();
                    this.placeBuffs();
                };
            };
        }


    }
} Ankama_Fight.ui

class TimelineParameters 
{

    public var orientation:uint;
    public var fighterParams:FighterParameters;
    public var turnCount:uint;
    public var waveCountAttackers:uint;
    public var turnCountBeforeNextWaveAttackers:int = -1;
    public var waveCountDefenders:uint;
    public var turnCountBeforeNextWaveDefenders:int = -1;

    public function TimelineParameters(pOrientation:uint, pFighterParams:FighterParameters, pTurnCount:uint, pWaveCountAttackers:uint, pTurnCountBeforeNextWaveAttackers:uint, pWaveCountDefenders:uint, pTurnCountBeforeNextWaveDefenders:uint)
    {
        this.orientation = pOrientation;
        this.fighterParams = pFighterParams;
        this.turnCount = pTurnCount;
        this.waveCountAttackers = pWaveCountAttackers;
        this.turnCountBeforeNextWaveAttackers = pTurnCountBeforeNextWaveAttackers;
        this.waveCountDefenders = pWaveCountDefenders;
        this.turnCountBeforeNextWaveDefenders = pTurnCountBeforeNextWaveDefenders;
    }

}

class FighterParameters 
{

    public var id:Number;
    public var waitingTime:int;
    public var remainingTime:int;

    public function FighterParameters(pId:Number, pWaitingTime:int, pRemainingTime:int)
    {
        this.id = pId;
        this.waitingTime = pWaitingTime;
        this.remainingTime = pRemainingTime;
    }

}


