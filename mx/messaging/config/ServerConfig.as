package mx.messaging.config
{
    import mx.resources.IResourceManager;
    import mx.messaging.ChannelSet;
    import mx.resources.ResourceManager;
    import mx.core.mx_internal;
    import mx.utils.ObjectUtil;
    import mx.messaging.Channel;
    import mx.messaging.errors.InvalidDestinationError;
    import flash.utils.getQualifiedClassName;
    import mx.messaging.MessageAgent;
    import mx.messaging.errors.InvalidChannelError;
    import flash.utils.getDefinitionByName;
    import mx.collections.ArrayCollection;

    use namespace mx_internal;

    public class ServerConfig 
    {

        public static const CLASS_ATTR:String = "type";
        public static const URI_ATTR:String = "uri";
        private static var _resourceManager:IResourceManager;
        public static var serverConfigData:XML;
        private static var _channelSets:Object = {};
        private static var _clusteredChannels:Object = {};
        private static var _unclusteredChannels:Object = {};
        private static var _configFetchedChannels:Object;
        public static var channelSetFactory:Class = ChannelSet;


        private static function get resourceManager():IResourceManager
        {
            if (!_resourceManager)
            {
                _resourceManager = ResourceManager.getInstance();
            };
            return (_resourceManager);
        }

        public static function get xml():XML
        {
            if (serverConfigData == null)
            {
                serverConfigData = <services/>
                ;
            };
            return (serverConfigData);
        }

        public static function set xml(value:XML):void
        {
            serverConfigData = value;
            _channelSets = {};
            _clusteredChannels = {};
            _unclusteredChannels = {};
        }

        public static function checkChannelConsistency(destinationA:String, destinationB:String):void
        {
            var channelIdsA:Array = getChannelIdList(destinationA);
            var channelIdsB:Array = getChannelIdList(destinationB);
            if (ObjectUtil.compare(channelIdsA, channelIdsB) != 0)
            {
                throw (new ArgumentError("Specified destinations are not channel consistent"));
            };
        }

        public static function getChannel(id:String, clustered:Boolean=false):Channel
        {
            var channel:Channel;
            if (!clustered)
            {
                if ((id in _unclusteredChannels))
                {
                    return (_unclusteredChannels[id]);
                };
                channel = createChannel(id);
                _unclusteredChannels[id] = channel;
                return (channel);
            };
            if ((id in _clusteredChannels))
            {
                return (_clusteredChannels[id]);
            };
            channel = createChannel(id);
            _clusteredChannels[id] = channel;
            return (channel);
        }

        public static function getChannelSet(destinationId:String):ChannelSet
        {
            var destinationConfig:XML = getDestinationConfig(destinationId);
            return (internalGetChannelSet(destinationConfig, destinationId));
        }

        public static function getProperties(destinationId:String):XMLList
        {
            var destination:XMLList;
            var message:String;
            destination = xml..destination.(@id == destinationId);
            if (destination.length() > 0)
            {
                return (destination.properties);
            };
            message = resourceManager.getString("messaging", "unknownDestination", [destinationId]);
            throw (new InvalidDestinationError(message));
        }

        mx_internal static function channelSetMatchesDestinationConfig(channelSet:ChannelSet, destination:String):Boolean
        {
            var csUris:Array;
            var csChannels:Array;
            var i:uint;
            var ids:Array;
            var dsUris:Array;
            var dsChannels:XMLList;
            var channelConfig:XML;
            var endpoint:XML;
            var dsUri:String;
            var j:uint;
            if (channelSet != null)
            {
                if (ObjectUtil.compare(channelSet.channelIds, getChannelIdList(destination)) == 0)
                {
                    return (true);
                };
                csUris = [];
                csChannels = channelSet.channels;
                i = 0;
                while (i < csChannels.length)
                {
                    csUris.push(csChannels[i].uri);
                    i++;
                };
                ids = getChannelIdList(destination);
                dsUris = [];
                j = 0;
                while (j < ids.length)
                {
                    dsChannels = xml.channels.channel.(@id == ids[j]);
                    channelConfig = dsChannels[0];
                    endpoint = channelConfig.endpoint;
                    dsUri = ((endpoint.length() > 0) ? endpoint[0].attribute(URI_ATTR).toString() : null);
                    if (dsUri != null)
                    {
                        dsUris.push(dsUri);
                    };
                    j++;
                };
                return (ObjectUtil.compare(csUris, dsUris) == 0);
            };
            return (false);
        }

        mx_internal static function fetchedConfig(endpoint:String):Boolean
        {
            return ((!(_configFetchedChannels == null)) && (!(_configFetchedChannels[endpoint] == null)));
        }

        mx_internal static function getChannelIdList(destination:String):Array
        {
            var destinationConfig:XML = getDestinationConfig(destination);
            return ((destinationConfig) ? getChannelIds(destinationConfig) : (getDefaultChannelIds()));
        }

        mx_internal static function needsConfig(channel:Channel):Boolean
        {
            var channelSets:Array;
            var m:int;
            var i:int;
            var messageAgents:Array;
            var n:int;
            var j:int;
            if (((_configFetchedChannels == null) || (_configFetchedChannels[channel.endpoint] == null)))
            {
                channelSets = channel.channelSets;
                m = channelSets.length;
                i = 0;
                while (i < m)
                {
                    if (getQualifiedClassName(channelSets[i]).indexOf("Advanced") != -1)
                    {
                        return (true);
                    };
                    messageAgents = ChannelSet(channelSets[i]).messageAgents;
                    n = messageAgents.length;
                    j = 0;
                    while (j < n)
                    {
                        if (MessageAgent(messageAgents[j]).needsConfig)
                        {
                            return (true);
                        };
                        j++;
                    };
                    i++;
                };
            };
            return (false);
        }

        mx_internal static function updateServerConfigData(serverConfig:ConfigMap, endpoint:String=null):void
        {
            var newServices:XML;
            var newService:XML;
            var newChannels:XMLList;
            var oldServices:XMLList;
            var oldDestinations:XMLList;
            var newDestination:XML;
            var oldService:XML;
            var oldChannels:XML;
            if (serverConfig != null)
            {
                if (endpoint != null)
                {
                    if (_configFetchedChannels == null)
                    {
                        _configFetchedChannels = {};
                    };
                    _configFetchedChannels[endpoint] = true;
                };
                newServices = <services></services>
                ;
                convertToXML(serverConfig, newServices);
                xml["default-channels"] = newServices["default-channels"];
                for each (newService in newServices..service)
                {
                    oldServices = xml.service.(@id == newService.@id);
                    if (oldServices.length() != 0)
                    {
                        oldService = oldServices[0];
                        for each (newDestination in newService..destination)
                        {
                            oldDestinations = oldService.destination.(@id == newDestination.@id);
                            if (oldDestinations.length() != 0)
                            {
                                delete oldDestinations[0];
                            };
                            oldService.appendChild(newDestination.copy());
                        };
                    }
                    else
                    {
                        for each (newDestination in newService..destination)
                        {
                            oldDestinations = xml..destination.(@id == newDestination.@id);
                            if (oldDestinations.length() != 0)
                            {
                                oldDestinations[0] = newDestination[0].copy();
                                delete newService..destination.(@id == newDestination.@id)[0];
                            };
                        };
                        if (newService.children().length() > 0)
                        {
                            xml.appendChild(newService);
                        };
                    };
                };
                newChannels = newServices.channels;
                if (newChannels.length() > 0)
                {
                    oldChannels = xml.channels[0];
                    if (((oldChannels == null) || (oldChannels.length() == 0)))
                    {
                        xml.appendChild(newChannels);
                    };
                };
            };
        }

        private static function createChannel(channelId:String):Channel
        {
            var message:String;
            var channels:XMLList;
            var channelConfig:XML;
            var className:String;
            var endpoint:XMLList;
            var uri:String;
            var channel:Channel;
            var channelClass:Class;
            channels = xml.channels.channel.(@id == channelId);
            if (channels.length() == 0)
            {
                message = resourceManager.getString("messaging", "unknownChannelWithId", [channelId]);
                throw (new InvalidChannelError(message));
            };
            channelConfig = channels[0];
            className = channelConfig.attribute(CLASS_ATTR).toString();
            endpoint = channelConfig.endpoint;
            uri = ((endpoint.length() > 0) ? endpoint[0].attribute(URI_ATTR).toString() : null);
            channel = null;
            try
            {
                channelClass = (getDefinitionByName(className) as Class);
                channel = new (channelClass)(channelId, uri);
                channel.applySettings(channelConfig);
                if (((!(LoaderConfig.parameters == null)) && (!(LoaderConfig.parameters.WSRP_ENCODED_CHANNEL == null))))
                {
                    channel.url = LoaderConfig.parameters.WSRP_ENCODED_CHANNEL;
                };
            }
            catch(e:ReferenceError)
            {
                message = resourceManager.getString("messaging", "unknownChannelClass", [className]);
                throw (new InvalidChannelError(message));
            };
            return (channel);
        }

        private static function convertToXML(config:ConfigMap, configXML:XML):void
        {
            var propertyKey:Object;
            var propertyValue:Object;
            var propertyValueList:Array;
            var i:int;
            var propertyXML1:XML;
            var propertyXML2:XML;
            for (propertyKey in config)
            {
                propertyValue = config[propertyKey];
                if ((propertyValue is String))
                {
                    if (propertyKey == "")
                    {
                        configXML.appendChild(propertyValue);
                    }
                    else
                    {
                        configXML.@[propertyKey] = propertyValue;
                    };
                }
                else
                {
                    if (((propertyValue is ArrayCollection) || (propertyValue is Array)))
                    {
                        if ((propertyValue is ArrayCollection))
                        {
                            propertyValueList = ArrayCollection(propertyValue).toArray();
                        }
                        else
                        {
                            propertyValueList = (propertyValue as Array);
                        };
                        i = 0;
                        while (i < propertyValueList.length)
                        {
                            propertyXML1 = new (XML)((((("<" + propertyKey) + "></") + propertyKey) + ">"));
                            configXML.appendChild(propertyXML1);
                            convertToXML((propertyValueList[i] as ConfigMap), propertyXML1);
                            i++;
                        };
                    }
                    else
                    {
                        propertyXML2 = new (XML)((((("<" + propertyKey) + "></") + propertyKey) + ">"));
                        configXML.appendChild(propertyXML2);
                        convertToXML((propertyValue as ConfigMap), propertyXML2);
                    };
                };
            };
        }

        private static function getChannelIds(destinationConfig:XML):Array
        {
            var result:Array = [];
            var channels:XMLList = destinationConfig.channels.channel;
            var n:int = channels.length();
            var i:int;
            while (i < n)
            {
                result.push(channels[i].@ref.toString());
                i++;
            };
            return (result);
        }

        private static function getDefaultChannelIds():Array
        {
            var result:Array = [];
            var channels:XMLList = xml["default-channels"].channel;
            var n:int = channels.length();
            var i:int;
            while (i < n)
            {
                result.push(channels[i].@ref.toString());
                i++;
            };
            return (result);
        }

        private static function getDestinationConfig(destinationId:String):XML
        {
            var destinations:XMLList;
            var destinationCount:int;
            destinations = xml..destination.(@id == destinationId);
            destinationCount = destinations.length();
            if (destinationCount == 0)
            {
                return (null);
            };
            return (destinations[0]);
        }

        private static function internalGetChannelSet(destinationConfig:XML, destinationId:String):ChannelSet
        {
            var channelIds:Array;
            var clustered:Boolean;
            var message:String;
            var channelSet:ChannelSet;
            var heartbeatMillis:int;
            if (destinationConfig == null)
            {
                channelIds = getDefaultChannelIds();
                if (channelIds.length == 0)
                {
                    message = resourceManager.getString("messaging", "noChannelForDestination", [destinationId]);
                    throw (new InvalidDestinationError(message));
                };
                clustered = false;
            }
            else
            {
                channelIds = getChannelIds(destinationConfig);
                clustered = ((destinationConfig.properties.network.cluster.length() > 0) ? true : false);
            };
            var channelSetId:String = ((channelIds.join(",") + ":") + clustered);
            if ((channelSetId in _channelSets))
            {
                return (_channelSets[channelSetId]);
            };
            channelSet = new channelSetFactory(channelIds, clustered);
            heartbeatMillis = serverConfigData["flex-client"]["heartbeat-interval-millis"];
            if (heartbeatMillis > 0)
            {
                channelSet.heartbeatInterval = heartbeatMillis;
            };
            if (clustered)
            {
                channelSet.initialDestinationId = destinationId;
            };
            _channelSets[channelSetId] = channelSet;
            return (channelSet);
        }


    }
}

