// [_groupName] execVm "scripts\common\groupOk.sqf"
//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_groupOk =
{
    private ["_groupName","_groupOk"];
    _groupName = _this select 0;
    _groupOk = false;
    if (!(isNull _groupName)) then
    {
    	if ({alive _x} count units _groupName > 0) then
    	{
    	    _groupOk = true;
    	};
    };
    _groupOk
};

if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    //hint "Calling fnc_groupOk.";
    //sleep 1.0;
    _return = _this call fnc_groupOk;
}
else
{
    if(isServer) then
    {
        //hint "Calling fnc_groupOk.";
        //sleep 1.0;
        _return = _this call fnc_groupOk;
    };
};
