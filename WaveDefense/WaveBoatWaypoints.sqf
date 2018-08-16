_vehArray = [];
_attackMarker = "";
_vehArray = _this select 0;
_attackMarker = _this select 1;
_spawnMarker = _this select 2;

// Get distance and direction towards attack point
private _spawnToAttackBearing = (getMarkerPos _spawnMarker) getDir (getMarkerPos _attackMarker);
private _AttackToSpawnBearing = (getMarkerPos _attackMarker) getDir (getMarkerPos _spawnMarker);
private _attackDistance = (getMarkerPos _spawnMarker) distance2D (getMarkerPos _attackMarker);

_unloadPositions = [];
_hasCargo = false;

{
    _veh = _x select 0;
    _vehCrew = _x select 1;
    _group = _x select 2;
    _attackPos = (getMarkerPos _attackMarker);

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
    if (_hasCargo) then {
        // Get out waypoint
        _getOutPos = [_attackPos, 0.0, 800.0, 5.0, 1, 1.0, 1] call BIS_fnc_findSafePos;
        _wpName = format ["%1_TRANSPORT_UNLOAD", str _group];
        private _wp0 = _group addWaypoint [_getOutPos, 20.0, _wpIndex, _wpName];
        _wp0 setWaypointCombatMode "RED";
        _wp0 setWaypointBehaviour "UNCHANGED";
        _wp0 setWaypointSpeed "FULL";
        _wp0 setWaypointType "TL UNLOAD";
        _wp0 setWaypointFormation "WEDGE";
        _wp0 setWaypointTimeout [5, 6, 8];
    }


    //_patrol = [_x, _attackPos, 500.0] call BIS_fnc_taskPatrol;


} forEach _vehArray;
