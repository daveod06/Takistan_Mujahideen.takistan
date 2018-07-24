// [_vehicleName] execVm "scripts\common\vehicleOk.sqf"
//if(!isServer)exitWith{};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_vehicleOk =
{
	private ["_vehicleName","_vehicleOk"];

	_vehicleName = _this select 0;
	_vehicleOk = false;
	if (!(isNull _vehicleName)) then
	{
		if (alive _vehicleName) then
		{
            _driver = driver _vehicleName;
            if ([_driver] call Saber_fnc_unitOk) then
            {
                if (canMove _vehicleName) then 
                {
                    _vehicleOk = true;
                };
            };
		};
	};
	_vehicleOk
};

if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    //hint "Calling fnc_vehicleOk.";
    //sleep 1.0;
    _return = _this call fnc_vehicleOk;
}
else
{
    if(isServer) then
    {
        //hint "Calling fnc_vehicleOk.";
        //sleep 1.0;
        _return = _this call fnc_vehicleOk;
    };
};
