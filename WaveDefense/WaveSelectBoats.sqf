// spawn n helicopters with crew
// group helicopters
// spawn n squads
// group squads
// try to put squads in helicopter cargo depending on size of each helicopter cargo, delete extra troops


_faction = _this select 0;
_boatsPerWave = _this select 6;

_unitTypes = [_faction] call Saber_fnc_WaveGetUnitPools;
_boatArray = _unitTypes select 6;

_vehToSpawn = [];
_maxVehicles = _boatsPerWave select 0;
_vehicleProb = _boatsPerWave select 1;
_spawnTroopsInCargo = _boatsPerWave select 2;
_vehClasses = _boatArray;
for [{_i=0},{_i<_maxVehicles},{_i=_i+1}] do
{
    if (_vehicleProb > floor random 100) then
    {
        _veh = selectRandom _vehClasses;
        _vehToSpawn pushBack [_veh,_spawnTroopsInCargo];
    };
};

//_message = format ["Will spawn %1 boats: %2 ",count _vehToSpawn,_vehToSpawn];
//if Saber_DEBUG then {hint _message; sleep 3.0;};

_vehToSpawn
