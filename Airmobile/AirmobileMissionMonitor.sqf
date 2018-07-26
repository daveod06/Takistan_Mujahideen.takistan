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
private _groupLanded = [false,false,false];
private _t = 0;
private _lzLandPos = [0,0,0];

// Enable collisions
while {_checkHelis} do
{
	_t = 0;
    {
	    _veh   = _x select 0;
        _vehGroup = _x select 2;

		_message = format ["_veh: %1, _vehGroup: %2 _veh type: %3",_veh,_vehGroup,typeOf _veh];
		if Saber_DEBUG then {hint _message; sleep 3.0;};
		//_message = format ["OKs: %1 ",[_veh] call Saber_fnc_vehicleOk]; // FIXME ERRORS HERE
		//if Saber_DEBUG then {hint _message; sleep 3.0;};
		//_message = format ["OKs: %1 ",[_vehGroup] call Saber_fnc_groupOk];
		//if Saber_DEBUG then {hint _message; sleep 3.0;};

        // lock cargo when far away from unload waypoint or when far from the ground
        //if (([_vehGroup] call Saber_fnc_groupOk) && ([_veh] call Saber_fnc_vehicleOk)) then
        _distToWp = 1000.0;
        if (true) then
        {

            // calculate lock conditions
            _wpIndex = currentWaypoint _vehGroup;
            _wpName = waypointName [_vehGroup,_wpIndex];
            _wpPos = waypointPosition [_vehGroup, _wpIndex];
            //_cargo = fullCrew [_veh, "cargo"];
            //_unitArray = _cargo select 0;
            //if (count _unitArray > 0) then
            //{
            //	_group = group (_unitArray select 0);
            //};
            
            _message = format ["_wpIndex: %1, _wpName: %2 _veh _wpPos: %3 _wpName find: %4",_wpIndex,_wpName,_wpPos,_wpName find "_LZ_LAND"];
			if Saber_DEBUG then {hint _message; sleep 1.0;};
            
            if ((_wpName find "_LZ_LAND") >= 0) then {
                _distToWp = _veh distance _wpPos;
                _lzLandPos = _wpPos;
                
			    private _vehCargo = fullCrew [_veh,"cargo", false];
			    private _cargoUnit = _vehCargo select 0;
			    private _transportSquad = group (_cargoUnit select 0);
			    
			    _message = format ["_distToWp: %1, _vehCargo: %2 _cargoUnit: %3 _transportSquad: %4",_distToWp,_vehCargo,_cargoUnit,_transportSquad];
				if Saber_DEBUG then {hint _message; sleep 1.0;};
                
                //[_wpPos,_transportSquad,_vehGroup] call Saber_fnc_AirmobileSingleTroopWaypoints;
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
                _cargo = fullCrew [_veh, "cargo"];
                if (count _cargo > 0) then
                {
                    _unitArray = _cargo select 0;
                    _group = group (_unitArray select 0);
                    _group setCombatMode "RED";
                    _group setFormation "WEDGE";
                    _group setBehaviour "AWARE";
                    _group setSpeedMode "FULL";
                    [(getPosATL _veh),_group,_vehGroup] call Saber_fnc_AirmobileSingleTroopWaypoints;
                };
            }
            else
            {
                _veh lockCargo true;
            };
        };

        // if helicopter damaged or crew killed, land
        //if (([_vehGroup] call Saber_fnc_groupOk) and ([_veh] call Saber_fnc_vehicleOk)) then
        if (false) then
        {
            // check if heli damaged
            if !(canMove _veh) then
            {
            	_message = format ["vehicle %1 is damaged, proceeding to last WP",_veh];
				if Saber_DEBUG then {hint _message; sleep 3.0;};
            
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
                while {((alive _veh) and !(unitReady _veh)) } do
                {
                    sleep 1.0;
                };
                if (alive _veh) then
                {
                    _veh land "LAND";
                };
                while {((alive _veh) and !(unitReady _veh)) } do
                {
                    sleep 1.0;
                };
                {
                    doGetOut _x;
                    _x leaveVehicle _veh;
                } forEach (fullCrew _veh);

            };
        };

        // disable collisions
        {
            _aVeh   = _x select 0;
            _aVehGroup = _x select 2;
            //if (([_aVeh] call Saber_fnc_vehicleOk) and ([_veh] call Saber_fnc_vehicleOk)) then
            if (true) then
            {
                _aVeh disableCollisionWith _veh;
	            _veh disableCollisionWith _aVeh;
            };
            {
            	_bVeh = _x select 0;
            	_aVeh disableCollisionWith _bVeh;
            	
            } forEach _spawnedAttackHelis;
	    } forEach _spawnedAttackHelis;
	    {
            _bVeh   = _x select 0;
            //if (([_bVeh] call Saber_fnc_vehicleOk) and ([_veh] call Saber_fnc_vehicleOk)) then
            if (true) then
            {
            	_bVeh = _x select 0;
	            _veh disableCollisionWith _bVeh;
            };
	    } forEach _spawnedTransportHelis;
        
    	_t = _t + 1;
	} forEach _spawnedTransportHelis;

	sleep 5.0;
};
