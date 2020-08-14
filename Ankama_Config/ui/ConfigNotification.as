package Ankama_Config.ui
{
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.uiApi.DataApi;
    import com.ankamagames.berilia.types.graphic.ButtonContainer;
    import com.ankamagames.berilia.components.ComboBox;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.TextureBitmap;
    import d2hooks.ExternalNotificationsOptionsUpdate;
    import Ankama_Config.types.ConfigProperty;
    import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
    import com.ankamagames.dofus.datacenter.externalnotifications.ExternalNotification;
    import __AS3__.vec.*;

    public class ConfigNotification extends ConfigUi 
    {

        private static var _componentDataAssoc:Dictionary;
        private static var _cb_notifModeDp:Array;
        private static var _cb_displayDurationDp:Array;
        private static var _cb_maxNumberDp:Array;
        private static var _cb_notifPositionDp:Array;
        private static var _events:Array;

        [Api(name="DataApi")]
        public var dataApi:DataApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _eventBtnList:Dictionary = new Dictionary(true);
        private var _soundBtnList:Dictionary = new Dictionary(true);
        private var _notifyBtnList:Dictionary = new Dictionary(true);
        private var _multiBtnList:Dictionary = new Dictionary(true);
        public var btn_alphaWindows:ButtonContainer;
        public var cb_notifMode:ComboBox;
        public var cb_displayDuration:ComboBox;
        public var cb_maxNumber:ComboBox;
        public var cb_notifPosition:ComboBox;
        public var gd_notifications:Grid;
        public var tx_bgForeground2:TextureBitmap;


        private static function getEventByType(pNotifType:int):Object
        {
            var event:Object;
            for each (event in _events)
            {
                if (event.notifType == pNotifType)
                {
                    return (event);
                };
            };
            return (null);
        }

        private static function addComponentData(component:*, componentValue:*, propertyValue:*):void
        {
            if (!_componentDataAssoc[component.name])
            {
                _componentDataAssoc[component.name] = new Vector.<ComponentData>(0);
            };
            _componentDataAssoc[component.name].push(new ComponentData(propertyValue, componentValue));
        }

        private static function getComponentDataProvider(component:*):Array
        {
            var componentData:ComponentData;
            var dp:Array = [];
            var i:int;
            while (i < _componentDataAssoc[component.name].length)
            {
                componentData = _componentDataAssoc[component.name][i];
                dp.push(componentData.componentValue);
                i++;
            };
            return (dp);
        }

        private static function getComponentValue(component:*, propertyValue:*):*
        {
            var componentData:ComponentData;
            if (_componentDataAssoc[component.name])
            {
                for each (componentData in _componentDataAssoc[component.name])
                {
                    if (componentData.propertyValue == propertyValue)
                    {
                        return (componentData.componentValue);
                    };
                };
            };
            return (null);
        }

        private static function getPropertyValue(component:*, componentValue:*):*
        {
            var componentData:ComponentData;
            if (_componentDataAssoc[component.name])
            {
                for each (componentData in _componentDataAssoc[component.name])
                {
                    if (componentData.componentValue == componentValue)
                    {
                        return (componentData.propertyValue);
                    };
                };
            };
            return (null);
        }


        public function main(args:*):void
        {
            var i:int;
            var e:Object;
            var forcedEvents:Array;
            var numEvents:uint;
            var notifType:int;
            var tab:Array;
            var eventOptions:Object;
            sysApi.addHook(ExternalNotificationsOptionsUpdate, this.onOptionsUpdate);
            if (!_componentDataAssoc)
            {
                _componentDataAssoc = new Dictionary();
                addComponentData(this.cb_notifMode, uiApi.getText("ui.common.none"), 0);
                addComponentData(this.cb_notifMode, uiApi.getText("ui.alert.activation.noFocusOnOneClient"), 1);
                addComponentData(this.cb_notifMode, uiApi.getText("ui.alert.activation.minimizedOneClient"), 2);
                addComponentData(this.cb_notifMode, uiApi.getText("ui.alert.activation.noFocusOnAnyClient"), 3);
                _cb_notifModeDp = getComponentDataProvider(this.cb_notifMode);
                addComponentData(this.cb_displayDuration, uiApi.getText("ui.alert.displayDuration1"), 3);
                addComponentData(this.cb_displayDuration, uiApi.getText("ui.alert.displayDuration2"), 5);
                addComponentData(this.cb_displayDuration, uiApi.getText("ui.alert.displayDuration3"), 10);
                addComponentData(this.cb_displayDuration, uiApi.getText("ui.alert.displayDuration4"), 30);
                addComponentData(this.cb_displayDuration, uiApi.getText("ui.alert.displayDuration5"), 60);
                _cb_displayDurationDp = getComponentDataProvider(this.cb_displayDuration);
                addComponentData(this.cb_maxNumber, "1", 1);
                addComponentData(this.cb_maxNumber, "3", 3);
                addComponentData(this.cb_maxNumber, "5", 5);
                addComponentData(this.cb_maxNumber, "10", 10);
                _cb_maxNumberDp = getComponentDataProvider(this.cb_maxNumber);
                addComponentData(this.cb_notifPosition, uiApi.getText("ui.alert.position.bottomRightCorner"), 0);
                addComponentData(this.cb_notifPosition, uiApi.getText("ui.alert.position.bottomLeftCorner"), 1);
                addComponentData(this.cb_notifPosition, uiApi.getText("ui.alert.position.topRightCorner"), 2);
                addComponentData(this.cb_notifPosition, uiApi.getText("ui.alert.position.topLeftCorner"), 3);
                _cb_notifPositionDp = getComponentDataProvider(this.cb_notifPosition);
            };
            var properties:Array = [];
            properties.push(new ConfigProperty("btn_alphaWindows", "notificationsAlphaWindows", "dofus"));
            properties.push(new ConfigProperty("cb_notifMode", "notificationsMode", "dofus"));
            properties.push(new ConfigProperty("cb_displayDuration", "notificationsDisplayDuration", "dofus"));
            properties.push(new ConfigProperty("cb_maxNumber", "notificationsMaxNumber", "dofus"));
            properties.push(new ConfigProperty("cb_notifPosition", "notificationsPosition", "dofus"));
            init(properties);
            if (!_events)
            {
                _events = [];
                forcedEvents = [];
                numEvents = this.dataApi.getExternalNotifications().length;
                for each (notifType in ExternalNotificationTypeEnum.NOTIFICATIONSARRAY)
                {
                    tab = ((notifType > numEvents) ? forcedEvents : _events);
                    tab.push({
                        "text":this.getEventDescription(notifType),
                        "notifType":notifType
                    });
                };
                _events.sortOn("notifType", Array.NUMERIC);
                forcedEvents.sortOn("notifType", (Array.NUMERIC | Array.DESCENDING));
                i = 0;
                while (i < forcedEvents.length)
                {
                    _events.splice(0, 0, forcedEvents[i]);
                    i++;
                };
            };
            for each (e in _events)
            {
                eventOptions = configApi.getExternalNotificationOptions(e.notifType);
                if (eventOptions.hasOwnProperty("active"))
                {
                    e.active = eventOptions.active;
                }
                else
                {
                    e.active = true;
                };
                if (eventOptions.hasOwnProperty("sound"))
                {
                    e.sound = eventOptions.sound;
                }
                else
                {
                    e.sound = true;
                };
                if (eventOptions.hasOwnProperty("notify"))
                {
                    e.notify = eventOptions.notify;
                }
                else
                {
                    e.notify = true;
                };
                if (eventOptions.hasOwnProperty("multi"))
                {
                    e.multi = eventOptions.multi;
                }
                else
                {
                    e.multi = true;
                };
            };
            this.cb_notifMode.dataProvider = _cb_notifModeDp;
            this.cb_notifMode.value = getComponentValue(this.cb_notifMode, sysApi.getOption("notificationsMode", "dofus"));
            this.cb_notifMode.dataNameField = "";
            this.cb_displayDuration.dataProvider = _cb_displayDurationDp;
            this.cb_displayDuration.value = getComponentValue(this.cb_displayDuration, sysApi.getOption("notificationsDisplayDuration", "dofus"));
            this.cb_displayDuration.dataNameField = "";
            this.cb_maxNumber.dataProvider = _cb_maxNumberDp;
            this.cb_maxNumber.value = getComponentValue(this.cb_maxNumber, sysApi.getOption("notificationsMaxNumber", "dofus"));
            this.cb_maxNumber.dataNameField = "";
            this.cb_notifPosition.dataProvider = _cb_notifPositionDp;
            this.cb_notifPosition.value = getComponentValue(this.cb_notifPosition, sysApi.getOption("notificationsPosition", "dofus"));
            this.cb_notifPosition.dataNameField = "";
            this.gd_notifications.height = (_events.length * this.gd_notifications.slotHeight);
            this.tx_bgForeground2.height = (this.gd_notifications.height + 50);
            this.gd_notifications.dataProvider = _events;
        }

        private function getEventDescription(pEventType:int):String
        {
            var extNotif:ExternalNotification;
            var extNotifs:Object = this.dataApi.getExternalNotifications();
            if (pEventType == ExternalNotificationTypeEnum.ACHIEVEMENT_UNLOCKED)
            {
                return (uiApi.getText("ui.achievement.achievement"));
            };
            if (pEventType == ExternalNotificationTypeEnum.QUEST_VALIDATED)
            {
                return (uiApi.getText("ui.almanax.questDone"));
            };
            for each (extNotif in extNotifs)
            {
                if (ExternalNotificationTypeEnum[extNotif.name] == pEventType)
                {
                    return (extNotif.description);
                };
            };
            return (null);
        }

        public function onOptionsUpdate(options:Object):void
        {
            var notifType:String;
            var e:Object;
            for (notifType in options)
            {
                e = getEventByType(parseInt(notifType));
                e.active = options[notifType].active;
                e.sound = options[notifType].sound;
                e.notify = options[notifType].notify;
                e.multi = options[notifType].multi;
            };
            this.gd_notifications.dataProvider = _events;
        }

        override public function reset():void
        {
            var property:ConfigProperty;
            var needMultiAccountSynchronize:Boolean;
            var notifData:Dictionary;
            var extNotif:ExternalNotification;
            var e:Object;
            var component:*;
            var propertyValue:*;
            var componentValue:*;
            var multiDefault:Boolean;
            super.reset();
            for each (property in _properties)
            {
                component = uiApi.me().getElement(property.associatedComponent);
                propertyValue = configApi.getConfigProperty(property.associatedConfigModule, property.associatedProperty);
                componentValue = getComponentValue(component, propertyValue);
                if (componentValue)
                {
                    component.value = componentValue;
                }
                else
                {
                    component.value = propertyValue;
                };
            };
            notifData = new Dictionary();
            for each (extNotif in this.dataApi.getExternalNotifications())
            {
                notifData[ExternalNotificationTypeEnum[extNotif.name]] = extNotif;
            };
            for each (e in _events)
            {
                extNotif = notifData[e.notifType];
                e.active = ((extNotif) ? extNotif.defaultEnable : true);
                e.sound = ((extNotif) ? extNotif.defaultSound : true);
                e.notify = ((extNotif) ? extNotif.defaultNotify : true);
                multiDefault = ((extNotif) ? extNotif.defaultMultiAccount : true);
                if (e.multi != multiDefault)
                {
                    needMultiAccountSynchronize = true;
                };
                e.multi = multiDefault;
                configApi.setExternalNotificationOptions(e.notifType, e, false);
            };
            if (needMultiAccountSynchronize)
            {
                configApi.synchronizeExternalNotificationsMultiAccount();
            };
            this.gd_notifications.dataProvider = _events;
        }

        public function updateNotificationLine(data:*, componentsRef:*, selected:Boolean):void
        {
            this._eventBtnList[componentsRef.btn_activate.name] = data;
            this._soundBtnList[componentsRef.btn_sound.name] = data;
            this._notifyBtnList[componentsRef.btn_notify.name] = data;
            this._multiBtnList[componentsRef.btn_multi.name] = data;
            if (data)
            {
                componentsRef.btn_label_btn_activate.text = data.text;
                data = getEventByType(data.notifType);
                componentsRef.btn_activate.selected = data.active;
                componentsRef.btn_sound.uri = uiApi.createUri(((uiApi.me().getConstant("alertIcon") + ((data.sound) ? "audio_selected" : "audio_normal")) + ".png"));
                componentsRef.btn_sound.finalize();
                componentsRef.btn_notify.uri = uiApi.createUri(((uiApi.me().getConstant("alertIcon") + ((data.notify) ? "page_selected" : "page_normal")) + ".png"));
                componentsRef.btn_notify.finalize();
                componentsRef.btn_multi.uri = uiApi.createUri(((uiApi.me().getConstant("alertIcon") + ((data.multi) ? "multi_selected" : "multi_normal")) + ".png"));
                componentsRef.btn_multi.finalize();
                componentsRef.btn_activate.visible = true;
                componentsRef.btn_sound.visible = data.hasOwnProperty("sound");
                componentsRef.btn_notify.visible = data.hasOwnProperty("notify");
                componentsRef.btn_multi.visible = data.hasOwnProperty("multi");
            }
            else
            {
                componentsRef.btn_activate.visible = false;
                componentsRef.btn_sound.visible = false;
                componentsRef.btn_notify.visible = false;
                componentsRef.btn_multi.visible = false;
            };
        }

        public function onMouseUp(target:Object):void
        {
            var event:Object;
            if (target.name.indexOf("btn_activate") != -1)
            {
                event = this._eventBtnList[target.name];
                this.updateEventOptions(event.notifType, "active");
            }
            else
            {
                if (target.name.indexOf("btn_sound") != -1)
                {
                    event = this._soundBtnList[target.name];
                    this.updateEventOptions(event.notifType, "sound");
                }
                else
                {
                    if (target.name.indexOf("btn_notify") != -1)
                    {
                        event = this._notifyBtnList[target.name];
                        this.updateEventOptions(event.notifType, "notify");
                    }
                    else
                    {
                        if (target.name.indexOf("btn_multi") != -1)
                        {
                            event = this._multiBtnList[target.name];
                            this.updateEventOptions(event.notifType, "multi");
                        }
                        else
                        {
                            if (target.name.indexOf("btn_alphaWindows") != -1)
                            {
                                setProperty("dofus", "notificationsAlphaWindows", target.selected);
                            };
                        };
                    };
                };
            };
            this.gd_notifications.updateItem(parseInt(target.name.split("_").reverse()[0]));
        }

        private function updateEventOptions(pEventType:int, pEventOptionName:String):Boolean
        {
            var event:Object = getEventByType(pEventType);
            event[pEventOptionName] = (!(event[pEventOptionName]));
            configApi.setExternalNotificationOptions(event.notifType, event);
            return (event[pEventOptionName]);
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            switch (target)
            {
                case this.cb_notifMode:
                    setProperty("dofus", "notificationsMode", this.cb_notifMode.selectedIndex);
                    break;
                case this.cb_displayDuration:
                    setProperty("dofus", "notificationsDisplayDuration", getPropertyValue(this.cb_displayDuration, this.cb_displayDuration.value));
                    break;
                case this.cb_maxNumber:
                    setProperty("dofus", "notificationsMaxNumber", int(this.cb_maxNumber.selectedItem));
                    break;
                case this.cb_notifPosition:
                    setProperty("dofus", "notificationsPosition", this.cb_notifPosition.selectedIndex);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var event:Object;
            var point:uint = 7;
            var relPoint:uint = 1;
            if (target.name.indexOf("btn_sound") != -1)
            {
                event = this._soundBtnList[target.name];
                if (getEventByType(event.notifType).sound == true)
                {
                    tooltipText = uiApi.getText("ui.alert.info.sound.deactivate");
                }
                else
                {
                    tooltipText = uiApi.getText("ui.alert.info.sound.activate");
                };
            }
            else
            {
                if (target.name.indexOf("btn_multi") != -1)
                {
                    event = this._multiBtnList[target.name];
                    if (getEventByType(event.notifType).multi == true)
                    {
                        tooltipText = uiApi.getText("ui.alert.info.multi.deactivate");
                    }
                    else
                    {
                        tooltipText = uiApi.getText("ui.alert.info.multi.activate");
                    };
                }
                else
                {
                    if (target.name.indexOf("btn_notify") != -1)
                    {
                        event = this._notifyBtnList[target.name];
                        if (getEventByType(event.notifType).notify == true)
                        {
                            tooltipText = uiApi.getText("ui.alert.info.notify.deactivate");
                        }
                        else
                        {
                            tooltipText = uiApi.getText("ui.alert.info.notify.activate");
                        };
                    };
                };
            };
            if (tooltipText != "")
            {
                uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText), target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            uiApi.hideTooltip();
        }


    }
} Ankama_Config.ui

class ComponentData 
{

    public var propertyValue:*;
    public var componentValue:*;

    public function ComponentData(propertyValue:*, componentValue:*)
    {
        this.propertyValue = propertyValue;
        this.componentValue = componentValue;
    }

}


