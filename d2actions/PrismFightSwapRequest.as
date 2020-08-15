package d2actions
{
    public class PrismFightSwapRequest implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = true;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function PrismFightSwapRequest(subAreaId:uint, targetId:Number)
        {
            this._params = [subAreaId, targetId];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}
