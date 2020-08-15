package com.ankamagames.jerakine.messages
{
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
    import flash.errors.IllegalOperationError;

    public class RegisteringFrame implements Frame 
    {

        private var _allowsRegistration:Boolean;
        private var _registeredTypes:Dictionary;
        protected var _priority:int = 1;

        public function RegisteringFrame()
        {
            this.initialize();
        }

        public function get priority():int
        {
            return (this._priority);
        }

        public function process(msg:Message):Boolean
        {
            var handler:Function = this._registeredTypes[msg["constructor"]];
            if (handler != null)
            {
                return (handler(msg));
            };
            return (false);
        }

        protected function registerMessages():void
        {
            throw (new AbstractMethodCallError());
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        protected function register(_arg_1:Class, handler:Function):void
        {
            if (((!(this._allowsRegistration)) || (!(_arg_1))))
            {
                throw (new IllegalOperationError());
            };
            if (this._registeredTypes[_arg_1])
            {
                throw (new IllegalOperationError("Cannot register twice a message"));
            };
            this._registeredTypes[_arg_1] = handler;
        }

        private function initialize():void
        {
            this._registeredTypes = new Dictionary();
            this._allowsRegistration = true;
            this.registerMessages();
            this._allowsRegistration = false;
        }


    }
}

