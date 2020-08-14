package cmodule.lua_wrapper
{
    import flash.utils.ByteArray;
    import cmodule.lua_wrapper.gdomainClass;
    import cmodule.lua_wrapper.log;
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import cmodule.lua_wrapper.*;

    internal class GLEByteArrayProvider 
    {


        public static function get():ByteArray
        {
            var result:ByteArray;
            try
            {
                result = gdomainClass.currentDomain.domainMemory;
            }
            catch(e)
            {
            };
            if (!result)
            {
                result = new LEByteArray();
                try
                {
                    result.length = gdomainClass.MIN_DOMAIN_MEMORY_LENGTH;
                    gdomainClass.currentDomain.domainMemory = result;
                }
                catch(e)
                {
                    log(3, "Not using domain memory");
                };
            };
            return (result);
        }


    }
} cmodule.lua_wrapper

