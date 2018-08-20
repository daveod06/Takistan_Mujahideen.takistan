_vehArray = [];
_attackMarker = "";
_vehArray = _this select 0;
_attackMarker = _this select 1;
_spawnMarker = _this select 2;

// Get distance and direction towards attack point
private _AttackToSpawnBearing = (getMarkerPos _attackMarker) getDir (getMarkerPos _spawnMarker);
private _attackDistance = (getMarkerPos _spawnMarker) distance2D (getMarkerPos _attackMarker);


_message = format ["Vehicle Waypoints  _vehArray %1",_vehArray]; // FIXME
if Saber_DEBUG then {hint _message; sleep 5.0;};

_hasCargo = false;
//{
    _veh = _vehArray select 0;
    _vehCrew = _vehArray select 1;
    _group = _vehArray select 2;

    private _attackPos = getMarkerPos _attackMarker;

    _vehCargo = fullCrew [_veh,"cargo", false];
    if (count _vehCargo > 0) then
    {
        _hasCargo = true;
		//_cargoUnit = _vehCargo select 0;
	    //_cargoGroup = group (_cargoUnit select 0);
    }
    else
    {
        _hasCargo = false;
        //_cargoGroup= objNull;
    };
    

    _message = format ["Vehicle Waypoints: _veh %1 _vehCargo %2, _hasCargo %3",_veh,_vehCargo,_hasCargo];
    if Saber_DEBUG then {hint _message; sleep 3.0;};

    _wpIndex = 1;
    if (_hasCargo) then {
        // Get out waypoint
        private _getOutPos = (getMarkerPos _attackMarker) getPos [300.0, _AttackToSpawnBearing];
        _wpName = format ["%1_TRANSPORT_UNLOAD", str _group];
        private _wp0 = _group addWaypoint [_getOutPos, 20.0, _wpIndex, _wpName];
        _wp0 setWaypointCombatMode "RED";
        _wp0 setWaypointBehaviour "UNCHANGED";
        _wp0 setWaypointSpeed "FULL";
        _wp0 setWaypointType "TR UNLOAD";
        _wp0 setWaypointFormation "WEDGE";
        _wp0 setWaypointTimeout [5, 6, 8];
    }
    else
    {
        // Attack waypoint
        _wpName = format ["%1_SAD", str _group];
        private _wp0 = _group addWaypoint [_attackPos, 20.0, _wpIndex, _wpName];
        _wp0 setWaypointCombatMode "RED";
        _wp0 setWaypointBehaviour "UNCHANGED";
        _wp0 setWaypointSpeed "FULL";
        _wp0 setWaypointType "SAD";
        _wp0 setWaypointFormation "WEDGE";
        _wp0 setWaypointTimeout [0, 0, 0];
    };

    _patrol = [_group, _attackPos, 500.0] call BIS_fnc_taskPatrol;


//} forEach _vehArray;
