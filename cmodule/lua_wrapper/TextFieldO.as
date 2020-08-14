package cmodule.lua_wrapper
{
    import flash.text.TextField;
    import flash.text.TextFormat;
    import cmodule.lua_wrapper.gstate;

    internal class TextFieldO extends IO 
    {

        private var m_trace:Boolean;
        private var m_tf:TextField;

        public function TextFieldO(_arg_1:TextField, _arg_2:Boolean=false)
        {
            this.m_tf = _arg_1;
            this.m_trace = _arg_2;
        }

        override public function write(_arg_1:int, _arg_2:int):int
        {
            var _local_4:String;
            var _local_5:int;
            var _local_6:int;
            var _local_7:TextFormat;
            var _local_3:int = _arg_2;
            _local_4 = "";
            while (_local_3--)
            {
                _local_4 = (_local_4 + String.fromCharCode(gstate._mru8(_arg_1)));
                _arg_1++;
            };
            if (this.m_trace)
            {
                trace(_local_4);
            };
            _local_5 = this.m_tf.length;
            this.m_tf.replaceText(_local_5, _local_5, _local_4);
            _local_6 = this.m_tf.length;
            _local_7 = this.m_tf.getTextFormat(_local_5, _local_6);
            _local_7.bold = true;
            this.m_tf.setTextFormat(_local_7, _local_5, _local_6);
            this.m_tf.setSelection(_local_6, _local_6);
            return (_arg_2);
        }


    }
} cmodule.lua_wrapper

