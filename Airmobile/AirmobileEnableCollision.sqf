//private _kph_to_mps = 0.277778;

//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

private _spawnHeliOutput = _this select 0;
private _spawnedAttackHelis = _spawnHeliOutput select 0;
private _spawnedTransportHelis = _spawnHeliOutput select 1;

private _checkHelis = true;
private _aVeh = objNull;
private _aGroup = objNull;
private _tVeh = objNull;

// Enable collisions
while {_checkHelis} do
{
	{
	    _aVeh = _x select 0;
	    _aGroup = _x select 2;
	    {
	       _tVeh = _x select 0;
	        if (currentWaypoint _aGroup > 0) then
	        {
		        _aVeh enableCollisionWith _tVeh;
		        _tVeh enableCollisionWith _aVeh;
		        _checkHelis = false; // FIXME might break the loop too early
	        };
	    } forEach _spawnedTransportHelis;
	} forEach _spawnedAttackHelis;
	sleep 5.0;
};