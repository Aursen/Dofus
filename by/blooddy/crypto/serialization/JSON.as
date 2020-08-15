package by.blooddy.crypto.serialization
{
    import flash.utils.ByteArray;
    import flash.utils.Endian;
    import __AS3__.vec.Vector;
    import flash.xml.XMLDocument;
    import flash.errors.StackOverflowError;
    import flash.utils.Dictionary;
    import flash.system.ApplicationDomain;
    import avm2.intrinsics.memory.*; // ASC2.0, AIR3.6 SDK and above, FlasCC (Alchemy)

    public class JSON 
    {

        public function JSON():void
        {
        }

        public static function encode(_arg_1:*):String
        {
            var _local_2:Object = XML.settings();
            XML.setSettings({
                "ignoreComments":true,
                "ignoreProcessingInstructions":false,
                "ignoreWhitespace":true,
                "prettyIndent":false,
                "prettyPrinting":false
            });
            var _local_3:ByteArray = new ByteArray();
            _local_3.writeUTFBytes("0123456789abcdef");
            var _local_4:ByteArray = new ByteArray();
            _local_4.endian = Endian.LITTLE_ENDIAN;
            var cvint:Class = (new Vector.<int>() as Object).constructor;
            var cvuint:Class = (new Vector.<uint>() as Object).constructor;
            var cvdouble:Class = (new Vector.<Number>() as Object).constructor;
            var cvobject:Class = (new Vector.<Object>() as Object).constructor;
            var writeValue:Function;
            writeValue = function (_arg_1:Dictionary, _arg_2:ByteArray, _arg_3:ByteArray, _arg_4:*):*
            {
                var _local_7:int;
                var _local_8:int;
                var _local_9:Number;
                var _local_10:* = (null as String);
                var _local_11:Boolean;
                var _local_12:* = (null as Array);
                var _local_13:* = null;
                var _local_14:* = (null as Array);
                var _local_15:int;
                var _local_16:* = null;
                var _local_17:Boolean;
                var _local_18:uint;
                var _local_19:uint;
                var _local_20:uint;
                var _local_21:uint;
                var _local_22:uint;
                var _local_6:String = typeof(_arg_4);
                if (_local_6 == "number")
                {
                    if (isFinite(_arg_4))
                    {
                        if (((_arg_4 >= (0)) && ((_arg_4 <= (9)) && ((_arg_4 % 1) == 0))))
                        {
                            _arg_2.writeByte((48 + _arg_4));
                        }
                        else
                        {
                            _arg_2.writeUTFBytes(_arg_4.toString());
                        };
                    }
                    else
                    {
                        _arg_2.writeInt(1819047278);
                    };
                }
                else
                {
                    if (_local_6 == "boolean")
                    {
                        if (_arg_4)
                        {
                            _arg_2.writeInt(1702195828);
                        }
                        else
                        {
                            _arg_2.writeInt(1936482662);
                            _arg_2.writeByte(101);
                        };
                    }
                    else
                    {
                        if (_local_6 == "xml")
                        {
                            _arg_4 = _arg_4.toXMLString();
                            _local_6 = "string";
                        }
                        else
                        {
                            if (((_arg_4) && (_local_6 == "object")))
                            {
                                if ((_arg_4 is XMLDocument))
                                {
                                    if (_arg_4.childNodes.length > 0)
                                    {
                                        _arg_4 = new XML(_arg_4).toXMLString();
                                        _local_6 = "string";
                                    }
                                    else
                                    {
                                        _arg_2.writeShort(0x2222);
                                    };
                                }
                                else
                                {
                                    if ((_arg_4 in _arg_1))
                                    {
                                        Error.throwError(StackOverflowError, 2024);
                                    };
                                    _arg_1[_arg_4] = true;
                                    _local_7 = 0;
                                    if (((_arg_4 is Array) || (_arg_4 is cvobject)))
                                    {
                                        _arg_2.writeByte(91);
                                        _local_8 = (_arg_4.length - 1);
                                        while (((_local_8 >= (0)) && (_arg_4[_local_8] == null)))
                                        {
                                            _local_8--;
                                        };
                                        if (++_local_8 > 0)
                                        {
                                            (writeValue(_arg_1, _arg_2, _arg_3, _arg_4[0]));
                                            while (++_local_7 < _local_8)
                                            {
                                                _arg_2.writeByte(44);
                                                (writeValue(_arg_1, _arg_2, _arg_3, _arg_4[_local_7]));
                                            };
                                        };
                                        _arg_2.writeByte(93);
                                    }
                                    else
                                    {
                                        if (((_arg_4 is cvint) || (_arg_4 is cvuint)))
                                        {
                                            _arg_2.writeByte(91);
                                            _local_8 = _arg_4.length;
                                            if (_local_8 > 0)
                                            {
                                                _local_9 = _arg_4[0];
                                                if (((_local_9 >= (0)) && ((_local_9 <= (9)) && ((_local_9 % 1) == 0))))
                                                {
                                                    _arg_2.writeByte((48 + _local_9));
                                                }
                                                else
                                                {
                                                    _arg_2.writeUTFBytes(_local_9.toString());
                                                };
                                                while (++_local_7 < _local_8)
                                                {
                                                    _arg_2.writeByte(44);
                                                    _local_9 = _arg_4[_local_7];
                                                    if (((_local_9 >= (0)) && ((_local_9 <= (9)) && ((_local_9 % 1) == 0))))
                                                    {
                                                        _arg_2.writeByte((48 + _local_9));
                                                    }
                                                    else
                                                    {
                                                        _arg_2.writeUTFBytes(_local_9.toString());
                                                    };
                                                };
                                            };
                                            _arg_2.writeByte(93);
                                        }
                                        else
                                        {
                                            if ((_arg_4 is cvdouble))
                                            {
                                                _arg_2.writeByte(91);
                                                _local_8 = (_arg_4.length - 1);
                                                while (((_local_8 >= (0)) && (!(isFinite(_arg_4[_local_8])))))
                                                {
                                                    _local_8--;
                                                };
                                                if (++_local_8 > 0)
                                                {
                                                    _local_9 = _arg_4[0];
                                                    if (isFinite(_local_9))
                                                    {
                                                        if (((_local_9 >= (0)) && ((_local_9 <= (9)) && ((_local_9 % 1) == 0))))
                                                        {
                                                            _arg_2.writeByte((48 + _local_9));
                                                        }
                                                        else
                                                        {
                                                            _arg_2.writeUTFBytes(_local_9.toString());
                                                        };
                                                    }
                                                    else
                                                    {
                                                        _arg_2.writeInt(1819047278);
                                                    };
                                                    while (++_local_7 < _local_8)
                                                    {
                                                        _arg_2.writeByte(44);
                                                        _local_9 = _arg_4[_local_7];
                                                        if (isFinite(_local_9))
                                                        {
                                                            if (((_local_9 >= (0)) && ((_local_9 <= (9)) && ((_local_9 % 1) == 0))))
                                                            {
                                                                _arg_2.writeByte((48 + _local_9));
                                                            }
                                                            else
                                                            {
                                                                _arg_2.writeUTFBytes(_local_9.toString());
                                                            };
                                                        }
                                                        else
                                                        {
                                                            _arg_2.writeInt(1819047278);
                                                        };
                                                    };
                                                };
                                                _arg_2.writeByte(93);
                                            }
                                            else
                                            {
                                                _arg_2.writeByte(123);
                                                _local_11 = false;
                                                _local_13 = null;
                                                if (_arg_4.constructor != Object)
                                                {
                                                    if ((_arg_4 is Dictionary))
                                                    {
                                                        _local_15 = 0;
                                                        _local_14 = [];
                                                        _local_16 = _arg_4;
                                                        for (var _temp_1 in _arg_4)
                                                        {
                                                            _local_14.push(_temp_1);
                                                        };
                                                        _local_12 = _local_14;
                                                        _local_8 = _local_12.length;
                                                        _local_7 = 0;
                                                        while (_local_7 < _local_8)
                                                        {
                                                            _local_13 = typeof(_local_12[_local_7]);
                                                            if (((_local_13 != ("string")) && (!(_local_13 == "number"))))
                                                            {
                                                                Error.throwError(TypeError, 0);
                                                            };
                                                            _local_7++;
                                                        };
                                                    };
                                                    _local_12 = SerializationHelper.getPropertyNames(_arg_4);
                                                    _local_8 = _local_12.length;
                                                    _local_7 = 0;
                                                    while (_local_7 < _local_8)
                                                    {
                                                        _local_10 = _local_12[_local_7];
                                                        try
                                                        {
                                                            _local_13 = _arg_4[_local_10];
                                                            _local_17 = true;
                                                        }
                                                        catch(_unnamedErr)
                                                        {
                                                            _local_16 = _unnamedErr;
                                                            _local_17 = false;
                                                        };
                                                        if (_local_17)
                                                        {
                                                            if (_local_11)
                                                            {
                                                                _arg_2.writeByte(44);
                                                            }
                                                            else
                                                            {
                                                                _local_11 = true;
                                                            };
                                                            if (_local_10.length <= 0)
                                                            {
                                                                _arg_2.writeShort(0x2222);
                                                            }
                                                            else
                                                            {
                                                                _arg_2.writeByte(34);
                                                                _arg_3.position = 16;
                                                                _arg_3.writeUTFBytes(_local_10);
                                                                _local_18 = _arg_3.position;
                                                                _local_19 = 16;
                                                                _local_20 = _local_19;
                                                                do 
                                                                {
                                                                    _local_22 = _arg_3[_local_19];
                                                                    if (((_local_22 < (32)) || ((_local_22 == (34)) || ((_local_22 == (47)) || (_local_22 == 92)))))
                                                                    {
                                                                        _local_21 = (_local_19 - _local_20);
                                                                        if (_local_21 > 0)
                                                                        {
                                                                            _arg_2.writeBytes(_arg_3, _local_20, _local_21);
                                                                        };
                                                                        _local_20 = (_local_19 + 1);
                                                                        if (_local_22 == 10)
                                                                        {
                                                                            _arg_2.writeShort(28252);
                                                                        }
                                                                        else
                                                                        {
                                                                            if (_local_22 == 13)
                                                                            {
                                                                                _arg_2.writeShort(29276);
                                                                            }
                                                                            else
                                                                            {
                                                                                if (_local_22 == 9)
                                                                                {
                                                                                    _arg_2.writeShort(29788);
                                                                                }
                                                                                else
                                                                                {
                                                                                    if (_local_22 == 34)
                                                                                    {
                                                                                        _arg_2.writeShort(8796);
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        if (_local_22 == 47)
                                                                                        {
                                                                                            _arg_2.writeShort(12124);
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            if (_local_22 == 92)
                                                                                            {
                                                                                                _arg_2.writeShort(0x5C5C);
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                if (_local_22 == 11)
                                                                                                {
                                                                                                    _arg_2.writeShort(30300);
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    if (_local_22 == 8)
                                                                                                    {
                                                                                                        _arg_2.writeShort(25180);
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        if (_local_22 == 12)
                                                                                                        {
                                                                                                            _arg_2.writeShort(26204);
                                                                                                        }
                                                                                                        else
                                                                                                        {
                                                                                                            _arg_2.writeInt(808482140);
                                                                                                            _arg_2.writeByte(_arg_3[(_local_22 >>> 4)]);
                                                                                                            _arg_2.writeByte(_arg_3[(_local_22 & 0x0F)]);
                                                                                                        };
                                                                                                    };
                                                                                                };
                                                                                            };
                                                                                        };
                                                                                    };
                                                                                };
                                                                            };
                                                                        };
                                                                    };
                                                                } while (++_local_19 < _local_18);
                                                                _local_21 = (_local_19 - _local_20);
                                                                if (_local_21 > 0)
                                                                {
                                                                    _arg_2.writeBytes(_arg_3, _local_20, _local_21);
                                                                };
                                                                _arg_2.writeByte(34);
                                                            };
                                                            _arg_2.writeByte(58);
                                                            (writeValue(_arg_1, _arg_2, _arg_3, _local_13));
                                                        };
                                                        _local_7++;
                                                    };
                                                };
                                                _local_15 = 0;
                                                _local_14 = [];
                                                _local_16 = _arg_4;
                                                for (var _temp_2 in _arg_4)
                                                {
                                                    _local_14.push(_temp_2);
                                                };
                                                _local_12 = _local_14;
                                                _local_8 = _local_12.length;
                                                _local_7 = 0;
                                                while (_local_7 < _local_8)
                                                {
                                                    _local_10 = _local_12[_local_7];
                                                    _local_13 = _arg_4[_local_10];
                                                    if (!(_local_13 is Function))
                                                    {
                                                        if (_local_11)
                                                        {
                                                            _arg_2.writeByte(44);
                                                        }
                                                        else
                                                        {
                                                            _local_11 = true;
                                                        };
                                                        if (_local_10.length <= 0)
                                                        {
                                                            _arg_2.writeShort(0x2222);
                                                        }
                                                        else
                                                        {
                                                            _arg_2.writeByte(34);
                                                            _arg_3.position = 16;
                                                            _arg_3.writeUTFBytes(_local_10);
                                                            _local_18 = _arg_3.position;
                                                            _local_19 = 16;
                                                            _local_20 = _local_19;
                                                            do 
                                                            {
                                                                _local_22 = _arg_3[_local_19];
                                                                if (((_local_22 < (32)) || ((_local_22 == (34)) || ((_local_22 == (47)) || (_local_22 == 92)))))
                                                                {
                                                                    _local_21 = (_local_19 - _local_20);
                                                                    if (_local_21 > 0)
                                                                    {
                                                                        _arg_2.writeBytes(_arg_3, _local_20, _local_21);
                                                                    };
                                                                    _local_20 = (_local_19 + 1);
                                                                    if (_local_22 == 10)
                                                                    {
                                                                        _arg_2.writeShort(28252);
                                                                    }
                                                                    else
                                                                    {
                                                                        if (_local_22 == 13)
                                                                        {
                                                                            _arg_2.writeShort(29276);
                                                                        }
                                                                        else
                                                                        {
                                                                            if (_local_22 == 9)
                                                                            {
                                                                                _arg_2.writeShort(29788);
                                                                            }
                                                                            else
                                                                            {
                                                                                if (_local_22 == 34)
                                                                                {
                                                                                    _arg_2.writeShort(8796);
                                                                                }
                                                                                else
                                                                                {
                                                                                    if (_local_22 == 47)
                                                                                    {
                                                                                        _arg_2.writeShort(12124);
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        if (_local_22 == 92)
                                                                                        {
                                                                                            _arg_2.writeShort(0x5C5C);
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            if (_local_22 == 11)
                                                                                            {
                                                                                                _arg_2.writeShort(30300);
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                if (_local_22 == 8)
                                                                                                {
                                                                                                    _arg_2.writeShort(25180);
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    if (_local_22 == 12)
                                                                                                    {
                                                                                                        _arg_2.writeShort(26204);
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        _arg_2.writeInt(808482140);
                                                                                                        _arg_2.writeByte(_arg_3[(_local_22 >>> 4)]);
                                                                                                        _arg_2.writeByte(_arg_3[(_local_22 & 0x0F)]);
                                                                                                    };
                                                                                                };
                                                                                            };
                                                                                        };
                                                                                    };
                                                                                };
                                                                            };
                                                                        };
                                                                    };
                                                                };
                                                            } while (++_local_19 < _local_18);
                                                            _local_21 = (_local_19 - _local_20);
                                                            if (_local_21 > 0)
                                                            {
                                                                _arg_2.writeBytes(_arg_3, _local_20, _local_21);
                                                            };
                                                            _arg_2.writeByte(34);
                                                        };
                                                        _arg_2.writeByte(58);
                                                        (writeValue(_arg_1, _arg_2, _arg_3, _local_13));
                                                    };
                                                    _local_7++;
                                                };
                                                _arg_2.writeByte(125);
                                            };
                                        };
                                    };
                                    delete _arg_1[_arg_4];
                                };
                            };
                        };
                        if (_local_6 == "string")
                        {
                            if (_arg_4.length <= 0)
                            {
                                _arg_2.writeShort(0x2222);
                            }
                            else
                            {
                                _arg_2.writeByte(34);
                                _arg_3.position = 16;
                                _arg_3.writeUTFBytes(_arg_4);
                                _local_18 = _arg_3.position;
                                _local_19 = 16;
                                _local_20 = _local_19;
                                do 
                                {
                                    _local_22 = _arg_3[_local_19];
                                    if (((_local_22 < (32)) || ((_local_22 == (34)) || ((_local_22 == (47)) || (_local_22 == 92)))))
                                    {
                                        _local_21 = (_local_19 - _local_20);
                                        if (_local_21 > 0)
                                        {
                                            _arg_2.writeBytes(_arg_3, _local_20, _local_21);
                                        };
                                        _local_20 = (_local_19 + 1);
                                        if (_local_22 == 10)
                                        {
                                            _arg_2.writeShort(28252);
                                        }
                                        else
                                        {
                                            if (_local_22 == 13)
                                            {
                                                _arg_2.writeShort(29276);
                                            }
                                            else
                                            {
                                                if (_local_22 == 9)
                                                {
                                                    _arg_2.writeShort(29788);
                                                }
                                                else
                                                {
                                                    if (_local_22 == 34)
                                                    {
                                                        _arg_2.writeShort(8796);
                                                    }
                                                    else
                                                    {
                                                        if (_local_22 == 47)
                                                        {
                                                            _arg_2.writeShort(12124);
                                                        }
                                                        else
                                                        {
                                                            if (_local_22 == 92)
                                                            {
                                                                _arg_2.writeShort(0x5C5C);
                                                            }
                                                            else
                                                            {
                                                                if (_local_22 == 11)
                                                                {
                                                                    _arg_2.writeShort(30300);
                                                                }
                                                                else
                                                                {
                                                                    if (_local_22 == 8)
                                                                    {
                                                                        _arg_2.writeShort(25180);
                                                                    }
                                                                    else
                                                                    {
                                                                        if (_local_22 == 12)
                                                                        {
                                                                            _arg_2.writeShort(26204);
                                                                        }
                                                                        else
                                                                        {
                                                                            _arg_2.writeInt(808482140);
                                                                            _arg_2.writeByte(_arg_3[(_local_22 >>> 4)]);
                                                                            _arg_2.writeByte(_arg_3[(_local_22 & 0x0F)]);
                                                                        };
                                                                    };
                                                                };
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                } while (++_local_19 < _local_18);
                                _local_21 = (_local_19 - _local_20);
                                if (_local_21 > 0)
                                {
                                    _arg_2.writeBytes(_arg_3, _local_20, _local_21);
                                };
                                _arg_2.writeByte(34);
                            };
                        }
                        else
                        {
                            if (!_arg_4)
                            {
                                _arg_2.writeInt(1819047278);
                            };
                        };
                    };
                };
            };
            (writeValue(new Dictionary(), _local_4, _local_3, _arg_1));
            XML.setSettings(_local_2);
            var _local_5:uint = _local_4.position;
            _local_4.position = 0;
            return (_local_4.readUTFBytes(_local_5));
        }

        public static function decode(_arg_1:String):*
        {
            var _local_4:* = (null as ByteArray);
            var _local_5:* = (null as ByteArray);
            var _local_6:uint;
            var _local_7:uint;
            var _local_8:uint;
            var _local_9:uint;
            var _local_10:uint;
            var _local_11:uint;
            var _local_12:Boolean;
            var _local_13:* = null;
            if (_arg_1 == null)
            {
                Error.throwError(TypeError, 2007, "value");
            };
            var _local_3:* = undefined;
            if (_arg_1.length > 0)
            {
                _local_4 = ApplicationDomain.currentDomain.domainMemory;
                _local_5 = new ByteArray();
                _local_5.writeUTFBytes(_arg_1);
                _local_5.writeByte(0);
                if (_local_5.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
                {
                    _local_5.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
                };
                ApplicationDomain.currentDomain.domainMemory = _local_5;
                _local_6 = 0;
                do 
                {
                    _local_9 = _local_6;
                    _local_6 = (_local_9 + 1);
                    _local_8 = li8(_local_9);
                    if (((_local_8 != (13)) && ((_local_8 != (10)) && ((_local_8 != (32)) && ((_local_8 != (9)) && ((_local_8 != (11)) && ((_local_8 != (8)) && (!(_local_8 == 12)))))))))
                    {
                        if (_local_8 == 47)
                        {
                            _local_9 = _local_6;
                            _local_6 = (_local_9 + 1);
                            _local_8 = li8(_local_9);
                            if (_local_8 == 47)
                            {
                                do 
                                {
                                    _local_10 = _local_6;
                                    _local_6 = (_local_10 + 1);
                                    _local_9 = li8(_local_10);
                                } while (((_local_9 != (10)) && ((_local_9 != (13)) && (!(_local_9 == 0)))));
                                _local_6--;
                                continue;
                            };
                            if (_local_8 == 42)
                            {
                                _local_6 = (_local_6 - 2);
                                _local_8 = _local_6;
                                _local_9 = _local_6;
                                _local_10 = _local_6;
                                _local_6 = (_local_10 + 1);
                                if (((li8(_local_10) != (47)) || (!(li8(_local_10) == 42))))
                                {
                                    _local_6 = _local_9;
                                }
                                else
                                {
                                    do 
                                    {
                                        _local_11 = _local_6;
                                        _local_6 = (_local_11 + 1);
                                        _local_10 = li8(_local_11);
                                        if (_local_10 == 42)
                                        {
                                            _local_11 = _local_6;
                                            _local_6 = (_local_11 + 1);
                                            if (li8(_local_11) == 47) break;
                                            _local_6--;
                                        }
                                        else
                                        {
                                            if (_local_10 == 0)
                                            {
                                                _local_6 = _local_9;
                                                break;
                                            };
                                        };
                                    } while (true);
                                };
                                if (_local_8 != _local_6) continue;
                            };
                            _local_6--;
                            _local_8 = 47;
                        };
                        break;
                    };
                } while (true);
                _local_7 = _local_8;
                if (_local_7 != 0)
                {
                    var position:uint = (_local_6 - 1);
                    var readValue:Function = null;
                    readValue = function (_arg_1:ByteArray, _arg_2:uint):*
                    {
                        var _local_3:* = (null as String);
                        var _local_7:uint;
                        var _local_8:uint;
                        var _local_9:uint;
                        var _local_10:uint;
                        var _local_11:* = (null as String);
                        var _local_12:* = (null as String);
                        var _local_13:uint;
                        var _local_14:uint;
                        var _local_15:uint;
                        var _local_16:* = (null as Object);
                        var _local_17:* = (null as String);
                        var _local_18:* = (null as Array);
                        var _local_6:* = undefined;
                        do 
                        {
                            _local_8 = _arg_2;
                            _arg_2 = (_local_8 + 1);
                            _local_7 = li8(_local_8);
                            if (((_local_7 != (13)) && ((_local_7 != (10)) && ((_local_7 != (32)) && ((_local_7 != (9)) && ((_local_7 != (11)) && ((_local_7 != (8)) && (!(_local_7 == 12)))))))))
                            {
                                if (_local_7 == 47)
                                {
                                    _local_8 = _arg_2;
                                    _arg_2 = (_local_8 + 1);
                                    _local_7 = li8(_local_8);
                                    if (_local_7 == 47)
                                    {
                                        do 
                                        {
                                            _local_9 = _arg_2;
                                            _arg_2 = (_local_9 + 1);
                                            _local_8 = li8(_local_9);
                                        } while (((_local_8 != (10)) && ((_local_8 != (13)) && (!(_local_8 == 0)))));
                                        _arg_2--;
                                        continue;
                                    };
                                    if (_local_7 == 42)
                                    {
                                        _arg_2 = (_arg_2 - 2);
                                        _local_7 = _arg_2;
                                        _local_8 = _arg_2;
                                        _local_9 = _arg_2;
                                        _arg_2 = (_local_9 + 1);
                                        if (((li8(_local_9) != (47)) || (!(li8(_local_9) == 42))))
                                        {
                                            _arg_2 = _local_8;
                                        }
                                        else
                                        {
                                            do 
                                            {
                                                _local_10 = _arg_2;
                                                _arg_2 = (_local_10 + 1);
                                                _local_9 = li8(_local_10);
                                                if (_local_9 == 42)
                                                {
                                                    _local_10 = _arg_2;
                                                    _arg_2 = (_local_10 + 1);
                                                    if (li8(_local_10) == 47) break;
                                                    _arg_2--;
                                                }
                                                else
                                                {
                                                    if (_local_9 == 0)
                                                    {
                                                        _arg_2 = _local_8;
                                                        break;
                                                    };
                                                };
                                            } while (true);
                                        };
                                        if (_local_7 != _arg_2) continue;
                                    };
                                    _arg_2--;
                                    _local_7 = 47;
                                };
                                break;
                            };
                        } while (true);
                        var _local_5:uint = _local_7;
                        if (((_local_5 == (39)) || (_local_5 == 34)))
                        {
                            _arg_2--;
                            _local_7 = _arg_2;
                            _local_9 = _arg_2;
                            _arg_2 = (_local_9 + 1);
                            _local_8 = li8(_local_9);
                            _local_3 = (((_local_8 != (39)) && (!(_local_8 == 34))) ? (_arg_2--, null) : ((_local_9 = (_local_7 + 1)), (_local_11 = ""), while (true)/*complex condition*/
{
if ((_local_13 = li8(_arg_2++)) >= 128)
{
    if ((_local_13 & 0xF8) == 240)
    {
        _local_13 = (((((_local_13 & 0x07) << 18) | ((li8(++_arg_2) & 0x3F) << 12)) | ((li8(++_arg_2) & 0x3F) << 6)) | (li8(++_arg_2) & 0x3F));
    }
    else
    {
        if ((_local_13 & 0xF0) == 224)
        {
            _local_13 = ((((_local_13 & 0x0F) << 12) | ((li8(++_arg_2) & 0x3F) << 6)) | (li8(++_arg_2) & 0x3F));
        }
        else
        {
            if ((_local_13 & 0xE0) == 192)
            {
                _local_13 = (((_local_13 & 0x1F) << 6) | (li8(++_arg_2) & 0x3F));
            };
        };
    };
}if (!(_local_10 = _local_13) != _local_8) break /*end of condition*/ if (_local_10 == 92)
{
    _arg_1.position = _local_9;
    _local_11 = (_local_11 + _arg_1.readUTFBytes(((_arg_2 - 1) - _local_9)));
    _local_13 = _arg_2;
    _arg_2 = (_local_13 + 1);
    _local_10 = li8(_local_13);
    if (_local_10 == 110)
    {
        _local_11 = (_local_11 + "\n");
    }
    else
    {
        if (_local_10 == 114)
        {
            _local_11 = (_local_11 + "\r");
        }
        else
        {
            if (_local_10 == 116)
            {
                _local_11 = (_local_11 + "\t");
            }
            else
            {
                if (_local_10 == 118)
                {
                    _local_11 = (_local_11 + "\x0B");
                }
                else
                {
                    if (_local_10 == 102)
                    {
                        _local_11 = (_local_11 + "\f");
                    }
                    else
                    {
                        if (_local_10 == 98)
                        {
                            _local_11 = (_local_11 + "\b");
                        }
                        else
                        {
                            if (_local_10 == 120)
                            {
                                _local_14 = 0;
                                do 
                                {
                                    _local_15 = _arg_2;
                                    _arg_2 = (_local_15 + 1);
                                    _local_13 = li8(_local_15);
                                    if ((((_local_13 < (48)) || (_local_13 > 57)) && (((_local_13 < (97)) || (_local_13 > 102)) && ((_local_13 < (65)) || (_local_13 > 70))))) break;
                                } while (++_local_14 < 2);
                                _local_12 = ((_local_14 != 2) ? ((_arg_2 = (_arg_2 - (_local_14 + 1))), null) : ((_arg_1.position = (_arg_2 - 2)), _arg_1.readUTFBytes(2)));
                                if (_local_12 != null)
                                {
                                    _local_11 = (_local_11 + String.fromCharCode(parseInt(_local_12, 16)));
                                }
                                else
                                {
                                    _local_11 = (_local_11 + "x");
                                };
                            }
                            else
                            {
                                if (_local_10 == 117)
                                {
                                    _local_14 = 0;
                                    do 
                                    {
                                        _local_15 = _arg_2;
                                        _arg_2 = (_local_15 + 1);
                                        _local_13 = li8(_local_15);
                                        if ((((_local_13 < (48)) || (_local_13 > 57)) && (((_local_13 < (97)) || (_local_13 > 102)) && ((_local_13 < (65)) || (_local_13 > 70))))) break;
                                    } while (++_local_14 < 4);
                                    _local_12 = ((_local_14 != 4) ? ((_arg_2 = (_arg_2 - (_local_14 + 1))), null) : ((_arg_1.position = (_arg_2 - 4)), _arg_1.readUTFBytes(4)));
                                    if (_local_12 != null)
                                    {
                                        _local_11 = (_local_11 + String.fromCharCode(parseInt(_local_12, 16)));
                                    }
                                    else
                                    {
                                        _local_11 = (_local_11 + "u");
                                    };
                                }
                                else
                                {
                                    if (_local_10 >= 128)
                                    {
                                        _arg_2--;
                                        _local_13 = li8(_arg_2);
                                        if (_local_13 >= 128)
                                        {
                                            if ((_local_13 & 0xF8) == 240)
                                            {
                                                _local_13 = (((((_local_13 & 0x07) << 18) | ((li8(++_arg_2) & 0x3F) << 12)) | ((li8(++_arg_2) & 0x3F) << 6)) | (li8(++_arg_2) & 0x3F));
                                            }
                                            else
                                            {
                                                if ((_local_13 & 0xF0) == 224)
                                                {
                                                    _local_13 = ((((_local_13 & 0x0F) << 12) | ((li8(++_arg_2) & 0x3F) << 6)) | (li8(++_arg_2) & 0x3F));
                                                }
                                                else
                                                {
                                                    if ((_local_13 & 0xE0) == 192)
                                                    {
                                                        _local_13 = (((_local_13 & 0x1F) << 6) | (li8(++_arg_2) & 0x3F));
                                                    };
                                                };
                                            };
                                        };
                                        _arg_2++;
                                        _local_10 = _local_13;
                                    };
                                    _local_11 = (_local_11 + String.fromCharCode(_local_10));
                                };
                            };
                        };
                    };
                };
            };
        };
    };
    _local_9 = _arg_2;
}
else
{
    if (((_local_10 == (0)) || ((_local_10 == (13)) || (_local_10 == 10))))
    {
        _arg_2 = _local_7;
        break;
    };
};
}, ((_arg_2 == _local_7) ? null : (if (_local_9 != (_arg_2 - 1))
{
_arg_1.position = _local_9;
_local_11 = (_local_11 + _arg_1.readUTFBytes(((_arg_2 - 1) - _local_9)));
}, _local_11))));
                            if (_local_3 != null)
                            {
                                _local_6 = _local_3;
                            }
                            else
                            {
                                Error.throwError(Error, 0);
                            };
                        }
                        else
                        {
                            if ((((_local_5 >= (48)) && (_local_5 <= 57)) || (_local_5 == 46)))
                            {
                                _arg_2--;
                                _local_11 = null;
                                _local_7 = _arg_2;
                                _local_9 = _arg_2;
                                _arg_2 = (_local_9 + 1);
                                _local_8 = li8(_local_9);
                                if (_local_8 == 48)
                                {
                                    _local_10 = _arg_2;
                                    _arg_2 = (_local_10 + 1);
                                    _local_8 = li8(_local_10);
                                    if (((_local_8 == (120)) || (_local_8 == 88)))
                                    {
                                        _local_9 = _arg_2;
                                        do 
                                        {
                                            _local_10 = _arg_2;
                                            _arg_2 = (_local_10 + 1);
                                            _local_8 = li8(_local_10);
                                        } while ((((_local_8 >= (48)) && (_local_8 <= 57)) || (((_local_8 >= (97)) && (_local_8 <= 102)) || ((_local_8 >= (65)) && (_local_8 <= 70)))));
                                        if (_arg_2 == (_local_9 + 1))
                                        {
                                            _arg_2 = (_local_7 + 1);
                                            _local_8 = 48;
                                        }
                                        else
                                        {
                                            _arg_2--;
                                            _arg_1.position = _local_9;
                                            _local_11 = parseInt(_arg_1.readUTFBytes((_arg_2 - _local_9)), 16);
                                        };
                                    }
                                    else
                                    {
                                        _arg_2--;
                                        _local_8 = 48;
                                    };
                                };
                                if (_local_11 == null)
                                {
                                    while (((_local_8 >= (48)) && (_local_8 <= 57)))
                                    {
                                        _local_10 = _arg_2;
                                        _arg_2 = (_local_10 + 1);
                                        _local_8 = li8(_local_10);
                                    };
                                    if (_local_8 == 46)
                                    {
                                        _local_9 = _arg_2;
                                        do 
                                        {
                                            _local_10 = _arg_2;
                                            _arg_2 = (_local_10 + 1);
                                            _local_8 = li8(_local_10);
                                        } while (((_local_8 >= (48)) && (_local_8 <= 57)));
                                        if (_arg_2 == (_local_9 + 1))
                                        {
                                            _arg_2--;
                                            _local_8 = 46;
                                        };
                                    };
                                    if (((_local_8 == (101)) || (_local_8 == 69)))
                                    {
                                        _local_10 = _arg_2;
                                        _local_13 = _arg_2;
                                        _arg_2 = (_local_13 + 1);
                                        _local_8 = li8(_local_13);
                                        if (((_local_8 == (45)) || (_local_8 == 43)))
                                        {
                                            _local_13 = _arg_2;
                                            _arg_2 = (_local_13 + 1);
                                            _local_8 = li8(_local_13);
                                        };
                                        _local_9 = _arg_2;
                                        while (((_local_8 >= (48)) && (_local_8 <= 57)))
                                        {
                                            _local_13 = _arg_2;
                                            _arg_2 = (_local_13 + 1);
                                            _local_8 = li8(_local_13);
                                        };
                                        if (_arg_2 == _local_9)
                                        {
                                            _arg_2 = _local_10;
                                        };
                                    };
                                    _arg_2--;
                                    if (_arg_2 != _local_7)
                                    {
                                        _arg_1.position = _local_7;
                                        _local_11 = _arg_1.readUTFBytes((_arg_2 - _local_7));
                                    };
                                };
                                _local_3 = _local_11;
                                if (_local_3 != null)
                                {
                                    _local_6 = parseFloat(_local_3);
                                }
                                else
                                {
                                    Error.throwError(Error, 0);
                                };
                            }
                            else
                            {
                                if (_local_5 == 45)
                                {
                                    do 
                                    {
                                        _local_8 = _arg_2;
                                        _arg_2 = (_local_8 + 1);
                                        _local_7 = li8(_local_8);
                                        if (((_local_7 != (13)) && ((_local_7 != (10)) && ((_local_7 != (32)) && ((_local_7 != (9)) && ((_local_7 != (11)) && ((_local_7 != (8)) && (!(_local_7 == 12)))))))))
                                        {
                                            if (_local_7 == 47)
                                            {
                                                _local_8 = _arg_2;
                                                _arg_2 = (_local_8 + 1);
                                                _local_7 = li8(_local_8);
                                                if (_local_7 == 47)
                                                {
                                                    do 
                                                    {
                                                        _local_9 = _arg_2;
                                                        _arg_2 = (_local_9 + 1);
                                                        _local_8 = li8(_local_9);
                                                    } while (((_local_8 != (10)) && ((_local_8 != (13)) && (!(_local_8 == 0)))));
                                                    _arg_2--;
                                                    continue;
                                                };
                                                if (_local_7 == 42)
                                                {
                                                    _arg_2 = (_arg_2 - 2);
                                                    _local_7 = _arg_2;
                                                    _local_8 = _arg_2;
                                                    _local_9 = _arg_2;
                                                    _arg_2 = (_local_9 + 1);
                                                    if (((li8(_local_9) != (47)) || (!(li8(_local_9) == 42))))
                                                    {
                                                        _arg_2 = _local_8;
                                                    }
                                                    else
                                                    {
                                                        do 
                                                        {
                                                            _local_10 = _arg_2;
                                                            _arg_2 = (_local_10 + 1);
                                                            _local_9 = li8(_local_10);
                                                            if (_local_9 == 42)
                                                            {
                                                                _local_10 = _arg_2;
                                                                _arg_2 = (_local_10 + 1);
                                                                if (li8(_local_10) == 47) break;
                                                                _arg_2--;
                                                            }
                                                            else
                                                            {
                                                                if (_local_9 == 0)
                                                                {
                                                                    _arg_2 = _local_8;
                                                                    break;
                                                                };
                                                            };
                                                        } while (true);
                                                    };
                                                    if (_local_7 != _arg_2) continue;
                                                };
                                                _arg_2--;
                                                _local_7 = 47;
                                            };
                                            break;
                                        };
                                    } while (true);
                                    _local_5 = _local_7;
                                    if ((((_local_5 >= (48)) && (_local_5 <= 57)) || (_local_5 == 46)))
                                    {
                                        _arg_2--;
                                        _local_11 = null;
                                        _local_7 = _arg_2;
                                        _local_9 = _arg_2;
                                        _arg_2 = (_local_9 + 1);
                                        _local_8 = li8(_local_9);
                                        if (_local_8 == 48)
                                        {
                                            _local_10 = _arg_2;
                                            _arg_2 = (_local_10 + 1);
                                            _local_8 = li8(_local_10);
                                            if (((_local_8 == (120)) || (_local_8 == 88)))
                                            {
                                                _local_9 = _arg_2;
                                                do 
                                                {
                                                    _local_10 = _arg_2;
                                                    _arg_2 = (_local_10 + 1);
                                                    _local_8 = li8(_local_10);
                                                } while ((((_local_8 >= (48)) && (_local_8 <= 57)) || (((_local_8 >= (97)) && (_local_8 <= 102)) || ((_local_8 >= (65)) && (_local_8 <= 70)))));
                                                if (_arg_2 == (_local_9 + 1))
                                                {
                                                    _arg_2 = (_local_7 + 1);
                                                    _local_8 = 48;
                                                }
                                                else
                                                {
                                                    _arg_2--;
                                                    _arg_1.position = _local_9;
                                                    _local_11 = parseInt(_arg_1.readUTFBytes((_arg_2 - _local_9)), 16);
                                                };
                                            }
                                            else
                                            {
                                                _arg_2--;
                                                _local_8 = 48;
                                            };
                                        };
                                        if (_local_11 == null)
                                        {
                                            while (((_local_8 >= (48)) && (_local_8 <= 57)))
                                            {
                                                _local_10 = _arg_2;
                                                _arg_2 = (_local_10 + 1);
                                                _local_8 = li8(_local_10);
                                            };
                                            if (_local_8 == 46)
                                            {
                                                _local_9 = _arg_2;
                                                do 
                                                {
                                                    _local_10 = _arg_2;
                                                    _arg_2 = (_local_10 + 1);
                                                    _local_8 = li8(_local_10);
                                                } while (((_local_8 >= (48)) && (_local_8 <= 57)));
                                                if (_arg_2 == (_local_9 + 1))
                                                {
                                                    _arg_2--;
                                                    _local_8 = 46;
                                                };
                                            };
                                            if (((_local_8 == (101)) || (_local_8 == 69)))
                                            {
                                                _local_10 = _arg_2;
                                                _local_13 = _arg_2;
                                                _arg_2 = (_local_13 + 1);
                                                _local_8 = li8(_local_13);
                                                if (((_local_8 == (45)) || (_local_8 == 43)))
                                                {
                                                    _local_13 = _arg_2;
                                                    _arg_2 = (_local_13 + 1);
                                                    _local_8 = li8(_local_13);
                                                };
                                                _local_9 = _arg_2;
                                                while (((_local_8 >= (48)) && (_local_8 <= 57)))
                                                {
                                                    _local_13 = _arg_2;
                                                    _arg_2 = (_local_13 + 1);
                                                    _local_8 = li8(_local_13);
                                                };
                                                if (_arg_2 == _local_9)
                                                {
                                                    _arg_2 = _local_10;
                                                };
                                            };
                                            _arg_2--;
                                            if (_arg_2 != _local_7)
                                            {
                                                _arg_1.position = _local_7;
                                                _local_11 = _arg_1.readUTFBytes((_arg_2 - _local_7));
                                            };
                                        };
                                        _local_3 = _local_11;
                                        if (_local_3 != null)
                                        {
                                            _local_6 = -(parseFloat(_local_3));
                                        }
                                        else
                                        {
                                            Error.throwError(Error, 0);
                                        };
                                    }
                                    else
                                    {
                                        if (_local_5 == 110)
                                        {
                                            if (((li8(_arg_2) == (117)) && (li16(_arg_2 + 1) == 0x6C6C)))
                                            {
                                                _arg_2 = (_arg_2 + 3);
                                                _local_6 = 0;
                                            }
                                            else
                                            {
                                                Error.throwError(Error, 0);
                                            };
                                        }
                                        else
                                        {
                                            if (_local_5 == 117)
                                            {
                                                if (((li32(_arg_2) == (1717920878)) && (li32(_arg_2 + 4) == 1684369001)))
                                                {
                                                    _arg_2 = (_arg_2 + 8);
                                                    _local_6 = Number.NaN;
                                                }
                                                else
                                                {
                                                    Error.throwError(Error, 0);
                                                };
                                            }
                                            else
                                            {
                                                if (_local_5 == 78)
                                                {
                                                    if (li16(_arg_2) == 20065)
                                                    {
                                                        _arg_2 = (_arg_2 + 2);
                                                        _local_6 = Number.NaN;
                                                    }
                                                    else
                                                    {
                                                        Error.throwError(Error, 0);
                                                    };
                                                }
                                                else
                                                {
                                                    Error.throwError(Error, 0);
                                                };
                                            };
                                        };
                                    };
                                }
                                else
                                {
                                    if (_local_5 == 110)
                                    {
                                        if (((li8(_arg_2) == (117)) && (li16(_arg_2 + 1) == 0x6C6C)))
                                        {
                                            _arg_2 = (_arg_2 + 3);
                                            _local_6 = null;
                                        }
                                        else
                                        {
                                            Error.throwError(Error, 0);
                                        };
                                    }
                                    else
                                    {
                                        if (_local_5 == 116)
                                        {
                                            if (((li8(_arg_2) == (114)) && (li16(_arg_2 + 1) == 25973)))
                                            {
                                                _arg_2 = (_arg_2 + 3);
                                                _local_6 = true;
                                            }
                                            else
                                            {
                                                Error.throwError(Error, 0);
                                            };
                                        }
                                        else
                                        {
                                            if (_local_5 == 102)
                                            {
                                                if (li32(_arg_2) == 1702063201)
                                                {
                                                    _arg_2 = (_arg_2 + 4);
                                                    _local_6 = false;
                                                }
                                                else
                                                {
                                                    Error.throwError(Error, 0);
                                                };
                                            }
                                            else
                                            {
                                                if (_local_5 == 117)
                                                {
                                                    if (((li32(_arg_2) == (1717920878)) && (li32(_arg_2 + 4) == 1684369001)))
                                                    {
                                                        _arg_2 = (_arg_2 + 8);
                                                    }
                                                    else
                                                    {
                                                        Error.throwError(Error, 0);
                                                    };
                                                }
                                                else
                                                {
                                                    if (_local_5 == 78)
                                                    {
                                                        if (li16(_arg_2) == 20065)
                                                        {
                                                            _arg_2 = (_arg_2 + 2);
                                                            _local_6 = Number.NaN;
                                                        }
                                                        else
                                                        {
                                                            Error.throwError(Error, 0);
                                                        };
                                                    }
                                                    else
                                                    {
                                                        if (_local_5 == 123)
                                                        {
                                                            _local_16 = new Object();
                                                            _local_11 = null;
                                                            do 
                                                            {
                                                                _local_8 = _arg_2;
                                                                _arg_2 = (_local_8 + 1);
                                                                _local_7 = li8(_local_8);
                                                                if (((_local_7 != (13)) && ((_local_7 != (10)) && ((_local_7 != (32)) && ((_local_7 != (9)) && ((_local_7 != (11)) && ((_local_7 != (8)) && (!(_local_7 == 12)))))))))
                                                                {
                                                                    if (_local_7 == 47)
                                                                    {
                                                                        _local_8 = _arg_2;
                                                                        _arg_2 = (_local_8 + 1);
                                                                        _local_7 = li8(_local_8);
                                                                        if (_local_7 == 47)
                                                                        {
                                                                            do 
                                                                            {
                                                                                _local_9 = _arg_2;
                                                                                _arg_2 = (_local_9 + 1);
                                                                                _local_8 = li8(_local_9);
                                                                            } while (((_local_8 != (10)) && ((_local_8 != (13)) && (!(_local_8 == 0)))));
                                                                            _arg_2--;
                                                                            continue;
                                                                        };
                                                                        if (_local_7 == 42)
                                                                        {
                                                                            _arg_2 = (_arg_2 - 2);
                                                                            _local_7 = _arg_2;
                                                                            _local_8 = _arg_2;
                                                                            _local_9 = _arg_2;
                                                                            _arg_2 = (_local_9 + 1);
                                                                            if (((li8(_local_9) != (47)) || (!(li8(_local_9) == 42))))
                                                                            {
                                                                                _arg_2 = _local_8;
                                                                            }
                                                                            else
                                                                            {
                                                                                do 
                                                                                {
                                                                                    _local_10 = _arg_2;
                                                                                    _arg_2 = (_local_10 + 1);
                                                                                    _local_9 = li8(_local_10);
                                                                                    if (_local_9 == 42)
                                                                                    {
                                                                                        _local_10 = _arg_2;
                                                                                        _arg_2 = (_local_10 + 1);
                                                                                        if (li8(_local_10) == 47) break;
                                                                                        _arg_2--;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        if (_local_9 == 0)
                                                                                        {
                                                                                            _arg_2 = _local_8;
                                                                                            break;
                                                                                        };
                                                                                    };
                                                                                } while (true);
                                                                            };
                                                                            if (_local_7 != _arg_2) continue;
                                                                        };
                                                                        _arg_2--;
                                                                        _local_7 = 47;
                                                                    };
                                                                    break;
                                                                };
                                                            } while (true);
                                                            _local_5 = _local_7;
                                                            if (_local_5 != 125)
                                                            {
                                                                _arg_2--;
                                                                do 
                                                                {
                                                                    do 
                                                                    {
                                                                        _local_8 = _arg_2;
                                                                        _arg_2 = (_local_8 + 1);
                                                                        _local_7 = li8(_local_8);
                                                                        if (((_local_7 != (13)) && ((_local_7 != (10)) && ((_local_7 != (32)) && ((_local_7 != (9)) && ((_local_7 != (11)) && ((_local_7 != (8)) && (!(_local_7 == 12)))))))))
                                                                        {
                                                                            if (_local_7 == 47)
                                                                            {
                                                                                _local_8 = _arg_2;
                                                                                _arg_2 = (_local_8 + 1);
                                                                                _local_7 = li8(_local_8);
                                                                                if (_local_7 == 47)
                                                                                {
                                                                                    do 
                                                                                    {
                                                                                        _local_9 = _arg_2;
                                                                                        _arg_2 = (_local_9 + 1);
                                                                                        _local_8 = li8(_local_9);
                                                                                    } while (((_local_8 != (10)) && ((_local_8 != (13)) && (!(_local_8 == 0)))));
                                                                                    _arg_2--;
                                                                                    continue;
                                                                                };
                                                                                if (_local_7 == 42)
                                                                                {
                                                                                    _arg_2 = (_arg_2 - 2);
                                                                                    _local_7 = _arg_2;
                                                                                    _local_8 = _arg_2;
                                                                                    _local_9 = _arg_2;
                                                                                    _arg_2 = (_local_9 + 1);
                                                                                    if (((li8(_local_9) != (47)) || (!(li8(_local_9) == 42))))
                                                                                    {
                                                                                        _arg_2 = _local_8;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        do 
                                                                                        {
                                                                                            _local_10 = _arg_2;
                                                                                            _arg_2 = (_local_10 + 1);
                                                                                            _local_9 = li8(_local_10);
                                                                                            if (_local_9 == 42)
                                                                                            {
                                                                                                _local_10 = _arg_2;
                                                                                                _arg_2 = (_local_10 + 1);
                                                                                                if (li8(_local_10) == 47) break;
                                                                                                _arg_2--;
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                if (_local_9 == 0)
                                                                                                {
                                                                                                    _arg_2 = _local_8;
                                                                                                    break;
                                                                                                };
                                                                                            };
                                                                                        } while (true);
                                                                                    };
                                                                                    if (_local_7 != _arg_2) continue;
                                                                                };
                                                                                _arg_2--;
                                                                                _local_7 = 47;
                                                                            };
                                                                            break;
                                                                        };
                                                                    } while (true);
                                                                    _local_5 = _local_7;
                                                                    if (((_local_5 == (39)) || (_local_5 == 34)))
                                                                    {
                                                                        _arg_2--;
                                                                        _local_7 = _arg_2;
                                                                        _local_9 = _arg_2;
                                                                        _arg_2 = (_local_9 + 1);
                                                                        _local_8 = li8(_local_9);
                                                                        _local_3 = (((_local_8 != (39)) && (!(_local_8 == 34))) ? (_arg_2--, null) : ((_local_9 = (_local_7 + 1)), (_local_12 = ""), while (true)/*complex condition*/
{
if ((_local_13 = li8(_arg_2++)) >= 128)
{
    if ((_local_13 & 0xF8) == 240)
    {
        _local_13 = (((((_local_13 & 0x07) << 18) | ((li8(++_arg_2) & 0x3F) << 12)) | ((li8(++_arg_2) & 0x3F) << 6)) | (li8(++_arg_2) & 0x3F));
    }
    else
    {
        if ((_local_13 & 0xF0) == 224)
        {
            _local_13 = ((((_local_13 & 0x0F) << 12) | ((li8(++_arg_2) & 0x3F) << 6)) | (li8(++_arg_2) & 0x3F));
        }
        else
        {
            if ((_local_13 & 0xE0) == 192)
            {
                _local_13 = (((_local_13 & 0x1F) << 6) | (li8(++_arg_2) & 0x3F));
            };
        };
    };
}if (!(_local_10 = _local_13) != _local_8) break /*end of condition*/ if (_local_10 == 92)
{
    _arg_1.position = _local_9;
    _local_12 = (_local_12 + _arg_1.readUTFBytes(((_arg_2 - 1) - _local_9)));
    _local_13 = _arg_2;
    _arg_2 = (_local_13 + 1);
    _local_10 = li8(_local_13);
    if (_local_10 == 110)
    {
        _local_12 = (_local_12 + "\n");
    }
    else
    {
        if (_local_10 == 114)
        {
            _local_12 = (_local_12 + "\r");
        }
        else
        {
            if (_local_10 == 116)
            {
                _local_12 = (_local_12 + "\t");
            }
            else
            {
                if (_local_10 == 118)
                {
                    _local_12 = (_local_12 + "\x0B");
                }
                else
                {
                    if (_local_10 == 102)
                    {
                        _local_12 = (_local_12 + "\f");
                    }
                    else
                    {
                        if (_local_10 == 98)
                        {
                            _local_12 = (_local_12 + "\b");
                        }
                        else
                        {
                            if (_local_10 == 120)
                            {
                                _local_14 = 0;
                                do 
                                {
                                    _local_15 = _arg_2;
                                    _arg_2 = (_local_15 + 1);
                                    _local_13 = li8(_local_15);
                                    if ((((_local_13 < (48)) || (_local_13 > 57)) && (((_local_13 < (97)) || (_local_13 > 102)) && ((_local_13 < (65)) || (_local_13 > 70))))) break;
                                } while (++_local_14 < 2);
                                _local_17 = ((_local_14 != 2) ? ((_arg_2 = (_arg_2 - (_local_14 + 1))), null) : ((_arg_1.position = (_arg_2 - 2)), _arg_1.readUTFBytes(2)));
                                if (_local_17 != null)
                                {
                                    _local_12 = (_local_12 + String.fromCharCode(parseInt(_local_17, 16)));
                                }
                                else
                                {
                                    _local_12 = (_local_12 + "x");
                                };
                            }
                            else
                            {
                                if (_local_10 == 117)
                                {
                                    _local_14 = 0;
                                    do 
                                    {
                                        _local_15 = _arg_2;
                                        _arg_2 = (_local_15 + 1);
                                        _local_13 = li8(_local_15);
                                        if ((((_local_13 < (48)) || (_local_13 > 57)) && (((_local_13 < (97)) || (_local_13 > 102)) && ((_local_13 < (65)) || (_local_13 > 70))))) break;
                                    } while (++_local_14 < 4);
                                    _local_17 = ((_local_14 != 4) ? ((_arg_2 = (_arg_2 - (_local_14 + 1))), null) : ((_arg_1.position = (_arg_2 - 4)), _arg_1.readUTFBytes(4)));
                                    if (_local_17 != null)
                                    {
                                        _local_12 = (_local_12 + String.fromCharCode(parseInt(_local_17, 16)));
                                    }
                                    else
                                    {
                                        _local_12 = (_local_12 + "u");
                                    };
                                }
                                else
                                {
                                    if (_local_10 >= 128)
                                    {
                                        _arg_2--;
                                        _local_13 = li8(_arg_2);
                                        if (_local_13 >= 128)
                                        {
                                            if ((_local_13 & 0xF8) == 240)
                                            {
                                                _local_13 = (((((_local_13 & 0x07) << 18) | ((li8(++_arg_2) & 0x3F) << 12)) | ((li8(++_arg_2) & 0x3F) << 6)) | (li8(++_arg_2) & 0x3F));
                                            }
                                            else
                                            {
                                                if ((_local_13 & 0xF0) == 224)
                                                {
                                                    _local_13 = ((((_local_13 & 0x0F) << 12) | ((li8(++_arg_2) & 0x3F) << 6)) | (li8(++_arg_2) & 0x3F));
                                                }
                                                else
                                                {
                                                    if ((_local_13 & 0xE0) == 192)
                                                    {
                                                        _local_13 = (((_local_13 & 0x1F) << 6) | (li8(++_arg_2) & 0x3F));
                                                    };
                                                };
                                            };
                                        };
                                        _arg_2++;
                                        _local_10 = _local_13;
                                    };
                                    _local_12 = (_local_12 + String.fromCharCode(_local_10));
                                };
                            };
                        };
                    };
                };
            };
        };
    };
    _local_9 = _arg_2;
}
else
{
    if (((_local_10 == (0)) || ((_local_10 == (13)) || (_local_10 == 10))))
    {
        _arg_2 = _local_7;
        break;
    };
};
}, ((_arg_2 == _local_7) ? null : (if (_local_9 != (_arg_2 - 1))
{
_arg_1.position = _local_9;
_local_12 = (_local_12 + _arg_1.readUTFBytes(((_arg_2 - 1) - _local_9)));
}, _local_12))));
                                                                        if (_local_3 != null)
                                                                        {
                                                                            _local_11 = _local_3;
                                                                        }
                                                                        else
                                                                        {
                                                                            Error.throwError(Error, 0);
                                                                        };
                                                                    }
                                                                    else
                                                                    {
                                                                        if ((((_local_5 >= (48)) && (_local_5 <= 57)) || (_local_5 == 46)))
                                                                        {
                                                                            _arg_2--;
                                                                            _local_12 = null;
                                                                            _local_7 = _arg_2;
                                                                            _local_9 = _arg_2;
                                                                            _arg_2 = (_local_9 + 1);
                                                                            _local_8 = li8(_local_9);
                                                                            if (_local_8 == 48)
                                                                            {
                                                                                _local_10 = _arg_2;
                                                                                _arg_2 = (_local_10 + 1);
                                                                                _local_8 = li8(_local_10);
                                                                                if (((_local_8 == (120)) || (_local_8 == 88)))
                                                                                {
                                                                                    _local_9 = _arg_2;
                                                                                    do 
                                                                                    {
                                                                                        _local_10 = _arg_2;
                                                                                        _arg_2 = (_local_10 + 1);
                                                                                        _local_8 = li8(_local_10);
                                                                                    } while ((((_local_8 >= (48)) && (_local_8 <= 57)) || (((_local_8 >= (97)) && (_local_8 <= 102)) || ((_local_8 >= (65)) && (_local_8 <= 70)))));
                                                                                    if (_arg_2 == (_local_9 + 1))
                                                                                    {
                                                                                        _arg_2 = (_local_7 + 1);
                                                                                        _local_8 = 48;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        _arg_2--;
                                                                                        _arg_1.position = _local_9;
                                                                                        _local_12 = parseInt(_arg_1.readUTFBytes((_arg_2 - _local_9)), 16);
                                                                                    };
                                                                                }
                                                                                else
                                                                                {
                                                                                    _arg_2--;
                                                                                    _local_8 = 48;
                                                                                };
                                                                            };
                                                                            if (_local_12 == null)
                                                                            {
                                                                                while (((_local_8 >= (48)) && (_local_8 <= 57)))
                                                                                {
                                                                                    _local_10 = _arg_2;
                                                                                    _arg_2 = (_local_10 + 1);
                                                                                    _local_8 = li8(_local_10);
                                                                                };
                                                                                if (_local_8 == 46)
                                                                                {
                                                                                    _local_9 = _arg_2;
                                                                                    do 
                                                                                    {
                                                                                        _local_10 = _arg_2;
                                                                                        _arg_2 = (_local_10 + 1);
                                                                                        _local_8 = li8(_local_10);
                                                                                    } while (((_local_8 >= (48)) && (_local_8 <= 57)));
                                                                                    if (_arg_2 == (_local_9 + 1))
                                                                                    {
                                                                                        _arg_2--;
                                                                                        _local_8 = 46;
                                                                                    };
                                                                                };
                                                                                if (((_local_8 == (101)) || (_local_8 == 69)))
                                                                                {
                                                                                    _local_10 = _arg_2;
                                                                                    _local_13 = _arg_2;
                                                                                    _arg_2 = (_local_13 + 1);
                                                                                    _local_8 = li8(_local_13);
                                                                                    if (((_local_8 == (45)) || (_local_8 == 43)))
                                                                                    {
                                                                                        _local_13 = _arg_2;
                                                                                        _arg_2 = (_local_13 + 1);
                                                                                        _local_8 = li8(_local_13);
                                                                                    };
                                                                                    _local_9 = _arg_2;
                                                                                    while (((_local_8 >= (48)) && (_local_8 <= 57)))
                                                                                    {
                                                                                        _local_13 = _arg_2;
                                                                                        _arg_2 = (_local_13 + 1);
                                                                                        _local_8 = li8(_local_13);
                                                                                    };
                                                                                    if (_arg_2 == _local_9)
                                                                                    {
                                                                                        _arg_2 = _local_10;
                                                                                    };
                                                                                };
                                                                                _arg_2--;
                                                                                if (_arg_2 != _local_7)
                                                                                {
                                                                                    _arg_1.position = _local_7;
                                                                                    _local_12 = _arg_1.readUTFBytes((_arg_2 - _local_7));
                                                                                };
                                                                            };
                                                                            _local_3 = _local_12;
                                                                            if (_local_3 != null)
                                                                            {
                                                                                _local_11 = parseFloat(_local_3).toString();
                                                                            }
                                                                            else
                                                                            {
                                                                                Error.throwError(Error, 0);
                                                                            };
                                                                        }
                                                                        else
                                                                        {
                                                                            if ((((_local_5 == (110)) && ((li8(_arg_2) == (117)) && (li16(_arg_2 + 1) == 0x6C6C))) || (((_local_5 == (116)) && ((li8(_arg_2) == (114)) && (li16(_arg_2 + 1) == 25973))) || ((_local_5 == (102)) && (li32(_arg_2) == 1702063201)))))
                                                                            {
                                                                                Error.throwError(Error, 0);
                                                                            }
                                                                            else
                                                                            {
                                                                                _arg_2--;
                                                                                _local_7 = _arg_2;
                                                                                _local_9 = li8(_arg_2);
                                                                                if (_local_9 >= 128)
                                                                                {
                                                                                    if ((_local_9 & 0xF8) == 240)
                                                                                    {
                                                                                        _local_9 = (((((_local_9 & 0x07) << 18) | ((li8(++_arg_2) & 0x3F) << 12)) | ((li8(++_arg_2) & 0x3F) << 6)) | (li8(++_arg_2) & 0x3F));
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        if ((_local_9 & 0xF0) == 224)
                                                                                        {
                                                                                            _local_9 = ((((_local_9 & 0x0F) << 12) | ((li8(++_arg_2) & 0x3F) << 6)) | (li8(++_arg_2) & 0x3F));
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            if ((_local_9 & 0xE0) == 192)
                                                                                            {
                                                                                                _local_9 = (((_local_9 & 0x1F) << 6) | (li8(++_arg_2) & 0x3F));
                                                                                            };
                                                                                        };
                                                                                    };
                                                                                };
                                                                                _arg_2++;
                                                                                _local_8 = _local_9;
                                                                                _local_3 = ((((_local_8 < (97)) || (_local_8 > 122)) && (((_local_8 < (65)) || (_local_8 > 90)) && ((_local_8 != (36)) && ((_local_8 != (95)) && (_local_8 <= 127))))) ? ((_arg_2 = _local_7), null) : (do 
{
_local_9 = _arg_2;
_local_10 = li8(_arg_2);
if (_local_10 >= 128)
{
    if ((_local_10 & 0xF8) == 240)
    {
        _local_10 = (((((_local_10 & 0x07) << 18) | ((li8(++_arg_2) & 0x3F) << 12)) | ((li8(++_arg_2) & 0x3F) << 6)) | (li8(++_arg_2) & 0x3F));
    }
    else
    {
        if ((_local_10 & 0xF0) == 224)
        {
            _local_10 = ((((_local_10 & 0x0F) << 12) | ((li8(++_arg_2) & 0x3F) << 6)) | (li8(++_arg_2) & 0x3F));
        }
        else
        {
            if ((_local_10 & 0xE0) == 192)
            {
                _local_10 = (((_local_10 & 0x1F) << 6) | (li8(++_arg_2) & 0x3F));
            };
        };
    };
};
_arg_2++;
_local_8 = _local_10;
} while ((((_local_8 >= (97)) && (_local_8 <= 122)) || (((_local_8 >= (65)) && (_local_8 <= 90)) || (((_local_8 >= (48)) && (_local_8 <= 57)) || ((_local_8 == (36)) || ((_local_8 == (95)) || (_local_8 > 127))))))), (_arg_2 = _local_9), (_arg_1.position = _local_7), _arg_1.readUTFBytes((_arg_2 - _local_7))));
                                                                                if (_local_3 != null)
                                                                                {
                                                                                    _local_11 = _local_3;
                                                                                }
                                                                                else
                                                                                {
                                                                                    Error.throwError(Error, 0);
                                                                                };
                                                                            };
                                                                        };
                                                                    };
                                                                    do 
                                                                    {
                                                                        _local_8 = _arg_2;
                                                                        _arg_2 = (_local_8 + 1);
                                                                        _local_7 = li8(_local_8);
                                                                        if (((_local_7 != (13)) && ((_local_7 != (10)) && ((_local_7 != (32)) && ((_local_7 != (9)) && ((_local_7 != (11)) && ((_local_7 != (8)) && (!(_local_7 == 12)))))))))
                                                                        {
                                                                            if (_local_7 == 47)
                                                                            {
                                                                                _local_8 = _arg_2;
                                                                                _arg_2 = (_local_8 + 1);
                                                                                _local_7 = li8(_local_8);
                                                                                if (_local_7 == 47)
                                                                                {
                                                                                    do 
                                                                                    {
                                                                                        _local_9 = _arg_2;
                                                                                        _arg_2 = (_local_9 + 1);
                                                                                        _local_8 = li8(_local_9);
                                                                                    } while (((_local_8 != (10)) && ((_local_8 != (13)) && (!(_local_8 == 0)))));
                                                                                    _arg_2--;
                                                                                    continue;
                                                                                };
                                                                                if (_local_7 == 42)
                                                                                {
                                                                                    _arg_2 = (_arg_2 - 2);
                                                                                    _local_7 = _arg_2;
                                                                                    _local_8 = _arg_2;
                                                                                    _local_9 = _arg_2;
                                                                                    _arg_2 = (_local_9 + 1);
                                                                                    if (((li8(_local_9) != (47)) || (!(li8(_local_9) == 42))))
                                                                                    {
                                                                                        _arg_2 = _local_8;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        do 
                                                                                        {
                                                                                            _local_10 = _arg_2;
                                                                                            _arg_2 = (_local_10 + 1);
                                                                                            _local_9 = li8(_local_10);
                                                                                            if (_local_9 == 42)
                                                                                            {
                                                                                                _local_10 = _arg_2;
                                                                                                _arg_2 = (_local_10 + 1);
                                                                                                if (li8(_local_10) == 47) break;
                                                                                                _arg_2--;
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                if (_local_9 == 0)
                                                                                                {
                                                                                                    _arg_2 = _local_8;
                                                                                                    break;
                                                                                                };
                                                                                            };
                                                                                        } while (true);
                                                                                    };
                                                                                    if (_local_7 != _arg_2) continue;
                                                                                };
                                                                                _arg_2--;
                                                                                _local_7 = 47;
                                                                            };
                                                                            break;
                                                                        };
                                                                    } while (true);
                                                                    if (_local_7 != 58)
                                                                    {
                                                                        Error.throwError(Error, 0);
                                                                    };
                                                                    _local_16[_local_11] = readValue(_arg_1, _arg_2);
                                                                    _arg_2 = position;
                                                                    do 
                                                                    {
                                                                        _local_8 = _arg_2;
                                                                        _arg_2 = (_local_8 + 1);
                                                                        _local_7 = li8(_local_8);
                                                                        if (((_local_7 != (13)) && ((_local_7 != (10)) && ((_local_7 != (32)) && ((_local_7 != (9)) && ((_local_7 != (11)) && ((_local_7 != (8)) && (!(_local_7 == 12)))))))))
                                                                        {
                                                                            if (_local_7 == 47)
                                                                            {
                                                                                _local_8 = _arg_2;
                                                                                _arg_2 = (_local_8 + 1);
                                                                                _local_7 = li8(_local_8);
                                                                                if (_local_7 == 47)
                                                                                {
                                                                                    do 
                                                                                    {
                                                                                        _local_9 = _arg_2;
                                                                                        _arg_2 = (_local_9 + 1);
                                                                                        _local_8 = li8(_local_9);
                                                                                    } while (((_local_8 != (10)) && ((_local_8 != (13)) && (!(_local_8 == 0)))));
                                                                                    _arg_2--;
                                                                                    continue;
                                                                                };
                                                                                if (_local_7 == 42)
                                                                                {
                                                                                    _arg_2 = (_arg_2 - 2);
                                                                                    _local_7 = _arg_2;
                                                                                    _local_8 = _arg_2;
                                                                                    _local_9 = _arg_2;
                                                                                    _arg_2 = (_local_9 + 1);
                                                                                    if (((li8(_local_9) != (47)) || (!(li8(_local_9) == 42))))
                                                                                    {
                                                                                        _arg_2 = _local_8;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        do 
                                                                                        {
                                                                                            _local_10 = _arg_2;
                                                                                            _arg_2 = (_local_10 + 1);
                                                                                            _local_9 = li8(_local_10);
                                                                                            if (_local_9 == 42)
                                                                                            {
                                                                                                _local_10 = _arg_2;
                                                                                                _arg_2 = (_local_10 + 1);
                                                                                                if (li8(_local_10) == 47) break;
                                                                                                _arg_2--;
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                if (_local_9 == 0)
                                                                                                {
                                                                                                    _arg_2 = _local_8;
                                                                                                    break;
                                                                                                };
                                                                                            };
                                                                                        } while (true);
                                                                                    };
                                                                                    if (_local_7 != _arg_2) continue;
                                                                                };
                                                                                _arg_2--;
                                                                                _local_7 = 47;
                                                                            };
                                                                            break;
                                                                        };
                                                                    } while (true);
                                                                    _local_5 = _local_7;
                                                                    if (_local_5 == 125) break;
                                                                    if (_local_5 != 44)
                                                                    {
                                                                        Error.throwError(Error, 0);
                                                                    };
                                                                } while (true);
                                                            };
                                                            _local_6 = _local_16;
                                                        }
                                                        else
                                                        {
                                                            if (_local_5 == 91)
                                                            {
                                                                _local_18 = [];
                                                                do 
                                                                {
                                                                    do 
                                                                    {
                                                                        _local_8 = _arg_2;
                                                                        _arg_2 = (_local_8 + 1);
                                                                        _local_7 = li8(_local_8);
                                                                        if (((_local_7 != (13)) && ((_local_7 != (10)) && ((_local_7 != (32)) && ((_local_7 != (9)) && ((_local_7 != (11)) && ((_local_7 != (8)) && (!(_local_7 == 12)))))))))
                                                                        {
                                                                            if (_local_7 == 47)
                                                                            {
                                                                                _local_8 = _arg_2;
                                                                                _arg_2 = (_local_8 + 1);
                                                                                _local_7 = li8(_local_8);
                                                                                if (_local_7 == 47)
                                                                                {
                                                                                    do 
                                                                                    {
                                                                                        _local_9 = _arg_2;
                                                                                        _arg_2 = (_local_9 + 1);
                                                                                        _local_8 = li8(_local_9);
                                                                                    } while (((_local_8 != (10)) && ((_local_8 != (13)) && (!(_local_8 == 0)))));
                                                                                    _arg_2--;
                                                                                    continue;
                                                                                };
                                                                                if (_local_7 == 42)
                                                                                {
                                                                                    _arg_2 = (_arg_2 - 2);
                                                                                    _local_7 = _arg_2;
                                                                                    _local_8 = _arg_2;
                                                                                    _local_9 = _arg_2;
                                                                                    _arg_2 = (_local_9 + 1);
                                                                                    if (((li8(_local_9) != (47)) || (!(li8(_local_9) == 42))))
                                                                                    {
                                                                                        _arg_2 = _local_8;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        do 
                                                                                        {
                                                                                            _local_10 = _arg_2;
                                                                                            _arg_2 = (_local_10 + 1);
                                                                                            _local_9 = li8(_local_10);
                                                                                            if (_local_9 == 42)
                                                                                            {
                                                                                                _local_10 = _arg_2;
                                                                                                _arg_2 = (_local_10 + 1);
                                                                                                if (li8(_local_10) == 47) break;
                                                                                                _arg_2--;
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                if (_local_9 == 0)
                                                                                                {
                                                                                                    _arg_2 = _local_8;
                                                                                                    break;
                                                                                                };
                                                                                            };
                                                                                        } while (true);
                                                                                    };
                                                                                    if (_local_7 != _arg_2) continue;
                                                                                };
                                                                                _arg_2--;
                                                                                _local_7 = 47;
                                                                            };
                                                                            break;
                                                                        };
                                                                    } while (true);
                                                                    _local_5 = _local_7;
                                                                    if (_local_5 == 93) break;
                                                                    if (_local_5 == 44)
                                                                    {
                                                                        _local_18.push(undefined);
                                                                    }
                                                                    else
                                                                    {
                                                                        _arg_2--;
                                                                        _local_18.push(readValue(_arg_1, _arg_2));
                                                                        _arg_2 = position;
                                                                        do 
                                                                        {
                                                                            _local_8 = _arg_2;
                                                                            _arg_2 = (_local_8 + 1);
                                                                            _local_7 = li8(_local_8);
                                                                            if (((_local_7 != (13)) && ((_local_7 != (10)) && ((_local_7 != (32)) && ((_local_7 != (9)) && ((_local_7 != (11)) && ((_local_7 != (8)) && (!(_local_7 == 12)))))))))
                                                                            {
                                                                                if (_local_7 == 47)
                                                                                {
                                                                                    _local_8 = _arg_2;
                                                                                    _arg_2 = (_local_8 + 1);
                                                                                    _local_7 = li8(_local_8);
                                                                                    if (_local_7 == 47)
                                                                                    {
                                                                                        do 
                                                                                        {
                                                                                            _local_9 = _arg_2;
                                                                                            _arg_2 = (_local_9 + 1);
                                                                                            _local_8 = li8(_local_9);
                                                                                        } while (((_local_8 != (10)) && ((_local_8 != (13)) && (!(_local_8 == 0)))));
                                                                                        _arg_2--;
                                                                                        continue;
                                                                                    };
                                                                                    if (_local_7 == 42)
                                                                                    {
                                                                                        _arg_2 = (_arg_2 - 2);
                                                                                        _local_7 = _arg_2;
                                                                                        _local_8 = _arg_2;
                                                                                        _local_9 = _arg_2;
                                                                                        _arg_2 = (_local_9 + 1);
                                                                                        if (((li8(_local_9) != (47)) || (!(li8(_local_9) == 42))))
                                                                                        {
                                                                                            _arg_2 = _local_8;
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            do 
                                                                                            {
                                                                                                _local_10 = _arg_2;
                                                                                                _arg_2 = (_local_10 + 1);
                                                                                                _local_9 = li8(_local_10);
                                                                                                if (_local_9 == 42)
                                                                                                {
                                                                                                    _local_10 = _arg_2;
                                                                                                    _arg_2 = (_local_10 + 1);
                                                                                                    if (li8(_local_10) == 47) break;
                                                                                                    _arg_2--;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    if (_local_9 == 0)
                                                                                                    {
                                                                                                        _arg_2 = _local_8;
                                                                                                        break;
                                                                                                    };
                                                                                                };
                                                                                            } while (true);
                                                                                        };
                                                                                        if (_local_7 != _arg_2) continue;
                                                                                    };
                                                                                    _arg_2--;
                                                                                    _local_7 = 47;
                                                                                };
                                                                                break;
                                                                            };
                                                                        } while (true);
                                                                        _local_5 = _local_7;
                                                                        if (_local_5 == 93) break;
                                                                        if (_local_5 != 44)
                                                                        {
                                                                            Error.throwError(Error, 0);
                                                                        };
                                                                    };
                                                                } while (true);
                                                                _local_6 = _local_18;
                                                            }
                                                            else
                                                            {
                                                                Error.throwError(Error, 0);
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                        position = _arg_2;
                        return (_local_6);
                    };
                    _local_12 = false;
                    try
                    {
                        _local_3 = readValue(_local_5, position);
                        _local_6 = position;
                        do 
                        {
                            _local_9 = _local_6;
                            _local_6 = (_local_9 + 1);
                            _local_8 = li8(_local_9);
                            if (((_local_8 != (13)) && ((_local_8 != (10)) && ((_local_8 != (32)) && ((_local_8 != (9)) && ((_local_8 != (11)) && ((_local_8 != (8)) && (!(_local_8 == 12)))))))))
                            {
                                if (_local_8 == 47)
                                {
                                    _local_9 = _local_6;
                                    _local_6 = (_local_9 + 1);
                                    _local_8 = li8(_local_9);
                                    if (_local_8 == 47)
                                    {
                                        do 
                                        {
                                            _local_10 = _local_6;
                                            _local_6 = (_local_10 + 1);
                                            _local_9 = li8(_local_10);
                                        } while (((_local_9 != (10)) && ((_local_9 != (13)) && (!(_local_9 == 0)))));
                                        _local_6--;
                                        continue;
                                    };
                                    if (_local_8 == 42)
                                    {
                                        _local_6 = (_local_6 - 2);
                                        _local_8 = _local_6;
                                        _local_9 = _local_6;
                                        _local_10 = _local_6;
                                        _local_6 = (_local_10 + 1);
                                        if (((li8(_local_10) != (47)) || (!(li8(_local_10) == 42))))
                                        {
                                            _local_6 = _local_9;
                                        }
                                        else
                                        {
                                            do 
                                            {
                                                _local_11 = _local_6;
                                                _local_6 = (_local_11 + 1);
                                                _local_10 = li8(_local_11);
                                                if (_local_10 == 42)
                                                {
                                                    _local_11 = _local_6;
                                                    _local_6 = (_local_11 + 1);
                                                    if (li8(_local_11) == 47) break;
                                                    _local_6--;
                                                }
                                                else
                                                {
                                                    if (_local_10 == 0)
                                                    {
                                                        _local_6 = _local_9;
                                                        break;
                                                    };
                                                };
                                            } while (true);
                                        };
                                        if (_local_8 != _local_6) continue;
                                    };
                                    _local_6--;
                                    _local_8 = 47;
                                };
                                break;
                            };
                        } while (true);
                        _local_7 = _local_8;
                        if (_local_7 == 0)
                        {
                            _local_12 = true;
                        };
                    }
                    catch(_unnamedErr)
                    {
                        _local_13 = _unnamedErr;
                    };
                    if (!_local_12)
                    {
                        ApplicationDomain.currentDomain.domainMemory = _local_4;
                        Error.throwError(SyntaxError, 1509);
                    };
                };
                ApplicationDomain.currentDomain.domainMemory = _local_4;
            };
            return (_local_3);
        }


    }
}

