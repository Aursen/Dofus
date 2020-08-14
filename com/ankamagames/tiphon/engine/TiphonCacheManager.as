package com.ankamagames.tiphon.engine
{
    import com.ankamagames.jerakine.newCache.ICache;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.tiphon.types.cache.SpriteCacheInfo;
    import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
    import com.ankamagames.jerakine.newCache.garbage.LfruCache;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import flash.utils.getTimer;
    import com.ankamagames.jerakine.managers.PerformanceManager;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.events.Event;
    import com.ankamagames.tiphon.types.cache.AnimCache;
    import com.ankamagames.tiphon.types.ScriptedAnimation;
    import com.ankamagames.jerakine.types.Swl;
    import com.ankamagames.tiphon.types.TiphonUtility;
    import __AS3__.vec.*;

    public class TiphonCacheManager 
    {

        public static var _cache:ICache;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonCacheManager));
        private static var _self:TiphonCacheManager;
        private static var PRIVILEGE_BOUNDS_CACHE:uint = 10;
        private static var UNPRIVILEGE_BOUNDS_CACHE:uint = 40;
        private static const MIN_FREQUENCY_CACHE:uint = 10;
        private static const _spritesListToRender:Vector.<SpriteCacheInfo> = new Vector.<SpriteCacheInfo>();
        private static var _processing:Boolean = false;
        private static var _lastRender:int = 0;
        private static var _waitRender:int = 0;

        public function TiphonCacheManager()
        {
            Tiphon.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onOptionChange);
        }

        public static function getInstance():TiphonCacheManager
        {
            if (!_self)
            {
                _self = new (TiphonCacheManager)();
                init();
            };
            return (_self);
        }

        public static function init():void
        {
            PRIVILEGE_BOUNDS_CACHE = (int(Tiphon.getInstance().options.getOption("animationsInCache")) / 5);
            UNPRIVILEGE_BOUNDS_CACHE = (int(Tiphon.getInstance().options.getOption("animationsInCache")) - PRIVILEGE_BOUNDS_CACHE);
            _cache = new LfruCache(PRIVILEGE_BOUNDS_CACHE, UNPRIVILEGE_BOUNDS_CACHE, MIN_FREQUENCY_CACHE);
        }

        private static function onEnterFrame(e:Event):void
        {
            var time:int;
            var spriteInfo:SpriteCacheInfo;
            var sprite:TiphonSprite;
            var currentAnim:String;
            var currentDirection:int;
            if (_spritesListToRender.length)
            {
                time = getTimer();
                if ((time - _lastRender) > _waitRender)
                {
                    _lastRender = time;
                    spriteInfo = _spritesListToRender.shift();
                    while (((spriteInfo.sprite.destroyed) && (_spritesListToRender.length)))
                    {
                        spriteInfo = _spritesListToRender.shift();
                    };
                    sprite = spriteInfo.sprite;
                    currentAnim = sprite.getAnimation();
                    currentDirection = sprite.getDirection();
                    sprite.look.updateFrom(spriteInfo.look);
                    sprite.setAnimationAndDirection(currentAnim, currentDirection);
                    if (PerformanceManager.performance == PerformanceManager.NORMAL)
                    {
                        _waitRender = 20;
                    }
                    else
                    {
                        if (PerformanceManager.performance == PerformanceManager.LIMITED)
                        {
                            _waitRender = 200;
                        }
                        else
                        {
                            _waitRender = 500;
                        };
                    };
                };
            }
            else
            {
                StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                _processing = false;
            };
        }

        private static function checkRessourceState():void
        {
        }

        private static function onRenderFail():void
        {
        }


        public function hasCache(anim:String, lookCode:String):Boolean
        {
            return (_cache.contains((lookCode + anim)));
        }

        public function pushScriptedAnimation(scriptedAnimation:ScriptedAnimation, lookCode:String):void
        {
            var animCache:AnimCache = _cache.peek((lookCode + scriptedAnimation.animationName));
            if (animCache)
            {
                animCache.pushAnimation(scriptedAnimation, scriptedAnimation.direction);
            }
            else
            {
                _cache.store((lookCode + scriptedAnimation.animationName), new AnimCache());
                _cache.peek((lookCode + scriptedAnimation.animationName)).pushAnimation(scriptedAnimation, scriptedAnimation.direction);
            };
        }

        public function getScriptedAnimation(bone:int, anim:String, direction:int, lookCode:String):ScriptedAnimation
        {
            var scriptedAnimation:ScriptedAnimation;
            var animClass:Class;
            var flipped:Boolean;
            var lib:Swl;
            var fullAnimName:String;
            var animCache:AnimCache = _cache.peek((lookCode + anim));
            if (animCache)
            {
                scriptedAnimation = animCache.getAnimation(direction);
                if (scriptedAnimation)
                {
                    if (scriptedAnimation.scaleX < 0)
                    {
                        scriptedAnimation.scaleX = (scriptedAnimation.scaleX * -1);
                    };
                    return (scriptedAnimation);
                };
                lib = Tiphon.skullLibrary.getResourceById(bone, anim);
                fullAnimName = ((anim + "_") + direction);
                if (lib.hasDefinition(fullAnimName))
                {
                    animClass = (lib.getDefinition(fullAnimName) as Class);
                }
                else
                {
                    fullAnimName = ((anim + "_") + TiphonUtility.getFlipDirection(direction));
                    if (lib.hasDefinition(fullAnimName))
                    {
                        animClass = (lib.getDefinition(fullAnimName) as Class);
                        flipped = true;
                    };
                };
                scriptedAnimation = (new (animClass)() as ScriptedAnimation);
                scriptedAnimation.bone = bone;
                scriptedAnimation.animationName = anim;
                scriptedAnimation.direction = direction;
                return (scriptedAnimation);
            };
            return (null);
        }

        private function onOptionChange(e:PropertyChangeEvent):void
        {
            var useAnimationCache:Boolean;
            if (e.propertyName == "useAnimationCache")
            {
                useAnimationCache = e.propertyValue;
                if (!useAnimationCache)
                {
                    _cache.destroy();
                };
            }
            else
            {
                if (e.propertyName == "animationsInCache")
                {
                    _cache.destroy();
                    init();
                };
            };
        }


    }
} com.ankamagames.tiphon.engine

