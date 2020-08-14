package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.dofus.datacenter.documents.Document;

    [InstanciedApi]
    public class DocumentApi implements IApi 
    {

        protected var _log:Logger = Log.getLogger(getQualifiedClassName(DocumentApi));
        private var _module:UiModule;


        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        public function destroy():void
        {
            this._module = null;
        }

        public function getDocument(pDocId:uint):Object
        {
            return (Document.getDocumentById(pDocId));
        }

        public function getType(pDocId:uint):uint
        {
            return (Document.getDocumentById(pDocId).typeId);
        }


    }
} com.ankamagames.dofus.uiApi

