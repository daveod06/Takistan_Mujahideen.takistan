// give troops patrol waypoint to nearest threat, set to aware


//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_AirmobileGroupCheck =
{
    private _group = _this select 0;
    private _groupIsAlive = true;
    if (isNull _group) then
    {
        _groupIsAlive = false;
    };
    if ({ alive _x } count units _group == 0) then
    {
        _groupIsDead = false;
    };
    _groupIsAlive;
};

fnc_AirmobileVehicleCheck =
{
    private _veh = _this select 0;
    private _vehIsAlive = true;
    if (isNull _veh) then
    {
        _vehIsAlive = false;
    };
    
    _vehIsAlive;
};









fnc_AirmobileTroopDustoff = {
	private _lzOutput = _this select 0;
	private _spawnOutput = _this select 1;
	private _aliveGroups = _this select 2;
	private _lzHelipads = _lzOutput select 2;
	private _lzTrigger = _lzOutput select 4;
	private _spawnedAttackHelis = _spawnOutput select 0;
    private _spawnedTransportHelis = _spawnOutput select 1;
    private _spawnedTroopGroups = _spawnOutput select 2;
	
	private _numSpawnedAttackHelis = count _spawnedAttackHelis;
	private _t = _numSpawnedAttackHelis;
	private _h = 0;
	private _loadWpIndex = 3;
	private _vehArray = [];
	private _veh = objNull;
	
	{
	    _group = _x;
	    _vehArray = _spawnedTransportHelis select _t;
	    _vehName = _vehArray select 0;
	    _vehGroup  = _vehArray select 2;
	    
	    
	    // Assign helipad
        _lzHelipad = _lzHelipads select _t;
        
        
        // remove all old waypoints
        _group setCurrentWaypoint [_group, (count (waypoints _group) - 1)];
        while {(count (waypoints _group)) > 0} do
        {
            ((waypoints _group) select 0) setWPPos (getPos leader _group);
            sleep 0.1;
            deleteWaypoint ((waypoints _group) select 0);
        };
        
        // Get In waypoint
        private _GetInPos = getPos _lzHelipad;
        _wpName = format ["%1_Get_In", str _group];
        private _wp1 = _x addWaypoint [_GetInPos, 0.0, 0, _wpName];
        _wp1 setWaypointCombatMode "RED";
        _wp1 setWaypointBehaviour "AWARE";
        _wp1 setWaypointSpeed "FULL";
        _wp1 setWaypointType "GETIN";
        _wp1 setWaypointFormation "WEDGE";
        _wp1 setWaypointTimeout [0, 0, 0];
        
        _heliWaypoints = waypoints _vehGroup;
        _heliLoadWp = _heliWaypoints select _loadWpIndex;
        _wp1 waypointAttachVehicle _vehName;
        
        _smokeObj = "G_40mm_SmokeRed" createVehicle (getPos _lzHelipad);
        
	    _t = _t + 1;
	    _h = _h + 1;
	} forEach _aliveGroups;
	
	
	
	
	
	
	
	// Troops squads
	{
	    private _group = _x;
	    private _groupIsDead = false;
	    if (isNull _group) then
	    {
	        _groupIsDead = true;
	    };
	    if ({ alive _x } count units _group == 0) then
        {
            _groupIsDead = true;
        };
	    
	    if !(_groupIsDead) then
	    {
		    // Assign helipad
		    _lzHelipad = _lzHelipads select _t;
		    
		    // remove all old waypoints
		    while {(count (waypoints _group)) > 0} do
			{
			    ((waypoints _group) select 0) setWPPos (getPos leader _group);
			    sleep 0.1;
			    deleteWaypoint ((waypoints _group) select 0);
			};
		    
		    
            //private _command = format ["smokeObj = ""G_40mm_SmokeRed"" createVehicle (getPos _lzHelipad);",_veh,_speed_kph,_veh,_veh,_speed_mps];
            //_wp0 setWaypointStatements [true,_command];
            
	        
	        // Get In waypoint
            private _GetInPos = getPos _lzHelipad;
            _wpName = format ["%1_Get_In", str _group];
            private _wp1 = _x addWaypoint [_GetInPos, 0.0, 1, _wpName];
            _wp1 setWaypointCombatMode "RED";
            _wp1 setWaypointBehaviour "AWARE";
            _wp1 setWaypointSpeed "FULL";
            _wp1 setWaypointType "GETIN";
            _wp1 setWaypointFormation "WEDGE";
            _wp1 setWaypointTimeout [0, 0, 0];
            
        };
        
        _t = _t + 1;
        
	} forEach _spawnedTroopGroups;
	
	
	
};





// _this = [[_totalHelicoptersToSpawn,_baseHelipads,_lzHelipads,_baseTrigger,_lzTrigger],[_spawnedAttackHelis,_spawnedTransportHelis,_spawnedTroopGroups]];
if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    hint "Calling fnc_AirmobileTroopDustoff.";
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
