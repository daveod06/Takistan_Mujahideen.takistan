// [_unit]  execVM "scripts\common\getFriendlyFactions.sqf"
//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_getFriendlyFactions =
{
    private ["_unit","_unitOk","_sidesArray","_friendlyFactionsArray","_side"];
    _unit = _this select 0;
    _unitOk = [_unit] call Saber_fnc_unitOk;
    if (!_unitOk) exitWith {};
    
    _sidesArray = [WEST,EAST,Resistance,Civilian];
    _friendlyFactionsArray = [];
    _side = side _unit;
    
    {
        if ([_side, _x] call BIS_fnc_sideIsFriendly) then
        {
            _friendlyFactionsArray append [_x];
        };
    } forEach _sidesArray;
    _friendlyFactionsArray
};

if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    //hint "Calling fnc_getFriendlyFactions.";
    //sleep 1.0;
    _return = _this call fnc_getFriendlyFactions;
}
else
{
    if(isServer) then
    {
        //hint "Calling fnc_getFriendlyFactions.";
        //sleep 1.0;
        _return = _this call fnc_getFriendlyFactions;
    };
};
