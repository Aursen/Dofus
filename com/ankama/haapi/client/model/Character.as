package com.ankama.haapi.client.model
{
    import flash.utils.Dictionary;

    public class Character 
    {

        public var id:Number = 0;
        public var name:String = null;
        public var experience:Number = 0;
        public var level:Number = 0;
        public var breed_id:Number = 0;
        public var sex_id:Number = 0;
        public var face_id:Number = 0;
        private var _images_obj_class:Dictionary = null;
        public var images:Dictionary = new Dictionary();
        private var _colors_obj_class:Dictionary = null;
        public var colors:Dictionary = new Dictionary();
        public var guild:Guild = null;


        public function toString():String
        {
            var str:String = "Character: ";
            str = (str + ((" (id: " + this.id) + ")"));
            str = (str + ((" (name: " + this.name) + ")"));
            str = (str + ((" (experience: " + this.experience) + ")"));
            str = (str + ((" (level: " + this.level) + ")"));
            str = (str + ((" (breed_id: " + this.breed_id) + ")"));
            str = (str + ((" (sex_id: " + this.sex_id) + ")"));
            str = (str + ((" (face_id: " + this.face_id) + ")"));
            str = (str + ((" (images: " + this.images) + ")"));
            str = (str + ((" (colors: " + this.colors) + ")"));
            str = (str + ((" (guild: " + this.guild) + ")"));
            return (str);
        }


    }
}

