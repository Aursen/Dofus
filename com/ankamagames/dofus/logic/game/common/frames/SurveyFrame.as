package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.dofus.logic.game.common.actions.SurveyNotificationAnswerAction;
    import com.ankamagames.dofus.misc.utils.SurveyManager;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.types.enums.Priority;

    public class SurveyFrame implements Frame 
    {


        public function pushed():Boolean
        {
            return (true);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var snaa:SurveyNotificationAnswerAction;
            switch (true)
            {
                case (msg is SurveyNotificationAnswerAction):
                    snaa = (msg as SurveyNotificationAnswerAction);
                    SurveyManager.getInstance().markSurveyAsDone(snaa.surveyId, snaa.accept);
                    return (true);
            };
            return (false);
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }


    }
}

