package d2actions
{
    public class BreachInvitationRequest implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = true;
        public static const NEED_CONFIRMATION:Boolean = false;
        public static const MAX_USE_PER_FRAME:int = 0;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function BreachInvitationRequest(guests:Object)
        {
            this._params = [guests];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
} d2actions

