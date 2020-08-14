package Ankama_Document
{
    import flash.display.Sprite;
    import Ankama_Document.ui.ReadingBook;
    import Ankama_Document.ui.Scroll;
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.DocumentApi;
    import d2hooks.DocumentReadingBegin;

    public class Document extends Sprite 
    {

        private static const TYPE_BOOK:uint = 1;
        private static const TYPE_SCROLL:uint = 2;

        protected var readingBook:ReadingBook;
        protected var scroll:Scroll;
        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="DocumentApi")]
        public var docApi:DocumentApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;


        public function main():void
        {
            this.sysApi.addHook(DocumentReadingBegin, this.onDocumentReadingBegin);
        }

        private function onDocumentReadingBegin(documentId:uint):void
        {
            var typeId:uint = this.docApi.getType(documentId);
            switch (typeId)
            {
                case TYPE_BOOK:
                    if (!this.uiApi.getUi("readingBook"))
                    {
                        this.uiApi.loadUi("readingBook", "readingBook", {"documentId":documentId});
                    };
                    break;
                case TYPE_SCROLL:
                    if (!this.uiApi.getUi("scroll2"))
                    {
                        this.uiApi.loadUi("scroll2", "scroll", {"documentId":documentId});
                    };
                    break;
            };
        }


    }
} Ankama_Document

