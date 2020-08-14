package mx.rpc.http
{
    import mx.rpc.AbstractOperation;
    import mx.core.mx_internal;
    import mx.messaging.ChannelSet;
    import mx.logging.ILogger;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.logging.Log;
    import mx.rpc.mxml.Concurrency;
    import mx.rpc.AbstractService;
    import mx.messaging.config.LoaderConfig;
    import mx.managers.CursorManager;
    import mx.rpc.AsyncToken;
    import mx.rpc.Fault;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.xml.SimpleXMLEncoder;
    import flash.xml.XMLDocument;
    import mx.rpc.AsyncDispatcher;
    import mx.utils.URLUtil;
    import flash.xml.XMLNode;
    import mx.utils.ObjectUtil;
    import mx.messaging.messages.HTTPRequestMessage;
    import mx.netmon.NetworkMonitor;
    import mx.rpc.xml.SimpleXMLDecoder;
    import mx.utils.StringUtil;
    import flash.utils.getQualifiedClassName;
    import mx.utils.ObjectProxy;
    import mx.messaging.messages.IMessage;
    import mx.messaging.messages.AsyncMessage;
    import mx.messaging.events.MessageEvent;
    import mx.collections.ArrayCollection;
    import mx.messaging.channels.DirectHTTPChannel;

    use namespace mx_internal;

    public class AbstractOperation extends mx.rpc.AbstractOperation 
    {

        mx_internal static const RESULT_FORMAT_E4X:String = "e4x";
        mx_internal static const RESULT_FORMAT_FLASHVARS:String = "flashvars";
        mx_internal static const RESULT_FORMAT_OBJECT:String = "object";
        mx_internal static const RESULT_FORMAT_ARRAY:String = "array";
        mx_internal static const RESULT_FORMAT_TEXT:String = "text";
        mx_internal static const RESULT_FORMAT_XML:String = "xml";
        mx_internal static const CONTENT_TYPE_XML:String = "application/xml";
        mx_internal static const CONTENT_TYPE_FORM:String = "application/x-www-form-urlencoded";
        private static const ERROR_URL_REQUIRED:String = "Client.URLRequired";
        private static const ERROR_DECODING:String = "Client.CouldNotDecode";
        private static const ERROR_ENCODING:String = "Client.CouldNotEncode";
        private static var _directChannelSet:ChannelSet;

        public var argumentNames:Array;
        private var _requestTimeout:int = -1;
        private var _resultFormat:String = "object";
        public var serializationFilter:SerializationFilter;
        [Inspectable(defaultValue="undefined", category="General")]
        public var request:Object = {};
        private var _url:String;
        private var _useProxy:Boolean = false;
        [Inspectable(defaultValue="undefined", category="General")]
        public var xmlDecode:Function;
        [Inspectable(defaultValue="undefined", category="General")]
        public var xmlEncode:Function;
        [Inspectable(defaultValue="undefined", category="General")]
        public var headers:Object = {};
        private var _contentType:String = "application/x-www-form-urlencoded";
        mx_internal var _rootURL:String;
        mx_internal var _log:ILogger;
        mx_internal var resourceManager:IResourceManager = ResourceManager.getInstance();
        private var _concurrency:String;
        private var _method:String = "GET";
        private var _showBusyCursor:Boolean = false;

        public function AbstractOperation(service:AbstractService=null, name:String=null)
        {
            super(service, name);
            this._log = Log.getLogger("mx.rpc.http.HTTPService");
            this.concurrency = Concurrency.MULTIPLE;
        }

        [Inspectable(enumeration="GET,get,POST,post,HEAD,head,OPTIONS,options,PUT,put,TRACE,trace,DELETE,delete", defaultValue="GET", category="General")]
        public function get method():String
        {
            return (this._method);
        }

        public function set method(m:String):void
        {
            this._method = m;
        }

        [Inspectable(enumeration="multiple,single,last", defaultValue="multiple", category="General")]
        public function get concurrency():String
        {
            return (this._concurrency);
        }

        public function set concurrency(c:String):void
        {
            this._concurrency = c;
        }

        public function get requestTimeout():int
        {
            return (this._requestTimeout);
        }

        public function set requestTimeout(value:int):void
        {
            if (this._requestTimeout != value)
            {
                this._requestTimeout = value;
            };
        }

        [Inspectable(enumeration="object,array,xml,flashvars,text,e4x", category="General")]
        public function get resultFormat():String
        {
            return (this._resultFormat);
        }

        public function set resultFormat(value:String):void
        {
            var sf:SerializationFilter;
            var message:String;
            switch (value)
            {
                case RESULT_FORMAT_OBJECT:
                case RESULT_FORMAT_ARRAY:
                case RESULT_FORMAT_XML:
                case RESULT_FORMAT_E4X:
                case RESULT_FORMAT_TEXT:
                case RESULT_FORMAT_FLASHVARS:
                    break;
                default:
                    if (((!(value == null)) && ((sf = SerializationFilter.filterForResultFormatTable[value]) == null)))
                    {
                        message = this.resourceManager.getString("rpc", "invalidResultFormat", [value, RESULT_FORMAT_OBJECT, RESULT_FORMAT_ARRAY, RESULT_FORMAT_XML, RESULT_FORMAT_E4X, RESULT_FORMAT_TEXT, RESULT_FORMAT_FLASHVARS]);
                        throw (new ArgumentError(message));
                    };
                    this.serializationFilter = sf;
            };
            this._resultFormat = value;
        }

        protected function getSerializationFilter():SerializationFilter
        {
            return (this.serializationFilter);
        }

        [Inspectable(defaultValue="undefined", category="General")]
        public function get url():String
        {
            return (this._url);
        }

        public function set url(value:String):void
        {
            this._url = value;
        }

        [Inspectable(defaultValue="false", category="General")]
        public function get useProxy():Boolean
        {
            return (this._useProxy);
        }

        public function set useProxy(value:Boolean):void
        {
            var dcs:ChannelSet;
            if (value != this._useProxy)
            {
                this._useProxy = value;
                dcs = this.getDirectChannelSet();
                if (!this.useProxy)
                {
                    if (dcs != asyncRequest.channelSet)
                    {
                        asyncRequest.channelSet = dcs;
                    };
                }
                else
                {
                    if (asyncRequest.channelSet == dcs)
                    {
                        asyncRequest.channelSet = null;
                    };
                };
            };
        }

        public function get contentType():String
        {
            return (this._contentType);
        }

        public function set contentType(ct:String):void
        {
            this._contentType = ct;
        }

        [Inspectable(defaultValue="false", category="General")]
        public function get showBusyCursor():Boolean
        {
            return (this._showBusyCursor);
        }

        public function set showBusyCursor(sbc:Boolean):void
        {
            this._showBusyCursor = sbc;
        }

        public function get rootURL():String
        {
            if (this._rootURL == null)
            {
                this._rootURL = LoaderConfig.url;
            };
            return (this._rootURL);
        }

        public function set rootURL(value:String):void
        {
            this._rootURL = value;
        }

        override public function cancel(id:String=null):AsyncToken
        {
            if (this.showBusyCursor)
            {
                CursorManager.removeBusyCursor();
            };
            return (super.cancel(id));
        }

        public function sendBody(parameters:Object):AsyncToken
        {
            var paramsToSend:Object;
            var token:AsyncToken;
            var fault:Fault;
            var faultEvent:FaultEvent;
            var msg:String;
            var m:String;
            var funcEncoded:Object;
            var encoder:SimpleXMLEncoder;
            var xmlDoc:XMLDocument;
            var childNodes:Array;
            var i:int;
            var val:Object;
            var classinfo:Object;
            var p:*;
            var dcs:ChannelSet;
            var filter:SerializationFilter = this.getSerializationFilter();
            if (((Concurrency.SINGLE == this.concurrency) && (activeCalls.hasActiveCalls())))
            {
                token = new AsyncToken(null);
                m = this.resourceManager.getString("rpc", "pendingCallExists");
                fault = new Fault("ConcurrencyError", m);
                faultEvent = FaultEvent.createEvent(fault, token);
                new AsyncDispatcher(dispatchRpcEvent, [faultEvent], 10);
                return (token);
            };
            var ctype:String = this.contentType;
            var urlToUse:String = this.url;
            if (((urlToUse) && (!(urlToUse == ""))))
            {
                urlToUse = URLUtil.getFullURL(this.rootURL, urlToUse);
            };
            if (filter != null)
            {
                ctype = filter.getRequestContentType(this, parameters, ctype);
                urlToUse = filter.serializeURL(this, parameters, urlToUse);
                parameters = filter.serializeBody(this, parameters);
            };
            if (ctype == CONTENT_TYPE_XML)
            {
                if (((parameters is String) && (this.xmlEncode == null)))
                {
                    paramsToSend = (parameters as String);
                }
                else
                {
                    if (((!(parameters is XMLNode)) && (!(parameters is XML))))
                    {
                        if (this.xmlEncode != null)
                        {
                            funcEncoded = this.xmlEncode(parameters);
                            if (null == funcEncoded)
                            {
                                token = new AsyncToken(null);
                                msg = this.resourceManager.getString("rpc", "xmlEncodeReturnNull");
                                fault = new Fault(ERROR_ENCODING, msg);
                                faultEvent = FaultEvent.createEvent(fault, token);
                                new AsyncDispatcher(dispatchRpcEvent, [faultEvent], 10);
                                return (token);
                            };
                            if (!(funcEncoded is XMLNode))
                            {
                                token = new AsyncToken(null);
                                msg = this.resourceManager.getString("rpc", "xmlEncodeReturnNoXMLNode");
                                fault = new Fault(ERROR_ENCODING, msg);
                                faultEvent = FaultEvent.createEvent(fault, token);
                                new AsyncDispatcher(dispatchRpcEvent, [faultEvent], 10);
                                return (token);
                            };
                            paramsToSend = XMLNode(funcEncoded).toString();
                        }
                        else
                        {
                            encoder = new SimpleXMLEncoder(null);
                            xmlDoc = new XMLDocument();
                            childNodes = encoder.encodeValue(parameters, new QName(null, "encoded"), new XMLNode(1, "top")).childNodes.concat();
                            i = 0;
                            while (i < childNodes.length)
                            {
                                xmlDoc.appendChild(childNodes[i]);
                                i++;
                            };
                            paramsToSend = xmlDoc.toString();
                        };
                    }
                    else
                    {
                        paramsToSend = XML(parameters).toXMLString();
                    };
                };
            }
            else
            {
                if (ctype == CONTENT_TYPE_FORM)
                {
                    paramsToSend = {};
                    if (typeof(parameters) == "object")
                    {
                        classinfo = ObjectUtil.getClassInfo(parameters);
                        for each (p in classinfo.properties)
                        {
                            val = parameters[p];
                            if (val != null)
                            {
                                if ((val is Array))
                                {
                                    paramsToSend[p] = val;
                                }
                                else
                                {
                                    paramsToSend[p] = val.toString();
                                };
                            };
                        };
                    }
                    else
                    {
                        paramsToSend = parameters;
                    };
                }
                else
                {
                    paramsToSend = parameters;
                };
            };
            var message:HTTPRequestMessage = new HTTPRequestMessage();
            if (this.useProxy)
            {
                if (((urlToUse) && (!(urlToUse == ""))))
                {
                    message.url = urlToUse;
                };
                if (NetworkMonitor.isMonitoring())
                {
                    message.recordHeaders = true;
                };
            }
            else
            {
                if (!urlToUse)
                {
                    token = new AsyncToken(null);
                    msg = this.resourceManager.getString("rpc", "urlNotSpecified");
                    fault = new Fault(ERROR_URL_REQUIRED, msg);
                    faultEvent = FaultEvent.createEvent(fault, token);
                    new AsyncDispatcher(dispatchRpcEvent, [faultEvent], 10);
                    return (token);
                };
                if (!this.useProxy)
                {
                    dcs = this.getDirectChannelSet();
                    if (dcs != asyncRequest.channelSet)
                    {
                        asyncRequest.channelSet = dcs;
                    };
                };
                if (NetworkMonitor.isMonitoring())
                {
                    message.recordHeaders = true;
                };
                message.url = urlToUse;
            };
            message.contentType = ctype;
            message.method = this.method.toUpperCase();
            if (((ctype == CONTENT_TYPE_XML) && (message.method == HTTPRequestMessage.GET_METHOD)))
            {
                message.method = HTTPRequestMessage.POST_METHOD;
            };
            message.body = paramsToSend;
            message.httpHeaders = this.getHeaders();
            return (this.invoke(message));
        }

        protected function getHeaders():Object
        {
            return (this.headers);
        }

        override mx_internal function processResult(message:IMessage, token:AsyncToken):Boolean
        {
            var tmp:Object;
            var fault:Fault;
            var decoded:Object;
            var msg:String;
            var fault1:Fault;
            var decoder:SimpleXMLDecoder;
            var fault2:Fault;
            var fault3:Fault;
            var body:Object = message.body;
            this._log.info("Decoding HTTPService response");
            this._log.debug("Processing HTTPService response message:\n{0}", message);
            var filter:SerializationFilter = this.getSerializationFilter();
            if (filter != null)
            {
                body = filter.deserializeResult(this, body);
            };
            if (((body == null) || (((!(body == null)) && (body is String)) && (StringUtil.trim(String(body)) == ""))))
            {
                _result = body;
                return (true);
            };
            if ((body is String))
            {
                if ((((this.resultFormat == RESULT_FORMAT_XML) || (this.resultFormat == RESULT_FORMAT_OBJECT)) || (this.resultFormat == RESULT_FORMAT_ARRAY)))
                {
                    tmp = new XMLDocument();
                    XMLDocument(tmp).ignoreWhite = true;
                    try
                    {
                        XMLDocument(tmp).parseXML(String(body));
                    }
                    catch(parseError:Error)
                    {
                        fault = new Fault(ERROR_DECODING, parseError.message);
                        dispatchRpcEvent(FaultEvent.createEvent(fault, token, message));
                        return (false);
                    };
                    if (((this.resultFormat == RESULT_FORMAT_OBJECT) || (this.resultFormat == RESULT_FORMAT_ARRAY)))
                    {
                        if (this.xmlDecode != null)
                        {
                            decoded = this.xmlDecode(tmp);
                            if (decoded == null)
                            {
                                msg = this.resourceManager.getString("rpc", "xmlDecodeReturnNull");
                                fault1 = new Fault(ERROR_DECODING, msg);
                                dispatchRpcEvent(FaultEvent.createEvent(fault1, token, message));
                            };
                        }
                        else
                        {
                            decoder = new SimpleXMLDecoder(makeObjectsBindable);
                            decoded = decoder.decodeXML(XMLNode(tmp));
                            if (decoded == null)
                            {
                                msg = this.resourceManager.getString("rpc", "defaultDecoderFailed");
                                fault2 = new Fault(ERROR_DECODING, msg);
                                dispatchRpcEvent(FaultEvent.createEvent(fault2, token, message));
                            };
                        };
                        if (decoded == null)
                        {
                            return (false);
                        };
                        if (((makeObjectsBindable) && (getQualifiedClassName(decoded) == "Object")))
                        {
                            decoded = new ObjectProxy(decoded);
                        }
                        else
                        {
                            decoded = decoded;
                        };
                        if (this.resultFormat == RESULT_FORMAT_ARRAY)
                        {
                            decoded = this.decodeArray(decoded);
                        };
                        _result = decoded;
                    }
                    else
                    {
                        if (tmp.childNodes.length == 1)
                        {
                            tmp = tmp.firstChild;
                        };
                        _result = tmp;
                    };
                }
                else
                {
                    if (this.resultFormat == RESULT_FORMAT_E4X)
                    {
                        try
                        {
                            _result = new XML(String(body));
                        }
                        catch(error:Error)
                        {
                            fault3 = new Fault(ERROR_DECODING, error.message);
                            dispatchRpcEvent(FaultEvent.createEvent(fault3, token, message));
                            return (false);
                        };
                    }
                    else
                    {
                        if (this.resultFormat == RESULT_FORMAT_FLASHVARS)
                        {
                            _result = this.decodeParameterString(String(body));
                        }
                        else
                        {
                            _result = body;
                        };
                    };
                };
            }
            else
            {
                if (this.resultFormat == RESULT_FORMAT_ARRAY)
                {
                    body = this.decodeArray(body);
                };
                _result = body;
            };
            return (true);
        }

        override mx_internal function invoke(message:IMessage, token:AsyncToken=null):AsyncToken
        {
            if (this.showBusyCursor)
            {
                CursorManager.setBusyCursor();
            };
            return (super.invoke(message, token));
        }

        override mx_internal function preHandle(event:MessageEvent):AsyncToken
        {
            if (this.showBusyCursor)
            {
                CursorManager.removeBusyCursor();
            };
            var wasLastCall:Boolean = activeCalls.wasLastCall(AsyncMessage(event.message).correlationId);
            var token:AsyncToken = super.preHandle(event);
            if (((Concurrency.LAST == this.concurrency) && (!(wasLastCall))))
            {
                return (null);
            };
            return (token);
        }

        private function decodeArray(o:Object):Object
        {
            var a:Array;
            if ((o is Array))
            {
                a = (o as Array);
            }
            else
            {
                if ((o is ArrayCollection))
                {
                    return (o);
                };
                a = [];
                a.push(o);
            };
            if (makeObjectsBindable)
            {
                return (new ArrayCollection(a));
            };
            return (a);
        }

        private function decodeParameterString(source:String):Object
        {
            var param:String;
            var equalsIndex:int;
            var name:String;
            var value:String;
            var trimmed:String = StringUtil.trim(source);
            var params:Array = trimmed.split("&");
            var decoded:Object = {};
            var i:int;
            while (i < params.length)
            {
                param = params[i];
                equalsIndex = param.indexOf("=");
                if (equalsIndex != -1)
                {
                    name = param.substr(0, equalsIndex);
                    name = name.split("+").join(" ");
                    name = unescape(name);
                    value = param.substr((equalsIndex + 1));
                    value = value.split("+").join(" ");
                    value = unescape(value);
                    decoded[name] = value;
                };
                i++;
            };
            return (decoded);
        }

        private function getDirectChannelSet():ChannelSet
        {
            var dcs:ChannelSet;
            var dhc:DirectHTTPChannel;
            if (_directChannelSet == null)
            {
                dcs = new ChannelSet();
                dhc = new DirectHTTPChannel("direct_http_channel");
                dhc.requestTimeout = this.requestTimeout;
                dcs.addChannel(dhc);
                _directChannelSet = dcs;
            };
            return (_directChannelSet);
        }


    }
} mx.rpc.http

