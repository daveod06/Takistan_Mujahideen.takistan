//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

_side               = _this select 0;
_faction            = _this select 1;
_transportType      = _this select 2;
_attackType         = _this select 3;
_spawnAttackHelis   = _this select 4;
_spawnInAir         = _this select 5;
_lzInitOutput       = _this select 6;
_spawnTroopOutput   = _this select 7;
private _alive      = false;
private _totalHelicoptersToSpawn = 0;
private _aliveGroups = [];

fnc_AirmobileGroupCheck =
{
    private _group = _this select 0;
    private _groupIsDead = false;
    if (isNull _group) then
    {
        _groupIsDead = true;
    };
    if ({ alive _x } count units _group == 0) then
    {
        _groupIsDead = true;
    };
    _groupIsDead;
};

waitUntil (groupsReadyForPickup)
{
	// find number of squads that need pickup
	_totalHelicoptersToSpawn = 0;
	{
	    _alive = [_x] call fnc_AirmobileGroupCheck;
	    if (_alive) then
	    {
	        _aliveGroups pushBack _x;
	    };
	} forEach _spawnTroopOutput;
	
	// adjust number of helicopters to spawn
	_lzInitOutput = _lzInitOutput set [0, count _aliveGroups];
	
	// spawn pickup helicopters
	_spawnHeliOutput = [_side,_faction,_transportType,_attackType,_spawnAttackHelis,_spawnInAir,_lzInitOutput] call Saber_fnc_AirmobileHeliSpawn;
	//_spawnHeliOutput = [_spawnedAttackHelis,_spawnedTransportHelis]
	private _message = format ["_spawnHeliOutput: %1",_spawnHeliOutput];
	hint _message;
	sleep 10.0;
	
	
	// create helicopter dustoff waypoints
	_heliDustoffOutput = [_lzInitOutput, _spawnHeliOutput] call Saber_fnc_AirmobileHeliDustoff;

    _spawnedTransportHelis = _spawnHeliOutput select 1;
    _heliGroup0 = (_spawnedTransportHelis select 0) select 2;
    // create troops dustoff waypoints
    _troopDustoffOutput = [_lzInitOutput, _spawnHeliOutput, _aliveGroups] call Saber_fnc_AirmobileTroopDustoff;

};
