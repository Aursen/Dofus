package com.ankamagames.jerakine.resources.protocols
{
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.resources.protocols.impl.HttpProtocol;
    import com.ankamagames.jerakine.resources.protocols.impl.FileProtocol;
    import com.ankamagames.jerakine.resources.protocols.impl.ZipProtocol;
    import com.ankamagames.jerakine.resources.protocols.impl.PakProtocol2;
    import com.ankamagames.jerakine.resources.protocols.impl.PakProtocol;
    import com.ankamagames.jerakine.resources.ResourceError;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.resources.protocols.impl.*;

    public class ProtocolFactory 
    {

        private static var _customProtocols:Dictionary = new Dictionary();


        public static function getProtocol(uri:Uri):IProtocol
        {
            var cp:*;
            switch (uri.protocol)
            {
                case "http":
                case "https":
                    return (new HttpProtocol());
                case "file":
                    return (new FileProtocol());
                case "zip":
                    return (new ZipProtocol());
                case "pak":
                case "pak2":
                case "d2p":
                    return (new PakProtocol2());
                case "d2pOld":
                    return (new PakProtocol());
            };
            var customProtocol:Class = (_customProtocols[uri.protocol] as Class);
            if (customProtocol)
            {
                cp = new (customProtocol)();
                if (!(cp is IProtocol))
                {
                    throw (new ResourceError((("Registered custom protocol for extension " + uri.protocol) + " isn't an IProtocol class.")));
                };
                return (cp);
            };
            throw (new ArgumentError((((("Unknown protocol '" + uri.protocol) + "' in the URI '") + uri) + "'.")));
        }

        public static function addProtocol(protocolName:String, protocolClass:Class):void
        {
            _customProtocols[protocolName] = protocolClass;
        }

        public static function removeProtocol(protocolName:String):void
        {
            delete _customProtocols[protocolName];
        }


    }
}

