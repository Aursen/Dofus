package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.dofus.types.data.FpsLogWrapper;
    import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.events.Event;
    import flash.desktop.NativeApplication;
    import flash.events.NativeWindowDisplayStateEvent;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;
    import com.ankamagames.tiphon.engine.TiphonDebugManager;
    import flash.display.NativeWindow;
    import flash.display.NativeWindowDisplayState;
    import com.ankamagames.jerakine.managers.PerformanceManager;
    import com.ankamagames.dofus.types.DofusOptions;
    import com.ankamagames.dofus.misc.interClient.InterClientManager;
    import flash.events.MouseEvent;
    import flash.utils.getTimer;
    import com.ankamagames.jerakine.utils.display.FpsControler;

    public class DofusFpsManager 
    {

        private static var _totalFrame:int = 0;
        private static var _animFPS:int = 25;
        private static var _interval:int = (1000 / _animFPS);
        private static var _framePlayed:int = 0;
        private static var _frameNeeded:int = 0;
        private static var _focusListInfo:Array = new Array();
        public static var currentFps:Number;
        public static var allowSkipFrame:Boolean = true;
        private static var _elapsedTime:uint;
        private static var _lastTime:uint;
        private static var _frame:uint;
        private static var _logWrapped:FpsLogWrapper;
        private static var _logRamWrapped:FpsLogWrapper;


        public static function init():void
        {
            EnterFrameDispatcher.addEventListener(onEnterFrame, "DofusFpsManager");
            StageShareManager.stage.addEventListener(Event.ACTIVATE, onActivate);
            StageShareManager.stage.addEventListener(Event.DEACTIVATE, onDesactivate);
            NativeApplication.nativeApplication.openedWindows[0].addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, onStateChange);
            _logWrapped = new FpsLogWrapper();
            _logRamWrapped = new FpsLogWrapper();
            if (((BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG) || (BuildInfos.BUILD_TYPE == BuildTypeEnum.INTERNAL)))
            {
                TiphonDebugManager.enable();
            };
        }

        public static function updateFocusList(focusList:Array, clientId:String):void
        {
            var lastFocus:String;
            var lastTime:Number;
            var time:Number;
            var nativeWindow:NativeWindow = NativeApplication.nativeApplication.openedWindows[0];
            if (((nativeWindow) && (nativeWindow["displayState"] == NativeWindowDisplayState.MINIMIZED)))
            {
                StageShareManager.stage.frameRate = 12;
                return;
            };
            var num:int = focusList.length;
            var i:int;
            while (i < num)
            {
                if (lastFocus == null)
                {
                    lastFocus = focusList[i];
                    lastTime = Number(focusList[(i + 1)]);
                }
                else
                {
                    time = Number(focusList[(i + 1)]);
                    if (lastTime < time)
                    {
                        lastFocus = focusList[i];
                        lastTime = time;
                    };
                };
                i = (i + 2);
            };
            if (clientId == lastFocus)
            {
                StageShareManager.stage.frameRate = PerformanceManager.BASE_FRAMERATE;
            }
            else
            {
                if (!StageShareManager.isActive)
                {
                    StageShareManager.stage.frameRate = 12;
                };
            };
        }

        private static function onActivate(e:Event):void
        {
            StageShareManager.stage.frameRate = PerformanceManager.BASE_FRAMERATE;
            var options:DofusOptions = Dofus.getInstance().options;
            if (((options) && (options.getOption("optimizeMultiAccount"))))
            {
                InterClientManager.getInstance().gainFocus();
            };
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OVER, onStageRollOver);
        }

        private static function onDesactivate(e:Event):void
        {
            StageShareManager.stage.addEventListener(MouseEvent.MOUSE_OVER, onStageRollOver);
        }

        private static function onStageRollOver(e:Event):void
        {
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OVER, onStageRollOver);
            StageShareManager.stage.frameRate = PerformanceManager.BASE_FRAMERATE;
        }

        private static function onStateChange(e:NativeWindowDisplayStateEvent):void
        {
            var options:DofusOptions = Dofus.getInstance().options;
            if (((options) && (options.getOption("optimizeMultiAccount"))))
            {
                if (e.afterDisplayState == NativeWindowDisplayState.MINIMIZED)
                {
                    StageShareManager.stage.frameRate = 12;
                    InterClientManager.getInstance().resetFocus();
                }
                else
                {
                    StageShareManager.stage.frameRate = PerformanceManager.BASE_FRAMERATE;
                };
            };
        }

        private static function onEnterFrame(e:Event):void
        {
            var numFrame:int;
            var i:int;
            var time:int = getTimer();
            _elapsedTime = (_elapsedTime + (time - _lastTime));
            _frame++;
            if (_elapsedTime > 1000)
            {
                currentFps = (_frame / (_elapsedTime / 1000));
                _elapsedTime = 0;
                _frame = 0;
            };
            if (allowSkipFrame)
            {
                _frameNeeded = (time / _interval);
                _totalFrame++;
                numFrame = (_frameNeeded - _framePlayed);
                if (numFrame)
                {
                    _framePlayed = _frameNeeded;
                    i = 0;
                    while (i < numFrame)
                    {
                        FpsControler.nextFrame();
                        i++;
                    };
                };
            }
            else
            {
                _frameNeeded = 1;
                _totalFrame++;
                FpsControler.nextFrame();
            };
            _lastTime = time;
        }


    }
} com.ankamagames.dofus.logic.common.managers

