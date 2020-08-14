package mx.collections
{
    import flash.utils.IExternalizable;
    import mx.core.mx_internal;
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;

    use namespace mx_internal;

    public class ArrayCollection extends ListCollectionView implements IExternalizable 
    {

        mx_internal static const VERSION:String = "4.16.1.0";

        public function ArrayCollection(source:Array=null)
        {
            this.source = source;
        }

        [Inspectable(category="General", arrayType="Object")]
        [Bindable("listChanged")]
        public function get source():Array
        {
            if (((list) && (list is ArrayList)))
            {
                return (ArrayList(list).source);
            };
            return (null);
        }

        public function set source(s:Array):void
        {
            list = new ArrayList(s);
        }

        public function toJSON(s:String):*
        {
            return (toArray());
        }

        public function readExternal(input:IDataInput):void
        {
            if ((list is IExternalizable))
            {
                IExternalizable(list).readExternal(input);
            }
            else
            {
                this.source = (input.readObject() as Array);
            };
        }

        public function writeExternal(output:IDataOutput):void
        {
            if ((list is IExternalizable))
            {
                IExternalizable(list).writeExternal(output);
            }
            else
            {
                output.writeObject(this.source);
            };
        }


    }
} mx.collections

