//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};


if HC3Present then
{
	//EOS Dynamic Combat System
	[]execVM "scripts\eos\OpenMe.sqf";
}
else
{
	if HC2Present then
	{
		//EOS Dynamic Combat System
		[]execVM "scripts\eos\OpenMe.sqf";
	}
	else
	{
		if HC1Present then
		{
			//EOS Dynamic Combat System
			[]execVM "scripts\eos\OpenMe.sqf";
		}
		else
		{
			//EOS Dynamic Combat System
			[]execVM "scripts\eos\OpenMe.sqf";
		};
	};
};

// Civilians & Traffic
call compile preprocessFileLineNumbers "scripts\Engima\Civilians\Init.sqf";
call compile preprocessFileLineNumbers "scripts\Engima\Traffic\Init.sqf";
// Compile convoy and airmobile
[] execVM "Convoy\ConvoyInit.sqf";
[] execVM "Airmobile\AirmobileInit.sqf";

init_fnc =
{
	"traffic_area" setMarkerAlpha 0.0;
	_laserT = createVehicle ["LaserTargetE", [0,0,0], [], 0, "NONE"]; 
	_laserT attachto [attack_heli0, [0, 0, 0]];
	attack_heli0 doTarget attack_heli0;
	attack_heli0 reveal attack_heli0;





};





sleep 4.0;
[] execVM "Convoy\ConvoyInit.sqf";
[] execVM "Airmobile\AirmobileInit.sqf";
sleep 1.0;

//hint "Calling Saber_fnc_ConvoySpawnVehicles.";
//[] spawn Saber_fnc_ConvoySpawnVehicles;
//hint "Spawning Saber_fnc_AirmobileMaster.";
private _lzTriggerArray = [helizone_0];
private _baseTriggerArray = [spawn_helizone_0];
private _side = east;
private _faction = "SovietArmy_OKSVA";
private _category = "Infantry";
private _transportType = "OKSVA_MI8MT";
private _attackType = selectRandom ["OKSVA_Mi8MTV3","OKSVA_Mi24P"];
private _squadType = "SovietArmy_OKSVA_infantry_rifle_squad";
private _spawnAttackHelis = true;
private _spawnInAir = true;
private _dustoff = false;
//[_lzTriggerArray,_baseTriggerArray,_side,_faction,_category,_transportType,_attackType,_squadType,_spawnAttackHelis,_spawnInAir,_dustoff] spawn Saber_fnc_AirmobileMaster;
