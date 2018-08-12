// give helicopters take off waypoints???\
// create get out waypoint for troops at LZ, set to careless
// give helicopters a move waypoint 1km out from LZ
// slow down helicopters and limit speed, lower alt, set behavior
// make intermediate waypoint, slow and lower more
// transport unload waypoint
// sleep for a few seconds
// give helicopters limited alt and speed to get away from LZ
// send helicopters back to takeoff points
// delete helicopters


// move waypoint 500m towards LZ (CARELESS, FAST)
// move waypoint 450m from LZ (CARELESS, FAST) "this limitSpeed 160; this flyInHeight 25; this forceSpeed 160*_kph_to_mps;"
// move waypoint 160m from LZ (CARELESS, LIMITED) "this limitSpeed 50; this flyInHeight 25; this forceSpeed 50*_kph_to_mps;"
// transport_unload waypoint at LZ (CARELESS, FAST) "this LAND "land"; this limitSpeed 50; this flyInHeight 25; this forceSpeed 50*_kph_to_mps;" // wait for 3 sec after waypoint done
// To use the LAND function in a waypoint, you must set "A3\functions_f\waypoints\fn_wpLand.sqf" as the script for that waypoint.
// move waypoint 200m from LZ (CARELESS, FAST)
// move waypoint 1km from LZ (CARELESS, FAST)

//private _kph_to_mps = 0.277778;

//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

//fnc_AirmobileHeliWaypoints = {
private _lzInitOutput = _this select 0;
private _spawnHeliOutput = _this select 1;
//private _spawnTroopOutput = _this select 2;
private _baseHelipads = _lzInitOutput select 1;
private _lzHelipads = _lzInitOutput select 2;
private _baseTrigger = _lzInitOutput select 3;
private _lzTrigger = _lzInitOutput select 4;
private _spawnedAttackHelis = _spawnHeliOutput select 0;
private _spawnedTransportHelis = _spawnHeliOutput select 1;
//
//private _spawnedTroopGroups = _spawnTroopOutput select 0;
private _kph_to_mps = 0.277778;

// Get distance and direction towards LZ
private _baseToLzBearing = (_baseHelipads select 0) getDir (_lzHelipads select 0);
private _lzToBaseBearing = (_lzHelipads select 0) getDir (_baseHelipads select 0);
private _lzDistance = (_baseHelipads select 0) distance2D (_lzHelipads select 0);
private _takeoffPos = [0,0,0];

// Attack helicopters
private _numAttackHelis = count (_spawnedAttackHelis);
private _a = 0;
{
    //_vehName  = _vehArray select 0;
    //_vehCrew  = _vehArray select 1;
    //_vehGroup     = _vehArray select 2;
    private _group = _x select 2;
    private _veh = _x select 0;
    
    // Assign helipads
    private _spawnHelipad = _baseHelipads select _a;
    private _lzHelipad = _lzHelipads select _a;
    
    // Takeoff waypoint
    _wpIndex = 1; // DON'T COMMENT OUT
    if (_lzDistance < 500.0) then
    {
        _takeoffPos = _spawnHelipad getPos [500.0, _baseToLzBearing];
    }
    else
    {
        _takeoffPos = _spawnHelipad getPos [500.0, _lzToBaseBearing];
    };
    //_takeoffPos = _takeoffPos set [2, (_takeoffPos select 2) + 200];
    private _wpName = format ["%1_Takeoff", _veh];
    private _wp0 = _group addWaypoint [_takeoffPos, 0.0, _wpIndex, _wpName];
    _wp0 setWaypointCombatMode "RED";
    _wp0 setWaypointBehaviour "AWARE";
    _wp0 setWaypointSpeed "FULL";
    _wp0 setWaypointType "MOVE";
    _wp0 setWaypointTimeout [0, 0, 0];
    //_command0 = format ["%1 flyInHeight 200; ",_veh];
    
    
    // Intermediate waypoint
    _wpIndex = _wpIndex + 1;
    private _intermediatePos = _spawnHelipad getPos [450.0, _lzToBaseBearing];
    //_intermediatePos = _intermediatePos set [2, (_intermediatePos select 2) + 100];
    _wpName = format ["%1_Intermediate", _veh];
    private _wp1 = _group addWaypoint [_intermediatePos, 0.0, _wpIndex, _wpName];
    _wp1 setWaypointCombatMode "RED";
    _wp1 setWaypointBehaviour "UNCHANGED";
    _wp1 setWaypointSpeed "UNCHANGED";
    _wp1 setWaypointType "MOVE";
    _wp1 setWaypointTimeout [0, 0, 0];
    
    // Patrol waypoint
    _wpIndex = _wpIndex + 1;
    private _lzPatrolPos = getPos _lzHelipad;
    //_lzPatrolPos = _lzPatrolPos set [2, (_lzPatrolPos select 2) + 100];
    _wpName = format ["%1_LZ_SAD", _veh];
    private _wp2 = _group addWaypoint [_lzPatrolPos, 0.0, _wpIndex, _wpName];
    _wp2 setWaypointCombatMode "RED";
    _wp2 setWaypointBehaviour "UNCHANGED";
    _wp2 setWaypointSpeed "UNCHANGED";
    _wp2 setWaypointType "SAD";
    _wp2 setWaypointTimeout [10, 12, 20];
    
    // Loiter waypoint
    _wpIndex = _wpIndex + 1;
    private _lzLoiterPos = getPos _lzHelipad;
    //_lzLoiterPos = _lzLoiterPos set [2, (_lzPatrolPos select 2) + 100];
    _wpName = format ["%1_LZ_Loiter", _veh];
    private _wp3 = _group addWaypoint [_lzLoiterPos, 0.0, _wpIndex, _wpName];
    _wp3 setWaypointCombatMode "RED";
    _wp3 setWaypointBehaviour "UNCHANGED";
    _wp3 setWaypointSpeed "UNCHANGED";
    _wp3 setWaypointType "LOITER";
    _wp3 setWaypointLoiterRadius 400;
    _wp3 setWaypointLoiterType "CIRCLE";
    _wp3 setWaypointTimeout [30, 45, 60];
    
    // Egress waypoint
    _wpIndex = _wpIndex + 1;
    private _lzEgressPos = _takeoffPos;
    _wpName = format ["%1_LZ_Egress", _veh];
    private _wp4 = _group addWaypoint [_lzEgressPos, 0.0, _wpIndex, _wpName];
    _wp4 setWaypointCombatMode "RED";
    _wp4 setWaypointBehaviour "UNCHANGED";
    _wp4 setWaypointSpeed "UNCHANGED";
    _wp4 setWaypointType "MOVE";
    _wp4 setWaypointTimeout [0, 0, 0];
    
    // Final waypoint
    _wpIndex = _wpIndex + 1;
    _finalPos = getPos _spawnHelipad;
    //_finalPos = _finalPos set [2, (_finalPos select 2) + 100];
    private _wpName = format ["%1_Final", _veh];
    //private _despawnCommand = format ["{{deleteVehicle _x} forEach crew %1} forEach thisList; deleteVehicle %2;",_veh,_veh];
    private _wp5 = _group addWaypoint [_finalPos, 0.0, _wpIndex, _wpName];
    _wp5 setWaypointCombatMode "RED";
    _wp5 setWaypointBehaviour "CARELESS";
    _wp5 setWaypointSpeed "LIMITED";
    _wp5 setWaypointType "MOVE";
    _wp5 setWaypointTimeout [0, 0, 0];
    //_wp5 setWaypointStatements ["true",_despawnCommand];
    
    _a = _a + 1;
    sleep 10.0;
    
} forEach _spawnedAttackHelis;


// Transport helicopters
transportUnloadArray = [];
private _numTransportHelis = count (_spawnedTransportHelis);
private _t = _a;
{
    //_vehName  = _vehArray select 0;
    //_vehCrew  = _vehArray select 1;
    //_vehGroup     = _vehArray select 2;
    private _group = _x select 2;
    private _veh = _x select 0;
    //private _vehCargo = fullCrew [_veh,"cargo", false];
    //private _cargoUnit = _vehCargo select 0;
    //private _cargoUnit = _cargoUnit select 0;
    //private _transportSquad = group (_cargoUnit select 0);
    
    //_message = format ["_group: %1, _veh: %2, _vehCargo: %3, _cargoUnit: %4, _transportSquad: %5",_group,_veh,_vehCargo,_cargoUnit,_transportSquad];
	//if Saber_DEBUG then {hint _message; sleep 1.0;};

    // Assign helipads
    private _spawnHelipad = _baseHelipads select _t;
    private _lzHelipad = _lzHelipads select _t;
    
    // Takeoff waypoint
    _wpIndex = 1; // DON'T COMMENT OUT
    if (_lzDistance < 500.0) then
    {
        _takeoffPos = _spawnHelipad getPos [500.0, _baseToLzBearing];
    }
    else
    {
        _takeoffPos = _spawnHelipad getPos [500.0, _lzToBaseBearing];
    };
    //_takeoffPos = _takeoffPos set [2, (_takeoffPos select 2) + 200];
    private _wpName = format ["%1_Takeoff", _veh];
    private _wp0 = _group addWaypoint [_takeoffPos, 0.0, _wpIndex, _wpName];
    _wp0 setWaypointCombatMode "NO CHANGE"; // "RED"
    _wp0 setWaypointBehaviour "CARELESS"; // "UNCHANGED"
    _wp0 setWaypointSpeed "FULL";
    _wp0 setWaypointType "MOVE";
    //_wp0 setWaypointTimeout [0, 0, 0];
    
    // Intermediate waypoint
    //_wpIndex = _wpIndex + 1;
    //private _intermediatePos = _spawnHelipad getPos [450.0, _lzToBaseBearing];
    ////_intermediatePos = _intermediatePos set [2, (_intermediatePos select 2) + 100];
    //_wpName = format ["%1_Intermediate", _veh];
    //private _speed_kph = 160;
    //private _speed_mps = _speed_kph * _kph_to_mps;
    //private _command = format ["%1 limitSpeed %2; %3 flyInHeight 25; %4 forceSpeed %5;",_veh,_speed_kph,_veh,_veh,_speed_mps];
    //private _wp1 = _group addWaypoint [_intermediatePos, 0.0, _wpIndex, _wpName];
    //_wp1 setWaypointCombatMode "NO CHANGE";
    //_wp1 setWaypointBehaviour "UNCHANGED";
    //_wp1 setWaypointSpeed "FULL";
    //_wp1 setWaypointType "MOVE";
    //_wp1 setWaypointTimeout [0, 0, 0];
    //_wp1 setWaypointStatements ["true",_command];
    
    // Approach waypoint
    _wpIndex = _wpIndex + 1;
    private _lzApproachPos = _lzHelipad getPos [160.0 + _t * 150.0, _lzToBaseBearing + _t*2.5];
    //_lzApproachPos = _lzApproachPos set [2, (_lzApproachPos select 2) + 50];
    _wpName = format ["%1_LZ_Approach", _veh];
    _speed_kph = 50;
    _speed_mps = _speed_kph * _kph_to_mps;
    //_command = format ["%1 limitSpeed %2; %3 flyInHeight 25; %4 forceSpeed %5;",_veh,_speed_kph,_veh,_veh,_speed_mps];
    //if (_t - _a) > 0 then
    //{
    //    _condition = format ["transportUnloadArray select %1",(_t - _a)-1];
    //    _command = format ["hint ""%1 is ready to unload"";",_veh];
    //    _wp2 setWaypointStatements [_condition,_command];
    //}
    private _wp2 = _group addWaypoint [_lzApproachPos, 0.0, _wpIndex, _wpName];
    _wp2 setWaypointCombatMode "NO CHANGE";
    _wp2 setWaypointBehaviour "UNCHANGED";
    _wp2 setWaypointSpeed "FULL";
    _wp2 setWaypointType "MOVE";
    _wp2 setWaypointTimeout [_t*10.0, _t*10.0, _t*10.0];
    _wp2 setWaypointCompletionRadius 50.0;
    //_wp2 setWaypointStatements ["true",_command];

    
    // Transport Unload waypoint
    _var = str _veh + "_UNLOAD_COMPLETE";
    server setvariable [_var,false];
    transportUnloadArray pushBack _var;
    _wpIndex = _wpIndex + 1;
    private _lzLandPos = getPos _lzHelipad;
    //_lzLandPos = _lzLandPos set [2, (_lzLandPos select 2) + 50];
    _wpName = format ["%1_LZ_Land", _veh];
    _speed_kph = 50;
    _speed_mps = _speed_kph * _kph_to_mps;
    //_command = format ["%1 limitSpeed %2; %3 flyInHeight 25; %4 forceSpeed %5; %6 land ""GET OUT"";",_veh,_speed_kph,_veh,_veh,_speed_mps,_veh]; // FIXME TEST
    //_command = format ["%1 land ""GET OUT""; server setVariable [%2,true];",_veh,_var]; // FIXME TEST
    //private _script = format ["[%1,%2,%3] call Saber_fnc_AirmobileSingleTroopWaypoints",_lzLandPos,_transportSquad,_group]; 
    private _wp3 = _group addWaypoint [_lzLandPos, 0.0, _wpIndex, _wpName];
    _wp3 setWaypointCombatMode "NO CHANGE"; //NO CHANGE
    _wp3 setWaypointBehaviour "UNCHANGED"; //UNCHANGED
    _wp3 setWaypointSpeed "FULL";
    _wp3 setWaypointType "TR UNLOAD";
    _wp3 setWaypointTimeout [5, 6, 9];
    //_wp3 setWaypointStatements ["true",_command];
    //_wp3 setWaypointScript _script;
    _wp3 waypointAttachVehicle _lzHelipad;
    //_wp3 setWaypointCompletionRadius 2.0;
    
    // Post Unload waypoint
    _wpIndex = _wpIndex + 1;
    private _postPos = _lzLandPos getPos [700.0, _baseToLzBearing + 45.0]; // _lzToBaseBearing _baseToLzBearing  origin getPos [distance, heading]
    ////_postPos = _postPos set [2, (_postPos select 2) + 100];
    _wpName = format ["%1_LZ_Post_Unload", _veh];
    private _wp4 = _group addWaypoint [_postPos, 0.0, _wpIndex, _wpName];
    _speed_kph = 250;
    _wp4 setWaypointCombatMode "NO CHANGE";
    _wp4 setWaypointBehaviour "CARELESS";
    _wp4 setWaypointSpeed "FULL";
    _wp4 setWaypointType "MOVE";
    _wp4 setWaypointTimeout [0, 0, 0];
    //_command0 = format ["%1 limitSpeed %2; %3 flyInHeight 200; %4 forceSpeed %5; ",_veh,_speed_kph,_veh,_veh,_speed_mps];
    //_command0 = format ["%1 flyInHeight 200; ",_veh];
    _command0 = "";
    _command1 = '{(commander _veh) enableAI _x} forEach ["TARGET","AUTOTARGET","FSM","AUTOCOMBAT"];{(driver _veh) enableAI _x} forEach ["TARGET","AUTOTARGET","FSM","AUTOCOMBAT"];';
    _wp4 setWaypointStatements ["true",_command1+_command0];

    //// Egress waypoint
    //_wpIndex = _wpIndex + 1;
    //private _lzEgressPos = _takeoffPos;
    //_wpName = format ["%1_LZ_Egress", _veh];
    //private _wp5 = _group addWaypoint [_lzEgressPos, 0.0, _wpIndex, _wpName];
    //_wp5 setWaypointCombatMode "NO CHANGE";
    //_wp5 setWaypointBehaviour "CARELESS";
    //_wp5 setWaypointSpeed "FULL";
    //_wp5 setWaypointType "MOVE";
    //_wp5 setWaypointTimeout [0, 0, 0];
    
    // Final waypoint
    _wpIndex = _wpIndex + 1;
    _finalPos = getPos _spawnHelipad;
    ////_finalPos = _finalPos set [2, (_finalPos select 2) + 100];
    _wpName = format ["%1_Final", _veh];
    private _despawnCommand = format ["{{deleteVehicle _x} forEach crew %1} forEach thisList; deleteVehicle %2;",_veh,_veh]; // FIXME TEST
    private _wp6 = _group addWaypoint [_finalPos, 0.0, _wpIndex, _wpName];
    _wp6 setWaypointCombatMode "NO CHANGE";
    _wp6 setWaypointBehaviour "CARELESS";
    _wp6 setWaypointSpeed "FULL";
    _wp6 setWaypointType "MOVE";
    _wp6 setWaypointTimeout [0, 0, 0];
    _wp6 setWaypointStatements ["true",_despawnCommand]; // FIXME TEST
    
    _t = _t + 1;
    sleep 13.0;
    
} forEach _spawnedTransportHelis;
//};


// _this = [[_totalHelicoptersToSpawn,_baseHelipads,_lzHelipads,_baseTrigger,_lzTrigger],[_spawnedAttackHelis,_spawnedTransportHelis,_spawnedTroopGroups]];
//if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
//{
//    hint "Calling fnc_AirmobileHeliWaypoints.";
//    sleep 1.0;
//    _output = [_this] call fnc_AirmobileHeliWaypoints;
//}
//else
//{
//    if(isServer) then
//    {
//        hint "Calling fnc_AirmobileHeliWaypoints.";
//        sleep 1.0;
//        _output = [_this] call fnc_AirmobileHeliWaypoints;
//    };
//};
