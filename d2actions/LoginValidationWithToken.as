package d2actions
{
    public class LoginValidationWithToken implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = true;
        public static const MAX_USE_PER_FRAME:int = 0;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function LoginValidationWithToken(autoSelectServer:Boolean=false, serverId:uint=0)
        {
            this._params = [autoSelectServer, serverId];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
} d2actions

