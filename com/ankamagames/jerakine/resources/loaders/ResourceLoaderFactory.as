package com.ankamagames.jerakine.resources.loaders
{
    import com.ankamagames.jerakine.resources.loaders.impl.ParallelRessourceLoader;
    import com.ankamagames.jerakine.JerakineConstants;
    import com.ankamagames.jerakine.resources.loaders.impl.SingleRessourceLoader;

    public class ResourceLoaderFactory 
    {


        public static function getLoader(_arg_1:uint):IResourceLoader
        {
            switch (_arg_1)
            {
                case ResourceLoaderType.PARALLEL_LOADER:
                    return (new ParallelRessourceLoader(JerakineConstants.MAX_PARALLEL_LOADINGS));
                case ResourceLoaderType.SERIAL_LOADER:
                    return (new ParallelRessourceLoader(1));
                case ResourceLoaderType.SINGLE_LOADER:
                    return (new SingleRessourceLoader());
            };
            throw (new ArgumentError((("Unknown loader type " + _arg_1) + ".")));
        }


    }
} com.ankamagames.jerakine.resources.loaders

