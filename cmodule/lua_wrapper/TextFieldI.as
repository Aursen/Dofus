package cmodule.lua_wrapper
{
    import flash.text.TextField;
    import flash.events.KeyboardEvent;
    import flash.utils.setTimeout;
    import flash.events.TextEvent;
    import flash.text.TextFormat;
    import cmodule.lua_wrapper.gstate;

    internal class TextFieldI extends IO 
    {

        private var m_buf:String = "";
        private var m_tf:TextField;
        private var m_start:int = -1;
        private var m_closed:Boolean = false;

        public function TextFieldI(tf:TextField)
        {
            super();
            this.m_tf = tf;
            this.m_tf.addEventListener(KeyboardEvent.KEY_DOWN, function (event:KeyboardEvent)
            {
                if (((String.fromCharCode(event.charCode).toLowerCase() == "d") && (event.ctrlKey)))
                {
                    m_closed = true;
                };
                if (((String.fromCharCode(event.charCode).toLowerCase() == "t") && (event.ctrlKey)))
                {
                    setTimeout(function ():void
                    {
                        m_start = -1;
                        m_tf.text = "";
                    }, 1);
                };
            });
            this.m_tf.addEventListener(TextEvent.TEXT_INPUT, function (_arg_1:TextEvent)
            {
                var _local_2:int;
                var _local_3:int;
                var _local_4:int;
                var _local_5:TextFormat;
                var _local_6:String;
                var _local_7:String;
                var _local_8:int;
                var _local_9:int;
                var _local_10:int;
                var _local_11:Boolean;
                _local_2 = m_tf.length;
                _local_3 = m_tf.selectionBeginIndex;
                if (((m_start < 0) || (m_start > _local_3)))
                {
                    m_start = _local_3;
                };
                _arg_1.preventDefault();
                m_tf.replaceSelectedText(_arg_1.text);
                _local_4 = m_tf.selectionEndIndex;
                _local_5 = m_tf.getTextFormat(_local_3, _local_4);
                _local_5.bold = false;
                m_tf.setTextFormat(_local_5, _local_3, _local_4);
                if (_arg_1.text.indexOf("\n") >= 0)
                {
                    _local_6 = m_tf.text;
                    _local_7 = "";
                    _local_2 = m_tf.length;
                    _local_8 = m_start;
                    while (_local_8 < _local_2)
                    {
                        _local_5 = m_tf.getTextFormat(_local_8, (_local_8 + 1));
                        _local_11 = _local_5.bold;
                        if (((!(_local_11 == null)) && (!(_local_11.valueOf()))))
                        {
                            _local_7 = (_local_7 + _local_6.charAt(_local_8));
                        };
                        _local_8++;
                    };
                    _local_7 = _local_7.replace(/\r/g, "\n");
                    _local_9 = _local_7.lastIndexOf("\n");
                    _local_10 = (_local_2 - ((_local_7.length - _local_9) - 1));
                    m_tf.setSelection(_local_10, _local_10);
                    _local_7 = _local_7.substr(0, (_local_9 + 1));
                    if (!m_closed)
                    {
                        m_buf = (m_buf + _local_7);
                    };
                    m_start = _local_10;
                };
            });
        }

        override public function read(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int;
            if (!this.m_buf)
            {
                if (this.m_closed)
                {
                    return (0);
                };
                throw (new AlchemyBlock());
            };
            _local_3 = 0;
            while (((this.m_buf) && (_arg_2--)))
            {
                _local_3++;
                gstate._mw8(_arg_1++, this.m_buf.charCodeAt(0));
                this.m_buf = this.m_buf.substr(1);
            };
            return (_local_3);
        }


    }
} cmodule.lua_wrapper

