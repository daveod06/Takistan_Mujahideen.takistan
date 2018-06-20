// [_staticName] execVm "scripts\common\staticOk.sqf"
if(!isServer)exitWith{};
private ["_staticName","_staticOk"];
COMMON_fnc_unitOk = compile preprocessfile "scripts\common\unitOk.sqf";
_staticName = _this select 0;
_staticOk = false;

if ([_staticName] call COMMON_fnc_unitOk) then
{
	if ([gunner _staticName] call COMMON_fnc_unitOk) then
	{
		_staticOk = true;
	};
};
_staticOk

