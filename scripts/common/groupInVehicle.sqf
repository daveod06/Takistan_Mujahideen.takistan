// [_groupName, _vehicleName] execVm "scripts\common\groupInVehicle.sqf"
if(!isServer)exitWith{};
private ["_groupName","_vehicleName","_groupInVehicle","_loop"];
COMMON_fnc_groupOk = compile preprocessfile "scripts\common\groupOk.sqf";
_groupName = _this select 0;
_vehicleName = _this select 1;
_groupInVehicle = false;
_loop = 1;

while {_loop == 1} do
{
    if ([_groupName] call COMMON_fnc_groupOk) then
    {
        _groupInVehicle = (({!(alive _x) || _x in _vehicleName} count (units _groupName)) == count (units _groupName));
    }
    else
    {
        _loop = 0;
    };
    sleep 1.0;
    _groupInVehicle
};



