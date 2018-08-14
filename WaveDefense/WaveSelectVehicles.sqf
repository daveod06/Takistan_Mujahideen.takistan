// spawn n helicopters with crew
// group helicopters
// spawn n squads
// group squads
// try to put squads in helicopter cargo depending on size of each helicopter cargo, delete extra troops


_faction = _this select 0;
_lightVehiclesPerWave = _this select 1;
_apcsPerWave = _this select 2;
_armorPerWave = _this select 3;

_unitTypes = [_faction] call Saber_fnc_WaveGetUnitPools;
_lightVehiclesArray = _unitTypes select 1;
_apcsArray = _unitTypes select 2;
_armorArray = _unitTypes select 3;

_vehToSpawn = [];
_maxVehicles = _lightVehiclesPerWave select 0;
_vehicleProb = _lightVehiclesPerWave select 1;
_vehClasses = _lightVehiclesArray;
for [{_i=0},{_i<_maxVehicles},{_i=_i+1}] do
{
    if (_vehicleProb > floor random 100) then
    {
        _veh = selectRandom _vehClasses;
        _vehToSpawn pushBack _veh;
    };
};

_message = format ["Spawning %1 vehicles ",count _vehToSpawn];
//if Saber_DEBUG then {hint _message; sleep 3.0;};


_maxVehicles = _apcsPerWave select 0;
_vehicleProb = _apcsPerWave select 1;
_vehClasses = _apcsArray;
for [{_i=0},{_i<_maxVehicles},{_i=_i+1}] do
{
    if (_vehicleProb > floor random 100) then
    {
        _veh = selectRandom _vehClasses;
        _vehToSpawn pushBack _veh;
    };
};

_maxVehicles = _armorPerWave select 0;
_vehicleProb = _armorPerWave select 1;
_vehClasses = _armorArray;
for [{_i=0},{_i<_maxVehicles},{_i=_i+1}] do
{
    if (_vehicleProb > floor random 100) then
    {
        _veh = selectRandom _vehClasses;
        _vehToSpawn pushBack _veh;
    };
};

_message = format ["Spawning %1 vehicles ",count _vehToSpawn];
//if Saber_DEBUG then {hint _message; sleep 3.0;};

_vehToSpawn
