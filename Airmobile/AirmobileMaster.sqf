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

private _lzTriggerArray = [""];
private _baseTriggerArray = [""];
private _side = east;
private _faction = "SovietArmy_OKSVA";
private _transportType = "OKSVA_MI8MT";
private _attackType = "OKSVA_Mi8MTV3";
private _squadType = "SovietArmy_OKSVA_infantry_rifle_squad";
//(configFile >> "CfgGroups" >> "East" >> "SovietArmy_OKSVA" >> "Infantry" >> "SovietArmy_OKSVA_infantry_rifle_squad")
private _spawnAttackHelis = true;
private _spawnInAir = true;


_lzInitOutput = [_lzTriggerArray,_baseTriggerArray] spawn Saber_fnc_AirmobileLzInit;
// _lzInitOutput = [_totalHelicoptersToSpawn,_baseHelipads,_lzHelipads,_baseTrigger,_lzTrigger]
_spawnOutput = [_side,_faction,_transportType,_attackType,_squadType,_spawnAttackHelis,_spawnInAir,_lzInitOutput] spawn Saber_fnc_AirmobileSpawn;
// _spawnOutput = [_spawnedAttackHelis,_spawnedTransportHelis,_spawnedTroopGroups]
_heliWaypointsOutput = [_lzInitOutput, _spawnOutput] spawn Saber_fnc_AirmobileHeliWaypoints;
_troopWaypointsOutput = [_lzInitOutput, _spawnOutput] spawn Saber_fnc_AirmobileTroopWaypoints;

