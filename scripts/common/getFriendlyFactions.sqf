// [_unit]  execVM "scripts\common\getFriendlyFactions.sqf"
if (!isServer) exitWith {};
private ["_unit","_sidesArray","_friendlyFactionsArray","_side"];
_unit = _this select 0;

_sidesArray = [WEST,EAST,Resistance,Civilian];
_friendlyFactionsArray = [];
_side = side _unit;

{
    if ([_side, _x] call BIS_fnc_sideIsFriendly) then
    {
        _friendlyFactionsArray append [_x];
    };
} forEach _sidesArray;
_friendlyFactionsArray
