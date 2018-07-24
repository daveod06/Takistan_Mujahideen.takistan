// give troops patrol waypoint to nearest threat, set to aware


//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

//fnc_AirmobileTroopWaypoints = {
private _lzInitOutput = _this select 0;
private _spawnHeliOutput = _this select 1;
private _spawnTroopOutput = _this select 2;

private _message = format ["_lzInitOutput: %1",_lzInitOutput];
hint _message;
sleep 3.0;
private _message = format ["_spawnHeliOutput: %1",_spawnHeliOutput];
hint _message;
sleep 3.0;

private _lzHelipads = _lzInitOutput select 2;
//private _lzTrigger = _lzOutput select 4;
private _spawnedAttackHelis = _spawnHeliOutput select 0;
private _spawnedTransportHelis = _spawnHeliOutput select 1;
private _spawnedTroopGroups = _spawnTroopOutput select 0;


private _numSpawnedAttackHelis = count _spawnedAttackHelis;
private _t = _numSpawnedAttackHelis;

// Troops squads
{
    // Assign helipad
    _lzHelipad = _lzHelipads select _t;
    _group = _x;
    
    // Find nearest enemies
    private _enemyPos = (leader _group) findNearestEnemy (getPos _lzHelipad);
    if (isNull _enemyPos) then
    {
        _enemyPos = _lzHelipad getPos [300.0, random[0.0,180.0,360.0]];
    };
    
    // Get out waypoint
    private _getOutPos = getPos _lzHelipad;
    //_getOutPos = _getOutPos set [2, (_getOutPos select 2) + 100];
    _wpName = format ["%1_Get_Out", str _group];
    private _wp0 = _x addWaypoint [_getOutPos, 5.0, 0, _wpName];
    _wp0 setWaypointCombatMode "RED";
    _wp0 setWaypointBehaviour "AWARE";
    _wp0 setWaypointSpeed "FULL";
    _wp0 setWaypointType "GETOUT";
    _wp0 setWaypointFormation "WEDGE";
    _wp0 setWaypointTimeout [0, 0, 0];
    _wp0 setWaypointCompletionRadius 3;
    
    // Attack waypoint
    private _attackPos = _enemyPos;
    _wpName = format ["%1_SAD", str _group];
    private _wp1 = _x addWaypoint [_attackPos, 20.0, 1, _wpName];
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
    private _PickUpPos = getPos _lzHelipad;
    _wpName = format ["%1_Pick_Up", str _group];
    private _wp2 = _x addWaypoint [_PickUpPos, 30.0, 2, _wpName];
    _wp2 setWaypointCombatMode "RED";
    _wp2 setWaypointBehaviour "UNCHANGED";
    _wp2 setWaypointSpeed "FULL";
    _wp2 setWaypointType "MOVE";
    _wp2 setWaypointFormation "WEDGE";
    _wp2 setWaypointTimeout [0, 0, 0];
    private _command = format ["groupsReadyForPickup = true;"];
    _wp2 setWaypointStatements ["true",_command];
    
    _t = _t + 1;
    
} forEach _spawnedTroopGroups;
//};





//// _this = [[_totalHelicoptersToSpawn,_baseHelipads,_lzHelipads,_baseTrigger,_lzTrigger],[_spawnedAttackHelis,_spawnedTransportHelis,_spawnedTroopGroups]];
//if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
//{
//    hint "Calling fnc_AirmobileTroopWaypoints.";
//    sleep 1.0;
//    _output = [_this] call fnc_AirmobileTroopWaypoints;
//}
//else
//{
//    if(isServer) then
//    {
//        hint "Calling fnc_AirmobileTroopWaypoints.";
//        sleep 1.0;
//        _output = [_this] call fnc_AirmobileTroopWaypoints;
//    };
//};
