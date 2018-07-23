// [_unitName] execVm "scripts\common\unitOk.sqf"
//if(!isServer)exitWith{};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_unitOk =
{
	private ["_unitName","_unitOk"];

	_unitName = _this select 0;
	_unitOk = false;
	if (!(isNull _unitName)) then
	{
		if (alive _unitName) then
		{
		    _unitOk = true;
		};
	};
	_unitOk
};

if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    //hint "Calling fnc_unitOk.";
    //sleep 1.0;
    _return = _this call fnc_unitOk;
}
else
{
    if(isServer) then
    {
        //hint "Calling fnc_unitOk.";
        //sleep 1.0;
        _return = _this call fnc_unitOk;
    };
};