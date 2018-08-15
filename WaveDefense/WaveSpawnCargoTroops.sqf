
_side = _this select 0;
_faction = _this select 1;
_squadType = _this select 2;
_spawnMarker = _this select 3;
_waveNum = _this select 4;
_squadNum = _this select 5;
_vehArray = _this select 6;

_category = _squadType select 0;
_squadClassname = _squadType select 1;

_veh 	= _vehArray select 0;
_vehCrew 	= _vehArray select 1;
_vehGroup 	= _vehArray select 2;

_sideStr = "";
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

//_message = format ["Spawned troop input: %1   _sideStr: %2",_this,_sideStr];
//if Saber_DEBUG then {hint _message; sleep 3.0;};

_squadName = "CARGO_WAVE_" + (str _waveNum) + "_VEH_" + (str _squadNum) + "_SQUAD";

_markerPos = getMarkerPos _spawnMarker;
_spawnPos = _markerPos getPos [(random [0,50,100]), (random [0,180,360])];
_spawnPos = [_spawnPos, 1.0, 150.0, 3.0, 0, 1.0, 0] call BIS_fnc_findSafePos;
_group = [ _spawnPos, _side, (configFile >> "CfgGroups" >> _sideStr >> _faction >> _category >> _squadClassname)] call BIS_fnc_spawnGroup;
_group deleteGroupWhenEmpty true;
_group setGroupId [_squadName];
_group setCombatMode "RED";
_group setFormation "WEDGE";
_group setBehaviour "AWARE";
_group setSpeedMode "FULL";

_skills = server getvariable "WaveINFskill";
_skills = WaveINFskill;

//_message = format ["Spawned troop _group: %1 skills: %2",_group,_skills];
//if Saber_DEBUG then {hint _message; sleep 3.0;};

[_group,_skills] call Saber_fnc_WaveSetSkill;

_deadTracker = _squadName + "_DEAD";
server setvariable [_deadTracker,0];
// "INF_WAVE_0_SQUAD_0_DEAD";

// remove extra troops
_vehType = typeOf _veh;

_totalSeats = [vehType, true] call BIS_fnc_crewCount; // Number of total seats: crew + non-FFV cargo/passengers + FFV cargo/passengers
_crewSeats = [_vehType, false] call BIS_fnc_crewCount; // Number of crew seats only
_cargoSeats = _totalSeats - _crewSeats; // Number of total cargo/passenger seats: non-FFV + FFV
if (_numMen > _cargoSeats) then
{
	for "_d" from (_cargoSeats - 1) to (_numMen - 1) do
	{
		deleteVehicle (units _group select _d);
	};
};

{
    _x moveInCargo _veh;
} forEach units _group;

//_message = format ["Spawned troop squad: %1",_group];
//if Saber_DEBUG then {hint _message; sleep 1.0;};

sleep 1.0;

_group
