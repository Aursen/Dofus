package d2actions
{
    public class HouseLockFromInside implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = true;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function HouseLockFromInside(code:String)
        {
            this._params = [code];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}

