//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_WaveMaster =
{
	//_message = format ["fnc_AirmobileTrigger _this[0]: %1",_this select 0];
	//if Saber_DEBUG then {hint _message;sleep 1.0;};
	//sleep 3.0;
	private _input = _this;

    private _intitialDelay = 5;
    private _waveInterval = 900;
    private _numWaves = 3;
    private _spawnMarker = "IND_wave_spawn_0";
    private _attackMarker = "EOSzone_1";
    private _infantrySquadsPerWave = [3,100.0];
    private _lightVehiclesPerWave = [2,100.0];
    private _apcsPerWave = [2,100.0];
    private _armorPerWave = [1,100.0];
    private _side = east;
    private _faction = "SovietArmy_OKSVA";

    // INITIAL DELAY
    sleep _intitialDelay;

    // INTITIAL SETUP
    _waveHQ = createCenter _side;
    [] call Saber_fnc_WaveAISkill;
    _squadArray = [];
    _vehArray = [];
    _infToSpawn = [];
    _vehToSpawn = [];
    _i = 0;

    // PER WAVE
    for [{_i=0},{_i<_numWaves},{_i=_i+1}] do
    {
        _message = format ["Spawning wave %1",_i];
        if Saber_DEBUG then {hint _message; sleep 1.0;};

        // SELECT HOW MANY SQUADS AND WHAT TYPES TO SPAWN
        _infToSpawn = [_faction,_infantrySquadsPerWave] call Saber_fnc_WaveSelectTroops;

        _message = format ["About to spawn %1 infantry squads: %2 ",count _infToSpawn,_infToSpawn];
        if Saber_DEBUG then {hint _message; sleep 4.0;};

        // SPAWN TROOPS
        _t = 0;
        {
            _message = format ["Spawning troop squad %1 for wave %2",_t,_i];
            if Saber_DEBUG then {hint _message; sleep 1.0;};
            _squadType = _x;
            _squadArray = [_side,_faction,_squadType,_spawnMarker,_i,_t] call Saber_fnc_WaveSpawnTroops;
            _t = _t + 1;
        } forEach _infToSpawn;

        // GIVE TROOPS WAYPOINTS
        [_squadArray,_attackMarker] spawn Saber_fnc_WaveTroopWaypoints;

        
        // SELECT VEHICLES
        _vehToSpawn = [_faction,_lightVehiclesPerWave,_apcsPerWave,_armorPerWave] call Saber_fnc_WaveSelectVehicles;

        _message = format ["About to spawn %1 vehicles: %2 ",count _vehToSpawn,_vehToSpawn];
        if Saber_DEBUG then {hint _message; sleep 4.0;};

        // SPAWN VEHICLES
        _v = 0;
        {
            _message = format ["Spawning vehicle %1 for wave %2",_v,_i];
            if Saber_DEBUG then {hint _message; sleep 3.0;};
            _vehType = _x;
            _vehArray = [_side,_faction,_vehType,_spawnMarker,_i,_v] call Saber_fnc_WaveSpawnVehicles;
            _v = _v + 1;
        } forEach _vehToSpawn;

        // GIVE VEHICLES WAYPOINTS
        [_vehArray,_attackMarker] spawn Saber_fnc_WaveVehicleWaypoints;

        _message = format ["Should be sleeping for %1 seconds",_waveInterval];
        if Saber_DEBUG then {hint _message; sleep 0.0;};

        sleep _waveInterval;
    };

};


if (HC3Present && !isServer && !hasInterface) then
{
    //
    [] spawn fnc_WaveMaster;
}
else
{
    if (HC2Present && !isServer && !hasInterface) then
    {
        //
        [] spawn fnc_WaveMaster;
    }
    else
    {
        if (HC1Present && !isServer && !hasInterface) then
        {
            //
            [] spawn fnc_WaveMaster;
        }
        else
        {
            if (isServer) then
            {
                //
                [] spawn fnc_WaveMaster;
            };
        };
    };
};
