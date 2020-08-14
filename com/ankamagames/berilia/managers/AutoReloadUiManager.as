package com.ankamagames.berilia.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.types.data.UiData;
    import __AS3__.vec.Vector;
    import com.adobe.air.filesystem.FileMonitor;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.types.Uri;
    import flash.filesystem.File;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.adobe.air.filesystem.events.FileMonitorEvent;
    import flash.filesystem.FileStream;
    import flash.filesystem.FileMode;
    import com.ankamagames.jerakine.managers.LangManager;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.jerakine.types.Callback;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.tooltip.TooltipBlock;
    import com.ankamagames.berilia.Berilia;
    import flash.display.Stage;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import __AS3__.vec.*;

    public class AutoReloadUiManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AutoReloadUiManager));

        private const _regImport:RegExp = /<Import *url="([^"]*)/gm;

        private var _uiData:UiData;
        private var _fileMonitors:Vector.<FileMonitor> = new Vector.<FileMonitor>();
        private var _componentsSnapShot:Dictionary;
        private var _scriptParams:Dictionary;
        private var _fileMonitorRef:Dictionary = new Dictionary();

        public function AutoReloadUiManager(uiData:UiData)
        {
            var fm:FileMonitor;
            super();
            this._uiData = uiData;
            var f:File = new Uri(uiData.file).toFile();
            this.watchFile(f);
            this.detectImport(f, new Dictionary());
            var watchedFile:Array = [];
            for each (fm in this._fileMonitors)
            {
                watchedFile.push(fm.file.name);
            };
            if (this._uiData.name.indexOf("tooltip_") == -1)
            {
                _log.info(((this._uiData.name + " watch ") + watchedFile.join(", ")));
            };
        }

        public static function create(uiName:String):AutoReloadUiManager
        {
            var module:UiModule;
            var data:UiData;
            for each (module in UiModuleManager.getInstance().getModules())
            {
                data = module.getUi(uiName);
                if (data)
                {
                    return (new AutoReloadUiManager(data));
                };
            };
            return (null);
        }


        public function destroy():void
        {
            var fm:FileMonitor;
            for each (fm in this._fileMonitors)
            {
                fm.removeEventListener(FileMonitorEvent.CHANGE, this.onXmlChange);
            };
            this._fileMonitors = null;
            this._componentsSnapShot = null;
            this._scriptParams = null;
        }

        private function detectImport(target:File, proceededImport:Dictionary):void
        {
            var template:String;
            var templateFile:File;
            if (!target.exists)
            {
                return;
            };
            var fs:FileStream = new FileStream();
            fs.open(target, FileMode.READ);
            var content:String = fs.readUTFBytes(fs.bytesAvailable);
            fs.close();
            var results:Array = content.match(this._regImport);
            for each (template in results)
            {
                templateFile = new Uri(LangManager.getInstance().replaceKey(template.substr((template.indexOf('"') + 1)))).toFile();
                if (!proceededImport[templateFile.nativePath])
                {
                    proceededImport[templateFile.nativePath] = true;
                    this.watchFile(templateFile);
                    this.detectImport(target, proceededImport);
                };
            };
        }

        private function watchFile(f:File):void
        {
            var fm:FileMonitor;
            if (!this._fileMonitorRef[f.nativePath])
            {
                this._fileMonitorRef[f.nativePath] = true;
                fm = new FileMonitor(f);
                fm.addEventListener(FileMonitorEvent.CHANGE, this.onXmlChange);
                this._fileMonitors.push(fm);
                fm.watch();
            };
        }

        protected function onXmlChange(event:FileMonitorEvent):void
        {
            var urc:UiRootContainer;
            var instruction:Callback;
            var parent:DisplayObjectContainer;
            var scriptParams:*;
            var parentContainer:GraphicContainer;
            var newContainer:UiRootContainer;
            UiRenderManager.getInstance().clearCacheFromId(this._uiData.file);
            CssManager.clear(true);
            TooltipManager.clearCache();
            TooltipBlock.clearCache();
            var _loadInstruction:Vector.<Callback> = new Vector.<Callback>();
            for each (urc in Berilia.getInstance().uiList)
            {
                if (urc.uiData == this._uiData)
                {
                    parent = urc;
                    do 
                    {
                    } while (((((!(parent is Stage)) && (!(parent == null))) && (parent = parent.parent)) && (!(parent is GraphicContainer))));
                    scriptParams = urc.properties;
                    if ((parent is GraphicContainer))
                    {
                        parentContainer = (parent as GraphicContainer);
                        newContainer = new UiRootContainer(StageShareManager.stage, this._uiData);
                        newContainer.uiModule = urc.uiModule;
                        newContainer.strata = parentContainer.getUi().strata;
                        newContainer.restoreSnapshotAfterLoading = parentContainer.getUi().restoreSnapshotAfterLoading;
                        newContainer.depth = (parentContainer.getUi().depth + 1);
                        parentContainer.addChild(newContainer);
                        _loadInstruction.push(new Callback(Berilia.getInstance().loadUiInside, this._uiData, urc.name, newContainer, parentContainer, scriptParams, true));
                    }
                    else
                    {
                        _loadInstruction.push(new Callback(Berilia.getInstance().loadUi, urc.uiModule, this._uiData, urc.name, scriptParams, true));
                    };
                };
            };
            for each (instruction in _loadInstruction)
            {
                instruction.exec();
            };
        }


    }
} com.ankamagames.berilia.managers

