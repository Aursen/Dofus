package d2actions
{
    public class PaddockToSellFilter implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = true;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function PaddockToSellFilter(areaId:int, atLeastNbMount:uint, atLeastNbMachine:uint, maxPrice:Number, orderBy:uint)
        {
            this._params = [areaId, atLeastNbMount, atLeastNbMachine, maxPrice, orderBy];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}

