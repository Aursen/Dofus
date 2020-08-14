package Ankama_Config.types
{
    public class ConfigProperty 
    {

        public var associatedComponent:*;
        public var associatedProperty:String;
        public var associatedConfigModule:String;

        public function ConfigProperty(associatedComponent:String, associatedProperty:String, associatedConfigModule:String)
        {
            this.associatedComponent = associatedComponent;
            this.associatedConfigModule = associatedConfigModule;
            this.associatedProperty = associatedProperty;
        }

    }
} Ankama_Config.types

