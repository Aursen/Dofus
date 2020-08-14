package d2actions
{
    public class ShopOneClickBuyRequest implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = true;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function ShopOneClickBuyRequest(data:String, currency:String, token:Number)
        {
            this._params = [data, currency, token];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
} d2actions

