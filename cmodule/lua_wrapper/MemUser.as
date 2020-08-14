package cmodule.lua_wrapper
{
    public class MemUser 
    {


        final public function _mrd(_arg_1:int):Number
        {
            gstate.ds.position = _arg_1;
            return (gstate.ds.readDouble());
        }

        final public function _mrf(_arg_1:int):Number
        {
            gstate.ds.position = _arg_1;
            return (gstate.ds.readFloat());
        }

        final public function _mr32(_arg_1:int):int
        {
            gstate.ds.position = _arg_1;
            return (gstate.ds.readInt());
        }

        final public function _mru8(_arg_1:int):int
        {
            gstate.ds.position = _arg_1;
            return (gstate.ds.readUnsignedByte());
        }

        final public function _mw32(_arg_1:int, _arg_2:int):void
        {
            gstate.ds.position = _arg_1;
            gstate.ds.writeInt(_arg_2);
        }

        final public function _mrs8(_arg_1:int):int
        {
            gstate.ds.position = _arg_1;
            return (gstate.ds.readByte());
        }

        final public function _mw16(_arg_1:int, _arg_2:int):void
        {
            gstate.ds.position = _arg_1;
            gstate.ds.writeShort(_arg_2);
        }

        final public function _mw8(_arg_1:int, _arg_2:int):void
        {
            gstate.ds.position = _arg_1;
            gstate.ds.writeByte(_arg_2);
        }

        final public function _mrs16(_arg_1:int):int
        {
            gstate.ds.position = _arg_1;
            return (gstate.ds.readShort());
        }

        final public function _mru16(_arg_1:int):int
        {
            gstate.ds.position = _arg_1;
            return (gstate.ds.readUnsignedShort());
        }

        final public function _mwd(_arg_1:int, _arg_2:Number):void
        {
            gstate.ds.position = _arg_1;
            gstate.ds.writeDouble(_arg_2);
        }

        final public function _mwf(_arg_1:int, _arg_2:Number):void
        {
            gstate.ds.position = _arg_1;
            gstate.ds.writeFloat(_arg_2);
        }


    }
} cmodule.lua_wrapper

