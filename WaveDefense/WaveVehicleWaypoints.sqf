_vehArray = [];
_attackMarker = "";
_vehArray = _this select 0;
_attackMarker = _this select 1;

{
    _veh = _x select 0;
    _vehCrew = _x select 1;
    _group = _x select 2;
    _wpIndex = 1;

    // Attack waypoint
    private _attackPos = getMarkerPos _attackMarker;
    _wpName = format ["%1_SAD", str _group];
    private _wp0 = _group addWaypoint [_attackPos, 20.0, _wpIndex, _wpName];
    _wp0 setWaypointCombatMode "RED";
    _wp0 setWaypointBehaviour "UNCHANGED";
    _wp0 setWaypointSpeed "FULL";
    _wp0 setWaypointType "MOVE";
    _wp0 setWaypointFormation "WEDGE";
    _wp0 setWaypointTimeout [0, 0, 0];

    _patrol = [_x, _attackPos, 500.0] call BIS_fnc_taskPatrol;


} forEach _vehArray;
