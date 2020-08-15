package flashx.textLayout.conversion
{
    import flashx.textLayout.tlf_internal;
    import flashx.textLayout.elements.Configuration;
    import flash.system.System;
    import flashx.textLayout.elements.FlowElement;
    import flashx.textLayout.elements.SpanElement;
    import flashx.textLayout.elements.FlowGroupElement;
    import flashx.textLayout.elements.ParagraphFormattedElement;
    import flashx.textLayout.elements.ContainerFormattedElement;
    import flashx.textLayout.elements.TableElement;
    import flashx.textLayout.elements.TableRowElement;
    import flashx.textLayout.elements.TableCellElement;
    import flashx.textLayout.formats.TextLayoutFormat;
    import flashx.textLayout.TextLayoutVersion;
    import flashx.textLayout.elements.TextFlow;
    import flash.utils.getQualifiedClassName;

    use namespace tlf_internal;

    public class BaseTextLayoutExporter extends ConverterBase implements ITextExporter 
    {

        private static const brRegEx:RegExp = / /;

        private var _rootTag:XML;
        private var _ns:Namespace;

        public function BaseTextLayoutExporter(ns:Namespace, rootTag:XML, configuration:ImportExportConfiguration)
        {
            config = configuration;
            this._ns = ns;
            this._rootTag = rootTag;
        }

        tlf_internal static function convertXMLToString(xml:XML):String
        {
            var result:String;
            var originalSettings:Object;
            originalSettings = XML.settings();
            try
            {
                XML.ignoreProcessingInstructions = false;
                XML.ignoreWhitespace = false;
                XML.prettyPrinting = false;
                result = xml.toXMLString();
                if (Configuration.playerEnablesArgoFeatures)
                {
                    var _local_3:* = System;
                    (_local_3["disposeXML"](xml));
                };
                XML.setSettings(originalSettings);
            }
            catch(e:Error)
            {
                XML.setSettings(originalSettings);
                throw (e);
            };
            return (result);
        }

        public static function exportFlowElement(exporter:BaseTextLayoutExporter, flowElement:FlowElement):XMLList
        {
            return (exporter.protected::exportFlowElement(flowElement));
        }

        public static function exportSpanText(destination:XML, span:SpanElement, replacementRegex:RegExp, replacementXMLCallback:Function):void
        {
            var dummy:XML;
            var ix:int;
            var tempStr:String;
            var replacementXML:XML;
            var spanText:String = span.text;
            var matchLocation:Array = spanText.match(replacementRegex);
            if (matchLocation)
            {
                while (matchLocation != null)
                {
                    ix = matchLocation.index;
                    tempStr = spanText.substr(0, ix);
                    if (tempStr.length > 0)
                    {
                        dummy = <dummy/>
                        ;
                        dummy.appendChild(tempStr);
                        destination.appendChild(dummy.text()[0]);
                    };
                    replacementXML = replacementXMLCallback(spanText.charAt(ix));
                    destination.appendChild(replacementXML);
                    spanText = spanText.slice((ix + 1), spanText.length);
                    matchLocation = spanText.match(replacementRegex);
                    if (((!(matchLocation)) && (spanText.length > 0)))
                    {
                        dummy = <dummy/>
                        ;
                        dummy.appendChild(spanText);
                        destination.appendChild(dummy.text()[0]);
                    };
                };
            }
            else
            {
                destination.appendChild(spanText);
            };
        }

        public static function exportSpan(exporter:BaseTextLayoutExporter, span:SpanElement):XMLList
        {
            var output:XMLList = public::exportFlowElement(exporter, span);
            exportSpanText(output[0], span, exporter.spanTextReplacementRegex, exporter.getSpanTextReplacementXML);
            return (output);
        }

        public static function exportFlowGroupElement(exporter:BaseTextLayoutExporter, flowBlockElement:FlowGroupElement):XMLList
        {
            var index:int;
            var flowChild:FlowElement;
            var childXML:XMLList;
            var output:XMLList = public::exportFlowElement(exporter, flowBlockElement);
            var count:int = flowBlockElement.numChildren;
            while (index < count)
            {
                flowChild = flowBlockElement.getChildAt(index);
                childXML = exporter.exportChild(flowChild);
                if (childXML)
                {
                    output.appendChild(childXML);
                };
                index++;
            };
            return (output);
        }

        public static function exportParagraphFormattedElement(exporter:BaseTextLayoutExporter, flowParagraph:ParagraphFormattedElement):XMLList
        {
            return (exporter.protected::exportParagraphFormattedElement(flowParagraph));
        }

        public static function exportList(exporter:BaseTextLayoutExporter, flowParagraph:ParagraphFormattedElement):XMLList
        {
            return (exporter.protected::exportList(flowParagraph));
        }

        public static function exportListItem(exporter:BaseTextLayoutExporter, flowParagraph:ParagraphFormattedElement):XMLList
        {
            return (exporter.protected::exportListItem(flowParagraph));
        }

        public static function exportContainerFormattedElement(exporter:BaseTextLayoutExporter, container:ContainerFormattedElement):XMLList
        {
            return (exporter.protected::exportContainerFormattedElement(container));
        }

        public static function exportTableElement(exporter:BaseTextLayoutExporter, table:TableElement):XMLList
        {
            return (exporter.protected::exportTableElement(table));
        }

        public static function exportTableRowElement(exporter:BaseTextLayoutExporter, tableRow:TableRowElement):XMLList
        {
            return (exporter.protected::exportTableRowElement(tableRow));
        }

        public static function exportTableCellElement(exporter:BaseTextLayoutExporter, tableCell:TableCellElement):XMLList
        {
            return (exporter.protected::exportTableCellElement(tableCell));
        }

        public static function exportTextFlow(exporter:BaseTextLayoutExporter, textFlow:TextFlow):XMLList
        {
            var output:XMLList = public::exportContainerFormattedElement(exporter, textFlow);
            if (exporter.config.whiteSpaceCollapse)
            {
                output.@[TextLayoutFormat.whiteSpaceCollapseProperty.name] = exporter.config.whiteSpaceCollapse;
            };
            output.@["version"] = TextLayoutVersion.getVersionString(TextLayoutVersion.CURRENT_VERSION);
            return (output);
        }


        public function export(source:TextFlow, conversionType:String):Object
        {
            clear();
            var result:XML = this.exportToXML(source);
            return ((conversionType == ConversionType.STRING_TYPE) ? convertXMLToString(result) : result);
        }

        protected function exportToXML(textFlow:TextFlow):XML
        {
            var result:XML;
            if (this._rootTag)
            {
                result = new XML(this._rootTag);
                result.addNamespace(this._ns);
                result.appendChild(this.exportChild(textFlow));
            }
            else
            {
                result = XML(exportTextFlow(this, textFlow));
                result.addNamespace(this._ns);
            };
            return (result);
        }

        protected function exportFlowElement(flowElement:FlowElement):XMLList
        {
            var className:String = getQualifiedClassName(flowElement);
            var elementName:String = config.lookupName(className);
            var output:XML = new (XML)((("<" + elementName) + "/>"));
            output.setNamespace(this._ns);
            return (XMLList(output));
        }

        protected function get spanTextReplacementRegex():RegExp
        {
            return (brRegEx);
        }

        protected function getSpanTextReplacementXML(ch:String):XML
        {
            var breakXML:XML = <br/>
            ;
            breakXML.setNamespace(this.flowNS);
            return (breakXML);
        }

        protected function exportList(flowElement:FlowElement):XMLList
        {
            var index:int;
            var flowChild:FlowElement;
            var result:XMLList = this.protected::exportFlowElement(flowElement);
            var count:int = FlowGroupElement(flowElement).numChildren;
            while (index < count)
            {
                flowChild = FlowGroupElement(flowElement).getChildAt(index);
                result.appendChild(this.exportChild(flowChild));
                index++;
            };
            return (result);
        }

        protected function exportListItem(flowElement:FlowElement):XMLList
        {
            var index:int;
            var flowChild:FlowElement;
            var result:XMLList = this.protected::exportFlowElement(flowElement);
            var count:int = FlowGroupElement(flowElement).numChildren;
            while (index < count)
            {
                flowChild = FlowGroupElement(flowElement).getChildAt(index);
                result.appendChild(this.exportChild(flowChild));
                index++;
            };
            return (result);
        }

        protected function exportContainerFormattedElement(flowElement:FlowElement):XMLList
        {
            return (this.protected::exportParagraphFormattedElement(flowElement));
        }

        protected function exportTableElement(tableElement:TableElement):XMLList
        {
            var flowChild:FlowElement;
            var result:XMLList = this.protected::exportFlowElement(tableElement);
            var count:int = tableElement.numRows;
            var index:int;
            while (index < count)
            {
                flowChild = tableElement.getRowAt(index);
                result.appendChild(this.exportChild(flowChild));
                index++;
            };
            return (result);
        }

        protected function exportTableRowElement(tableRowElement:TableRowElement):XMLList
        {
            var index:int;
            var flowChild:FlowElement;
            var result:XMLList = this.protected::exportFlowElement(tableRowElement);
            var count:int = tableRowElement.numCells;
            while (index < count)
            {
                flowChild = tableRowElement.getCellAt(index);
                result.appendChild(this.exportChild(flowChild));
                index++;
            };
            return (result);
        }

        protected function exportTableCellElement(tableCellElement:TableCellElement):XMLList
        {
            var result:XMLList = this.protected::exportFlowElement(tableCellElement);
            return (result);
        }

        protected function exportParagraphFormattedElement(flowElement:FlowElement):XMLList
        {
            var index:int;
            var flowChild:FlowElement;
            var result:XMLList = this.protected::exportFlowElement(flowElement);
            var count:int = ParagraphFormattedElement(flowElement).numChildren;
            while (index < count)
            {
                flowChild = ParagraphFormattedElement(flowElement).getChildAt(index);
                result.appendChild(this.exportChild(flowChild));
                index++;
            };
            return (result);
        }

        public function exportChild(flowElement:FlowElement):XMLList
        {
            var className:String = getQualifiedClassName(flowElement);
            var info:FlowElementInfo = config.lookupByClass(className);
            if (info != null)
            {
                return (info.exporter(this, flowElement));
            };
            return (null);
        }

        protected function exportStyles(xml:XMLList, sortableStyles:Array):void
        {
            var exportInfo:Object;
            var xmlVal:Object;
            sortableStyles.sortOn("xmlName");
            for each (exportInfo in sortableStyles)
            {
                xmlVal = exportInfo.xmlVal;
                if (((!(useClipboardAnnotations)) && (exportInfo.xmlName == ConverterBase.MERGE_TO_NEXT_ON_PASTE)))
                {
                }
                else
                {
                    if ((xmlVal is String))
                    {
                        xml.@[exportInfo.xmlName] = xmlVal;
                    }
                    else
                    {
                        if ((xmlVal is XMLList))
                        {
                            xml.appendChild(xmlVal);
                        };
                    };
                };
            };
        }

        internal function get flowNS():Namespace
        {
            return (this._ns);
        }

        protected function get formatDescription():Object
        {
            return (null);
        }


    }
}

