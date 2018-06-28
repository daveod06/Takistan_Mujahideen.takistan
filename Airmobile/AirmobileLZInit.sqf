// determine destination & num helipads
// determine spawn area and create helipads if on ground

//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

//fnc_AirmobileLZInit =
//{
private _objectsInsideLZ          = _this select 0; // FIXME
private _objectsInsideBase        = _this select 1; // FIXME
private _lzTriggerArray           = _this select 2;
private _baseTriggerArray         = _this select 3;
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
_lzTrigger                = _lzTriggerArray select 0;
_baseTrigger              = _baseTriggerArray select 0;
_lzTrigger setTriggerActivation ["ANY", "PRESENT", false];
_lzTrigger setTriggerStatements [true, "objectsInsideLZ = thisList", ""] ;
_baseTrigger setTriggerActivation ["ANY", "PRESENT", false];
_baseTrigger setTriggerStatements [true, "objectsInsideBase = thisList", ""] ;
sleep 1.0;
_objectsInsideLZ = objectsInsideLZ;
_objectsInsideBase = objectsInsideBase;

// Get LZ Helipad count
_numLZHelipads = 0;
_lzHelipads = [];
_message = "";
{
	if (typeOf _x == "Land_HelipadEmpty_F") then
	{
		_numLZHelipads = _numLZHelipads + 1;
		//_LZHelipads pushBack vehicleVarName _x;
		_lzHelipads pushBack _x;
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


//// _this = [_lzTriggerArray,_lzBaseArray];
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