package com.ankamagames.jerakine.pools
{
    import flash.utils.Dictionary;

    public class GenericPool 
    {

        private static var _pools:Dictionary = new Dictionary();


        public static function get(_arg_1:Class, ... args):*
        {
            if (((_pools[_arg_1]) && (_pools[_arg_1].length)))
            {
                return (_arg_1["create"].apply(null, args.concat(_pools[_arg_1].pop())));
            };
            return (_arg_1["create"].apply(null, args));
        }

        public static function free(target:Poolable):void
        {
            target.free();
            var _local_2:Class = Object(target).constructor;
            if (!_pools[_local_2])
            {
                _pools[_local_2] = new Array();
            };
            (_pools[_local_2] as Array).push(target);
        }


    }
}

