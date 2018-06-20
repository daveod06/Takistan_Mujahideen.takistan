// auto find flat spots and place helipads within marker area
// determine destination & num helipads
// determine spawn area and create helipads if on ground
// spawn n helicopters with crew
// group helicopters
// spawn n squads
// group squads
// try to put squads in helicopter cargo depending on size of each helicopter cargo, delete extra troops
// give helicopters take off waypoints???\
// create get out waypoint for troops at LZ, set to careless
// give helicopters a move waypoint 1km out from LZ
// slow down helicopters and limit speed, lower alt, set behavior
// make intermediate waypoint, slow and lower more
// transport unload waypoint
// sleep for a few seconds
// give troops patrol waypoint to nearest threat, set to aware
// give helicopters limited alt and speed to get away from LZ
// send helicopters back to takeoff points
// delete helicopters

//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

// _handle = [["pos_1","pos_2","pos_3","pos_4"],[v_1,v_2,v_3], 35, 500, 1, "NORMAL", "CARELESS"] spawn Saber_fnc_ConvoyMove;
private _markerArray            = _this select 0;
private _convoyArray            = _this select 1;
private _ConvoySpeedLimit       = _this select 2;
private _ConvoySearchRange      = _this select 3;
private _ConvoyID               = _this select 4;
private _ConvoySpeedMode        = _this select 5;
private _ConvoyBehaviour        = _this select 6;
private _StopConvoy             = false;
private _marker                 = _markerArray select 0;
private _leadVcl                = _convoyArray select 0;
private _markersRemaining       = _markerArray;
private _all_groups             = [];
private _inf_groups             = [];
private _arm_groups             = [];
private _arm_vehicles           = [];
private _aliveConvoy            = [];
private _c                      = 0;
private _i                      = 0;
private _ConvoyDestination      = false;
private _SplitArmored           = objNull;
private _tmpGroup               = [];
private _BaseGroup              = objNull;
private _group                  = objNull;
private _crew                   = objNull;
private _vehicle                = objNull;
private _enemySides             = _leadVcl call BIS_fnc_enemySides;


