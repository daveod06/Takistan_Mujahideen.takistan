
_attackMarker = "";
_group = _this select 0;
_attackMarker = _this select 1;
_spawnMarker = _this select 2;

//_message = format ["WaveTroopWaypoints _squadArray: %1",_squadArray];
//if Saber_DEBUG then {hint _message;sleep 3.0;};

// Get distance and direction towards attack point
private _spawnToAttackBearing = (getMarkerPos _spawnMarker) getDir (getMarkerPos _attackMarker);
private _AttackToSpawnBearing = (getMarkerPos _attackMarker) getDir (getMarkerPos _spawnMarker);
private _attackDistance = (getMarkerPos _spawnMarker) distance2D (getMarkerPos _attackMarker);

_wpIndex = 1;

// Get out waypoint
private _getOutPos = (getMarkerPos _attackMarker) getPos [300.0, _AttackToSpawnBearing];
_wpName = format ["%1_GET_OUT", str _group];
private _wp0 = _group addWaypoint [_getOutPos, 20.0, _wpIndex, _wpName];
_wp0 setWaypointCombatMode "RED";
_wp0 setWaypointBehaviour "AWARE";
_wp0 setWaypointSpeed "FULL";
_wp0 setWaypointType "MOVE";
_wp0 setWaypointFormation "WEDGE";
_wp0 setWaypointTimeout [0, 0, 0];

private _attackPos = getMarkerPos _attackMarker;
_patrol = [_x, _attackPos, 500.0] call BIS_fnc_taskPatrol;


_getOutPos
