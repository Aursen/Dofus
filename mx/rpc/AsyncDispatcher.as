package mx.rpc
{
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    [ExcludeClass]
    public class AsyncDispatcher 
    {

        private var _method:Function;
        private var _args:Array;
        private var _timer:Timer;

        public function AsyncDispatcher(method:Function, args:Array, delay:Number)
        {
            this._method = method;
            this._args = args;
            this._timer = new Timer(delay);
            this._timer.addEventListener(TimerEvent.TIMER, this.timerEventHandler);
            this._timer.start();
        }

        private function timerEventHandler(event:TimerEvent):void
        {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.timerEventHandler);
            this._method.apply(null, this._args);
        }


    }
} mx.rpc

