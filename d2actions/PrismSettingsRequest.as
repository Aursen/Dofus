package d2actions
{
    public class PrismSettingsRequest implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = true;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function PrismSettingsRequest(subAreaId:uint, startDefenseTime:uint)
        {
            this._params = [subAreaId, startDefenseTime];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}

