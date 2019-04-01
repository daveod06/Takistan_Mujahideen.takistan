params["_heli","_insertPos","_pos"];

private _extract = false;
//private _smokeSpawned = false;

while {alive _heli && !_extract} do {
	private _state = _heli getvariable ["State","Unknown"];
	switch (_state) do {
		case "Init": { 
			systemchat "Init Heli";
			_heli setvariable ["State","Approach"];
			private _waypoint = (group _heli) addWaypoint [_insertPos, 30];
			_waypoint setWaypointSpeed "FULL";
			_waypoint setWaypointBehaviour "CARELESS";
			_waypoint setWaypointFormation "WEDGE";
            _waypoint setWaypointType "TR UNLOAD"; // might be needed to kick out loaded cargo troops
            //_waypoint setWaypointStatements ["true", "(vehicle this) setvariable [""State"",""Land""];"];
            _waypoint setWaypointStatements ["true", "(vehicle this) setvariable [""State"",""Evac""];"];
            _waypoint setWaypointTimeout [1.5, 2, 3];

            //_wp = _cargoGroup addWaypoint [_insertPos, 5.0];
            //_wp setWaypointType "GETOUT";
            //_waypoint synchronizeWaypoint [_wp];
			////_waypoint setWaypointStatements ["true", "(vehicle this) setvariable [""State"",""Land""];"]; // FIXME may be unecessary
            //[_cargoGroup, _insertPos, 500] call bis_fnc_taskPatrol;
		};
		case "Approach": { 
			systemchat "Approaching";
            if(_heli distance _insertPos < 800) then {
            	//if (!_smokeSpawned) then
            	//{
			    //	_smoke1 = (selectRandom Tooth_LZ_Smoke) createVehicle _insertPos;
			    //	_smokeSpawned = true;
			    //};
            };
			if(_heli distance _insertPos < 300) then {
				_heli setSpeedMode "NORMAL";
				_heli flyinheight 30;
			};
			if(_heli distance _insertPos < 60) then {
				_heli setSpeedMode "LIMITED";
				_heli flyinheight 20;
			};
		};
		case "Land": { 
			systemchat "Landing";
			_heli land "LAND";
            //_wp = _cargoGroup addWaypoint [_insertPos, 5.0];
            //_wp setWaypointType "GETOUT";
			sleep 10;
			if(_heli getvariable ["State","Unknown"] != "Evac") then {
				_heli setvariable ["State","WaitForPlayers"];
			};
		};
		case "WaitForPlayers": {
			systemchat "Waiting";
			if(!isTouchingGround _heli) then {
				if(_heli getvariable ["State","Unknown"] != "Evac") then {
					_heli setvariable ["State","Land"];
				};
			}
            else
            {
            	_cargoGroup = grpNull;
            	_cargoGroup = (crew _heli) select {(assignedVehicleRole _x) select 0 isEqualTo "cargo"};
                {
                    doGetOut _x;
                    _x leaveVehicle _heli;
                    _x enableAI "FSM";
                    unassignVehicle _x;
                } forEach _cargoGroup;
            };
		};
		case "Evac": { 
			systemchat "Extracting";
			sleep (random 4 + 1);
			_heli land "NONE";
			_heli setSpeedMode "FULL";
			private _waypoint = (group _heli) addWaypoint [_pos, 0];
			_waypoint setWaypointSpeed "FULL";
			_waypoint setWaypointBehaviour "CARELESS";
			_waypoint setWaypointFormation "WEDGE";
            private _despawnCommand = format ["{{deleteVehicle _x} forEach crew %1} forEach thisList; deleteVehicle %2;",_heli,_heli];
			_waypoint setWaypointStatements ["true", _despawnCommand];
			_extract = true;
		};
		default { };
	};
	sleep 2;
};
