package d2actions
{
    public class TimelineEntityOut implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = false;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function TimelineEntityOut(target:Number)
        {
            this._params = [target];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}

