params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];
waituntil{!isNull(_newUnit)};
_player = _newUnit;

// stamina stuff
//_player setFatigue 0.0;
_player enableStamina false;
0 = [_player] spawn
{
	_player = _this select 0;
    while {alive _player} do
    {
        //_player setFatigue 0.0;
        _player enableStamina false;
        sleep 10.0;
    };
};

// reduce damage
AT_Revive_StaticRespawns = [];
AT_Revive_enableRespawn = false;
AT_Revive_clearedDistance = 0;
AT_Revive_Camera = 1;

//[] call ATR_FNC_ReviveInit;
_player addEventHandler ["HandleDamage", ATR_FNC_ReduceDamage];

_player setUnitLoadout [(_player getVariable ["respawnLoadout", []]), true]; 

// Start saving player loadout periodically
[_player] spawn {
	_player = _this select 0;
	while {true} do {
		sleep 10;
		if (alive _player) then {
			_player setVariable ["respawnLoadout", getUnitLoadout _player]; 
		};
	};
};

_player setUnitTrait ["medic",true];
_player setUnitTrait ["engineer",true];
_player setUnitTrait ["explosiveSpecialist",true];

diag_log format ["Tooth DEBUG: onPlayerRespawn run for %1",name _player];
