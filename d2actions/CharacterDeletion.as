package d2actions
{
    public class CharacterDeletion implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = true;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function CharacterDeletion(id:Number, answer:String)
        {
            this._params = [id, answer];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
} d2actions

