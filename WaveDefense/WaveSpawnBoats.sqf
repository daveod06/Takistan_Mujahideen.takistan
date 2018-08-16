
_side = _this select 0;
_faction = _this select 1;
_vehType = _this select 2;
_spawnMarker = _this select 3;
_attackMarker = _this select 4;
_waveNum = _this select 5;
_vehNum = _this select 6;

_vehName = (str _vehType) + "_WAVE_" + (str _waveNum) + "_BOAT_" + (str _vehNum);

_markerPos = getMarkerPos _spawnMarker;
_spawnPos = _markerPos getPos [(random [0,50,100]), (random [0,180,360])];
_spawnPos = [_spawnPos, 1.0, 400.0, 10.0, 2, 1.0, 0] call BIS_fnc_findSafePos;

// Get distance and direction towards attack point
private _spawnToAttackBearing = (getMarkerPos _spawnMarker) getDir (getMarkerPos _attackMarker);
private _AttackToSpawnBearing = (getMarkerPos _attackMarker) getDir (getMarkerPos _spawnMarker);
private _attackDistance = (getMarkerPos _spawnMarker) distance2D (getMarkerPos _attackMarker);
_spawnDir = _spawnToAttackBearing;

_vehArray = [_spawnPos, _spawnDir, _vehType, _side] call bis_fnc_spawnvehicle;
_veh 	= _vehArray select 0;
_vehCrew 	= _vehArray select 1;
_group 	= _vehArray select 2;

_group deleteGroupWhenEmpty true;
_group setGroupId [_vehName];
_group setCombatMode "RED";
_group setFormation "WEDGE";
_group setBehaviour "AWARE";
_group setSpeedMode "FULL";

_skills = server getvariable "WaveVEHskill";
_skills = WaveVEHskill;

[_group,_skills] call Saber_fnc_WaveSetSkill;
_veh setVehicleLock "UNLOCKED";

//_deadTracker = _vehName + "_DEAD";
//server setvariable [_deadTracker,0];
//// "INF_WAVE_0_SQUAD_0_DEAD";
//
//{
//    _x addEventHandler ["killed", 
//    {
//        _grp = group (_this select 0);
//    	if ({ alive _x } count units _grp < 1) then
//    	{
//    	    hint "All units dead";
//    	    server setvariable [_deadTracker,1];
//    	};
//    }
//    ];
//} forEach units _group;


//_message = format ["Spawned vehicle: %1",_veh];
//if Saber_DEBUG then {hint _message; sleep 1.0;};

sleep 1.0;

_vehArray
