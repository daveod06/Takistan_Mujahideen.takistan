// give troops patrol waypoint to nearest threat, set to aware

//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

//fnc_AirmobileTroopWaypoints = {

// Troops squads
_lzPos = _this select 0; // pos of helicopter WP or LZ
_group = _this select 1; // group of men in chopper
_vehGroup = _this select 2; // group of chopper

// Find nearest enemies
_nearestEnemy = [(leader _group),500] call Saber_fnc_findNearestEnemy;
if !(isNull _nearestEnemy) then
{
    _enemyPos = getPos _nearestEnemy;
}
else
{
    _enemyPos = _lzPos getPos [300.0, random[0.0,180.0,360.0]];
};

// Get out waypoint
_wpIndex = 0; // DON'T COMMENT OUT
//private _getOutPos = getPos _lzPos;
////_getOutPos = _getOutPos set [2, (_getOutPos select 2) + 100];
//_wpName = format ["%1_Get_Out", str _group];
//private _wp0 = _x addWaypoint [_getOutPos, 5.0, _wpIndex, _wpName];
//_wp0 setWaypointCombatMode "RED";
//_wp0 setWaypointBehaviour "AWARE";
//_wp0 setWaypointSpeed "FULL";
//_wp0 setWaypointType "GETOUT";
//_wp0 setWaypointFormation "WEDGE";
//_wp0 setWaypointTimeout [0, 0, 0];
//_wp0 setWaypointCompletionRadius 3;

// Attack waypoint
_wpIndex = _wpIndex + 1;
private _attackPos = _enemyPos;
_wpName = format ["%1_SAD", str _group];
private _wp1 = _x addWaypoint [_attackPos, 20.0, _wpIndex, _wpName];
_wp1 setWaypointCombatMode "RED";
_wp1 setWaypointBehaviour "UNCHANGED";
_wp1 setWaypointSpeed "FULL";
_wp1 setWaypointType "SAD";
_wp1 setWaypointFormation "WEDGE";
_wp1 setWaypointTimeout [0, 0, 0];

// Patrol waypoint
private _patrolSuccess = [];
private _success = [_x, _attackPos, 500.0] call BIS_fnc_taskPatrol;
private _message = format ["%1 has completed their patrol",_x];
//_patrolSuccess pushBack [_success,_message,_x];

// Pick up waypoint
_wpIndex = _wpIndex + 1;
private _PickUpPos = getPos _lzPos;
_wpName = format ["%1_Pick_Up", str _group];
private _wp2 = _x addWaypoint [_PickUpPos, 30.0, _wpIndex, _wpName];
_wp2 setWaypointCombatMode "RED";
_wp2 setWaypointBehaviour "UNCHANGED";
_wp2 setWaypointSpeed "FULL";
_wp2 setWaypointType "MOVE";
_wp2 setWaypointFormation "WEDGE";
_wp2 setWaypointTimeout [0, 0, 0];
private _command = format ["groupsReadyForPickup = true;"];
_wp2 setWaypointStatements ["true",_command];
    
    


