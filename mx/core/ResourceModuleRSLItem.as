package mx.core
{
    import mx.resources.IResourceManager;
    import flash.system.ApplicationDomain;
    import flash.events.IEventDispatcher;
    import mx.events.ResourceEvent;
    import flash.events.IOErrorEvent;

    [ExcludeClass]
    public class ResourceModuleRSLItem extends RSLItem 
    {

        mx_internal static const VERSION:String = "4.16.1.0";
        public static var resourceManager:IResourceManager;

        private var appDomain:ApplicationDomain;

        public function ResourceModuleRSLItem(url:String, appDomain:ApplicationDomain)
        {
            super(url);
            this.appDomain = appDomain;
        }

        override public function load(progressHandler:Function, completeHandler:Function, ioErrorHandler:Function, securityErrorHandler:Function, rslErrorHandler:Function):void
        {
            var resourceManagerClass:Class;
            chainedProgressHandler = progressHandler;
            chainedCompleteHandler = completeHandler;
            chainedIOErrorHandler = ioErrorHandler;
            chainedSecurityErrorHandler = securityErrorHandler;
            chainedRSLErrorHandler = rslErrorHandler;
            if (!resourceManager)
            {
                if (this.appDomain.hasDefinition("mx.resources::ResourceManager"))
                {
                    resourceManagerClass = Class(this.appDomain.getDefinition("mx.resources::ResourceManager"));
                    resourceManager = IResourceManager(resourceManagerClass["getInstance"]());
                }
                else
                {
                    return;
                };
            };
            var eventDispatcher:IEventDispatcher = resourceManager.loadResourceModule(url);
            eventDispatcher.addEventListener(ResourceEvent.PROGRESS, itemProgressHandler);
            eventDispatcher.addEventListener(ResourceEvent.COMPLETE, itemCompleteHandler);
            eventDispatcher.addEventListener(ResourceEvent.ERROR, this.resourceErrorHandler);
        }

        private function resourceErrorHandler(event:ResourceEvent):void
        {
            var errorEvent:IOErrorEvent = new IOErrorEvent(IOErrorEvent.IO_ERROR);
            errorEvent.text = event.errorText;
            super.itemErrorHandler(errorEvent);
        }


    }
} mx.core

