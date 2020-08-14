package com.ankamagames.tiphon.types.cache
{
    import __AS3__.vec.Vector;
    import com.ankamagames.tiphon.types.ScriptedAnimation;
    import __AS3__.vec.*;

    public class AnimCache 
    {

        private var _directions:Vector.<Vector.<ScriptedAnimation>> = new Vector.<Vector.<ScriptedAnimation>>(8, true);
        private var _size:int;

        public function AnimCache()
        {
            this._directions[0] = new Vector.<ScriptedAnimation>();
            this._directions[1] = new Vector.<ScriptedAnimation>();
            this._directions[2] = new Vector.<ScriptedAnimation>();
            this._directions[3] = new Vector.<ScriptedAnimation>();
            this._directions[4] = new Vector.<ScriptedAnimation>();
            this._directions[5] = new Vector.<ScriptedAnimation>();
            this._directions[6] = new Vector.<ScriptedAnimation>();
            this._directions[7] = new Vector.<ScriptedAnimation>();
        }

        public function getAnimation(direction:int):ScriptedAnimation
        {
            var animList:Vector.<ScriptedAnimation> = this._directions[direction];
            if (animList.length)
            {
                return (animList.shift());
            };
            return (null);
        }

        public function pushAnimation(scriptedAnimation:ScriptedAnimation, direction:int):void
        {
            if (this._directions[scriptedAnimation.direction].length < 3)
            {
                this._directions[scriptedAnimation.direction].push(scriptedAnimation);
            };
        }

        public function get size():int
        {
            return (this._size);
        }


    }
} com.ankamagames.tiphon.types.cache

