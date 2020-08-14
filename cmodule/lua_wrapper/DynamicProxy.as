package cmodule.lua_wrapper
{
    import flash.utils.Proxy;
    import cmodule.lua_wrapper.flash_delegate;
    import flash.utils.flash_proxy; 

    use namespace flash.utils.flash_proxy;
    use namespace flash_delegate;

    public dynamic class DynamicProxy extends Proxy 
    {

        flash_delegate var nextValue:Function;
        flash_delegate var getProperty:Function;
        flash_delegate var isAttribute:Function;
        flash_delegate var nextNameIndex:Function;
        flash_delegate var hasProperty:Function;
        flash_delegate var callProperty:Function;
        flash_delegate var nextName:Function;
        flash_delegate var getDescendants:Function;
        flash_delegate var deleteProperty:Function;
        flash_delegate var setProperty:Function;


        override flash_proxy function hasProperty(_arg_1:*):Boolean
        {
            return (this.flash_delegate::hasProperty(_arg_1));
        }

        override flash_proxy function callProperty(_arg_1:*, ... _args):*
        {
            return (this.flash_delegate::callProperty(_arg_1, _args));
        }

        override flash_proxy function setProperty(_arg_1:*, _arg_2:*):void
        {
            this.flash_delegate::setProperty(_arg_1, _arg_2);
        }

        override flash_proxy function isAttribute(_arg_1:*):Boolean
        {
            return (this.flash_delegate::isAttribute(_arg_1));
        }

        override flash_proxy function getProperty(_arg_1:*):*
        {
            return (this.flash_delegate::getProperty(_arg_1));
        }

        override flash_proxy function nextNameIndex(_arg_1:int):int
        {
            return (this.flash_delegate::nextNameIndex(_arg_1));
        }

        override flash_proxy function deleteProperty(_arg_1:*):Boolean
        {
            return (this.flash_delegate::deleteProperty(_arg_1));
        }

        override flash_proxy function nextName(_arg_1:int):String
        {
            return (this.flash_delegate::nextName(_arg_1));
        }

        override flash_proxy function getDescendants(_arg_1:*):*
        {
            return (this.flash_delegate::getDescendants(_arg_1));
        }

        override flash_proxy function nextValue(_arg_1:int):*
        {
            return (this.flash_delegate::nextValue(_arg_1));
        }


    }
} cmodule.lua_wrapper

