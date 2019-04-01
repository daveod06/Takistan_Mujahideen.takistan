params ["_lz0", "_spawn0"];


_lz0_pos = getPos _lz0;
_helispawn_0_pos = getMarkerPos _spawn0;


private _spawnVector = (_helispawn_0_pos) vectorDiff (_lz0_pos);
_pos = (_lz0_pos vectorAdd (_spawnVector vectorMultiply 0.8)) vectorAdd [0,0,60];
private _dir = (_helispawn_0_pos) getDir (_lz0_pos);
_result = [_pos,_dir, selectRandom TOOTH_Escort_Chopper, TOOTH_Reinforcment_Chopper_Side] call BIS_fnc_spawnVehicle;
private _boat3 = _result select 0;
private _group3 = _result select 2;
_crew = crew _boat3;
{
	//_x allowDamage false;
} forEach _crew;

_waypoint = _group3 addWaypoint [_lz0_pos, 0];
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointFormation "WEDGE";
_waypoint setWaypointType "SAD";
_waypoint setWaypointLoiterRadius 300;
_waypoint setWaypointTimeout [400,500,600];

_callsign = format ["Boomer %1",TOOTH_Escort_Chopper_Num];
TOOTH_Escort_Chopper_Num = TOOTH_Escort_Chopper_Num + 1;
_group3 setGroupId [_callsign];
_group3 setCombatMode "RED";
_group3 setCombatMode "COMBAT";

_skillset = [
0.3,        // aimingAccuracy
0.1,        // aimingShake
0.1,        // aimingSpeed
1.0,         // spotDistance
1.0,        // spotTime
1.0,        // courage
0.5,        // reloadSpeed
1.0,        // commanding
1.0        // general
];

// set AI squad skill
{
	_unit = _x;
	{
		_skillvalue = (_skillset select _forEachIndex);
		_unit setSkill [_x,_skillvalue];
	} forEach ["aimingAccuracy","aimingShake","aimingSpeed","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];
} forEach (units _group3);



//_boat3 flyinheight 60;

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

[_boat3] spawn _heloGuard;

sleep 1;


// need to add extraction waypoint and delete chopper

_waypoint = _group3 addWaypoint [_helispawn_0_pos, 0];
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointFormation "WEDGE";
_waypoint setWaypointType "MOVE";
private _despawnCommand = "_heli = vehicle this;{{deleteVehicle _x} forEach crew _heli} forEach thisList; deleteVehicle _heli;";
_waypoint setWaypointStatements ["true", _despawnCommand];





