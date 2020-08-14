package com.ankamagames.dofus.misc.utils
{
    import mx.core.MovieClipLoaderAsset;
    import flash.utils.ByteArray;

    public class LoadingScreen__progessAnim extends MovieClipLoaderAsset 
    {

        private static var bytes:ByteArray = null;

        public var dataClass:Class = LoadingScreen__progessAnim_dataClass;

        public function LoadingScreen__progessAnim()
        {
            initialWidth = (400 / 20);
            initialHeight = (400 / 20);
        }

        override public function get movieClipData():ByteArray
        {
            if (bytes == null)
            {
                bytes = ByteArray(new this.dataClass());
            };
            return (bytes);
        }


    }
} com.ankamagames.dofus.misc.utils

