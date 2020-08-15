package Ankama_Document.ui
{
    import com.ankamagames.dofus.uiApi.SystemApi;
    import com.ankamagames.berilia.api.UiApi;
    import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
    import com.ankamagames.dofus.uiApi.MapApi;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.components.Input;
    import flash.text.TextFormat;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import flash.text.StyleSheet;
    import d2actions.QuestStartRequest;
    import d2actions.QuestObjectiveValidation;
    import d2hooks.AddMapFlag;
    import com.ankamagames.dofus.network.enums.CompassTypeEnum;
    import d2actions.LeaveDialogRequest;
    import Ankama_Document.data.ImageData;
    import __AS3__.vec.Vector;
    import Ankama_Document.data.LinkData;
    import com.ankamagames.berilia.components.Label;
    import __AS3__.vec.*;
    import d2hooks.*;
    import d2actions.*;

    public class DocumentBase 
    {

        private static var EXP_IMG:RegExp = /(.*?)(<img.*?\/?>)/gi;
        private static var EXP_DIESE:RegExp = /#+/g;
        private static var EXP_LINK:RegExp = /<a\shref=('|")(.*?)('|")\s*>(.*?)<\/a>/gi;
        private static const START_QUEST:String = "startquest";
        private static const VALIDATE_OBJECTIVE:String = "validateobjective";
        private static const GO_TO_COORDINATE:String = "map";
        private static const NAVIGATE_TO_URL:String = "url";

        [Api(name="SystemApi")]
        public var sysApi:SystemApi;
        [Api(name="UiApi")]
        public var uiApi:UiApi;
        [Api(name="PlayedCharacterApi")]
        public var playerApi:PlayedCharacterApi;
        [Api(name="MapApi")]
        public var mapApi:MapApi;
        private var _debugSprContainer:GraphicContainer;
        private var _rootDebugCtr:GraphicContainer;
        private var _debugTextField:Input;
        private var _debugTextFormat:TextFormat;
        private var _debugValidBtn:ButtonContainer;
        private var _debugCancelbtn:ButtonContainer;
        private var _debugCopyAllBtn:ButtonContainer;


        public static function replace(input:String, replace:String, replaceWith:String):String
        {
            var j:Number;
            var sb:String = new String();
            var found:Boolean;
            var sLen:Number = input.length;
            var rLen:Number = replace.length;
            var i:Number = 0;
            for (;i < sLen;i++)
            {
                if (input.charAt(i) == replace.charAt(0))
                {
                    found = true;
                    j = 0;
                    while (j < rLen)
                    {
                        if (input.charAt((i + j)) != replace.charAt(j))
                        {
                            found = false;
                            break;
                        };
                        j++;
                    };
                    if (found)
                    {
                        sb = (sb + replaceWith);
                        i = (i + (rLen - 1));
                        continue;
                    };
                };
                sb = (sb + input.charAt(i));
            };
            return (sb);
        }


        protected function overrideLinkStyleInCss(pStyleSheet:StyleSheet):void
        {
            var aStyle:Object = new Object();
            aStyle.color = "#AB4F22";
            aStyle.fontWeight = "bold";
            aStyle.textDecoration = "underline";
            pStyleSheet.setStyle("a", aStyle);
        }

        protected function linkHandler(textEvent:String):void
        {
            var px:int;
            var py:int;
            var param:Array = textEvent.split(",");
            if (param[0] == START_QUEST)
            {
                this.sysApi.sendAction(new QuestStartRequest(int(param[1])));
                this.closeMe();
            }
            else
            {
                if (param[0] == VALIDATE_OBJECTIVE)
                {
                    this.sysApi.sendAction(new QuestObjectiveValidation(int(param[1]), int(param[2])));
                    this.closeMe();
                }
                else
                {
                    if (param[0] == GO_TO_COORDINATE)
                    {
                        px = param[1];
                        py = param[2];
                        this.sysApi.dispatchHook(AddMapFlag, ((((("flag_srv" + CompassTypeEnum.COMPASS_TYPE_SIMPLE) + "_pos_") + px) + "_") + py), ((px + ",") + py), this.mapApi.getCurrentWorldMap().id, px, py, 0x558800, true);
                    }
                    else
                    {
                        if (param[0] == NAVIGATE_TO_URL)
                        {
                            this.sysApi.goToUrl(param[1]);
                        };
                    };
                };
            };
        }

        private function closeMe():void
        {
            this.sysApi.sendAction(new LeaveDialogRequest());
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        public function getImageData(page:String):ImageData
        {
            var imgData:ImageData = new ImageData();
            var exp:RegExp = new RegExp(EXP_IMG);
            var data:* = exp.exec(page);
            if (data == null)
            {
                return (null);
            };
            var imgBalise:String = data[2];
            if (imgBalise.charAt((imgBalise.length - 2)) != "/")
            {
                imgBalise = imgBalise.replace(">", "/>");
            };
            var imgXml:XML = new XML(imgBalise);
            var tmp:Array = imgXml.@src.split(",");
            var source:String = ((tmp[1] + ".") + tmp[0]);
            imgData.regExpResult = data[0];
            imgData.before = data[1];
            imgData.src = source.replace(EXP_DIESE, "");
            imgData.width = parseInt(imgXml.@width);
            imgData.height = parseInt(imgXml.@height);
            imgData.hspace = parseInt(imgXml.@hspace);
            imgData.align = imgXml.@align;
            imgData.x = imgXml.attribute("data-x");
            imgData.y = imgXml.attribute("data-y");
            return (imgData);
        }

        public function getAllImagesData(page:String):Vector.<ImageData>
        {
            var data:*;
            var images:Vector.<ImageData> = new Vector.<ImageData>();
            var exp:RegExp = new RegExp(EXP_IMG);
            while ((data = exp.exec(page)) != null)
            {
                images.push(this.getImageData(data[0]));
            };
            return (images);
        }

        public function getAllLinks(page:String):Vector.<LinkData>
        {
            var link:LinkData;
            var data:*;
            var links:Vector.<LinkData> = new Vector.<LinkData>();
            var exp:RegExp = new RegExp(EXP_LINK);
            while ((data = exp.exec(page)) != null)
            {
                link = new LinkData(data[4], data[2]);
                links.push(link);
            };
            return (links);
        }

        protected function formateText(t:String):String
        {
            var newText:String = t;
            while (newText.search("\n") != -1)
            {
                newText = newText.replace("\n", "");
            };
            while (newText.search("\r") != -1)
            {
                newText = newText.replace("\r", "");
            };
            return (newText);
        }

        public function getProperties(pProperties:String):Object
        {
            var i:int;
            var nbProperties:int;
            var prop:Array;
            if (!pProperties)
            {
                return (null);
            };
            var properties:Object = new Object();
            var propertiesList:Array = pProperties.split(";");
            if (propertiesList.length > 0)
            {
                nbProperties = propertiesList.length;
                i = 0;
                while (i < nbProperties)
                {
                    prop = propertiesList[i].split("=");
                    if (prop.length == 2)
                    {
                        properties[prop[0]] = prop[1];
                    };
                    i++;
                };
            };
            return (properties);
        }

        public function openDebugEditionPanel(pParentCtr:GraphicContainer, pHtmlText:String, pX:Number=0, pY:Number=0):void
        {
            var btnLbl:Label;
            var btnLbl2:Label;
            var btnLbl3:Label;
            if (this._rootDebugCtr == pParentCtr)
            {
                return;
            };
            this._rootDebugCtr = pParentCtr;
            if (this._debugSprContainer == null)
            {
                this._debugSprContainer = (this.uiApi.createContainer("GraphicContainer") as GraphicContainer);
                this._debugSprContainer.bgColor = 0xFFFFFF;
                this._debugSprContainer.borderColor = 0;
                this._debugSprContainer.width = 450;
                this._debugSprContainer.height = 550;
                this._debugTextField = (this.uiApi.createComponent("Input") as Input);
                this._debugTextField.multiline = true;
                this._debugTextField.wordWrap = true;
                this._debugTextField.selectable = true;
                this._debugTextField.mouseEnabled = false;
                this._debugTextField.textfield.mouseWheelEnabled = false;
                this._debugTextField.html = false;
                this._debugValidBtn = (this.uiApi.createContainer("ButtonContainer") as ButtonContainer);
                this._debugValidBtn.x = 60;
                this._debugValidBtn.y = 500;
                this._debugValidBtn.changingStateData = new Array();
                this._debugValidBtn.finalize();
                btnLbl = (this.uiApi.createComponent("Label") as Label);
                btnLbl.width = 50;
                btnLbl.height = 50;
                btnLbl.verticalAlign = "center";
                btnLbl.text = "VALID";
                this._debugValidBtn.addChild(btnLbl);
                this.uiApi.addComponentHook(this._debugValidBtn, "onRelease");
                this._debugCancelbtn = (this.uiApi.createContainer("ButtonContainer") as ButtonContainer);
                this._debugCancelbtn.x = 340;
                this._debugCancelbtn.y = 500;
                this._debugCancelbtn.changingStateData = new Array();
                this._debugCancelbtn.finalize();
                btnLbl2 = (this.uiApi.createComponent("Label") as Label);
                btnLbl2.width = 60;
                btnLbl2.height = 50;
                btnLbl2.verticalAlign = "center";
                btnLbl2.text = "CANCEL";
                this._debugCancelbtn.addChild(btnLbl2);
                this.uiApi.addComponentHook(this._debugCancelbtn, "onRelease");
                this._debugCopyAllBtn = (this.uiApi.createContainer("ButtonContainer") as ButtonContainer);
                this._debugCopyAllBtn.x = 150;
                this._debugCopyAllBtn.y = 500;
                this._debugCopyAllBtn.changingStateData = new Array();
                this._debugCopyAllBtn.finalize();
                btnLbl3 = (this.uiApi.createComponent("Label") as Label);
                btnLbl3.width = 130;
                btnLbl3.height = 50;
                btnLbl3.verticalAlign = "center";
                btnLbl3.text = "COPY TO CLIPBOARD";
                this._debugCopyAllBtn.addChild(btnLbl3);
                this.uiApi.addComponentHook(this._debugCopyAllBtn, "onRelease");
                this._debugSprContainer.addChild(this._debugTextField);
                this._debugSprContainer.addChild(this._debugValidBtn);
                this._debugSprContainer.addChild(this._debugCopyAllBtn);
                this._debugSprContainer.addChild(this._debugCancelbtn);
            };
            this._debugTextField.text = replace(pHtmlText, "> <", ">\n <");
            this._debugTextField.height = 800;
            this._debugTextField.fullSize(400);
            this._debugTextField.finalize();
            this._debugSprContainer.x = pX;
            this._debugSprContainer.y = pY;
            pParentCtr.addChild(this._debugSprContainer);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this._debugCancelbtn:
                    this.hideDebugEditionPanel();
                    break;
                case this._debugValidBtn:
                    this.updateDocumentContent(this._rootDebugCtr, this._debugTextField.text);
                    break;
                case this._debugCopyAllBtn:
                    this.copyAllDataToClipBoard();
                    break;
            };
        }

        public function copyAllDataToClipBoard():void
        {
        }

        public function hideDebugEditionPanel():void
        {
            if (((!(this._debugSprContainer == null)) && (!(this._rootDebugCtr == null))))
            {
                this._rootDebugCtr.removeChild(this._debugSprContainer);
                this._rootDebugCtr = null;
            };
        }

        public function updateDocumentContent(pParentCtr:GraphicContainer, pNewText:String):void
        {
        }

        public function debugModeIsOpen():Boolean
        {
            return (!(this._rootDebugCtr == null));
        }


    }
}

