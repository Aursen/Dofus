package com.ankamagames.dofus.logic.game.common.managers
{
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.dofus.datacenter.misc.Subhint;
    import com.ankamagames.dofus.internalDatacenter.tutorial.SubhintWrapper;
    import com.ankamagames.dofus.logic.common.managers.UiHintManager;
    import com.ankamagames.dofus.uiApi.UiTutoApi;

    public class SubhintManager 
    {

        private static var _self:SubhintManager;
        public static var subhintDictionary:Dictionary = new Dictionary();
        public static var maxSubhintDate:Number = 0;

        private var _log:Logger = Log.getLogger(getQualifiedClassName(SubhintManager));

        public function SubhintManager()
        {
            if (_self)
            {
                throw (new SingletonError());
            };
        }

        public static function getInstance():SubhintManager
        {
            if (!_self)
            {
                _self = new (SubhintManager)();
            };
            return (_self);
        }


        public function init():void
        {
            this.createSubhintDictionary(Subhint.getSubhints());
        }

        private function createSubhintDictionary(result:Object):void
        {
            var subhintWrapper:SubhintWrapper;
            var subhint:Subhint;
            subhintDictionary = new Dictionary();
            for each (subhint in result)
            {
                if (subhint.hint_creation_date > maxSubhintDate)
                {
                    maxSubhintDate = subhint.hint_creation_date;
                };
                subhintWrapper = SubhintWrapper.create(subhint);
                if (!subhintDictionary[subhint.hint_parent_uid])
                {
                    subhintDictionary[subhint.hint_parent_uid] = [];
                };
                subhintDictionary[subhint.hint_parent_uid][(subhint.hint_order - 1)] = subhintWrapper;
            };
            UiHintManager.reloadHintState();
        }

        public function closeSubhint():void
        {
            UiTutoApi.getInstance().closeSubHints();
        }


    }
} com.ankamagames.dofus.logic.game.common.managers

