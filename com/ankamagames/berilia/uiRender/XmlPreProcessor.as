package com.ankamagames.berilia.uiRender
{
    import flash.events.EventDispatcher;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.xml.XMLDocument;
    import com.ankamagames.berilia.managers.TemplateManager;
    import com.ankamagames.berilia.types.event.TemplateLoadedEvent;
    import com.ankamagames.berilia.types.event.PreProcessEndEvent;
    import flash.xml.XMLNode;
    import com.ankamagames.berilia.enums.XmlTagsEnum;
    import com.ankamagames.berilia.enums.XmlAttributesEnum;
    import com.ankamagames.jerakine.managers.LangManager;
    import com.ankamagames.jerakine.utils.files.FileUtils;
    import com.ankamagames.berilia.types.template.TemplateParam;

    public class XmlPreProcessor extends EventDispatcher 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(XmlPreProcessor));

        private var _xDoc:XMLDocument;
        private var _bMustBeRendered:Boolean = true;
        private var _aImportFile:Array;

        public function XmlPreProcessor(xDoc:XMLDocument)
        {
            this._xDoc = xDoc;
        }

        public function get importedFiles():int
        {
            return (this._aImportFile.length);
        }

        public function processTemplate():void
        {
            this._aImportFile = [];
            TemplateManager.getInstance().addEventListener(TemplateLoadedEvent.EVENT_TEMPLATE_LOADED, this.onTemplateLoaded);
            this.matchImport(this._xDoc.firstChild);
            if (!this._aImportFile.length)
            {
                dispatchEvent(new PreProcessEndEvent(this));
                TemplateManager.getInstance().removeEventListener(TemplateLoadedEvent.EVENT_TEMPLATE_LOADED, this.onTemplateLoaded);
                return;
            };
            var i:uint;
            while (i < this._aImportFile.length)
            {
                TemplateManager.getInstance().register(this._aImportFile[i]);
                i++;
            };
        }

        private function matchImport(node:XMLNode):void
        {
            var currNode:XMLNode;
            if (node == null)
            {
                return;
            };
            var i:uint;
            while (i < node.childNodes.length)
            {
                currNode = node.childNodes[i];
                if (currNode.nodeName == XmlTagsEnum.TAG_IMPORT)
                {
                    if (currNode.attributes[XmlAttributesEnum.ATTRIBUTE_URL] == null)
                    {
                        _log.warn((((("Attribute '" + XmlAttributesEnum.ATTRIBUTE_URL) + "' is missing in ") + XmlTagsEnum.TAG_IMPORT) + " tag."));
                    }
                    else
                    {
                        this._aImportFile.push(LangManager.getInstance().replaceKey(currNode.attributes[XmlAttributesEnum.ATTRIBUTE_URL]));
                    };
                    currNode.removeNode();
                    i--;
                }
                else
                {
                    if (currNode != null)
                    {
                        this.matchImport(currNode);
                    };
                };
                i++;
            };
        }

        private function replaceTemplateCall(node:XMLNode, depthRecursion:int=0):Boolean
        {
            var currNode:XMLNode;
            var currVarNode:XMLNode;
            var templateNode:XMLNode;
            var insertedNode:XMLNode;
            var childNodes:Array;
            var j:uint;
            var s:String;
            var n:uint;
            var sFileName:String;
            var aTemplateVar:Array;
            var currAttributes:Object;
            var content:String;
            var varNode:XMLNode;
            var bRes:Boolean;
            if (depthRecursion > 128)
            {
                _log.error(("replaceTemplateCall : Recursion depth is too high :" + depthRecursion));
                return (bRes);
            };
            var i:uint;
            while (i < node.childNodes.length)
            {
                currNode = node.childNodes[i];
                j = 0;
                while (j < this._aImportFile.length)
                {
                    if (this._aImportFile[j].indexOf(currNode.nodeName) == -1)
                    {
                    }
                    else
                    {
                        sFileName = FileUtils.getFileStartName(this._aImportFile[j]);
                        if (sFileName == currNode.nodeName)
                        {
                            aTemplateVar = [];
                            currAttributes = currNode.attributes;
                            for (s in currAttributes)
                            {
                                aTemplateVar[s] = new TemplateParam(s, currAttributes[s]);
                            };
                            childNodes = currNode.childNodes;
                            n = 0;
                            while (n < childNodes.length)
                            {
                                currVarNode = childNodes[n];
                                content = "";
                                for each (varNode in currVarNode.childNodes)
                                {
                                    content = (content + varNode);
                                };
                                aTemplateVar[currVarNode.nodeName] = new TemplateParam(currVarNode.nodeName, content);
                                n++;
                            };
                            templateNode = TemplateManager.getInstance().getTemplate(sFileName).makeTemplate(aTemplateVar);
                            childNodes = templateNode.firstChild.childNodes;
                            n = 0;
                            while (n < childNodes.length)
                            {
                                insertedNode = childNodes[n].cloneNode(true);
                                currNode.parentNode.insertBefore(insertedNode, currNode);
                                n++;
                            };
                            currNode.removeNode();
                            currNode = node.childNodes[i];
                            bRes = true;
                        };
                    };
                    j++;
                };
                bRes = ((this.replaceTemplateCall(currNode, (depthRecursion + 1))) || (bRes));
                i++;
            };
            return (bRes);
        }

        private function onTemplateLoaded(e:TemplateLoadedEvent):void
        {
            if (((TemplateManager.getInstance().areLoaded(this._aImportFile)) && (this._bMustBeRendered)))
            {
                this._bMustBeRendered = this.replaceTemplateCall(this._xDoc.firstChild);
                if (this._bMustBeRendered)
                {
                    this.processTemplate();
                }
                else
                {
                    dispatchEvent(new PreProcessEndEvent(this));
                    TemplateManager.getInstance().removeEventListener(TemplateLoadedEvent.EVENT_TEMPLATE_LOADED, this.onTemplateLoaded);
                };
            };
        }


    }
}

