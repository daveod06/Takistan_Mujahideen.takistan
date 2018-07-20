// [_groupName, _vehicleName] execVm "scripts\common\groupInVehicle.sqf"
//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};


fnc_groupInVehicle =
{
    private ["_groupName","_vehicle","_vehicleOk","_groupInVehicle","_loop"];
    _groupName = _this select 0;
    _vehicle = _this select 1;
    
    _vehicleOk = [_vehicle] call Saber_fnc_vehicleOk;
    if !(_vehicleOk) exitwith {};

    _groupInVehicle = false;
    _loop = 1;
    
    while {_loop == 1} do
    {
        if ([_groupName] call Saber_fnc_groupOk) then
        {
            //_groupInVehicle = (({!(alive _x) || _x in _vehicle} count (units _groupName)) == count (units _groupName));

            _aliveUnitsInGroup = [];
            {
                if (alive _x) then
                {
                    _aliveUnitsInGroup pushBack _x;
                };
            } forEach (units _groupName);
        
            _count = 0;
            _vehicleCrew = crew _vehicle;
            if (count _vehicleCrew > 0) then
            {
                {
                    if (_x in _aliveUnitsInGroup) then
                    {
                        _count = _count + 1;
                    };
                } forEach _vehicleCrew;
            };
            
            if _count == (count _aliveUnitsInGroup) then
            {
                _groupInVehicle = true;
            }
            else
            {
                _groupInVehicle = true;
            };

        }
        else
        {
            _loop = 0;
            _groupInVehicle = false;
        };
        sleep 1.0;
        _groupInVehicle
    };
}


if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    //hint "Calling fnc_groupInVehicle.";
    //sleep 1.0;
    _return = _this call fnc_groupInVehicle;
}
else
{
    if(isServer) then
    {
        //hint "Calling fnc_groupInVehicle.";
        //sleep 1.0;
        _return = _this call fnc_groupInVehicle;
    };
};
