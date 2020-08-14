package com.ankamagames.atouin.resources.adapters
{
    import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
    import com.ankamagames.jerakine.resources.adapters.IAdapter;
    import com.ankamagames.atouin.data.map.TacticalModeTemplate;
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;
    import flash.errors.IOError;
    import com.ankamagames.jerakine.resources.ResourceErrorCode;
    import com.ankamagames.atouin.resources.AtouinResourceType;
    import flash.net.URLLoaderDataFormat;

    public class TacticalTemplatesAdapter extends AbstractUrlLoaderAdapter implements IAdapter 
    {


        override protected function getResource(dataFormat:String, data:*):*
        {
            var template:TacticalModeTemplate;
            var templates:Dictionary = new Dictionary();
            var ba:ByteArray = (data as ByteArray);
            var header:int = ba.readByte();
            if (header != 84)
            {
                ba.position = 0;
                try
                {
                    ba.uncompress();
                }
                catch(ioe:IOError)
                {
                    dispatchFailure(ioe.message, ResourceErrorCode.MALFORMED_MAP_FILE);
                    return (null);
                };
                header = ba.readByte();
                if (header != 84)
                {
                    dispatchFailure("Wrong header file.", ResourceErrorCode.MALFORMED_MAP_FILE);
                    return (null);
                };
            };
            var version:int = ba.readByte();
            var numTemplates:uint = ba.readInt();
            var i:int;
            while (i < numTemplates)
            {
                template = new TacticalModeTemplate();
                template.fromRaw(ba);
                templates[template.id] = template;
                i = (i + 1);
            };
            return (templates);
        }

        override public function getResourceType():uint
        {
            return (AtouinResourceType.TACTICAL_TEMPLATES);
        }

        override protected function getDataFormat():String
        {
            return (URLLoaderDataFormat.BINARY);
        }


    }
} com.ankamagames.atouin.resources.adapters

