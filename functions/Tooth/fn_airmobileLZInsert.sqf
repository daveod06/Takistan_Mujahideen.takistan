params ["_lz0", "_spawn0","_spawnTroops"];


_lz0_pos = getPos _lz0;
_helispawn_0_pos = getMarkerPos _spawn0;

private _dir = (_helispawn_0_pos) getDir (_lz0_pos);
private _result = [_helispawn_0_pos,_dir, selectRandom TOOTH_Reinforcment_Chopper, TOOTH_Reinforcment_Chopper_Side] call BIS_fnc_spawnVehicle;
private _boat0 = _result select 0;
private _group0 = _result select 2;
_group0 setFormation 'WEDGE';
_group0 setBehaviour 'CARELESS';
_group0 setSpeedMode 'FULL';
_group0 setCombatMode 'RED';
_group0 deleteGroupWhenEmpty true;
_callsign = format ["Tiger %1",TOOTH_Reinforcment_Chopper_Num];
TOOTH_Reinforcment_Chopper_Num = TOOTH_Reinforcment_Chopper_Num + 1;
_group0 setGroupIdGlobal [_callsign];
_boat0 setvariable ["State","Init"];

_crew = crew _boat0;
{
	//_x allowDamage false;
} forEach _crew;


if (_spawnTroops) then
{
	// create squad in cargo
	private _assaultGrpArr = [];
    _assaultGrp0 = createGroup [TOOTH_Reinforcment_Chopper_Side, true];

    {
        _unitType = _x;
        _init = [_unitType,false] call ToothFunctions_fnc_getunitloadout;
        _unit = _assaultGrp0 createUnit [_unitType, _lz0_pos, [], 0, "FORM"];
        [_unit, (compileFinal _init)] spawn BIS_fnc_spawn;

    } forEach Tooth_Reinforcment_Group;

	//private _assaultGrp0 = [_lz0_pos, TOOTH_Reinforcment_Chopper_Side, Tooth_Reinforcment_Group] call BIS_fnc_spawnGroup;
	_assaultGrp0 setSpeedMode 'NORMAL';
	_assaultGrp0 setCombatMode 'RED';
	_assaultGrp0 setBehaviour 'AWARE';
	_assaultGrpArr append [_assaultGrp0];
	{
		{_x moveInCargo (vehicle (leader _group0));} foreach (units _x);
	} forEach _assaultGrpArr;

	_skillset = [
	0.3,        // aimingAccuracy
	0.1,        // aimingShake
	0.1,        // aimingSpeed
	0.3,         // spotDistance
	0.4,        // spotTime
	0.8,        // courage
	0.5,        // reloadSpeed
	1.0,        // commanding
	0.7        // general
	];

	// set AI squad skill
	{
		_unit = _x;
		{
			_skillvalue = (_skillset select _forEachIndex) + (random 0.05) - (random 0.05);
			_unit setSkill [_x,_skillvalue];
		} forEach ["aimingAccuracy","aimingShake","aimingSpeed","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];
	} forEach (units _assaultGrp0);
	// have cargo squad join player's squad
	diag_log format ["REINFORCMENT _assaultGrpArr: %1 (units _assaultGrp0): %1",_assaultGrpArr,(units _assaultGrp0)];

	_wp = _assaultGrp0 addWaypoint [_lz0_pos, 5.0];
	_wp setWaypointType "GETOUT";
	[_assaultGrp0, _lz0_pos, 500] call bis_fnc_taskPatrol;
};


[_boat0,_lz0_pos,_helispawn_0_pos] spawn ToothFunctions_fnc_insertionChopper;



diag_log format["fn_RunExtraction: Insertion choppers spawned: %1",_boat0];

_boat0 flyinheight 40;


_heloGuard = {
	params["_heli"];
	sleep 6;
	private _msg = ["We are taking damage!","Under fire!","We are under fire!","Taking damage!","I thought the landing zone was safe!"];
	waituntil{sleep 0.5;((getDammage _heli)>0.1)};
	if(alive (driver _heli)) then {
		[driver _heli,selectRandom _msg] remoteExec ["sideChat",0,false];
	};
	waituntil{sleep 0.5;!(alive _heli)};
	if(!(isNull _heli)) then {
		[[TOOTH_Reinforcment_Chopper_Side,"HQ"],format["%1 is going down!",groupId (group (driver _heli))]] remoteExec ["sideChat",0,false];
	};
};
[_boat0] spawn _heloGuard;

sleep 1;

(driver _boat0) action ["LightOff", _boat0];


while {count (fullCrew [_boat0, "cargo", false]) != 0} do {
	sleep 1;
};
_boat0 setvariable ["State","Evac"];

if(alive (driver _boat0)) then
{
    [driver _boat0,"Everybody get off and let's get the fuck out of here!"] remoteExec ["sideChat",0,false];
};


