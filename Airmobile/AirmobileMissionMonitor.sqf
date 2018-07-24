//private _kph_to_mps = 0.277778;

//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

private _spawnHeliOutput = _this select 0;
private _spawnedAttackHelis = _spawnHeliOutput select 0;
private _spawnedTransportHelis = _spawnHeliOutput select 1;

private _checkHelis = true;
//private _aVeh = objNull;
//private _aGroup = objNull;
//private _tVeh = objNull;

// Enable collisions
while {_checkHelis} do
{
    {
	    _veh   = _x select 0;
        _vehGroup = _x select 2;

        // lock cargo when far away from unload waypoint or when far from the ground
        if (([_vehGroup] call Saber_fnc_groupOk) && ([_veh] call Saber_fnc_vehicleOk)) then
        {

            // calculate lock conditions
            _wpIndex = currentWaypoint _vehGroup;
            _wpName = waypointName [_vehGroup,_wpIndex];
            _wpPos = waypointPosition [_vehGroup, _wpIndex];
            if ((_wpName find "_LZ_LAND") >= 0) then {_
                _distToWp = _veh distance _wpPos;
            }
            else
            {
                _distToWp = 1000.0;
            };
            _vehAltAGL =  (getPos _veh) select 2;
            
            // set lock
            if ((_distToWp < 5.0 ) or (_vehAltAGL < 3.0)) then
            {
                _veh lockCargo false;
            }
            else
            {
                _veh lockCargo true;
            };
        };

        // if helicopter damaged or crew killed, land
        if (([_vehGroup] call Saber_fnc_groupOk) && ([_veh] call Saber_fnc_vehicleOk)) then
        {
            // check if heli damaged
            if !(canMove _veh) then
            {
                // remove all waypoints
                _vehGroup setCurrentWaypoint [_vehGroup, (count (waypoints _vehGroup) - 1)];
                sleep 0.5;
                if (count waypoints _vehGroup > 0) then
                {
                    {
                        deleteWaypoint( (waypoints _vehGroup) select 0);
                    } forEach waypoints _vehGroup;
                };
                sleep 1.0;

                // make helicopter land
                _veh move (getPos _veh);
                sleep 3.0;
                while {((alive _veh) && !(unitReady _veh)) } do
                {
                    sleep 1.0;
                };
                if (alive _veh) then
                {
                    _veh land "LAND";
                };
                while {((alive _veh) && !(unitReady _veh)) } do
                {
                    sleep 1.0;
                };
                {
                    doGetOut _x;
                    _x leaveVehicle _veh;
                } forEach (fullCrew vehicle);

            };
        };

        // disable collisions
        {
            _aVeh   = _x select 0;
            _aVehGroup = _x select 2;
            if (([_aVeh] call Saber_fnc_vehicleOk) && ([_veh] call Saber_fnc_vehicleOk)) then
            {
                _aVeh disableCollisionWith _veh;
	            _veh disableCollisionWith _aVeh;
            };
	    } forEach _spawnedAttackHelis;
        
	} forEach _spawnedTransportHelis;

	sleep 5.0;
};
