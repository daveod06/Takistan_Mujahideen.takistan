// [_groupName, _trigger] execVm "scripts\common\groupEntireInTrigger.sqf"
//if (!isServer) exitWith {};
//check if HC1 is present
HC1Present = if (isNil "HC1") then{False} else{True};
HC2Present = if (isNil "HC2") then{False} else{True};
HC3Present = if (isNil "HC3") then{False} else{True};

fnc_groupEntireInTrigger =
{
    private ["_groupName","_trigger","_triggerOk","_unitsInTrigger","_count","_groupInTrigger","_loop"];
    _groupName = _this select 0;
    _trigger = _this select 1;


    //_groupOk = [_groupName] call Saber_fnc_groupOk;
    _triggerOk = !(isNull _trigger);
    if !(_triggerOk) exitwith {};
    _trigger setTriggerActivation [ANY", "PRESENT", true];

    _groupInTrigger = false;
    _loop = 1;
    
    while {_loop == 1} do
    {
        if ([_groupName] call Saber_fnc_groupOk) then
        {
            //_groupInTrigger = (({_x in list _trigger} count (units _groupName)) >= count (_units _groupName));
            _unitsInTrigger = list _trigger;
            if (count _unitsInTrigger > 0) then
            {
                _count = 0;
                {
                    if (_x in (units _groupName)) then
                    {
                        _count = _count + 1;
                    };
                } forEach _unitsInTrigger;
                if (_count == count (units _groupName)) then
                {
                    _groupInTrigger = true;
                };
            };
        }
        else
        {
            _loop = 0;
            _groupInTrigger = false;
        };
        sleep 2.0;
        _groupInTrigger
    };
};


if(HC1Present && isMultiplayer && !isServer && !hasInterface) then
{
    //hint "Calling fnc_groupEntireInTrigger.";
    //sleep 1.0;
    _return = _this call fnc_groupEntireInTrigger;
}
else
{
    if(isServer) then
    {
        //hint "Calling fnc_groupEntireInTrigger.";
        //sleep 1.0;
        _return = _this call fnc_groupEntireInTrigger;
    };
};
