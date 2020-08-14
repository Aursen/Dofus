package d2actions
{
    public class OpenMap implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = false;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function OpenMap(ignoreSetting:Boolean=false, fromShortcut:Boolean=false, conquest:Boolean=false)
        {
            this._params = [ignoreSetting, fromShortcut, conquest];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
} d2actions

