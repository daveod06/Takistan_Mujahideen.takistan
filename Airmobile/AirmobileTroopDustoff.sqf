// give troops patrol waypoint to nearest threat, set to aware


//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_vehicleOk =
{
	private ["_vehicleName","_vehicleOk"];

	_vehicleName = _this select 0;
	_vehicleOk = false;
	if (!(isNull _vehicleName)) then
	{
		if (alive _vehicleName) then
		{
		    _vehicleOk = true;
		};
	};
	_vehicleOk
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
        _groupIsAlive = false;
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

//fnc_AirmobileTroopDustoff = {
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
private _loadWpIndex = -1;
private _vehArray = [];
private _veh = objNull;
_checkHeliWaypoints = true;

while {_checkHeliWaypoints} do
{
    _vehArray = _spawnedTransportHelis select _t;
    _vehName = _vehArray select 0;
    _vehGroup  = _vehArray select 2;
    _wpIndex = currentWaypoint _vehGroup;
    if (_wpIndex >= 0) then
    {
        _wpName = waypointName [_vehGroup,_wpIndex];
        _wpPos = waypointPosition [_vehGroup, _wpIndex];
        _distToWp = _veh distance _wpPos;
    }
    else
    {
        _wpName = "";
        _wpPos = [0,0,0];
        _distToWp = 100000.0;
    };

    if ((_wpName find "LZ_Load") >= 0) then
    {
        _loadWpIndex = _wpIndex;
        _checkHeliWaypoints = false;
    };

    sleep 3.0;
};


waitUntil {_checkHeliWaypoints == false};
//{
    {
        _group = _x;
        _vehArray = _spawnedTransportHelis select _t;
        _vehName = _vehArray select 0;
        _vehGroup  = _vehArray select 2;

        _vehOk = [_vehName] call fnc_vehicleOk;
        _vehGroupOk = [_vehGroup] call fnc_groupOk;
        _groupOk = [_group] call fnc_groupOk;

        if (_vehOk && _vehGroupOk && _groupOk) then
        {
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
            private _getInPos = getPos _lzHelipad;
            _wpName = format ["%1_Get_In", str _group];
            private _wp1 = _x addWaypoint [_getInPos, 0.0, 0, _wpName];
            _wp1 setWaypointCombatMode "RED";
            _wp1 setWaypointBehaviour "AWARE";
            _wp1 setWaypointSpeed "FULL";
            _wp1 setWaypointType "GETIN";
            _wp1 setWaypointFormation "WEDGE";
            _wp1 setWaypointTimeout [0, 0, 0];
            
            _heliWaypoints = waypoints _vehGroup;
            _heliLoadWp = _heliWaypoints select _loadWpIndex;
            _wp1 waypointAttachVehicle _vehName;
            _wp1 synchronizeWaypoint [_heliLoadWp];
            
            //private _smokeClasses = ["G_40mm_SmokeRed","G_40mm_SmokeBlue","G_40mm_Smoke","G_40mm_SmokeGreen","G_40mm_SmokeYellow","G_40mm_SmokePurple","G_40mm_SmokeOrange"];
            private _smokeClasses = ["G_40mm_SmokeOrange"];
            _smokeObj = (selectRandom _smokeClasses) createVehicle (getPos _lzHelipad);

            (units _group) allowGetIn true;
            (units _group) assignAsCargo _vehName;
            (units _group) orderGetIn true;
            
            _t = _t + 1;
            _h = _h + 1;
            sleep 1.0;
        };
    } forEach _aliveGroups;
//};
//};

// _this = [[_totalHelicoptersToSpawn,_baseHelipads,_lzHelipads,_baseTrigger,_lzTrigger],[_spawnedAttackHelis,_spawnedTransportHelis,_spawnedTroopGroups]];
//if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
//{
//    hint "Calling fnc_AirmobileTroopDustoff.";
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
