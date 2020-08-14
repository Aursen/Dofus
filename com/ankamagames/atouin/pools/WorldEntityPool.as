package com.ankamagames.atouin.pools
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.pools.Poolable;
    import com.ankamagames.atouin.types.WorldEntitySprite;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.jerakine.JerakineConstants;
    import __AS3__.vec.*;

    public class WorldEntityPool 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(WorldEntityPool));
        private static var pool:Vector.<Poolable>;
        private static var GROW_SIZE:int;
        private static var WARN_LIMIT:int;
        private static var TOTAL_SIZE:int;
        private static var counter:uint;
        private static var currentWorldEntity:WorldEntitySprite;


        public static function init(initialSize:int, growSize:int, warnLimit:int=0):void
        {
            GROW_SIZE = growSize;
            WARN_LIMIT = warnLimit;
            TOTAL_SIZE = initialSize;
            counter = initialSize;
            var i:uint = initialSize;
            pool = new Vector.<Poolable>(TOTAL_SIZE);
            while (--i > -1)
            {
                pool[i] = new WorldEntitySprite(new TiphonEntityLook("{666}"), -1, -1);
            };
        }

        public static function checkOut(look:TiphonEntityLook, cellId:int, identifier:int):Poolable
        {
            if (pool == null)
            {
                init(JerakineConstants.WORLD_ENTITY_POOL_INITIAL_SIZE, JerakineConstants.WORLD_ENTITY_POOL_GROW_SIZE, JerakineConstants.WORLD_ENTITY_POOL_WARN_LIMIT);
            };
            if (counter > 0)
            {
                currentWorldEntity = (pool[--counter] as WorldEntitySprite);
                currentWorldEntity.initialize(look, cellId, identifier);
                return (currentWorldEntity);
            };
            var i:uint = GROW_SIZE;
            while (--i > -1)
            {
                pool.unshift(new WorldEntitySprite(new TiphonEntityLook("{666}"), -1, -1));
            };
            TOTAL_SIZE = (TOTAL_SIZE + GROW_SIZE);
            counter = GROW_SIZE;
            if (TOTAL_SIZE > WARN_LIMIT)
            {
                _log.warn((("WorldEntityPool has reached the limit (size : " + WARN_LIMIT) + ")"));
            };
            return (checkOut(look, cellId, identifier));
        }

        public static function checkIn(freedObject:Poolable):void
        {
            if (!freedObject)
            {
                return;
            };
            freedObject.free();
            var _local_2:* = counter++;
            pool[_local_2] = freedObject;
        }


    }
} com.ankamagames.atouin.pools

