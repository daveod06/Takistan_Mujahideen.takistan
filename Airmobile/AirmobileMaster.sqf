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

private _lzTriggerArray = ["helizone_10"];
private _baseTriggerArray = ["spawn_helizone_0"];
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

_lzInitOutput = [_lzTriggerArray,_baseTriggerArray] spawn Saber_fnc_AirmobileLzInit;
// _lzInitOutput = [_totalHelicoptersToSpawn,_baseHelipads,_lzHelipads,_baseTrigger,_lzTrigger]
private _message = format ["_lzInitOutput: %1",_lzInitOutput];
hint _message;
sleep 10.0;
if ((_lzInitOutput select 0 == 0) || (isNull (_lzInitOutput select 1)) || (isNull (_lzInitOutput select 2)) || (_lzInitOutput select 3 == "") || (_lzInitOutput select 4 == "")) exitWith
{
    hint "Can't initialize Airmobile scripts.";
};


//_spawnHeliOutput = [_side,_faction,_transportType,_attackType,_spawnAttackHelis,_spawnInAir,_lzInitOutput] spawn Saber_fnc_AirmobileHeliSpawn;
////_spawnHeliOutput = [_spawnedAttackHelis,_spawnedTransportHelis]
//private _message = format ["_spawnHeliOutput: %1",_spawnHeliOutput];
//hint _message;
//sleep 10.0;

//_spawnTroopOutput = [_side,_faction,_squadType] spawn Saber_fnc_AirmobileTroopSpawn;
////_spawnTroopOutput = [_spawnedTroopGroups];
//private _message = format ["_spawnTroopOutput: %1",_spawnTroopOutput];
//hint _message;
//sleep 10.0;


//_heliWaypointsOutput = [_lzInitOutput, _spawnOutput] spawn Saber_fnc_AirmobileHeliWaypoints;
//_troopWaypointsOutput = [_lzInitOutput, _spawnOutput] spawn Saber_fnc_AirmobileTroopWaypoints;



//if _dustoff then
//{
//    _spawnAttackHelis = false;
//    _dustoffOutput = [_side,_faction,_transportType,_attackType,_spawnAttackHelis,_spawnInAir,_lzInitOutput,_spawnTroopOutput] spawn Saber_fnc_AirmobileDustoff;
//};




