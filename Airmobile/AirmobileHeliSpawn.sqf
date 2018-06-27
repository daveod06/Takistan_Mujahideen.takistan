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

//fnc_AirmobileSpawn = {
private _side                       = _this select 0;
private _faction                    = _this select 1;
private _transportType              = _this select 2;
private _attackType                 = _this select 3;
//private _squadType                  = _this select 4;
private _spawnAttackHelis           = _this select 4;
private _spawnInAir                 = _this select 5;
private _lzInitOutput               = _this select 6;
private _totalHelicoptersToSpawn    = 0;
private _baseHelipads               = [];
private _lzHelipads                 = [];
private _attackHeliToSpawn          = 0;
private _transportHeliToSpawn       = 0;
private _iterator                   = 0;
private _airmobileHQ                = objNull;
private _spawnedVehicles            = [];
//private _spawnedGroups              = [];
private _spawnPos                   = [0,0,0];
private _spawnDir                   = 0;
private _spawnClass                 = "";
private _vehArray                   = [];
private _vehName                    = "";
private _spawnedAttackHelis         = [];
private _spawnedTransportHelis      = [];
//private _spawnedTroopGroups         = [];
private _sideStr                    = "";
private _group                      = objNull;
private _heli                       = "";
//private _numMen                     = 0;
//private _totalSeats                 = 0;
//private _crewSeats                  = 0;
//private _cargoSeats                 = 0;
private _output                     = [];


_totalHelicoptersToSpawn    = _lzInitOutput select 0;
//_totalHelicoptersToSpawn = 8;
_baseHelipads               = _lzInitOutput select 1;
//_lzHelipads                 = _lzInitOutput select 2;
_baseHelipads = [spawn_helipad0_0,spawn_helipad0_1,spawn_helipad0_2,spawn_helipad0_3,spawn_helipad0_4,spawn_helipad0_5,spawn_helipad0_6,spawn_helipad0_7];


// figure out how many helicopters to spawn
_attackHeliToSpawn = 0;
_transportHeliToSpawn = 0;
if (_spawnAttackHelis) then
{
	if (_totalHelicoptersToSpawn < 3) then // no attack helis
	{
		_attackHeliToSpawn = 0;
		_transportHeliToSpawn = _totalHelicoptersToSpawn;
	};
	if (_totalHelicoptersToSpawn == 3) then // 1 attack heli, 2 transport
	{
		_attackHeliToSpawn = _totalHelicoptersToSpawn - 2;
		_transportHeliToSpawn = _totalHelicoptersToSpawn - 1;
	};
	if (_totalHelicoptersToSpawn == 4) then // 1 attack heli, 3 transport
	{
		_attackHeliToSpawn = _totalHelicoptersToSpawn - 3;
		_transportHeliToSpawn = _totalHelicoptersToSpawn - 1;
	};
	if (_totalHelicoptersToSpawn == 5) then // 1 attack heli, 4 transport
	{
		_attackHeliToSpawn = _totalHelicoptersToSpawn - 4;
		_transportHeliToSpawn = _totalHelicoptersToSpawn - 1;
	};
	if (_totalHelicoptersToSpawn == 6) then // 2 attack heli, 4 transport
	{
		_attackHeliToSpawn = _totalHelicoptersToSpawn - 4;
		_transportHeliToSpawn = _totalHelicoptersToSpawn - 2;
	};
	if (_totalHelicoptersToSpawn == 7) then // 2 attack heli, 5 transport
	{
		_attackHeliToSpawn = _totalHelicoptersToSpawn - 5;
		_transportHeliToSpawn = _totalHelicoptersToSpawn - 2;
	};
	if (_totalHelicoptersToSpawn == 8) then // 2 attack heli, 6 transport
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
_iterator = 0;
_airmobileHQ = createCenter _side;
_spawnedVehicles = [];
//_spawnedGroups = [];
_spawnPos = [0,0,0];
_spawnDir = 0;
_spawnClass = "";
_vehArray = [];
_vehName ="";
_spawnedAttackHelis = [];
_spawnedTransportHelis = [];
_spawnedTroopGroups = [];
_sideStr = "";
_group = "group";
_heli = "heli";
_numMen = 0;
_totalSeats = 0;
_crewSeats = 0;
_cargoSeats = 0;
_output = [];

// Spawn Attack Helicopters
for "_a" from 0 to (_attackHeliToSpawn - 1) do
{
	// Get spawn parameters
	_spawnPos = getPosATL (_baseHelipads select _a);
	if (_spawnInAir) then
	{
		_spawnPos set [2, (_spawnPos select 2) + 200 - _iterator*10]
	};
	_spawnDir = getDir (_baseHelipads select _a);
	_spawnClass = _attackType;
	
	// Spawn Helicopter
	_vehArray = [_spawnPos, _spawnDir, _spawnClass, _side] call bis_fnc_spawnvehicle;
    //_vehName 	= _vehArray select 0;
    //_vehCrew 	= _vehArray select 1;
    _vehGroup 	= _vehArray select 2;
    _vehGroup setFormation 'WEDGE';
    _vehGroup setBehaviour 'CARELESS';
    _vehGroup setSpeedMode 'NORMAL';
    _vehGroup deleteGroupWhenEmpty true;
	_spawnedAttackHelis pushBack _vehArray;
	_iterator = _iterator + 1;
};

// Spawn Transport Helicopters
for "_t" from 0 to (_transportHeliToSpawn - 1) do
{
	// Get spawn parameters
	_spawnPos = getPosATL (_baseHelipads select _t + _attackHeliToSpawn);
	if (_spawnInAir) then
	{
		_spawnPos set [2, (_spawnPos select 2) + 250 - _iterator*10]
	};
	_spawnDir = getDir (_baseHelipads select _t + _attackHeliToSpawn);
	_spawnClass = _transportType;
	
	// Spawn Helicopter
	_vehArray =[_spawnPos, _spawnDir, _spawnClass, _side] call bis_fnc_spawnvehicle;
    _vehName 	= _vehArray select 0;
    //_vehCrew 	= _vehArray select 1;
    _vehGroup 	= _vehArray select 2;
    _vehGroup setFormation 'WEDGE';
    _vehGroup setBehaviour 'CARELESS';
    _vehGroup setSpeedMode 'NORMAL';
    _vehGroup deleteGroupWhenEmpty true;
    {(driver _vehName) disableAI _x} forEach ["TARGET","AUTOTARGET","FSM","AUTOCOMBAT"];
    {(commander _vehName) disableAI _x} forEach ["TARGET","AUTOTARGET","FSM","AUTOCOMBAT"];
    
	_spawnedTransportHelis pushBack _vehArray;
	_iterator = _iterator + 1;
};

_output = [_spawnedAttackHelis,_spawnedTransportHelis];
_output;
//};



//// _this = [_side,_faction,_transportType,_attackType,_squadType,_spawnAttackHelis,_spawnInAir,[_totalHelicoptersToSpawn, _baseHelipads, _lzHelipads]];
//if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
//{
//    hint "Calling fnc_AirmobileSpawn.";
//    sleep 1.0;
//    _output = [_this] call fnc_AirmobileSpawn;
//}
//else
//{
//    if(isServer) then
//    {
//        hint "Calling fnc_AirmobileSpawn.";
//        sleep 1.0;
//        _output = [_this] call fnc_AirmobileSpawn;
//    };
//};