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

    private _intitialDelay = 0;
    private _waveInterval = 60;
    private _numWaves = 3;
    private _spawnMarker = marker0;
    private _attackMarker = marker1;
    private _infantrySquadsPerWave = [4,50.0]
    private _lightVehiclesPerWave = [4,50.0]
    private _apcsPerWave = [4,50.0]
    private _armorPerWave = [4,50.0]
    private _side = east;
    private _faction = "SovietArmy_OKSVA";

    // INITIAL DELAY
    sleep _intitialDelay;

    // INTITIAL SETUP
    _waveHQ = createCenter _side;

    // PER WAVE
    for [_i=0,_i<_numWaves,_i=_i+1] do
    {
        // SELECT HOW MANY SQUADS AND WHAT TYPES TO SPAWN
        _infToSpawn = [_faction,_infantrySquadsPerWave] call Saber_fnc_WaveSelectTroops;

        // SPAWN TROOPS
        _t = 0;
        {
            _squadType = _x;
            _squadArray = [_side,_faction,_squadType,_spawnMarker,_i,_t] call Saber_fnc_WaveSpawnTroops;
            _t = _t + 1;
        } forEach _infToSpawn;

        // GIVE TROOPS WAYPOINTS
        [_squadArray,_attackMarker] spawn Saber_fnc_WaveTroopWaypoints;

        
        // SELECT VEHICLES
        _vehToSpawn = [_faction,_lightVehiclesPerWave,_apcsPerWave,_armorPerWave] call Saber_fnc_WaveSelectVehicles;

        // SPAWN VEHICLES
        _v = 0;
        {
            _vehType = _x;
            _vehArray = [_side,_faction,_vehType,_spawnMarker,_i,_v] call Saber_fnc_WaveSpawnVehicles;
            _v = _v + 1;
        } forEach _vehToSpawn;

        // GIVE VEHICLES WAYPOINTS
        [_vehArray,_attackMarker] spawn Saber_fnc_WaveVehicleWaypoints;

        

        sleep _waveInterval;
    };

};

if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    //if Saber_DEBUG then {hint "Calling fnc_WaveMaster.";sleep 1.0;};
    [] spawn fnc_WaveMaster;
}
else
{
    if(isServer) then
    {
        //if Saber_DEBUG then {hint "Calling fnc_WaveMaster.";sleep 1.0;};
        [] spawn fnc_WaveMaster;
    };
};

