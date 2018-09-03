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
    private _waveInterval = 900;
    private _numWaves = 3;
    private _spawnMarker = "IND_wave_spawn_0";
    private _attackMarker = "EOSzone_1";
    private _infantrySquadsPerWave = [4,100.0];
    private _lightVehiclesPerWave = [3,50.0,true];
    private _apcsPerWave = [0,100.0,true];
    private _armorPerWave = [0,100.0,false];
    private _attackHelisPerWave = [0,100.0,false];
    private _cargoHelisPerWave = [0,100.0,false];
    private _boatsPerWave = [0,100.0,true];
    private _side = east;
    private _faction = "SovietArmy_OKSVA";
    //private _side = independent;
    //private _faction = "LOP_AM";


    // INITIAL DELAY
    sleep _intitialDelay;

    // INTITIAL SETUP
    _waveHQ = createCenter _side;
    [] call Saber_fnc_WaveAISkill;
    _squadArray = [];
    _vehArray = [];
    _infToSpawn = [];
    _vehToSpawn = [];
    _unitTypes = [];
    _i = 0;

    // PER WAVE
    for [{_i=0},{_i<_numWaves},{_i=_i+1}] do
    {
        _message = format ["Spawning wave %1 %2 ",_i,Saber_fnc_WaveGetUnitPools];
        if Saber_DEBUG then {hint _message; sleep 2.0;};

        // SELECT HOW MANY SQUADS AND WHAT TYPES TO SPAWN
        _unitTypes = [];
        _unitTypes = [_faction] call Saber_fnc_WaveGetUnitPools;

        _message = format ["_unitTypes: %1 typeOf _unitTypes:",_unitTypes,(typeOf _unitTypes)];
        if Saber_DEBUG then {hint _message; sleep 5.0;};

        sleep 1.0;
        _infToSpawn = [_faction,_infantrySquadsPerWave,_unitTypes] call Saber_fnc_WaveSelectTroops;

        //// SPAWN TROOPS
        //_squadArray = [];
        //_t = 0;
        //{
        //    //_message = format ["Spawning troop squad %1 for wave %2",_t,_i];
        //    //if Saber_DEBUG then {hint _message; sleep 1.0;};
        //    _squadType = _x;
        //    _squadArray = [_side,_faction,_squadType,_spawnMarker,_i,_t,_squadArray] call Saber_fnc_WaveSpawnTroops;
        //    _t = _t + 1;
        //} forEach _infToSpawn;

        //// GIVE TROOPS WAYPOINTS
        //[_squadArray,_attackMarker] spawn Saber_fnc_WaveTroopWaypoints;
        //
        //// SELECT HOW MANY LAND VEHICLES AND WHAT TYPES TO SPAWN
        //_vehToSpawn = [_faction,_lightVehiclesPerWave,_apcsPerWave,_armorPerWave] call Saber_fnc_WaveSelectVehicles;

        //// SPAWN LAND VEHICLES
        //_v = 0;
        //{
        //    //_message = format ["Spawning vehicle %1 for wave %2",_v,_i];
        //    //if Saber_DEBUG then {hint _message; sleep 1.0;};
        //    _vehType = _x select 0;
        //    _spawnTroopsInCargo = _x select 1;
        //    _vehArray = [_side,_faction,_vehType,_spawnMarker,_i,_v] call Saber_fnc_WaveSpawnVehicles;

        //    _message = format ["Spawnied vehicle %1 for wave %2  _vehArray: %3",_v,_i,_vehArray];
        //    if Saber_DEBUG then {hint _message; sleep 6.0;};

        //    if (_spawnTroopsInCargo) then
        //    {
        //        _infToSpawn = [_faction,[1,100.0]] call Saber_fnc_WaveSelectTroops;
        //        _squadType = _infToSpawn select 0;
        //        _cargoSquadGroup = [_side,_faction,_squadType,_spawnMarker,_i,_v,_vehArray] call Saber_fnc_WaveSpawnCargoTroops;
        //        [_cargoSquadGroup,_attackMarker,_spawnMarker] call Saber_fnc_WaveCargoTroopWaypoints;
        //    };

        //    // GIVE LAND VEHICLES WAYPOINTS
        //    [_vehArray,_attackMarker,_spawnMarker] spawn Saber_fnc_WaveVehicleWaypoints;

        //    _v = _v + 1;
        //} forEach _vehToSpawn;

        ////// GIVE LAND VEHICLES WAYPOINTS
        ////[_vehArray,_attackMarker,_spawnMarker] spawn Saber_fnc_WaveVehicleWaypoints;

        //// SELECT HOW MANY SEA VEHICLES AND WHAT TYPES TO SPAWN
        //_boatToSpawn = [_faction,_boatsPerWave] call Saber_fnc_WaveSelectBoats;

        //// SPAWN SEA VEHICLES
        //_v = 0;
        //{
        //    //_message = format ["Spawning boat %1 for wave %2",_v,_i];
        //    //if Saber_DEBUG then {hint _message; sleep 1.0;};
        //    _vehType = _x select 0;
        //    _spawnTroopsInCargo = _x select 1;
        //    _vehArray = [_side,_faction,_vehType,_spawnMarker,_attackMarker,_i,_v] call Saber_fnc_WaveSpawnBoats;
        //    if (_spawnTroopsInCargo) then
        //    {
        //        _infToSpawn = [_faction,[1,100.0]] call Saber_fnc_WaveSelectTroops;
        //        _squadType = _infToSpawn select 0;
        //        _cargoSquadGroup = [_side,_faction,_squadType,_spawnMarker,_i,_v,_vehArray] call Saber_fnc_WaveSpawnCargoTroops;
        //        [_cargoSquadGroup,_attackMarker,_spawnMarker] call Saber_fnc_WaveCargoTroopWaypoints;
        //    };

        //    // GIVE SEA VEHICLES WAYPOINTS
        //    [_vehArray,_attackMarker,_spawnMarker] spawn Saber_fnc_WaveBoatWaypoints;

        //    _v = _v + 1;
        //} forEach _boatToSpawn;

        ////// GIVE SEA VEHICLES WAYPOINTS
        ////[_vehArray,_attackMarker,_spawnMarker] spawn Saber_fnc_WaveBoatWaypoints;

        sleep _waveInterval;
    };

};


if (HC3Present && !isServer && !hasInterface) then
{
    [] call fnc_WaveMaster;
}
else
{
    if (HC2Present && !isServer && !hasInterface) then
    {
        [] call fnc_WaveMaster;
    }
    else
    {
        if (HC1Present && !isServer && !hasInterface) then
        {
            [] call fnc_WaveMaster;
        }
        else
        {
            if (isServer) then
            {
                [] call fnc_WaveMaster;
            };
        };
    };
};
