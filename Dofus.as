package 
{
    public class Dofus 
    {

        private static var _instance:IDofus;


        public static function setInstance(instance:IDofus):void
        {
            _instance = instance;
        }

        public static function getInstance():IDofus
        {
            return (_instance);
        }


    }
}

