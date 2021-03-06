package com.ankamagames.jerakine.types
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.filesystem.File;
    import com.ankamagames.jerakine.utils.system.SystemManager;
    import com.ankamagames.jerakine.enum.OperatingSystem;
    import flash.system.LoaderContext;
    import flash.errors.IllegalOperationError;
    import com.ankamagames.jerakine.utils.crypto.CRC32;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.managers.LangManager;

    public class Uri 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Uri));
        public static var APPLICATION_DIRECTORY:String = File.applicationDirectory.nativePath;
        private static var _useSecureURI:Boolean = false;
        private static var _unescapeAppPath:String = unescape(APPLICATION_DIRECTORY);
        private static var _unescapeThemePath:String;
        private static var _osIsWindows:Boolean = (SystemManager.getSingleton().os == OperatingSystem.WINDOWS);

        private var _protocol:String;
        private var _path:String;
        private var _subpath:String;
        private var _uri:String;
        private var _fileName:String;
        private var _fileType:String;
        private var _tag:*;
        private var _sum:String;
        private var _loaderContext:LoaderContext;
        private var _secureMode:Boolean;
        private var _uriChanged:Boolean = true;
        private var _fileNameChanged:Boolean = true;
        private var _fileTypeChanged:Boolean = true;

        public function Uri(uri:String=null, secureMode:Boolean=true)
        {
            this._secureMode = secureMode;
            this.parseUri(uri);
        }

        public static function enableSecureURI():void
        {
            _useSecureURI = true;
        }

        public static function set unescapeThemePath(v:String):void
        {
            _unescapeThemePath = v;
        }


        public function get protocol():String
        {
            return (this._protocol);
        }

        public function set protocol(value:String):void
        {
            this._protocol = value;
            this._sum = "";
            this._uriChanged = true;
        }

        public function get path():String
        {
            if (_osIsWindows)
            {
                return (this._path);
            };
            if ((((this._path) && (this._path.charCodeAt(0) == "/".charCodeAt())) && (!(this._path.charCodeAt(1) == "/".charCodeAt()))))
            {
                return ("/" + this._path);
            };
            return (this._path);
        }

        public function set path(value:String):void
        {
            var i:int;
            if (value.indexOf("\\") != -1)
            {
                this._path = value.replace(/\\/g, "/");
            }
            else
            {
                this._path = value;
            };
            if (_osIsWindows)
            {
                if (this._path.indexOf("/") == 0)
                {
                    i = 1;
                    while (i < this._path.length)
                    {
                        if (this._path.charCodeAt(i) != "/".charCodeAt())
                        {
                            break;
                        };
                        i++;
                    };
                    this._path = ("\\\\" + this._path.substr(i));
                };
                if (this._path.indexOf("//") != -1)
                {
                    this._path = this._path.replace("//", "/");
                };
            };
            this._sum = "";
            this._uriChanged = true;
            this._fileNameChanged = true;
            this._fileTypeChanged = true;
        }

        public function get subPath():String
        {
            return (this._subpath);
        }

        public function set subPath(value:String):void
        {
            if ((((!(this.subPath)) && (!(value))) || ((((this.subPath) && (value)) && (this.subPath.length == value.length)) && (this.subPath.indexOf(value) == 0))))
            {
                return;
            };
            if (((value == null) || (value == "")))
            {
                this._subpath = null;
            }
            else
            {
                this._subpath = ((value.charCodeAt(0) == "/".charCodeAt()) ? value.substr(1) : value);
            };
            this._sum = "";
            this._uriChanged = true;
            this._fileNameChanged = true;
            this._fileTypeChanged = true;
        }

        public function get uri():String
        {
            if (this._uriChanged)
            {
                this._uri = this.toString();
                this._uriChanged = false;
            };
            return (this._uri);
        }

        public function set uri(value:String):void
        {
            this.parseUri(value);
            this._uriChanged = false;
            this._uri = this.toString();
        }

        public function get tag():*
        {
            return (this._tag);
        }

        public function set tag(value:*):void
        {
            this._tag = value;
        }

        public function get loaderContext():LoaderContext
        {
            return (this._loaderContext);
        }

        public function set loaderContext(value:LoaderContext):void
        {
            this._loaderContext = value;
        }

        public function get fileType():String
        {
            var pointPos:int;
            var paramPos:int;
            if (this._fileTypeChanged)
            {
                if ((((!(this._subpath)) || (this._subpath.length == 0)) || (this._subpath.indexOf(".") == -1)))
                {
                    pointPos = this._path.lastIndexOf(".");
                    paramPos = this._path.indexOf("?");
                    this._fileType = this._path.substr((pointPos + 1), ((paramPos != -1) ? ((paramPos - pointPos) - 1) : int.MAX_VALUE));
                }
                else
                {
                    this._fileType = this._subpath.substr((this._subpath.lastIndexOf(".") + 1), ((this._subpath.indexOf("?") != -1) ? this._subpath.indexOf("?") : int.MAX_VALUE));
                };
            };
            this._fileTypeChanged = false;
            return (this._fileType);
        }

        public function get fileName():String
        {
            if (this._fileNameChanged)
            {
                if (((!(this._subpath)) || (this._subpath.length == 0)))
                {
                    this._fileName = this._path.substr((this._path.lastIndexOf("/") + 1));
                }
                else
                {
                    this._fileName = this._subpath.substr((this._subpath.lastIndexOf("/") + 1));
                };
            };
            this._fileNameChanged = false;
            return (this._fileName);
        }

        public function get normalizedUri():String
        {
            switch (this._protocol)
            {
                case "http":
                case "https":
                case "file":
                case "zip":
                case "mod":
                case "theme":
                case "d2p":
                case "d2pOld":
                case "pak":
                case "pak2":
                    return (this.uri.replace("/\\/g", "/"));
            };
            throw (new IllegalOperationError((("Unsupported protocol " + this._protocol) + " for normalization.")));
        }

        public function get normalizedUriWithoutSubPath():String
        {
            switch (this._protocol)
            {
                case "http":
                case "https":
                case "file":
                case "zip":
                case "mod":
                case "theme":
                case "d2p":
                case "d2pOld":
                case "pak":
                case "pak2":
                    return (this.toString(false).replace("/\\/g", "/"));
            };
            throw (new IllegalOperationError((("Unsupported protocol " + this._protocol) + " for normalization.")));
        }

        public function isSecure():Boolean
        {
            var currentFile:File;
            var stack:String;
            try
            {
                currentFile = File.applicationDirectory.resolvePath(this._path);
                stack = _unescapeAppPath;
                while (true)
                {
                    if (currentFile.nativePath == _unescapeAppPath)
                    {
                        return (true);
                    };
                    currentFile = currentFile.parent;
                    if (!currentFile)
                    {
                        break;
                    };
                    stack = (stack + (" -> " + currentFile.nativePath));
                };
                if (_unescapeThemePath)
                {
                    currentFile = File.applicationDirectory.resolvePath(this._path);
                    stack = _unescapeThemePath;
                    while (true)
                    {
                        if (currentFile.nativePath == _unescapeThemePath)
                        {
                            return (true);
                        };
                        currentFile = currentFile.parent;
                        if (!currentFile)
                        {
                            break;
                        };
                        stack = (stack + (" -> " + currentFile.nativePath));
                    };
                };
            }
            catch(e:Error)
            {
            };
            _log.debug(((("URI not secure: " + _unescapeAppPath) + "\nDetails: ") + stack));
            return (false);
        }

        public function toString(withSubPath:Boolean=true):String
        {
            return (((this._protocol + "://") + this.path) + ((((withSubPath) && (this._subpath)) && (this._subpath.length > 0)) ? ("|" + this._subpath) : ""));
        }

        public function toSum():String
        {
            if (this._sum.length > 0)
            {
                return (this._sum);
            };
            var crc:CRC32 = new CRC32();
            var buf:ByteArray = new ByteArray();
            buf.writeUTF(this.normalizedUri);
            crc.update(buf);
            return (this._sum = crc.getValue().toString(16));
        }

        public function toFile():File
        {
            var tmp:String;
            var uiRoot:String;
            if (this._path == null)
            {
                tmp = "null";
            }
            else
            {
                tmp = this._path;
            };
            if (((_osIsWindows) && ((tmp.indexOf("\\\\") == 0) || (tmp.charCodeAt(1) == ":".charCodeAt()))))
            {
                return (new File(tmp));
            };
            if (((!(_osIsWindows)) && (tmp.charCodeAt(0) == "/".charCodeAt())))
            {
                return (new File(("/" + tmp)));
            };
            if (this._protocol == "mod")
            {
                uiRoot = LangManager.getInstance().getEntry("config.mod.path");
                if (((!(uiRoot.substr(0, 2) == "\\\\")) && (!(uiRoot.substr(1, 2) == ":/"))))
                {
                    return (new File(((((APPLICATION_DIRECTORY + File.separator) + uiRoot) + File.separator) + tmp)));
                };
                return (new File(((uiRoot + File.separator) + tmp)));
            };
            return (new File(((APPLICATION_DIRECTORY + File.separator) + tmp)));
        }

        private function parseUri(uri:String):void
        {
            var pathWithoutProtocol:String;
            var protocolStart:int;
            if (!uri)
            {
                return;
            };
            var signPos:int = uri.lastIndexOf("://");
            if (signPos != -1)
            {
                protocolStart = uri.lastIndexOf("://", (signPos - 1));
                if (protocolStart == -1)
                {
                    this._protocol = uri.substring(0, signPos);
                }
                else
                {
                    this._protocol = uri.substring((protocolStart + 3), signPos);
                };
                pathWithoutProtocol = uri.substr((signPos + 3));
            }
            else
            {
                this._protocol = "file";
                pathWithoutProtocol = uri;
            };
            signPos = pathWithoutProtocol.indexOf("|");
            if (signPos == -1)
            {
                this.path = pathWithoutProtocol;
            }
            else
            {
                this.path = pathWithoutProtocol.substring(0, signPos);
            };
            if (((!(signPos == -1)) && (pathWithoutProtocol.length > (signPos + 1))))
            {
                this.subPath = pathWithoutProtocol.substr((signPos + 1));
            }
            else
            {
                this.subPath = null;
            };
            if (((((this._secureMode) && (_useSecureURI)) && (this._protocol == "file")) && (!(this.isSecure()))))
            {
                throw (new ArgumentError((("'" + uri) + "' is a unsecure URI.")));
            };
        }


    }
}

