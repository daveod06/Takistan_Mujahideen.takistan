// [_staticName] execVm "scripts\common\staticOk.sqf"
//if(!isServer)exitWith{};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_staticOk =
{
	private ["_staticName","_staticOk"];
	_staticName = _this select 0;
	_staticOk = false;

	if ([_staticName] call Saber_fnc_unitOk) then
	{
		if ([gunner _staticName] call Saber_fnc_unitOk) then
		{
			_staticOk = true;
		};
	};
	_staticOk
};

if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    //hint "Calling fnc_staticOk.";
    //sleep 1.0;
    _return = _this call fnc_staticOk;
}
else
{
    if(isServer) then
    {
        //hint "Calling fnc_staticOk.";
        //sleep 1.0;
        _return = _this call fnc_staticOk;
    };
};