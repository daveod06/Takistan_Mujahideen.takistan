// spawn n helicopters with crew
// group helicopters
// spawn n squads
// group squads
// try to put squads in helicopter cargo depending on size of each helicopter cargo, delete extra troops


_faction = _this select 0;
_infantrySquadPerWave = _this select 1;
_infantryTypes =  [];
_infHqTypes = [];
_unitTypes = [];
_infSquadTypes = "";

_unitTypes = [_faction] call Saber_fnc_WaveGetUnitPools;
_infantryTypes = _unitTypes select 0;
_infHqTypes = _infantryTypes select 0;
_infSquadTypes = _infantryTypes select 1;

_maxInfSquads = _infantrySquadPerWave select 0;
_infSquadProb = _infantrySquadPerWave select 1;
_infToSpawn = [];


_message = format ["Will spawn up to %1 troop squads. _infHqTypes: %2 _infSquadTypes: %3",_maxInfSquads,_infHqTypes,_infSquadTypes];
if Saber_DEBUG then {hint _message; sleep 2.0;};

for [{_i=0},{_i<_maxInfSquads},{_i=_i+1}] do
{
    if (_infSquadProb > floor random 100) then
    {
        _squad = selectRandom _infSquadTypes;
        _infToSpawn pushBack _squad;
    };
};

//_message = format ["Will spawn %1 troop squads ",count _infToSpawn];
//if Saber_DEBUG then {hint _message; sleep 2.0;};

_hqToSpawn = floor ((count _infToSpawn)/3.0);
for [{_i=0},{_i<_hqToSpawn},{_i=_i+1}] do
{
    _hqSquad = selectRandom _infHqTypes;
    _infToSpawn pushBack _hqSquad;
};

//_message = format ["Will spawn %1 HQ squads ",_hqToSpawn];
//if Saber_DEBUG then {hint _message; sleep 2.0;};



_infToSpawn
