// [_groupName, _triggerName] execVm "scripts\common\groupInVehicle.sqf"
if(!isServer)exitWith{};
private ["_groupName","_triggerName","_groupInTrigger","_loop"];
COMMON_fnc_groupOk = compile preprocessfile "scripts\common\groupOk.sqf";
_groupName = _this select 0;
_triggerName = _this select 1;
_groupInTrigger = false;
_loop = 1;

while {_loop == 1} do
{
    if ([_groupName] call COMMON_fnc_groupOk) then
    {
        _groupInTrigger = (({_x in list _triggerName} count (units _groupName)) >= 1 );
    }
    else
    {
        _loop = 0;
    };
    sleep 1.0;
    _groupInTrigger
};



