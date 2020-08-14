package com.ankamagames.jerakine.utils.benchmark.monitoring
{
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class MonitoredObject 
    {

        public var name:String;
        public var list:Dictionary;
        public var data:Vector.<Number>;
        public var limits:Vector.<Number>;
        public var color:uint;
        public var selected:Boolean = false;
        private var _extendsClass:List;

        public function MonitoredObject(pName:String, pColor:uint, pParentList:List=null):void
        {
            this.name = pName;
            this.list = new Dictionary(true);
            this.data = new Vector.<Number>();
            this.limits = new Vector.<Number>();
            this.color = pColor;
            this._extendsClass = pParentList;
        }

        public function addNewValue(o:Object):void
        {
            this.list[o] = null;
        }

        public function update():void
        {
            this.data.push(FpsManagerUtils.countKeys(this.list));
            this.limits.push(FpsManagerUtils.getVectorMaxValue(this.data));
            if (this.data.length > FpsManagerConst.BOX_WIDTH)
            {
                this.data.shift();
                this.limits.shift();
            };
        }

        public function get extendsClass():List
        {
            return (this._extendsClass);
        }


    }
} com.ankamagames.jerakine.utils.benchmark.monitoring

