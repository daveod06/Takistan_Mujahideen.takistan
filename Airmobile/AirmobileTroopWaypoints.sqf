// give troops patrol waypoint to nearest threat, set to aware


//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_AirmobileTroopWaypoints = {
	private _lzOutput = _this select 0;
	private _spawnOutput = _this select 1;
	private _lzHelipads = _lzOutput select 2;
	private _lzTrigger = _lzOutput select 4;
	private _spawnedAttackHelis = _spawnOutput select 0;
    private _spawnedTransportHelis = _spawnOutput select 1;
    private _spawnedTroopGroups = _spawnOutput select 2;
	
	
	private _numSpawnedAttackHelis = count _spawnedAttackHelis;
	private _t = _numSpawnedAttackHelis;
	
	// Troops squads
	{
	    // Assign helipad
	    _lzHelipad = _lzHelipads select _t;
	    
	    // Find nearest enemies
	    private _enemyPos = _lzHelipad findNearestEnemy (getPos _lzHelipad);
	    if (isNull _enemyPos) then
	    {
	        _enemyPos = _lzHelipad getPos [500.0, random[0.0,180.0,360.0]];
	    };
	    
	    // Get out waypoint
        private _getOutPos = getPos _lzHelipad;
        _getOutPos = _getOutPos set [2, (_getOutPos select 2) + 100];
        _wpName = format ["%1_Get_Out", str _group];
        private _wp0 = _x addWaypoint [_getOutPos, 5.0, 0, _wpName];
        _wp0 setWaypointCombatMode "RED";
        _wp0 setWaypointBehaviour "AWARE";
        _wp0 setWaypointSpeed "FULL";
        _wp0 setWaypointType "GETOUT";
        _wp0 setWaypointFormation "WEDGE";
        _wp0 setWaypointTimeout [0, 0, 0];
        
        // Attack waypoint
        private _attackPos = getPos _enemyPos;
        _wpName = format ["%1_SAD", str _group];
        private _wp1 = _x addWaypoint [_attackPos, 20.0, 1, _wpName];
        _wp1 setWaypointCombatMode "RED";
        _wp1 setWaypointBehaviour "AWARE";
        _wp1 setWaypointSpeed "FULL";
        _wp1 setWaypointType "SAD";
        _wp1 setWaypointFormation "WEDGE";
        _wp1 setWaypointTimeout [0, 0, 0];
        
        // Patrol waypoint
        private _patrolSuccess = [];
        private _success = [_x, _attackPos, 500.0] call BIS_fnc_taskPatrol;
        private _message = format ["%1 has completed their patrol",_x];
        _patrolSuccess pushBack [_success,_message,_x];
        
        // Pick up waypoint
        private _PickUpPos = getPos _lzHelipad;
        _wpName = format ["%1_Pick_Up", str _group];
        private _wp2 = _x addWaypoint [_PickUpPos, 30.0, 2, _wpName];
        _wp2 setWaypointCombatMode "RED";
        _wp2 setWaypointBehaviour "AWARE";
        _wp2 setWaypointSpeed "FULL";
        _wp2 setWaypointType "MOVE";
        _wp2 setWaypointFormation "WEDGE";
        _wp2 setWaypointTimeout [0, 0, 0];
        private _command = format ["groupsReadyForPickup = true;"];
        _wp2 setWaypointStatements [true,_command];
        
        _t = _t + 1;
        
	} forEach _spawnedTroopGroups;
	
	private _patrolLoop = true;
	while {_patrolLoop} do
	{
	    sleep 3.0;
	    {
	        if (_x select 0) then
	        {
	            hint (_x select 1);
	            _group = (_x select 2);
                private _groupIsDead = false;
                if (isNull _group) then
                {
                    _groupIsDead = true;
                };
                if ({ alive _x } count units _group == 0) then
                {
                    _groupIsDead = true;
                };
	            
	            if (!_groupIsDead) then
	            {
		            {
		                _x setCurrentWaypoint [_x, (count (waypoints _x) - 1)];
		            } forEach _spawnedTroopGroups;
		            _patrolLoop = false;
	            };  
	            
	        };
	    } forEach _patrolSuccess;
	};

    while {true} do
    {
        sleep 3.0;
        if (groupsReadyForPickup) then
        {
            {
                _group = _x;
                _groupIsDead = false;
                if (isNull _group) then
                {
                    _groupIsDead = true;
                };
                if ({ alive _x } count units _group == 0) then
                {
                    _groupIsDead = true;
                };
                
                if (!_groupIsDead) then
                {
                    //private _smokeObj = "G_40mm_SmokeRed" createVehicle (getPos _lzHelipad);
                    // call heli dustoff spawn
                    sleep 1.0;
                    // call troop dustoff waypoint
                };
                
                
            } forEach _spawnedTroopGroups;
        };
    };

};





// _this = [[_totalHelicoptersToSpawn,_baseHelipads,_lzHelipads,_baseTrigger,_lzTrigger],[_spawnedAttackHelis,_spawnedTransportHelis,_spawnedTroopGroups]];
if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    hint "Calling fnc_AirmobileTroopWaypoints.";
    sleep 1.0;
    _output = [_this] call fnc_AirmobileTroopWaypoints;
}
else
{
    if(isServer) then
    {
        hint "Calling fnc_AirmobileTroopWaypoints.";
        sleep 1.0;
        _output = [_this] call fnc_AirmobileTroopWaypoints;
    };
};
