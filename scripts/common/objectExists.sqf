// [_objectName] execVm "scripts\common\objectExists.sqf"
//if(!isServer)exitWith{};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_objectExists =
{
	private ["_objectName","_objectOk"];

	_objectName = _this select 0;
	_objectOk = false;
	if (!(isNull _objectName)) then
	{
		_objectOk = true;
	};
	_objectOk
};

if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    //hint "Calling fnc_objectExists.";
    //sleep 1.0;
    _return = _this call fnc_objectExists;
}
else
{
    if(isServer) then
    {
        //hint "Calling fnc_objectExists.";
        //sleep 1.0;
        _return = _this call fnc_objectExists;
    };
};
