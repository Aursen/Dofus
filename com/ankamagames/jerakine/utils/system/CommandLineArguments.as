package com.ankamagames.jerakine.utils.system
{
    import flash.utils.Dictionary;

    public class CommandLineArguments 
    {

        private static var _self:CommandLineArguments;

        private var _arguments:Dictionary = new Dictionary();


        public static function getInstance():CommandLineArguments
        {
            if (!_self)
            {
                _self = new (CommandLineArguments)();
            };
            return (_self);
        }


        public function setArguments(args:Array):void
        {
            var arg:String;
            var couple:Array;
            var key:String;
            if (args)
            {
                for each (arg in args)
                {
                    couple = arg.split("=");
                    key = couple[0].replace(/^--?/, "");
                    this._arguments[key] = couple[1];
                };
            };
        }

        public function hasArgument(argument:String):Boolean
        {
            return (this._arguments.hasOwnProperty(argument));
        }

        public function getArgument(argument:String):String
        {
            return (this._arguments[argument]);
        }

        public function toString():String
        {
            var arg:String;
            var res:Array = [];
            for (arg in this._arguments)
            {
                res.push(((arg + "=") + this._arguments[arg]));
            };
            return (res.join("||"));
        }


    }
} com.ankamagames.jerakine.utils.system

