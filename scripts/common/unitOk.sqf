// [_unitName] execVm "scripts\common\unitOk.sqf"
if(!isServer)exitWith{};
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

