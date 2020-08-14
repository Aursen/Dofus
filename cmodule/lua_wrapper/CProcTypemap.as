package cmodule.lua_wrapper
{
    import cmodule.lua_wrapper.regFunc;
    import cmodule.lua_wrapper.log;
    import cmodule.lua_wrapper.unregFunc;
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal class CProcTypemap extends CTypemap 
    {

        private var retTypemap:CTypemap;
        private var varargs:Boolean;
        private var argTypemaps:Array;
        private var async:Boolean;

        public function CProcTypemap(_arg_1:CTypemap, _arg_2:Array, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            this.retTypemap = _arg_1;
            this.argTypemaps = _arg_2;
            this.varargs = _arg_3;
            this.async = _arg_4;
        }

        override public function createC(v:*, ptr:int=0):Array
        {
            var id:int;
            id = regFunc(function ():void
            {
                var args:* = undefined;
                var sp:* = undefined;
                var n:* = undefined;
                var tm:* = undefined;
                var aa:* = undefined;
                var ts:* = undefined;
                args = [];
                mstate.pop();
                sp = mstate.esp;
                n = 0;
                while (n < argTypemaps.length)
                {
                    tm = argTypemaps[n];
                    aa = [];
                    ts = tm.typeSize;
                    mstate.ds.position = sp;
                    sp = (sp + ts);
                    while (ts)
                    {
                        aa.push(mstate.ds.readInt());
                        ts = (ts - 4);
                    };
                    args.push(tm.fromC(aa));
                    n++;
                };
                if (varargs)
                {
                    args.push(sp);
                };
                try
                {
                    retTypemap.toReturnRegs(mstate, v.apply(null, args));
                }
                catch(e)
                {
                    mstate.eax = 0;
                    mstate.edx = 0;
                    mstate.st0 = 0;
                    log(2, ("v.apply: " + e.toString()));
                };
            });
            return ([id]);
        }

        override public function destroyC(_arg_1:Array):void
        {
            unregFunc(int(_arg_1[0]));
        }

        override public function fromC(v:Array):*
        {
            return (function (... args):*
            {
                var sp:* = undefined;
                var cargs:* = undefined;
                var n:* = undefined;
                var asyncHandler:* = undefined;
                var oldWorker:* = undefined;
                var arg:* = undefined;
                var carg:* = undefined;
                var cleanup:Function = function ():void
                {
                    n = (cargs.length - 1);
                    while (n >= 0)
                    {
                        argTypemaps[n].destroyC(cargs[n]);
                        n--;
                    };
                    mstate.esp = sp;
                    mstate.gworker = oldWorker;
                };
                sp = mstate.esp;
                cargs = [];
                oldWorker = mstate.gworker;
                if (async)
                {
                    asyncHandler = args.shift();
                    mstate.gworker = new NotifyMachine(function ():Boolean
                    {
                        var result:* = undefined;
                        result = retTypemap.fromReturnRegs(mstate);
                        cleanup();
                        try
                        {
                            asyncHandler(result);
                        }
                        catch(e)
                        {
                            log(1, ("asyncHandler: " + e.toString()));
                        };
                        return (true);
                    });
                };
                n = (args.length - 1);
                while (n >= 0)
                {
                    arg = args[n];
                    if (n >= argTypemaps.length)
                    {
                        push(arg);
                    }
                    else
                    {
                        carg = argTypemaps[n].createC(arg);
                        cargs[n] = carg;
                        push(carg);
                    };
                    n--;
                };
                mstate.push(0);
                if (!asyncHandler)
                {
                    try
                    {
                        try
                        {
                            var _local_3:* = mstate.funcs;
                            (_local_3[int(v[0])]());
                        }
                        catch(e:AlchemyYield)
                        {
                        }
                        catch(e:AlchemyDispatch)
                        {
                        };
                        while (mstate.gworker !== oldWorker)
                        {
                            try
                            {
                                while (mstate.gworker !== oldWorker)
                                {
                                    mstate.gworker.work();
                                };
                            }
                            catch(e:AlchemyYield)
                            {
                            }
                            catch(e:AlchemyDispatch)
                            {
                            };
                        };
                        _local_3 = retTypemap.fromReturnRegs(mstate);
                        return (_local_3);
                    }
                    finally
                    {
                        (cleanup());
                    };
                }
                else
                {
                    try
                    {
                        _local_3 = mstate.funcs;
                        (_local_3[int(v[0])]());
                    }
                    catch(e:AlchemyYield)
                    {
                    }
                    catch(e:AlchemyDispatch)
                    {
                    }
                    catch(e:AlchemyBlock)
                    {
                    }
                    catch(e)
                    {
                        (cleanup());
                        throw (e);
                    };
                };
            });
        }

        private function push(_arg_1:*):void
        {
            var _local_2:int;
            if ((_arg_1 is Array))
            {
                _local_2 = (_arg_1.length - 1);
                while (_local_2 >= 0)
                {
                    mstate.push(_arg_1[_local_2]);
                    _local_2--;
                };
            }
            else
            {
                mstate.push(_arg_1);
            };
        }


    }
} cmodule.lua_wrapper

