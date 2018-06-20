// [_groupName] execVm "scripts\common\groupOk.sqf"
if(!isServer)exitWith{};
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

