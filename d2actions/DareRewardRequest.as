package d2actions
{
    public class DareRewardRequest implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = false;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function DareRewardRequest(dareId:Number, dareRewardType:int=0)
        {
            this._params = [dareId, dareRewardType];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}

