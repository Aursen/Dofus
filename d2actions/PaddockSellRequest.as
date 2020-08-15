package d2actions
{
    public class PaddockSellRequest implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = true;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function PaddockSellRequest(price:Number, forSale:Boolean=true)
        {
            this._params = [price, forSale];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}

