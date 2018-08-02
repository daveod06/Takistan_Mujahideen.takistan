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
    private _wp0 = _group addWaypoint [_takeoffPos, 0.0, 0, _wpName];
    _wp0 setWaypointCombatMode "RED";
    _wp0 setWaypointBehaviour "AWARE";
    _wp0 setWaypointSpeed "FULL";
    _wp0 setWaypointType "MOVE";
    _wp0 setWaypointTimeout [0, 0, 0];
    
    
    // Intermediate waypoint
    private _intermediatePos = _spawnHelipad getPos [450.0, _lzToBaseBearing];
    //_intermediatePos = _intermediatePos set [2, (_intermediatePos select 2) + 100];
    _wpName = format ["%1_Intermediate", _veh];
    private _wp1 = _group addWaypoint [_intermediatePos, 0.0, 1, _wpName];
    _wp1 setWaypointCombatMode "RED";
    _wp1 setWaypointBehaviour "UNCHANGED";
    _wp1 setWaypointSpeed "UNCHANGED";
    _wp1 setWaypointType "MOVE";
    _wp1 setWaypointTimeout [0, 0, 0];
    
    // Patrol waypoint
    private _lzPatrolPos = getPos _lzHelipad;
    //_lzPatrolPos = _lzPatrolPos set [2, (_lzPatrolPos select 2) + 100];
    _wpName = format ["%1_LZ_SAD", _veh];
    private _wp2 = _group addWaypoint [_lzPatrolPos, 0.0, 2, _wpName];
    _wp2 setWaypointCombatMode "RED";
    _wp2 setWaypointBehaviour "UNCHANGED";
    _wp2 setWaypointSpeed "UNCHANGED";
    _wp2 setWaypointType "SAD";
    _wp2 setWaypointTimeout [10, 12, 20];
    
    // Loiter waypoint
    private _lzLoiterPos = getPos _lzHelipad;
    //_lzLoiterPos = _lzLoiterPos set [2, (_lzPatrolPos select 2) + 100];
    _wpName = format ["%1_LZ_Loiter", _veh];
    private _wp3 = _group addWaypoint [_lzLoiterPos, 0.0, 3, _wpName];
    _wp3 setWaypointCombatMode "RED";
    _wp3 setWaypointBehaviour "UNCHANGED";
    _wp3 setWaypointSpeed "UNCHANGED";
    _wp3 setWaypointType "LOITER";
    _wp3 setWaypointLoiterRadius 400;
    _wp3 setWaypointLoiterType "CIRCLE";
    _wp3 setWaypointTimeout [30, 45, 60];
    
    // Egress waypoint
    private _lzEgressPos = _takeoffPos;
    _wpName = format ["%1_LZ_Egress", _veh];
    private _wp4 = _group addWaypoint [_lzEgressPos, 0.0, 4, _wpName];
    _wp4 setWaypointCombatMode "RED";
    _wp4 setWaypointBehaviour "UNCHANGED";
    _wp4 setWaypointSpeed "UNCHANGED";
    _wp4 setWaypointType "MOVE";
    _wp4 setWaypointTimeout [0, 0, 0];
    
    // Final waypoint
    _finalPos = getPos _spawnHelipad;
    //_finalPos = _finalPos set [2, (_finalPos select 2) + 100];
    private _wpName = format ["%1_Final", _veh];
    //private _despawnCommand = format ["{{deleteVehicle _x} forEach crew %1} forEach thisList; deleteVehicle %2;",_veh,_veh];
    private _wp5 = _group addWaypoint [_finalPos, 0.0, 5, _wpName];
    _wp5 setWaypointCombatMode "RED";
    _wp5 setWaypointBehaviour "CARELESS";
    _wp5 setWaypointSpeed "LIMITED";
    _wp5 setWaypointType "MOVE";
    _wp5 setWaypointTimeout [0, 0, 0];
    //_wp5 setWaypointStatements ["true",_despawnCommand];
    
    _a = _a + 1;
    sleep 1.0;
    
} forEach _spawnedAttackHelis;

// Transport helicopters
private _numTransportHelis = count (_spawnedTransportHelis);
private _t = _a;
{
    //_vehName  = _vehArray select 0;
    //_vehCrew  = _vehArray select 1;
    //_vehGroup     = _vehArray select 2;
    private _group = _x select 2;
    private _veh = _x select 0;
    private _vehCargo = fullCrew [_veh,"cargo", false];
    private _cargoUnit = _vehCargo select 0;
    //private _cargoUnit = _cargoUnit select 0;
    private _transportSquad = group (_cargoUnit select 0);
    
    _message = format ["_group: %1, _veh: %2, _vehCargo: %3, _cargoUnit: %4, _transportSquad: %5",_group,_veh,_vehCargo,_cargoUnit,_transportSquad];
	if Saber_DEBUG then {hint _message; sleep 3.0;};

    // Assign helipads
    private _spawnHelipad = _baseHelipads select _t;
    private _lzHelipad = _lzHelipads select _t;
    
    // Takeoff waypoint
    _wpIndex = 0; // DON'T COMMENT OUT
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
    _wp0 setWaypointBehaviour "CARELESS";
    _wp0 setWaypointSpeed "FULL";
    _wp0 setWaypointType "MOVE";
    _wp0 setWaypointTimeout [0, 0, 0];
    
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
    //_wpIndex = _wpIndex + 1;
    //private _lzApproachPos = _lzHelipad getPos [160.0, _lzToBaseBearing];
    //_lzApproachPos = _lzApproachPos set [2, (_lzApproachPos select 2) + 50];
    //_wpName = format ["%1_LZ_Approach", _veh];
    //_speed_kph = 50;
    //_speed_mps = _speed_kph * _kph_to_mps;
    //_command = format ["%1 limitSpeed %2; %3 flyInHeight 25; %4 forceSpeed %5;",_veh,_speed_kph,_veh,_veh,_speed_mps];
    //private _wp2 = _group addWaypoint [_lzApproachPos, 0.0, _wpIndex, _wpName];
    //_wp2 setWaypointCombatMode "NO CHANGE";
    //_wp2 setWaypointBehaviour "UNCHANGED";
    //_wp2 setWaypointSpeed "LIMITED";
    //_wp2 setWaypointType "MOVE";
    //_wp2 setWaypointTimeout [0, 0, 0];
    //_wp2 setWaypointStatements ["true",_command];
    
    // Transport Unload waypoint
    _wpIndex = _wpIndex + 1;
    private _lzLandPos = getPos _lzHelipad;
    //_lzLandPos = _lzLandPos set [2, (_lzLandPos select 2) + 50];
    _wpName = format ["%1_LZ_Land", _veh];
    _speed_kph = 50;
    _speed_mps = _speed_kph * _kph_to_mps;
    
    _message = format ["_lzLandPos: %1, _transportSquad: %2, _group: %3",_lzLandPos,_transportSquad,_group];
	if Saber_DEBUG then {hint _message; sleep 3.0;};
    
    //_command = format ["%1 limitSpeed %2; %3 flyInHeight 25; %4 forceSpeed %5;",_veh,_speed_kph,_veh,_veh,_speed_mps];
    //_command = format ["%1 limitSpeed %2; %3 flyInHeight 25; %4 forceSpeed %5; [%6,%7,%8] call Saber_fnc_AirmobileSingleTroopWaypoints;",_veh,_speed_kph,_veh,_veh,_speed_mps,_lzLandPos,_transportSquad,_group];
    //_command = format ["%1 limitSpeed %2; %3 flyInHeight 25; %4 forceSpeed %5; [%6,%7,%8] call Saber_fnc_AirmobileSingleTroopWaypoints; %9 land ""GET OUT"";",_veh,_speed_kph,_veh,_veh,_speed_mps,_lzLandPos,_transportSquad,_group,_veh]; // FIXME TEST

    //private _script = format ["[%1,%2,%3] call Saber_fnc_AirmobileSingleTroopWaypoints",_lzLandPos,_transportSquad,_group]; 
    private _wp3 = _group addWaypoint [_lzLandPos, 0.0, _wpIndex, _wpName];
    _wp3 setWaypointCombatMode "NO CHANGE"; //NO CHANGE
    _wp3 setWaypointBehaviour "CARELESS"; //UNCHANGED
    _wp3 setWaypointSpeed "FULL";
    _wp3 setWaypointType "TR UNLOAD";
    _wp3 setWaypointTimeout [3, 4, 5];
    //_wp3 setWaypointStatements ["true",_command];
    //_wp3 setWaypointScript _script;
    _wp3 waypointAttachVehicle _lzHelipad;
    _wp3 setWaypointCompletionRadius 3;
    
    // Post Unload waypoint
    _wpIndex = _wpIndex + 1;
    private _postPos = _spawnHelipad getPos [200.0, _baseToLzBearing];
    ////_postPos = _postPos set [2, (_postPos select 2) + 100];
    _wpName = format ["%1_LZ_Post_Unload", _veh];
    {(driver _veh) enableAI _x} forEach ["TARGET","AUTOTARGET","FSM","AUTOCOMBAT"];
    {(commander _veh) enableAI _x} forEach ["TARGET","AUTOTARGET","FSM","AUTOCOMBAT"];
    private _wp4 = _group addWaypoint [_postPos, 0.0, _wpIndex, _wpName];
    _wp4 setWaypointCombatMode "NO CHANGE";
    _wp4 setWaypointBehaviour "CARELESS";
    _wp4 setWaypointSpeed "FULL";
    _wp4 setWaypointType "MOVE";
    _wp4 setWaypointTimeout [0, 0, 0];

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
    //private _despawnCommand = format ["{{deleteVehicle _x} forEach crew %1} forEach thisList; deleteVehicle %2;",_veh,_veh]; // FIXME TEST
    private _wp6 = _group addWaypoint [_finalPos, 0.0, _wpIndex, _wpName];
    _wp6 setWaypointCombatMode "NO CHANGE";
    _wp6 setWaypointBehaviour "CARELESS";
    _wp6 setWaypointSpeed "LIMITED";
    _wp6 setWaypointType "MOVE";
    _wp6 setWaypointTimeout [0, 0, 0];
    //_wp6 setWaypointStatements ["true",_despawnCommand]; // FIXME TEST
    
    _t = _t + 1;
    sleep 10.0;
    
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
