package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.DataStoreType;
    import __AS3__.vec.Vector;
    import com.ankama.haapi.client.api.CmsPollInGameApi;
    import com.ankamagames.dofus.logic.game.common.frames.SurveyFrame;
    import org.openapitools.common.ApiUserCredentials;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.jerakine.managers.LangManager;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.common.managers.NotificationManager;
    import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
    import org.openapitools.event.ApiClientEvent;
    import com.ankama.haapi.client.model.CmsPollInGame;
    import __AS3__.vec.*;

    public class SurveyManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SurveyManager));
        private static const IGNORE_SURVEY_TRESHOLD_CANCELLATION:uint = 3;
        private static const MINIMUM_TIME_BETWEEN_SURVEYS:Number = 86400000;
        private static var _singleton:SurveyManager;

        private var _dataStore:DataStoreType;
        private var _surveys:Vector.<Survey>;
        private var _surveyApi:CmsPollInGameApi;
        private var _currentLocale:String;
        private var _surveyFrame:SurveyFrame;
        private var _apiCredentials:ApiUserCredentials;

        public function SurveyManager()
        {
            this._dataStore = new DataStoreType("Dofus_Surveys", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
            this._apiCredentials = new ApiUserCredentials("", XmlConfig.getInstance().getEntry("config.haapiUrlAnkama"), null);
            this._surveyApi = new CmsPollInGameApi(this._apiCredentials);
            this._currentLocale = LangManager.getInstance().getEntry("config.lang.current");
        }

        public static function getInstance():SurveyManager
        {
            if (!_singleton)
            {
                _singleton = new (SurveyManager)();
            };
            return (_singleton);
        }


        public function pullSurveys():void
        {
            if (((this.userAcceptsSurveys) && (!(this.userAcceptedSurveyRecently))))
            {
                this.getSurveysFromHaapi();
            };
        }

        public function checkSurveys():void
        {
            var i:int;
            if (((this._surveys) && (!(this.hasSurveyNotificationWaitingForAnswer))))
            {
                i = 0;
                while (i < this._surveys.length)
                {
                    if (this._surveys[i].readyForPlayer)
                    {
                        this.addNotificationForSurvey(this._surveys[i]);
                        break;
                    };
                    i++;
                };
            };
        }

        public function markSurveyAsDone(surveyId:Number, accepted:Boolean):void
        {
            var surveyUrl:String;
            var survey:Survey;
            var totalClosedSurveys:uint;
            for each (survey in this._surveys)
            {
                if (survey.id == surveyId)
                {
                    surveyUrl = survey.url;
                    this._surveys.splice(this._surveys.indexOf(survey), 1);
                    break;
                };
            };
            if (((accepted) && (surveyUrl)))
            {
                navigateToURL(new URLRequest(surveyUrl), "_blank");
                StoreDataManager.getInstance().setData(this._dataStore, "lastAcceptedSurveyDate", new Date());
            }
            else
            {
                totalClosedSurveys = StoreDataManager.getInstance().getSetData(this._dataStore, "totalClosedSurveys", 0);
                StoreDataManager.getInstance().setData(this._dataStore, "totalClosedSurveys", totalClosedSurveys++);
            };
            this.setSurveyAsDoneOnHaapi(surveyId);
        }

        private function addNotificationForSurvey(survey:Survey):void
        {
            if (!this._surveyFrame)
            {
                this._surveyFrame = new SurveyFrame();
            };
            Kernel.getWorker().addFrame(this._surveyFrame);
            var notificationMessage:String = survey.description;
            if (!notificationMessage)
            {
                notificationMessage = I18n.getUiText("ui.surveys.notificationContent", [survey.title]);
            };
            var surveyNotifId:uint = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.surveys.notificationTitle"), notificationMessage, NotificationTypeEnum.SURVEY_INVITATION, ("surveyNotification_" + survey.id));
            NotificationManager.getInstance().addButtonToNotification(surveyNotifId, I18n.getUiText("ui.common.refuse"), "SurveyNotificationAnswer", [survey.id, false], true, 130);
            NotificationManager.getInstance().addButtonToNotification(surveyNotifId, I18n.getUiText("ui.common.accept"), "SurveyNotificationAnswer", [survey.id, true], true, 130);
            NotificationManager.getInstance().addCallbackToNotification(surveyNotifId, "SurveyNotificationAnswer", [survey.id, false]);
            NotificationManager.getInstance().sendNotification(surveyNotifId);
        }

        private function get hasSurveyNotificationWaitingForAnswer():Boolean
        {
            return (!(Kernel.getWorker().getFrame(SurveyFrame) == null));
        }

        private function get userAcceptsSurveys():Boolean
        {
            return (StoreDataManager.getInstance().getSetData(this._dataStore, "totalClosedSurveys", 0) <= IGNORE_SURVEY_TRESHOLD_CANCELLATION);
        }

        private function get userAcceptedSurveyRecently():Boolean
        {
            var lastAcceptedSurveyDate:Date = StoreDataManager.getInstance().getData(this._dataStore, "lastAcceptedSurveyDate");
            if (!lastAcceptedSurveyDate)
            {
                return (false);
            };
            return ((new Date().time - lastAcceptedSurveyDate.time) < MINIMUM_TIME_BETWEEN_SURVEYS);
        }

        private function getSurveysFromHaapi():void
        {
            HaapiKeyManager.getInstance().callWithApiKey(function (apiKey:String):void
            {
                _apiCredentials.apiToken = apiKey;
                _surveyApi.get("DOFUS", _currentLocale, 1, 42).onSuccess(onSurveysReceived).onError(onSurveysError).call();
            });
        }

        private function setSurveyAsDoneOnHaapi(surveyId:Number):void
        {
            HaapiKeyManager.getInstance().callWithApiKey(function (apiKey:String):void
            {
                _surveyApi.addEventListener(ApiClientEvent.SUCCESS_EVENT, onSurveyMarkedAsDoneReceived);
                _surveyApi.addEventListener(ApiClientEvent.FAILURE_EVENT, onSurveyMarkedAsDoneError);
                _surveyApi.mark_as_read(surveyId).onSuccess(onSurveyMarkedAsDoneReceived).onError(onSurveyMarkedAsDoneError).call();
            });
        }

        private function onSurveysReceived(pEvent:ApiClientEvent):void
        {
            var survey:CmsPollInGame;
            if (pEvent.response.payload == null)
            {
                _log.error("Api Error: Surveys requested data is corrupted");
                return;
            };
            this._surveys = new Vector.<Survey>();
            var results:Array = (pEvent.response.payload as Array);
            if (((results) && (results.length)))
            {
                for each (survey in results)
                {
                    this._surveys.push(new Survey(survey));
                };
            };
            this.checkSurveys();
        }

        protected function onSurveysError(pEvent:ApiClientEvent):void
        {
            this._surveys = null;
            _log.error(("Failed to retrieve surveys data, error:\n" + pEvent.response.errorMessage));
        }

        private function onSurveyMarkedAsDoneReceived(pEvent:ApiClientEvent):void
        {
            Kernel.getWorker().removeFrame(this._surveyFrame);
        }

        private function onSurveyMarkedAsDoneError(pEvent:ApiClientEvent):void
        {
            Kernel.getWorker().removeFrame(this._surveyFrame);
            _log.error(("Failed to mark survey as done, error:\n" + pEvent.response.errorMessage));
        }


    }
} com.ankamagames.dofus.misc.utils

