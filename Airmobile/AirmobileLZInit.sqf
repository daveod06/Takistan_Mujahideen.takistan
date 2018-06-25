// determine destination & num helipads
// determine spawn area and create helipads if on ground

//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_AirmobileLZInit =
{
	private _LZTriggerArray            = _this select 0;
	private _BaseTriggerArray         = _this select 1;
	private _return                   = [];
	private _LZTrigger = _LZTriggerArray select 0;
	private _BaseTrigger = _BaseTriggerArray select 0;
	// Get LZ Helipad count
	private _numLZHelipads = 0;
	private _LZHelipads = [];
	private _message = "";
	private _objectsInsideLZ = list _LZTrigger;
	{
		if (typeOf  _x == "Land_HelipadEmpty_F") then
		{
			_numLZHelipads = _numLZHelipads + 1;
			//_LZHelipads pushBack vehicleVarName _x;
			_LZHelipads pushBack _x;
		}; 
	} forEach _objectsInsideLZ;
	_message = format ["%1 Helipads in the LZ.", _numLZHelipads];
	hint _message;
	
	// Get Base Helipad count
	sleep 2.0;
	private _numBaseHelipads = 0;
	private _BaseHelipads = [];
	private _message = "";
	private _objectsInsideBase = list _BaseTrigger;
	{
		if (typeOf  _x == "Land_HelipadEmpty_F") then
		{
			_numBaseHelipads = _numBaseHelipads + 1;
			//_BaseHelipads pushBack vehicleVarName _x;
			_BaseHelipads pushBack _x;
		}; 
	} forEach _objectsInsideBase;
	_message = format ["%1 Helipads in the base.", _numBaseHelipads];
	hint _message;
	
	sleep 1.0;
	// Compare Helipad counts
	private _totalHelicoptersToSpawn = 0;
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
	};
	
	_return = [_totalHelicoptersToSpawn, _BaseHelipads, _LZHelipads];
	_return;
};


// _this = [_lzTriggerArray,_lzBaseArray];
if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    hint "Calling fnc_AirmobileLZInit.";
    sleep 1.0;
    _output = [_this] call fnc_AirmobileLZInit;
}
else
{
    if(isServer) then
    {
        hint "Calling fnc_AirmobileLZInit.";
        sleep 1.0;
        _output = [_this] call fnc_AirmobileLZInit;
    };
};