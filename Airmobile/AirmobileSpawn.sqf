// spawn n helicopters with crew
// group helicopters
// spawn n squads
// group squads
// try to put squads in helicopter cargo depending on size of each helicopter cargo, delete extra troops




//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_AirmobileSpawn = {
	private _side = _this select 0;
	private _faction = _this select 1;
	private _transportType = _this select 2;
	private _attackType = _this select 3;
	private _squadType = _this select 4;
	private _spawnAttackHelis = _this select 5;
	private _spawnInAir = _this select 6;
	private _lzInitOutput = _this select 7;
	private _totalHelicoptersToSpawn = _lzInitOutput select 0;
	private _BaseHelipads = _lzInitOutput select 1;
	private _LZHelipads = _lzInitOutput select 2;

	// figure out how many helicopters to spawn
	private _attackHeliToSpawn = 0;
	private _transportHeliToSpawn = 0;
	if (_spawnAttackHelis) then
	{
		if (_totalHelicoptersToSpawn < 3) then // no attack helis
		{
			_attackHeliToSpawn = 0;
			_transportHeliToSpawn = _totalHelicoptersToSpawn;
		};
		if (_totalHelicoptersToSpawn = 3) then // 1 attack heli, 2 transport
		{
			_attackHeliToSpawn = _totalHelicoptersToSpawn - 2;
			_transportHeliToSpawn = _totalHelicoptersToSpawn - 1;
		};
		if (_totalHelicoptersToSpawn = 4) then // 1 attack heli, 3 transport
		{
			_attackHeliToSpawn = _totalHelicoptersToSpawn - 3;
			_transportHeliToSpawn = _totalHelicoptersToSpawn - 1;
		};
		if (_totalHelicoptersToSpawn = 5) then // 1 attack heli, 4 transport
		{
			_attackHeliToSpawn = _totalHelicoptersToSpawn - 4;
			_transportHeliToSpawn = _totalHelicoptersToSpawn - 1;
		};
		if (_totalHelicoptersToSpawn = 6) then // 2 attack heli, 4 transport
		{
			_attackHeliToSpawn = _totalHelicoptersToSpawn - 4;
			_transportHeliToSpawn = _totalHelicoptersToSpawn - 2;
		};
		if (_totalHelicoptersToSpawn = 7) then // 2 attack heli, 5 transport
		{
			_attackHeliToSpawn = _totalHelicoptersToSpawn - 5;
			_transportHeliToSpawn = _totalHelicoptersToSpawn - 2;
		};
		if (_totalHelicoptersToSpawn = 8) then // 2 attack heli, 6 transport
		{
			_attackHeliToSpawn = _totalHelicoptersToSpawn - 6;
			_transportHeliToSpawn = _totalHelicoptersToSpawn - 2;
		};
	}
	else
	{
		_attackHeliToSpawn = 0;
		_transportHeliToSpawn = _totalHelicoptersToSpawn;
	};
	
	// Basic Setup
	private _iterator = 0;
    private _AirmobileHQ = createCenter _side;
    private _spawnedVehicles = [];
    private _spawnedGroups = [];
    private _spawnPos = [0,0,0];
    private _spawnDir = 0;
    private _spawnClass = "";
    private _vehArray = [];
    private _vehName ="";
    private _spawnedAttackHelis = [];
    private _spawnedTransportHelis = [];
    private _spawnedTroopGroups = [];
    private _sideStr = "";
    private _spawnSide = east;
    private _group = "group";
    private _heli = "heli";
    private _numMen = 0;
    private _totalSeats = 0;
	private _crewSeats = 0;
	private _cargoSeats = 0;
	private _toDelete = 0;
	
	// Spawn Attack Helicopters
	for "_a" from 0 to _attackHeliToSpawn do
	{
		// Get spawn parameters
		_spawnPos = getPosATL (_BaseHelipads select _a);
		if _spawnInAir then
		{
			_spawnPos set [2, (_spawnPos select 2) + 200 - _iterator*10]
		};
		_spawnDir = getDir (_BaseHelipads select _a);
		_spawnClass = _attackType;
		_spawnSide = _side;
		
		// Spawn Helicopter
		_vehArray =[_spawnPos, _spawnDir, _spawnClass, _spawnSide] call bis_fnc_spawnvehicle;
        //_vehName 	= _vehArray select 0;
        //_vehCrew 	= _vehArray select 1;
        //_vehGroup 	= _vehArray select 2;
		_spawnedAttackHelis pushBack _vehArray;
		_iterator = _iterator + 1;
	};
	
	// Spawn Transport Helicopters
	for "_t" from 0 to _transportHeliToSpawn do
	{
		// Get spawn parameters
		_spawnPos = getPosATL (_BaseHelipads select _t + _attackHeliToSpawn);
		if _spawnInAir then
		{
			_spawnPos set [2, (_spawnPos select 2) + 250 - _iterator*10]
		};
		_spawnDir = getDir (_BaseHelipads select _t + _attackHeliToSpawn);
		_spawnClass = _transportType;
		_spawnSide = _side;
		
		// Spawn Helicopter
		_vehArray =[_spawnPos, _spawnDir, _spawnClass, _spawnSide] call bis_fnc_spawnvehicle;
        //_vehName 	= _vehArray select 0;
        //_vehCrew 	= _vehArray select 1;
        //_vehGroup 	= _vehArray select 2;
		_spawnedTransportHelis pushBack _vehArray;
		_iterator = _iterator + 1;
	};
	
	// Spawn Troop Squads
	for "_s" from 0 to (count _spawnedTransportHelis) do
	{
		// Get spawn parameters
		_spawnPos = [0,0,0];
		_spawnClass = _squadType;
		_spawnSide = _side;
		
		// Get side string
		if (_spawnSide == east) then
		{
			_sideStr = "East"
		};
		if (_spawnSide == west) then
		{
			_sideStr = "East"
		};
		if (_spawnSide == resistance) then
		{
			_sideStr = "Resistance"
		};
		
		// Spawn Troops
		//[pos, side, (configFile >> "CfgGroups" >> "East" >> "SovietArmy_OKSVA" >> "Infantry" >> "SovietArmy_OKSVA_infantry_rifle_squad")] call BIS_fnc_spawnGroup;
		//[ _spawnPos, _spawnSide, (configFile >> "CfgGroups" >> _sideStr >> _faction >> "Infantry" >> _spawnClass)] call BIS_fnc_spawnGroup;
		_group = [ _spawnPos, _spawnSide, (configFile >> "CfgGroups" >> "East" >> "SovietArmy_OKSVA" >> "Infantry" >> "SovietArmy_OKSVA_infantry_rifle_squad")] call BIS_fnc_spawnGroup;
		_group deleteGroupWhenEmpty true;
		_spawnedTroopGroups pushBack _group;
		_numMen = units _group;
		
		// remove extra troops
		_heli = _spawnedTransportHelis select _s;
		_totalSeats = [_heli, true] call BIS_fnc_crewCount; // Number of total seats: crew + non-FFV cargo/passengers + FFV cargo/passengers
		_crewSeats = [_heli, false] call BIS_fnc_crewCount; // Number of crew seats only
		_cargoSeats = _totalSeats - _crewSeats; // Number of total cargo/passenger seats: non-FFV + FFV
		if (_numMen > _cargoSeats) then
		{
			for "_d" from (_cargoSeats - 1) to (_numMen - 1) do
			{
				deleteVehicle (units _group select _d);
			};
		};
		
		// put troops in heli
		{
			_x moveInCargo _heli;
		} forEach units _group;
	};
};



// _this = [_side,_faction,_transportType,_attackType,_squadType,_spawnAttackHelis,_spawnInAir,[_totalHelicoptersToSpawn, _BaseHelipads, _LZHelipads]];
if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    hint "Calling fnc_AirmobileSpawn.";
    sleep 1.0;
    _output = [_this] call fnc_AirmobileSpawn;
}
else
{
    if(isServer) then
    {
        hint "Calling fnc_AirmobileSpawn.";
        sleep 1.0;
        _output = [_this] call fnc_AirmobileSpawn;
    };
};
