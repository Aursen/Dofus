package d2actions
{
    public class AllianceModificationNameAndTagValid implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = true;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function AllianceModificationNameAndTagValid(pName:String, pTag:String)
        {
            this._params = [pName, pTag];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}

