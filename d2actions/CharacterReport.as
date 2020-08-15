package d2actions
{
    public class CharacterReport implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = true;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function CharacterReport(reportedId:Number, reason:uint)
        {
            this._params = [reportedId, reason];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}

