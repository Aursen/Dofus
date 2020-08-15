package com.ankamagames.atouin.data.map.elements
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.atouin.data.map.Cell;
    import com.ankamagames.atouin.enums.ElementTypesEnum;
    import flash.utils.IDataInput;

    public class BasicElement 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BasicElement));

        private var _cell:Cell;

        public function BasicElement(cell:Cell)
        {
            this._cell = cell;
        }

        public static function getElementFromType(_arg_1:int, cell:Cell):BasicElement
        {
            switch (_arg_1)
            {
                case ElementTypesEnum.GRAPHICAL:
                    return (new GraphicalElement(cell));
                case ElementTypesEnum.SOUND:
                    return (new SoundElement(cell));
            };
            throw (new UnknownElementError((((("Un élément de type inconnu " + _arg_1) + " a été trouvé sur la cellule ") + cell.cellId) + "!")));
        }


        public function get cell():Cell
        {
            return (this._cell);
        }

        public function get elementType():int
        {
            return (-1);
        }

        public function fromRaw(raw:IDataInput, mapVersion:int):void
        {
            throw (new Error("Cette méthode doit être surchargée !"));
        }


    }
}

