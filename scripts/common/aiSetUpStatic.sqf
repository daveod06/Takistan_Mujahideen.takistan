// [_staticGroupName] execVm "scripts\common\aiSetUpStatic.sqf"
if(!isServer)exitWith{};
private ["_group","_watchPos","_nearestEnemy","_assistant","_restofunits","_leader"];
_group = _this select 0;

_leader = leader _group;
_restofunits = (units _group - [_leader]);
_gunner = _restofunits select 0;
_assistant = _restofunits select 1;
units _group doFollow _leader;
_group allowFleeing 0;

_nearestEnemy = _leader findNearestEnemy (getPos _leader);
if (isNull findNearestEnemy) then
{
    _watchPos = getPos _nearestEnemy;
}
else
{
    _watchPos = _leader getPos [700, random 360];
};

[_group, _leader getPos [5, random 360], _watchPos, _leader getPos [10, random 360]] call BIS_fnc_unpackStaticWeapon;
