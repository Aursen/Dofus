package flashx.textLayout.conversion
{
    import flashx.textLayout.conversion.IFormatImporter;
    import flash.utils.Dictionary;
    import flashx.textLayout.conversion.*;

    [ExcludeClass]
    internal class CustomFormatImporter implements IFormatImporter 
    {

        private var _rslt:Dictionary = null;


        public function reset():void
        {
            this._rslt = null;
        }

        public function get result():Object
        {
            return (this._rslt);
        }

        public function importOneFormat(key:String, val:String):Boolean
        {
            if (this._rslt == null)
            {
                this._rslt = new Dictionary();
            };
            this._rslt[key] = val;
            return (true);
        }


    }
}

