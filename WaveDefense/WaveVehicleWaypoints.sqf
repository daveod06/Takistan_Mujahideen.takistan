_vehArray = [];
_attackMarker = "";
_vehArray = _this select 0;
_attackMarker = _this select 1;

// Get distance and direction towards attack point
private _spawnToAttackBearing = (getMarkerPos _spawnMarker) getDir (getMarkerPos _attackMarker);
private _AttackToSpawnBearing = (getMarkerPos _attackMarker) getDir (getMarkerPos _spawnMarker);
private _attackDistance = (getMarkerPos _spawnMarker) distance2D (getMarkerPos _attackMarker);

{
    _veh = _x select 0;
    _vehCrew = _x select 1;
    _group = _x select 2;

    _vehCargo = fullCrew [_veh,"cargo", false];
    if (count _vehCargo > 0) then
    {
        _hasCargo = true;
		_cargoUnit = _vehCargo select 0;
	    _cargoGroup = group (_cargoUnit select 0);
    }
    else
    {
        _hasCargo = false;
        _cargoGroup= objNull;
    };
    
    _wpIndex = 1;
    if (_hasCargo) {
        // Get out waypoint
        private _getOutPos = (getMarkerPos _attackMarker) getPos [300.0, _AttackToSpawnBearing];
        _wpName = format ["%1_TRANSPORT_UNLOAD", str _group];
        private _wp0 = _group addWaypoint [_getOutPos, 20.0, _wpIndex, _wpName];
        _wp0 setWaypointCombatMode "RED";
        _wp0 setWaypointBehaviour "UNCHANGED";
        _wp0 setWaypointSpeed "FULL";
        _wp0 setWaypointType "TL UNLOAD";
        _wp0 setWaypointFormation "WEDGE";
        _wp0 setWaypointTimeout [5, 6, 8];
    }
    else
    {
        // Attack waypoint
        private _attackPos = getMarkerPos _attackMarker;
        _wpName = format ["%1_MOVE", str _group];
        private _wp0 = _group addWaypoint [_attackPos, 20.0, _wpIndex, _wpName];
        _wp0 setWaypointCombatMode "RED";
        _wp0 setWaypointBehaviour "UNCHANGED";
        _wp0 setWaypointSpeed "FULL";
        _wp0 setWaypointType "MOVE";
        _wp0 setWaypointFormation "WEDGE";
        _wp0 setWaypointTimeout [0, 0, 0];
    };

    _patrol = [_x, _attackPos, 500.0] call BIS_fnc_taskPatrol;


} forEach _vehArray;
