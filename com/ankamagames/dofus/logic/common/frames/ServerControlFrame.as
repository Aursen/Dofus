package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.utils.crypto.SignatureKey;
    import flash.utils.ByteArray;
    import com.hurlant.crypto.rsa.RSAKey;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.hurlant.util.der.PEM;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.security.RawDataMessage;
    import com.ankamagames.jerakine.utils.crypto.Signature;
    import com.ankamagames.dofus.network.messages.game.script.URLOpenMessage;
    import com.ankamagames.dofus.datacenter.misc.Url;
    import com.ankamagames.dofus.network.messages.secure.TrustStatusMessage;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.connection.frames.AuthentificationFrame;
    import by.blooddy.crypto.MD5;
    import flash.events.UncaughtErrorEvent;
    import com.ankamagames.jerakine.managers.ErrorManager;
    import flash.system.ApplicationDomain;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.types.enums.WebLocationEnum;
    import com.ankamagames.dofus.logic.shield.SecureModeManager;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.jerakine.messages.Message;

    public class ServerControlFrame implements Frame 
    {

        private static const PUBLIC_KEY_V1:Class = ServerControlFrame_PUBLIC_KEY_V1;
        private static const SIGNATURE_KEY_V1:SignatureKey = SignatureKey.fromByte((new PUBLIC_KEY_V1() as ByteArray));
        private static const PUBLIC_KEY_V2:Class = ServerControlFrame_PUBLIC_KEY_V2;
        private static var SIGNATURE_KEY_V2:RSAKey;
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerControlFrame));

        public function ServerControlFrame()
        {
            var rawPem:ByteArray = (new PUBLIC_KEY_V2() as ByteArray);
            SIGNATURE_KEY_V2 = PEM.readRSAPublicKey(rawPem.readUTFBytes(rawPem.bytesAvailable));
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var rdMsg:RawDataMessage;
            var content:ByteArray;
            var signature:Signature;
            var urlmsg:URLOpenMessage;
            var urlData:Url;
            var tsMsg:TrustStatusMessage;
            var l:Loader;
            var lc:LoaderContext;
            switch (true)
            {
                case (msg is RawDataMessage):
                    rdMsg = (msg as RawDataMessage);
                    if (Kernel.getWorker().contains(AuthentificationFrame))
                    {
                        _log.error("Impossible de traiter le paquet RawDataMessage durant cette phase.");
                        return (false);
                    };
                    content = new ByteArray();
                    signature = new Signature(SIGNATURE_KEY_V1, SIGNATURE_KEY_V2);
                    _log.info(((("Bytecode len: " + rdMsg.content.length) + ", hash: ") + MD5.hashBytes(rdMsg.content)));
                    rdMsg.content.position = 0;
                    if (signature.verify(rdMsg.content, content))
                    {
                        l = new Loader();
                        l.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, ErrorManager.onUncaughtError, false, 0, true);
                        lc = new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain));
                        AirScanner.allowByteCodeExecution(lc, true);
                        l.loadBytes(content, lc);
                    }
                    else
                    {
                        _log.error("Signature incorrecte");
                    };
                    return (true);
                case (msg is URLOpenMessage):
                    urlmsg = (msg as URLOpenMessage);
                    urlData = Url.getUrlById(urlmsg.urlId);
                    switch (urlData.browserId)
                    {
                        case 1:
                            HaapiKeyManager.getInstance().callWithApiKey(function (apiKey:String):void
                            {
                                var req:URLRequest = new URLRequest(urlData.url);
                                req.method = ((urlData.method == "") ? "GET" : urlData.method.toUpperCase());
                                req.data = urlData.getVariables(apiKey);
                                navigateToURL(req);
                            });
                            return (true);
                        case 2:
                            KernelEventsManager.getInstance().processCallback(HookList.OpenWebPortal, WebLocationEnum.WEB_LOCATION_OGRINE);
                            return (true);
                        case 3:
                            return (true);
                        case 4:
                            if (HookList[urlData.url])
                            {
                                KernelEventsManager.getInstance().processCallback(HookList[urlData.url]);
                            };
                            return (true);
                    };
                    return (true);
                case (msg is TrustStatusMessage):
                    tsMsg = (msg as TrustStatusMessage);
                    SecureModeManager.getInstance().active = (!(tsMsg.trusted));
                    PlayerManager.getInstance().isSafe = tsMsg.certified;
                    return (true);
            };
            return (false);
        }


    }
} com.ankamagames.dofus.logic.common.frames

