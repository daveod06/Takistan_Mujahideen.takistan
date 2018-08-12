//private _kph_to_mps = 0.277778;

//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

private _spawnHeliOutput = _this select 0;
private _spawnedAttackHelis = _spawnHeliOutput select 0;
private _spawnedTransportHelis = _spawnHeliOutput select 1;

fnc_vehicleOk =
{
	private ["_vehicleName","_vehicleOk"];

	_vehicleName = _this select 0;
	_vehicleOk = false;
	if (!(isNull _vehicleName)) then
	{
		if (alive _vehicleName) then
		{
		    _vehicleOk = true;
		};
	};
	_vehicleOk
};

fnc_groupOk =
{
    private ["_groupName","_groupOk"];
    _groupName = _this select 0;
    _groupOk = false;
    if (!(isNull _groupName)) then
    {
    	if ({alive _x} count (units _groupName) > 0) then
    	{
    	    _groupOk = true;
    	};
    };
    _groupOk
};

// initialize
fnc_heliStatusCheck =
{
    _veh = _this select 0;
    _vehGroup = _this select 1;

    _vehOk = [_veh] call fnc_vehicleOk;
    _groupOk = [_vehGroup] call fnc_groupOk;
    _wpIndex = -1;
    _wpName = "";
    _distToWp = 100000.0;
    _hasCargo = true;
    _cargoGroup = objNull;
    _cargoGroupOk = false;
    _vehAltAGL =  100000.0;
    //_message = format ["MISSION MONITOR: _veh: %1 typeName _veh: %2 _vehGroup %3 typeName _vehGroup: %4",_veh,typeName _veh,_vehGroup,typeName _vehGroup];
	//if Saber_DEBUG then {hint _message; sleep 3.0;};

    if (_vehOk && _groupOk) then
    {
        _vehAltAGL =  (getPos _veh) select 2;
        _wpIndex = currentWaypoint _vehGroup;
        if (_wpIndex >= 0) then
        {
            _wpName = waypointName [_vehGroup,_wpIndex];
            _wpPos = waypointPosition [_vehGroup, _wpIndex];
            _distToWp = _veh distance _wpPos;
        }
        else
        {
            _wpName = "";
            _wpPos = [0,0,0];
            _distToWp = 100000.0;
        };

        _vehCargo = fullCrew [_veh,"cargo", false];
        if (count _vehCargo > 0) then
        {
            _hasCargo = true;
	    	_cargoUnit = _vehCargo select 0;
		    _cargoGroup = group (_cargoUnit select 0);
            _cargoGroupOk = [_cargoGroup] call fnc_groupOk;
        }
        else
        {
            _hasCargo = false;
            _cargoGroup= objNull;
            _cargoGroupOk = false;
        };
    }
    else
    {
        _vehAltAGL =  100000.0;
        _wpIndex = -1;
        _wpName = "";
        _distToWp = 100000.0;
        _cargoGroup = objNull;
        _cargoGroupOk = false;
        _hasCargo = false;
    };
    
    _heliStatusArray = [_vehOk,_groupOk,_wpIndex,_wpName,_distToWp,_hasCargo,_cargoGroup,_cargoGroupOk,_vehAltAGL];
    _message = format ["fnc_heliStatusCheck  _wpName:%1 _distToWp:%2 _vehAltAGL:%3 _hasCargo:%4",_wpName,_distToWp,_vehAltAGL,_hasCargo];
    if Saber_DEBUG then {hint _message; sleep 1.0;};
    _heliStatusArray;
};


_transportUnloaded = [];
_heliAliveCount = 0;
{
    _transportUnloaded pushBack false;
    _heliAliveCount = _heliAliveCount + 1;
} forEach _spawnedTransportHelis;
{
    _heliAliveCount = _heliAliveCount + 1;
} forEach _spawnedAttackHelis; 


_message = format ["MISSION MONITOR: %1 helicopters, _transportUnloaded: %2",count _transportUnloaded,_transportUnloaded];
//if Saber_DEBUG then {hint _message; sleep 1.0;};


// vehicle_25_LZ_Land

_unlock = false;


while {_heliAliveCount > 0} do
{
    _t = 0;
    _heliAliveCount = 0;
    {
        _veh   = _x select 0;
        _vehGroup = _x select 2;
        
        _heliStatusArray = [_veh,_vehGroup] call fnc_heliStatusCheck; // ERRORS HERE FIXME
        _vehOk = _heliStatusArray select 0;
        _groupOk = _heliStatusArray select 1;
        _wpIndex = _heliStatusArray select 2;
        _wpName = _heliStatusArray select 3;
        _distToWp = _heliStatusArray select 4;
        _hasCargo = _heliStatusArray select 5;
        _cargoGroup = _heliStatusArray select 6;
        _cargoGroupOk = _heliStatusArray select 7;
        _vehAltAGL = _heliStatusArray select 8;
        
        _t = _t + 1;
        if _vehOk then {
            _heliAliveCount = _heliAliveCount + 1;
        };
        
    } forEach _spawnedTransportHelis;

    {
        _veh = _x select 0;
        _vehOk = [_veh] call fnc_vehicleOk;
        if _vehOk then
        {
            _heliAliveCount = _heliAliveCount + 1;
        };
    } forEach _spawnedAttackHelis;

    {
        _attackVehA = _x select 0;
        {
            _transVehA = _x select 0;
            {
                _attackVehB = _x select 0;
                _attackVehA disableCollisionWith _attackVehB;
                _attackVehA disableCollisionWith _transVehA;

            } forEach _spawnedAttackHelis;

            {
                _transVehB = _x select 0;
                _transVehA disableCollisionWith _transVehB;
                _transVehA disableCollisionWith _attackVehA;

            } forEach _spawnedTransportHelis;

        } forEach _spawnedTransportHelis;
    } forEach _spawnedAttackHelis;

    sleep 2.0;
};

//{

