package cmodule.lua_wrapper
{
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;

    public class CRunner implements Debuggee 
    {

        internal var timer:Timer;
        internal var forceSyncSystem:Boolean;
        internal var suspended:int = 0;
        internal var debugger:GDBMIDebugger;

        public function CRunner(_arg_1:Boolean=false)
        {
            if (grunner)
            {
                log(1, "More than one CRunner!");
            };
            grunner = this;
            this.forceSyncSystem = _arg_1;
        }

        public function cancelDebug():void
        {
            this.debugger = null;
        }

        public function get isRunning():Boolean
        {
            return (this.suspended <= 0);
        }

        public function createArgv(_arg_1:Array):Array
        {
            return (this.rawAllocStringArray(_arg_1).concat(0));
        }

        public function createEnv(_arg_1:Object):Array
        {
            var _local_2:Array;
            var _local_3:String;
            _local_2 = [];
            for (_local_3 in _arg_1)
            {
                _local_2.push(((_local_3 + "=") + _arg_1[_local_3]));
            };
            return (this.rawAllocStringArray(_local_2).concat(0));
        }

        public function startInit():void
        {
            var args:Array;
            var env:Object;
            var argv:Array;
            var envp:Array;
            var startArgs:Array;
            var ap:int;
            log(2, "Static init...");
            modStaticInit();
            args = gstate.system.getargv();
            env = gstate.system.getenv();
            argv = this.createArgv(args);
            envp = this.createEnv(env);
            startArgs = [args.length].concat(argv, envp);
            ap = this.rawAllocIntArray(startArgs);
            gstate.ds.length = ((gstate.ds.length + 4095) & (~(0x0FFF)));
            gstate.push(ap);
            gstate.push(0);
            log(2, "Starting work...");
            this.timer = new Timer(1);
            this.timer.addEventListener(TimerEvent.TIMER, function (_arg_1:TimerEvent):void
            {
                work();
            });
            try
            {
                FSM__start.start();
            }
            catch(e:AlchemyExit)
            {
                gstate.system.exit(e.rv);
                return;
            }
            catch(e:AlchemyYield)
            {
            }
            catch(e:AlchemyDispatch)
            {
            }
            catch(e:AlchemyBlock)
            {
            };
            this.startWork();
        }

        private function startWork():void
        {
            if (!this.timer.running)
            {
                this.timer.delay = 1;
                this.timer.start();
            };
        }

        public function work():void
        {
            var startTime:Number;
            var checkInterval:int;
            var ms:int;
            if (!this.isRunning)
            {
                return;
            };
            try
            {
                startTime = new Date().time;
                while (true)
                {
                    checkInterval = 1000;
                    while (checkInterval > 0)
                    {
                        try
                        {
                            while (checkInterval-- > 0)
                            {
                                gstate.gworker.work();
                            };
                        }
                        catch(e:AlchemyDispatch)
                        {
                        };
                    };
                    if ((new Date().time - startTime) >= (1000 * 10))
                    {
                        throw (new AlchemyYield());
                    };
                };
            }
            catch(e:AlchemyExit)
            {
                timer.stop();
                gstate.system.exit(e.rv);
            }
            catch(e:AlchemyYield)
            {
                ms = e.ms;
                timer.delay = ((ms > 0) ? ms : 1);
            }
            catch(e:AlchemyBlock)
            {
                timer.delay = 10;
            }
            catch(e:AlchemyBreakpoint)
            {
                throw (e);
            };
        }

        public function startSystemBridge(_arg_1:String, _arg_2:int):void
        {
            log(3, ((("bridge: " + _arg_1) + " port: ") + _arg_2));
            gstate.system = new CSystemBridge(_arg_1, _arg_2);
            gstate.system.setup(this.startInit);
        }

        public function rawAllocString(_arg_1:String):int
        {
            var _local_2:int;
            var _local_3:int;
            _local_2 = gstate.ds.length;
            gstate.ds.length = (gstate.ds.length + (_arg_1.length + 1));
            gstate.ds.position = _local_2;
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                gstate.ds.writeByte(_arg_1.charCodeAt(_local_3));
                _local_3++;
            };
            gstate.ds.writeByte(0);
            return (_local_2);
        }

        public function rawAllocStringArray(_arg_1:Array):Array
        {
            var _local_2:Array;
            var _local_3:int;
            _local_2 = [];
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_2.push(this.rawAllocString(_arg_1[_local_3]));
                _local_3++;
            };
            return (_local_2);
        }

        public function resume():void
        {
            if (!--this.suspended)
            {
                this.startWork();
            };
        }

        public function startSystem():void
        {
            var request:URLRequest;
            var loader:URLLoader;
            if (!this.forceSyncSystem)
            {
                request = new URLRequest(".swfbridge");
                loader = new URLLoader();
                loader.dataFormat = URLLoaderDataFormat.TEXT;
                loader.addEventListener(Event.COMPLETE, function (_arg_1:Event):void
                {
                    var _local_2:XML;
                    _local_2 = new XML(loader.data);
                    if (((((_local_2) && (_local_2.name() == "bridge")) && (_local_2.host)) && (_local_2.port)))
                    {
                        startSystemBridge(_local_2.host, _local_2.port);
                    }
                    else
                    {
                        startSystemLocal();
                    };
                });
                loader.addEventListener(IOErrorEvent.IO_ERROR, function (_arg_1:Event):void
                {
                    startSystemLocal();
                });
                loader.load(request);
                return;
            };
            this.startSystemLocal(true);
        }

        public function rawAllocIntArray(_arg_1:Array):int
        {
            var _local_2:int;
            var _local_3:int;
            _local_2 = gstate.ds.length;
            gstate.ds.length = (gstate.ds.length + ((_arg_1.length + 1) * 4));
            gstate.ds.position = _local_2;
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                gstate.ds.writeInt(_arg_1[_local_3]);
                _local_3++;
            };
            return (_local_2);
        }

        public function startSystemLocal(_arg_1:Boolean=false):void
        {
            log(3, "local system");
            gstate.system = new CSystemLocal(_arg_1);
            gstate.system.setup(this.startInit);
        }

        public function suspend():void
        {
            this.suspended++;
            if (((this.timer) && (this.timer.running)))
            {
                this.timer.stop();
            };
        }


    }
}

