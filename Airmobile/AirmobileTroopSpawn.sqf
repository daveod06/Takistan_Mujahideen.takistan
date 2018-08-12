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


// INFANTRY SKILL
_InfskillSet = [
0.25,        // aimingAccuracy
0.45,        // aimingShake
0.5,        // aimingSpeed
0.4,         // spotDistance
0.3,        // spotTime
1,        // courage
1,        // reloadSpeed
1,        // commanding
1        // general
];



//fnc_AirmobileSpawn = {
private _side                       = _this select 0;
private _faction                    = _this select 1;
//private _transportType              = _this select 2;
//private _attackType                 = _this select 3;
private _squadType                  = _this select 2;
private _spawnHeliOutput            = _this select 3;
private _category                   = _this select 4;
//private _spawnInAir                 = _this select 6;
//private _lzInitOutput               = _this select 7;
//private _totalHelicoptersToSpawn    = 0;
//private _baseHelipads               = [];
//private _lzHelipads                 = [];
//private _attackHeliToSpawn          = 0;
//private _transportHeliToSpawn       = 0;
//private _iterator                   = 0;
//private _airmobileHQ                = objNull;
private _spawnedVehicles            = [];
//private _spawnedGroups              = [];
private _spawnPos                   = [0,0,0];
private _spawnDir                   = 0;
private _spawnClass                 = "";
private _vehArray                   = [];
private _vehName                    = "";
private _spawnedAttackHelis         = [];
private _spawnedTransportHelis      = _spawnHeliOutput select 1;
private _spawnedTroopGroups         = [];
private _sideStr                    = "";
private _group                      = objNull;
private _heli                       = "";
private _numMen                     = 0;
private _totalSeats                 = 0;
private _crewSeats                  = 0;
private _cargoSeats                 = 0;
private _output                     = [];


//_totalHelicoptersToSpawn    = _lzInitOutput select 0;
//_baseHelipads               = _lzInitOutput select 1;
//_lzHelipads                 = _lzInitOutput select 2;


// Basic Setup
_iterator = 0;
_airmobileHQ = createCenter _side;
_spawnedVehicles = [];
_spawnedGroups = [];
//_spawnPos = [0,0,0];
//_spawnDir = 0;
//_spawnClass = "";
//_vehArray = [];
//_vehName ="";
//_spawnedAttackHelis = [];
//_spawnedTransportHelis = [];
//_spawnedTroopGroups = [];
//_sideStr = "";
//_group = "group";
//_heli = objNull;
//_numMen = 0;
//_totalSeats = 0;
//_crewSeats = 0;
//_cargoSeats = 0;
//_output = [];


//private _message = format ["_spawnedTransportHelis: %1",_spawnedTransportHelis];
//hint _message;
//sleep 5.0;


// Spawn Troop Squads
for "_s" from 0 to (count _spawnedTransportHelis - 1) do
{
	// Get spawn parameters
	_spawnPos = [0,0,0];
	_spawnClass = _squadType;
	
	// Get side string
	if (_side == east) then
	{
		_sideStr = "East"
	};
	if (_side == west) then
	{
		_sideStr = "West"
	};
	if (_side == resistance) then
	{
		_sideStr = "Resistance"
	};
	
	// Spawn Troops
	_message = format ["Trying to spawn troops. (%1)", _s];
	if Saber_DEBUG then {hint _message;};
	//[pos, side, (configFile >> "CfgGroups" >> "East" >> "SovietArmy_OKSVA" >> "Infantry" >> "SovietArmy_OKSVA_infantry_rifle_squad")] call BIS_fnc_spawnGroup;
	_group = [ _spawnPos, _side, (configFile >> "CfgGroups" >> _sideStr >> _faction >> _category >> _spawnClass)] call BIS_fnc_spawnGroup;
	//_group = [ _spawnPos, _side, (configFile >> "CfgGroups" >> "East" >> "SovietArmy_OKSVA" >> "Infantry" >> "SovietArmy_OKSVA_infantry_rifle_squad")] call BIS_fnc_spawnGroup;
	_group deleteGroupWhenEmpty true;
    [_group,_InfskillSet] call Saber_fnc_AirmobileSetSkill;
	//_group setCombatMode "BLUE";
	//_group setFormation 'WEDGE';
    //_group setBehaviour 'CARELESS';
    //_group setSpeedMode 'NORMAL';
	_spawnedTroopGroups pushBack _group;
	_numMen = count (units _group);
	
	// remove extra troops
	_heli = (_spawnedTransportHelis select _s) select 0;
    _heliType = typeOf _heli;
    
    //_message = format ["_heli: %1 _heliType: %2", _heli,_heliType];
    //if (Saber_DEBUG) then {hint _message;};
    
	_totalSeats = [_heliType, true] call BIS_fnc_crewCount; // Number of total seats: crew + non-FFV cargo/passengers + FFV cargo/passengers
	_crewSeats = [_heliType, false] call BIS_fnc_crewCount; // Number of crew seats only
	_cargoSeats = _totalSeats - _crewSeats; // Number of total cargo/passenger seats: non-FFV + FFV
	if (_numMen > _cargoSeats) then
	{
		for "_d" from (_cargoSeats - 1) to (_numMen - 1) do
		{
			deleteVehicle (units _group select _d);
		};
	};
	//_message = format ["units _group: %1",units _group];
	//if Saber_DEBUG then {hint _message;};
	//sleep 2.0;
	
	//_message = format ["_heli: %1",_heli];
	//if Saber_DEBUG then {hint _message;};
	//sleep 2.0;
	
	// put troops in heli
	{
		_x moveInCargo _heli;
	} forEach units _group;
	sleep 0.3;
};

_output = [_spawnedTroopGroups];
_output;
//};



//// _this = [_side,_faction,_transportType,_attackType,_squadType,_spawnAttackHelis,_spawnInAir,[_totalHelicoptersToSpawn, _baseHelipads, _lzHelipads]];
//if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
//{
//    _message = "Calling fnc_AirmobileSpawn.";
//    if Saber_DEBUG then {hint _message;};
//    sleep 1.0;
//    _output = [_this] call fnc_AirmobileSpawn;
//}
//else
//{
//    if(isServer) then
//    {
//		  _message = "Calling fnc_AirmobileSpawn.";
//        if Saber_DEBUG then {hint _message;};
//        sleep 1.0;
//        _output = [_this] call fnc_AirmobileSpawn;
//    };
//};
