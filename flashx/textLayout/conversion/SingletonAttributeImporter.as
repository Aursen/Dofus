package flashx.textLayout.conversion
{
    import flashx.textLayout.conversion.IFormatImporter;

    [ExcludeClass]
    internal class SingletonAttributeImporter implements IFormatImporter 
    {

        private var _keyToMatch:String;
        private var _rslt:String = null;

        public function SingletonAttributeImporter(key:String)
        {
            this._keyToMatch = key;
        }

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
            if (key == this._keyToMatch)
            {
                this._rslt = val;
                return (true);
            };
            return (false);
        }


    }
} flashx.textLayout.conversion

