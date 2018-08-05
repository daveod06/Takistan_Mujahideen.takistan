// give troops patrol waypoint to nearest threat, set to aware

//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};



fnc_unitOk =
{
	private ["_unitName","_unitOk"];

	_unitName = _this select 0;
	_unitOk = false;
	if (!(isNull _unitName)) then
	{
		if (alive _unitName) then
		{
		    _unitOk = true;
		};
	};
	_unitOk
};

fnc_groupOk =
{
    private ["_groupName","_groupOk"];
    _groupName = _this select 0;
    _groupOk = false;
    if (!(isNull _groupName)) then
    {
    	if ({alive _x} count (units _groupName) > 0) then
    	{
    	    _groupOk = true;
    	};
    };
    _groupOk
};

fnc_getEnemyFactions =
{
    private ["_unit","_unitOk","_sidesArray","_enemyFactionsArray","_side"];
    _unit = _this select 0;
    _unitOk = [_unit] call fnc_unitOk;
    if (!_unitOk) exitWith {};
    
    _sidesArray = [WEST,EAST,Resistance,Civilian];
    _enemyFactionsArray = [];
    _side = side _unit;
    
    {
        if ([_side, _x] call BIS_fnc_sideIsEnemy) then
        {
            _enemyFactionsArray append [_x];
        };
    } forEach _sidesArray;
    _enemyFactionsArray
};

fnc_findNearestEnemy =
{
    private ["_unit","_pos"];
    private _input = _this select 0;
    private _distance = _this select 1;
    private _obj = objNull;
    _nearestEnemy = objNull;
    if (typeName _input == "OBJECT") then
    {
        if ([_input] call fnc_unitOk) then
        {
            _obj = _input;
            _pos = getPosATL _obj;
        };
    };
    if (typeName _input == "GROUP") then
    {
        if ([_input] call fnc_groupOk) then
        {
            _obj = leader _input;
            _pos = getPosATL _obj;
        };
    };

    if (Saber_DEBUG && (isNull _obj)) exitWith {hint "Saber_fnc_findNearestEnemy input validation failed.";};

    _nearestEnemy = _obj findNearestEnemy _pos;
    if (isNull _nearestEnemy) then
    {
        _list = _pos nearEntities _distance;
        _enemyFactions = [_obj] call fnc_getEnemyFactions;
        _nearEnemies = _list select {side _x in _enemyFactions;}; 

        if (count _nearEnemies > 0) then
        {
            _closest = _distance;
            _nearestEnemy = _nearEnemies select 0;
            {
                _range = _x distance _obj;
                if (_range <= _closest) then
                {
                    _closest = _range;
                    _nearestEnemy = _x;
                };
            } forEach _nearEnemies;
        }
        else
        {
            _nearestEnemy = objNull;
        };
    };
    _nearestEnemy

};








//fnc_AirmobileTroopWaypoints = {

// Troops squads
_lzPos = _this select 0; // pos of helicopter WP or LZ
_group = _this select 1; // group of men in chopper
_vehGroup = _this select 2; // group of chopper

// Find nearest enemies
_nearestEnemy = [(leader _group),500] call fnc_findNearestEnemy;
_enemyPos = _lzPos;
if !(isNull _nearestEnemy) then
{
    _enemyPos = getPosATL _nearestEnemy;
    //_enemyPos set [2, 0.0];
}
else
{
    _enemyPos = _lzPos; //getPos [300.0, random[0.0,180.0,360.0]];
    _enemyPos set [2, 0.0];
};


// Get out waypoint
_wpIndex = 0; // DON'T COMMENT OUT
//private _getOutPos = getPos _lzPos;
////_getOutPos = _getOutPos set [2, (_getOutPos select 2) + 100];
//_wpName = format ["%1_Get_Out", str _group];
//private _wp0 = _group addWaypoint [_getOutPos, 5.0, _wpIndex, _wpName];
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
private _wp1 = _group addWaypoint [_attackPos, 20.0, _wpIndex, _wpName]; // type array, expected group
_wp1 setWaypointCombatMode "RED";
_wp1 setWaypointBehaviour "AWARE";
_wp1 setWaypointSpeed "FULL";
_wp1 setWaypointType "SAD";
_wp1 setWaypointFormation "WEDGE";
_wp1 setWaypointTimeout [0, 0, 0];
_wp1 setWaypointCompletionRadius 5.0;

// Patrol waypoint
//private _patrolSuccess = [];
//private _success = [_group, _attackPos, 500.0] call BIS_fnc_taskPatrol;
//private _message = format ["%1 has completed their patrol",_group];
//_patrolSuccess pushBack [_success,_message,_group];

// Pick up waypoint
_wpIndex = _wpIndex + 1;
private _pickUpPos = _lzPos;
_pickUpPos set [2, 0.0];
_wpName = format ["%1_Pick_Up", str _group];
private _wp2 = _group addWaypoint [_pickUpPos, 30.0, _wpIndex, _wpName];
_wp2 setWaypointCombatMode "RED";
_wp2 setWaypointBehaviour "UNCHANGED";
_wp2 setWaypointSpeed "FULL";
_wp2 setWaypointType "MOVE";
_wp2 setWaypointFormation "WEDGE";
_wp2 setWaypointTimeout [0, 0, 0];
private _command = format ["groupsReadyForPickup = true;"];
_wp2 setWaypointStatements ["true",_command];
_wp2 setWaypointCompletionRadius 30.0;
    
    


