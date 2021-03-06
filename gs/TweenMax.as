package gs
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import gs.plugins.TweenPlugin;
    import gs.plugins.AutoAlphaPlugin;
    import gs.plugins.EndArrayPlugin;
    import gs.plugins.FramePlugin;
    import gs.plugins.RemoveTintPlugin;
    import gs.plugins.TintPlugin;
    import gs.plugins.VisiblePlugin;
    import gs.plugins.VolumePlugin;
    import gs.plugins.BevelFilterPlugin;
    import gs.plugins.BezierPlugin;
    import gs.plugins.BezierThroughPlugin;
    import gs.plugins.BlurFilterPlugin;
    import gs.plugins.ColorMatrixFilterPlugin;
    import gs.plugins.ColorTransformPlugin;
    import gs.plugins.DropShadowFilterPlugin;
    import gs.plugins.FrameLabelPlugin;
    import gs.plugins.GlowFilterPlugin;
    import gs.plugins.HexColorsPlugin;
    import gs.plugins.RoundPropsPlugin;
    import gs.plugins.ShortRotationPlugin;
    import gs.events.TweenEvent;
    import gs.core.TweenCore;
    import flash.utils.Dictionary;
    import flash.display.DisplayObjectContainer;
    import flash.display.DisplayObject;
    import gs.core.SimpleTimeline;
    import flash.utils.getTimer;
    import gs.core.PropTween;
    import flash.events.Event;
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import gs.core.*;
    import gs.plugins.*;

    public class TweenMax extends TweenLite implements IEventDispatcher 
    {

        public static const version:Number = 11.66;
        private static var _overwriteMode:int = ((OverwriteManager.enabled) ? OverwriteManager.mode : OverwriteManager.init(2));
        public static var killTweensOf:Function = TweenLite.killTweensOf;
        public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;

        protected var _dispatcher:EventDispatcher;
        protected var _hasUpdateListener:Boolean;
        protected var _repeat:int = 0;
        protected var _repeatDelay:Number = 0;
        protected var _cyclesComplete:int = 0;
        protected var _easePower:int;
        protected var _easeType:int;
        public var yoyo:Boolean;

        {
            TweenPlugin.activate([AutoAlphaPlugin, EndArrayPlugin, FramePlugin, RemoveTintPlugin, TintPlugin, VisiblePlugin, VolumePlugin, BevelFilterPlugin, BezierPlugin, BezierThroughPlugin, BlurFilterPlugin, ColorMatrixFilterPlugin, ColorTransformPlugin, DropShadowFilterPlugin, FrameLabelPlugin, GlowFilterPlugin, HexColorsPlugin, RoundPropsPlugin, ShortRotationPlugin, {}]);
        }

        public function TweenMax(target:Object, duration:Number, vars:Object)
        {
            super(target, duration, vars);
            if (TweenLite.version < 11.2)
            {
                throw (new Error("TweenMax error! Please update your TweenLite class or try deleting your ASO files. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com."));
            };
            this.yoyo = Boolean(this.vars.yoyo);
            this._repeat = uint(this.vars.repeat);
            this._repeatDelay = ((this.vars.repeatDelay) ? Number(this.vars.repeatDelay) : 0);
            this.cacheIsDirty = true;
            if (((((((this.vars.onCompleteListener) || (this.vars.onInitListener)) || (this.vars.onUpdateListener)) || (this.vars.onStartListener)) || (this.vars.onRepeatListener)) || (this.vars.onReverseCompleteListener)))
            {
                this.initDispatcher();
                if (((duration == 0) && (_delay == 0)))
                {
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
                };
            };
            if (((this.vars.timeScale) && (!(this.target is TweenCore))))
            {
                this.cachedTimeScale = this.vars.timeScale;
            };
        }

        public static function to(target:Object, duration:Number, vars:Object):TweenMax
        {
            return (new TweenMax(target, duration, vars));
        }

        public static function from(target:Object, duration:Number, vars:Object):TweenMax
        {
            vars.runBackwards = true;
            if (!("immediateRender" in vars))
            {
                vars.immediateRender = true;
            };
            return (new TweenMax(target, duration, vars));
        }

        public static function fromTo(target:Object, duration:Number, fromVars:Object, toVars:Object):TweenMax
        {
            toVars.startAt = fromVars;
            if (fromVars.immediateRender)
            {
                toVars.immediateRender = true;
            };
            return (new TweenMax(target, duration, toVars));
        }

        public static function allTo(targets:Array, duration:Number, vars:Object, stagger:Number=0, onCompleteAll:Function=null, onCompleteAllParams:Array=null):Array
        {
            var i:int;
            var varsDup:Object;
            var p:String;
            var onCompleteProxy:Function;
            var onCompleteParamsProxy:Array;
            var l:int = targets.length;
            var a:Array = [];
            var curDelay:Number = (("delay" in vars) ? Number(vars.delay) : 0);
            onCompleteProxy = vars.onComplete;
            onCompleteParamsProxy = vars.onCompleteParams;
            var lastIndex:int = (l - 1);
            i = 0;
            while (i < l)
            {
                varsDup = {};
                for (p in vars)
                {
                    varsDup[p] = vars[p];
                };
                varsDup.delay = curDelay;
                if (((i == lastIndex) && (!(onCompleteAll == null))))
                {
                    varsDup.onComplete = function ():void
                    {
                        if (onCompleteProxy != null)
                        {
                            onCompleteProxy.apply(null, onCompleteParamsProxy);
                        };
                        onCompleteAll.apply(null, onCompleteAllParams);
                    };
                };
                a[i] = new TweenMax(targets[i], duration, varsDup);
                curDelay = (curDelay + stagger);
                i = (i + 1);
            };
            return (a);
        }

        public static function allFrom(targets:Array, duration:Number, vars:Object, stagger:Number=0, onCompleteAll:Function=null, onCompleteAllParams:Array=null):Array
        {
            vars.runBackwards = true;
            if (!("immediateRender" in vars))
            {
                vars.immediateRender = true;
            };
            return (allTo(targets, duration, vars, stagger, onCompleteAll, onCompleteAllParams));
        }

        public static function allFromTo(targets:Array, duration:Number, fromVars:Object, toVars:Object, stagger:Number=0, onCompleteAll:Function=null, onCompleteAllParams:Array=null):Array
        {
            toVars.startAt = fromVars;
            if (fromVars.immediateRender)
            {
                toVars.immediateRender = true;
            };
            return (allTo(targets, duration, toVars, stagger, onCompleteAll, onCompleteAllParams));
        }

        public static function delayedCall(delay:Number, onComplete:Function, onCompleteParams:Array=null, useFrames:Boolean=false):TweenMax
        {
            return (new TweenMax(onComplete, 0, {
                "delay":delay,
                "onComplete":onComplete,
                "onCompleteParams":onCompleteParams,
                "immediateRender":false,
                "useFrames":useFrames,
                "overwrite":0
            }));
        }

        public static function getTweensOf(target:Object):Array
        {
            var i:int;
            var cnt:int;
            var a:Array = masterList[target];
            var toReturn:Array = [];
            if (a)
            {
                i = a.length;
                cnt = 0;
                while (--i > -1)
                {
                    if (!TweenLite(a[i]).gc)
                    {
                        var _local_6:* = cnt++;
                        toReturn[_local_6] = a[i];
                    };
                };
            };
            return (toReturn);
        }

        public static function isTweening(target:Object):Boolean
        {
            var tween:TweenLite;
            var a:Array = getTweensOf(target);
            var i:int = a.length;
            while (--i > -1)
            {
                tween = a[i];
                if (((tween.active) || ((tween.cachedStartTime == tween.timeline.cachedTime) && (tween.timeline.active))))
                {
                    return (true);
                };
            };
            return (false);
        }

        public static function getAllTweens():Array
        {
            var a:Array;
            var i:int;
            var ml:Dictionary = masterList;
            var cnt:int;
            var toReturn:Array = [];
            for each (a in ml)
            {
                i = a.length;
                while (--i > -1)
                {
                    if (!TweenLite(a[i]).gc)
                    {
                        var _local_8:* = cnt++;
                        toReturn[_local_8] = a[i];
                    };
                };
            };
            return (toReturn);
        }

        public static function killAll(complete:Boolean=false, tweens:Boolean=true, delayedCalls:Boolean=true):void
        {
            var isDC:Boolean;
            var a:Array = getAllTweens();
            var i:int = a.length;
            while (--i > -1)
            {
                isDC = (a[i].target == a[i].vars.onComplete);
                if (((isDC == delayedCalls) || (!(isDC == tweens))))
                {
                    if (complete)
                    {
                        a[i].complete(false);
                    }
                    else
                    {
                        a[i].setEnabled(false, false);
                    };
                };
            };
        }

        public static function killChildTweensOf(parent:DisplayObjectContainer, complete:Boolean=false):void
        {
            var curTarget:Object;
            var curParent:DisplayObjectContainer;
            var a:Array = getAllTweens();
            var i:int = a.length;
            while (--i > -1)
            {
                curTarget = a[i].target;
                if ((curTarget is DisplayObject))
                {
                    curParent = curTarget.parent;
                    while (curParent)
                    {
                        if (curParent == parent)
                        {
                            if (complete)
                            {
                                a[i].complete(false);
                            }
                            else
                            {
                                a[i].setEnabled(false, false);
                            };
                        };
                        curParent = curParent.parent;
                    };
                };
            };
        }

        public static function pauseAll(tweens:Boolean=true, delayedCalls:Boolean=true):void
        {
            changePause(true, tweens, delayedCalls);
        }

        public static function resumeAll(tweens:Boolean=true, delayedCalls:Boolean=true):void
        {
            changePause(false, tweens, delayedCalls);
        }

        private static function changePause(pause:Boolean, tweens:Boolean=true, delayedCalls:Boolean=false):void
        {
            var isDC:Boolean;
            var a:Array = getAllTweens();
            var i:int = a.length;
            while (--i > -1)
            {
                isDC = (TweenLite(a[i]).target == TweenLite(a[i]).vars.onComplete);
                if (((isDC == delayedCalls) || (!(isDC == tweens))))
                {
                    TweenCore(a[i]).paused = pause;
                };
            };
        }

        public static function get globalTimeScale():Number
        {
            return ((TweenLite.rootTimeline == null) ? 1 : TweenLite.rootTimeline.cachedTimeScale);
        }

        public static function set globalTimeScale(n:Number):void
        {
            if (n == 0)
            {
                n = 0.0001;
            };
            if (TweenLite.rootTimeline == null)
            {
                TweenLite.to({}, 0, {});
            };
            var tl:SimpleTimeline = TweenLite.rootTimeline;
            var curTime:Number = (getTimer() * 0.001);
            tl.cachedStartTime = (curTime - (((curTime - tl.cachedStartTime) * tl.cachedTimeScale) / n));
            tl = TweenLite.rootFramesTimeline;
            curTime = TweenLite.rootFrame;
            tl.cachedStartTime = (curTime - (((curTime - tl.cachedStartTime) * tl.cachedTimeScale) / n));
            TweenLite.rootFramesTimeline.cachedTimeScale = (TweenLite.rootTimeline.cachedTimeScale = n);
        }


        override protected function init():void
        {
            var startTween:TweenMax;
            if (this.vars.startAt)
            {
                this.vars.startAt.overwrite = 0;
                this.vars.startAt.immediateRender = true;
                startTween = new TweenMax(this.target, 0, this.vars.startAt);
            };
            if (this._dispatcher)
            {
                this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.INIT));
            };
            super.init();
            if ((_ease in fastEaseLookup))
            {
                this._easeType = fastEaseLookup[_ease][0];
                this._easePower = fastEaseLookup[_ease][1];
            };
        }

        override public function invalidate():void
        {
            this.yoyo = Boolean((this.vars.yoyo == true));
            this._repeat = ((this.vars.repeat) ? Number(this.vars.repeat) : 0);
            this._repeatDelay = ((this.vars.repeatDelay) ? Number(this.vars.repeatDelay) : 0);
            this._hasUpdateListener = false;
            if ((((!(this.vars.onCompleteListener == null)) || (!(this.vars.onUpdateListener == null))) || (!(this.vars.onStartListener == null))))
            {
                this.initDispatcher();
            };
            setDirtyCache(true);
            super.invalidate();
        }

        public function updateTo(vars:Object, resetDuration:Boolean=false):void
        {
            var p:String;
            var inv:Number;
            var pt:PropTween;
            var endValue:Number;
            var curRatio:Number = this.ratio;
            if ((((resetDuration) && (!(this.timeline == null))) && (this.cachedStartTime < this.timeline.cachedTime)))
            {
                this.cachedStartTime = this.timeline.cachedTime;
                this.setDirtyCache(false);
                if (this.gc)
                {
                    this.setEnabled(true, false);
                }
                else
                {
                    this.timeline.insert(this, (this.cachedStartTime - _delay));
                };
            };
            for (p in vars)
            {
                this.vars[p] = vars[p];
            };
            if (this.initted)
            {
                this.initted = false;
                if (!resetDuration)
                {
                    if (((_notifyPluginsOfEnabled) && (this.cachedPT1)))
                    {
                        onPluginEvent("onDisable", this);
                    };
                    this.init();
                    if ((((!(resetDuration)) && (this.cachedTime > 0)) && (this.cachedTime < this.cachedDuration)))
                    {
                        inv = (1 / (1 - curRatio));
                        pt = this.cachedPT1;
                        while (pt)
                        {
                            endValue = (pt.start + pt.change);
                            pt.change = (pt.change * inv);
                            pt.start = (endValue - pt.change);
                            pt = pt.nextNode;
                        };
                    };
                };
            };
        }

        public function setDestination(property:String, value:*, adjustStartValues:Boolean=true):void
        {
            var vars:Object = {};
            vars[property] = value;
            this.updateTo(vars, (!(adjustStartValues)));
        }

        public function killProperties(names:Array):void
        {
            var v:Object = {};
            var i:int = names.length;
            while (--i > -1)
            {
                v[names[i]] = true;
            };
            killVars(v);
        }

        override public function renderTime(time:Number, suppressEvents:Boolean=false, force:Boolean=false):void
        {
            var isComplete:Boolean;
            var repeated:Boolean;
            var setRatio:Boolean;
            var cycleDuration:Number;
            var prevCycles:int;
            var power:int;
            var val:Number;
            var totalDur:Number = ((this.cacheIsDirty) ? this.totalDuration : this.cachedTotalDuration);
            var prevTime:Number = this.cachedTotalTime;
            if (time >= totalDur)
            {
                this.cachedTotalTime = totalDur;
                this.cachedTime = this.cachedDuration;
                this.ratio = 1;
                isComplete = true;
                if (this.cachedDuration == 0)
                {
                    if ((((time == 0) || (_rawPrevTime < 0)) && (!(_rawPrevTime == time))))
                    {
                        force = true;
                    };
                    _rawPrevTime = time;
                };
            }
            else
            {
                if (time <= 0)
                {
                    if (time < 0)
                    {
                        this.active = false;
                        if (this.cachedDuration == 0)
                        {
                            if (_rawPrevTime >= 0)
                            {
                                force = true;
                                isComplete = true;
                            };
                            _rawPrevTime = time;
                        };
                    }
                    else
                    {
                        if (((time == 0) && (!(this.initted))))
                        {
                            force = true;
                        };
                    };
                    this.cachedTotalTime = (this.cachedTime = (this.ratio = 0));
                    if (((this.cachedReversed) && (!(prevTime == 0))))
                    {
                        isComplete = true;
                    };
                }
                else
                {
                    this.cachedTotalTime = (this.cachedTime = time);
                    setRatio = true;
                };
            };
            if (this._repeat != 0)
            {
                cycleDuration = (this.cachedDuration + this._repeatDelay);
                prevCycles = this._cyclesComplete;
                this._cyclesComplete = ((this.cachedTotalTime / cycleDuration) >> 0);
                if (this._cyclesComplete == (this.cachedTotalTime / cycleDuration))
                {
                    this._cyclesComplete--;
                };
                if (prevCycles != this._cyclesComplete)
                {
                    repeated = true;
                };
                if (isComplete)
                {
                    if (((this.yoyo) && (this._repeat % 2)))
                    {
                        this.cachedTime = (this.ratio = 0);
                    };
                }
                else
                {
                    if (time > 0)
                    {
                        this.cachedTime = (((this.cachedTotalTime / cycleDuration) - this._cyclesComplete) * cycleDuration);
                        if (((this.yoyo) && (this._cyclesComplete % 2)))
                        {
                            this.cachedTime = (this.cachedDuration - this.cachedTime);
                        }
                        else
                        {
                            if (this.cachedTime >= this.cachedDuration)
                            {
                                this.cachedTime = this.cachedDuration;
                                this.ratio = 1;
                                setRatio = false;
                            };
                        };
                        if (this.cachedTime <= 0)
                        {
                            this.cachedTime = (this.ratio = 0);
                            setRatio = false;
                        };
                    }
                    else
                    {
                        this._cyclesComplete = 0;
                    };
                };
            };
            if (((prevTime == this.cachedTotalTime) && (!(force))))
            {
                return;
            };
            if (!this.initted)
            {
                this.init();
            };
            if (((!(this.active)) && (!(this.cachedPaused))))
            {
                this.active = true;
            };
            if (setRatio)
            {
                if (this._easeType)
                {
                    power = this._easePower;
                    val = (this.cachedTime / this.cachedDuration);
                    if (this._easeType == 2)
                    {
                        this.ratio = (val = (1 - val));
                        while (--power > -1)
                        {
                            this.ratio = (val * this.ratio);
                        };
                        this.ratio = (1 - this.ratio);
                    }
                    else
                    {
                        if (this._easeType == 1)
                        {
                            this.ratio = val;
                            while (--power > -1)
                            {
                                this.ratio = (val * this.ratio);
                            };
                        }
                        else
                        {
                            if (val < 0.5)
                            {
                                this.ratio = (val = (val * 2));
                                while (--power > -1)
                                {
                                    this.ratio = (val * this.ratio);
                                };
                                this.ratio = (this.ratio * 0.5);
                            }
                            else
                            {
                                this.ratio = (val = ((1 - val) * 2));
                                while (--power > -1)
                                {
                                    this.ratio = (val * this.ratio);
                                };
                                this.ratio = (1 - (0.5 * this.ratio));
                            };
                        };
                    };
                }
                else
                {
                    this.ratio = _ease(this.cachedTime, 0, 1, this.cachedDuration);
                };
            };
            if ((((prevTime == 0) && ((!(this.cachedTotalTime == 0)) || (this.cachedDuration == 0))) && (!(suppressEvents))))
            {
                if (this.vars.onStart)
                {
                    this.vars.onStart.apply(null, this.vars.onStartParams);
                };
                if (this._dispatcher)
                {
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
                };
            };
            var pt:PropTween = this.cachedPT1;
            while (pt)
            {
                pt.target[pt.property] = (pt.start + (this.ratio * pt.change));
                pt = pt.nextNode;
            };
            if (((_hasUpdate) && (!(suppressEvents))))
            {
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            };
            if (((this._hasUpdateListener) && (!(suppressEvents))))
            {
                this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
            };
            if ((((repeated) && (!(suppressEvents))) && (!(this.gc))))
            {
                if (this.vars.onRepeat)
                {
                    this.vars.onRepeat.apply(null, this.vars.onRepeatParams);
                };
                if (this._dispatcher)
                {
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REPEAT));
                };
            };
            if (((isComplete) && (!(this.gc))))
            {
                if (((_hasPlugins) && (this.cachedPT1)))
                {
                    onPluginEvent("onComplete", this);
                };
                this.complete(true, suppressEvents);
            };
        }

        override public function complete(skipRender:Boolean=false, suppressEvents:Boolean=false):void
        {
            super.complete(skipRender, suppressEvents);
            if (((!(suppressEvents)) && (this._dispatcher)))
            {
                if (((this.cachedTotalTime == this.cachedTotalDuration) && (!(this.cachedReversed))))
                {
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
                }
                else
                {
                    if (((this.cachedReversed) && (this.cachedTotalTime == 0)))
                    {
                        this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REVERSE_COMPLETE));
                    };
                };
            };
        }

        protected function initDispatcher():void
        {
            if (this._dispatcher == null)
            {
                this._dispatcher = new EventDispatcher(this);
            };
            if ((this.vars.onInitListener is Function))
            {
                this._dispatcher.addEventListener(TweenEvent.INIT, this.vars.onInitListener, false, 0, true);
            };
            if ((this.vars.onStartListener is Function))
            {
                this._dispatcher.addEventListener(TweenEvent.START, this.vars.onStartListener, false, 0, true);
            };
            if ((this.vars.onUpdateListener is Function))
            {
                this._dispatcher.addEventListener(TweenEvent.UPDATE, this.vars.onUpdateListener, false, 0, true);
                this._hasUpdateListener = true;
            };
            if ((this.vars.onCompleteListener is Function))
            {
                this._dispatcher.addEventListener(TweenEvent.COMPLETE, this.vars.onCompleteListener, false, 0, true);
            };
            if ((this.vars.onRepeatListener is Function))
            {
                this._dispatcher.addEventListener(TweenEvent.REPEAT, this.vars.onRepeatListener, false, 0, true);
            };
            if ((this.vars.onReverseCompleteListener is Function))
            {
                this._dispatcher.addEventListener(TweenEvent.REVERSE_COMPLETE, this.vars.onReverseCompleteListener, false, 0, true);
            };
        }

        public function addEventListener(_arg_1:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            if (this._dispatcher == null)
            {
                this.initDispatcher();
            };
            if (_arg_1 == TweenEvent.UPDATE)
            {
                this._hasUpdateListener = true;
            };
            this._dispatcher.addEventListener(_arg_1, listener, useCapture, priority, useWeakReference);
        }

        public function removeEventListener(_arg_1:String, listener:Function, useCapture:Boolean=false):void
        {
            if (this._dispatcher)
            {
                this._dispatcher.removeEventListener(_arg_1, listener, useCapture);
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return ((this._dispatcher == null) ? false : this._dispatcher.hasEventListener(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return ((this._dispatcher == null) ? false : this._dispatcher.willTrigger(_arg_1));
        }

        public function dispatchEvent(e:Event):Boolean
        {
            return ((this._dispatcher == null) ? false : this._dispatcher.dispatchEvent(e));
        }

        public function get currentProgress():Number
        {
            return (this.cachedTime / this.duration);
        }

        public function set currentProgress(n:Number):void
        {
            if (this._cyclesComplete == 0)
            {
                setTotalTime((this.duration * n), false);
            }
            else
            {
                setTotalTime(((this.duration * n) + (this._cyclesComplete * this.cachedDuration)), false);
            };
        }

        public function get totalProgress():Number
        {
            return (this.cachedTotalTime / this.totalDuration);
        }

        public function set totalProgress(n:Number):void
        {
            setTotalTime((this.totalDuration * n), false);
        }

        override public function set currentTime(n:Number):void
        {
            if (this._cyclesComplete != 0)
            {
                if (((this.yoyo) && ((this._cyclesComplete % 2) == 1)))
                {
                    n = ((this.duration - n) + (this._cyclesComplete * (this.cachedDuration + this._repeatDelay)));
                }
                else
                {
                    n = (n + (this._cyclesComplete * (this.duration + this._repeatDelay)));
                };
            };
            setTotalTime(n, false);
        }

        override public function get totalDuration():Number
        {
            if (this.cacheIsDirty)
            {
                this.cachedTotalDuration = ((this._repeat == -1) ? 999999999999 : ((this.cachedDuration * (this._repeat + 1)) + (this._repeatDelay * this._repeat)));
                this.cacheIsDirty = false;
            };
            return (this.cachedTotalDuration);
        }

        override public function set totalDuration(n:Number):void
        {
            if (this._repeat == -1)
            {
                return;
            };
            this.duration = ((n - (this._repeat * this._repeatDelay)) / (this._repeat + 1));
        }

        public function get timeScale():Number
        {
            return (this.cachedTimeScale);
        }

        public function set timeScale(n:Number):void
        {
            if (n == 0)
            {
                n = 0.0001;
            };
            var tlTime:Number = (((this.cachedPauseTime) || (this.cachedPauseTime == 0)) ? this.cachedPauseTime : this.timeline.cachedTotalTime);
            this.cachedStartTime = (tlTime - (((tlTime - this.cachedStartTime) * this.cachedTimeScale) / n));
            this.cachedTimeScale = n;
            setDirtyCache(false);
        }

        public function get repeat():int
        {
            return (this._repeat);
        }

        public function set repeat(n:int):void
        {
            this._repeat = n;
            setDirtyCache(true);
        }

        public function get repeatDelay():Number
        {
            return (this._repeatDelay);
        }

        public function set repeatDelay(n:Number):void
        {
            this._repeatDelay = n;
            setDirtyCache(true);
        }


    }
}

