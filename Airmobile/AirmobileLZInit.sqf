// determine destination & num helipads
// determine spawn area and create helipads if on ground

//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

//fnc_AirmobileLZInit =
//{
private _lzHelipadsArray           = _this select 0;
private _baseHelipadsArray         = _this select 1;
private _lzTrigger                = "";
private _baseTrigger              = "";
private _lzHelipads               = [];
private _message                  = "";
private _objectsInsideLZ          = [];
private _numBaseHelipads          = 0;
private _baseHelipads             = [];
private _message                  = "";
private _objectsInsideBase        = [];
private _totalHelicoptersToSpawn  = 0;
private _output                   = [];

// Select base and LZ triggers
//_lzTrigger                = _lzHelipadsArray select 0; // FIXME
//_baseTrigger              = _baseHelipadsArray select 0; // FIXME
//_lzTrigger setTriggerActivation ["ANY", "PRESENT", false];
//_lzTrigger setTriggerStatements [true, "objectsInsideLZ = thisList", ""] ;
//_baseTrigger setTriggerActivation ["ANY", "PRESENT", false];
//_baseTrigger setTriggerStatements [true, "objectsInsideBase = thisList", ""] ;
sleep 1.0;
//_objectsInsideLZ = objectsInsideLZ;
//_objectsInsideBase = objectsInsideBase;

//_objectsInsideLZ = [helipad10_0,helipad10_1,helipad10_2,helipad10_3,helipad10_4,helipad10_5,helipad10_6,helipad10_7]; // FIXME
//_objectsInsideBase = [spawn_helipad0_0,spawn_helipad0_1,spawn_helipad0_2,spawn_helipad0_3,spawn_helipad0_4,spawn_helipad0_5,spawn_helipad0_6,spawn_helipad0_7]; // FIXME

_objectsInsideLZ = _lzHelipadsArray;
_objectsInsideBase = _baseHelipadsArray;

if ((count _objectsInsideLZ == 0) or (count _objectsInsideBase == 0)) exitWith
{
	hint "No helipads in either base or LZ.";
};

// Get LZ Helipad count
_numLZHelipads = 0;
_lzHelipads = [];
_message = "";
{
	_message = format ["_objectsInsideLZ: %1 ",_objectsInsideLZ];
	hint _message;
	_obj = _x;
	if (typeOf _obj == "Land_HelipadEmpty_F") then
	{
		_numLZHelipads = _numLZHelipads + 1;
		//_LZHelipads pushBack vehicleVarName _x;
		_lzHelipads pushBack _obj;
	}; 
} forEach _objectsInsideLZ;
_message = format ["%1 Helipads in the LZ.", _numLZHelipads];
hint _message;
sleep 1.0;

// Get Base Helipad count
_numBaseHelipads = 0;
_baseHelipads = [];
_message = "";
{
	if (typeOf _x == "Land_HelipadEmpty_F") then
	{
		_numBaseHelipads = _numBaseHelipads + 1;
		//_BaseHelipads pushBack vehicleVarName _x;
		_baseHelipads pushBack _x;
	}; 
} forEach _objectsInsideBase;
_message = format ["%1 Helipads in the base.", _numBaseHelipads];
hint _message;
sleep 1.0;

// Compare Helipad counts
_totalHelicoptersToSpawn = 0;
if (_numLZHelipads > _numBaseHelipads) then
{
	_message = format ["LZ has more helipads (%1) then Base (%2). Limiting to %3 helicopters.", _numLZHelipads, _numBaseHelipads, _numBaseHelipads];
	hint _message;
	_totalHelicoptersToSpawn = _numBaseHelipads;
};
if (_numLZHelipads < _numBaseHelipads) then
{
	_message = format ["LZ has less helipads (%1) then Base (%2). Limiting to %3 helicopters.", _numLZHelipads, _numBaseHelipads, _numLZHelipads];
	hint _message;
	_totalHelicoptersToSpawn = _numLZHelipads;
}
else
{
	_message = format ["LZ has same number of helipads (%1) as the Base (%2).", _numLZHelipads, _numBaseHelipads];
	hint _message;
	_totalHelicoptersToSpawn = _numLZHelipads;
	if (_totalHelicoptersToSpawn > 8) then
	{
	    _totalHelicoptersToSpawn = 8;
	};
};

_output = [_totalHelicoptersToSpawn, _baseHelipads, _lzHelipads,_baseTrigger,_lzTrigger];
_output;
//};


//// _this = [_lzHelipadsArray,_lzBaseArray];
//if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
//{
//    hint "Calling fnc_AirmobileLZInit.";
//    sleep 1.0;
//    _output = [_this] call fnc_AirmobileLZInit;
//}
//else
//{
//    if(isServer) then
//    {
//		private _message = format ["_this: %1",_this];
//		hint _message;
//		sleep 5.0;
//        hint "Calling fnc_AirmobileLZInit.";
//        sleep 1.0;
//        _output = [_this] call fnc_AirmobileLZInit;
//    };
//};
