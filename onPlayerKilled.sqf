params ["_player", "_killer", "_respawn", "_respawnDelay"];
waituntil{!isNull(_player)};
if (isMultiplayer) then
{
	//_player setVariable ["respawnLoadout", (getUnitLoadout _player)];
	//if ((paramsArray select 0) == 3) then {
	//	[player, -2000, true] call BIS_fnc_respawnTickets;
	//	diag_log ([player, 0, true] call BIS_fnc_respawnTickets);
	//	[missionNamespace, -2000] call BIS_fnc_respawnTickets;
	//	setPlayerRespawnTime 0;
	//};
};

diag_log format["Tooth DEBUG: onPlayerKilled run for %1", name _player];
