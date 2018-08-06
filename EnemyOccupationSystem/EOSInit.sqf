IF (isnil "server")then{hint "YOU MUST PLACE A GAME LOGIC NAMED SERVER!";};
//EOS_fnc_spawnvehicle=compile preprocessfilelinenumbers "EnemyOccupationSystem\functions_SpawnVehicle.sqf";
//EOS_fnc_grouphandlers=compile preprocessfilelinenumbers "EnemyOccupationSystem\functions\setSkill.sqf";
//EOS_fnc_findsafepos=compile preprocessfilelinenumbers "EnemyOccupationSystem\functions\findSafePos.sqf";
//EOS_fnc_spawngroup= compile preprocessfile "EnemyOccupationSystem\functions\infantry_fnc.sqf";
//EOS_fnc_spawngroup= compile preprocessfile "EnemyOccupationSystem\functions\infantry_loadout_fnc.sqf";
//EOS_fnc_setcargo = compile preprocessfile "EnemyOccupationSystem\functions\cargo_fnc.sqf";
//EOS_fnc_taskpatrol= compile preprocessfile "EnemyOccupationSystem\functions\shk_patrol.sqf";
//SHK_pos = compile preprocessfile "EnemyOccupationSystem\functions\shk_pos.sqf";
//SHK_fnc_fillhouse = compile preprocessFileLineNumbers "EnemyOccupationSystem\Functions\SHK_buildingpos.sqf";
//EOS_fnc_getunitpool = compile preprocessfilelinenumbers "EnemyOccupationSystem\UnitPools.sqf";
//EOS_fnc_getunitloadout = compile preprocessfilelinenumbers "EnemyOccupationSystem\UnitLoadouts.sqf";
//call compile preprocessfilelinenumbers "EnemyOccupationSystem\AI_Skill.sqf";

EOS_fnc_Spawn = compile preprocessfilelinenumbers "EnemyOccupationSystem\core_launch.sqf";
EOS_fnc_Bastion_Spawn= compile preprocessfilelinenumbers "EnemyOccupationSystem\core\b_launch.sqf";
EOS_fnc_b_core = "EnemyOccupationSystem\core\b_core.sqf";
EOS_fnc_TransportUnload_fnc = "EnemyOccupationSystem\functions\TransportUnload_fnc.sqf"
EOS_fnc_Core = "EnemyOccupationSystem\core\EOS_Core.sqf";
EOS_fnc_SpawnVehicle = "EnemyOccupationSystem\functions_SpawnVehicle.sqf";
EOS_fnc_setSkill = "EnemyOccupationSystem\functions\setSkill.sqf";
EOS_fnc_findSafePos.sqf = "EnemyOccupationSystem\functions\findSafePos.sqf";
EOS_fnc_infantry_fnc = "EnemyOccupationSystem\functions\infantry_fnc.sqf";
EOS_fnc_cargo_fnc = "EnemyOccupationSystem\functions\cargo_fnc.sqf";
EOS_fnc_shk_patrol = "EnemyOccupationSystem\functions\shk_patrol.sqf";
EOS_fnc_shk_pos = "EnemyOccupationSystem\functions\shk_pos.sqf";
EOS_fnc_SHK_buildingpos = "EnemyOccupationSystem\Functions\SHK_buildingpos.sqf";
EOS_fnc_UnitPools = "EnemyOccupationSystem\UnitPools.sqf";
EOS_fnc_UnitLoadouts = "EnemyOccupationSystem\UnitLoadouts.sqf";
EOS_fnc_AI_Skill = "EnemyOccupationSystem\AI_Skill.sqf";
EOS_fnc_KillCounter = "EnemyOccupationSystem\functions\EOS_KillCounter.sqf";
//EOS_fnc_spawn_fnc = "EnemyOccupationSystem\core\spawn_fnc.sqf";
EOS_fnc_Markers = "EnemyOccupationSystem\Functions\EOS_Markers.sqf";
EOS_fnc_suicideBomber = "EnemyOccupationSystem\suicideBomber.sqf";
EOS_fnc_spawngroup= compile preprocessfile "EnemyOccupationSystem\functions\infantry_loadout_fnc.sqf";
EOS_fnc_Master = compile preprocessfile "EnemyOccupationSystem\EOSMaster.sqf";

EOS_Deactivate = {
	private ["_mkr"];
		_mkr=(_this select 0);		
	{
		_x setmarkercolor "colorblack";
		_x setmarkerAlpha 0;
	}foreach _mkr;
};

EOS_debug = {
private ["_note"];
_mkr=(_this select 0);
_n=(_this select 1);
_note=(_this select 2);
_pos=(_this select 3);

_mkrID=format ["%3:%1,%2",_mkr,_n,_note];
deletemarker _mkrID;
_debugMkr = createMarker[_mkrID,_pos];
_mkrID setMarkerType "Mil_dot";
_mkrID setMarkercolor "colorBlue";
_mkrID setMarkerText _mkrID;
_mkrID setMarkerAlpha 0.5;
};
