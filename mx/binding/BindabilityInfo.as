package mx.binding
{
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;

    use namespace mx_internal;

    [ExcludeClass]
    public class BindabilityInfo 
    {

        mx_internal static const VERSION:String = "4.16.1.0";
        public static const BINDABLE:String = "Bindable";
        public static const MANAGED:String = "Managed";
        public static const CHANGE_EVENT:String = "ChangeEvent";
        public static const NON_COMMITTING_CHANGE_EVENT:String = "NonCommittingChangeEvent";
        public static const ACCESSOR:String = "accessor";
        public static const METHOD:String = "method";

        private var typeDescription:XML;
        private var classChangeEvents:Object;
        private var childChangeEvents:Object = {};

        public function BindabilityInfo(typeDescription:XML)
        {
            this.typeDescription = typeDescription;
        }

        public function getChangeEvents(childName:String):Object
        {
            var childDesc:XMLList;
            var numChildren:int;
            var changeEvents:Object = this.childChangeEvents[childName];
            if (!changeEvents)
            {
                changeEvents = this.copyProps(this.getClassChangeEvents(), {});
                childDesc = (this.typeDescription.accessor.(@name == childName) + this.typeDescription.method.(@name == childName));
                numChildren = childDesc.length();
                if (numChildren == 0)
                {
                    if (!this.typeDescription.@dynamic)
                    {
                        trace((((("warning: no describeType entry for '" + childName) + "' on non-dynamic type '") + this.typeDescription.@name) + "'"));
                    };
                }
                else
                {
                    if (numChildren > 1)
                    {
                        trace(((((("warning: multiple describeType entries for '" + childName) + "' on type '") + this.typeDescription.@name) + "':\n") + childDesc));
                    };
                    this.addBindabilityEvents(childDesc.metadata, changeEvents);
                };
                this.childChangeEvents[childName] = changeEvents;
            };
            return (changeEvents);
        }

        private function getClassChangeEvents():Object
        {
            if (!this.classChangeEvents)
            {
                this.classChangeEvents = {};
                this.addBindabilityEvents(this.typeDescription.metadata, this.classChangeEvents);
                if (this.typeDescription.metadata.(@name == MANAGED).length() > 0)
                {
                    this.classChangeEvents[PropertyChangeEvent.PROPERTY_CHANGE] = true;
                };
            };
            return (this.classChangeEvents);
        }

        private function addBindabilityEvents(metadata:XMLList, eventListObj:Object):void
        {
            this.addChangeEvents(metadata.(@name == BINDABLE), eventListObj, true);
            this.addChangeEvents(metadata.(@name == CHANGE_EVENT), eventListObj, true);
            this.addChangeEvents(metadata.(@name == NON_COMMITTING_CHANGE_EVENT), eventListObj, false);
        }

        private function addChangeEvents(metadata:XMLList, eventListObj:Object, isCommit:Boolean):void
        {
            var md:XML;
            var arg:XMLList;
            var eventName:String;
            for each (md in metadata)
            {
                arg = md.arg;
                if (arg.length() > 0)
                {
                    eventName = arg[0].@value;
                    eventListObj[eventName] = isCommit;
                }
                else
                {
                    trace((("warning: unconverted Bindable metadata in class '" + this.typeDescription.@name) + "'"));
                };
            };
        }

        private function copyProps(from:Object, _arg_2:Object):Object
        {
            var propName:String;
            for (propName in from)
            {
                _arg_2[propName] = from[propName];
            };
            return (_arg_2);
        }


    }
} mx.binding

