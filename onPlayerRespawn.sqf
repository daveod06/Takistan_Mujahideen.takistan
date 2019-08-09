params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];
waituntil{!isNull(_newUnit)};
_player = _newUnit;





_player setUnitTrait ["medic",true];
_player setUnitTrait ["engineer",true];
_player setUnitTrait ["explosiveSpecialist",true];

diag_log format ["Tooth DEBUG: onPlayerRespawn run for %1",name _player];
