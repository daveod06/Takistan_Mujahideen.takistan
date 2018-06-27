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



private _zone10Helipads = [helipad10_0,helipad10_1,helipad10_2,helipad10_3,helipad10_4,helipad10_5,helipad10_6,helipad10_7];
private _base0Helipads = [spawn_helipad0_0,spawn_helipad0_1,spawn_helipad0_2,spawn_helipad0_3,spawn_helipad0_4,spawn_helipad0_5,spawn_helipad0_6,spawn_helipad0_7];


private _objectsInsideLZ = _zone10Helipads;
private _objectsInsideBase = _base0Helipads;
private _side = east;
private _faction = "SovietArmy_OKSVA";
private _transportType = "OKSVA_MI8MT";
private _attackType = "OKSVA_Mi8MTV3";
private _squadType = "SovietArmy_OKSVA_infantry_rifle_squad";
//(configFile >> "CfgGroups" >> "East" >> "SovietArmy_OKSVA" >> "Infantry" >> "SovietArmy_OKSVA_infantry_rifle_squad")
private _spawnAttackHelis = true;
private _spawnInAir = true;
private _dustoff = true;
groupsReadyForPickup = false;

_lzInitOutput = [_objectsInsideLZ,_objectsInsideBase] call Saber_fnc_AirmobileLzInit;
// _lzInitOutput = [_totalHelicoptersToSpawn,_baseHelipads,_lzHelipads,_baseTrigger,_lzTrigger]
private _message = format ["_lzInitOutput: %1",_lzInitOutput];
hint _message;
sleep 1.0;
//if ((_lzInitOutput select 0 == 0) || (isNull (_lzInitOutput select 1)) || (isNull (_lzInitOutput select 2)) || (_lzInitOutput select 3 == "") || (_lzInitOutput select 4 == "")) exitWith
//{
//    hint "Can't initialize Airmobile scripts.";
//};


_spawnHeliOutput = [_side,_faction,_transportType,_attackType,_spawnAttackHelis,_spawnInAir,_lzInitOutput] call Saber_fnc_AirmobileHeliSpawn;
//_spawnHeliOutput = [_spawnedAttackHelis,_spawnedTransportHelis]
private _message = format ["_spawnHeliOutput: %1",_spawnHeliOutput];
hint _message;
sleep 1.0;

_spawnTroopOutput = [_side,_faction,_squadType,_spawnHeliOutput] call Saber_fnc_AirmobileTroopSpawn;
//_spawnTroopOutput = [_spawnedTroopGroups];
private _message = format ["_spawnTroopOutput: %1",_spawnTroopOutput];
hint _message;
sleep 1.0;


_heliWaypointsOutput = [_lzInitOutput, _spawnHeliOutput, _spawnTroopOutput] call Saber_fnc_AirmobileHeliWaypoints;
_troopWaypointsOutput = [_lzInitOutput, _spawnHeliOutput, _spawnTroopOutput] call Saber_fnc_AirmobileTroopWaypoints;



//if _dustoff then
//{
//    _spawnAttackHelis = false;
//    _dustoffOutput = [_side,_faction,_transportType,_attackType,_spawnAttackHelis,_spawnInAir,_lzInitOutput,_spawnTroopOutput] spawn Saber_fnc_AirmobileDustoff;
//};




